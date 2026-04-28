# Technical Operating Paper: Mem0
## Architecture, Mechanisms, and Strategic Assessment for Custom Agent Memory Systems

**Prepared for:** System Architect — Velorin System
**Date:** April 4, 2026
**Primary Source:** arxiv:2504.19413 (published ECAI 2025), mem0ai/mem0 GitHub repository, official documentation
**Confidence key:** [HIGH] = confirmed from source code or paper. [MED] = confirmed from docs or secondary sources. [LOW] = inferred from architectural patterns.

---

## Table of Contents

1. Core Architecture Overview
2. Memory Extraction Pipeline — Full Mechanism
3. Memory Update Pipeline — Full Mechanism
4. Storage Layer — Full Mechanism
5. Retrieval — Full Mechanism
6. Graph Memory (Mem0g) — Full Mechanism
7. The API / SDK
8. Configuration
9. Code Examples
10. Can We Recreate It?
11. How To Incorporate Into Velorin

---

## 1. Core Architecture Overview

### The System in One Sentence

Mem0 is a memory middleware layer that intercepts agent conversations, uses a two-phase LLM pipeline to extract atomic facts and decide what to do with them (store/update/delete/ignore), persists those facts in a vector store, and returns relevant memories on demand via semantic search.

### The Full Pipeline: Input to Stored Memory

Every call to `memory.add(messages, user_id=...)` executes this exact sequence [HIGH]:

```
1. Message normalization
   - Input (string, dict, or list of dicts) is normalized to [{role, content}] pairs
   - Vision content is optionally pre-processed via vision LLM

2. Filter and metadata construction
   - user_id / agent_id / run_id are validated (at least one required)
   - A "metadata" dict is built for vector storage tagging
   - A "filters" dict is built for querying existing memories

3. If infer=False (direct mode):
   - Messages are embedded directly and stored as-is
   - Skips both LLM phases entirely
   - Faster, cheaper, lower quality

4. If infer=True (default — inference mode):

   Phase 1: Fact Extraction
   - get_fact_retrieval_messages() selects the appropriate system prompt
     (FACT_RETRIEVAL_PROMPT, USER_MEMORY_EXTRACTION_PROMPT, or AGENT_MEMORY_EXTRACTION_PROMPT)
   - LLM is called with messages as context
   - LLM returns JSON: {"facts": ["fact1", "fact2", ...]}
   - normalize_facts() converts various LLM output formats to a clean string list

   Phase 2: Update Decision
   - For each extracted fact:
     a. Embed the fact using the configured embedder
     b. Run vector search against existing memories (top-s, default s=10)
     c. get_update_memory_messages() formats: existing memories + new fact
     d. LLM is called via tool-calling with four available tools:
        ADD_MEMORY_TOOL, UPDATE_MEMORY_TOOL, DELETE_MEMORY_TOOL, NOOP_TOOL
     e. LLM returns a list of tool calls specifying the action

   Execution:
   - ADD: _create_memory() generates UUID, embeds, inserts to vector store + SQLite
   - UPDATE: _update_memory() replaces existing memory text, updates embedding + SQLite
   - DELETE: _delete_memory() removes from vector store, logs deletion in SQLite
   - NOOP: nothing happens

5. If graph_store is configured (Mem0g mode):
   - Entity extraction and relationship extraction run in parallel with vector ops
   - Results are returned in a separate "relations" key

6. Return value:
   {"results": [{"id": "uuid", "memory": "text", "event": "ADD|UPDATE|DELETE|NONE"}],
    "relations": [...]}  # only if graph enabled
```

### The Two-Phase LLM Architecture

This is the conceptual heart of Mem0. Most memory systems treat storage as simple write operations. Mem0 treats storage as an intelligent decision-making problem.

**Phase 1 (Extraction):** "Given this conversation, what facts are worth remembering?"
**Phase 2 (Update):** "Given these new facts and what I already know, what should change?"

Phase 1 reduces a raw conversation (which may be noisy, repetitive, and long) to a short list of candidate atomic facts. Phase 2 compares those candidates against existing memory and decides whether each one is novel, redundant, contradictory, or an improvement. Both phases are LLM calls. Neither uses hard-coded rules. The complexity lives in the prompts.

### Data Structures

**A memory record** in the vector store [HIGH]:
```
{
  "id": "550e8400-e29b-41d4-a716-446655440000",  # UUID4
  "memory": "User prefers Python over JavaScript",  # the text
  "hash": "d41d8cd98f00b204e9800998ecf8427e",  # MD5 of content
  "user_id": "christian",
  "agent_id": null,
  "run_id": null,
  "metadata": {...},  # any custom metadata passed at add() time
  "created_at": "2026-01-15T10:30:00Z",
  "updated_at": "2026-01-15T10:30:00Z",
  "score": 0.87  # only present in search results
}
```

**A history record** in SQLite [HIGH]:
```
{
  "id": "uuid",
  "memory_id": "uuid",  # FK to vector store record
  "old_memory": "User likes Python",
  "new_memory": "User prefers Python over JavaScript",
  "event": "UPDATE",
  "created_at": "2026-01-15T10:30:00Z",
  "updated_at": "2026-01-15T10:30:00Z",
  "is_deleted": 0,
  "actor_id": "christian",
  "role": "user"
}
```

### The Three Storage Layers and Their Relationships

```
Vector Store (Qdrant, Pinecone, etc.)
  └── Stores: memory embeddings + metadata + full text
  └── Purpose: semantic search for retrieval and for update comparison
  └── Primary key: UUID

SQLite History Store (~/.mem0/history.db)
  └── Stores: full change log for every ADD/UPDATE/DELETE
  └── Purpose: audit trail, debugging, memory recovery
  └── NOT used for retrieval — write-only from retrieval's perspective

Graph Store (Neo4j, optional — Mem0g only)
  └── Stores: entity nodes + relationship edges
  └── Purpose: structured relational queries, temporal reasoning
  └── Runs in parallel with vector store operations
  └── Returns separate "relations" array in results
```

The three stores are not synchronized in a transactional sense. If a vector write succeeds and the SQLite write fails (or vice versa), there is no rollback. [MED — inferred from source structure, no explicit transaction wrapping found]

### The Memory Class

`Memory` (from `mem0/memory/main.py`) is the central entry point for OSS usage. It is a Python class, not a service. It holds:
- An LLM client instance (via LlmFactory)
- An embedder instance (via EmbedderFactory)
- A vector store instance (via VectorStoreFactory)
- An optional graph memory instance (MemoryGraph)
- An optional reranker instance (via RerankerFactory)
- A SQLiteManager instance

`AsyncMemory` mirrors it exactly but uses `asyncio.create_task()` for parallel graph and vector operations and `asyncio.to_thread()` for blocking I/O.

---

## 2. Memory Extraction Pipeline — Full Mechanism

### The Extraction Prompt

Three variants exist, selected based on whether `agent_id` is present and whether the message list contains assistant turns [HIGH]:

**FACT_RETRIEVAL_PROMPT** (generic, legacy) instructs the LLM to act as a "Personal Information Organizer" and extract into seven categories:
1. Personal preferences (food, hobbies, entertainment)
2. Important personal details (name, location, relationships)
3. Plans and intentions (future activities, goals)
4. Activity preferences (sports, travel, leisure)
5. Health and wellness information
6. Professional details (job, skills, domain)
7. Miscellaneous (anything not captured above)

Return format: `{"facts": ["fact1", "fact2", ...]}`

**USER_MEMORY_EXTRACTION_PROMPT** is the preferred modern variant for user-scoped memory. It adds a critical constraint: "GENERATE FACTS SOLELY BASED ON THE USER'S MESSAGES. DO NOT INCLUDE INFORMATION FROM ASSISTANT OR SYSTEM MESSAGES." This is stated twice and labeled as critical to prevent the model from extracting what the agent said as if it were user preference.

**AGENT_MEMORY_EXTRACTION_PROMPT** mirrors this for agent-scoped memory, but extracts from assistant messages only: the agent's preferences, capabilities, personality traits, knowledge areas, and approach to tasks.

### What "Salient Facts" Means in Practice

The prompts include few-shot examples that define the expected granularity. A salient fact is:
- Atomic: one claim per fact
- Durable: not tied to a specific moment ("User prefers Python" not "User is writing Python today")
- Personal: about the user or agent, not about the world
- Actionable: something that would change future responses

What does NOT get extracted (by design):
- Transient states ("User is tired today")
- General world knowledge ("Python was created by Guido van Rossum")
- Conversational filler
- Information from the wrong party (user prompts don't extract assistant claims)

What DOES get extracted incorrectly in practice (see Section 10, Production Audit):
- System prompt contents that repeat on every turn
- Heartbeat/cron messages from automated processes
- Tool execution results that get re-extracted as user facts

### Candidate Fact Format

After Phase 1, facts are a flat Python list of strings: `["User's name is Sarah", "Works at Acme Corp", "Having API integration issues with the payment module"]`. Each fact is a simple English declarative sentence. There is no metadata, confidence score, or source attribution at this stage.

`normalize_facts()` handles LLM variability — some models return `[{"fact": "..."}]`, others return `[{"text": "..."}]`, others return plain strings. The normalizer converts all formats to `["..."]`.

### inclusion_prompts and exclusion_prompts

As of v1.0.3 (January 2026), Mem0 Platform added `includes` and `excludes` parameters to the `client.add()` call [HIGH from changelog]. These modify extraction by appending to the extraction prompt:

```python
client.add(
    messages,
    user_id="athlete_001",
    includes="training routines, performance metrics, sports techniques"
)

client.add(
    messages,
    user_id="personal_assistant",
    excludes="financial details, personal identification information"
)
```

Mechanically, these strings are injected into the extraction prompt context as additional instructions. They do not filter post-extraction — they modify what the LLM extracts in Phase 1. [MED — mechanism inferred from documentation description]

For the OSS version, equivalent customization is via `custom_fact_extraction_prompt` in `MemoryConfig`, which completely replaces the default extraction prompt.

### memory_depth Parameter

Added in v1.0.3 as a project-level setting on the Platform [HIGH from changelog]. Controls how many recent messages are included in the extraction context window. The paper's configuration used m=10 messages. Higher depth means more context for extraction (better for long conversations) at higher token cost. This parameter is available via the Platform API project settings, not yet fully documented for OSS local config. [MED]

---

## 3. Memory Update Pipeline — Full Mechanism

### The ADD/UPDATE/DELETE/NOOP Decision

This is where Mem0's intelligence lives. The DEFAULT_UPDATE_MEMORY_PROMPT presents the LLM with:
1. A list of existing memories (ID + text) that were returned by semantic search
2. The new candidate fact(s) extracted from Phase 1

The LLM is told to compare and decide one of four tool calls for each fact [HIGH]:

**ADD**: The fact contains information not present in any existing memory. Generate a new UUID and store it. Example: existing memory contains "User likes pizza," new fact is "User has a dog named Rex" — these don't overlap, so ADD.

**UPDATE**: The fact is about the same subject as an existing memory but provides different or better information. Preserve the original ID. Include an `old_memory` field. Example: existing = "User likes to play cricket", new = "Loves to play cricket with friends on weekends" → UPDATE because the new version is more specific and doesn't contradict, it augments.

**DELETE**: The fact directly contradicts an existing memory. Example: existing = "User is vegetarian", new = "User had a steak for dinner" → DELETE the existing memory. The new contradicting fact is then ADDed.

**NONE** (NOOP): The fact is already adequately represented in existing memory. Example: existing = "User's name is John", new = "The user's name is John" → NONE. No duplicate is stored.

### What "UPDATE" Actually Does

UPDATE is a full replacement, not an append. The old memory text is replaced with new memory text. The old text is preserved in the SQLite history store's `old_memory` field. The UUID is preserved. The `updated_at` timestamp is refreshed. The `created_at` timestamp is not changed. The embedding is re-computed from the new text. [HIGH from source analysis]

This means there is no "memory grows over time by appending." Each memory is a single, current-state string. History is in SQLite, not in the memory itself.

### How Semantic Search Finds Comparison Candidates

Before calling the update LLM, Mem0 embeds each extracted fact and runs vector search against the existing memory store, filtered by the current session identifiers (user_id/agent_id/run_id). The top-s results (default s=10, per the paper) are retrieved. These become the "existing memories" context passed to the update LLM.

This means the update LLM only sees the 10 most semantically similar existing memories, not all memories. If a relevant memory is not in the top-10 by cosine similarity, it will not be considered for UPDATE or DELETE decisions. This is the main source of false ADD events (duplicates that slip through because they fall outside the similarity window). [HIGH — confirmed from paper's Algorithm 1 description]

### Conflict Resolution

When a new fact contradicts an old one, the expected behavior is:
1. The existing (contradicted) memory receives a DELETE action
2. The new (contradicting) fact receives an ADD action

Both operations happen in the same update cycle. The old memory is removed from the vector store. The new memory is inserted. Both events are logged in SQLite. [HIGH]

Conflict detection is probabilistic — it relies on the LLM recognizing contradiction from the update prompt examples. Hard negation ("User is NOT vegetarian") is more reliably caught than soft temporal contradiction ("User ate at McDonald's last Tuesday"). [MED — inferred from known LLM behavior patterns]

### The Deduplication Mechanism

Deduplication works via the NONE action: if a new fact is semantically equivalent to an existing memory, the LLM is supposed to call NOOP. The mechanism has two failure modes:

1. **Below similarity threshold:** If the duplicate is not retrieved by vector search (not in top-10), it gets ADDed as a new memory anyway.
2. **LLM discretion:** The LLM may judge two semantically similar but differently phrased facts as non-duplicates and ADD both.

There is no hash-based deduplication. The `hash` field stored on memory records (MD5 of content) is used for tracking purposes, not for blocking duplicate inserts at write time. [MED — hash field confirmed, dedup-blocking behavior inferred from code structure]

---

## 4. Storage Layer — Full Mechanism

### Vector Store Options

Mem0 supports 24+ vector database backends via a `VectorStoreFactory` with a registry pattern [HIGH]. All implement the same `VectorStoreBase` interface: `add`, `get`, `search`, `update`, `delete`. Provider selection is via a string in config.

**Primary production-grade options:**
- **Qdrant** (default): Supports local mode (file-based), server mode (Docker/cloud), and Qdrant Cloud. Configuration: `url`, `port`, `api_key`, `collection_name`. Indexed payload fields: `user_id`, `agent_id`, `run_id`, `actor_id`.
- **Pinecone**: Serverless and pod-based. Requires `api_key`, `index_name`, environment.
- **Chroma**: Local embedded (`persist_directory`) or server mode (`host`, `port`).
- **PGVector**: PostgreSQL extension. Supports HNSW and DiskANN indexing. Connection pooling and SSL.
- **Milvus**: Scalable, schema-flexible.
- **Redis/Valkey**: In-memory with vector search module.
- **MongoDB Atlas**: Document database with integrated vector search.
- **FAISS**: Local-only, no filtering support at vector level.
- **Weaviate**, **Elasticsearch**, **OpenSearch**, **Azure AI Search**, **Vertex AI Vector Search**, others.

For Velorin specifically: Qdrant is already planned and is Mem0's default — zero friction on integration.

### How Memories Are Embedded

Default embedder: OpenAI `text-embedding-3-small`, 1536 dimensions [HIGH].

The embedding is computed from the **memory text string** only — not including metadata like user_id or timestamps. Each memory fact gets one embedding vector. For UPDATE operations, the embedding is re-computed from the updated text. Embeddings are stored alongside the memory text and metadata in the vector store as the native vector payload.

TypeScript OSS mode auto-probes to detect embedding dimension if not specified. Python requires explicit specification for non-default embedders.

Supported embedder providers: OpenAI, HuggingFace, FastEmbed, Vertex AI, Ollama, Together, Google AI, and others.

### Metadata Stored Alongside Each Memory Vector

Every memory record in the vector store contains [HIGH]:
```
{
  "id": uuid_string,          # primary key
  "memory": text_string,      # the actual fact text
  "hash": md5_string,         # MD5 of memory text
  "user_id": string_or_null,
  "agent_id": string_or_null,
  "run_id": string_or_null,
  "actor_id": string_or_null, # from message "name" field
  "metadata": {},             # custom metadata passed by caller
  "created_at": iso_timestamp,
  "updated_at": iso_timestamp
}
```

Qdrant indexes `user_id`, `agent_id`, `run_id`, and `actor_id` as payload fields for efficient filtering.

### SQLite History Store

Located at `~/.mem0/history.db` by default (configurable via `history_db_path` in MemoryConfig) [HIGH].

Schema of the `history` table:

| Column | Type | Description |
|--------|------|-------------|
| id | TEXT | UUID for this history entry |
| memory_id | TEXT | FK to the memory record |
| old_memory | TEXT | Text before modification (null for ADD) |
| new_memory | TEXT | Text after modification (null for DELETE) |
| event | TEXT | ADD, UPDATE, or DELETE |
| created_at | DATETIME | When this change occurred |
| updated_at | DATETIME | Rarely updated post-insert |
| is_deleted | INTEGER | Soft-delete flag (0/1) |
| actor_id | TEXT | Who triggered this |
| role | TEXT | user/assistant/system |

Why it exists separately: The vector store is optimized for ANN search, not for temporal queries or change auditing. The SQLite store answers questions like "what did this memory contain six versions ago?" and provides recovery paths when memories are incorrectly deleted. It is also useful for debugging extraction quality (you can replay all ADD/UPDATE/DELETE decisions for a user session).

### Memory IDs

Memory IDs are UUID4 strings generated at creation time [HIGH, from `_create_memory()` source]. They are stable across UPDATEs — an updated memory keeps its original ID. This is by design: downstream systems that hold memory IDs do not break when a memory is refined.

The LLM can hallucinate integer IDs (e.g., "1", "2") when told to work with existing memories. The source code handles this explicitly: there is an integer-to-UUID mapping step that translates hallucinated short integers back to real UUIDs before executing operations. [HIGH from source analysis of the add() flow]

---

## 5. Retrieval — Full Mechanism

### The search() API

```python
results = memory.search(
    query,                    # string — the search query
    user_id=None,             # scope filter
    agent_id=None,            # scope filter
    run_id=None,              # scope filter
    limit=100,                # max results (default 100)
    filters=None,             # advanced filter dict
    threshold=None,           # minimum similarity score (0-1)
    rerank=True               # apply reranker if configured
)
```

At least one scope identifier is required. [HIGH]

### How Semantic Search Works at Retrieval Time

1. The query string is embedded using the same embedder as storage
2. An ANN (approximate nearest neighbor) search runs in the vector store
3. Results are filtered by user_id/agent_id/run_id metadata tags
4. Results are optionally filtered by `threshold` (minimum cosine similarity)
5. If a reranker is configured, results are reordered
6. Top `limit` results are returned

The vector store handles both the ANN search and the metadata filtering in a single query (using payload filters in Qdrant, `$where` in Chroma, etc.). There is no post-retrieval Python-side filtering of results. [MED]

### The Namespace Model

Mem0 uses four scope identifiers that define memory ownership and isolation [HIGH]:

- **user_id**: The human user. Memories scoped to a user_id are shared across all their sessions and agents.
- **agent_id**: The AI agent. Memories scoped only to an agent_id are agent-specific, not tied to a user.
- **run_id**: A single conversation or session. Scoped to one run.
- **app_id**: Application-level scope (Platform API only, for multi-app deployments).

These can be combined: `user_id="alice", agent_id="jiang", run_id="session_042"` stores a memory that belongs to all three namespaces and can be retrieved by any of those scopes.

When filtering by multiple identifiers, Mem0 applies AND logic between them (retrieve memories that match ALL specified filters). [MED]

### Advanced Filtering

The `filters` parameter supports structured queries with operators [HIGH]:
```python
filters={
    "AND": [
        {"user_id": {"eq": "alice"}},
        {"metadata.project": {"contains": "velorin"}}
    ]
}
```

Operators: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`, `in`, `nin`, `contains`, `icontains`, plus logical `AND`, `OR`, `NOT`.

### Reranking

An optional reranker stage re-orders the vector search results by relevance after ANN retrieval [HIGH]. Supported providers: Cohere, Sentence Transformers, Zero Entropy, LLM-based, HuggingFace. Configured via `RerankerConfig` in `MemoryConfig`. Reranking adds latency but improves ranking quality for cases where cosine similarity alone produces a poor ordering.

The graph memory search also uses BM25Okapi reranking (lexical overlap) to rerank graph results. [HIGH from graph_memory.py analysis]

### Return Format

```python
{
  "results": [
    {
      "id": "550e8400-...",
      "memory": "User prefers Python over JavaScript",
      "user_id": "christian",
      "agent_id": null,
      "hash": "...",
      "metadata": {},
      "created_at": "2026-01-15T10:30:00Z",
      "updated_at": "2026-01-15T10:30:00Z",
      "score": 0.87  # cosine similarity (0-1)
    }
  ],
  "relations": [...]  # only if graph_store enabled
}
```

---

## 6. Graph Memory (Mem0g) — Full Mechanism

### Architecture

Mem0g extends the base system with a directed labeled graph G=(V,E,L) where [HIGH from arxiv paper]:
- **V (nodes):** Entities — people, places, concepts. Each node has: `name` (string, lowercased+underscored), entity type label, `embedding` vector, `user_id`, `mentions` counter, `created` timestamp.
- **E (edges):** Relationships. Each edge has: source node, relationship type, destination node, `valid` boolean (soft-delete), `invalidated_at`, `mentions`, `created_at`, `updated_at`.
- **L (labels):** Semantic type assignments to nodes (e.g., `person`, `organization`, `project`).

### Entity Extraction

The `_retrieve_nodes_from_data()` method sends conversation text to an LLM with the `EXTRACT_ENTITIES_TOOL` definition [HIGH]. The LLM is instructed to extract all named entities and is told to use `{user_id}` as the reference for first-person pronouns ("I", "me", "my"). Extracted entity names are normalized to lowercase with underscores replacing spaces.

For providers supporting structured output (Azure OpenAI), `EXTRACT_ENTITIES_STRUCT_TOOL` is used instead.

### Relationship Extraction

`_establish_nodes_relations_from_data()` uses `EXTRACT_RELATIONS_PROMPT` [HIGH]. The LLM receives:
- The original conversation text
- The list of extracted entity names
- The user context (user_id, agent_id, run_id)
- Optional custom prompt additions

The LLM returns relationship triplets: `(source_entity, relationship_type, destination_entity)`. These become directed edges in Neo4j.

### Neo4j Schema

**Node creation (Cypher MERGE pattern):**
```cypher
MERGE (n:__Entity__ {name: $name, user_id: $user_id})
ON CREATE SET n.created = datetime(), n.mentions = 1
ON MATCH SET n.mentions = n.mentions + 1
SET n.embedding = $embedding
```

**Relationship creation:** Four MERGE scenarios handle all combinations of whether source/destination nodes already exist. The relationship type becomes a dynamic Cypher relationship label.

**Conflict detection:** When a new relationship is extracted that contradicts an existing one (e.g., new relationship says "works_at: Google" but existing says "works_at: OpenAI"), the old relationship is soft-deleted: `SET r.valid = false, r.invalidated_at = datetime()`. The new relationship is then inserted. Soft deletion preserves temporal history. [HIGH]

**Indexes:** `user_id` single index; `(name, user_id)` composite index for Enterprise Neo4j. [HIGH]

### Integration with Vector Memory

Graph and vector operations run **in parallel** during `add()` via `asyncio.create_task()` in `AsyncMemory`. In synchronous `Memory`, they run sequentially. [HIGH]

They do **not** share data — the graph extracts entities+relationships independently of the vector store extracting atomic facts. The same conversation text goes to both pipelines simultaneously.

During `search()`, graph results are returned in a separate `"relations"` array, not merged into the main `"results"`. Callers must explicitly use both arrays if they want hybrid retrieval. Vector similarity determines result ordering; graph does not rerank the vector results. [HIGH from docs]

### When Graph Memory Helps vs Hurts: The Benchmark Data

From LOCOMO benchmark (arxiv:2504.19413, Table 1) [HIGH]:

| Metric | Mem0 | Mem0g | Delta |
|--------|------|-------|-------|
| Single-Hop F1 | 38.72 | 38.09 | -0.63 |
| Single-Hop J | 67.13 | 65.71 | -1.42 |
| Multi-Hop F1 | 28.64 | 24.32 | -4.32 |
| Multi-Hop J | 51.15 | 47.19 | -3.96 |
| Open-Domain J | 72.93 | 75.71 | +2.78 |
| Temporal J | 55.51 | 58.13 | +2.62 |

**Interpretation:** Graph memory helps for open-domain questions (+2.78 J) and temporal questions (+2.62 J), where explicit relationship edges and timestamps aid reasoning. It **hurts** for single-hop retrieval and significantly hurts multi-hop reasoning (-4.32 F1, -3.96 J). The paper attributes multi-hop degradation to "overhead or redundancy when navigating more intricate graph structures." Graph memory also doubles token consumption (14k vs 7k tokens per conversation) and increases p95 latency from 1.44s to slightly higher due to graph query overhead.

**Practical implication:** Enable graph memory only when temporal tracking or cross-entity relationship queries are the primary use case. For general conversational memory, base Mem0 outperforms Mem0g on most dimensions.

---

## 7. The API / SDK

### Python SDK: Memory() Constructor

```python
from mem0 import Memory

# Minimal (uses OpenAI defaults)
m = Memory()

# Full config via dict
config = {
    "llm": {
        "provider": "openai",
        "config": {
            "model": "gpt-4.1-nano-2025-04-14",
            "temperature": 0.1,
            "max_tokens": 2000
        }
    },
    "embedder": {
        "provider": "openai",
        "config": {
            "model": "text-embedding-3-small"
        }
    },
    "vector_store": {
        "provider": "qdrant",
        "config": {
            "collection_name": "velorin_memories",
            "url": "http://localhost:6333"
        }
    },
    "history_db_path": "/path/to/history.db",
    "custom_fact_extraction_prompt": None,
    "custom_update_memory_prompt": None,
    "version": "v1.1"
}
m = Memory.from_config(config)
```

### add() Method

```python
result = m.add(
    messages,              # str | dict | list[dict] — the conversation
    user_id=None,          # str — at least one scope ID required
    agent_id=None,         # str
    run_id=None,           # str
    metadata=None,         # dict — custom metadata stored with memories
    infer=True,            # bool — False skips LLM pipeline entirely
    memory_type=None,      # str — "procedural_memory" for a special mode
    prompt=None            # str — one-time override for extraction prompt
)
# Returns: {"results": [{id, memory, event, ...}], "relations": [...]}
```

### search() Method

```python
results = m.search(
    query,                 # str
    user_id=None,          # str
    agent_id=None,         # str
    run_id=None,           # str
    limit=100,             # int
    filters=None,          # dict — advanced filter syntax
    threshold=None,        # float — min similarity (0-1)
    rerank=True            # bool — if reranker configured
)
# Returns: {"results": [{id, memory, score, ...}], "relations": [...]}
```

### get() and get_all()

```python
# Single memory by ID
memory = m.get(memory_id)
# Returns: single memory dict

# All memories for a scope
all_memories = m.get_all(user_id="christian", limit=500)
# Returns: {"results": [list of all memories without similarity scoring]}
```

`get_all()` does not use semantic search — it returns all memories for the specified scope, paginated. No embedding is generated for the query. [HIGH]

### delete() and delete_all()

```python
# Delete single memory
m.delete(memory_id)
# Removes from vector store, logs DELETE event in SQLite

# Delete all memories for a scope
m.delete_all(user_id="christian")
# Or with graph: also wipes graph nodes/relationships for that scope
# As of v1.0.10: Memory.reset() integrates graph database reset
```

Deletion from the vector store is permanent. The SQLite history log records the deletion event and preserves the old memory text. [HIGH]

### history()

```python
history = m.history(memory_id)
# Returns: list of all change events for this memory ID
# [{id, memory_id, old_memory, new_memory, event, created_at, ...}]
```

### AsyncMemory

```python
from mem0 import AsyncMemory

m = AsyncMemory()
result = await m.add(messages, user_id="christian")
results = await m.search(query, user_id="christian")
```

Differences from synchronous Memory:
- `add()` runs graph and vector operations with `asyncio.create_task()` (true parallelism)
- Blocking operations (embeddings, vector store I/O) wrapped in `asyncio.to_thread()`
- All public methods are coroutines
- Configuration is identical to synchronous Memory [HIGH]

### REST API

Two variants exist:

**Self-hosted OSS server** (from `server/` in the repo):
- Base URL: `http://localhost:8888` (Docker) or `http://localhost:8000` (uvicorn)
- No `/v1/` prefix on paths
- Authentication: optional `X-API-Key` header if `ADMIN_API_KEY` env var is set
- OpenAPI docs at `/docs`
- Key endpoints: `POST /memories`, `GET /memories`, `POST /search`, `GET /memories/{id}`, `PUT /memories/{id}`, `DELETE /memories/{id}`, `GET /memories/{id}/history`, `POST /configure`, `POST /reset`

**Hosted Platform API** (api.mem0.ai):
- Uses `/v1/` and `/v2/` prefixes
- Auth: `Authorization: Token <api-key>` header
- Additional endpoints: webhooks, exports, entities, batch operations, events
- `POST /v1/memories/` — add
- `POST /v2/memories/search/` — semantic search
- `POST /v2/memories/` — get all (paginated)
- `GET /v1/memories/{memory_id}/` — get single
- `PUT /v1/memories/{memory_id}/` — update
- `DELETE /v1/memories/{memory_id}/` — delete
- `GET /v1/memories/{memory_id}/history/` — history
- `DELETE /v1/memories/` — delete all for scope
- `PUT /v1/batch/` / `DELETE /v1/batch/` — batch operations

---

## 8. Configuration

### MemoryConfig Fields (Complete)

```python
from mem0.configs.base import MemoryConfig

config = MemoryConfig(
    llm=LlmConfig(
        provider="openai",        # openai|anthropic|ollama|groq|litellm|bedrock|...
        config={
            "model": "gpt-4.1-nano-2025-04-14",  # default
            "temperature": 0.1,
            "max_tokens": 2000,
            "api_key": "...",
            "reasoning_effort": "low"  # for o1/o3 models, added v1.0.9
        }
    ),
    embedder=EmbedderConfig(
        provider="openai",        # openai|huggingface|fastembed|vertex_ai|ollama|together|google_ai|...
        config={
            "model": "text-embedding-3-small",  # default
            "embedding_dims": 1536
        }
    ),
    vector_store=VectorStoreConfig(
        provider="qdrant",        # qdrant|pinecone|chroma|pgvector|milvus|faiss|redis|valkey|mongodb|...
        config={
            "collection_name": "mem0",
            "url": "http://localhost:6333",  # for server mode
            "port": 6333,
            "api_key": None,               # for Qdrant Cloud
            # path="/tmp/qdrant"           # for local mode
        }
    ),
    graph_store=GraphStoreConfig(
        provider="neo4j",         # neo4j|memgraph|kuzu|neptune|apache_age
        config={
            "url": "neo4j+s://<instance>",
            "username": "neo4j",
            "password": "...",
            "database": "neo4j"
        },
        custom_prompt=None,       # override entity/relationship extraction prompt
        threshold=0.75            # min confidence for graph edges
    ),
    reranker=None,                # or RerankerConfig(provider="cohere", config={...})
    history_db_path="~/.mem0/history.db",
    version="v1.1",               # "v1.0" legacy or "v1.1" current
    custom_fact_extraction_prompt=None,
    custom_update_memory_prompt=None
)
```

### LLM Provider Notes

Default model is `gpt-4.1-nano-2025-04-14` [HIGH from changelog]. Any OpenAI-compatible model works. For Anthropic: `{"provider": "anthropic", "config": {"model": "claude-sonnet-4-6"}}`. For local: `{"provider": "ollama", "config": {"model": "llama3.1:8b"}}`.

Important: Model quality directly impacts extraction quality. Smaller models (gemma2:2b, llama3.1:8b) follow extraction prompts less reliably, producing more hallucinations and false extractions. Claude Sonnet/GPT-4 class models follow the prompts much more accurately — but "a better model follows the extraction prompt more faithfully, which means it extracts more indiscriminately" (from production audit). Prompt quality becomes the bottleneck, not model capability.

### Embedder Notes

1536-dimension default (text-embedding-3-small). If switching embedders, you must either re-embed all existing memories or maintain separate collections per embedder. Mixing embeddings from different models in one collection produces garbage retrieval. [HIGH — architectural constraint]

### Graph Store Configuration

Graph store is entirely optional. Omitting `graph_store` from config disables graph memory entirely. The `threshold` parameter (default 0.75) filters low-confidence relationship edges — raising it to 0.9 produces a sparser but higher-quality graph. Custom prompts allow domain-specific entity scoping (e.g., "only extract software entities, never extract person names").

---

## 9. Code Examples

### Basic Setup and First Memory Add

```python
from mem0 import Memory

config = {
    "llm": {
        "provider": "anthropic",
        "config": {
            "model": "claude-sonnet-4-6",
            "temperature": 0.1
        }
    },
    "embedder": {
        "provider": "openai",
        "config": {"model": "text-embedding-3-small"}
    },
    "vector_store": {
        "provider": "qdrant",
        "config": {
            "collection_name": "agent_memories",
            "url": "http://localhost:6333"
        }
    },
    "history_db_path": "/data/mem0_history.db"
}

m = Memory.from_config(config)

# Add a conversation
messages = [
    {"role": "user", "content": "My name is Christian. I'm building an agent system called Velorin."},
    {"role": "assistant", "content": "Understood. What's your primary use case for Velorin?"},
    {"role": "user", "content": "I need agents that remember context across sessions. I hate starting from scratch every time."}
]

result = m.add(messages, user_id="christian_taylor")
# Returns:
# {"results": [
#   {"id": "uuid1", "memory": "User's name is Christian", "event": "ADD"},
#   {"id": "uuid2", "memory": "Building an agent system called Velorin", "event": "ADD"},
#   {"id": "uuid3", "memory": "Needs agents with persistent cross-session memory", "event": "ADD"},
#   {"id": "uuid4", "memory": "Dislikes losing context between sessions", "event": "ADD"}
# ]}
```

### Custom Extraction with Inclusion/Exclusion Prompts

```python
# OSS: full prompt replacement
TECHNICAL_EXTRACTION_PROMPT = """
You are a technical preference extractor for an AI agent system.
Extract ONLY: programming languages, tools, frameworks, architectural preferences,
and explicit technical opinions from USER messages.
DO NOT extract: social information, personal details, or general sentiments.
Return JSON: {"facts": ["technical fact 1", "technical fact 2"]}

Input: {messages}
"""

config_with_custom = {
    **config,
    "custom_fact_extraction_prompt": TECHNICAL_EXTRACTION_PROMPT
}

m_technical = Memory.from_config(config_with_custom)

# Platform API: per-request inclusion
from mem0 import MemoryClient

client = MemoryClient(api_key="m0-...")
client.add(
    messages,
    user_id="christian_taylor",
    includes="architectural decisions, technology preferences, agent system requirements",
    excludes="personal names, contact information, financial details"
)
```

### Retrieval with Filtering

```python
# Basic semantic search
results = m.search(
    "What does the user think about Python?",
    user_id="christian_taylor",
    limit=5,
    threshold=0.7
)

# Advanced filtering: memories created after a date AND tagged with specific metadata
results = m.search(
    "agent architecture preferences",
    user_id="christian_taylor",
    filters={
        "AND": [
            {"user_id": {"eq": "christian_taylor"}},
            {"metadata.session": {"contains": "architecture"}}
        ]
    },
    limit=10
)

# Get all memories for an agent (no semantic scoring)
all_jiang_memories = m.get_all(agent_id="jiang", limit=1000)

# Retrieve with history for a specific memory
history = m.history("550e8400-e29b-41d4-a716-446655440000")
```

### Full Agent Loop That Reads and Writes Memory

```python
from mem0 import Memory
import anthropic

m = Memory.from_config(config)
client = anthropic.Anthropic()

def run_agent_turn(user_message: str, user_id: str, conversation_history: list) -> str:
    # 1. Retrieve relevant memories before responding
    memories = m.search(user_message, user_id=user_id, limit=10, threshold=0.6)

    # 2. Format memories as context
    memory_context = ""
    if memories["results"]:
        memory_context = "Relevant memories about this user:\n"
        for mem in memories["results"]:
            memory_context += f"- {mem['memory']}\n"

    # 3. Build messages with memory context
    system_prompt = f"""You are a helpful assistant with persistent memory.
{memory_context}
Use the memories above to personalize your response, but do not explicitly
mention that you are reading from a memory system."""

    messages = conversation_history + [{"role": "user", "content": user_message}]

    # 4. Get response from LLM
    response = client.messages.create(
        model="claude-sonnet-4-6",
        max_tokens=1024,
        system=system_prompt,
        messages=messages
    )
    assistant_message = response.content[0].text

    # 5. Store the interaction in memory
    interaction = [
        {"role": "user", "content": user_message},
        {"role": "assistant", "content": assistant_message}
    ]
    m.add(interaction, user_id=user_id)

    return assistant_message

# Usage
history = []
response = run_agent_turn("I prefer dark mode in all my editors.", "christian_taylor", history)
history.append({"role": "user", "content": "I prefer dark mode in all my editors."})
history.append({"role": "assistant", "content": response})

# On next session — history is empty but memories persist
response2 = run_agent_turn("Set up my new IDE.", "christian_taylor", [])
# Agent will retrieve the dark mode preference and include it without being told
```

### Graph Memory Configuration

```python
config_with_graph = {
    **config,
    "graph_store": {
        "provider": "neo4j",
        "config": {
            "url": "bolt://localhost:7687",
            "username": "neo4j",
            "password": "password"
        },
        "custom_prompt": "Only extract: agents, projects, tools, and their relationships. Never extract personal names.",
        "threshold": 0.8  # high threshold = fewer but more reliable edges
    }
}

m_graph = Memory.from_config(config_with_graph)
result = m_graph.add(messages, user_id="christian_taylor")

# result["relations"] now contains graph edges:
# [{"source": "christian_taylor", "relationship": "builds", "destination": "velorin", ...}]

# Search returns both
results = m_graph.search("what is christian building?", user_id="christian_taylor")
# results["results"] = vector memories
# results["relations"] = graph triplets
```

---

## 10. Can We Recreate It?

### The Extraction + Update LLM Pipeline — How Hard?

**Difficulty: Medium. Time: 2-3 days.**

The pipeline is conceptually simple: two sequential LLM calls with structured output. Phase 1 extracts facts. Phase 2 decides actions. The prompts are the hard part — they require careful few-shot examples to produce consistent JSON output, and they degrade significantly with smaller models.

What makes it non-trivial: the `normalize_facts()` robustness handling (every LLM formats JSON slightly differently), the integer hallucination mapping for memory IDs, and the tooling to turn LLM tool-call responses into concrete vector store operations.

**What you get if you build it yourself:** Complete control over the extraction logic — you can add a REJECT action, you can add confidence scoring, you can add feedback loop prevention (marking recalled memories so they are not re-extracted). Mem0's fixed prompt is the source of most production failures.

### The ADD/UPDATE/DELETE/NOOP Decision Logic — Clever Prompt or Sophisticated Logic?

**It is a prompt.** The decision logic is entirely in `DEFAULT_UPDATE_MEMORY_PROMPT`. There is no rule-based heuristic, no embedding distance threshold for "close enough to be a duplicate," no semantic entailment check. The LLM reads existing memories + new fact and decides. [HIGH]

This is simultaneously Mem0's greatest strength (flexible, handles edge cases) and its greatest weakness (depends entirely on LLM judgment, inconsistent with smaller models, can be confused by ambiguous facts).

The implication: you can build this yourself with ~50 lines of Python + a good prompt. The hard part is prompt engineering the edge cases (temporal facts, soft contradictions, near-duplicates).

### The Deduplication Mechanism — What Makes It Hard?

The deduplication depends on two things: (1) the semantic search retrieving the near-duplicate in the top-10 results, and (2) the LLM recognizing the near-duplicate as such. Both fail in practice.

**The real hard problem:** What counts as a duplicate? "User likes Python" and "User prefers Python for backend work" — are these the same memory or two distinct ones? This is a judgment call, and different LLMs answer differently. Building a consistent dedup mechanism requires either a separate similarity threshold check (if cosine similarity > 0.95, call NONE) or a separate LLM call specifically for dedup, neither of which Mem0 currently implements.

### Which Parts Are Novel vs Wrappers Around Standard Patterns?

**Genuinely novel or well-executed:**
- The two-phase pipeline architecture applied specifically to memory (extraction then update-decision)
- The four-action AUDN framework and its prompt engineering
- The soft-delete pattern for graph relationships preserving temporal history
- The namespace model (user_id + agent_id + run_id) for multi-tenant multi-agent scoping
- The memory ID stability across updates (downstream consumers don't break)

**Wrappers around standard patterns:**
- The vector store abstraction: standard VectorStoreBase pattern, nothing novel
- The graph extraction: standard NLP entity+relation extraction, just wired to Neo4j
- The SQLite history log: a standard audit trail
- The embedding pipeline: standard OpenAI embedding call

**Honestly, the core mechanism** (two LLM calls + vector search + four actions) is implementable in under 200 lines of Python. The 47,000 lines in the mem0 repository are predominantly provider integrations, edge case handling, async variants, TypeScript SDK, documentation, and telemetry.

### Estimate: How Long to Build a Functional Equivalent from Scratch?

| Component | Time |
|-----------|------|
| Extraction prompt + Phase 1 LLM call | 1 day |
| Update prompt + Phase 2 LLM call + 4 actions | 1-2 days |
| Qdrant vector store integration | 0.5 days |
| SQLite history log | 0.5 days |
| search() with filtering | 0.5 days |
| Namespace model (user/agent/run scoping) | 0.5 days |
| Edge case handling (normalize_facts, integer ID mapping) | 1 day |
| **Total: Functional equivalent** | **5-6 days** |
| Production hardening (async, error handling, telemetry) | +3-5 days |
| Graph memory (optional) | +3-4 days |
| Full provider matrix (24 vector stores, etc.) | Not worth it — use Mem0's code |

A functional equivalent that handles your actual use cases (not 24 vector store backends) is roughly a week of focused work. The question is whether to build it or adapt Mem0 directly.

---

## 11. How To Incorporate Into Velorin

### The Core Question

Velorin already has a custom memory system: the Velorin Brain — a neural file graph of markdown neurons with rated pointers, stored in GitHub, accessed by agents. The question is not "should we use Mem0 instead?" The question is "does Mem0 solve problems the Brain doesn't, and if so, which specific mechanisms should we adopt?"

### What the Brain Does That Mem0 Doesn't

The Brain is a **curated, architect-designed knowledge graph**. Neurons are written deliberately. Pointers are rated. Knowledge is organized into regions and areas. It encodes reasoning chains, architectural decisions, and relationships that would be mangled by automatic extraction. Mem0's extraction pipeline cannot write neurons to the Brain — it lacks the curation layer, the pointer rating logic, and the architectural judgment of the Chairman.

The Brain is the right tool for **durable, high-value knowledge** that warrants curation.

### What Mem0 Solves That the Brain Doesn't

The Brain is not designed for **high-volume, low-curation ephemeral facts** that arise during agent sessions:
- "Jiang noted that the API rate limit was hit at 15:42 during session 023"
- "Alexander confirmed the Postgres schema change was committed"
- "User expressed frustration with the current onboarding flow"
- "MarcusAurelius detected a contradiction in the agent config at boot"

These are session-level facts that are worth remembering for days or weeks but don't merit a Brain neuron. The Brain would bloat with them. Mem0's extraction-to-vector pipeline is exactly right for this tier.

### Recommended Architecture: Two-Tier Memory

```
Tier 1: Velorin Brain (GitHub, markdown neurons)
  - Curated, architect-level knowledge
  - Architectural decisions, agent configs, deep context
  - Human-in-the-loop curation
  - Write path: deliberate neuron creation only

Tier 2: Mem0 Vector Store (Qdrant, already planned)
  - Automatic extraction from agent sessions
  - High-volume ephemeral and semi-durable facts
  - Per-agent and per-user namespacing
  - Write path: automatic via Mem0 extraction pipeline
```

Agents query both tiers. Brain provides architectural context. Mem0 provides conversational context. When a Mem0 fact proves durable and important, a human (or agent with permission) promotes it to a Brain neuron.

### Specific Recommendations for Velorin Components

**1. Adopt Mem0's extraction pipeline with a custom extraction prompt.**

The default FACT_RETRIEVAL_PROMPT will extract noise. Write a Velorin-specific extraction prompt that:
- Extracts agent actions, decisions, and confirmations (not personality facts)
- Explicitly excludes system prompt content and boot-file content
- Marks facts with source: "stated by user" vs "agent observed" vs "tool result"
- Adds a REJECT action for content that should never be stored (heartbeat messages, cron triggers)

```python
VELORIN_EXTRACTION_PROMPT = """
You are a Velorin System Memory Extractor. Extract ONLY:
1. Decisions made by the user or agents (explicit commitments)
2. Technical findings discovered during agent work (confirmed facts, not hypotheses)
3. User preferences expressed in this session (stated directly by the user)
4. Cross-agent coordination facts (what agent X told agent Y)

DO NOT extract:
- Content from system prompts or boot files (these repeat every session)
- Heartbeat messages or automated cron triggers
- LLM tool results verbatim (summarize finding, not raw output)
- Anything prefixed with "Tool result:" or "System:"

Return JSON: {"facts": ["fact1", "fact2"]}
Messages: {messages}
"""
```

**2. Adopt Mem0's namespace model directly.**

Map Velorin namespaces to Mem0 namespaces:
- `user_id` → `christian_taylor` (the Chairman)
- `agent_id` → `jiang` | `marcus_aurelius` | `alexander` | `trey`
- `run_id` → session ID (e.g., `jiang_session_021`)

This gives you per-agent memory isolation while allowing shared user-level memories.

**3. Use Qdrant — already planned.**

Mem0's Qdrant integration is production-tested and the default backend. No changes needed to the Velorin Qdrant plan.

**4. Solve the session compaction problem with Mem0's add() + get_all().**

The current compaction/recovery problem (sessions that compact and lose state) can be partially addressed by:
- At start of each session: `m.get_all(agent_id="jiang", limit=200)` to inject recent agent memories into context
- At end of each session: `m.add(session_summary, agent_id="jiang", run_id=session_id)`
- The SQLite history log provides recovery from bad extractions

This does not replace TEAM_STATE.md for active team coordination, but supplements it with persistent factual context.

**5. Do NOT enable graph memory (Mem0g) for Velorin.**

Reasons:
- The Brain already provides the graph structure (with better curation)
- Mem0g underperforms on multi-hop reasoning (the primary Brain use case)
- Graph memory doubles token consumption
- The Brain's pointer-rating system is architecturally superior for the Velorin use case
- Neo4j adds infrastructure complexity for marginal benefit

**6. Consider building the extraction pipeline from scratch rather than installing mem0ai.**

Mem0 installs a heavy dependency tree. The core mechanism you need is approximately:

```python
# The minimum viable Velorin memory system (pseudocode structure)
class VelorinMemory:
    def __init__(self, qdrant_client, llm_client, embedder):
        self.qdrant = qdrant_client
        self.llm = llm_client
        self.embedder = embedder

    def add(self, messages, agent_id, user_id=None, run_id=None):
        # Phase 1: Extract facts
        facts = self._extract_facts(messages)

        # Phase 2: For each fact, decide action
        for fact in facts:
            similar = self._search_similar(fact, agent_id, user_id, run_id, limit=10)
            action = self._decide_action(fact, similar)
            self._execute_action(action, fact, agent_id, user_id, run_id)

    def _extract_facts(self, messages):
        # Call LLM with VELORIN_EXTRACTION_PROMPT
        # Return list of strings
        pass

    def _decide_action(self, fact, existing_memories):
        # Call LLM with update prompt showing existing + new
        # Return {"action": "ADD|UPDATE|DELETE|NONE", "memory_id": ..., "text": ...}
        pass

    def search(self, query, agent_id, user_id=None, limit=10):
        # Embed query, run Qdrant search with payload filters
        pass
```

This is ~300-400 lines including error handling. You get full control over prompts, actions, and integration with the Brain promotion path.

**7. The extraction feedback loop problem requires a custom solution.**

The production audit finding (97.8% junk from uncurated extraction) is the most important signal for Velorin. Solutions to implement:

- Tag recalled memories so the extraction prompt ignores them: when building the extraction context, mark memories already retrieved from Mem0 as `[RECALLED FROM MEMORY]` so they are not re-extracted as new facts
- Implement a quality gate: before storing, score each candidate fact on a 0-1 relevance scale via a quick LLM call; only store if score > threshold
- Add a `REJECT` action to the update prompt for clearly junk content
- Log rejection reasons for tuning

**8. Agent-specific memory collections.**

Each agent should have its own Qdrant collection (or use collection prefix). This prevents cross-contamination between agents' working knowledge:
- `velorin_jiang` — Jiang's extracted session memories
- `velorin_marcus` — MarcusAurelius working memory
- `velorin_user` — Chairman's preferences and decisions (shared by all agents)

### Is the Extraction Pipeline Worth Using, or Does Neuron-Curation Supersede It?

**They operate at different levels. Both are needed. Neither replaces the other.**

The extraction pipeline handles **volume and speed**: automatically capturing hundreds of session facts that would take a human operator hours to curate. These facts are lower quality and shorter-lived.

The neuron-curation approach handles **depth and durability**: each neuron is a deliberate artifact encoding reasoning chains, architectural principles, and cross-linked knowledge. These facts are higher quality and indefinitely persistent.

The mistake would be routing everything through one or the other. Route high-volume session facts to Mem0/extraction. Route architectural knowledge, agent principles, and important discoveries to Brain neurons. Build a promotion path for the rare Mem0 fact that warrants neuron-level treatment.

---

## Appendix A: Benchmark Summary

From arxiv:2504.19413, LOCOMO benchmark, all methods using gpt-4o-mini [HIGH]:

| Method | Overall J | p95 Latency | Tokens/Conv |
|--------|-----------|-------------|-------------|
| Mem0 | ~66.9% | 1.44s | 7k |
| Mem0g | ~68.0% | ~2.0s | 14k |
| OpenAI Memory | 52.9% | ~5s | ~15k |
| LangMem | ~62% | ~2s | ~10k |
| Zep | ~61% | ~3s | 600k+ |
| Best RAG | ~61% | ~3s | ~26k |
| Full Context | ~72.9% | 17.1s | 26k |

Key finding: Full context wins on accuracy (most information available) but is 12x slower. Mem0 achieves 92% of full-context quality at 8% of the latency. Zep is catastrophically token-inefficient (600k+ tokens per conversation).

---

## Appendix B: Known Failure Modes

1. **Feedback loop amplification:** Recalled memories re-extracted as new facts → exponential growth. Solution: mark recalled memories before extraction.

2. **Boot file extraction:** Static system prompts extracted as user preferences on every session. Solution: custom extraction prompt with explicit exclusions.

3. **Model-quality inversion:** Better models extract more accurately but also more indiscriminately. Quality depends on prompt, not model capability.

4. **Similarity window blindness:** Duplicates not in top-10 by cosine similarity bypass dedup. Solution: raise s parameter or add hash-based pre-dedup.

5. **Hallucinated facts from small models:** gemma2:2b and similar models fabricate user demographics not present in conversation. Solution: use GPT-4-class models for extraction, or add a grounding check.

6. **Transient state persistence:** "User is working on X" stored indefinitely even after completion. Solution: add explicit time-to-live fields or periodic review.

---

## References

- Mem0 arxiv paper: https://arxiv.org/abs/2504.19413
- Mem0 GitHub: https://github.com/mem0ai/mem0
- Mem0 documentation: https://docs.mem0.ai
- DeepWiki — Vector Store Providers: https://deepwiki.com/mem0ai/mem0/5.2-vector-store-providers
- DeepWiki — Memory Configuration: https://deepwiki.com/mem0ai/mem0/3.1-memory-configuration
- DeepWiki — History and Storage: https://deepwiki.com/mem0ai/mem0/3.3-history-and-storage-management
- DeepWiki — REST API Reference: https://deepwiki.com/mem0ai/mem0/7.2-rest-api-reference
- GitHub Issue #4573 (97.8% junk audit): https://github.com/mem0ai/mem0/issues/4573
- Mem0 Graph Memory docs: https://docs.mem0.ai/open-source/features/graph-memory
- Mem0 REST API docs: https://docs.mem0.ai/open-source/features/rest-api
- AI Memory Wars benchmark comparison: https://guptadeepak.com/the-ai-memory-wars-why-one-system-crushed-the-competition-and-its-not-openai/
- Mem0 research page: https://mem0.ai/research
- Mem0 changelog: https://docs.mem0.ai/changelog
