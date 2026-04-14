---
class: research-request
priority: CRITICAL
assigned: Trey 2
requested-by: Jiang (Director of Strategic Intelligence) | authorized: Christian Taylor (Chairman)
date: April 13, 2026
session: 026
status: QUEUED
mode: DISCOVERY MODE — assume the frame is incomplete
confidence-threshold: 75%
---

# Trey Research Request — Brain Ingestion Pipeline: Automation Architecture

---

## THE PROBLEM

The Velorin Brain is a neural file graph. Neurons are small atomic knowledge files (~15 lines,
one idea each) connected by rated directional pointers (1-10, max 7 per neuron). Retrieval
runs via Personalized PageRank (PPR) over the pointer graph.

The entire system currently assumes a human manually:
- Reads raw input (memory, document, photo, video)
- Decides what constitutes one atomic idea
- Writes the neuron file
- Decides which other neurons it connects to
- Assigns pointer ratings by judgment
- Updates ratings over time as the graph evolves

This is not an operating system. This is a filing cabinet with extra steps. The automation
of this pipeline is the foundational engineering problem of the entire Velorin build.
Nothing else scales until this is solved.

---

## THE FULL PIPELINE — WHAT NEEDS TO EXIST

```
Raw input (memory, file, photo, video, text, conversation)
    ↓
Semantic extraction (multimodal → text/meaning)
    ↓
Atomic decomposition (meaning → candidate neurons)
    ↓
Deduplication (new neuron? or update existing?)
    ↓
Region/Area assignment (where does this live in the graph?)
    ↓
Pointer construction (what does this connect to?)
    ↓
Initial rating assignment (how strong is each connection?)
    ↓
Write to Brain
    ↓
Dynamic rating update over time (retrieval feedback loop)
```

Research is needed on every stage. The hard problems are identified below.

---

## STAGE-BY-STAGE RESEARCH QUESTIONS

### Stage 1 — Atomic Decomposition

The most fundamental unsolved problem in the pipeline. A paragraph can contain one idea
or twelve. A conversation contains dozens. A photo contains people, place, time, event,
and emotional context — each potentially a separate neuron.

Research questions:
1. What does the existing literature say about automated semantic chunking at the
   atomic-idea level? What approaches exist and what are their failure modes?
2. What criterion defines "one atomic idea" in a knowledge graph context? Is there
   a formal definition, or is this always domain-specific?
3. What recursive decomposition strategies exist — approaches that keep splitting a
   unit until it can no longer be split without losing meaning?
4. What is the minimum viable atomicity criterion that could be encoded as a prompt
   or algorithm for the Velorin neuron format specifically?
5. How do existing systems (Zep, Graphiti, Mem0, knowledge graph pipelines) handle
   this decomposition step? What can be learned from their architectures?

### Stage 2 — Deduplication

Before writing a new neuron, the system must check whether the information already
exists in the Brain. If it does, the existing neuron should be updated, not duplicated.

Research questions:
1. What embedding similarity thresholds are used in production knowledge graph systems
   for deduplication? What are the tradeoffs at different thresholds?
2. How do systems handle partial overlap — where new information partially matches an
   existing neuron but also contains genuinely new content?
3. What approaches exist for semantic deduplication that go beyond simple cosine
   similarity (which catches near-duplicates but misses paraphrases and conceptual
   overlaps)?
4. How do systems handle contradictions — where new input contradicts an existing
   neuron? Which wins, and how is the conflict resolved?

### Stage 3 — Region and Area Assignment

Every neuron must be placed in the correct Region/Area of the graph. Currently this
is done by hand. Automating it requires a classification mechanism.

Research questions:
1. What approaches exist for automatic taxonomy classification in knowledge graphs?
2. How do these approaches handle content that legitimately spans multiple regions?
3. What is the failure mode when the taxonomy itself is incomplete — when new content
   doesn't fit any existing Region?

### Stage 4 — Pointer Construction and Initial Rating

This is the hardest stage. Two distinct problems:

**Problem A — Which neurons to connect:**
Embedding cosine similarity finds related neurons. But relatedness is not the same as
navigational value. Two neurons can be highly similar without one being a useful pointer
to reach the other during PPR retrieval.

**Problem B — What rating to assign:**
The rating (1-10) is supposed to encode directional navigational value — "if I'm at
neuron A looking for something, how often does following this edge get me closer to
the answer?" This is a retrieval-quality signal, not a similarity signal. It cannot
be derived from embeddings alone at ingestion time, because retrieval history doesn't
exist yet for a new neuron.

Research questions:
1. What signal — other than embedding similarity — best predicts whether edge A→B
   will carry PPR mass in retrieval? Is there a proxy available at ingestion time?
2. What approaches do knowledge graph systems use for initial edge weight assignment
   when no retrieval history exists?
3. How do graph neural network approaches (GraphSAGE, GAT, etc.) assign edge weights
   at induction time for new nodes? Is the mechanism transferable to the Velorin model?
4. What is the minimum viable initial rating strategy — even if imperfect — that can
   be refined over time via the dynamic update loop?
5. Is there a principled way to use LLM judgment at ingestion time to bootstrap pointer
   ratings? What prompt structure, what evaluation criteria?

### Stage 5 — Dynamic Rating Update (The Feedback Loop)

The most important long-term mechanism. Without this, the graph is static. With it,
the graph self-organizes around what actually works.

The proposed mechanism:
- Every retrieval event logs which neurons were returned and via which paths
- Paths that resolved the query get reinforced (rating number decremented)
- Paths that were traversed but didn't contribute get incremented toward demotion
- Over time, ratings reflect actual retrieval performance, not initial assignment

Research questions:
1. What reinforcement learning on graph edge weights approaches exist in the literature?
   What is the closest existing mechanism to what is described above?
2. How does PPR stationary mass (π_u) relate to the rating update signal? Specifically:
   can π_u be used as a proxy for "this node is structurally important" to protect
   high-centrality edges from being demoted even when a specific query didn't use them?
3. What is the correct update rule? Options to evaluate:
   - Simple frequency: edges traversed more often get lower ratings
   - Success-weighted: edges on paths that resolved the query get reinforced, others don't
   - Decay: edges not traversed in N retrievals get incremented toward demotion
   - Hybrid: success-weighted with decay baseline
4. What convergence guarantees (if any) exist for graph edge weight update rules of
   this type? Does the graph stabilize or does it oscillate?
5. How do existing systems (collaborative filtering, recommendation graphs, knowledge
   graph completion) handle the cold-start problem for new edges with no retrieval history?

### Stage 6 — Multimodal Ingestion (Photos, Video, Audio)

Completely separate ingestion problem from text.

A photo contains at minimum: people, place, timestamp, event context, emotional context —
each potentially a separate neuron or a connection to an existing one.
A video is a sequence of frames plus audio.
A voice memo is audio that needs transcription plus prosodic/emotional signal.

Research questions:
1. What multimodal decomposition pipelines exist for extracting structured semantic
   content from photos and video for knowledge graph ingestion?
2. How do existing systems assign emotional valence (equivalent to H_E in the Velorin
   model) from image content? What is the evidence base for automated affect detection
   from photos?
3. What is the minimal viable photo ingestion pipeline that produces Velorin-compatible
   neurons without requiring human annotation?
4. How do temporal signals (timestamps, sequence) get encoded in a static graph structure
   without creating a separate time-indexed node for every moment?

---

## WHAT IS NOT BEING ASKED

Do not research:
- General RAG architectures (already researched)
- Vector database selection (not the current question)
- The PPR retrieval algorithm itself (already derived by Erdős — locked)
- The pruning algorithm (separate research track, substantially complete)

---

## OUTPUT REQUIRED

A complete research report structured as follows:

1. Executive summary — what the literature says is solved vs. genuinely open
2. Stage-by-stage findings — for each pipeline stage: what exists, what works,
   what is a genuine open problem
3. Recommended architecture — a first-principles recommendation for each stage
   based on findings, with confidence levels
4. What Velorin must build from scratch vs. what it can adapt from existing work
5. Open questions that require Erdős (mathematical derivation) vs. Trey 2
   (further research) vs. engineering (just build it)
6. Remaining gaps — what the research could not resolve

Confidence-weight all conclusions. Distinguish prior context from new findings.
Flag contradictions with the existing Velorin architecture explicitly.

Deliver to: Google Drive → Claude.AI Shipping folder
Destination header:
---
destination: Claude.AI/Bot.Trey/Research_Complete/
---

[VELORIN.EOF]
