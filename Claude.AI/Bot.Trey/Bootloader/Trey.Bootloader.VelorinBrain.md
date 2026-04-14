---
destination: Claude.AI/Bot.Trey/Bootloader/
file: Trey.Bootloader.VelorinBrain.md
type: bootloader
updated: April 13, 2026
---

# Trey Bootloader — The Velorin Brain Architecture

Version 1.0 | April 13, 2026
Context for Trey 2 research on Velorin build decisions

---

## 1. What the Velorin Brain Is

The Velorin Brain is a neural file graph. It is the long-term memory and knowledge
retrieval layer of the Velorin personal operating system. It stores knowledge as
atomic files (neurons) connected by rated directional pointers (synapses). Retrieval
is performed via Personalized PageRank (PPR) walks over the pointer graph.

The Brain is not a database. It is not a vector store. It is not a flat document library.
It is a graph of small, human-readable files where the connection structure IS the
knowledge structure.

---

## 2. The Four-Layer Architecture

The Brain implements a four-layer architecture that mirrors the biological memory hierarchy
from hippocampus (episodic, fast) to neocortex (semantic, permanent).

**Layer 3 — Markdown / Hippocampal Layer**
The top layer. Atomic markdown files (neurons), ~15 lines max, each containing one idea.
Connected by rated directional pointers. Human-readable. Lives on the filesystem.
Analogous to hippocampal episodic memory: fast, specific, retrievable by association.

**Layer 2 — Pointer Graph / Cortical Connection Layer**
The connection structure of Layer 3. Directional edges with ratings 1–10.
Low numbers = high priority: [1] = read immediately, [10] = tangential.
Each neuron carries maximum 7 pointers. When full, lowest-rated pointer is demoted.
Analogous to cortical-hippocampal connections: the routing structure that determines
what concepts are associated and how strongly.

**Layer 1 — E₈ Crystal / Entorhinal Routing Layer**
The semantic coordinate space. Planned implementation: Qdrant vector store as an
MCP-addressable semantic index over Layer 3. Maps neurons into continuous embedding
space so that semantic similarity can route queries to the correct region before PPR.
Analogous to the entorhinal cortex: the gateway that routes external input to the
correct hippocampal region.
Status: PLANNED — not yet implemented.

**Layer 0 — LoRa / Neocortical Layer**
The permanent semantic sediment. Patterns that have been retrieved and reinforced enough
times that they compress from specific episodes (Layer 3) into general semantic structure
(Layer 0). Implementation: LoRa fine-tuning of a base model on Chairman-specific
knowledge that has been sufficiently validated.
Analogous to neocortical semantic memory: slow to write, permanent, not episodic.
Status: FUTURE — not yet designed in detail.

---

## 3. The Retrieval Algorithm

**Personalized PageRank (PPR):**

R = (1 - α) · P · R + α · S

Where:
- R = relevance distribution over all neurons
- P = transition matrix (rows are neurons, columns are pointers, weights from ratings)
- α = teleportation probability (typically 0.15)
- S = seed vector (query — which neurons the current session starts from)

The walk follows pointer ratings as edge weights. High-priority pointers (low rating number)
propagate more relevance mass. The algorithm returns the highest-R neurons as retrieval results.

**Pointer rating → edge weight mapping:**
Rating 1 = highest edge weight → most relevance mass flows through this edge
Rating 10 = lowest edge weight → minimal relevance mass

---

## 4. Neuron Structure

Each neuron is a markdown file. Maximum 15 lines. Maximum 7 pointers.
Contains: one atomic idea, context sentence, and rated pointers to related neurons.

Class labels on neurons:
- Standard neurons: prunable, can be demoted, decayed, or archived
- c-memory neurons: permanent, never touched by any pruning algorithm

The c-memory class is a hard constraint. Any algorithm that modifies c-memory neurons
is architecturally wrong regardless of its mathematical properties.

---

## 5. Graph Organization

Neurons are organized into Regions (broad domain folders) → Areas (mid-level folders) →
Neurons (bottom layer, always markdown files). The bottom layer is always neurons.

Current regions are hand-curated. Automated ingestion pipeline is planned but not built.

---

## 6. Known Failure Modes

**Failure Mode 1 — Monster Node Problem:**
High-centrality nodes (e.g., "Velorin," "Christian Taylor," "Architecture") accumulate
pointers from hundreds of neurons. In PPR, the walk keeps getting drawn to these nodes,
spreading teleportation probability across the entire graph. Eventually PPR stops returning
relevant neurons and starts returning the same high-centrality nodes regardless of query.
Retrieval precision collapses.

**Failure Mode 2 — Stale Neuron Problem:**
Information becomes outdated. A reversed design decision from six months ago remains in
the graph with equal weight to current decisions. The graph accumulates history with equal
weighting, degrading retrieval signal-to-noise as the graph grows.

**Combined result:** A Brain precise at 200 neurons becomes a noise machine at 5,000.
The system degrades with use instead of improving.

---

## 7. What Is and Is Not Built

BUILT:
- Neuron structure and pointer format
- 7-pointer cap with local demotion
- c-memory class label
- Hand-curated initial graph
- PPR retrieval (conceptually — implementation via Claude MCP)
- Velorin Brain GitHub repo (navyhellcat/velorin-system)

PLANNED / NOT YET BUILT:
- Automated ingestion pipeline
- Global pruning algorithm (synaptic pruning — active research)
- Time-based decay mechanism
- Monster Node detection and suppression
- Qdrant vector store (Layer 1)
- Session close protocol for neuron updates
- Access-frequency tracking

FUTURE (not yet designed):
- LoRa fine-tuning layer (Layer 0)
- Full four-layer integration

---

## 8. Active Research Questions Relevant to the Brain

The following are open questions actively being researched or worked on:

- Synaptic pruning algorithm: how to prune the pointer graph without breaking
  retrieval precision as the graph scales to 5,000+ neurons (Trey research complete;
  Phase 2 math specification pending Erdős)
- Temporal decay function: the Ebbinghaus-Laplacian Decay Model proposed by Erdős
  needs empirical validation from neuroscience literature (Trey validation request queued)
- Monster Node suppression: how to detect and flatten high-centrality nodes without
  destroying the structural information they carry

---

Trey.Bootloader.VelorinBrain | Version 1.0 | April 13, 2026
[VELORIN.EOF]
