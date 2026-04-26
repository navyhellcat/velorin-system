---
file: Erdos.ResearchRequest.GhostConnectionPriority.md
purpose: Derive a principled priority ranking for ghost connections (undone architectural promises)
         potentially using PPR mass accumulation as a relevance signal
type: Erdős problem specification
date: 2026-04-26
source: Jiang2.WholeSystemReimagining.Synthesis.md Section 11, Math Gap 3
        Internal synthesis — Consensus Filter does not apply
---

# COPY EVERYTHING BELOW THIS LINE INTO THE FRESH ERDŐS GEM SESSION

```
[BOOT]

Erdős — open your brain. One derivation is required.

---

## CONTEXT — READ BEFORE THE PROBLEM

This problem originates from Jiang2's whole-system re-imagining synthesis (2026-04-26).
Internal origin — Consensus Filter does not apply.

**Background:** The Velorin system has accumulated "ghost connections" — architectural
promises that were mentioned as "we should do X" or "this will be designed later" but
were never converted into hard work items with concrete triggers. Examples include: the
skills-checker/skills-fixer thread, the intake test design, the H_E measurement protocol,
the Layer 3 operator architecture, the KVM bridge implementation.

When multiple ghost connections exist simultaneously, which should be resurrected first?
There must be a principled ordering.

**The conjecture (THEORY — requires proof):**

Ghost connection resurrection priority may have an analog in the Brain's PPR mass
accumulation. A ghost connection is relevant if many of the Brain's most-accessed neurons
depend on it. A ghost connection has high Priority if the Brain's PPR walks frequently
pass through the region where that undone promise would have created connections.

Formally: define the "relevance mass" of a ghost connection $g$ as the total PPR mass
accumulated by neurons that would be affected if $g$ were completed:

$$\text{relevance}(g, q) = \sum_{v \in \text{affected}(g)} \pi_v^{(q)}$$

where $\pi^{(q)}$ is the stationary distribution for query $q$ and $\text{affected}(g)$
is the set of neurons that would gain new pointers or connections if $g$ were resolved.

The ghost connection with highest average relevance mass across a representative sample
of CT's queries should be resurrected first.

---

## PROBLEM CLASS

Priority scheduling with dynamic relevance weights, PPR-based relevance propagation,
optimal sequential decision theory.

---

## FORMAL SETUP

Let $G = \{g_1, \ldots, g_k\}$ be the set of ghost connections.

For each ghost connection $g_i$, define:
- $\text{affected}(g_i) \subseteq V$: the set of Brain neurons that would gain new
  connections if $g_i$ were completed (estimated from the architectural intent)
- $\text{cost}(g_i) \in \mathbb{R}^+$: the engineering cost to complete $g_i$
- $\text{dependency}(g_i, g_j) \in \{0, 1\}$: whether completing $g_i$ requires
  completing $g_j$ first

For a query distribution $\mathcal{D}$ over CT's queries:
$$\text{priority}(g_i) = \frac{1}{|\mathcal{D}|} \sum_{q \in \mathcal{D}} \text{relevance}(g_i, q) / \text{cost}(g_i)$$

**The question:** Is this priority function correct? Can it be derived from first principles
as the optimal scheduling policy?

---

## DERIVATION REQUIRED

Derive the optimal ghost connection resurrection order as a priority scheduling problem:

1. Under what assumptions on $\mathcal{D}$ (the query distribution) and the dependency
   structure among ghost connections does the ratio `relevance/cost` yield the optimal
   scheduling policy?

2. How does the PPR stationary distribution $\pi^{(q)}$ propagate through the dependency
   graph? If completing $g_1$ enables $g_2$ which enables $g_3$, how should the priority
   calculation account for the cascade value?

3. Is there a simpler proxy for relevance that does not require running PPR queries
   for every ghost connection × query pair? (E.g., the out-degree of affected neurons,
   their authority_tier, their region's commutator norm?)

4. How should the priority function be updated as ghost connections are completed?
   (Each completion changes the Brain's PPR topology, which changes the relevance of
   remaining ghost connections.)

---

## OUTPUT FORMAT

Per your standard 9-section structure. All math in plain-text LaTeX wrapped in `$...$`
or `$$...$$`. Never Equation Editor. Never images. Follow Erdos.GitHubLatex.Rules.md.

---

## FILE NAMING ON DELIVERY

`Erdos.Solution.GhostConnectionPriority.md`

Place in your Drive shipping folder.

---

Your brain is open.
```

[VELORIN.EOF]
