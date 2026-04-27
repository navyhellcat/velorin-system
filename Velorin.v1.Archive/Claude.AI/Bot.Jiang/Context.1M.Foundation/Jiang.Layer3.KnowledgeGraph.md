---
class: c-memory
type: layer-research
layer: 3
layer_name: Knowledge Graph / Brain
status: BUILT — 4 gaps identified
session: 016 | April 3, 2026
confidence: 92% neuroscience basis | 78% gap mapping
---

# Layer 3 — Knowledge Graph / Brain
**Status: BUILT. Architecture is sound. 4 specific gaps identified. None require rearchitecting — all are additions.**

---

## Full Research Document
`Research_Complete/Jiang.Topic.HumanBrainLayers.md` — 858 lines, 6 sections, fully sourced.
`Research_Complete/Jiang.BrainLayers.Interactive.html` — 72KB interactive visualization, 3 views.

Read those files for complete detail. This file is the layer summary and decision pointer.

---

## What the Brain Is
The Velorin Brain is a neural file graph stored in GitHub. Knowledge lives in neurons — small files (~15 lines max) containing one atomic idea with rated pointers to related neurons. Neurons are organized into regions (broad) → areas (specific).

The architecture is independently convergent with the hippocampal indexing model (Teyler & DiScenna): hippocampus stores a pointer to a distributed cortical pattern, not the pattern itself. The Brain is not an approximation of how biological memory works. It IS the same architecture at the structural level.

---

## The 4 Gaps (Priority Order)

### Gap 1 — Reverse Pointer Index [HIGHEST PRIORITY]
**Biological equivalent:** CA3 recurrent collaterals (pattern completion)
**What's missing:** The Brain can follow pointers forward (neuron A → neuron B). It cannot find what points TO a neuron. You cannot ask "what other neurons reference this one?" without scanning the entire graph.
**Why it matters:** Pattern completion from partial cues. If you know one part of a memory, the brain finds the whole. The Brain currently cannot do this.
**Fix:** A separate index file (or automated script) that maps: neuron_name → [list of neurons that point to it]. Updated whenever neurons are created/modified.

### Gap 2 — Salience Scoring Gate
**Biological equivalent:** Amygdala-hippocampal salience gating
**What's missing:** The brain gates what gets stored based on emotional/importance signals. The Brain stores everything with equal weight — no mechanism to prevent low-value neuron proliferation.
**Fix:** A salience score field in neuron frontmatter. Neurons below threshold get flagged for review rather than traversal.

### Gap 3 — Pointer Renormalization
**Biological equivalent:** Synaptic Homeostasis Hypothesis (Tononi)
**What's missing:** Pointer ratings (1-10) are assigned at creation. As the graph grows, ratings drift — a [1] pointer from 6 months ago may no longer be the most critical connection.
**Fix:** Periodic renormalization sweep. When a neuron's pointer count changes or its region grows significantly, recalibrate pointer ratings relative to network state.

### Gap 4 — Scratch Log Purge
**Biological equivalent:** Glymphatic clearance / sleep-phase consolidation
**What's missing:** Temporary working neurons from active sessions accumulate. No automated mechanism to purge or consolidate them post-session.
**Fix:** Session-end hook that flags newly created neurons as `status: provisional`. After 2 sessions without a pointer from another neuron → auto-archive candidate.

---

## Brain Entry Points
- Local: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Velorin_Brain/_index.md`
- GitHub: `navyhellcat/velorin-system` → `Claude.AI/Velorin_Brain/_index.md`
- Schema: `Claude.AI/Velorin_Brain/_BRAIN_SCHEMA.md`

---

## Relationship to Layer 2
Gap 1 (reverse pointer index) is a Layer 2/3 boundary feature. It enables pattern completion from partial cues — which is a retrieval behavior (L2) implemented in the graph structure (L3). Closing this gap closes part of the Layer 2 retrieval gap without requiring a vector database.

---

[VELORIN.EOF]
