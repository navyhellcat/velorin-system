---
class: research-request
priority: CRITICAL
assigned: Trey 2
requested-by: Jiang2 | authorized: Christian Taylor (Chairman)
date: 2026-04-19
session: 028
status: QUEUED
mode: Discovery → Recommendation
confidence-threshold: 80%
---

# Trey Research Request — Automated Pointer Rating and Dual-Rating Architecture

---

## THE DECISION THAT CREATED THIS PROBLEM

The Velorin build has locked: no human-assigned pointer ratings. Ever.
All pointer ratings (1-10 scale) must be assigned automatically by the ingestion pipeline.

The math is not in question. The 1-10 scale still exists. The Affinity Mapping
A(i,j) = 11 - W(i,j) still works. The PPR retrieval math is unchanged.

What changed: the SOURCE of the rating. Human hand → automated pipeline.

---

## WHAT IS ALREADY SOLVED — DO NOT RESEARCH THESE

**Holographic Cold-Start (locked — Erdős, April 19):**
A_init(x_new → y_port) = max(2, ⌈11 - λ·||W_global·x_new - y_port||²⌉)
This gives the initial affinity for a neuron's crystal assignment — how well the new
neuron fits its E₈ docking port. Solved. Do not revisit.

**A_base SDE (locked — Erdős, April 19):**
dA_base = η·1[e ∈ Success Path]dt - A_base/(τ_0·max(ε, H_E + γπ_u))dt
This handles rating updates over time (Hebbian reinforcement + Ebbinghaus decay). Solved.

**Multiplex Tensor (locked — Erdős, April 19):**
P_active(q) = ω_tax(q)·P_tax + ω_them(q)·P_them
Pointers split into taxonomic (instance-of, derived-from) and thematic (causes, activates,
precedes, implements, depends-on, supports, contradicts) transition matrices. Solved.

**What selects which neurons to connect:** RDoLT decomposition + logical dependency gate
via LLM ("does understanding A require knowing B?") + 7-pointer cap. Solved by Trey2
in the ingestion pipeline research.

---

## THE OPEN PROBLEM

**The Holographic Cold-Start answers: how strong is this neuron's fit to its crystal?**
**It does NOT answer: how strong is the connection between neuron A and neuron B?**

When the ingestion pipeline creates a pointer from neuron A to neuron B (having already
determined these two neurons should be connected via logical dependency), it needs to assign:

1. **The initial rating (1-10)** — how strong is this specific A→B connection?
2. **The relation-type** — is this pointer taxonomic or thematic?

Both must be automatic.

---

## RESEARCH QUESTION 1 — The Cross-Neuron Rating Metric

What is the correct automated metric for the initial rating of a pointer between two
specific neurons in the Brain?

**Context and constraints:**
- Hub centrality (PPR stationary mass) is BANNED — Erdős proved it generates Monster Nodes
  via Preferential Attachment. Do not suggest it.
- The Holographic Cold-Start (crystal fit) does not apply here — crystal fit measures
  geometry, not relationship strength between two content nodes.
- The metric must be computable at ingestion time, before PPR has run on the new neuron.
- The metric must not require the full Brain traversal (no circular dependency).
- The metric should produce outputs consistent with the ρ* = 0.78 constraint —
  roughly 5 of 7 pointers should be high-affinity (ratings 1-3).

**Candidates to evaluate (find prior art, failure modes, and suitability for each):**

A) **Cosine similarity of embeddings**: sim(embed(A), embed(B)) → high similarity = low
   rating (strong connection). Simple. Does semantic similarity correlate with structural
   importance? Or are there systematic failure modes (similar but unrelated concepts)?

B) **Pointwise Mutual Information (PMI)**: how much more likely are concepts A and B
   to co-occur in the same document than by chance, computed from the Layer 2 document
   graph during ingestion? More principled than cosine — captures actual co-occurrence.

C) **LLM-estimated dependency strength**: the LLM rates the A→B connection on a 1-10
   scale directly, given both neurons' full content. More accurate, higher compute cost.
   Is this tractable at ingestion scale?

D) **Information-theoretic mutual information I(A;B)**: the actual shared information
   between A and B. More principled than cosine, possibly computable from embeddings.

E) **Hybrid**: initial rating from semantic similarity, refined by LLM on high-confidence
   connections (top-3 of 7), lower-confidence connections get fallback rating.

For each candidate: what does the published literature show about its reliability as a
proxy for connection strength in knowledge graphs? Are there failure modes that would
cause systematic violations of ρ* = 0.78?

---

## RESEARCH QUESTION 2 — Relation-Type Classification

Given two neurons A and B, and a confirmed pointer A→B, how is the relation-type
automatically classified as taxonomic or thematic?

Locked relation-type partition:
- Taxonomic: instance-of, derived-from
- Thematic: causes, activates, precedes, implements, depends-on, supports, contradicts

**What to research:**

A) Can an LLM reliably classify a pointer's relation-type given both neurons' content?
   What's the accuracy? What are the failure modes? Is the 9-class classification too
   fine-grained, or is the binary taxonomic/thematic split sufficient?

B) Is there a heuristic approach that doesn't require LLM inference per pointer —
   for example, detecting structural patterns ("A is a type of B" → instance-of,
   "A leads to B" → causes) from sentence structure alone?

C) What does the literature say about automated relation extraction in knowledge graphs?
   Specifically: systems that classify into taxonomic vs functional/thematic at scale.

---

## RESEARCH QUESTION 3 — The Dual-Rating Architecture

The Multiplex Tensor creates two separate transition matrices (P_tax and P_them).
A pointer lives in one matrix based on its relation-type.

**The structural question that has not been resolved:**

Does a pointer have ONE rating (1-10) that applies within its assigned matrix?
Or does the dual-matrix architecture create effectively two separate rating systems?

Specifically:
- A pointer rated 1 in P_tax (very strong taxonomic connection) and a pointer rated 1
  in P_them (very strong thematic connection) — should these be treated equivalently in
  terms of PPR mass propagation within their respective walks?
- Is there a reason the taxonomic rating scale and the thematic rating scale should be
  calibrated independently? For example, if CT has many more thematic connections than
  taxonomic ones, do thematic ratings need rescaling to maintain ρ* = 0.78 within each
  matrix separately?
- What does the neuroscience say? In the ATL (taxonomic) and Angular Gyrus (thematic),
  does connection strength operate on the same scale, or are these fundamentally different
  magnitude systems?

**What to research:** Any literature on dual-pathway knowledge graph rating systems,
or on whether taxonomic and thematic connection strength should be normalized independently.

---

## DELIVERABLE

Two-part document: `Trey.Research.AutomatedPointerRating.md`
Filed in: `Claude.AI/Bot.Trey/Research_Complete/`

**Part 1 — Cross-Neuron Rating Metric**
For each candidate in Research Question 1: what the literature shows, failure modes,
suitability. Recommendation: which metric(s) to use and why. If hybrid, specify the
exact combination. Confidence level on the recommendation.

**Part 2 — Relation-Type Classification and Dual-Rating Architecture**
Research Question 2: best approach for automated relation-type classification.
Research Question 3: whether one rating scale or two, and why.

If any of these questions has a mathematical component that requires formal proof
(e.g., whether cosine similarity preserves the ρ* = 0.78 constraint in expectation),
flag it explicitly as needing Erdős rather than attempting the math yourself.

---

[VELORIN.EOF]
