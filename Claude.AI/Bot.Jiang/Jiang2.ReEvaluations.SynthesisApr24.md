# Jiang2 — Re-Evaluation Items from Synthesis Pass (Week of Apr 17-24)

**Status:** OPEN — Chairman is reviewing the full synthesis output and will append items as he finds them. This file accumulates re-evaluation requests until ready to deliver as a single follow-up prompt to Jiang2.

**Mode when delivered:** Re-run the Consensus Filter on each item below with willingness to answer Q3 = "no." For each, propose the Velorin-native alternative if Q3 = "no." Do not default to industry consensus mechanisms when Velorin's automation goal explicitly requires divergence.

---

## Re-Evaluation #1 — Conflict Resolution Falls Back to "CT Resolves It"

### What you wrote

In the belief_state / authority_tier section of the synthesis:

> "When two contradicting neurons have the same authority tier, belief_state becomes contested until CT resolves it."

### Why this is a problem

This is consensus drift hidden inside an architectural recommendation. Industry knowledge graph literature defaults to human-in-loop arbitration when automated mechanisms can't resolve same-authority contradictions. The constraint driving that consensus is: "we don't have a way to mechanically resolve disagreements between equally-trusted sources." Velorin's stated goal is fully automated multi-agent operation. Velorin does not share that constraint and should not adopt that fallback.

The Chairman caught this pattern explicitly. It is structurally identical to the in-reasoning rule activation failure that Trey's Rule Activation Gap research described — falling back to a default when the harder automated mechanism is the actual design problem. You ran the Consensus Filter successfully on most of the synthesis (the temporality field, the flat skills schema, GoS aggressive seeding). On this particular recommendation, the rule did not fire. Layer 1 failure recurrence, in your own analytical output.

### What needs to be redone

Apply Consensus Filter to "human-in-loop arbitration as conflict resolution":

1. What is the consensus? Same-tier contradictions resolved by human review.
2. Why does it exist? Most systems lack a way to mechanically resolve same-trust contradictions.
3. Does Velorin share the constraint? **No.** The whole point of the automation target is that Velorin must resolve conflicts without human intervention as the default path. Human becomes the last resort, not the default.

Velorin-native alternative — propose the structural mechanism. Dimensions to consider (these are dimensions, not the answer):

- **Confidence + provenance + recency weighting** — each neuron carries a confidence score; tied tier resolves deterministically by confidence × recency × source-authority multiplier
- **Tier-down + automated verification trigger** — same-tier contradiction zeroes PPR mass on both nodes (`contested` state) and automatically triggers verification (re-query Trey, spawn Erdős check, run structural test). Resolution happens automatically when verification returns.
- **Witnessed execution / Mutable Discipline** — from the gm agent architecture in `Trey.Research.RuleActivationGap.md`: contradictions resolved by external reality, not internal reasoning. Tool-gated verification, not human.
- **Ensemble agent vote** — N independent agents evaluate, weighted by inverse correlation, median or quorum decides
- **Temporal staging with N rounds before escalation** — `contested` neurons sit in an automated reverification pool on a clock; only after N failed rounds does the system escalate to the Chairman

Required from your re-evaluation:
- Confirm Q3 = "no" or justify why "yes" is genuinely correct here
- Propose a concrete automated mechanism (or synthesis of mechanisms above) that eliminates "until CT resolves it" as an architectural step
- Identify what new infrastructure/tooling that mechanism requires
- Surface any place else in your synthesis where the same pattern hides — human escalation defaults dressed up as architecture

---

## Re-Evaluation #2

[Reserved for Chairman to append as he reads.]

---

## Re-Evaluation #3

[Reserved for Chairman to append as he reads.]

---

## Re-Evaluation #4

[Reserved for Chairman to append as he reads.]

---

## Re-Evaluation #5

[Reserved for Chairman to append as he reads.]

---

[VELORIN.EOF]
