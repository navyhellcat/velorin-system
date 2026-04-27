---
class: c-memory
type: layer-research
layer: 2
layer_name: Retrieval & Search
status: UNSETTLED — PRIMARY RESEARCH MANDATE
session: 016 | April 3, 2026
confidence: varies by sub-topic (see below)
priority: BLOCKING — all other architecture decisions depend on this
---

# Layer 2 — Retrieval & Search
**Status: UNSETTLED. This is the layer where the confusion lives. This is the primary research mandate.**

The confusion is not because competing technologies are fighting for the same slot. It is because they serve different retrieval needs and belong at different access paths within the same layer. This file maps what is known, what is unknown, and what decision needs to be made.

---

## The Core Question
**When Jiang needs to find a piece of knowledge, how does the retrieval actually work?**

Current answer: Jiang reads a known filename, follows pointer links, traverses the Brain. Works when Jiang knows which file to start from.

Gap: What happens when Jiang doesn't know which neuron to start from? When the query is semantic ("find what I know about compression") rather than navigational ("read neurons.memory.storage.A1")?

That gap is this layer's unsolved problem.

---

## Technology Map — What Each One Actually Does

### RAG — Retrieval Augmented Generation
**Confidence: 88%**

**What it is:** Documents are split into chunks, each chunk is embedded as a vector (a list of numbers representing semantic meaning), stored in a vector database. At query time, the query is embedded the same way, and the nearest chunks by cosine similarity are retrieved.

**What it's good for:** "What does document X say about topic Y?" Finding relevant passages. Works when you don't know which document contains the answer.

**What it's bad for:** Understanding relationships between concepts across documents. Architectural understanding. Retrieving structure, not just content. RAG retrieves fragments. It misses the pattern connecting the fragments.

**Key limitation:** Chunk size is a hard tradeoff. Large chunks = more context per retrieval, less precise targeting. Small chunks = precise targeting, missing context. No chunk size is universally optimal.

**Confidence on this characterization: 88%**

---

### Graph RAG — Microsoft (2024)
**Confidence: 84%**

**What it is:** Before retrieval, documents are processed by an LLM to extract entities (things) and relationships (how things connect). These are stored as a knowledge graph. At query time, subgraphs are retrieved — not chunks, but relationship structures.

**What it's good for:** "How does X relate to Y?" "What connects these concepts?" Queries that require understanding structure, not just content. Multi-hop reasoning across documents.

**What it's bad for:** Cost. Building the graph requires many LLM calls per document. Ongoing maintenance — the graph must be updated when documents change. Overkill for simple retrieval.

**Microsoft open-sourced GraphRAG (2024).** Production implementations exist. Requires significant compute to build the initial graph.

**Key insight:** The Velorin Brain IS a manually-maintained knowledge graph. It is Graph RAG, built by hand. Graph RAG is an attempt to automate what the Brain does manually.

**Confidence: 84%**

---

### Vector Databases — The Infrastructure Layer
**Confidence: 92% — this is commodity technology**

**What it is:** Not a retrieval strategy. The storage infrastructure that makes RAG and semantic search possible. Stores embeddings (vectors) and retrieves nearest neighbors efficiently.

**Current landscape:**
- **pgvector** — Postgres extension. Best choice if already using Postgres. No new database. SQL-compatible. Open source.
- **Chroma** — Lightweight, local-first, Python-native. Best for small-to-medium collections. Easy to run locally.
- **Qdrant** — High performance, production-grade. Rust-based. Good filtering capabilities.
- **Pinecone** — Managed cloud service. No self-hosting. Higher cost but zero infrastructure.
- **Weaviate** — Full-featured, schema-based. More complex but more powerful.

**For Velorin's current phase:** Chroma or pgvector. Small collection, local operation, no managed service cost. The choice between them is a hosting preference, not a capability difference.

**Confidence: 92%**

---

### Pointer Traversal — The Current Velorin Brain Approach
**Confidence: 95% — we built it**

**What it is:** Jiang starts at a known neuron (filename), reads it, follows rated pointers to related neurons. Follows [1] pointers first (critical connections), then [2], expanding outward.

**What it's good for:** Structured knowledge navigation when the starting neuron is known. Follows human-curated relationship ratings. Respects the semantic structure of the knowledge.

**What it's bad for:** Entry point discovery. If Jiang doesn't know which neuron to start from, there is no mechanism to find it by semantic similarity. The _index.md files partially address this — but they require knowing the region and area.

**This is the gap that needs filling at Layer 2.**

---

### Obsidian
**Confidence: 90% on characterization**

**What it is:** A human-facing note-taking application that uses local markdown files with [[wiki-style links]]. Has a graph visualization view showing connections between notes. Plugin ecosystem (Dataview, Templater, Kanban, etc.).

**What it is NOT:** A retrieval technology. Not an AI-native system. Not a vector database.

**Relevance to Velorin:** The Velorin Brain's file structure is already Obsidian-compatible. The Brain's neurons are markdown files with pointer links — Obsidian's [[wikilinks]] are the same pattern. Pointing Obsidian at the velorin-system folder would immediately give a graph visualization of the Brain without changing any files.

**Value:** Christian Taylor gets a visual graph of the Brain. Can navigate it like a map. Can see which neurons are most connected. Helps with the "can't visualize this" problem.

**Limitation:** AI agents don't benefit from Obsidian's visualization — they read the markdown directly. Obsidian is for the human, not the agent.

**Recommendation:** Worth evaluating as a visualization layer for the human. Does not change the underlying architecture.

---

## The Decision Tree

```
When Jiang needs to retrieve knowledge:

Is the entry neuron known?
├── YES → Pointer traversal (current approach) ✓
└── NO → Need semantic search entry point
         │
         ├── Option A: Vector index over neuron names + summaries
         │   Semantic query → neuron name → pointer traversal
         │   Low cost, low complexity, fits current architecture
         │
         ├── Option B: Graph RAG over research documents
         │   Automatic entity/relationship extraction → graph
         │   Higher power, higher cost to build and maintain
         │   Overlaps with what the Brain already does manually
         │
         └── Option C: Keep navigational only
             Rely on well-named neurons + _index.md discipline
             Breaks at ~50-80 topics (not yet hit)
```

**Option A is the likely recommendation** — pending full research. It is the minimum addition that closes the gap without disrupting the existing Brain architecture. The vector index is a search entry point, not a replacement for the pointer graph.

---

## What the Full Research Mandate Needs to Determine

This file captures what is known. The bottom-of-funnel research mandate needs to determine:

1. **Which vector database is right for the Velorin scale and hosting model?** (Probably Chroma or pgvector — verify.)
2. **What does "adding a vector index to the Brain" actually look like in code?** 3-5 files. What are they?
3. **Is Graph RAG worth the build cost over manual curation?** At what volume of research documents does automatic extraction beat manual neuron creation?
4. **What is the embedding model for the vector index?** (text-embedding-3-small from OpenAI, or Gemini embeddings, or local via Ollama?)
5. **Does Obsidian integrate cleanly with the current Brain file structure?** Is the visualization worth the setup?
6. **What are the newest developments** (post-March 2026) in retrieval architecture that might supersede these options?

---

## Current Velorin Brain Gaps at This Layer
(From HumanBrainLayers research, Session 015, 92% confidence)

The Brain lacks a reverse pointer index — the biological equivalent of CA3 recurrent collaterals. Currently: traversal is one-directional (follow pointers forward). Missing: finding "what points TO this neuron?" This is needed for pattern completion from partial cues. It is the highest-priority Brain enhancement and is a Layer 2/3 boundary feature.

---

[VELORIN.EOF]
