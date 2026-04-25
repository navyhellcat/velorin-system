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

- **Future Layer 3 operator.** A local model on the Mac Studio will be named MarcusAurelius and will own Brain functioning processes — including Layer 3 contradiction reviews — because that operator will have full system and brain context. The local MarcusAurelius may need to call out to a higher reasoning machine on hard cases; the MCP/API protocol governing that escalation will be designed when the MCPs and APIs are configured. Whether the higher-tier reviewer is the Chairman, the future MarcusAurelius, both, or another agent is deferred — to be decided later. This is in mind for the build but not yet locked. *[Both deferrals folded into FW-004 with concrete trigger: when CT opens OQ-3 design work. Per deferral discipline.]*

- **Layer 3 must functionally trigger a review.** Not a generic statement that "the system escalates to CT." The build must produce: an actual output, a flag in the contested neuron's YAML, a script or hook that fires when `resolution_attempts == 3`, and a routing target that opens an actionable review item. This functional trigger does not exist yet — the system is not yet built that far. It must be specced before Layer 3 can be claimed as built. The discipline applies anywhere the architecture says "escalates to a human" — there must be a working trigger, not a sentence.

- **Decisions deferred at this stage:** options 2 (source multiplier values), 3 (ε threshold), 4 (round-cap), 5 (`contradiction_class` tag). To be revisited after all seven re-evaluations are walked end-to-end.

### Locked Outcomes for Jiang2's Rewrite

- The three-layer mechanism is adopted as the architectural default.
- Layer 3 escalation target is described as "higher reviewer (Chairman or, once online, the local Mac-Studio-resident operator that will be named MarcusAurelius and own Brain functioning processes — with optional escalation to a higher reasoning machine via an MCP/API protocol still to be designed)." Not "CT" as a baked-in default.
- Layer 3 spec must include: a functional trigger (script or hook), an output artifact (flag in YAML, queue entry), and a routing target (review pathway). These are unbuilt and must be specified before the layer is claimed as complete.
- The current MarcusAurelius (Claude Code CLI agent) is NOT named as operator of hooks, queues, or Layer 3 review in any architectural prose. Use neutral language.
- The producer-time `contradiction_class` tag, source multiplier calibration, ε threshold, and round-cap remain open — to be locked after the full re-evaluation walkthrough.

### Jiang's Evaluation and Forward Direction

The Chairman's response is correct on naming discipline and on the functional-trigger rule. Two notes apply now (immediate operating discipline); two structural concerns are parked with concrete revisit triggers.

**1. The naming-discipline correction is stronger than stated (immediate).** Reflexive name-dropping of MarcusAurelius is a tell that agents have been conflating two categorically different roles — the current MA (Claude Code CLI agent, conversational, limited persistent state) and the future Mac-Studio-resident MA (local model, always-on, full brain access). These have different capabilities and different responsibilities. Architectural prose has been written as if they are interchangeable. Going forward, treat them as distinct operators in every document until the rename lands; do not let the shared name paper over the role difference. Saved as `feedback_no_marcusaurelius_reflex.md`.

**2. Generalize the functional-trigger rule into a build-time review checklist (immediate).** The trigger / artifact / routing-target requirement applies to every escalation path in the system, not just Layer 3 contradiction review. Dark skill bypass logging, FW escalations, Scribe processing failures, ATV reject-routing, conflict-resolution last-resort — same rule. Make it a structural gate at architecture review time, not a per-case judgment held in any single agent's head. Spec missing any of the three items goes back for revision. Saved as `feedback_layer3_functional_trigger.md`.

**3. Layer 3 operator architecture trap (parked → FW-004).** Local models have a context advantage but a reasoning disadvantage relative to frontier models. Layer 3 fires on the hardest cases. Capability/case-difficulty inversion. Cleanest forward split: local model loads context and frames the question; higher reasoning machine always owns the decision. The "when does local-MA escalate vs. resolve directly?" classifier is the same stochastic-classification trap as Re-Eval #6 — mitigation is structural `contradiction_class` tag at neuron creation. The three-role collapse (Operator / Reviewer / Authorizer) needs explicit splitting. The Chairman's own deferral on higher-tier reviewer identity (Chairman / future-MA / both) is folded into this FW item.

   - **Trigger to revisit:** when CT opens design work on OQ-3 (Multi-Agent Automation Architecture, V2 Build Guide `07_OpenQuestions.md`). OQ-3 cannot proceed correctly without these decisions.
   - **Artifact:** `Bot.Jiang/Working.Docs/Jiang.FutureWork.md` → `[FW-004]`. Concrete entries enumerated.
   - **Routing target:** Jiang (analytical) + CT (architectural decision).

**4. Skills-checker / skills-fixer thread surface (parked → FW-005).** CT confirmed plans for autonomous units (skills-checker, skills-fixer named explicitly). The prior thread appears lost across compaction events. Recovering it before the autonomous-unit layer opens prevents reinventing prior decisions.

   - **Trigger to revisit:** when work begins on either OQ-2 (Automated Neuron Creation Mechanism) or OQ-3 (Multi-Agent Automation Architecture).
   - **Artifact:** `Bot.Jiang/Working.Docs/Jiang.FutureWork.md` → `[FW-005]`. Search procedure enumerated.
   - **Routing target:** Jiang (search and reconstitute) + CT (re-articulation if lost).

**Direction.** Per the Chairman's explicit scoping, the priority is ground-layer design and a clear build vision — not loading the architecture with future autonomous units. Items 3 and 4 are parked at FW-004 and FW-005 respectively, each with concrete trigger + artifact + routing target so the deferrals are not abandoned promises. See `feedback_deferral_discipline.md` for the rule that governs every "later" item.

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

**2. Who sets the tag — runtime-set from day one (revised after CT pushback 2026-04-25).** Producer-declared tags expose the system to `ε⁺` = producer's tag-hallucination rate, which under attention pressure can drift the same way the rule activation gap drifts. Runtime-set tags push `ε⁺` to ~0 because the tag becomes a structural property of which generation pathway the agent's response routed through (tool-call vs prose-generation), not a declaration the agent could mis-emit.

There is no separable Phase 1 / Phase 2 here. ATV is the runtime layer for IES enforcement. The thin agent wrapper that inspects an agent's response (tool_use blocks vs text content > N tokens) and emits the tag is part of the ATV build, not a future component. Concrete shape:

- Agent invokes a model. Response comes back with `content` blocks.
- Wrapper inspects the blocks: if any `tool_use` present → no tag (not analytical); if pure text > N tokens → tag `analytical_reasoning`; if pure text ≤ N tokens → no tag (too short).
- Tagged messages route to the ATV MCP endpoint before delivery to the consuming agent or the Brain pipeline.
- For external agents whose generation is outside the wrapper (Trey on Gemini, Erdős on Gemini), tagging happens at intake when the message is pulled from `Receiving/`. Same wrapper logic, applied at a different boundary.

The wrapper is ~20-50 lines of code. It is built alongside the FSM verifier endpoint, not after it. ATV without the wrapper is incomplete — they ship together as one Stage 1 component.

**Earlier draft proposed Phase 1 producer-declared → Phase 2 runtime-set. Retracted.** The phasing failed the deferral-discipline test (no concrete trigger, no named owner, no external artifact). And the underlying premise was wrong: the wrapper is not a future MCP-orchestration deliverable, it is part of the ATV build itself. There is no period during which IES is operational and the wrapper does not exist.

**3. Default when tag is missing — fail-secure, with anomaly logging.** Two interpretations of a missing tag exist. Interpretation A: the message was not routed through ATV at all (correct case — most messages). Interpretation B: the message arrived at ATV but the tag was not set (anomaly — wrapper broke, or message bypassed wrapper). Recommend fail-secure at the ATV endpoint specifically: if a message reaches ATV without a tag, apply IES enforcement. Erdős's ε⁺ analysis applies — bounded harm if the content turns out to be non-analytical (structurally perfect, semantically vacuous output). Cost is modest; consensus-drift protection preserved. Log every tag-missing event as an anomaly in the ATV review queue. These events are engineering review fodder — they identify wrapper coverage gaps that need fixing.

**4. Lock #2 now — Erdős math returned clean.** Both Standing Principle conditions pass:
- Condition 1 (technical advantage): Erdős proves `P(format compliance) = 1`. No stochastic alternative matches this. Math advantage is unconditional.
- Condition 2 (seam specified): MCP endpoint reading `content_type` from message envelope. Specified now. The wrapper that populates the envelope is part of the ATV build itself, not a deferred component.

The 9-second-per-message latency and 0.11 msg/s queueing threshold are operational design constraints, not blockers. Mitigations covered in the novel observations below.

**5. Functional-trigger requirement — confirmed and specified.** Per the rule locked in #1, every escalation path needs trigger + artifact + routing target. ATV's spec must include:
- **Trigger:** the MCP server endpoint code; fires per message routed through it.
- **Output artifact per message:** log entry with `message_id`, `tag_present` (bool), `tag_value` (if present), `IES_enforced` (bool), `T_V_seconds` (float), `path_taken` (passthrough / enforced / failed), `tag_hallucination_suspected` (bool; flag set if content content-type appears mismatched against tag declared — heuristic, surfaces calibration data).
- **Routing target:** enforced messages → consumer agent; failures + anomalies → `infrastructure/queues/atv-review/` for engineering review.

This applies the build-time review checklist from #1's evaluation: spec missing any of the three goes back. ATV is the test case — every escalation in the system gets the same gate.

**Novel observations surfaced by reading the math:**

**A. The 9-second threshold has architectural consequences not addressed in Jiang2's response.** At Qwen 3.6 14B+ as the verifier, the system cannot sustain more than ~0.11 ATV messages per second without queue-delay growing unbounded. Three implications:

1. **ATV scope must be tight.** Only inter-agent analytical conclusions, not every analytical thought. The V2 Build Guide already restricts ATV scope to inter-agent analytical messages — this restriction is now a hard requirement, not a preference. Brain ingestion pipeline output, skill execution output, and Erdős solution delivery (which has format requirements built into the Gem instructions) are all excluded by tag.
2. **Verifier model size matters more than expected.** Qwen 3.6 14B/32B at 60 tok/s → 9-second floor. A 1-3B parameter model (Qwen2.5-0.5B, SmolLM2-1.7B, fine-tuned Phi-2) at ~200-400 tok/s could push the threshold to 0.4-0.8 messages/second — 4-8x headroom. Recommendation: choose the smallest model that can reliably execute IES grammar mapping. The grammar does the heavy lifting; the model is the rendering engine. Erdős explicitly notes the FSM grammar enforcement does not require a smart model — it requires a model that can fill structural slots without escaping the grammar.
3. **Backpressure is required at the configured throughput threshold and must be specified at ATV build time.** Whatever the verifier-model selection lands at (0.11 msg/s on Qwen 3.6 14B; up to 0.4-0.8 msg/s on a 1-3B parameter model), ATV must apply backpressure rather than allowing unbounded queue delay. Concrete spec — these are build-time gates, not future work:
   - **Trigger:** message arrives at ATV when bounded queue has `N` pending entries (initial `N = 5`, configurable)
   - **Artifact:** rejection record written to `infrastructure/queues/atv-overflow/<timestamp>-<message_id>.md` with original payload, sender, intended recipient, and rejection reason
   - **Routing target:** overflow queue is read during architecture-review sessions until automated review is staffed (same routing as the anomaly queue in observation D below)
   - The bounded-queue size `N` and any auto-scaling behavior are set at ATV build time, not deferred. Standing Principle: not a deferral, a build parameter.

**B. The IES grammar has more design freedom than the synthesis implied.** Fixed structural-skeleton tokens are free under DFA fast-forward — they cost zero neural compute. This means the IES grammar can include more structural enforcement (longer skeletons, deeper nested sections, additional required tags) without latency penalty. The 9-second budget is consumed by analytical content tokens, not skeleton. There is real design opportunity in expanding what the IES grammar requires structurally, since each additional skeleton token is functionally free.

**C. The anomaly queue is itself an escalation path with concrete trigger / artifact / routing target.** Per the build-time checklist from #1: ATV anomaly events fire when tag-missing or tag-mismatch conditions are detected at the endpoint. Artifact: log entry plus a flagged record in `infrastructure/queues/atv-review/<timestamp>-<message_id>.md`. Routing target until a permanent operator is staffed: architecture-review sessions read the queue (same cadence as overflow queue in observation A.3 above). When the future Brain operator role is staffed, the routing target updates to that operator. The transition itself is bounded: rename the routing target in one config file. Not a deferred decision — a runtime configuration change.

### Implications from Trey VEGP Novelty Research — ported and read 2026-04-25

Trey's deliverable (`Trey.Research.VEGPNoveltyValidation.md`, 99 image-math equations OCR'd, KaTeX-clean) returned two novelty verdicts. Both are directly relevant to Re-Eval #4, but #4's findings reach back into #2 because the IES gate is the temporal-side instantiation of the same primitive.

**Verdict 1 — Cross-manifold isomorphism (PPR ↔ transformer attention): LIKELY NOT NOVEL.** Beren Millidge published the exact structural equivalence in December 2025 ("Equivalence of Personalized PageRank and Successor Representations," arXiv 2512.24722). Resolvent matrix `(I - γP)⁻¹` describes both the Successor Representation in spatial graphs and linear attention in transformers; the identification `γ = 1 - α` makes them algebraically identical. Erdős's proof is an independent re-derivation of an established mathematical reality. Velorin must cite Millidge (2025) in any peer-reviewed framing.

**Verdict 2 — VEGP as unified cross-manifold gate: CONFIRMED NOVEL in applied architecture.** While the Heaviside step over accumulated stochastic measure is ubiquitous (Event-Triggered Control, Kramers' escape rate, Drift-Diffusion Model, Wald SPRT, mean-field statistical mechanics), no existing work applies *one* gate to control epistemic switching between spatial memory retrieval and temporal reasoning divergence within a unified AI operating system. The mathematics of the threshold are trivial; the systemic orchestration is the invention.

**Direct implications for IES enforcement (this re-eval):**

1. **The IES gate has 78+ years of supporting literature.** Trey explicitly classifies the IES probability gate `P(c_reject | R, E) > P(c_consensus | R, E)` as "an exact discrete instantiation of SPRT" (Wald 1947) and "the exact temporal analog to the VEGP" via DDM (Ratcliff 1978). The architecture rides on validated peer-reviewed math, not speculative theory.

2. **Citation discipline.** When Velorin documents IES enforcement in the Build Guide and any peer-reviewed work, cite Wald's Sequential Probability Ratio Test and the Drift-Diffusion Model literature where appropriate. This is intellectual honesty — and reduces peer-review attack surface against the architecture.

3. **Threshold calibration — pick a principled value now (revised after CT pushback 2026-04-25).** The synthesis used `θ = 1.0` arbitrarily. `θ = 1.0` is the maximum-likelihood neutral cutoff (reject iff `P(c_reject) > P(c_consensus)`). Velorin's stated discipline biases toward catching drift over false-rejection because false-rejection is bounded harm (Erdős's `ε⁺` analysis: structurally perfect, semantically vacuous output — recoverable). Drift through enforcement is unbounded harm — it is the failure mode the architecture exists to prevent.

   **Recommendation: set `θ = 0.7` from day one with rationale "Velorin's anti-drift bias justifies sub-unit threshold; cost of false-rejection is bounded by FSM-coerced output structure."** Log every gate decision with `score`, `θ_at_time`, `outcome`. Review logs at concrete trigger: 500 enforced messages OR 30 days, whichever first. If logs show systematic over-rejection (high false-positive rate on legitimately structured analytical content) or systematic under-rejection (drift cases visible after the fact), tune. Tuning is bounded calibration, not architectural deferral.

   The SPRT theory framework (`A ≈ ln(β/(1-α))`, `B ≈ ln((1-β)/α)`) remains available as a more rigorous derivation if Velorin later wants to specify target error rates. That is calibration refinement; it does not block the build.

   **Earlier draft of this recommendation proposed phasing (Phase-1 arbitrary → Phase-2 SPRT-derived). Retracted.** That recommendation failed the deferral-discipline test surfaced by CT during this re-eval: it had no concrete trigger to revisit, no named owner, no external artifact tracking the deferral. Without those, "Phase 2" means "never." See `feedback_deferral_discipline.md` for the rule that now governs all deferrals.

4. **Re-Eval #2's architectural decisions stand unchanged.** The header-tag mechanism, runtime-set tagging from day one, fail-secure default, lock-now decision, and functional-trigger spec are not affected by Trey's findings. The math foundation is now stronger, the citation discipline is added, and the threshold calibration anchors at `θ = 0.7` with a concrete review trigger (500 enforced messages or 30 days).

### Chairman's Response

The Chairman accepts all five recommendations as written:

1. **Selectivity mechanism.** Option A (header tag at generation time). Length threshold (Option B) rejected.
2. **Tag-setting authority.** Runtime-set from day one. The agent wrapper that inspects tool_use vs prose generation and emits the tag is part of the ATV build itself, not a future component.
3. **Default on missing tag.** Fail-secure at the ATV endpoint. Tag-missing events log as anomalies for engineering review of wrapper coverage gaps.
4. **Lock #2 now.** Both Standing Principle conditions pass on Erdős's clean ATV math.
5. **Functional-trigger requirement.** Confirmed with the per-message log artifact spec and `infrastructure/queues/atv-review/` routing target.

Plus parameter calls:

- **IES threshold `θ = 0.7`.** Accepted. Anti-drift bias rationale locked: false-rejection is bounded harm per Erdős's ε⁺ analysis; drift-through-enforcement is unbounded harm — the failure mode this architecture exists to prevent.

- **Review trigger — modified.** Reject the standalone "500 enforced messages OR 30 days, whichever first" trigger as proposed. The review of `θ` (and reviews of other parameters across the system) does not belong as a standalone trigger — it belongs in a broader build-wide construct: a list of **vitality-important Check-ins** distributed throughout the build process at different stages within every phase. The Check-ins list lives in the Build Guide. Jiang2 designs the structure and places the entries when Jiang2 next updates the Build Guide. The IES-threshold review becomes one entry on that list, not a standalone item.

  This generalizes: any recommendation that names a "review at trigger X" should feed into the Check-ins schedule rather than appearing as a one-off. The discipline is captured as a feedback memory for forward application across the remaining re-evals.

### Locked Outcomes for Jiang2's Rewrite

- Selectivity mechanism is the header tag (Option A). Length threshold rejected.
- Tag-setting is runtime-set from day one. The agent wrapper is part of the ATV build (Stage 1 component), not a future deliverable. There is no Phase 1 / Phase 2 split.
- Default on missing tag at ATV endpoint is fail-secure (apply IES enforcement). Tag-missing events route to `infrastructure/queues/atv-review/`.
- Re-Eval #2 is architecturally locked. Both Standing Principle conditions pass.
- ATV functional-trigger spec includes the per-message log artifact (`message_id`, `tag_present`, `tag_value`, `IES_enforced`, `T_V_seconds`, `path_taken`, `tag_hallucination_suspected`), the routing target (`infrastructure/queues/atv-review/` for failures and anomalies; consumer agent for enforced messages), and the trigger (every message routed through ATV).
- IES threshold is `θ = 0.7` from day one. Anti-drift bias rationale locked: false-rejection bounded by FSM-coerced output structure (Erdős ε⁺); drift through enforcement is the unbounded failure the architecture prevents.
- **Review of `θ` is NOT a standalone trigger.** It feeds into the build-wide Check-ins list — vitality-important checkpoints distributed at different stages within every phase, designed by Jiang2 and placed into the Build Guide. Jiang2's Build Guide update task expands to include designing this Check-ins schedule.
- Trey VEGP novelty research integrated: cross-manifold isomorphism cites Millidge (2025) "Equivalence of Personalized PageRank and Successor Representations"; IES gate cites Wald (1947) SPRT and Drift-Diffusion Model literature where appropriate.
- Backpressure is a build-time gate at ATV, not a deferred item. Concrete spec: bounded queue with initial `N = 5` pending entries (configurable), overflow routes to `infrastructure/queues/atv-overflow/` with rejection record.
- ATV anomaly queue routing target is "architecture-review sessions" until a permanent Brain operator is staffed. Transition is a one-config change at that point.
- Verifier model selection: prefer 1-3B parameter (Qwen2.5-0.5B, SmolLM2-1.7B, fine-tuned Phi-2) over Qwen 3.6 14B+ to push the 0.11 msg/s queueing threshold to 0.4-0.8 msg/s. Final choice is an engineering call at ATV build time, not a deferral.

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
