# 02 — Architecture
**The 4-Layer Memory System**

---

## The Complete Stack

```
Layer 0 — LoRa Adapter          FUTURE: CT's cognitive patterns as model weights
                                  Semantic intuition, always-on, shapes inference
                                  Depends on: local model decision, compression event detector

Layer 1 — E₈ Brain              IMMEDIATE BUILD
                                  PPR over neuron pointer graph in E₈ crystals
                                  The navigation and retrieval layer
                                  Qdrant as vector search entry point

Layer 2 — Episodic Graphs       DESIGNED — engineering phase after Layer 1
                                  240-node document graphs, temporal KG format
                                  Dark Matter: bulk data with zero pointers
                                  Ignition Protocol: emotional engagement crystallizes

Layer 3 — Permanent Archive     EXISTS (GitHub repo)
                                  All markdown files, sessions, research
                                  Never deleted — Second Law of Epistemodynamics
                                  Model-agnostic ground truth
```

---

## Layer 3 — The Archive (Exists Now)

GitHub is Layer 3. Everything committed is permanently preserved.

**What lives here:**
- Session handoffs and daily logs
- All research documents (Trey outputs, Erdős proofs)
- Agent instruction files
- Architecture documents
- The neuron markdown files that make up the Brain

**The Second Law:** Once information enters Layer 3, it is never deleted.
When the LoRa (Layer 0) learns a pattern, the explicit Markdown record
is demoted — its pointer priority drops — but it is never removed.
This is mathematically proven (DPI + Eckart-Young, see `03_BrainAndMath.md`).

Model agnosticism is a consequence: when CT upgrades to a new AI model,
the Markdown ground truth survives. The LoRa is model-specific and gets
retrained. The archive enables that retraining.

---

## Layer 1 — The Brain (Build This First)

**What it is:** A neural file graph. Neurons are atomic markdown files (~15 lines,
one idea each). Neurons connect via directed pointer ratings (1-10), automatically
assigned by the ingestion pipeline — never rated by hand. Low number = strong connection.
High number = tangential. Max 7 outbound pointers.

**Retrieval algorithm:** Personalized PageRank (PPR)
```
R = (1-α) · P · R + α · S
```
Where P is the transition matrix weighted by pointer ratings, S is the query seed,
α is teleportation probability (~0.25). High-affinity edges (rating 1-3, affinity 8-10)
carry more probability mass. The walk follows the human's judgment.

**Scale invariance (Theorem 1):** With the 7-pointer cap, retrieval precision ρ*(n)
scales as O(1) regardless of graph size. The Brain at 5M neurons maintains the same
PPR precision as at 500 neurons. This is proven, not assumed.

**Density floor (Theorem 2):** ρ* ≈ 0.78. 78% of a neuron's pointers must be
high-priority (ratings 1-3) to maintain 75% retrieval precision. With 7 pointers,
that means 5 of 7 must be semantic signal. 2 can be tangential.

**Crystal structure:** Neurons are organized into E₈ crystals (240 neurons max per crystal).
The Pointer Gravity algorithm (Wall A) warps the 8D embedding space through the human's
pointer topology before assigning neurons to crystal docking ports. Connected neurons
cluster together geometrically.

**Cross-crystal routing:** The Inter-Crystal Gauge Tensor (Wall B) — an 8×8 matrix (64
floats per crystal boundary) — routes PPR walks across crystal boundaries without
O(N) lookup. Simon-Ando Aggregation makes multi-crystal traversal computationally cheap.

**Monster Nodes:** Neurons with high betweenness centrality become Semantic Mirrors
(Theorem 3) — the Fisher Information penalty makes them reflect the PPR walk back to
the query seed rather than absorbing mass. Retrieval precision is preserved.

**Pruning:** GNNDelete with c-memory masking (Theorem 4). c-memory neurons are
mathematically excluded from pruning operations — the feasible set is empty if you
try to modify them. Regular neurons can be pruned. The mask M = 0 for c-memory, 1 for
regular enforces this at the loss function level.

### Brain Folder Structure

```
brain/
├── _index.md               ← Entry point for all agents
├── _BRAIN_SCHEMA.md        ← Schema, pointer rating rules, generality test
├── Operations/
│   ├── _index.md
│   ├── Architecture/
│   │   └── neurons.md
│   ├── Startup/
│   │   └── neurons.md
│   └── Tools/
│       └── neurons.md
├── Connectivity/
│   ├── _index.md
│   ├── MCP/
│   │   └── neurons.md
│   └── Auth/
│       └── neurons.md
├── Agents/
│   ├── _index.md
│   ├── Roster/
│   │   └── neurons.md
│   └── Protocols/
│       └── neurons.md
├── Principles/
│   ├── _index.md
│   ├── RewardAlignment/
│   │   └── neurons.md
│   └── CoreDrives/
│       └── neurons.md
├── Company/                ← NEW — create immediately
│   ├── _index.md
│   └── [areas]/
└── Intelligence/           ← NEW — create immediately
    ├── _index.md
    └── [areas]/
```

**Company/ region:** Strategic knowledge as neurons. Window Gravity, Build vs Adopt,
Five Boxes, architectural decisions, vocabulary. Currently exists only as flat documents —
needs to become neurons.

**Intelligence/ region:** Jiang's research conclusions as neurons. 12+ concluded topics
(AgentOrchestration, WindowGravity, InstructionLanguageArchitecture, HumanBrainLayers,
etc.) — none are neurons yet. The Brain cannot reason about what Jiang knows.

---

## Layer 2 — Episodic Graphs (Design Complete, Engineering Pending)

**What it is:** For each document ingested, a 240-node weighted graph connecting the
semantically most central chunks of that document. This is the episodic detail layer —
what the Brain routes to when Layer 1 signals "need more detail."

**Data model:** Temporal knowledge graph (RDF-style triples with validity windows)
```
(node_u, relation, node_v, valid_from=date, valid_to=NULL_or_date, weight=float)
```
When a pointer is demoted by the Demotion Oracle, `valid_to` is set. The record
survives. The temporal KG is the implementation. MemPalace represents this design
pattern — adopt the data model, not necessarily the specific tool.

**Semantic Dark Matter:** All bulk data (photos, chat logs, raw documents) is ingested
into Qdrant as isolated 1536D vectors with zero Layer 2 pointers. No pointer = no PPR
routing gravity. The data exists but cannot be walked to. This prevents PPR density
collapse during bulk ingestion. Validated by Trey (Q5, 67-84% confidence).

**Ignition Protocol:** When CT queries the vector index and emotionally engages with
a result:
1. The system identifies the active PPR context V_active (what the current walk has lit up)
2. Computes topological fitness: f(x* → u) = π^(q)_u · exp(x*^T W_LoRa x_u / τ)
3. Assigns top-k edges, all with affinity ≥ 8 (Ignition Valency Constraint — emotional
   engagement forces high-affinity connections)
4. Writes a reciprocal pointer from the anchor node back to the crystallized node
5. Density is preserved or fortified — proven in Section 7 of Ignition Protocol doc

**Implementation status:** Designed and proven. Engineering has NOT started.
Ingestion pipeline research is nearly complete but has issues with base assumptions
(see `07_OpenQuestions.md`). Build Layer 1 first, then design Layer 2 engineering.

---

## Layer 0 — LoRa Adapter (Future)

**What it is:** A lightweight fine-tuned parameter layer attached to a frozen local base
model. Encodes CT's compressed cognitive patterns in model weights. Shapes every
inference without entering the context window. The semantic weight layer.

**Why it matters:** The Brain (Layer 1) generates training signal. The LoRa receives it.
When CT consistently applies a framework across many different unrelated contexts,
the compression event detector identifies this as a load-bearing semantic pattern
and queues it for LoRa encoding. The LoRa is what makes the system "get CT"
without re-explanation.

**The Second Law consequence:** The LoRa is a lossy, model-specific encoding.
The Markdown record (Layer 3) is never deleted because:
- Δ = I(X;Y) - I(Z;Y) > 0 always (proven — DPI + Eckart-Young)
- When the base model changes, the LoRa must be retrained
- The Markdown ground truth enables that retraining across any future model

**What's open:**
- Local base model selection (deferred until Brain is built)
- Compression event detector design (core open problem — how does the system detect
  that a pattern has become load-bearing vs still episodic?)
- Training pipeline design (Trey2 research on ingestion pipeline may address this)

**Do not build this yet.** Build the Brain first. The LoRa requires:
- A populated Brain with high-confidence neurons
- A local base model running on Mac Studio
- A compression event detection mechanism (not yet designed)

---

## The Retrieval Flow (End-to-End)

```
CT types a query
    │
    ▼
W_global projection: query → 8D via global projection matrix
    │
    ▼
O(K) softmax over K crystal centroids → identify entry crystals
    │
    ▼
PPR micro-walk inside activated crystals
    │
    ▼
Inter-Crystal Gauge Tensor routing for cross-crystal paths
    │
    ▼
Simon-Ando aggregation for efficient multi-crystal traversal
    │
    ▼
TAG (Topology-Augmented Generation): context returned in pointer-graph order
not flat list — the LLM reads neurons in the exact topological sequence
CT's pointers define
    │
    ▼
Response generated against this structured context
```

Qdrant is the entry point (vector similarity to find seed neurons for PPR).
PPR is the traversal algorithm.
TAG is the output formatting — not RAG (retrieval then generate), but topology
preserved through the generation context.

---

## The Memory Hierarchy — What Goes Where

| Content Type | Layer | Storage | When Accessed |
|---|---|---|---|
| CT's profile, locked decisions | Layer 1 c-memory neurons | Brain | Every session |
| Active architectural knowledge | Layer 1 regular neurons | Brain | On PPR traversal |
| Research conclusions | Layer 1 Intelligence/ neurons | Brain | On relevant query |
| Session handoffs | Layer 3 + pointer in Brain | GitHub + Brain pointer | On session start |
| Research documents | Layer 3 | GitHub tools-and-research/ | On demand |
| Photos, chat logs, bulk data | Dark Matter (Qdrant only) | Qdrant vector index | On query + Ignition |
| Demoted pointers | Layer 3 (archived) | Markdown with valid_to | Rarely — historical |

---

[VELORIN.EOF]
