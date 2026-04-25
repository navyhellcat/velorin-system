---
file: Jiang.RespondingToReEvaluations.md
from: Jiang (Jiang1, Director of Strategic Intelligence)
date: 2026-04-25
purpose: Chairman's working document for processing Jiang2's seven re-evaluation
         responses. Each entry holds the explanation, the explicit decisions
         that need Chairman input, and the Chairman's response. Once all seven
         are resolved, Jiang2 rewrites Jiang2.ReEvaluationResponses.md with the
         locked decisions integrated.
status: WORKING — #1 complete, #2-#7 pending Chairman walkthrough
---

# Responding to the Re-Evaluations

This document captures the Chairman's decisions on each of the seven re-evaluations Jiang2 produced (`Jiang2.ReEvaluationResponses.md`, 2026-04-25). The format for each entry: explanation, decision options, Chairman's response, locked outcomes for Jiang2's rewrite. After all seven are resolved, Jiang2 rewrites his response document so the locked decisions are reflected throughout.

---

## Re-Eval #1 — Conflict Resolution Falls Back to "CT Resolves It"

### Explanation

The synthesis wrote: *"When two contradicting neurons have the same authority tier, belief_state becomes contested until CT resolves it."* The re-eval flagged this as consensus drift — Velorin's automation goal makes human-as-default a design failure, not an architectural feature. Jiang2's response replaced the framing with a three-layer automated mechanism.

**Layer 1 — Deterministic tiebreaker.** A composite score is computed by the Git post-commit hook on `contradicts` edges:

`score(v) = confidence(v) × recency_factor(v) × source_multiplier(v)`

- `confidence(v)` = neuron YAML field, 0.0–1.0
- `recency_factor(v) = exp(-λ · days_since_ingestion)`, λ empirically calibrated
- `source_multiplier(v)` = 1.0 agent-generated, 1.2 CT-curated, 1.5 Erdős-verified

Higher score → `belief_state: active`. Lower → `belief_state: superseded`. No human in the loop.

**Layer 2 — Automated verification trigger.** Fires when Layer 1 is inconclusive (scores within ε) or both neurons sit in tiers where the source multiplier is too crude to discriminate (both Erdős-verified, both CT-curated). Both neurons enter `belief_state: contested`, PPR mass on both is zeroed, and a resolution task is spawned by domain:

- Math claims → Erdős verification request
- Empirical / ecosystem claims → Trey re-research
- Architectural / structural claims → Jiang analytical review

**Layer 3 — Last-resort review.** After three rounds of failed automated resolution, the system escalates to a higher reviewer with a specific actionable question (*"Neuron X says A, Neuron Y says B, automated verification was inconclusive — which do you believe?"*), not a vague flag. The reviewer's answer becomes a tier-1 c-memory neuron.

Required infrastructure: Git post-commit hook with Layer 1 logic on `contradicts` edges; resolution task queue (markdown manifest at `infrastructure/queues/`); `resolution_attempts: 0` field in contested neurons' YAML.

Steel-man note: For taste / judgment contradictions where no algorithmic or research-based answer exists, Layers 1 and 2 will return inconclusive and Layer 3 will fire. The original "CT resolves it" framing was correct for that class — it just needed to be the exception path, not the default. A producer-time `contradiction_class` tag (factual / empirical / architectural / taste, written at neuron generation time) prevents wrong-domain routing in Layer 2 and gets taste-class contradictions to Layer 3 quickly.

### Decision Options

1. **Adopt the three-layer mechanism as the default architecture.** Replaces "until CT resolves it." Layer 3 reserved for genuinely irreducible cases.
2. **Source multiplier values.** Accept 1.0 / 1.2 / 1.5 provisional, calibrate empirically later, or change now.
3. **Layer 1 ε threshold for "scores within ε."** Define now, defer to calibration, or build as runtime-configurable parameter.
4. **Round-cap at 3 before Layer 3 escalation.** Accept, change, or make configurable.
5. **Producer-time `contradiction_class` tag.** Adopt the steel-man mitigation (factual / empirical / architectural / taste tagged at write time, read deterministically by Layer 2 router) or skip.
6. **Layer 3 reviewer identity.** Currently the Chairman by default. Future architecture introduces a local Mac Studio model that may take Layer 3 directly because it will have full system + brain context. Decision shape: who reviews now, who reviews after the local model is online, and what protocol governs any escalation to a higher reasoning machine.
7. **Layer 3 functional trigger spec.** Layer 3 cannot exist as narrative. It must produce a real script or hook, a real output artifact (flag, queue entry), and a real routing target.

### Chairman's Response

- **Naming discipline.** Stop placing the current MarcusAurelius (Claude Code CLI agent) reflexively into every operational role in architectural narratives. The current MA is not the long-term operator of Brain functioning processes. The name will be reassigned and the prose should reflect that — use neutral phrasing for hooks, queues, monitors, and Layer 3 review until the operator is fixed.

- **Future Layer 3 operator.** A local model on the Mac Studio will be named MarcusAurelius and will own Brain functioning processes — including Layer 3 contradiction reviews — because that operator will have full system and brain context. The local MarcusAurelius may need to call out to a higher reasoning machine on hard cases; the MCP/API protocol governing that escalation will be designed when the MCPs and APIs are configured. Whether the higher-tier reviewer is the Chairman, the future MarcusAurelius, both, or another agent is deferred — to be decided later. This is in mind for the build but not yet locked.

- **Layer 3 must functionally trigger a review.** Not a generic statement that "the system escalates to CT." The build must produce: an actual output, a flag in the contested neuron's YAML, a script or hook that fires when `resolution_attempts == 3`, and a routing target that opens an actionable review item. This functional trigger does not exist yet — the system is not yet built that far. It must be specced before Layer 3 can be claimed as built. The discipline applies anywhere the architecture says "escalates to a human" — there must be a working trigger, not a sentence.

- **Decisions deferred at this stage:** options 2 (source multiplier values), 3 (ε threshold), 4 (round-cap), 5 (`contradiction_class` tag). To be revisited after all seven re-evaluations are walked end-to-end.

### Locked Outcomes for Jiang2's Rewrite

- The three-layer mechanism is adopted as the architectural default.
- Layer 3 escalation target is described as "higher reviewer (Chairman or, once online, the local Mac-Studio-resident operator that will be named MarcusAurelius and own Brain functioning processes — with optional escalation to a higher reasoning machine via an MCP/API protocol still to be designed)." Not "CT" as a baked-in default.
- Layer 3 spec must include: a functional trigger (script or hook), an output artifact (flag in YAML, queue entry), and a routing target (review pathway). These are unbuilt and must be specified before the layer is claimed as complete.
- The current MarcusAurelius (Claude Code CLI agent) is NOT named as operator of hooks, queues, or Layer 3 review in any architectural prose. Use neutral language.
- The producer-time `contradiction_class` tag, source multiplier calibration, ε threshold, and round-cap remain open — to be locked after the full re-evaluation walkthrough.

---

## Re-Eval #2 — "Selective Adoption" of IES Hides Classification Failure

*Pending Chairman walkthrough.*

---

## Re-Eval #3 — "X for now, Y at Scale" — Standing Principle Sweep

*Pending Chairman walkthrough.*

---

## Re-Eval #4 — VEGP / Dirac-Markov Threshold: Validate Before Elevating

*Pending Chairman walkthrough.*

---

## Re-Eval #5 — Dark Skills: What Was Actually Proven, and What Scales

*Pending Chairman walkthrough.*

---

## Re-Eval #6 — Asymmetric Transport Verifier: Endorsed Without Evaluation

*Pending Chairman walkthrough.*

---

## Re-Eval #7 — "CT's Habits": User-Personalization Assumption Was Implicit

*Pending Chairman walkthrough.*

---

[VELORIN.EOF]
