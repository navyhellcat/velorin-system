---
file: Erdos.Problem.SynapticPruning.md
from: Trey (Deep Research) via Jiang
to: Erdős (Deep Think)
date: 2026-04-05
session: 022
status: QUEUED
---

# Mathematical Problem Specification — Synaptic Pruning for the Velorin Brain

---

## SECTION 0 — SYSTEM CONTEXT AND DESIGN GOALS

This is not a math section. Read it before touching a single formula.

**What the system is:**
The Velorin Brain is a neural file graph. Neurons are atomic markdown files (~15 lines max), each containing one idea. Neurons connect via directed, human-assigned pointer ratings (integers 1–10). Low number = strong connection. High number = weak/tangential. Maximum 7 outbound pointers per neuron. Retrieval is Personalized PageRank (PPR):

```
R = (1 - α)·P·R + α·S
```

where P is the transition matrix weighted by pointer ratings, S is the query seed vector, and α is the teleportation probability. The walk follows pointer ratings as edge weights. High-rated pointers (low integer value) propagate more relevance mass through the graph.

**What the system does:**
Serves a single user with highly personalized knowledge retrieval hundreds of times per day. Precision of retrieval is the core product. The graph is entirely human-curated — no automated extraction. Edge weights are quality judgments made by a human, not computed gradients.

**What failure looks like:**

*Failure Mode 1 — Monster Node Problem:*
Certain concept nodes accumulate inbound pointers from hundreds of neurons over time. Their betweenness centrality grows unbounded. The PPR random walk keeps getting drawn toward these nodes, spreading teleportation probability across the entire graph. Eventually PPR returns the same high-centrality nodes regardless of query. Retrieval precision collapses.

*Failure Mode 2 — Stale Neuron Noise:*
No decay mechanism exists. Outdated neurons remain in the graph with equal pointer weight, contributing noise and contradicting current neurons. The graph accumulates all history with equal weight indefinitely.

**What success looks like:**
The Brain at 5,000 neurons must return results as precise as the Brain at 200 neurons. Precision must not decay as a function of graph scale.

**The permanence constraint:**
A hard class of neurons labeled `c-memory` must never be touched by any pruning operator under any conditions. This is an absolute constraint, not a soft preference.

**Implementation environment:**
Markdown files on a filesystem. No database. Human-readable format must be preserved after any operation. Future state: Qdrant vector store as an additional index layer. Solutions requiring infrastructure not described here must flag that dependency explicitly.

---

## THREE PROBLEMS FOR ERDŐS

You are receiving three formally-specified mathematical problems. Solve each independently. Each has its own proof obligation stated at the end of its section.

---

## PROBLEM 1 — FI-Based Selective Centrality Reduction

**Problem Class:** Spectral Graph Theory and Information Geometry

**Precise Claim:**
Modulating the PPR transition matrix P by an inverse function of a node's Fisher Information — calculated over discrete, human-assigned pointer weights rather than continuous activation gradients — will selectively attenuate the random-walk gravity of high-centrality Monster Nodes without degrading the retrieval precision of the surrounding topological neighborhood.

**Formal Problem Statement:**

Let G = (V, E, W) be a directed graph where:
- V is the set of neurons
- E ⊆ V × V is the set of directed pointer edges
- W : E → {1, 2, ..., 10} is the human-assigned integer weight function

Let P be the row-normalized transition matrix of G such that:
```
P_ij = W(i,j) / Σ_k W(i,k)   if (i,j) ∈ E
P_ij = 0                       otherwise
```

Let FI(v) denote the Fisher Information of node v, computed as a measure of the sensitivity of the PPR stationary distribution R to perturbations in the edge weights incident to v. Note that W is discrete, not derived from a differentiable loss landscape.

Define a penalized transition matrix P̃ such that:
```
P̃_ij = P_ij · f(FI(v_i))^(-1)
```
where f is a monotonically increasing penalty function to be derived.

**Known Inputs:**
- G = (V, E, W) as defined above
- PPR formula: R = (1 - α)·P·R + α·S, where α ∈ (0,1) and S is a query seed vector
- W is integer-valued ∈ {1,...,10}, directional, human-assigned
- Maximum 7 outbound edges per node (enforced structurally)
- Monster Nodes are defined as nodes v where betweenness centrality β(v) > θ for some threshold θ

**Required Outputs:**
1. A formal definition of FI(v) that is valid for a discrete, non-differentiable weight function W
2. The penalty function f such that P̃ exists and remains a valid stochastic matrix
3. Proof or disproof: the PPR walk on P̃ converges to a stationary distribution R̃ where the rank-order of non-Monster Node neurons is strictly preserved compared to R on the unpenalized P

**What is not known (free parameters):**
- The penalty function f — must be derived, not assumed
- The threshold θ that defines a Monster Node — flag as a free parameter requiring empirical calibration
- Whether a discrete analog of Fisher Information exists with the required properties — this may be the crux of the proof

---

## PROBLEM 2 — Constrained GNNDelete Operator for Hard Exemptions

**Problem Class:** Topological Graph Theory and Constrained Optimization

**Precise Claim:**
Enforcing a strict zero-bounded Lipschitz continuity constraint on the deletion operator ϕ for a predefined hard exemption class of nodes C_memory will satisfy the Neighborhood Influence preservation requirement of GNNDelete while mathematically guaranteeing absolute structural permanence for the exempted nodes.

**Formal Problem Statement:**

The standard GNNDelete operator ϕ satisfies two conditions:
1. *Deleted Edge Consistency:* For any deleted edge (u,v), the representations h_u and h_v after applying ϕ are indistinguishable from representations trained without that edge.
2. *Neighborhood Influence:* For any node w in the k-hop neighborhood of deleted nodes, the representation h_w after applying ϕ approximates the representation that would result from full retraining without the deleted edges.

Standard GNNDelete assumes uniform vulnerability: any node's embedding can be modified by ϕ.

Now introduce a partition of V into two disjoint classes:
```
V = C_memory ∪ C_regular
C_memory ∩ C_regular = ∅
```

Where C_memory are permanently exempt neurons that must not have their representations altered under any conditions.

Define a modified deletion operator ϕ* such that for all v ∈ C_memory:
```
||ϕ*(h_v) - h_v|| = 0
```
(zero-bounded Lipschitz constraint — no change permitted to exempt node representations)

**Known Inputs:**
- G = (V, E, W) as defined in Problem 1
- C_memory ⊂ V is a fixed, known set identified by class label in neuron metadata
- The original GNNDelete objective function L(ϕ) combining Deleted Edge Consistency and Neighborhood Influence terms
- Target deletions are edges and nodes in C_regular only — never in C_memory

**Required Outputs:**
1. A modified objective function L*(ϕ*) that incorporates the zero-bound constraint on C_memory
2. Proof or disproof: L*(ϕ*) converges to a global minimum that simultaneously satisfies:
   - Deleted Edge Consistency for targeted obsolete nodes in C_regular
   - Neighborhood Influence for the k-hop neighborhood of deleted nodes
   - Zero alteration to any node in C_memory, including C_memory nodes in the k-hop neighborhood of deleted nodes
3. If convergence cannot be guaranteed for all three simultaneously, derive the conditions under which they conflict and state what must be sacrificed

**What is not known (free parameters):**
- The k-hop neighborhood radius — flag as free parameter
- Whether the zero-bound constraint on C_memory is compatible with the Neighborhood Influence requirement when C_memory nodes are within k hops of deleted edges — this may be the crux of the proof

---

## PROBLEM 3 — Mathematical Signal Threshold for PPR Precision

**Problem Class:** Random Matrix Theory and Markov Chains

**Precise Claim:**
In a walk-based, single-user, human-curated semantic graph, PPR retrieval precision remains above a 75% utility threshold if and only if the ratio of high-priority outbound edges to total graph edges scales logarithmically rather than linearly with total node count.

**Formal Problem Statement:**

Let G = (V, E, W) be defined as above. Define:
- n = |V| (total node count, growing over time)
- E_high ⊆ E = the set of edges with W(e) ∈ {1, 2, 3} (high-priority pointers)
- E_total = |E| (total edge count)
- ρ(n) = |E_high| / |E_total| (high-priority edge density ratio as a function of n)

Define PPR precision P(q, G) for a query q as the proportion of top-k results returned by the PPR walk that belong to the ground-truth relevant set for q.

**Known Inputs:**
- PPR formula: R = (1 - α)·P·R + α·S
- W is integer-valued ∈ {1,...,10}, human-assigned
- Maximum 7 outbound edges per node (hard structural cap)
- The 7-pointer cap already enforces local pruning: when a neuron is full, the lowest-rated pointer is demoted
- Graph is single-user, human-curated — no automated extraction noise
- Target precision threshold: P(q, G) ≥ 0.75 for the majority of queries

**Required Outputs:**
1. A formal derivation of the PPR stationary distribution R as a function of ρ(n) and n
2. The exact edge-density threshold ρ*(n) where the PPR stationary distribution transitions from a precision-preserving distribution to a uniform (precision-collapsed) distribution
3. Proof or disproof of the null hypothesis: PPR precision in a human-rated pointer graph decays linearly with total node count n. Specifically, disprove linearity by deriving whether ρ*(n) scales as O(log n), O(n), O(1), or some other function
4. The boundary conditions: state the exact values of ρ(n) and n at which precision collapse becomes mathematically inevitable given the 7-pointer structural cap

**What is not known (free parameters):**
- α (teleportation probability) — known to be in (0,1), exact value is a calibration parameter
- The exact definition of "ground-truth relevant set" for a query — flag as a measurement problem requiring empirical calibration
- Whether the 7-pointer cap creates a natural ρ(n) floor that prevents collapse — this may be the key structural insight

---

## HANDOFF NOTES FOR ERDŐS

These three problems are not independent. Problem 1 modifies the transition matrix P. Problem 3 defines the structural conditions on P under which PPR precision is preserved. Problem 1's solution must be compatible with Problem 3's threshold — a penalty function that satisfies Problem 1 but violates Problem 3's density constraint is architecturally invalid.

Problem 2 is independent of Problems 1 and 3. It operates on the deletion layer, not the retrieval layer.

If your solution to Problem 1 requires conditions that conflict with the constraints in Problem 3, state the conflict explicitly. That conflict is itself an architectural finding.

---

[ERDOS.EOF]
