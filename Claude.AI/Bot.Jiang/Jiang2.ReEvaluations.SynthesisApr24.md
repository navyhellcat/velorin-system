# Jiang2 — Re-Evaluation Items from Synthesis Pass (Week of Apr 17-24)

**Status:** OPEN — Chairman is reviewing the full synthesis output and will append items as he finds them. This file accumulates re-evaluation requests until ready to deliver as a single follow-up prompt to Jiang2.

**Mode when delivered:** Re-run the Consensus Filter on each item below with willingness to answer Q3 = "no." For each, propose the Velorin-native alternative if Q3 = "no." Do not default to industry consensus mechanisms when Velorin's automation goal explicitly requires divergence.

---

## STANDING PRINCIPLE — Applies to Every Re-Evaluation Below

**Defer implementation if and only if both of these are true:**

1. Deferring has a legitimate technical advantage over building now (not "it's complicated," not "we'll get to it later," not "we don't fully understand Y yet" — a concrete technical reason why building now is worse than building later)
2. The architecture today is designed such that the deferred implementation plugs in easily later (the seam exists, is specified, and downstream components are built against it from day one)

If either condition fails, build now.

If condition 1 fails: there is no technical reason to defer, so deferral is laziness or avoidance. Build now.

If condition 2 fails: deferring will cost a system overhaul later, not an implementation swap. Build now.

This principle applies to every recommendation in the synthesis, not just the items flagged in the re-evaluations below. Sweep every place you used "X for now, Y at scale," "selective," "for Phase 1," "evaluate later," "adopt when scale demands it," or similar deferral language. Apply both conditions. Resolve to one of: build now, defer with legitimate technical advantage AND specified seam, or commit-forever to the current choice and remove the deferred option from the schema.

The Chairman has flagged the recurrence of "X for now, Y later" as the most dangerous pattern in the synthesis. Three or four such deferrals stacked together do not produce three or four implementation swaps later. They produce a system overhaul during the period when the system is supposed to be running. That cost is asymmetric and compounding.

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

## Re-Evaluation #2 — "Selective Adoption" of IES Hides the Same Classification Failure

### What you wrote

In the "What is consensus drift in disguise" section, item 2:

> "Universal IES injection — Trey recommended applying to all Level 4 agent outputs. Consensus exists because other systems have no structural gates at all. Velorin is building structural gates (TAP, GoS reverse-PPR). IES fills the gap where structural gates don't exist: analytical conclusions, Trey research synthesis, build decisions. Not every output. Selective adoption."

### Why this is a problem

"Selective adoption" without specifying the enforcement mechanism reintroduces the same classification failure that Trey's Rule Activation Gap research, the Chairman's earlier pushback, and your own synthesis section on the Asymmetric Transport Verifier all identify as the actual problem.

If "selective" means "an agent decides per task whether this output is analytical and therefore needs IES," then:

- Sender-side selection requires the prompting agent to correctly classify what the receiving agent's task is. The Chairman explicitly identified this failure mode: *"If the agents that are prompting other agents don't know when and why to insert hooks in their prompts, then this will never work."* In an automated multi-agent system, sender classification is the same blind spot we're trying to fix.
- Receiver-side selection-by-judgment requires the receiving agent to self-classify its own output type before applying IES. That self-classification is itself a discipline-by-judgment gate with the same Layer 1 activation failure. The agent can decide "this isn't really analytical" mid-conclusion the same way it can decide "the Consensus Filter doesn't really apply here."

The substrate of "selective adoption" must be a structural mechanism, not a per-task classification. You already proposed the right answer in section 4 of the synthesis (the Asymmetric Transport Verifier as transport-layer enforcement). The "selective adoption" framing here is in tension with that answer because it doesn't specify which mechanism does the selecting.

### What needs to be redone

Reconcile the two halves of your own synthesis. Specifically:

1. State explicitly what does the selecting in "selective adoption." If the answer is "the ATV middleware reads the raw output and decides based on content whether it's an analytical conclusion that needs IES structure," then say so — and connect it directly to the ATV section. If the answer is something else, name that mechanism with the same precision.
2. If no structural mechanism is specified for "selective" — i.e., if the answer is genuinely "an agent decides" — that is consensus drift. Re-run the Consensus Filter on it: industry consensus is "agents apply discipline by judgment," constraint is "we can't tool-gate every output," Velorin's automation goal makes Q3 = no. Velorin needs the structural answer.
3. If selective enforcement ends up requiring per-output content classification (analytical vs not), define what that classifier looks like operationally. Is it a small local model? A regex-and-keywords heuristic in the ATV? A learned filter? Some other primitive? "We'll figure out which outputs need IES" is not an answer the build can ship on.
4. Surface anywhere else in the synthesis where "selective" or "where appropriate" or similar language is used without specifying the structural mechanism that makes the selection. Same pattern, same fix.

The acceptable end state: every place IES is supposed to fire, there is a deterministic mechanism that fires it without an agent making a classification decision.

---

---

## Re-Evaluation #3 — "X for now, Y at scale" without naming the architectural seam

### What you wrote

In the "What is consensus drift in disguise" section, item 4:

> "GoS aggressive seeding machinery — sparse LLM validation, hybrid semantic-lexical seeding. Benchmark artifacts for 2000-skill libraries. Velorin starts with <100 skills. Dense exhaustive validation is fine at this scale. Adopt when scale demands it."

### Why this is a problem

You used "X for now, Y at scale" framing without specifying where Y plugs in. The Chairman has now flagged this pattern multiple times across multiple sessions and it keeps recurring. The problem is not that your technical analysis is wrong. Dense exhaustive validation at <100 skills is genuinely simpler than GoS's sampling machinery, and the optimization is genuinely premature at our starting scale. The problem is the framing.

"Adopt when scale demands it" assumes that swapping dense for sparse later is a change of implementation, not architecture. That assumption is true only if:

- The validator is built as a clean module with a defined interface from day one (e.g., `validate(candidate_edges) → validated_edges`), so swapping the implementation is a one-line change
- Downstream agents do not have hardcoded assumptions about validator behavior baked into the call sites
- The data shape produced by dense and sparse validation is identical (which it likely is — both produce the same edge records, just via different verification methods)

If those conditions are met, "ship dense now, swap later" is fine. If they are not, "swap later" is "rewrite later," and at scale you will be doing that rewrite while debugging emergent behavior of a Brain that has been live for months. That is the failure mode the Chairman has been flagging across this entire week of synthesis.

The Chairman's standing principle is at the top of this file. Defer implementation if and only if (a) deferring has a legitimate technical advantage over building now AND (b) the architecture is designed today such that the deferred implementation plugs in easily later. Both conditions, not either. Failure on either condition means build now.

Apply both conditions to this item:
- **Condition 1 (legitimate technical advantage to deferring):** Is there a concrete technical reason that dense validation now is technically better than sparse from day one, beyond "it's simpler"? Simpler is not automatic technical advantage. If the only argument is "we don't need the optimization yet," that may not pass. Argue this case explicitly.
- **Condition 2 (architectural seam exists today):** If condition 1 passes, is the validator built behind a clean module interface so swapping to sparse later is a one-line change? Specify the interface or admit it does not exist.

If both conditions pass, this is a legitimate deferral. If either fails, change the recommendation.

The recurrence pattern matters more than this one item. Every "X for now, Y at scale" or "ok for now, build Y later" recommendation in your synthesis needs to be re-examined under this principle. If three or four of these are stacked, the cumulative retrofit cost at scale is not three or four small changes — it is a system overhaul.

### What needs to be redone

Two-part response on this item, then a sweep of the rest of the synthesis.

**For the GoS sparse-validation item specifically:**

1. Argue condition 1 explicitly. State the concrete technical advantage of deferring sparse validation, beyond "it is simpler" or "we do not need it yet." If the only argument is operational simplicity, that may not pass — operational simplicity is not automatic technical advantage when the cost of swapping later is high.
2. If condition 1 passes, address condition 2: state whether the dense validator will be built behind a clean module interface that supports swapping to sparse later without changes to call sites, downstream schema, or expectations. Yes or no.
3. If condition 2 yes: sketch the interface — function signature, input shape, output shape, what other components depend on it, what they assume.
4. If either condition fails: change the recommendation. Either commit to dense forever (state explicitly that Velorin will not move to sparse validation at any scale) or commit to building sparse from the start.

The acceptable end state for this item is one of: dense forever, sparse from day one, or dense behind a swappable interface where both conditions of the Standing Principle are satisfied with explicit reasoning.

**For the broader sweep across the entire synthesis:**

5. Walk every other place in the synthesis where you used "X for now, Y at scale" or "selective," "for Phase 1," "evaluate later," "adopt when scale demands it," "additive — no retrofit debt," or any similar deferral language.
6. For each, apply both conditions of the Standing Principle.
7. List every item you swept. For each, show the result: build-now / defer-with-conditions-passed-and-seam-specified / commit-forever. No item gets to keep its deferral framing without explicit pass on both conditions.

This is the highest-leverage discipline pass on the synthesis. Three items hidden inside "we'll fix it at scale" become a system overhaul. The Chairman's instinct that this is the most dangerous pattern in the synthesis is correct.

---

---

## Re-Evaluation #4

[Reserved for Chairman to append as he reads.]

---

## Re-Evaluation #5

[Reserved for Chairman to append as he reads.]

---

[VELORIN.EOF]
