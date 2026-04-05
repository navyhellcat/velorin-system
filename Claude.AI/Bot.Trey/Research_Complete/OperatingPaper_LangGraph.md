# Technical Operating Paper: LangGraph
**Classification:** System Architect Reference
**Date:** 2026-04-04
**Author:** Trey (Velorin Research Agent)
**Purpose:** Full technical teardown — architecture, internals, code patterns, and Velorin integration assessment

---

## Preface

This paper is written for a system architect who needs to understand LangGraph well enough to (a) recreate its core mechanisms and (b) selectively incorporate components into a custom agent memory system. It is not a tutorial. Marketing language is excluded. Every claim is sourced or confidence-weighted where uncertain.

LangGraph version referenced: 1.x (1.0 released October 2025, platform renamed LangSmith Deployment). The 0.x API differs in some checkpoint and interrupt details — those differences are noted inline.

---

## Section 1: Core Architecture

### 1.1 What Is a "Graph" in LangGraph

LangGraph models agent workflows as a **directed graph** where:

- **Nodes** are computation units — Python functions or callables that accept the current state and return a partial state update (a dict of keys to update)
- **Edges** are transitions between nodes — either static (fixed destination) or conditional (dynamically computed destination)
- **State** is a shared TypedDict instance that flows through every node in sequence

The graph is not a data flow DAG in the traditional ETL sense. It is a **stateful execution graph** implemented on top of a Pregel-inspired bulk-synchronous parallel (BSP) runtime. The distinction matters: state persists across supersteps, nodes can loop, and the graph can pause and resume from any checkpoint.

At compile time, `StateGraph.compile()` converts the declarative builder into a `CompiledStateGraph`, which is a `Pregel` instance — the actual execution engine.

```
StateGraph (builder)
    └── .compile()
           └── CompiledStateGraph (Pregel instance)
                   ├── channels: {key -> BaseChannel}
                   ├── nodes: {name -> PregelNode}
                   ├── edges: routing logic
                   └── checkpointer: BaseCheckpointSaver | None
```

### 1.2 StateGraph vs MessageGraph

**MessageGraph** is deprecated as of LangGraph 1.0 and will be removed in 2.0. Do not design against it.

The distinction that matters in practice:

| Concept | Implementation |
|---------|---------------|
| `MessageGraph` | Deprecated. State was implicitly a list of messages. |
| `StateGraph` | Current standard. State is a TypedDict you define. |
| `MessagesState` | A pre-built TypedDict subclass with one field: `messages: Annotated[list[AnyMessage], add_messages]`. Use this when your graph is purely message-driven. |

`MessagesState` is the successor to `MessageGraph`. You get the same implicit message-list behavior but with the full StateGraph machinery underneath.

```python
from langgraph.graph import StateGraph, MessagesState

# Option A: Fully custom state
class MyState(TypedDict):
    messages: Annotated[list, add_messages]
    tool_output: str
    iteration_count: int

graph = StateGraph(MyState)

# Option B: Messages-only shorthand
graph = StateGraph(MessagesState)
```

### 1.3 The TypedDict State Schema — Precise Mechanics

The state schema is a Python `TypedDict` (or Pydantic model). Every key in the schema maps to a `BaseChannel` instance internally. The channel type is determined by whether a key is annotated with a reducer:

| Annotation | Channel Created | Behavior |
|------------|----------------|---------|
| `str` (no annotation) | `LastValue` | Overwrites previous value each update |
| `Annotated[list, add_messages]` | `BinaryOperatorAggregate` | Applies the reducer function to merge updates |
| `Annotated[list, operator.add]` | `BinaryOperatorAggregate` | Appends list elements |
| `Annotated[T, reducer_fn]` | `BinaryOperatorAggregate` | Calls `reducer_fn(current, new)` |

**How state flows:**

1. Node receives the current state (or a typed subset if its signature only requests specific keys)
2. Node returns a dict of keys it wants to update — NOT the full state
3. LangGraph calls each key's channel `.update(current_value, node_return_value[key])`
4. The merged state becomes the input to the next superstep

Nodes never see each other's writes within the same superstep — channel updates are applied atomically after all parallel nodes complete (BSP isolation guarantee).

```python
from typing import TypedDict, Annotated
from langgraph.graph import StateGraph
import operator

class PipelineState(TypedDict):
    query: str                                    # LastValue — overwrites
    results: Annotated[list[str], operator.add]   # BinaryOperatorAggregate — appends
    messages: Annotated[list, add_messages]        # BinaryOperatorAggregate — deduplicates by ID
    step_count: int                               # LastValue — overwrites

def search_node(state: PipelineState) -> dict:
    # Returns partial update — only keys that change
    return {
        "results": ["result_a", "result_b"],  # Will be appended to existing list
        "step_count": state["step_count"] + 1
    }
```

**TypedDict vs Pydantic:** Pydantic models are supported for validation. TypedDict is lighter-weight and the predominant pattern in LangGraph docs. For production systems with complex state, Pydantic adds input validation at node boundaries.

### 1.4 Conditional Edges — The Routing Mechanism

Conditional edges are Python functions that receive the current state and return either:
- A string node name (route to that node)
- A list of strings (fan out to multiple nodes in parallel)
- `END` (terminal constant, stops the graph)

```python
from langgraph.graph import StateGraph, END

def route_decision(state: MyState) -> str:
    if state["tool_output"] is not None:
        return "process_tool_output"
    elif state["iteration_count"] > 5:
        return END
    else:
        return "call_llm"

graph.add_conditional_edges(
    "router_node",
    route_decision,
    {
        "process_tool_output": "process_tool_output",
        "call_llm": "call_llm",
        END: END,
    }
)
```

The optional third argument is a mapping dict — it translates string return values to node names. This allows the routing function to return clean logical labels without coupling to node naming conventions.

**Fan-out (parallel dispatch):** Return a list from the conditional edge function. All listed nodes execute in the same superstep. Their results are merged before the next superstep runs.

**The `Send` API** enables dynamic fan-out with per-branch payloads:

```python
from langgraph.types import Send

def map_step(state: MyState) -> list[Send]:
    # Dynamically create parallel work items
    return [Send("worker_node", {"item": item}) for item in state["items"]]

graph.add_conditional_edges("map_step", map_step)
```

Each `Send` carries its own state payload to the target node — this is LangGraph's map-reduce primitive.

### 1.5 Reducers — What They Do

Reducers are the key mechanism for merging parallel writes. Without reducers, if two parallel nodes both write to the same state key, LangGraph raises a conflict error. With a reducer, LangGraph calls `reducer_fn(current_value, update_1)` then `reducer_fn(result, update_2)` for each write, in deterministic order.

The most important built-in reducer is `add_messages`:

```python
from langgraph.graph.message import add_messages

# add_messages behavior:
# 1. Takes existing message list and new messages
# 2. Deduplicates by message ID (prevents duplicate messages)
# 3. Supports message updates — if new message has same ID as existing, replaces it
# 4. Appends new messages to the end
```

This ID-based deduplication is critical for agentic loops: if an LLM generates a message, it gets a UUID; if the same message is somehow sent again (retry, duplicate call), the reducer silently deduplicates rather than appending a copy.

Custom reducers:

```python
def take_max(current: int, update: int) -> int:
    return max(current, update)

class MyState(TypedDict):
    high_score: Annotated[int, take_max]
```

---

## Section 2: Persistence / Checkpointing — Full Mechanism

### 2.1 What Checkpointing Is Actually Doing

Checkpointing is LangGraph's persistence layer. Every time a superstep completes, the runtime serializes the complete graph state and writes it to the configured backend. This enables:

- Resume after interruption (human-in-the-loop)
- Fault recovery (process crash, network failure)
- State replay (debug/rewind)
- Multi-turn conversations (state persists between invocations)

The checkpoint does NOT store diffs. It stores a complete snapshot of all channel values at that point in time. The version tracking system (`channel_versions`) is separate from the state values and tracks which version of each channel each node has processed — this is how the Pregel engine decides which nodes need to re-execute.

### 2.2 The BaseCheckpointSaver Interface

All checkpointers implement `BaseCheckpointSaver`. The required interface:

**Synchronous methods:**

| Method | Signature | Purpose |
|--------|-----------|---------|
| `get_tuple(config)` | `(RunnableConfig) -> CheckpointTuple \| None` | Retrieve checkpoint. If `checkpoint_id` present in config, fetch exact. Otherwise fetch latest for thread. |
| `get(config)` | `(RunnableConfig) -> Checkpoint \| None` | Convenience wrapper over `get_tuple`, returns just the dict |
| `list(config, filter, before, limit)` | `(...) -> Iterator[CheckpointTuple]` | List checkpoints newest-first. Supports metadata filtering. |
| `put(config, checkpoint, metadata, new_versions)` | `(...) -> RunnableConfig` | Save a checkpoint snapshot. Returns updated config with the new checkpoint_id. |
| `put_writes(config, writes, task_id, task_path)` | `(...) -> None` | Save pending writes (node outputs not yet applied to channels). Separate table. |
| `delete_thread(config)` | `(RunnableConfig) -> None` | Delete all checkpoints for a thread |
| `get_next_version(current, channel)` | `(str \| None, BaseChannel) -> str` | Generate next version identifier for a channel |

**Asynchronous variants:** `aget_tuple`, `aget`, `alist`, `aput`, `aput_writes`, `adelete_thread` — same signatures, async.

The separation between `put` and `put_writes` is important: `put` writes the main checkpoint after a superstep completes, while `put_writes` records intermediate node outputs as they arrive during execution. This means if a process crashes mid-superstep, the pending writes survive and can be replayed.

### 2.3 The CheckpointTuple Structure

```python
# Simplified from langgraph_checkpoint source
class CheckpointTuple(NamedTuple):
    config: RunnableConfig          # Contains thread_id, checkpoint_id, checkpoint_ns
    checkpoint: Checkpoint          # The actual state snapshot
    metadata: CheckpointMetadata    # Source, step number, parent IDs
    parent_config: RunnableConfig | None  # Points to parent checkpoint
    pending_writes: list[tuple[str, str, Any]]  # (task_id, channel, value)
```

The `Checkpoint` TypedDict:

```python
class Checkpoint(TypedDict):
    v: int                          # Format version (currently 1)
    id: str                         # UUID v6 — monotonically increasing, sortable
    ts: str                         # ISO 8601 timestamp
    channel_values: dict[str, Any]  # Complete deserialized state: {channel_name: value}
    channel_versions: dict[str, str] # {channel_name: version_id}
    versions_seen: dict[str, dict[str, str]]  # {node_id: {channel: version}} — tracks what each node processed
    updated_channels: list[str]     # Channels modified in this checkpoint
```

`versions_seen` is the key to the Pregel scheduling algorithm: a node is eligible to run if any channel it subscribes to has a version newer than what `versions_seen` records for that node.

### 2.4 Available Backends

**InMemorySaver** (formerly InMemoryCheckpointer):
```python
from langgraph.checkpoint.memory import MemorySaver
checkpointer = MemorySaver()
```
Stores everything in a Python dict. Survives the session only. Use for development and testing.

**SqliteSaver:**
```python
from langgraph.checkpoint.sqlite import SqliteSaver
with SqliteSaver.from_conn_string("checkpoints.db") as saver:
    graph = workflow.compile(checkpointer=saver)
```
Synchronous SQLite. Appropriate for single-process deployments. Not suitable for multi-process or distributed setups.

**AsyncSqliteSaver:**
```python
from langgraph.checkpoint.sqlite.aio import AsyncSqliteSaver
async with AsyncSqliteSaver.from_conn_string("checkpoints.db") as saver:
    graph = workflow.compile(checkpointer=saver)
```
Async SQLite for async graph execution.

**PostgresSaver / AsyncPostgresSaver:**
```python
from langgraph.checkpoint.postgres import PostgresSaver
from psycopg import Connection

conn = Connection.connect("postgresql://...")
saver = PostgresSaver(conn)
saver.setup()  # Creates tables on first use
graph = workflow.compile(checkpointer=saver)
```
PostgreSQL backend. Three tables: `checkpoints`, `checkpoint_blobs`, `checkpoint_writes`. Primitive values stored inline as JSONB; complex objects extracted to `checkpoint_blobs` with versioned keys `(thread_id, checkpoint_ns, channel, version)`.

**RedisSaver:** Community-maintained (not in the official repo). Exists in third-party packages. Not production-recommended without custom implementation due to lack of transaction guarantees matching Postgres.

### 2.5 Thread IDs and Checkpoint IDs — The Namespace Model

Three identifiers compose the checkpoint primary key:

```
(thread_id, checkpoint_ns, checkpoint_id)
```

- **thread_id**: User-provided string. Identifies a conversation or execution thread. Same thread_id across multiple `.invoke()` calls = persistent conversation.
- **checkpoint_ns**: String, default empty. Allows multiple checkpoint sequences within one thread. Used by nested subgraphs to maintain separate checkpoint histories under the same thread.
- **checkpoint_id**: UUID v6 generated by the runtime. Monotonically increasing, chronologically sortable.

```python
config = {"configurable": {"thread_id": "user_123_session_1"}}
result = graph.invoke({"messages": [HumanMessage("Hello")]}, config=config)

# Second call — same thread_id continues conversation
result2 = graph.invoke({"messages": [HumanMessage("Follow up")]}, config=config)
```

### 2.6 How Resume Works — Exact API

**Resuming an interrupted run:**

```python
# Graph was interrupted — either via interrupt() or interrupt_before
# thread_id tells checkpointer which checkpoint to load

config = {"configurable": {"thread_id": "thread_abc"}}

# Check current state
state = graph.get_state(config)
print(state.next)         # What node would execute next
print(state.values)       # Current state values

# Resume with human input
graph.invoke(
    Command(resume="approved"),  # Human provides input
    config=config
)
```

**Resume mechanism internally:**
1. `get_tuple()` fetches latest checkpoint for thread
2. `channel_values` restored to channels
3. `pending_writes` fetched and applied to channels
4. `versions_seen` compared against `channel_versions` to determine which nodes are pending
5. Execution resumes from those pending nodes

**Rewinding to a specific checkpoint:**

```python
# Get checkpoint history
history = list(graph.get_state_history(config))
past_state = history[2]  # Third-most-recent checkpoint

# Replay from that point
graph.invoke(
    None,
    config=past_state.config  # Contains specific checkpoint_id
)
```

### 2.7 Async vs Sync Checkpointing

The runtime detects whether it's executing synchronously or asynchronously and calls the appropriate variant. If you're using `graph.ainvoke()` (async), the checkpointer must implement the async methods. Mixing sync graph execution with an async-only checkpointer (or vice versa) raises a `NotImplementedError`.

SqliteSaver implements sync only. AsyncSqliteSaver implements async only. PostgresSaver implements both.

---

## Section 3: Memory Store — Full Mechanism

### 3.1 Store vs Checkpointer — The Distinction

The **checkpointer** stores graph execution state (what happened in this run, for this thread). It is per-thread and per-run.

The **store** stores long-term memories that persist across threads, runs, and agents. It is explicitly cross-thread. The store is where you put facts about a user that should persist between separate conversations.

Both are injected at compile time:

```python
graph = workflow.compile(
    checkpointer=MemorySaver(),   # Per-thread state
    store=InMemoryStore()          # Cross-thread persistent memory
)
```

### 3.2 InMemoryStore Architecture

`InMemoryStore` implements the `BaseStore` interface. Internally it uses Python dicts indexed by namespace. For vector search, it optionally maintains an embedding index.

**Constructor with vector search:**

```python
from langgraph.store.memory import InMemoryStore

def embed_fn(texts: list[str]) -> list[list[float]]:
    # Call your embedding model
    return [[0.1, 0.2, ...] for t in texts]  # list of float vectors

store = InMemoryStore(
    index={
        "embed": embed_fn,   # Embedding function
        "dims": 1536,        # Vector dimensions
        "fields": ["$"],     # JSON paths to embed. "$" = whole document. ["content", "title"] = specific fields
    }
)
```

**For production**, replace with a database-backed implementation. LangGraph's `BaseStore` interface is small enough that writing a Qdrant-backed or Postgres-backed store is a realistic project (assessed in Section 8).

### 3.3 The put / get / search API

**put — write a memory:**

```python
store.put(
    namespace=("user_123", "preferences"),  # Tuple — hierarchical namespace
    key="theme_preference",                  # Unique key within namespace
    value={"theme": "dark", "font_size": 14},  # JSON-serializable dict
    index=["theme"]  # Optional: embed only specific fields. False = skip indexing.
)
```

**get — retrieve by key:**

```python
item = store.get(
    namespace=("user_123", "preferences"),
    key="theme_preference"
)
# Returns Item(namespace=..., key=..., value=..., created_at=..., updated_at=...)
# Returns None if not found
```

**search — semantic or filtered retrieval:**

```python
results = store.search(
    namespace_prefix=("user_123",),  # Search within this namespace prefix
    query="what font size does the user prefer?",  # Natural language — triggers vector search
    filter={"type": "preference"},   # Metadata filter (exact match)
    limit=5                          # Max results
)
# Returns list[SearchItem] — each has .value, .score (relevance), .namespace, .key
```

**Async variants:** `aput`, `aget`, `asearch`, `abatch` for async graph execution.

**batch — multiple operations in one call:**

```python
results = store.batch([
    GetOp(namespace=("user_123",), key="prefs"),
    SearchOp(namespace_prefix=("docs",), query="python errors", limit=3),
    PutOp(namespace=("user_123",), key="new_fact", value={"content": "..."}),
])
```

### 3.4 Vector Search Internals

When a `query` string is passed to `search()`:
1. The store calls `embed_fn([query])` to get the query vector
2. Computes cosine similarity against all indexed embeddings in the namespace prefix
3. Returns results sorted by similarity score (0.0–1.0), filtered by `filter` if provided
4. Truncates to `limit`

For `InMemoryStore`, this is a brute-force scan across all stored embeddings — O(n). For production, you want a vector-indexed backend (Qdrant, pgvector, etc.).

The `fields` parameter in the index config controls what gets embedded. `["$"]` embeds the entire JSON value as a string. `["content", "title"]` embeds only those specific keys, concatenated.

Accessing the store within a node requires the store to be injected via the `get_store()` mechanism or passed through state:

```python
from langgraph.store.base import BaseStore
from langchain_core.runnables import RunnableConfig

def memory_node(state: MyState, config: RunnableConfig, store: BaseStore) -> dict:
    # Store is auto-injected when graph is compiled with store=
    thread_id = config["configurable"]["thread_id"]
    memories = store.search(
        namespace_prefix=(thread_id,),
        query=state["messages"][-1].content,
        limit=3
    )
    return {"retrieved_context": [m.value for m in memories]}
```

### 3.5 LangMem — How It Sits on Top of the Store

LangMem is a separate package (`langmem`) that provides high-level memory management tooling built on top of LangGraph's `BaseStore`. Install separately: `pip install langmem`.

LangMem's architecture:

```
LangMem Layer
├── Memory Managers (extract and reconcile memories from conversations)
├── Prompt Optimizers (update system prompts based on feedback)
└── Store Managers (wrap BaseStore with memory-specific logic)
         ↓
LangGraph BaseStore (the storage interface)
         ↓
InMemoryStore / Postgres / Qdrant / etc.
```

LangMem operates in two modes:

**Hot path (synchronous, in-graph):** Memory extraction happens inside a node before response generation. Adds latency, captures context immediately.

**Background (deferred):** Memory extraction runs after the graph response, as a separate job. No latency impact on the main response.

### 3.6 The Three Memory Strategies

**Semantic Memory** — facts and knowledge:
```python
from langmem import create_memory_manager

manager = create_memory_manager(
    model="openai:gpt-4o",
    schemas=[],  # Empty = extract arbitrary facts
    instructions="Extract key facts about the user",
)

memories = await manager.ainvoke({
    "messages": conversation_history,
    "existing": current_memories
})
# Returns ExtractedMemory objects with content and unique IDs
# Stored as individual documents in the store namespace
# Recalled via semantic search at query time
```

**Episodic Memory** — experiences and examples:
```python
from pydantic import BaseModel

class Episode(BaseModel):
    situation: str
    reasoning: str
    action: str
    result: str
    success: bool

manager = create_memory_manager(
    model="openai:gpt-4o",
    schemas=[Episode],
    instructions="Extract problem-solving episodes"
)
# Episodic memories capture HOW a problem was solved
# Used as few-shot examples in future prompts
# Retrieved via semantic similarity to current problem
```

**Procedural Memory** — skills and rules (stored in prompts):
```python
from langmem import create_prompt_optimizer

optimizer = create_prompt_optimizer(
    model="openai:gpt-4o",
    kind="metaprompt"  # or "gradient", "prompt_memory"
)

new_prompt = await optimizer.ainvoke({
    "trajectories": [(conversation, feedback_score)],
    "prompt": current_system_prompt
})
# Returns updated prompt text — the "memory" is the prompt itself
# No vector retrieval needed — baked into system instructions
```

---

## Section 4: Multi-Agent Patterns

### 4.1 The Core Multi-Agent Model

In LangGraph, multi-agent systems are implemented as **nodes in a single graph** (flat) or as **nested subgraphs** (hierarchical). Each agent is either:

1. A regular compiled `CompiledStateGraph` used as a node
2. A `StateGraph` with its own internal nodes, compiled and embedded as a subgraph

State communication between agents happens through shared state channels (by convention: the `messages` channel) or via explicit state handoffs using the `Command` primitive.

### 4.2 Supervisor Pattern — Exact Implementation

The supervisor pattern uses `langgraph-supervisor` package or can be built manually:

```python
from langgraph_supervisor import create_supervisor
from langgraph.prebuilt import create_react_agent

# Define worker agents
researcher = create_react_agent(
    model="openai:gpt-4o",
    tools=[web_search, read_file],
    name="researcher"
)

writer = create_react_agent(
    model="openai:gpt-4o",
    tools=[write_file],
    name="writer"
)

# Create supervisor
workflow = create_supervisor(
    agents=[researcher, writer],
    model="openai:gpt-4o",
    prompt="Route tasks to the appropriate specialist. researcher handles information gathering. writer handles document creation.",
    output_mode="full_history",  # or "last_message"
    add_handoff_messages=True,   # Add tracking messages on agent handoffs
)

app = workflow.compile(checkpointer=MemorySaver())
```

**What create_supervisor builds internally:**
1. A StateGraph with `MessagesState`
2. A supervisor node (LLM with tool-calling)
3. One node per worker agent
4. Auto-generated handoff tools: `transfer_to_researcher`, `transfer_to_writer`
5. Conditional edges: when supervisor calls a handoff tool, route to that agent
6. After agent completes, route back to supervisor

The routing is **tool-call-based**: the supervisor LLM calls a handoff tool as a normal tool invocation. The tool's execution triggers a `Command(goto="agent_name")` which re-routes the graph.

### 4.3 Handoff Mechanism — How It Works

Handoffs use LangGraph's `Command` primitive:

```python
from langgraph.types import Command

# A handoff tool looks like this internally
def transfer_to_researcher(state: MessagesState) -> Command:
    return Command(
        goto="researcher",
        update={"messages": [ToolMessage("Transferring to researcher", tool_call_id=...)]},
        graph=Command.PARENT  # If inside subgraph, hop to parent graph
    )
```

`Command` combines routing and state update in a single return value. A node that returns a `Command` is saying: "update state with this, then go to that node." This is more powerful than a conditional edge because the routing decision and the state update happen atomically.

For cross-subgraph handoffs:
```python
# Agent B (running inside subgraph) wants to hand off to Agent A (in parent graph)
return Command(
    goto="agent_a",
    graph=Command.PARENT,  # Escalate to parent graph's routing
    update={"messages": [...]}
)
```

### 4.4 Subgraph Pattern — Agents as Nested Graphs

```python
# Define a subgraph agent
researcher_graph = StateGraph(ResearcherState)
researcher_graph.add_node("search", search_node)
researcher_graph.add_node("synthesize", synthesize_node)
researcher_graph.add_edge(START, "search")
researcher_graph.add_edge("search", "synthesize")
researcher_graph.add_edge("synthesize", END)
compiled_researcher = researcher_graph.compile()

# Use subgraph as a node in parent graph
parent_graph = StateGraph(ParentState)
parent_graph.add_node("researcher", compiled_researcher)  # Subgraph as node
parent_graph.add_node("writer", writer_node)
```

**State schema compatibility:** If parent and subgraph share no state keys, you need input/output transformations:

```python
def researcher_input(state: ParentState) -> ResearcherState:
    return {"query": state["messages"][-1].content}

def researcher_output(state: ResearcherState) -> dict:
    return {"messages": [AIMessage(state["findings"])]}

parent_graph.add_node(
    "researcher",
    compiled_researcher,
    input=researcher_input,
    output=researcher_output
)
```

### 4.5 Shared State Between Agents

The most common pattern: shared `messages` channel. All agents read from and write to the same message list. The `add_messages` reducer with ID deduplication handles concurrent writes without conflict.

For more structured coordination:

```python
class TeamState(TypedDict):
    messages: Annotated[list, add_messages]   # Shared conversation
    task_queue: Annotated[list[str], operator.add]  # Agents append tasks
    completed_tasks: Annotated[list[str], operator.add]
    active_agent: str  # LastValue — supervisor sets this
    final_output: str  # LastValue — only writer sets this
```

### 4.6 Swarm Pattern (2025 Addition)

The `langgraph-swarm` package implements peer-to-peer agent coordination without a central supervisor. Agents can hand off to each other directly. An `active_agent` field in shared state tracks who is currently responsible. Any agent can invoke any other agent's handoff tool.

---

## Section 5: Human-in-the-Loop

### 5.1 The interrupt() Mechanism

`interrupt()` is a function callable from within any node that pauses graph execution and waits for external input. Unlike breakpoints, it is designed for production HITL workflows.

```python
from langgraph.types import interrupt

def approval_node(state: MyState) -> dict:
    # Execution pauses here — state is checkpointed
    decision = interrupt({
        "message": "Please review this tool call",
        "tool_call": state["pending_tool_call"],
        "options": ["approve", "reject", "modify"]
    })
    # When resumed, `decision` = whatever was passed as Command(resume=...)

    if decision == "approve":
        return {"tool_approved": True}
    else:
        return {"tool_approved": False, "rejection_reason": decision}
```

**Internal mechanism:**
1. `interrupt(payload)` raises a `GraphInterrupt` exception internally
2. The Pregel runtime catches it — this is NOT a crash
3. The payload is serialized and stored in the checkpoint as `pending_writes`
4. The thread status is marked as `"interrupted"`
5. The runtime returns to the caller with the interrupt payload surfaced in the response
6. On resume, the **entire node re-executes from its beginning** — not from the `interrupt()` line
7. On re-execution, `interrupt()` returns the resume value instead of raising

**Critical implication:** Any side effects that run before `interrupt()` in the node body will execute twice. Design nodes to be idempotent, or check the resume value first.

### 5.2 Static Interrupts — Compile-Time Configuration

For testing and debugging, declare interrupt points at compile time:

```python
graph = workflow.compile(
    checkpointer=MemorySaver(),
    interrupt_before=["tool_execution_node"],  # Pause before these nodes
    interrupt_after=["llm_call_node"]          # Pause after these nodes
)
```

Static interrupts require no code changes in nodes. They pause the graph and return — you then call `graph.invoke(None, config)` to resume without providing input.

### 5.3 Resume Patterns

**Single interrupt resume:**
```python
config = {"configurable": {"thread_id": "thread_123"}}

# First invocation — triggers interrupt
result = graph.invoke(initial_input, config=config)
interrupt_payload = result["__interrupt__"]  # v1 API, or result.interrupts in v2

# Human reviews interrupt_payload...

# Resume
final_result = graph.invoke(
    Command(resume="approved"),
    config=config
)
```

**Multiple parallel interrupts:**
```python
# When parallel branches each call interrupt(), you get a list
interrupts = result["__interrupt__"]  # list of Interrupt objects

resume_map = {
    interrupts[0].id: "approved",
    interrupts[1].id: "rejected"
}

graph.invoke(Command(resume=resume_map), config=config)
```

**Editing state at interrupt:**
```python
# Instead of just resuming, modify state first
graph.update_state(
    config,
    {"tool_call_args": {"modified_arg": "new_value"}},
    as_node="approval_node"
)
# Then resume
graph.invoke(Command(resume="approved"), config=config)
```

---

## Section 6: Production / LangGraph Platform

### 6.1 What the Platform Adds

LangGraph open-source is a Python library. LangGraph Platform (renamed LangSmith Deployment in October 2025) is a managed service that adds:

| Feature | Open Source | Platform |
|---------|-------------|---------|
| Graph execution | Yes | Yes |
| Checkpointing | DIY backends | Managed Postgres |
| Horizontal scaling | DIY | Managed, auto-scale |
| REST API | DIY | 30+ built-in endpoints |
| Streaming over HTTP | DIY | Managed SSE |
| Studio IDE | Local | Hosted |
| Async task queues | DIY | Managed |
| Long-running tasks (hours) | Possible | Designed for |

Three deployment tiers: SaaS (managed), Hybrid (control plane managed, data plane self-hosted), Self-Hosted (full VPC deployment).

### 6.2 Streaming — How It Works

LangGraph supports five streaming modes, configured per-invocation:

```python
for event in graph.stream(
    {"messages": [HumanMessage("Query")]},
    config=config,
    stream_mode="messages"  # or "values", "updates", "debug", "custom"
):
    print(event)
```

**`values` mode:** Emits the complete state snapshot after each superstep. Highest token volume. Good for debugging.

**`updates` mode:** Emits only the state delta produced by each node. More efficient than `values`.

```python
# updates mode output
# {"node_name": {"key": "new_value"}}  — only what changed
```

**`messages` mode:** Streams LLM tokens as they are generated — streamed at the token level, not the superstep level. Required for responsive chat UIs.

```python
async for chunk, metadata in graph.astream(input, config, stream_mode="messages"):
    # chunk is a BaseMessage chunk (partial content)
    # metadata includes node name, langgraph_step, etc.
    print(chunk.content, end="", flush=True)
```

**`debug` mode:** Emits checkpoint and task events — superstep boundaries, task scheduling decisions. Used for deep debugging.

**`custom` mode:** Nodes can emit arbitrary events:
```python
from langchain_core.runnables import RunnableConfig
from langgraph.config import get_stream_writer

def my_node(state: MyState, config: RunnableConfig) -> dict:
    writer = get_stream_writer()
    writer({"progress": "starting search..."})  # Custom event
    # ... do work ...
    writer({"progress": "search complete"})
    return {"results": [...]}
```

**Multiple modes simultaneously:**
```python
async for event in graph.astream(input, config, stream_mode=["messages", "updates"]):
    # event is a tuple: (mode, data)
    mode, data = event
```

**Platform-level streaming** uses Server-Sent Events (SSE) over HTTP. The platform's API server buffers events in a per-run queue, delivers to clients via SSE, and supports reconnection via `Last-Event-ID` header (no token loss on connection drop).

---

## Section 7: Code Examples

### 7.1 Minimal StateGraph with Persistence

```python
from typing import TypedDict, Annotated
from langgraph.graph import StateGraph, START, END
from langgraph.graph.message import add_messages
from langgraph.checkpoint.memory import MemorySaver
from langchain_core.messages import HumanMessage, AIMessage

class AgentState(TypedDict):
    messages: Annotated[list, add_messages]

def llm_node(state: AgentState) -> dict:
    # Simulated LLM call
    last_message = state["messages"][-1].content
    response = AIMessage(content=f"Echo: {last_message}")
    return {"messages": [response]}

# Build graph
graph = StateGraph(AgentState)
graph.add_node("llm", llm_node)
graph.add_edge(START, "llm")
graph.add_edge("llm", END)

# Compile with persistence
app = graph.compile(checkpointer=MemorySaver())

# Run with thread_id — persists between calls
config = {"configurable": {"thread_id": "convo_001"}}
result = app.invoke({"messages": [HumanMessage("Hello")]}, config=config)
result2 = app.invoke({"messages": [HumanMessage("How are you?")]}, config=config)
# result2 sees both messages in history
```

### 7.2 Conditional Routing

```python
from langgraph.graph import StateGraph, START, END

class RouterState(TypedDict):
    query: str
    route: str
    response: str

def classify(state: RouterState) -> dict:
    q = state["query"].lower()
    if "math" in q:
        return {"route": "math"}
    elif "code" in q:
        return {"route": "code"}
    else:
        return {"route": "general"}

def route_fn(state: RouterState) -> str:
    return state["route"]  # Returns node name

def math_agent(state: RouterState) -> dict:
    return {"response": "Math answer here"}

def code_agent(state: RouterState) -> dict:
    return {"response": "Code answer here"}

def general_agent(state: RouterState) -> dict:
    return {"response": "General answer here"}

graph = StateGraph(RouterState)
graph.add_node("classify", classify)
graph.add_node("math", math_agent)
graph.add_node("code", code_agent)
graph.add_node("general", general_agent)

graph.add_edge(START, "classify")
graph.add_conditional_edges("classify", route_fn, {
    "math": "math",
    "code": "code",
    "general": "general"
})
graph.add_edge("math", END)
graph.add_edge("code", END)
graph.add_edge("general", END)

app = graph.compile()
```

### 7.3 Custom Checkpointer Skeleton

```python
from langgraph.checkpoint.base import BaseCheckpointSaver, CheckpointTuple, Checkpoint, CheckpointMetadata
from langgraph.serde.jsonplus import JsonPlusSerializer
from langchain_core.runnables import RunnableConfig
from typing import Iterator, Optional, Sequence, Tuple, Any

class MyCustomCheckpointer(BaseCheckpointSaver):
    """Skeleton for a custom checkpointer implementation."""

    serde = JsonPlusSerializer()

    def __init__(self, connection_string: str):
        self.conn_str = connection_string
        # Initialize your database connection here

    def get_tuple(self, config: RunnableConfig) -> Optional[CheckpointTuple]:
        thread_id = config["configurable"]["thread_id"]
        checkpoint_id = config["configurable"].get("checkpoint_id")
        checkpoint_ns = config["configurable"].get("checkpoint_ns", "")

        # Fetch from your database
        # If checkpoint_id: fetch exact row
        # Else: fetch latest for (thread_id, checkpoint_ns)
        row = self._fetch_from_db(thread_id, checkpoint_ns, checkpoint_id)

        if row is None:
            return None

        return CheckpointTuple(
            config=config,
            checkpoint=self.serde.loads(row["checkpoint_data"]),
            metadata=self.serde.loads(row["metadata"]),
            parent_config={"configurable": {"checkpoint_id": row["parent_id"]}} if row["parent_id"] else None,
            pending_writes=self._fetch_pending_writes(row["checkpoint_id"])
        )

    def list(self, config: RunnableConfig, *, filter: Optional[dict] = None,
             before: Optional[RunnableConfig] = None, limit: Optional[int] = None) -> Iterator[CheckpointTuple]:
        # List checkpoints newest-first
        thread_id = config["configurable"]["thread_id"]
        rows = self._list_from_db(thread_id, filter=filter, limit=limit)
        for row in rows:
            yield self._row_to_tuple(row)

    def put(self, config: RunnableConfig, checkpoint: Checkpoint,
            metadata: CheckpointMetadata, new_versions: dict) -> RunnableConfig:
        thread_id = config["configurable"]["thread_id"]
        checkpoint_ns = config["configurable"].get("checkpoint_ns", "")
        checkpoint_id = checkpoint["id"]

        self._upsert_to_db(
            thread_id=thread_id,
            checkpoint_ns=checkpoint_ns,
            checkpoint_id=checkpoint_id,
            parent_id=config["configurable"].get("checkpoint_id"),
            data=self.serde.dumps(checkpoint),
            metadata=self.serde.dumps(metadata)
        )

        return {
            "configurable": {
                "thread_id": thread_id,
                "checkpoint_ns": checkpoint_ns,
                "checkpoint_id": checkpoint_id
            }
        }

    def put_writes(self, config: RunnableConfig, writes: Sequence[Tuple[str, Any]],
                   task_id: str, task_path: str = "") -> None:
        # Store pending writes for mid-superstep recovery
        for channel, value in writes:
            self._upsert_write(
                checkpoint_id=config["configurable"]["checkpoint_id"],
                task_id=task_id,
                channel=channel,
                value=self.serde.dumps(value)
            )

    def _fetch_from_db(self, *args): pass   # Implement with your DB
    def _upsert_to_db(self, **kwargs): pass
    def _upsert_write(self, **kwargs): pass
    def _list_from_db(self, *args, **kwargs): return []
    def _row_to_tuple(self, row): pass
    def _fetch_pending_writes(self, checkpoint_id): return []
```

### 7.4 Memory Store with Vector Search

```python
from langgraph.store.memory import InMemoryStore
from langchain_openai import OpenAIEmbeddings

embeddings = OpenAIEmbeddings(model="text-embedding-3-small")

def embed_fn(texts: list[str]) -> list[list[float]]:
    return embeddings.embed_documents(texts)

store = InMemoryStore(
    index={
        "embed": embed_fn,
        "dims": 1536,
        "fields": ["content"]  # Only embed the "content" field
    }
)

# Store a memory
store.put(
    namespace=("user_123", "facts"),
    key="fact_001",
    value={"content": "User prefers Python over JavaScript", "source": "session_5"}
)

# Semantic search
results = store.search(
    namespace_prefix=("user_123",),
    query="What programming language does the user prefer?",
    limit=3
)
for r in results:
    print(f"Score: {r.score:.3f} | {r.value['content']}")
```

### 7.5 Human-in-the-Loop with interrupt()

```python
from langgraph.types import interrupt, Command
from langgraph.graph import StateGraph, START, END
from langgraph.checkpoint.memory import MemorySaver

class ReviewState(TypedDict):
    draft: str
    approved: bool
    feedback: str

def draft_node(state: ReviewState) -> dict:
    return {"draft": "Here is my proposed action: DELETE ALL LOGS"}

def review_node(state: ReviewState) -> dict:
    # Pause and ask human to review
    decision = interrupt({
        "draft": state["draft"],
        "question": "Approve this action?",
    })

    if decision["approved"]:
        return {"approved": True}
    else:
        return {"approved": False, "feedback": decision.get("feedback", "")}

def execute_node(state: ReviewState) -> dict:
    if state["approved"]:
        # Execute action
        return {"draft": "Action executed successfully"}
    else:
        return {"draft": f"Cancelled. Feedback: {state['feedback']}"}

graph = StateGraph(ReviewState)
graph.add_node("draft", draft_node)
graph.add_node("review", review_node)
graph.add_node("execute", execute_node)
graph.add_edge(START, "draft")
graph.add_edge("draft", "review")
graph.add_edge("review", "execute")
graph.add_edge("execute", END)

app = graph.compile(checkpointer=MemorySaver())
config = {"configurable": {"thread_id": "review_001"}}

# First invocation — pauses at interrupt
result = app.invoke({"draft": "", "approved": False, "feedback": ""}, config=config)
print(result)  # Contains __interrupt__ with the payload

# Human reviews and provides decision
final = app.invoke(
    Command(resume={"approved": True}),
    config=config
)
```

### 7.6 Multi-Agent Supervisor

```python
from langgraph_supervisor import create_supervisor
from langgraph.prebuilt import create_react_agent
from langgraph.checkpoint.memory import MemorySaver
from langchain_openai import ChatOpenAI

llm = ChatOpenAI(model="gpt-4o")

# Specialized agents
research_agent = create_react_agent(
    model=llm,
    tools=[web_search_tool, read_url_tool],
    name="research_specialist",
    prompt="You are a research specialist. Gather information thoroughly."
)

analysis_agent = create_react_agent(
    model=llm,
    tools=[python_repl_tool],
    name="data_analyst",
    prompt="You are a data analyst. Analyze data and produce insights."
)

# Supervisor orchestrates
supervisor_workflow = create_supervisor(
    agents=[research_agent, analysis_agent],
    model=llm,
    prompt="""You are a team coordinator.
    Route information-gathering tasks to research_specialist.
    Route analysis tasks to data_analyst.
    Combine results for final output.""",
    output_mode="last_message"
)

app = supervisor_workflow.compile(checkpointer=MemorySaver())

result = app.invoke(
    {"messages": [HumanMessage("Research the top 3 Python web frameworks and compare their performance")]},
    config={"configurable": {"thread_id": "research_001"}}
)
```

---

## Section 8: Can We Recreate It?

### 8.1 State Graph Routing Engine

**Complexity: LOW-MEDIUM | Time: 3–7 days**

The StateGraph builder is essentially:
- A dict of `{node_name: callable}`
- A dict of `{source_node: [(condition_fn, dest_node)]}` for edges
- A `compile()` that validates connectivity and builds the execution plan

The BSP execution loop (Pregel) is more involved:
- Topological ordering for non-cyclic sections
- Parallel task scheduling (asyncio.gather or threadpool)
- Transactional state update (all writes buffered, applied atomically after superstep)
- Loop detection / max-iterations guard

A functional recreation of the core state-routing logic is ~500–800 lines of Python. The hard parts are: correct handling of parallel fan-out, atomic state updates, and the Send API for dynamic dispatch. A week of focused work gets you a working implementation. LangGraph's production version adds edge cases around serialization, validation, visualization, and error handling that add weeks of polish.

### 8.2 Checkpointing Mechanism

**Complexity: LOW | Time: 2–5 days**

The `BaseCheckpointSaver` interface is well-defined and the storage format (CheckpointTuple, Checkpoint TypedDict) is simple. A custom Postgres or SQLite checkpointer is a realistic 2–3 day project:

- Define 3 tables (checkpoints, checkpoint_blobs, checkpoint_writes)
- Implement `put`, `get_tuple`, `list`, `put_writes`
- Wire in serialization (JsonPlusSerializer or pickle)
- Add the async variants

What LangGraph's production checkpointers add that takes more time: schema migrations, connection pooling, retry logic on transient failures, efficient blob storage for large states (LangGraph splits primitives inline vs complex objects to blobs — a correct optimization that takes 1–2 extra days to implement properly).

### 8.3 Memory Store

**Complexity: LOW | Time: 1–3 days**

`BaseStore` with `put/get/search` is a key-value store with optional vector search. This is a thin wrapper around any existing vector database. The interface is small:

```python
class BaseStore(ABC):
    def put(self, namespace, key, value, index=None): ...
    def get(self, namespace, key): ...
    def search(self, namespace_prefix, *, query=None, filter=None, limit=10): ...
    def delete(self, namespace, key): ...
    def batch(self, ops): ...
```

A Qdrant-backed implementation of this interface is 1–2 days. The hard part is the `search()` semantics — specifically, the `namespace_prefix` filtering (Qdrant payloads + filter conditions handle this) and the `filter` dict (needs to map to Qdrant's filter syntax).

### 8.4 LangMem Memory Extraction

**Complexity: MEDIUM | Time: 1–2 weeks**

LangMem's `create_memory_manager` is an LLM-based extraction pipeline. The pattern:
1. Build a prompt from conversation + existing memories + instructions
2. Call LLM with structured output (Pydantic schemas)
3. Reconcile new extractions with existing store entries (this is the hard part)

The reconciliation logic (should this new fact update an existing memory? Create new? Delete stale?) requires careful prompt engineering and is where most of the complexity lives. A basic version works in a few days. A production-quality reconciler that handles edge cases (contradictions, temporal updates, deduplication across sessions) takes weeks.

### 8.5 What Is Genuinely Hard vs. Wrapper Patterns

**Genuinely non-trivial:**
- Interrupt/resume mechanism: The node-restart-on-resume semantics, GraphInterrupt exception handling, multi-interrupt ID mapping — subtle to get right
- Concurrent parallel branch execution with atomic state merge — race conditions are real
- Checkpoint recovery with pending_writes replay — the exact ordering matters for correctness

**Wrappers around standard patterns:**
- Memory store: key-value with vector search — fully standard
- Checkpointing backends: SQL CRUD with specific schema — fully standard
- Streaming: SSE or websocket event emitter — fully standard
- Supervisor routing: LLM tool-calling driving a state machine — standard pattern

**Surprising simplicity:** The routing engine itself. Once you strip LangGraph's abstractions, it's a loop that repeatedly calls functions and applies their outputs to a shared dict, with branching driven by return values. The Pregel BSP model sounds complex but the implementation is a topologically-sorted parallel executor with checkpoint callbacks.

---

## Section 9: How to Incorporate Into Velorin

### 9.1 Velorin System Context

The Velorin system has:
- Multiple named agents (Jiang, Trey, MarcusAurelius, Alexander) running as separate Claude Code instances
- A knowledge graph stored as markdown files with pointer-rated synapses (Velorin Brain)
- Qdrant for vector search (available, not yet integrated with agents)
- GitHub as source of truth (pull before read, push after write)
- Session compaction causing state loss (the primary memory problem)

### 9.2 What to Adopt from LangGraph

**Adopt immediately: The Checkpointing Pattern (not the library)**

The session compaction problem is exactly what LangGraph's checkpointing solves. The architecture:

1. Before every session, write a checkpoint: agent name, current task, key reasoning state, active handoffs
2. Checkpoint lives in a file (GitHub) or local SQLite — NOT in CLAUDE.md or MEMORY.md (too coarse)
3. On session start, each agent reads their checkpoint and restores exactly where they were

You do NOT need the LangGraph library for this. The pattern is: serialize state dict → store → deserialize on boot. The existing session handoff files (e.g., `Bot.Jiang/Jiang.SessionHandoff.Session020.Apr4.md`) are already a manual version of this pattern. What's missing is automation and granularity.

**Adopt: The Namespace Model for Memory**

LangGraph's `(namespace_prefix, key)` model maps directly to the Velorin Brain's `(region, area, neuron)` hierarchy. The pointer-rating system in the Brain is more sophisticated than LangGraph's flat namespace model — keep the Brain's model, but adopt the explicit namespace-tuple convention for Qdrant vector storage:

```python
# Velorin-style namespace for Qdrant
namespace = ("velorin_brain", "region_name", "area_name")
key = "neuron_filename"
```

This gives you LangGraph-compatible namespace semantics over Qdrant without requiring the LangGraph store library.

**Adopt: The BaseStore Interface as a Design Contract**

Write a `VerlorinStore` that implements the `BaseStore` interface (`put/get/search/delete/batch`) backed by Qdrant. This gives you:
- A clean API that any agent can use without knowing about Qdrant
- Compatibility with LangMem if you choose to adopt it later
- A standard pattern for adding other backends later

```python
class VelorinStore:
    """Qdrant-backed store implementing BaseStore interface."""

    def __init__(self, qdrant_client, collection_name="velorin_brain"):
        self.client = qdrant_client
        self.collection = collection_name

    def put(self, namespace: tuple, key: str, value: dict, index=None):
        # Store with namespace as payload field
        # Compute embedding if index is not False
        ...

    def search(self, namespace_prefix: tuple, *, query=None, filter=None, limit=10):
        # Qdrant vector search with namespace prefix filter
        ...

    def get(self, namespace: tuple, key: str):
        # Qdrant point lookup by payload filter
        ...
```

### 9.3 What to Skip

**Skip: The LangGraph StateGraph routing engine**

Velorin agents are separate Claude Code instances, not nodes in a Python graph. The routing happens at the human or orchestration layer (CLAUDE.md agent detection, session handoffs, inbox files). Importing LangGraph's execution engine would require wrapping Claude Code invocations as LangGraph nodes — heavy infrastructure for marginal benefit.

**Skip: LangGraph Platform / LangSmith Deployment**

Velorin runs on Claude Code with tmux. The platform deployment model is built for HTTP-served graphs with REST API frontends. Not applicable.

**Skip: The full LangMem SDK (initially)**

LangMem adds LLM calls for memory extraction on every conversation, which adds latency and API costs. The Velorin Brain already has a memory model (neurons with rated pointers) that is arguably more sophisticated than LangMem's flat semantic/episodic split. The risk is LangMem's extraction logic conflicting with or duplicating the Brain's neuron creation protocol.

Consider adopting only LangMem's **Prompt Optimizer** pattern for Procedural Memory — the idea that agent system prompts evolve based on feedback is directly applicable to improving agent rules files.

### 9.4 Specific Integration Recommendations

**Priority 1: Automated Checkpoint System**

Build a lightweight checkpoint writer that runs at session close and reads at session open. Store in `Bot.{AgentName}/session_checkpoint.json`. This is 50 lines of Python.

```python
# Each agent writes this on close
{
    "agent": "Jiang",
    "session": 21,
    "timestamp": "2026-04-04T18:30:00Z",
    "active_tasks": ["build first neuron", "daily scraper bot"],
    "current_reasoning": "...",
    "pending_handoffs": [...],
    "brain_regions_modified": ["neurons.agents.protocols"]
}
```

**Priority 2: VelorinStore (Qdrant-backed, BaseStore-interface)**

Implement the BaseStore interface over Qdrant. Use the Velorin Brain neuron hierarchy as the namespace structure. This unlocks semantic search over the Brain without pulling every neuron on every session.

```python
# Current pattern (expensive)
# Read Brain _index.md → read 5–10 neurons → find answer

# With VelorinStore
results = store.search(
    namespace_prefix=("velorin_brain",),
    query="What is CT's current position on platform dependencies?",
    limit=3
)
# Returns top-3 neurons by semantic similarity, with their content
```

**Priority 3: Inter-Agent Inbox Pattern (aligned with LangGraph Command)**

The `Command(goto="agent", update={...})` pattern maps to Velorin's inbox files. Formalize this: each agent writes handoffs as structured JSON to their target's inbox. The receiving agent reads and applies on boot. This is Velorin's existing pattern made explicit and machine-readable.

**Priority 4: LangGraph Checkpointer for Jiang (Optional, Low Priority)**

If Jiang is ever rebuilt as a LangGraph-native agent (nodes as tool-calling steps), the PostgresSaver checkpointer would give precise resume capability. This is a future consideration — the current tmux+Claude Code model doesn't map to LangGraph nodes.

### 9.5 The Core Velorin-Specific Problem LangGraph Doesn't Solve

LangGraph assumes all agents run within a single Python process (or accessible via the platform's API). Velorin agents are separate Claude Code terminal sessions with no shared process. LangGraph's graph routing is therefore inapplicable at the agent-to-agent coordination layer.

What Velorin needs that LangGraph doesn't provide: a shared coordination bus that is file-system-based (GitHub), persistent across process boundaries, and readable by any AI system including non-Claude models (Trey in GPT). LangGraph's multi-agent patterns assume Python-native coordination — the shared `messages` channel requires all agents to be in the same Python runtime.

The Velorin Brain + inbox files architecture is correctly designed for this constraint. The right move is not to adopt LangGraph's multi-agent model, but to harden the existing model with the specific technical patterns LangGraph has proven: namespace-organized storage, structured checkpoints, semantic search over memory, and explicit handoff contracts.

---

## Appendix: Quick Reference

### Key Classes and Their Roles

| Class | Location | Role |
|-------|----------|------|
| `StateGraph` | `langgraph.graph` | Builder API for defining graphs |
| `CompiledStateGraph` | Internal (`Pregel`) | Runtime executor |
| `BaseCheckpointSaver` | `langgraph.checkpoint.base` | Checkpointer interface |
| `MemorySaver` | `langgraph.checkpoint.memory` | In-memory checkpointer |
| `PostgresSaver` | `langgraph.checkpoint.postgres` | Postgres checkpointer |
| `BaseStore` | `langgraph.store.base` | Memory store interface |
| `InMemoryStore` | `langgraph.store.memory` | In-memory store |
| `Command` | `langgraph.types` | Combined routing + state update |
| `Send` | `langgraph.types` | Dynamic fan-out with payload |
| `interrupt` | `langgraph.types` | HITL pause function |
| `MessagesState` | `langgraph.graph` | Pre-built messages TypedDict |
| `add_messages` | `langgraph.graph.message` | Message list reducer |

### Install Commands

```bash
pip install langgraph                          # Core library
pip install langgraph-checkpoint-postgres      # Postgres backend
pip install langgraph-checkpoint-sqlite        # SQLite backend
pip install langgraph-supervisor               # Supervisor multi-agent
pip install langgraph-swarm                    # Swarm multi-agent
pip install langmem                            # Memory extraction
```

### Confidence Weights on Claims

- Core StateGraph, channel, reducer architecture: **HIGH** — directly from source code analysis and official docs
- CheckpointTuple fields and storage model: **HIGH** — from DeepWiki source analysis and Postgres implementation review
- LangMem extraction internals: **MEDIUM-HIGH** — from official LangMem docs, some implementation details inferred
- Streaming event ordering and SSE reconnect semantics: **MEDIUM** — from LangGraph.js docs (Python implementation similar but not confirmed identical)
- LangGraph Platform pricing and SLA details: **NOT COVERED** — out of scope for technical teardown
- October 2025 LangSmith Deployment renaming: **HIGH** — confirmed from blog post

---

*Document ends. Total word count: ~6,800 words.*
