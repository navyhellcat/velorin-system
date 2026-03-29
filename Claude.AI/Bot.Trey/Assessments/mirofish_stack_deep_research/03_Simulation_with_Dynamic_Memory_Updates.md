# Simulation with Dynamic Memory Updates

## What MiroFish says it is doing

Its third workflow stage is:

- dual-platform parallel simulation
- automatic parsing of prediction requirements
- dynamic temporal memory updates

This is the engine room. This is where the world stops being static and starts evolving.

## What this means conceptually

A real simulation loop needs four things:

1. state
2. time
3. agents
4. memory

If agents do not update memory over time, the simulation collapses into disconnected one-shot turns.

Dynamic memory updates mean:
- agents remember what they experienced
- memory changes future behavior
- group memory accumulates at the population level
- the environment changes based on agent actions
- later steps are not reboots; they are continuations

## Reference architecture

The best-known small-scale template is **Generative Agents**:
- memory stream
- retrieval of relevant memories
- reflection into higher-level insights
- planning based on retrieved memory

The large-scale MiroFish side seems to combine that idea with:
- Zep-style memory management
- OASIS-style scalable environment and action loops
- GraphRAG-generated structure from the initial corpus

## What “dynamic temporal memory” should mean in practice

### Agent memory
The agent stores:
- observations
- interactions
- inferred beliefs
- emotional/priority markers
- commitments
- outcomes of previous actions

### Group memory
The system stores:
- trending narratives
- institution-level state
- faction-level priors
- public events
- emergent norms

### Temporal updates
Memory is not just appended. It is:
- timestamped
- prioritized
- summarized
- pruned or compressed
- re-used differently over time

## Why memory is the hard part

Most multi-agent demos fail because memory is treated as:
- a chat transcript
- a vector lookup
- a dumping ground

That is not enough.

Good simulation memory needs:
- recency
- relevance
- abstraction
- temporal ordering
- write rules
- read rules
- decay or compression

If you do not manage these, the agents either:
- forget too much
- remember everything badly
- become repetitive
- become unstable

## How this likely works in MiroFish

Probable loop:

1. initialize environment state
2. initialize agents with persona + prior memory
3. parse the prediction objective
4. choose active agents / visible context for the current tick
5. each agent retrieves relevant memory
6. each agent acts
7. environment updates
8. memory writes occur at:
   - agent level
   - social / group level
9. summaries or reflections are generated periodically
10. next tick starts from the updated state

## Role of Zep here

MiroFish explicitly recommends Zep Cloud.

That strongly suggests:
- persistent long-term memory
- structured or graph-backed memory retrieval
- temporal reasoning support
- offloading memory storage and retrieval complexity

Zep is not the simulator itself. It is the memory substrate or memory service.

## Role of OASIS here

OASIS gives the scalable simulation structure:
- environment server
- recommendation / feed logic
- agent module
- time engine
- scalable inferencer

That means MiroFish probably uses OASIS to manage large-scale simulation flow while using Zep to manage memory persistence and retrieval.

## Where to get it

This layer is assembled from multiple parts:

- MiroFish for the application architecture
- Generative Agents for the core behavioral memory logic
- Zep Cloud for memory API / graph memory patterns
- OASIS for the large-scale simulation framework

## ChatGPT integration path

There is no direct native feature for this.

### Correct path
Build MCP tools exposing operations like:
- `run_simulation_tick`
- `get_agent_memory`
- `get_group_memory`
- `inject_event`
- `advance_time`
- `retrieve_relevant_memories`

Then package into a ChatGPT app.

### Weak path
Upload reports and ask ChatGPT to summarize them. Useful after simulation, not for operating the engine.

## Anthropic / Claude integration path

### Best path
Remote MCP server or Claude Code MCP tools.

Useful tool surface:
- launch / stop simulation
- inspect memory state
- inspect environment state
- replay events
- compare scenario branches

### Useful addition
Claude Skill to standardize:
- memory write policy
- compression policy
- simulation QA
- evaluation rubric

## Velorin relevance

This is directly relevant if Velorin ever wants:

- strategic scenario replay
- company-memory-driven simulation
- customer-behavior mock ecosystems
- market narrative spread modeling
- political reaction mapping
- personal operating system “what-if” simulations

## Failure modes

- memory grows without compression
- no distinction between memory types
- retrieval returns noise
- every agent remembers the same things
- reflections become self-reinforcing hallucinations
- time step granularity is wrong
- dynamic updates corrupt causality

## Design recommendation

Treat memory as three layers:

1. episodic memory  
   specific events and interactions

2. semantic / abstracted memory  
   distilled beliefs, patterns, identities, relationship summaries

3. world memory  
   evolving external state, trends, institutions, events

That separation makes simulation much more stable.

## Decision

Dynamic memory updates are one of the load-bearing reasons MiroFish is interesting. Without them, this would be a fancy reporting workflow. With them, it becomes a stateful population simulator.

## Sources

- MiroFish README workflow
- Google Research / Stanford Generative Agents
- Zep Memory docs
- OASIS paper and repo
