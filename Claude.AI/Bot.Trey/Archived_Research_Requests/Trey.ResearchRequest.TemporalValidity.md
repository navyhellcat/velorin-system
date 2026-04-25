---
file: Trey.ResearchRequest.TemporalValidity.md
purpose: Mechanisms for detecting stale knowledge in persistent knowledge graph systems
type: Trey research request
date: 2026-04-22
priority: Medium — architectural input for Brain schema and ingestion pipeline
mode: Tight — confirm landscape + surface specific mechanisms
confidence threshold: 80% minimum
---

# Trey Research Request — Temporal Validity Mechanisms for Fast-Changing Knowledge

## Background

Jiang2 surfaced this as an unsolicited Q7 observation during Session 033 system evaluation. Velorin's Brain currently lacks any mechanism to distinguish a neuron that was accurate in April 2026 from one that is still accurate six months later. The Ebbinghaus decay SDE (Hebbian reinforcement minus time decay) handles long-term decay based on PPR traversal recency, but it does not decay based on whether the information itself has become false in the external world.

Example failure mode Velorin will definitely hit: a neuron asserting "Claude Opus 4.7 is the most capable Claude model" will decay slowly if CT frequently accesses it — but its accuracy depends on Anthropic releasing a new model, which the Brain cannot observe. The more CT relies on the neuron, the more PPR mass it accumulates; staleness does not trigger decay. The Brain will confidently route CT to outdated answers.

Jiang2 proposed a `temporality` field in neuron YAML with four values (`static | slow | fast | ephemeral`) mapping to different decay time constants in the Ebbinghaus SDE. That is a sketch, not a researched solution.

## Research Question

How do existing persistent knowledge graph systems — production-grade, 2024-2026 vintage — detect and handle stale knowledge, particularly in fast-changing domains? Specifically:

1. **Detection mechanisms.** How is staleness detected in systems that store knowledge about external states (market data, software landscape, organizational facts)? Active polling, subscription-based invalidation, embedded timestamps with validity windows, external-oracle patterns, trust-decay models?

2. **Revalidation strategies.** Once staleness is suspected, how is revalidation triggered? Automated re-retrieval, human review, confidence decay with replacement-on-conflict, other patterns?

3. **Multi-timescale knowledge.** Where a single knowledge base contains facts with wildly different validity horizons (a mathematical proof that never changes vs. a competitor product launch that changes quarterly), what schema-level mechanisms separate them?

4. **Contradiction resolution.** When a new ingestion produces a neuron contradicting an existing neuron, what provenance-weighting mechanisms are used? How do production systems decide which to keep, which to deprecate, how to link them?

5. **Empirical evidence.** Which approaches have actually shipped and survived contact with production, versus which are theoretical proposals in the literature? The Velorin bias is toward mechanisms that have demonstrated durability, not elegance.

## Deliverable

Per `Trey.OutputStandards`:

1. **Landscape matrix:** mechanism | where deployed | evidence of durability | failure modes | Velorin fit assessment
2. **Recommendation:** the specific mechanism (or minimal combination) best fit for Velorin's architecture — markdown-neuron graph, PPR retrieval, Hebbian-Ebbinghaus SDE
3. **Schema implications:** what neuron YAML fields need to exist to support the recommended mechanism, and whether they should be added now (Stage 1) or later
4. **Velorin connection:** explicit — Jiang2 proposed `temporality` field. Is that the right primitive, or is there a better pattern?

## Output Standards (mandatory)

- Plain-text LaTeX for any math per `Trey.OutputStandards.md` §2.3 and `Trey.ProjectInstructions.md` CARDINAL section. No Equation Editor.
- Apply meta-awareness per §2.2a — flag where consensus exists for genuine architectural necessity versus the specific needs of enterprise knowledge management deployments whose constraints Velorin does not share.

## Consensus Filter Note

Velorin's storage architecture is unusually constrained — markdown files in git, atomic neurons, PPR retrieval, no enterprise-grade metadata infrastructure. Most knowledge-graph research assumes richer infrastructure. Flag anywhere the published mechanism requires substrate Velorin does not have, and identify the minimum substrate upgrade needed if the mechanism is still the right answer.

[VELORIN.EOF]
