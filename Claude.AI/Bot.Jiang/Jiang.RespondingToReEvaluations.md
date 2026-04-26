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

### Explanation

The synthesis used "X for now, Y at scale" framing for several architectural deferrals (GoS sparse validation, RoMem Semantic Speed Gate, θ_work empirical calibration, ATV, bi-temporal validity windows from Graphiti, 9-class label vs 4-type edge ontology reconciliation). The re-eval flagged that the framing was technically defensible but failed to explicitly run the Standing Principle's Condition 2 — was the architectural seam specified now, so the deferred implementation can plug in easily later?

Jiang2's response ran the full sweep against both Standing Principle conditions. Verdicts split four ways:

- **Defer with seam specified** — GoS sparse validation, RoMem, θ_work
- **Drop forever (not defer)** — Graphiti bi-temporal validity windows
- **Blocked on Re-Eval #6** — ATV (now resolved post-Erdős math; ATV is BUILD NOW per Re-Eval #2 lock)
- **Promote to BUILD NOW** — 9-class label vs 4-type edge reconciliation

The most consequential outcome: edge ontology unification moves from "hole that needs filling" to immediate pre-pipeline task. It must happen before either the Brain ingestion pipeline or the skills dependency graph is built, because building both with divergent edge schemas creates the exact retrofit cost the Standing Principle is trying to prevent.

### Sweep — item by item

Standing Principle (CT's exact wording, locked Session 035): Defer implementation IFF both (a) legitimate technical advantage to deferring AND (b) architecture seam specified now. Either fails → build now.

**1. GoS sparse validation.** Dense exhaustive validation handles edge candidates fine at <100 skills. Sparse adds sampling, hybrid seeding, LLM-estimation infrastructure — pure overhead at small scale. Condition 1 passes. Condition 2 satisfied by the interface `validate_skill_edges(candidate_edges, skill_graph, validation_mode="dense")` built from day 1. Mode swap to `"sparse"` later is a one-line config change at initialization. **Defer with seam.**

**2. RoMem Semantic Speed Gate.** RoMem (rotational memory geometry) requires Layer 0 LoRa, which is Stage 5 — deferred until Brain operational and a local base model is selected. Condition 1 passes (the prerequisite doesn't exist). Condition 2 satisfied *only if* PPR is built to call `compute_edge_transition_weight(source, target, query_context, mode="ebbinghaus_sde")` from day 1. If PPR inlines the weight computation, retrofit cost is high. **Defer with the explicit constraint: PPR implementation must call through this function, never inline.**

**3. θ_work empirical calibration.** Can't calibrate without ingestion data. Condition 1 trivially passes. Condition 2 trivially passes — `skill_injection_threshold: float` is a runtime config parameter, not a hardcoded value. **Defer.**

**4. Asymmetric Transport Verifier.** At time of Jiang2's response, Re-Eval #6 was unresolved. Post-Erdős ATV math (returned 2026-04-25, ported and read this session): both Standing Principle conditions pass. ATV is BUILD NOW per Re-Eval #2 lock. The "defer" status no longer applies — superseded.

**5. Bi-temporal validity windows (from Graphiti).** Requires a graph database Velorin doesn't have. Condition 1 passes. Condition 2 N/A — Velorin already committed to *dropping* this pattern, not deferring it. **Drop permanently.**

**6. 9-class label vs 4-type edge reconciliation.** Brain pointer graph uses 9 relation types (instance-of, derived-from, causes, activates, precedes, implements, depends-on, supports, contradicts). Skills dependency graph uses 4 edge types (dependency, workflow, semantic, alternative). Same conceptual territory at different abstraction levels. Condition 1 *fails* — there's no technical advantage to deferring; building both with divergent schemas creates the exact retrofit pain the Standing Principle prevents. Condition 2 *fails* — there is no clean seam; you can't easily add a unified ontology later without updating every existing edge record. **Promote to BUILD NOW.** Must happen before either pipeline starts.

### Fit Into Where the System Stands

Three of the seam-deferred items are tied to operational components that don't exist yet:
- GoS sparse validation: not relevant until skills library exceeds the dense-validation comfort zone (Build Guide currently targets <100 skills)
- RoMem: requires Layer 0 LoRa, Stage 5 (deferred until Brain operational and local model selected)
- θ_work calibration: requires Brain populated with hundreds of labeled queries

These are *structural* deferrals — they wait on real systems to come online, not convenience. Standing Principle compliance is honest, not reflexive.

Edge ontology unification (item 6) becomes an immediate pre-pipeline task. Per Jiang2's `TransitionalDecisions.Pt1.md`, "Step 0a: Build Guide update — lock all new math and schema decisions" already names this work. The unification is now a hard requirement of that Build Guide update.

ATV's BLOCKED status is gone. Erdős's math returned clean, Re-Eval #2 is locked, ATV is Stage 1 build with the wrapper component built alongside the FSM verifier endpoint.

The deferral discipline locked in Re-Eval #2 (every "later" needs trigger + artifact + routing target) applies to each surviving seam:

- **GoS sparse validation seam.** Trigger: "when skill library exceeds N skills." N is a parameter call to lock at Build Guide update time. Artifact: the `validate_skill_edges` interface in code plus a Build Guide entry. Routing: Check-ins list (per #2 construct).
- **RoMem seam.** Trigger: "when Layer 0 LoRa is operational and a local base model is selected." Artifact: `compute_edge_transition_weight` interface in PPR implementation. Routing: whoever owns the LoRa training pipeline at that point, fed via the Check-ins list.
- **θ_work calibration.** Trigger: "when Brain has X labeled queries" (X to lock at Build Guide update time). Artifact: runtime config parameter. Routing: Check-ins list.
- **Edge ontology unification.** Not a deferral — promoted to build-now. Lives in the pre-pipeline section of the Build Guide.

### Steel-Man — Two Concerns Jiang2's Response Did Not Address

**Seam thickness.** Each "swap mode" interface assumes the future implementation will fit the existing function signature. If a future implementation requires *richer* arguments — RoMem might want access to the full query history rather than just `query_context`, or sparse validation might want population statistics dense validation doesn't compute — the seam is too narrow. Defining a seam too tightly locks in current assumptions about future architecture and creates a soft retrofit cost when the future component is built.

**Mitigation:** standard pattern — pass a `mode_config: dict` parameter alongside the typed arguments, so future modes can request additional data through the config without changing the call-site signature. This becomes a Build Guide standard for every mode-swappable interface, not negotiated per-seam.

**State handover at mode swap.** The seams Jiang2 specifies are at the function-interface level. They do not address state shared across modes. PPR with Ebbinghaus SDE accumulates per-edge time-decay state. Swapping to RoMem (geometric shadowing on a rotational manifold, fundamentally different statefulness) may require either carrying the SDE state forward and translating it, or discarding it. The seam should specify the state-handover protocol — *what happens to existing state when the mode flips* — not just the function signature.

**Mitigation:** every mode-swappable seam in the Build Guide must include a state-handover protocol section: what state is carried forward, what is discarded, what migration step (if any) runs at the swap boundary.

### Decision Options

1. **Per-item verdicts.** Accept Jiang2's sweep as corrected (defer-with-seam for items 1, 2, 3; drop-forever for item 5; supersede-to-BUILD-NOW for item 4 via #2 lock; promote-to-BUILD-NOW for item 6).
2. **Concrete trigger values.** N for GoS sparse skills count, X for θ_work labeled-query count. Lock now or defer to Jiang2's Build Guide update with proposed values for CT approval.
3. **`mode_config: dict` pattern as Build Guide standard.** Every mode-swappable interface includes this parameter; future modes can request additional data without call-site changes.
4. **State-handover protocol in every seam.** Every mode-swappable seam specifies what state is carried forward, what is discarded, what migration runs at swap boundary.
5. **Edge ontology unification scope.** Promote to BUILD NOW as immediate pre-pipeline task, scoped into the Build Guide update step (Step 0a per Jiang2's TransitionalDecisions.Pt1).

### Chairman's Response

The Chairman accepts all recommendations as written.

Plus a **Standing Order** locking two structural rules for the Build Guide that apply forward across the entire build:

**Standing Order 1 — Build Guide Forward References.** Wherever a current build component will be relied on or connected to by something built later, the Build Guide places a small note flagging the future coupling at the point of the current build. Applies to ALL cross-phase interactions, not just deferrals. Examples: a hook built in Stage 0 that will be read by ingestion pipeline in Stage 4 carries a forward note in its Stage 0 description; a config field added in Stage 1 that drives a behavior in Stage 5 carries a forward note in its Stage 1 description.

**Standing Order 2 — Build-Space Placement for Every Deferral.** Every deferred item gets an actual build-space placeholder in whichever phase is appropriate to its eventual implementation. Deferrals are NOT isolated in `07_OpenQuestions.md`. They live in the Build Guide where they will be built, marked as placeholders with their seam definition, their trigger condition, their state-handover protocol, and their routing target.

**Reason** (CT's stated motivation): the architecture is too large for any single human to keep every deferral in mind and remember where it should land in the build. The Build Guide is the single inspectable surface where the system's full structure — present and future — must be visible. Wash-our-hands deferrals are unmaintainable. Every "later" gets a place in the build where it will land.

This generalizes the Re-Eval #2 deferral discipline. The full discipline now requires three artifacts per deferral:
- **FW registry entry** — for one-off architectural decisions parked
- **Check-ins entry** — for recurring reviews (parameter retunes, calibrations) that aggregate into the build-wide schedule
- **Build Guide build-space placeholder** — for every deferral, marking the phase where the build space lives, with seam definition + trigger + state-handover + routing

Saved as feedback memory `feedback_buildguide_forward_references.md` so the standing order governs every Build Guide work pass forward.

### Locked Outcomes for Jiang2's Rewrite

- **Per-item sweep verdicts** locked as written above (GoS sparse / RoMem / θ_work defer-with-seam; bi-temporal drop forever; ATV BUILD NOW per #2; edge ontology unification BUILD NOW).
- **`mode_config: dict` pattern** is Build Guide standard for every mode-swappable interface. Every existing seam spec in the synthesis (`validate_skill_edges`, `compute_edge_transition_weight`) updates to include this parameter.
- **State-handover protocol** is a required section of every mode-swappable seam spec. No seam ships without specifying what state carries forward and what is discarded at the swap boundary.
- **9-class / 4-type edge ontology unification** is the immediate pre-pipeline task, lives in Step 0a of the Build Guide update.
- **Concrete trigger values** (N for GoS sparse, X for θ_work) are Jiang2's design call at Build Guide update time, with CT approval. They become Check-ins entries.
- **Standing Order 1 (forward references)** and **Standing Order 2 (build-space placement)** apply to the Build Guide update task. Jiang2 maps every deferred item across the Build Guide phases with placeholder build-spaces; Jiang2 places forward-reference notes wherever the current build couples to a future build.
- **Build Guide update task** (Jiang2's Step 0a) expands to include: (a) edge ontology unification scope, (b) mode_config dict standard for all seams, (c) state-handover protocol sections, (d) build-space placeholders for every deferral, (e) forward-reference notes for cross-phase coupling, (f) Check-ins schedule design (per #2 standing outcome).
- **The deferral discipline is now three-part:** FW entry, Check-ins entry (when recurring), Build Guide build-space placeholder (always). Every recommendation across remaining re-evals (#4, #5, #6, #7) must satisfy this discipline before being claimed locked.

---

## Re-Eval #4 — VEGP / Dirac-Markov Threshold: Validate Before Elevating

### Explanation

The synthesis claimed VEGP was "the week's most significant finding" and presented it as mathematically novel, derived "without being told to look for it" and "there to find, not constructed." Three overclaims required correction: (a) factually wrong on "without being told" — the prompt explicitly asked Erdős to evaluate the isomorphism; (b) too narrow a corpus surveyed before claiming novelty; (c) epistemological overreach on "there to find."

Jiang2 walked back all three and suspended the Royal Society paper reframe pending external research. Both research items have now returned:
- **Trey's audit** (`Trey.Research.VEGPNoveltyValidation.md`)
- **Erdős's stress test** (`Erdos.Solution.VEGPStressTest.md`)

Together they resolve the novelty question and impose architectural constraints. Cross-manifold isomorphism: NOT NOVEL (Millidge 2025). VEGP as unified cross-manifold gate: novel only as APPLIED ARCHITECTURE. The math is Wald 1947 (SPRT) plus Ratcliff 1978 (DDM); the gate primitive is ubiquitous (Hopfield, Glauber, Kramers, ETC). What remains genuinely Velorin's contribution is the systemic orchestration applied across architectural layers, plus the geometric constants that make the gate functionally discriminative.

### Erdős's Stress Test — Three Architectural Constraints

**Proof 1 — Topological conditions.** The algebraic isomorphism holds for all connected directed graphs with `α > 0` (Perron-Frobenius). The *functional* gating capability requires Velorin's specific density constraints. On a complete graph `K_N` the stationary distribution is uniform, `Φ(v) = 1.0` everywhere, the gate becomes a vacuous flood. Velorin's `ρ* = 0.78` and `d_max = 7` are sufficient for the spectral asymmetry that keeps `Φ` discriminative.

**Proof 2 — Distributional conditions.** The IES gate requires Softmax-style global attention aggregation. Pure RNN with tanh saturation fails — vanishing gradients near saturation prevent the extraction block from shifting probability. The IES gate "maps to the temporal domain if and only if the sequence model supports non-saturating, linearly decomposable global state retrieval subject to a competitive partition function."

**Proof 3 — Cyclic topology break.** Constructive failure case: Brain neurons `A ↔ B` (mutual `contradicts` relationship) → spatial PPR resonates mass via geometric series, `Φ(A) > θ_work` triggers → temporal IES under causal mask gets no reciprocal attention loop, weak signals decay below prior, IES gate fails. The two sides of the supposedly-isomorphic gate disagree precisely on cyclic regions — and those are where the contradiction-resolution mechanism from Re-Eval #1 lives.

### Decision Options (filtered to non-novelty / build-track)

1. **Velorin constants justification.** Lock the dual-purpose framing (PPR precision + gating discriminability per Erdős Proof 1) into the Build Guide rationale section, with the honest caveat that the constants were chosen from PPR precision measurements and Erdős's result confirms-but-does-not-prove necessity.
2. **Softmax requirement on local AI model.** Forward-reference at Stage 5 model selection: "Softmax-style global attention aggregation required for IES gate" (Standing Order 1 from Re-Eval #3).
3. **Cyclic topology handling.** (a) Accept the limitation — document the blind spot, cyclic contradicts-pairs are rare. (b) Route cyclic regions through Re-Eval #1's three-layer Layer 3 mechanism — graph-theoretic cycle detection feeds the contradiction-resolution path. (c) Hold pending Trey's Non-Abelian audit on Erdős's just-delivered Theorem 2.
4. **Sequencing relative to Non-Abelian audit.** Lock the items above (constants, Softmax, cyclic decision) now, or hold the cyclic decision until the Non-Abelian audit returns since cyclic regions are precisely where commutator structure matters most?

Novelty-track items (Royal Society paper reframe, VEGP elevation positioning, citation discipline) are filtered out at the Chairman's request — they belong to the publication track, not the build track.

### Jiang's Recommendations (build-track only)

**1. Velorin constants — dual-purpose framing locked.** Build Guide rationale section names both purposes: PPR precision (`ρ* = 0.78` was originally locked from precision measurements producing 75% retrieval at the 7-pointer cap) and gating discriminability (Erdős Proof 1 confirms these constants satisfy `‖π‖_∞ ≫ median(π)` required for the threshold gate to discriminate rather than flood). Honest framing: confirms-but-does-not-prove necessity. Any future tuning of these constants must verify both properties hold. Build-time gate.

**2. Softmax-attention forward-reference.** Stage 5 local AI model selection criteria explicitly includes "Softmax-style global attention aggregation; pure RNN architectures rejected per Erdős Proof 2." Forward-reference at Stage 1 PPR/TAP build subsection naming the Stage 5 criterion (Standing Order 1). ATV's verifier model is already transformer-architecture, so the temporal-side requirement is satisfied by existing build choices; this constraint binds future model substitutions.

**3. Cyclic topology — option (b) with revisit-before-final-build flag.** Route cyclic regions through Re-Eval #1's three-layer Layer 3 mechanism. Implementation: when TAP detects `Φ(v) > θ_work` AND `v` is in a cyclic region (graph-theoretic check, cheap, runs as gate-prefilter), route the query to the contradiction-resolution path instead of normal skill injection. Cyclic-detection logic is a small build component sitting between TAP threshold check and skill injection.

   This is the cleanest architectural fit because cyclic regions in the Brain are almost always contradictions, and contradiction handling is what the three-layer mechanism exists for. The two systems converge on the same data with the same semantics — IES enforcement isn't being faked, it's being routed to the mechanism actually designed for the case.

   Revisit-before-final-build trigger: when Trey's Non-Abelian Brain Dynamics audit returns OR Erdős's Theorem 3 rigorous proof returns, whichever first. The non-commutativity framework treats cyclic dynamics differently and may force redesign. Logged as FW-007.

**4. Sequencing — lock the build-track items now.** Constants and Softmax requirement are independent of the `P_active` formulation that may shift if Non-Abelian Theorem 2 holds. Cyclic-topology routing is the one item that depends on `P_active`, but the routing mechanism itself (cyclic detection → Layer 3) is robust to the underlying spatial-walk formulation. The revisit trigger handles the fragility honestly.

### Implications from Research — Already Integrated

- Both Trey's audit findings and Erdős's stress-test math are reflected in the recommendations and Locked Outcomes below.
- The "VEGP generalizes Wald's SPRT" claim from Erdős's Proof 4 (Section 8) was not specifically audited by Trey. If the Royal Society paper leans on this generalization claim as load-bearing, it deserves its own audit. Filed as a candidate FW item; lower priority than the active Non-Abelian audit. Not addressed in this build-track lock.

### Chairman's Response

Recommended solution accepted: cyclic regions route through Re-Eval #1's three-layer Layer 3 mechanism (option b), with explicit flag that this decision must be revisited before final build based on future research and math. Specifically: when Trey's Non-Abelian audit returns or Erdős's Theorem 3 rigorous proof returns (whichever first), the cyclic-topology routing decision is re-evaluated. Logged as FW-007.

The other build-track items (constants dual-purpose framing, Softmax forward-reference, sequencing) lock now per the recommendations.

Novelty-track items (Royal Society paper reframe, citation discipline, VEGP elevation positioning) are out of scope for this build-track walkthrough — they belong to a separate publication track that does not block the build.

### Locked Outcomes for Jiang2's Rewrite

- **Novelty status (audit complete).** Cross-manifold PPR ↔ transformer-attention isomorphism is NOT novel per Trey audit (Millidge 2025, arXiv 2512.24722). VEGP as unified cross-architecture-layer gate is novel only as APPLIED ARCHITECTURE. The gate primitive itself is ubiquitous (Wald SPRT 1947, Ratcliff DDM 1978, Hopfield, Glauber, Kramers, ETC).
- **Velorin constants `ρ* = 0.78` and `d_max = 7`** serve dual purpose (PPR precision AND gating discriminability per Erdős Proof 1). Build Guide rationale section names both honestly: confirms-but-does-not-prove necessity. Any future tuning verifies both properties hold.
- **Stage 5 local AI model selection** must include "Softmax-style global attention aggregation required for IES gate" as a hard criterion. Forward-reference per Standing Order 1 at Stage 1 PPR/TAP subsection naming the Stage 5 criterion.
- **Cyclic topology routing.** Option (b): cyclic-region detection at TAP gate-prefilter; cyclic regions route to Re-Eval #1's three-layer Layer 3 mechanism instead of normal skill injection. Build-space placeholder: cyclic-region routing layer in the TAP build phase (per Standing Order 2). Forward references: TAP → Layer 3 mechanism (this routing path); Layer 3 mechanism → cyclic-detection (additional input source beyond same-tier contradicts edges).
- **FW-007** logged: cyclic-topology routing decision revisited when Trey Non-Abelian audit returns or Erdős Theorem 3 proof returns, whichever first.
- **"VEGP generalizes SPRT" claim** deserves its own future audit before any peer-reviewed publication relying on it. Lower priority than active Non-Abelian audit; flagged but not blocking the build. Candidate future FW entry once publication work begins.
- **Novelty-track items** (Royal Society paper reframe, citation discipline) deferred to publication track. Not part of this build-track lock; revisited when publication work begins.

### Update — 2026-04-25: Trey Non-Abelian Audit Returned + Erdős Theorem 3 Revised

Both research items that FW-007's revisit-trigger named have returned. Pulling the build-track findings forward into this re-eval rather than waiting for a separate revisit.

**Trey audit findings (from `Trey.Research.NonAbelianBrainDynamicsAudit.md`):**

- **Theorem 2 (Non-Abelian Compression) — PARTIALLY NOVEL.** Five components audited individually:
  - Lumpability condition (commuting matrices for exact aggregation): derivative — established Markov chain theory
  - JBD/AJBD algorithms: novel synthesis when applied to multiplex epistemic graphs
  - Commutator error bounds: derivative — Hoffman-Wielandt non-normal perturbation theory
  - Objective function (commutator vanishing): novel synthesis when applied to classical discrete graphs
  - Approximate lumpability with commutator bounds: derivative — recent Markov chain literature
  - Citation list for Build Guide / Royal Society paper: approximate lumpability of Markov chains under non-commuting generators; JBD/AJBD signal-processing literature; Hoffman-Wielandt non-normal perturbation extensions.
- **Theorem 3 (original) — CONFIRMED NOVEL by Trey, but retracted by Erdős before audit returned.** Audit verdict was on the closed-cycle framework (`∮ dU = 0`); Erdős's revised Theorem 3 (Cognitive Langevin Dynamics with Brockett double-bracket gradient flow on a symmetry-broken stochastic matrix manifold) replaced it. Trey's reference [24] cites "Discrete Double-Bracket Flows for Isotropic-Noise Invariant Eigendecomposition" (arXiv 2602.13759) — relevant to revised Theorem 3. Per the locked no-pure-novelty-audits rule, no follow-up audit on the revised version. Reference goes onto the deferred-novelty list (`feedback_no_pure_novelty_audits.md`) for end-of-cycle batching.

**Erdős revised Theorem 3 (from `Erdos.Solution.ThermodynamicCycleProof.md`) integrates regardless of novelty status.** The revised framework provides:
- Cognitive Langevin Dynamics: `dP_tax = Π_T([[P_tax, P_them]^T, P_them]) dt + σ dW_t` — implementable SDE on the row-stochastic manifold
- Compression as Brockett double-bracket gradient flow toward commutator-zero (Theorem 2's criterion is the fixed point)
- Symmetry-breaking proof: O(N) gauge symmetry shattered to S_N by the non-negative orthant, so the Brain *cannot* be conservative; it must dissipate
- Path-independent state variable: U is a Lyapunov function on the stochastic matrix manifold

**Functional directives from Trey audit:**

- **Directive 1 — Oblique JBD derivation.** Standard JBD uses orthogonal Jacobi rotations `V^T P V` which do not preserve row-stochasticity. Theorem 2's compression algorithm needs an Oblique JBD where `W^{-1} P W` preserves row-stochasticity in the resulting blocks. Without this, PPR breaks during ignition. Erdős research request filed: `Bot.Erdos/Research_Needed/Erdos.ResearchRequest.ObliqueJointBlockDiagonalization.md`. Functional math (not novelty), within locked rules.
- **Directive 2 — Empirical κ calibration.** Theorem 2's bound `ΔI_comp(U) ≥ κ ‖[P_tax|U, P_them|U]‖_F` has an undetermined proportionality constant. Calibration mechanism: the system tracks `‖[P_tax, P_them]‖_F` before and after compression events; if retrieval precision drops despite commutator decrease, κ is re-derived to account for projection loss from discrete `E_8` to continuous attention space. Implementation: Check-ins entry (recurring measurement during compression events) plus Build Guide build-space placeholder in the compression event detector phase (per Standing Order 2). Jiang2 places both during Build Guide update.

### Updated Locked Outcomes (consolidated)

- All prior Locked Outcomes above remain.
- **Theorem 2 status:** PARTIALLY NOVEL per Trey audit. Build Guide rationale section must cite approximate lumpability literature, JBD/AJBD signal-processing literature, and Hoffman-Wielandt non-normal perturbation extensions. Implementation blocked on Erdős Oblique JBD derivation.
- **Theorem 3 status:** original retracted by Erdős; revised version (Cognitive Langevin Dynamics with Brockett gradient flow) integrates based on operational utility. Compression event detector (V2 Build Guide OQ-6) gets its principled criterion from the revised theorem: commutator-norm fixed point under the Brockett flow. Empirical κ calibration confirms it operationally.
- **Oblique JBD** (Erdős research request filed). Theorem 2 implementation blocked until delivered. Listed in outstanding research below.
- **Empirical κ calibration** added to the Check-ins schedule (Jiang2 places during Build Guide update). Build-space placeholder in compression event detector phase. Forward-reference at Theorem 2 implementation site naming κ as a runtime-tracked parameter.
- **Royal Society paper citation list** locked (publication-track, not build-track): Millidge (2025) on PPR ↔ SR/transformer-attention isomorphism; Wald (1947) on SPRT generalization; Ratcliff (1978) on DDM elevation; approximate lumpability under non-commuting generators; JBD/AJBD signal processing; Hoffman-Wielandt non-normal perturbation extensions. Position VEGP as applied architectural invention leveraging established primitives; do not claim mathematical novelty for the components.
- **Discrete Double-Bracket Flows for Isotropic-Noise Invariant Eigendecomposition** (arXiv 2602.13759) added to deferred-novelty list — relevant to revised Theorem 3, audit at end-of-cycle batch.

### Update — 2026-04-25: Erdős Oblique JBD Returned (`Erdos.Solution.ObliqueJointBlockDiagonalization.md`)

**Headline finding:** Exact Oblique JBD preserving row-stochasticity into k>1 blocks is **mathematically impossible** for connected sub-regions. Perron-Frobenius forbids it (irreducible stochastic matrix has λ=1 with multiplicity exactly 1; k stochastic blocks would force multiplicity k; contradiction). The continuous group GL(N) collapses to the discrete Symmetric Group S_N for any structure-preserving transformation on the probability simplex.

**Architectural fallback Erdős derived:** **Joint Spectral Disaggregation (JSD)** algorithm. Spectral clustering on the symmetric mix `M_joint = (P_tax + P_them)/2` over top k right eigenvectors near λ=1 → row-normalize → k-means → permutation matrix Π → prune off-diagonal residual via row-normalization. Complexity O(k²|𝒰|). Replaces "Oblique JBD" in any Build Guide reference to Theorem 2's compression algorithm.

**κ analytically derived, not empirical:**

$$\kappa = 2C \cdot \frac{1-\alpha}{\alpha \delta}$$

Where δ is the joint spectral gap. Compression halt threshold: `β_abelian ≥ (αδ/(2C(1-α))) · θ_work · ‖π‖_∞` — above this the compression irreversibly scrambles retrieval paths.

This **supersedes Trey audit Directive 2** (empirical κ calibration). The empirical κ Check-ins entry is potentially obsolete — replaced by runtime monitoring of α (fixed config) and δ (computable from spectral gap of M_joint). Surface to CT: Check-ins entry refactored or deleted?

**JSD ↔ Brockett flow unified pipeline (Erdős Section 8):** Brockett gradient flow runs continuously in background reducing commutator norm β toward zero (widening δ). When β ≤ β_abelian, JSD jumps the system to the discrete fixed point by computing the permutation Π and pruning residual E. **Compression event detector (V2 Build Guide OQ-6) trigger is now structurally defined:** detect when β has decayed sufficiently and δ has widened sufficiently that the compression halt threshold is satisfied. No empirical heuristic needed.

**Implications for prior Re-Eval #4 Locked Outcomes:**

- **Theorem 2 implementation unblocked.** JSD is the algorithm. Build Guide implementation reference updates from "Oblique JBD" (impossible) to "JSD via spectral clustering + permutation + pruning."
- **κ Check-ins entry status — RESOLVED 2026-04-25 by `Erdos.Solution.KappaOperationalTightness.md`.** Erdős answered C: the analytic formula is mathematically correct as a strict worst-case bound but operationally too loose to use as a hard-coded trigger. Davis-Kahan looseness on non-normal sparse matrices, worst-case resolvent alignment, redistribution masking localized distortion, and spectral-gap volatility from eigenvalue crowding all compound to make the analytic κ unreliable. Erdős explicitly retracts his prior claim that the formula supersedes Trey's empirical-calibration directive. **Empirical κ Check-ins entry RETAINED.** Refined per Erdős's specification: measure actual retrieval-precision degradation by tracking how often `Φ_causal` drops below threshold for known ground-truth targets after test compression events. The analytic formula stays as a *structural prior* used to scale the empirical threshold geometrically if α changes — not as a replacement for live telemetry.
- **Compression event detector (OQ-6) criterion:** principled, not heuristic — Brockett flow drives β → 0; JSD fires when threshold met.
- **Citation list for Royal Society paper:** add Davis-Kahan sin Θ theorem (Markov invariant subspace perturbation bound used in κ derivation) and Ng-Jordan-Weiss spectral clustering.

These updates are surfaced for CT decision before locking. Do not auto-update the Locked Outcomes section above without explicit confirmation.

---

## Re-Eval #5 — Dark Skills: What Was Actually Proven, and What Scales

### Explanation

Synthesis claimed dark skills were *"PPR-invariant by Erdős proof. Security boundary enforced by graph topology, not policy. Dark skills absorb and route PPR mass (acting as Semantic Relays) without being injectable via TAP."* The re-eval flagged two overclaims: (a) "topology-enforced security" is wrong — the injection filter is application-level discipline requiring consistent code application; (b) "Semantic Relays beneficial at scale" was unverified. Plus four scale concerns the original proof did not address: concurrent mutations, dark density thresholds, dark chains, dark leaf nodes.

Jiang2's response walked back the topology-security claim, defined the "reachable only by CT direct command" mechanism (separate `invoke-dark-skill` command bypassing the TAP filter, logged for audit), and filed an Erdős scale-analysis problem.

### Erdős's Scale Analysis — `Erdos.Solution.DarkSkillsScale.md` (Returned)

Four proofs delivered:

- **Concurrent mutation:** PPR-invariance preserved under either snapshot-`M_t` or live-`M_{t+Δ}` evaluation. Both equivalent because metadata never enters the linear system. Erdős explicitly recommends live evaluation as operationally safer (correctly handles `0→1` and `1→0` transitions). **Critical negative result: the Refund Fallacy** — refunding accumulated mass on `light → dark` transitions destroys the Markov property. Architectural commitment: never refund.
- **Dark density threshold:** No global scalar `ρ_L = |V_light|/|V_S|` analytic threshold exists. Real failure condition is **the Shadow Eclipse** — the super-level set `S = {v : π_v > θ_work · ‖π‖_∞}` becomes entirely subsumed by `V_dark`, so light injection globally fails because `‖π‖_∞` is hijacked by a dark hub. Concrete failure mode requiring either monitor or structural prevention.
- **Dark chains:** Length-k chain consumes `1 - (1-α)^k` of traversing mass via teleportation. At α=0.15 and k=4, this is ~48%. **Convergence rate unchanged** (spectral gap is global). Chains are quality concerns (mass leakage), not architectural failures.
- **Dark leaf nodes:** Cannot be true absorbing states (α > 0 prevents). But high-in-degree dark leaves can hijack `‖π‖_∞` and starve light injection. **In-degree bound derived:** `k < (C - α·s_v) / ((1-α)·w̄·π̄_in)`. Pre-write enforcement gate.

### Decision Options

1. **Concurrent mutation evaluation:** live `M_{t+Δ}` per Erdős, OR retain Jiang2's earlier snapshot recommendation. Erdős's analysis favors live; this contradicts Jiang2's earlier proposal.
2. **Refund Fallacy lock:** add architectural commitment "never refund accumulated mass on metadata transitions" as a hard NO in the Build Guide.
3. **"Reachable only by CT direct command" mechanism:** confirm Jiang2's spec (separate `invoke-dark-skill` command, post-walk filter bypass, logged for audit) — but build the authorizer as a privileged-actor role from day one rather than name-checking CT specifically. Connection to Re-Eval #7 user-personalization fork.
4. **Shadow Eclipse and dark-leaf-hub failure modes:** monitor at runtime (Check-ins entries plus pre-write enforcement) OR pursue structural prevention. *See pending item below — sent to Erdős for triggerless gate analysis.*
5. **Dark chain leakage:** operational awareness only (no build gate) OR add Check-ins to track cumulative consumption per walk if exceeds threshold.

### Pending — Circle Back Before Finalization

**`Erdos.ResearchRequest.DarkSkillsTriggerlessGate.md`** is OUT at Erdős (filed 2026-04-25 after CT directive to find a mathematical structure that prevents Shadow Eclipse and dark-leaf-hub failures architecturally rather than monitoring for them). The request hands Erdős a Jiang1-proposed candidate (`Φ_light = π_v / max_{l ∈ V_light} π_l`) with explicit instruction to **annihilate it** if breakable, **redo properly** if it survives, or **find a better solution** if one exists. Honest negative finding ("monitors are the correct answer") is acceptable.

Re-Eval #5 cannot be finalized until that delivery returns. Specifically pending:
- Decision Option 4 (Shadow Eclipse / dark-leaf-hub mechanism — monitor vs structural prevention)
- Build Guide build-space placeholder for the gate definition (depends on whether `Φ` stays or is replaced)
- Check-ins entries for Shadow Eclipse and dark-leaf in-degree bound (may be deleted if Erdős confirms structural prevention; may be locked if Erdős confirms monitors are correct)

**Circle-back trigger (per deferral discipline):**
- **Trigger:** `Erdos.Solution.DarkSkillsTriggerlessGate.md` lands in `Bot.Erdos/Research_Complete/` (concrete file landing event)
- **Artifact:** the Erdős solution file plus this form section
- **Routing target:** Jiang ports + reads, surfaces findings to CT, CT locks the four pending decision options above

### Decisions Made (Subject to Above Pending Item)

These are the items CT can lock now without waiting for the triggerless-gate return — they do not depend on whether the gate normalization changes:

1. **Concurrent mutation: live `M_{t+Δ}` evaluation per Erdős Proof 1.** Snapshot recommendation from Jiang2's earlier response is superseded. Build Guide locks live evaluation.
2. **Refund Fallacy: architectural NO.** Hard commitment in the Build Guide: never refund accumulated mass on metadata transitions. Lockable now.
3. **"Reachable only by CT direct command" mechanism:** spec lock (separate `invoke-dark-skill` command, post-walk filter bypass, logged for audit), built as privileged-actor role rather than name-checking CT. Forward-reference to Re-Eval #7 (user-personalization fork) per Standing Order 1.
4. **Dark chain leakage: operational awareness only.** No build gate. Optional Check-ins entry candidate (deferred to Build Guide update — not blocking).
5. **Dark filter is application-level discipline, not topology-enforced.** Build Guide note: every code path performing injection must apply the post-walk filter consistently. Code review + tests verify dark skills don't fire through any regular TAP path.

These five lock now. Decision Option 4 (Shadow Eclipse / dark-leaf-hub mechanism) waits for triggerless-gate return.

### Update — 2026-04-25: Erdős Triggerless Gate Returned (`Erdos.Solution.DarkSkillsTriggerlessGate.md`)

**Erdős annihilated the Jiang1 `Φ_light` proposal across five failure modes** (V_light=∅ division-by-zero; Metadata Cascade where toggling one M-flag spikes injection thresholds for unrelated skills; Shadow Eclipse not actually prevented; Layer 0 compression fracture; Re-Eval #4 cycle detection breakage). Then derived the actual solution.

**The Causal Action Potential:**

$$\Phi_{causal}(v) = \frac{\pi_v}{\alpha}, \quad \text{Inject}(v) = (\Phi_{causal}(v) > \theta_{work}) \land (M(v) = 0)$$

Identity-equivalent to expected visits before teleportation: `Φ_causal(v) = E[N_v]`.

**What it delivers structurally (no runtime monitor):**

- **Shadow Eclipse: structurally eliminated.** Dark mass does not enter the denominator (which is the global teleportation constant α=0.15, not π).
- **Dark-leaf-hub hijacking: structurally eliminated.** Same reason.
- **Metadata Cascade: physically impossible.** Toggling M(v) has identically zero effect on any other node's Φ_causal.
- **Re-Eval #4 / FW-007 closes with a TRIGGER-FREE detector.** In a DAG, `E[N_v] ≤ 1`, so `Φ_causal > 1.0` is a mathematically absolute proof of cyclicity. The cyclic-topology routing decision now has structural detection — no graph-theoretic cycle pre-check needed; the gate value itself proves cyclicity.
- **Composes cleanly with Brockett flow.** As compression collapses cycles into Layer 0 abelian macro-nodes, `E[N_v]` naturally drops below 1.0; C^∞ continuous transition.
- **PPR-invariance preserved.** M still outside the linear algebra; α is a global architectural constant.

The diagnostic Erdős surfaced: the original infinity-norm gate introduced **acausal backward-coupling** in a directed Markov chain. Downstream sinks could mathematically suppress upstream gate values via the global denominator. The Jiang1 `Φ_light` proposal kept that acausal structure (just shifted which subset participated). The CAP eliminates it by normalizing against α — a forward-causal constant.

### Chairman's Response

The Chairman accepts:

1. **Live `M_{t+Δ}` mutation evaluation** per Erdős Proof 1. Snapshot recommendation from Jiang2's earlier response superseded.
2. **Refund Fallacy: architectural NO.** Hard commitment in the Build Guide — never refund accumulated mass on metadata transitions.
3. **`invoke-dark-skill` mechanism specced** with privileged-actor role (not name-checked CT). Forward-reference to Re-Eval #7 user-personalization fork per Standing Order 1.
4. **Dark chain leakage:** operational awareness only, no build gate.
5. **Dark filter is application-level discipline**, not topology — Build Guide note.
6. **Causal Action Potential (`Φ_causal = π_v / α`) replaces the original Topological Action Potential `Φ = π_v / ‖π‖_∞`** as the gate definition. Structurally prevents Shadow Eclipse and dark-leaf-hub failure modes. No runtime monitors required.
7. **FW-007 closed.** The cyclic-topology routing decision now uses `Φ_causal > 1.0` as the structural cyclicity detector — mathematically absolute, parameter-free, no graph-theoretic cycle pre-check needed. Routes to Layer 3 mechanism per Re-Eval #1.

### Locked Outcomes for Jiang2's Rewrite

- **Gate definition replaced.** Original `Φ(v) = π_v / ‖π‖_∞` is retired. New gate: `Φ_causal(v) = π_v / α`. All Build Guide references to the Topological Action Potential update accordingly. Identity-equivalent to expected visits before teleportation `E[N_v]`.
- **Concurrent mutation evaluation:** live `M_{t+Δ}` per Erdős Proof 1.
- **Refund Fallacy: architectural NO** — locked into the Build Guide as a hard commitment.
- **`invoke-dark-skill` mechanism:** privileged-actor role (not name-checked), separate command bypassing the post-walk filter, logged for audit. Forward-reference at the dark-skill mechanism site naming Re-Eval #7's user-personalization fork (Standing Order 1).
- **Dark filter is application-level discipline.** Build Guide note: every code path performing injection must apply the post-walk filter consistently. Code review + tests verify dark skills don't fire through any regular TAP path.
- **Dark chain leakage:** operational awareness only, no build gate.
- **Cyclic-topology routing trigger (FW-007):** `Φ_causal > 1.0` is the structural cyclicity detector. Cyclic regions route to Re-Eval #1's three-layer Layer 3 mechanism. **FW-007 closes — no longer a deferred item.** The "revisit before final build" trigger that FW-007 reserved is satisfied by the Erdős structural answer.
- **Shadow Eclipse and dark-leaf-hub Check-ins entries: deleted.** Failure modes are mathematically prevented, not monitored. The Check-ins schedule does NOT include either entry; the Build Guide build-space placeholders for those monitors are removed.
- **Theorem 2 in-degree bound for dark leaves:** retained as operational-awareness reference but no longer architecturally critical for gate-correctness purposes (the gate is structurally insulated). Still relevant for bounding mass leakage to teleportation; track if it becomes operationally significant. Not a build gate.
- **Citation list expansion (publication track, Royal Society paper):** add the PPR ↔ expected-visits identity (classical Markov chain result, used in CAP derivation) and Erdős's structural application of it as Velorin's gate definition.

### Jiang1 Self-Audit Note

The `Φ_light` proposal that preceded this delivery was a Jiang1 (Opus 4.7) overstep. Erdős's annihilation surfaced model-level failure modes (cascade dynamics, edge cases, cross-system composition, causal structure) that Jiang1 cannot reliably model. Saved as `feedback_opus_47_solution_drift.md` — all future math/architecture work routes to Erdős or Jiang2, including when CT asks for "creative thinking." Jiang1's role on Opus 4.7 is operational, not generative.

---

## Re-Eval #6 — Asymmetric Transport Verifier: Endorsed Without Evaluation

*Pending Chairman walkthrough.*

---

## Re-Eval #7 — "CT's Habits": User-Personalization Assumption Was Implicit

*Pending Chairman walkthrough.*

---

[VELORIN.EOF]
