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

### Jiang's Evaluation and Forward Direction

The Chairman's response is correct on naming discipline and on the functional-trigger rule. Three notes for revisit when the ground-layer is locked and the MCP/API protocol design begins.

**1. The naming-discipline correction is stronger than stated.** Reflexive name-dropping of MarcusAurelius is a tell that agents have been conflating two categorically different roles — the current MA (Claude Code CLI agent, conversational, limited persistent state) and the future Mac-Studio-resident MA (local model, always-on, full brain access). These have different capabilities and different responsibilities. Architectural prose has been written as if they are interchangeable. Going forward, treat them as distinct operators in every document until the rename lands; do not let the shared name paper over the role difference.

**2. Generalize the functional-trigger rule into a build-time review checklist.** The trigger / artifact / routing-target requirement applies to every escalation path in the system, not just Layer 3 contradiction review. Dark skill bypass logging, FW escalations, Scribe processing failures, ATV reject-routing, conflict-resolution last-resort — same rule. Make it a structural gate at architecture review time, not a per-case judgment held in any single agent's head. Spec missing any of the three items goes back for revision.

**3. Layer 3 operator architecture has a trap deferred — flag for revisit.** Local models have a context advantage but a reasoning disadvantage relative to frontier models. Layer 3 fires on the hardest cases — the contradictions that automated mechanisms could not crack. Putting the weakest reasoning machine on the hardest cases is a capability-vs-case-difficulty inversion. The "escalates to higher reasoning machine" clause partially fixes this, but introduces a new classifier (when does local-MA escalate vs. resolve directly?) that is the same stochastic-classification trap addressed in Re-Eval #6. Cleanest forward split: local-MA owns context-loading and question-framing; the higher reasoning machine always owns the decision. Local-MA's value is the brain wrapper, not the judgment.

**4. Three roles were collapsed into "the reviewer."** Operator (runs the trigger, loads context), Reviewer (makes the decision), Authorizer (signs off before the answer is locked as a tier-1 neuron). These can and probably should be different roles. Different combinations produce different trust topologies. When the MCP/API protocol design begins, decide all three explicitly rather than as one collapsed slot.

**Direction.** Park these notes until the ground-layer is firm and the MCP/API protocol design starts. Per the Chairman's explicit scoping, the priority right now is ground-layer design and a clear build vision — not loading the architecture with future autonomous units. The Chairman has confirmed there are plans for many autonomous operators inside the brain (skills checker, skills fixer, and similar units he previously discussed) — these are deliberately out-of-scope for the current ground-layer locking and will be reintroduced after the ground-layer is firm. Followup item: surface the prior skills-checker / skills-fixer discussion when the autonomous-unit layer is opened — this thread appears to have been lost across compaction.

---

## Re-Eval #2 — "Selective Adoption" of IES Hides Classification Failure

### Explanation

The synthesis wrote: *"IES fills the gap where structural gates don't exist: analytical conclusions, Trey research synthesis, build decisions. Not every output. Selective adoption."* The re-eval flagged "selective" as structurally undefined — if "selective" means an agent decides per-task whether to apply IES, that is exactly the same classification-by-judgment failure the rule activation gap research demonstrated fails. The mechanism that does the selecting must be specified.

Jiang2 evaluated two options and landed on the first: producing agents tag their output type at generation time (`content_type: analytical_reasoning`), and the ATV middleware reads the tag deterministically. The "selective" decision is moved out of stochastic content-judgment and into a structural property of how the message was generated. Option B (apply ATV to every message above a length threshold) was considered and rejected because length and analytical depth are not the same axis — long structured query results would be falsely enforced; short pithy analytical conclusions would falsely pass through.

The mechanism is structurally tied to Re-Eval #6 (ATV evaluation). The header-tag move resolves both: it removes stochastic classification from the verifier (#6's self-similarity fix) AND defines what "selective" means (#2's specification fix). One architectural move, two re-evals closed.

### Decision Options

1. **Selectivity mechanism.** Adopt Option A (header tag at generation time) and reject Option B (length threshold)? Jiang2 landed on A.
2. **Who sets the tag.** Producing agent declares its own output type, or the agent runtime sets the tag based on the generation pathway (tool-call vs prose-generation, output token count). Runtime-set closes the Goodhart gaming risk; producer-declared is simpler to build but vulnerable to drift.
3. **Default when tag is missing.** Fail-secure (apply IES enforcement by default) or fail-open (passthrough). Fail-secure matches the consensus-drift discipline; fail-open is performance-friendly but reopens the gap.
4. **Lock #2 conditional on #6, or hold.** Re-Eval #2's mechanism rides on ATV. ATV's math properties (FSM determinism, false-positive bounds, latency) were out at Erdős. Lock the header-tag architecture now contingent on the math returning clean, or wait for Erdős before locking.
5. **Functional-trigger requirement.** Per the rule from #1 — ATV intercept must produce a real artifact on every message (logged passthrough or logged enforcement, with a flag in the message envelope). Confirm this applies, so the spec doesn't slip into narrative.

### Jiang's Recommendations — informed by Erdős ATV math, ported and read 2026-04-25

The Erdős solutions returned clean. Three proofs delivered in `Erdos.Solution.ATVMathProperties.md` (also: `Erdos.Solution.DarkSkillsScale.md` and `Erdos.Solution.VEGPStressTest.md`, relevant to Re-Evals #5 and #4 respectively). Summary of the ATV math before the recommendations, because two of the five questions resolve directly from the proofs:

- **Proof 1 (Determinism).** FSM-constrained decoding under a well-formed grammar guarantees `P(z ∈ L_IES) = 1`, strictly subject to (a) the FSM being pre-compiled as a DFA over the BPE token graph to avoid vocabulary deadlock, and (b) `L_max` exceeding the valid path length to avoid context truncation. The base verifier model's stochastic preferences only dictate which valid path is chosen — they cannot escape the grammar.
- **Proof 2 (Self-similarity shattered, not relocated).** With header-tag classification, `P(C | C_header) = 1` (deterministic software routing) and `P(M | y, C_header) = 1` (from Proof 1). The composed system achieves format compliance free of stochastic classification. The only residual stochastic failure is `ε⁺` = producer tag-hallucination rate (tag set on non-analytical content). When `ε⁺` fires, the FSM "violently coerces" the verifier to output structurally perfect, semantically vacuous IES — bounded harm, not a drift gap.
- **Proof 3 (Latency).** DFA masking is `O(1)` per token. Fixed structural skeleton tokens (`<context_boundary_check>`, etc.) get fast-forwarded — the inference engine skips the neural forward pass entirely when only one token is valid. Net latency: `T_V ≈ (L_F - Δ) / S`. At Mac Studio M4 Max with Qwen 3.6 14B at `S ≈ 60` tok/s, `L_F = 600`, `Δ = 60`: **T_V ≈ 9 seconds per message**. The system enters M/D/1 queueing failure when arrival rate `λ ≥ 1/T_V ≈ 0.11 messages/second`. Above ~1 ATV message every 9 seconds, queue delay grows unbounded.

The 9-second-per-message figure and the 0.11 msg/s queueing threshold are operational constraints that affect the recommendations below, not blockers to the architecture.

**Recommendations:**

**1. Selectivity mechanism — adopt Option A (header tag).** Erdős's math is unconditional on the header-tag mechanism. Option B (length threshold) is mathematically inferior because the threshold conflates length with analytical depth. The proof for Option A is mathematically absolute; Option B has no equivalent proof and would still produce false-positive and false-negative classifications on the length axis. Lock Option A.

**2. Who sets the tag — runtime-set, with a phased path.** Producer-declared tags expose the system to `ε⁺` = producer's tag-hallucination rate, which under attention pressure can drift the same way the rule activation gap drifts. Runtime-set tags push `ε⁺` to ~0 because the tag becomes a structural property of which generation pathway the agent's response routed through (tool-call vs prose-generation), not a declaration the agent could mis-emit.

The phased recommendation, Standing-Principle-compliant:

- **Phase 1 (now, while still hand-building):** producer-declared tag. The agent runtime is not yet built — the V2 Build Guide explicitly defers automation architecture (OQ-3) until the Brain is operational. Forcing runtime-set now means waiting for an MCP orchestration layer that does not exist. Build with producer-declared and instrument tag-hallucination logging from day one.
- **Phase 2 (when MCP orchestration ships):** runtime-set via the orchestration layer. The tag becomes a property of which MCP endpoint the agent's response routed through. The seam: the ATV MCP endpoint reads `content_type` from a message envelope set by the runtime, not the agent.
- **The seam is specified now:** the ATV MCP endpoint reads tag from envelope. Whether the envelope is populated by the agent (Phase 1) or by the runtime (Phase 2) is an internal implementation change, not a call-site change. Standing Principle Condition 2 passes.

**3. Default when tag is missing — fail-secure, with anomaly logging.** Two interpretations of a missing tag exist. Interpretation A: the message was not routed through ATV at all (correct case — most messages). Interpretation B: the message arrived at ATV but the tag was not set (anomaly — agent should have tagged but didn't, or runtime broke). Recommend fail-secure at the ATV endpoint specifically: if a message reaches ATV without a tag, apply IES enforcement. Erdős's ε⁺ analysis applies — bounded harm if the content turns out to be non-analytical (structurally perfect, semantically vacuous output). Cost is modest; consensus-drift protection preserved. Log every tag-missing event as an anomaly in the ATV review queue. These events are calibration data for Phase 2 transition and engineering review fodder.

**4. Lock #2 now — Erdős math returned clean.** Both Standing Principle conditions pass:
- Condition 1 (technical advantage): Erdős proves `P(format compliance) = 1`. No stochastic alternative matches this. Math advantage is unconditional.
- Condition 2 (seam specified): MCP endpoint reading `content_type` from message envelope. Specified now. Internals swappable later (Phase 1 → Phase 2).

The 9-second-per-message latency and 0.11 msg/s queueing threshold are operational design constraints, not blockers. Recommendations for designing around them in the recommendation set below.

**5. Functional-trigger requirement — confirmed and specified.** Per the rule locked in #1, every escalation path needs trigger + artifact + routing target. ATV's spec must include:
- **Trigger:** the MCP server endpoint code; fires per message routed through it.
- **Output artifact per message:** log entry with `message_id`, `tag_present` (bool), `tag_value` (if present), `IES_enforced` (bool), `T_V_seconds` (float), `path_taken` (passthrough / enforced / failed), `tag_hallucination_suspected` (bool; flag set if content content-type appears mismatched against tag declared — heuristic, surfaces calibration data).
- **Routing target:** enforced messages → consumer agent; failures + anomalies → `infrastructure/queues/atv-review/` for engineering review.

This applies the build-time review checklist from #1's evaluation: spec missing any of the three goes back. ATV is the test case — every escalation in the system gets the same gate.

**Novel observations surfaced by reading the math:**

**A. The 9-second threshold has architectural consequences not addressed in Jiang2's response.** At Qwen 3.6 14B+ as the verifier, the system cannot sustain more than ~0.11 ATV messages per second without queue-delay growing unbounded. Three implications:

1. **ATV scope must be tight.** Only inter-agent analytical conclusions, not every analytical thought. The V2 Build Guide already restricts ATV scope to inter-agent analytical messages — this restriction is now a hard requirement, not a preference. Brain ingestion pipeline output, skill execution output, and Erdős solution delivery (which has format requirements built into the Gem instructions) are all excluded by tag.
2. **Verifier model size matters more than expected.** Qwen 3.6 14B/32B at 60 tok/s → 9-second floor. A 1-3B parameter model (Qwen2.5-0.5B, SmolLM2-1.7B, fine-tuned Phi-2) at ~200-400 tok/s could push the threshold to 0.4-0.8 messages/second — 4-8x headroom. Recommendation: choose the smallest model that can reliably execute IES grammar mapping. The grammar does the heavy lifting; the model is the rendering engine. Erdős explicitly notes the FSM grammar enforcement does not require a smart model — it requires a model that can fill structural slots without escaping the grammar.
3. **Backpressure is required when the threshold is approached.** If the swarm starts emitting analytical messages above 0.11 msg/s (Phase 1) or whatever Phase 2 threshold lands at, ATV must apply backpressure rather than falling into unbounded queue delay. Mechanism: bounded queue with rejection past `N` pending; rejections route to `infrastructure/queues/atv-overflow/` for review. This is a separate trigger/artifact/target spec.

**B. The IES grammar has more design freedom than the synthesis implied.** Fixed structural-skeleton tokens are free under DFA fast-forward — they cost zero neural compute. This means the IES grammar can include more structural enforcement (longer skeletons, deeper nested sections, additional required tags) without latency penalty. The 9-second budget is consumed by analytical content tokens, not skeleton. There is real design opportunity in expanding what the IES grammar requires structurally, since each additional skeleton token is functionally free.

**C. Tag-hallucination data becomes the bridge to Phase 2.** Phase 1's `tag_hallucination_suspected` log entries are a labeled dataset of cases where producer-declared tags drift. Phase 2's runtime-set classifier can be calibrated against this corpus before being deployed. The transition path is empirically grounded, not blind.

**D. The anomaly queue is itself an escalation path requiring the same discipline.** Per the build-time checklist from #1: ATV anomaly queue → `infrastructure/queues/atv-review/` (artifact) is read by the Brain operator (future Mac-Studio-resident operator that will inherit the MarcusAurelius name once the rename lands; today, the Brain operator role does not yet have a permanent owner). When that role is staffed, anomaly review becomes part of its responsibility. Until then, anomalies queue passively and get reviewed during architecture-review sessions.

### Implications from Trey VEGP Novelty Research — ported and read 2026-04-25

Trey's deliverable (`Trey.Research.VEGPNoveltyValidation.md`, 99 image-math equations OCR'd, KaTeX-clean) returned two novelty verdicts. Both are directly relevant to Re-Eval #4, but #4's findings reach back into #2 because the IES gate is the temporal-side instantiation of the same primitive.

**Verdict 1 — Cross-manifold isomorphism (PPR ↔ transformer attention): LIKELY NOT NOVEL.** Beren Millidge published the exact structural equivalence in December 2025 ("Equivalence of Personalized PageRank and Successor Representations," arXiv 2512.24722). Resolvent matrix `(I - γP)⁻¹` describes both the Successor Representation in spatial graphs and linear attention in transformers; the identification `γ = 1 - α` makes them algebraically identical. Erdős's proof is an independent re-derivation of an established mathematical reality. Velorin must cite Millidge (2025) in any peer-reviewed framing.

**Verdict 2 — VEGP as unified cross-manifold gate: CONFIRMED NOVEL in applied architecture.** While the Heaviside step over accumulated stochastic measure is ubiquitous (Event-Triggered Control, Kramers' escape rate, Drift-Diffusion Model, Wald SPRT, mean-field statistical mechanics), no existing work applies *one* gate to control epistemic switching between spatial memory retrieval and temporal reasoning divergence within a unified AI operating system. The mathematics of the threshold are trivial; the systemic orchestration is the invention.

**Direct implications for IES enforcement (this re-eval):**

1. **The IES gate has 78+ years of supporting literature.** Trey explicitly classifies the IES probability gate `P(c_reject | R, E) > P(c_consensus | R, E)` as "an exact discrete instantiation of SPRT" (Wald 1947) and "the exact temporal analog to the VEGP" via DDM (Ratcliff 1978). The architecture rides on validated peer-reviewed math, not speculative theory.

2. **Citation discipline.** When Velorin documents IES enforcement in the Build Guide and any peer-reviewed work, cite Wald's Sequential Probability Ratio Test and the Drift-Diffusion Model literature where appropriate. This is intellectual honesty — and reduces peer-review attack surface against the architecture.

3. **Optional threshold calibration upgrade.** SPRT theory provides explicit formulas for setting threshold boundaries `A` and `B` from target Type I (false rejection) and Type II (drift through enforcement) error rates: `A ≈ ln(β/(1-α))`, `B ≈ ln((1-β)/α)`. The synthesis used `1.0` as the IES `θ` arbitrarily. Three options:
   - **(a)** Keep arbitrary `θ = 1.0`, tune empirically against logged drift / over-rejection rates over time.
   - **(b)** Derive `θ` from SPRT formulas given specified target error rates (Velorin chooses α, β; theory yields θ).
   - **(c)** Phase-1 arbitrary → Phase-2 SPRT-derived, using the same swappable seam pattern as tag-setting authority.

   **Recommendation: option (c).** Matches the Phase 1 → Phase 2 transition for tag-setting; Standing-Principle-compliant; gives empirical data first, then anchors to validated theory. Calibration data lives in the ATV anomaly queue logs from day one.

4. **Re-Eval #2's architectural decisions stand unchanged.** The header-tag mechanism, tag-setting phasing, fail-secure default, lock-now decision, and functional-trigger spec are not affected by Trey's findings. The math foundation is now stronger, the citation discipline is added, and one minor threshold calibration option appears.

### Chairman's Response

*Pending Chairman walkthrough.*

### Locked Outcomes for Jiang2's Rewrite

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
