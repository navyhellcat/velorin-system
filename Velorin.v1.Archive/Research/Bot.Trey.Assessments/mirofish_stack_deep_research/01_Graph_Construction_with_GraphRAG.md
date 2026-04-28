# Graph Construction with GraphRAG

## Why this exists in the MiroFish stack

MiroFish states that its first workflow stage is **“seed extraction & individual/collective memory injection & GraphRAG construction.”** That is the front-end of the simulator’s world-building layer. The job is not “search documents.” The job is to convert seed material into a structured world model.

In plain terms:

- seed inputs = reports, news, policy drafts, stories, or other starting material
- GraphRAG = the structure that turns those inputs into entities, relations, communities, summaries, and retrievable context
- the simulation then uses that graph as the substrate for agents, environment state, and report generation

## What GraphRAG actually is

Microsoft’s GraphRAG is a **graph-based retrieval and indexing system** that extracts structured data from unstructured text, builds a knowledge graph, groups it into communities, summarizes those communities, and then uses those structures at query time.

That matters because naive vector RAG is weak on “global” questions:

- “What are the major themes?”
- “Who are the most important actors?”
- “What factions, coalitions, or narrative clusters exist?”
- “How does the overall structure of the corpus fit together?”

GraphRAG is stronger than plain chunk retrieval when the question is not local.

## Core mechanics

### 1. Extraction

The indexer runs over raw text and tries to extract:

- entities
- relationships
- claims / events / descriptions
- supporting passages or chunks

### 2. Graph assembly

Those extractions are assembled into a graph:
- nodes = entities / concepts / sometimes communities
- edges = relationships / interactions / dependencies

### 3. Community detection

The graph is clustered into communities or subgraphs. This is where GraphRAG stops being “vector search with extra steps.” It creates a hierarchy of social, topical, or causal neighborhoods.

### 4. Community summaries

Each community is summarized. This creates a compressed representation of a large corpus that is better suited for “global” reasoning.

### 5. Query-time retrieval

At question time, the system can use:
- local graph neighborhoods
- community summaries
- entity embeddings
- source text chunks

This lets a system answer both:
- local questions (“What did actor X say about issue Y?”)
- global questions (“What are the major themes across the whole corpus?”)

## What MiroFish is likely doing with it

The MiroFish repo does not publish a full architecture whitepaper, so this section is partly inference from the stated workflow.

Most likely flow:

1. ingest seed documents
2. run extraction over people, organizations, topics, policies, signals, events
3. merge those into a graph
4. attach memory objects at both individual and collective levels
5. use the graph to:
   - create personas
   - determine relationships
   - build the simulation environment
   - anchor later report generation and interactive querying

That is important: in MiroFish, GraphRAG is probably not just a retrieval layer. It is part of the **world compiler**.

## Where to get it

### Official sources
- Microsoft GraphRAG docs: `https://microsoft.github.io/graphrag/`
- GitHub repo: `https://github.com/microsoft/graphrag`
- Microsoft Research paper / post: `https://www.microsoft.com/en-us/research/publication/from-local-to-global-a-graph-rag-approach-to-query-focused-summarization/`

### Install path
Typical quickstart:
```bash
python -m venv .venv
source .venv/bin/activate
python -m pip install graphrag
graphrag init
```

## Runtime and dependency notes

Microsoft’s quickstart documents Python **3.10–3.12**. That aligns with why MiroFish constrains its backend to Python 3.11–3.12.

## What it is good for

- corpus-to-world conversion
- entity relationship modeling
- social/political/organizational mapping
- long-context compression
- report generation inputs
- agent grounding before simulation starts

## What it is bad for

- exact transactional state
- high-frequency real-time systems without a separate event/state layer
- hard guarantees of factuality
- deterministic simulation by itself

GraphRAG organizes knowledge. It does not replace:
- simulation rules
- agent memory
- temporal state
- evaluation logic

## How to think about it inside Velorin

For Velorin, GraphRAG is relevant in three very different ways:

### 1. Company memory graph
Map:
- decisions
- agents
- tools
- dependencies
- customers
- strategic threads
- unresolved questions

### 2. Research graph
Turn market research and build notes into:
- themes
- players
- tool relationships
- opportunity clusters

### 3. Human operating system graph
Potentially map:
- obligations
- recurring entities
- domains
- advisors
- constraints
- risks
- cross-box effects

## ChatGPT integration path

There is no first-party “GraphRAG connector” inside ChatGPT.

The practical path is:

### Option A — MCP-backed ChatGPT app
Build a remote MCP server that exposes GraphRAG operations like:
- `index_corpus`
- `query_local`
- `query_global`
- `get_entity`
- `get_community_summary`

Then connect it to ChatGPT using:
- Apps SDK
- MCP
- custom app / connector path

This is the correct serious path.

### Option B — API-only backend
Run GraphRAG behind your own API and call it from:
- an OpenAI app backend
- internal workflow tools
- orchestration services

### Option C — file upload only
Weakest option. You can upload outputs, but ChatGPT is not running GraphRAG for you unless you provide a tool layer.

## Anthropic / Claude integration path

Again, there is no native GraphRAG connector.

Real options:

### Option A — Remote MCP server
Best path for Claude API and Claude-based systems. Anthropic’s MCP connector can connect directly to remote MCP servers.

### Option B — Claude Code + local MCP
Useful for development. Good for indexing corpora or operating on local research folders.

### Option C — Claude Desktop extension / MCP bundle
Useful when you want one-click internal distribution for non-technical operators.

### Option D — Claude Skill
A Skill does not replace GraphRAG. It can package the workflow and instructions for using a GraphRAG-backed tool.

## Recommended Velorin position

- Do not treat GraphRAG as “memory.”
- Do not treat GraphRAG as “simulation.”
- Treat it as a **knowledge-to-structure compiler**.

Best use:
- drive world-building
- drive report generation
- drive strategic querying
- feed simulation agents with structured context

## Failure modes

- over-extraction and graph bloat
- weak entity normalization
- hallucinated edges
- stale summaries
- false confidence from graph aesthetics
- mixing raw evidence and inferred structure without labels

## Decision

For a MiroFish-like system, GraphRAG is not optional. It is one of the key reasons the simulator can start from messy seed material and still produce a coherent world model.

## Sources

- MiroFish README / workflow and prerequisites
- Microsoft GraphRAG docs
- Microsoft GraphRAG GitHub
- Microsoft Research GraphRAG publication
