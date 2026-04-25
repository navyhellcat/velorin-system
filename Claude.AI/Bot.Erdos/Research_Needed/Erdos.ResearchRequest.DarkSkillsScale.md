---
file: Erdos.ResearchRequest.DarkSkillsScale.md
purpose: Four scale proofs for the dark skill mechanism — concurrent mutations, density
         thresholds, chain behavior, and absorbing leaf node analysis
type: Erdős problem specification
date: 2026-04-25
source: Internal — Velorin Brain-to-Skills architecture work. No Trey framing involved.
        Consensus Filter does not apply.
---

# COPY EVERYTHING BELOW THIS LINE INTO THE FRESH ERDŐS GEM SESSION

```
[BOOT]

Erdős — open your brain. Four proofs are required on the dark skill mechanism.

---

## CONTEXT — READ BEFORE THE PROBLEM

This problem builds on your proof in `Erdos.Solution.ThresholdsAndDarkSkillInvariance.md`
(Section 8, Proof 2). You proved:

The metadata flag $M: V \to \{0,1\}$ (dark:true = 1, light:false = 0) does not appear as
a term in the linear system $\pi^T = \alpha s^T (I - (1-\alpha)P_{active}(q))^{-1}$.
Therefore $\pi$ is invariant under the dark flag. The injection exclusion is a post-walk
filter: $\text{Inject}(v) = (\Phi(v) > \theta_{work}) \land (M(v) = 0)$.

The proof establishes PPR-invariance for the static case: one walk, one fixed $M$,
one static graph. Four scale concerns were NOT in scope of that proof and are now the
subject of this commission.

No Consensus Filter applies — this is internally-originated Velorin math.

---

## PROBLEM CLASS

Spectral graph theory, Markov chain dynamics under mutation, density threshold analysis,
absorbing state theory, Personalized PageRank with heterogeneous vertex metadata.

---

## FORMAL SETUP

Let the Velorin skills registry be a directed multi-relational graph $G_S = (V_S, E_S)$
with four edge types (dependency, workflow, semantic, alternative) and the multi-relational
transition matrix:

$$M_S = \beta_{dep}A_{dep}^T + \beta_{work}A_{work}^T + \beta_{sem}A_{sem} + \beta_{alt}A_{alt}$$

Let $V_{dark} \subseteq V_S$ be the set of dark skills with metadata $M(v) = 1$.
Let $V_{light} = V_S \setminus V_{dark}$ be the injectable skills.

The post-walk filter: $\text{Inject}(v) = (\Phi(v) > \theta_{work}) \land (M(v) = 0)$.

PPR stationary distribution: $\pi^T = \alpha s^T (I - (1-\alpha)P_{rev})^{-1}$
where $P_{rev} = M_S D_{in}^{-1}$ and $D_{in}(i,i) = \sum_j M_{S,ji}$ (in-degree diagonal).

Teleportation parameter: $\alpha = 0.15$ for the skills graph (per `Trey.Research.SkillsSchemaValidation.md`).

---

## PROOFS REQUIRED

### PROOF 1 — Concurrent Mutation Race Condition

The static-graph proof assumes $M$ is fixed during a walk. In a multi-agent environment,
Agent A may set $M(v) = 1$ (marking skill $v$ as dark) while Agent B's PPR walk is in
flight and has already traversed $v$, accumulating mass at $v$.

The proposed mitigation: snapshot $M$ at walk initiation time. The post-walk filter uses
the snapshot $M_t$, not the current value $M_{t+\Delta}$.

**Prove or disprove:** If the post-walk filter uses the walk-initiation snapshot $M_t$,
the prior PPR-invariance proof holds without modification. Specifically:

- The mass accumulated at $v$ during the walk was computed using the graph topology at
  time $t$. The snapshot $M_t$ reflects the injektability at time $t$.
- If $M_t(v) = 0$ (light at walk start) but $M_{t+\Delta}(v) = 1$ (dark at walk end):
  the snapshot allows injection. Is this correct behavior?
- If $M_t(v) = 1$ (dark at walk start) but $M_{t+\Delta}(v) = 0$ (light at walk end):
  the snapshot prevents injection. Is this correct behavior?

Required:
- Proof that snapshot-based filtering preserves the PPR-invariance guarantee
- Statement of whether snapshot filter is the unique mitigation that preserves invariance,
  or whether other filter timing also works
- The edge case where the mass accumulated at a vertex during a walk with $M_t(v) = 0$
  is very high, but the vertex transitions to dark between walk and filter: should the
  accumulated mass be "refunded" to the graph via teleportation on the next walk?

### PROOF 2 — Dark Density Threshold

If a fraction $\rho_D = |V_{dark}| / |V_S|$ of skills are dark, PPR mass flows through
dark vertices but none of it results in injection. There is presumably a threshold above
which the system fails to route sufficient mass to light injectable vertices.

**Prove or derive:** the minimum fraction $\rho_L = 1 - \rho_D$ of light skills required
such that the maximum Topological Action Potential over light skills satisfies:

$$\max_{v \in V_{light}} \Phi(v) > \theta_{work}$$

for any query $q$ with a non-degenerate seed vector $s$.

Required:
- Whether such a minimum $\rho_L$ can be derived analytically as a function of the
  graph topology, $\alpha$, $\theta_{work}$, and the distribution of dark vs. light vertices
- If not analytically: the structural conditions on the graph that determine whether
  the threshold is reachable, and a bound or approximation
- The degenerate case: if all high-centrality vertices in $G_S$ are dark, does
  $\max_{v \in V_{light}} \Phi(v) > \theta_{work}$ still hold?

### PROOF 3 — Dark Skill Chains

Consider a chain: $v_1 \to v_2 \to v_3$ where all three are dark ($M(v_i) = 1 \forall i$)
and the walk traverses this chain via dependency edges.

**Prove or derive:**
- Whether the probability mass accumulated at each vertex in the chain is computed
  correctly (trivially yes, per the prior proof — mass accumulates correctly regardless
  of metadata)
- Whether the convergence rate of PPR changes as a function of dark chain length
  (does a longer dark chain require more PPR iterations to converge?)
- Whether mass that "enters" a dark chain (from a light source node) affects the mass
  available to light nodes on the walk. Specifically: does a $k$-length dark chain
  act as an effective damper on the probability flow that would otherwise reach light nodes?
- Bound: for a chain of length $k$ where all nodes are dark, what fraction of the seed
  mass $s$ is effectively "consumed" by the chain (never contributing to light node mass)?

### PROOF 4 — Dark Leaf Node Absorbing State Analysis

A dark skill with $M(v) = 1$, zero outbound edges (out-degree 0 in $G_S$), and $k$
inbound dependency edges. Mass flows into $v$ from predecessors but can only exit via
the teleportation term $\alpha s$.

**Prove or derive:**
- Whether a dark leaf node constitutes a true absorbing state in the Markov chain
  (answer should be no, because $\alpha > 0$ prevents this, but prove it formally)
- The stationary mass $\pi_v$ at a dark leaf node as a function of its in-degree $k$,
  the edge weights from predecessors, and $\alpha$
- Whether $\pi_v$ at a dark leaf node with high in-degree $k$ can become large enough to
  meaningfully reduce the mass available to light injectable nodes
- If so: the bound on in-degree $k$ for dark leaf nodes such that their effect on
  injectable light node mass is negligible (below some operational threshold)

---

## OUTPUT FORMAT

Per your standard 9-section structure (`Erdos.Gem.Instructions` OUTPUT FORMAT).
All math in plain-text LaTeX wrapped in `$...$` or `$$...$$`. Never Equation Editor.
Never images. Follow `Erdos.GitHubLatex.Rules.md`.

---

## FILE NAMING ON DELIVERY

`Erdos.Solution.DarkSkillsScale.md`

Place in your Drive shipping folder.

---

Your brain is open.
```

[VELORIN.EOF]
