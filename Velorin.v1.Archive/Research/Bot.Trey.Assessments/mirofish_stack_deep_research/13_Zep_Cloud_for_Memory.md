# Zep Cloud for Memory

## What MiroFish says

MiroFish explicitly asks for:
- `ZEP_API_KEY`
- Zep Cloud
- notes that the free monthly quota is enough for simple usage

That is very strong evidence that Zep is not optional in their default memory flow.

## What Zep is

Zep is a memory / context-engineering platform for AI agents. Its docs emphasize:
- agent memory
- temporal knowledge graphs
- high-level Memory API
- lower-level Graph API
- SDKs for Python, TypeScript, and Go

In practical terms, Zep is trying to solve a hard agent problem:
**how do you remember relevant things over time without shoving raw transcripts into prompts forever?**

## Why it fits a simulation stack

A simulator with many agents needs:
- persistent memory
- retrieval by relevance and time
- structured memory relationships
- compression / abstraction
- easy API access

Zep fits that shape better than a plain vector store alone.

## Memory modes

### High-level Memory API
Fastest path for:
- storing memories
- retrieving memories
- immediate use in an LLM call

### Lower-level Graph API
More flexible if you need:
- custom memory schemas
- graph-level inspection
- more specialized memory engineering

## Why Zep is attractive for MiroFish

### 1. It externalizes memory complexity
The simulation team does not need to invent every memory primitive from scratch.

### 2. It supports temporal logic
That is important when:
- order matters
- beliefs evolve
- interactions accumulate over time

### 3. It fits multi-agent systems
You can model per-agent memory and possibly shared / structured memory patterns.

## Likely MiroFish usage

Most likely:
- store episodic or semantic memory per agent
- retrieve relevant memories before action generation
- update memory after actions or interactions
- possibly support world-level or group-level memory structures

## Where to get it

- Website: `https://www.getzep.com/`
- Docs: `https://help.getzep.com/`
- App: `https://app.getzep.com/`

## ChatGPT integration path

There is no native “Zep connector” in ChatGPT by default.

Real options:

### Option A — your backend uses Zep
Best path. Keep Zep behind your service boundary. ChatGPT calls your tools, not Zep directly.

### Option B — expose memory tools through MCP
Examples:
- `store_memory`
- `retrieve_memory`
- `get_agent_memory`
- `get_world_memory`

### Option C — direct custom app integration
Possible, but usually less clean than wrapping Zep inside your own domain backend.

## Anthropic / Claude integration path

Same logic.

Best pattern:
- backend or MCP server talks to Zep
- Claude talks to backend or MCP tools

Useful additions:
- Claude Skill for memory policy and QA
- Claude Code for local development against memory services

## Velorin relevance

This is one of the most directly relevant tools in the whole list.

Velorin’s internal issue is not just “more memory.” It is:
- better structured memory
- retrieval at the right level
- temporal continuity
- cross-domain relationship mapping
- agent-specific memory discipline

Zep is directly relevant to that problem class.

## Risks

- confusing memory storage with memory quality
- writing low-signal junk memories
- no memory schema
- retrieval with no ranking discipline
- no distinction between episodic / semantic / world memory

## Recommended Velorin stance

If Velorin explores Zep, do not start with “store everything.”

Start with a schema:
- person / agent memory
- project memory
- decision memory
- event memory
- relationship memory
- domain summary memory

Then build retrieval rules.

## Decision

Zep Cloud is one of the most operationally valuable components in the MiroFish stack because it tackles one of the hardest agent problems directly. It is not the only way to do memory, but it is a serious, purpose-built option.

## Sources

- MiroFish README env vars
- Zep overview docs
- Zep Memory API docs
