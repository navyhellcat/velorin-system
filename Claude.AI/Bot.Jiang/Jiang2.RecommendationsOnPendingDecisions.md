---
file: Jiang2.RecommendationsOnPendingDecisions.md
from: Jiang2 (Director of Strategic Intelligence)
date: 2026-04-26
purpose: Per-decision recommendations for Decisions 2-10 in Jiang.RespondingToReEvaluations.md.
         Decision 1 already locked. CT reads this alongside the form before locking 2-10.
         These are recommendations, not decisions. Chairman decides.
sources:
  - Jiang.RespondingToReEvaluations.md (7 re-evals locked, 10 pending decisions)
  - Erdos.Solution.ATVMathProperties.md
  - Erdos.Solution.DarkSkillsScale.md
  - Erdos.Solution.VEGPStressTest.md
  - Erdos.Solution.NonAbelianBrainDynamics.md
  - Erdos.Solution.ThermodynamicCycleProof.md
  - Erdos.Solution.KappaOperationalTightness.md
  - Erdos.Solution.ObliqueJointBlockDiagonalization.md
  - Erdos.Solution.DarkSkillsTriggerlessGate.md
  - Erdos.Solution.ATVConsumerPolicyDriftBound.md
  - Trey.Research.VEGPNoveltyValidation.md
  - Trey.Research.NonAbelianBrainDynamicsAudit.md
  - Trey.Research.VerifierBenchmarkMethodology.md
  - Trey.Research.FSMGrammarVersionManagement.md
  - Jiang2.ReEvaluationResponses.md (Jiang2's seven re-eval responses)
  - Jiang2.TransitionalDecisions.Pt1.md (second-half synthesis snapshot)
  - Jiang.FutureWork.md (FW-001 through FW-008)
  - MEMORY.md and all 10 locked feedback memories
  - Jiang.SessionHandoff.Session036.Apr25-26.md
---

# Jiang2 Recommendation — Pending Decisions 2-10

---

## Section A — Whole-Picture Synthesis

Reading the entire corpus — seven locked re-evals, ten Erdős solutions, four Trey deliverables, ten locked feedback memories, and two Jiang2 prior work documents — produces one dominant pattern across Decisions 2-10: they are **not architectural decisions of the same depth as Re-Evals 1-7**. They are either adoption calls with clear answers visible from the Trey research, or calibration starting-point decisions where the right pattern is "principled value now, program measures outcomes, Check-ins tune."

The form's locked outcomes from the seven re-evals were architecturally rigorous — replacing the Topological Action Potential with the Causal Action Potential, locking Direction C for personalization, specifying the ATV as an MCP server, deriving the three-layer conflict resolution mechanism, establishing the Build Guide standing orders. That work is done. Decisions 2-10 are the operational tail: what stack to adopt for the ATV benchmark, how to manage the grammar over time, when to close FW entries, how to finalize and sequence the form handoff.

**Pattern 1 — The founding thesis closes most adoption questions.** Decisions 2 and 3 look like choices between complexity levels. Viewed through the founding thesis (programs do the work, AI watches), both simplify: adopt the best existing program infrastructure (JSONSchemaBench, XGrammar, vllm-mlx, Schema Registry, PBT), build the Velorin-specific dataset on top, and write the AI-review workflow. Don't reinvent the infrastructure; do claim the operational layer that is specific to Velorin.

**Pattern 2 — Calibration parameters have the A_min pattern.** Decision 1 locked A_min as "iteratively engineered through build + test, not a single upfront pick." Decisions 4a–4d, 7, and 8 are all the same shape. Source multipliers, ε threshold, round-cap, κ Check-ins design — these are empirical parameters, not analytically-derivable constants (Erdős was explicit on κ: analytic formula is too loose for hard-threshold use). The right answer is: pick a principled starting value from first principles now, build the measurement program, and let Check-ins refine. Don't defer parameter decisions; give them initial values and log them.

**Pattern 3 — The Build Guide is the bottleneck.** Everything locked in the re-evals — new schemas, CAP replacing TAP, ATV architecture, belief_state and authority_tier fields, edge ontology unification, base_model_config field, the contradiction_class tag — lives in documents outside the authoritative Build Guide. Every session that runs before the Build Guide update is operating on stale specs. Decision 10 (form finalization sequencing) directly controls how fast this staleness resolves. The risk compounds: more sessions on stale specs means more drift between what agents think is true and what the form has locked.

**Pattern 4 — FW entries with satisfied triggers should close.** FW-007 was triggered by Erdős's DarkSkillsTriggerlessGate delivery. The trigger is satisfied. Keeping it open as a "watch item" serves no purpose — it's an open entry that has been resolved but hasn't been marked COMPLETE. Unnecessary open entries in the FW registry are cognitive overhead and increase the risk that genuinely open items get overlooked.

---

## Section B — Surfaced New Options

Two decisions have options the original menu does not name.

**Decision 2 — Phased Golden Dataset (not presented in original menu)**

The form presents "CT curates 300 items personally" vs "AI-assisted curation" vs "100 items instead of 300." There is a fourth option the menu doesn't surface: **phased curation tied to use cases**.

Phase 1 (model selection): CT curates 100 items — sufficient to run the VTPS benchmark and select the verifier model for ATV build. These 100 items are the densest, most challenging analytical outputs CT has produced: architecture evaluations, Trey research syntheses, build decisions. They stress the grammar hardest.

Phase 2 (production calibration): After ATV ships and accumulates 500+ real inter-agent messages, CT expands the Golden Dataset to 300 items using actual production messages that have passed through the ATV, spot-verified by CT. The production messages are ground truth by revealed preference (they were accepted; CT confirms a sample).

This is not deferral. The seam: `golden_dataset_v{version}.json` as the benchmark's input file. Phase 1 ships `v1` with 100 items. Phase 2 ships `v2` with 300 items. Benchmark reruns automatically against `v2` when it arrives. The distinction from Option 3 (reduced dataset): Phase 2 expansion is a committed plan with a concrete trigger (500 real messages), not an open-ended "maybe expand later."

The critical constraint from Trey (`Trey.Research.VerifierBenchmarkMethodology.md`, Section 4): Golden Dataset cannot be AI-generated or AI-curated without invalidating FRR measurement. CT personal curation is structurally required for the ground truth to be reliable. This constraint applies to Phase 1 and Phase 2.

**Decision 7 — Program-first specification for FW-008 κ Check-ins (not presented in original menu)**

The form presents options between "defer entirely" vs "lock specific values now" vs "iterative engineering pattern like A_min." The founding thesis suggests a cleaner framing: **specify the program now, defer the values to the program's first runs.**

Specifically: the κ measurement program has a defined structure (described below in Decision 7 recommendation). The program is the Check-ins entry. CT approves the program design; the thresholds emerge from the first measurement cycle. This is exactly the A_min pattern: the program is locked at build time; the calibrated value comes from the program's measurements.

---

## Section C — Risk Notes

**Risk on Decision 2 — AI-curated Golden Dataset destroys the benchmark's validity**

Trey is unambiguous: synthetic or AI-generated ground truth for FRR measurement "destroys the validity of the metric due to pervasive annotation errors and bias injection." This is not a preference — it is a methodological constraint from production AI safety and biometric measurement standards (ISO/IEC 19795-1:2021). If CT opts for AI-assisted curation (Option 2), the FRR and FAR measurements become unreliable, leading to selecting the wrong verifier model, which breaks ATV's quality guarantees. The founding thesis applies: AI watches the benchmark program; CT is the human judgment in the ground truth. This role cannot be delegated to AI without invalidating the measurement.

Confidence that this risk is real: **92%** (grounded in Trey's Section 4 sourced from ISO/IEC standard and production telemetry findings).

**Risk on Decision 9 — Reactive inline corrections don't close systemic bootloader contamination**

The 2026-04-25 inline corrections caught contamination from Trey's bootloaders (human-curated framing, stale open-question assertions). Those were reactive fixes after deliverables already reflected stale framing. The `feedback_audit_external_agent_context.md` rule locks the "audit before sending" discipline going forward, but that fires per-request, not systematically. If there are patterns of staleness across the bootloaders (solved Erdős problems still listed as open, Build Guide OQ status not updated), every future Trey session runs on contaminated context until the systematic audit happens. The risk compounds as Trey research queue refills.

Confidence that this risk is real and worth acting on now: **85%** (the contamination incident is confirmed; the systematic exposure is structural).

---

## Decision 1 — Acknowledged; Cross-Decision Implications Only

Already locked: Adaptive Rate-Limit Policy with `ρ* = λ · max(0, A_min − τ) / (1 − τ)`. A_min calibration is iterative engineering.

Cross-decision implications:

- The consumer policy enforcement program (one of the three Stage 1 program-build specifications from Re-Eval #6) must specify A_min as a runtime-configurable parameter, not a hardcoded constant. The Check-ins schedule (designed by Jiang2 during Build Guide update) must include an A_min review entry at Stage 1 ATV operational validation.
- The availability cliff at `τ = A_min` (identified in Erdős's Proof 5 in `Erdos.Solution.ATVConsumerPolicyDriftBound.md`) means the consumer policy program must monitor τ in real time. The program is the monitor; AI watches when τ approaches A_min to flag early.

---

## Decision 2 — Trey Verifier Benchmark Methodology Adoption

**Restated question:** Which components of the Trey-recommended benchmark stack do we adopt (JSONSchemaBench + XGrammar + vllm-mlx + VTPS + 300-item Golden Dataset), and at what scope for the Golden Dataset?

**Recommendation:** Adopt the full stack (Option 1) with phased Golden Dataset construction (new option, Section B).

**Reasoning:**

Consensus Filter applied:
- Q1: Consensus is JSONSchemaBench + XGrammar + vllm-mlx as the production benchmark/serving stack for constrained decoding on Apple Silicon.
- Q2: Consensus exists because: (a) Outlines has catastrophic compilation latency on complex schemas; (b) llama.cpp lacks continuous batching for multi-agent workloads; (c) VTPS is the only metric that accounts for schema compliance failures as zero-throughput events; (d) JSONSchemaBench is purpose-built for evaluating constrained decoding across exactly these dimensions.
- Q3: Does Velorin share these constraints? **YES.** The ATV verifier must run at high compliance rate on Apple Silicon M4 Max under continuous multi-agent message load. The constraints that drove the consensus are exactly Velorin's operating conditions.

Founding thesis: the benchmark is a program. CT writes the ground truth (Golden Dataset); the program runs the evaluation; AI reviews results and recommends the winner. Trey's research is the ecosystem scan that tells us which tools to use for the program — exactly the right use of Trey.

Specific component decisions:
- **JSONSchemaBench**: adopt. Clone the evaluation architecture; build Velorin-specific IES schema datasets on top. Do not build from scratch.
- **XGrammar**: adopt as the constrained decoding engine. Replace any Outlines reference in the ATV build spec. XGrammar's JIT compilation eliminates the pre-compilation bottleneck that would make Outlines unusable on complex IES schemas.
- **vllm-mlx**: adopt as the Apple Silicon backend. Replace any llama.cpp reference for the ATV serving layer. 21-87% throughput advantage over llama.cpp on M4 Max, continuous batching at 4.3× aggregate throughput at 16 concurrent requests (`Trey.Research.VerifierBenchmarkMethodology.md`, Section 5.2). The prefix caching (SHA-256 hash, 5.8× TTFT speedup for repeated IES system prompt) is operationally valuable — the ATV's long IES format system prompt is a perfect prefix cache candidate.
- **VTPS metric**: adopt as primary metric. VTPS = (N_total × C) / T_total. If compliance C=0, VTPS=0 for that run. The metric directly punishes non-compliant outputs as zero-throughput events; raw TPS would mislead.
- **Golden Dataset — phased curation (Section B's new option)**:
  - Phase 1 (model selection): CT personally curates 100 items. Composition: 40 clean analytical conclusions from prior sessions, 40 high-complexity multi-domain outputs (Erdős research evaluations, cross-domain synthesis outputs), 20 edge cases (very short analytical statements, statements containing technical notation, statements with embedded structured data). This is sufficient to select the verifier model.
  - Phase 2 (production calibration, trigger: 500 real ATV-processed messages): CT spot-verifies a sample of production messages accepted by the ATV; expands Golden Dataset to 300 items using confirmed-valid production messages plus new edge cases discovered during Phase 1 operation.
  - Seam: `golden_dataset_v{version}.json` as benchmark input. Phase 1 ships v1=100 items; Phase 2 ships v2=300 items. Benchmark program reruns against v2 at Phase 2 trigger.
  - AI-assisted curation is NOT used for the Golden Dataset at any phase. CT judgment is structurally required for FRR/FAR measurement validity.

Cross-decision dependencies:
- Decision 10 (form sequencing): ATV build happens after Build Guide update, which happens after form finalization. The benchmark is built at ATV Stage 1 build time, not now. Decision 2 is locking the approach; execution timing is governed by the build sequence.
- Decision 3 (FSM grammar management): the benchmark and grammar management programs are co-built with ATV. The benchmark validates the verifier model; the grammar management workflow validates grammar changes. Both are Stage 1 build-space placeholders.

Confidence: **88%** on the full technology stack adoption. 81% on the phased Golden Dataset approach specifically (the phase trigger count of 500 messages is a principled estimate, not empirically validated).

**What would change this recommendation:** If XGrammar turns out to have a specific incompatibility with the IES grammar's structure (e.g., recursive structures that cause state explosion), a different CFG engine would be needed. The Phase 1 benchmark run would surface this — at which point the engine selection falls back to llguidance or a custom grammar engine.

---

## Decision 3 — Trey FSM Grammar Version Management Adoption

**Restated question:** Which layers of the FSM grammar version management workflow do we adopt now (Schema Registry + PBT + Differential Equivalence + Compiler-in-the-Loop + Shadow Mode + Canary)?

**Recommendation:** Option 4 (Minimum Viable) for Stage 1, with explicit build-space placeholders for Shadow Mode and Canary.

**Reasoning:**

Consensus Filter applied:
- Q1: Consensus is Schema Registry + PBT + Differential Equivalence + Compiler-in-the-Loop + Shadow Mode + Canary as the production grammar management workflow.
- Q2: Consensus exists because production systems manage grammar changes that can break thousands of live agents if deployed incorrectly. Shadow Mode and Canary exist specifically to test grammar changes against live traffic without disrupting production.
- Q3: Does Velorin share the constraint? **PARTIALLY.** Velorin shares the constraint for the Schema Registry, PBT, and Compiler-in-the-Loop layers — these protect against bad grammar deployments regardless of scale. **Velorin does NOT currently share the constraint for Shadow Mode and Canary** — not because they're wrong, but because the operating conditions that make them necessary don't exist yet:
  - Shadow Mode doubles inference cost during testing windows. At Stage 1, there are no "live production requests" to shadow against. Shadow Mode becomes meaningful when the system has steady inter-agent message volume and a populated historical corpus of prior messages to run differential equivalence against. Currently there are zero historical messages.
  - Canary requires a production traffic split. Velorin's current "traffic" is CT's direct interaction sessions — indivisible into a canary fraction.

Standing Principle applied:
- Condition 1 (technical advantage to deferring Shadow + Canary): YES. Shadow Mode during Stage 1 would be purely synthetic (no real messages to shadow against); it would test the grammar on fabricated inputs, producing misleading results about Format Tax.
- Condition 2 (seam specified for Shadow + Canary): the ATV's grammar invocation function must be wrapped so Shadow Mode can duplicate requests without changing call-site signatures. Seam: `apply_grammar(message, grammar_hash, shadow_hash=None)` — if shadow_hash is provided, the function invokes the grammar twice (primary + shadow) and logs both outputs. This interface is built at Stage 1 even though shadow_hash is always None until Stage 2.

The Schema Registry is the foundational piece — without it there is no version management at all. Trey makes this explicit: the IES grammar must be treated as compiled executable infrastructure, not a prompt string. Agents reference the grammar by cryptographic hash, not by text. This must be built from the first grammar version.

Specific layer decisions:
- **Schema Registry**: adopt now. Git repository for IES grammar source; post-commit hook compiles to XGrammar artifact; SHA-256 hash serves as the immutable identifier. Local SQLite database or key-value store maps hash to binary artifact. This IS the ATV build's first component — without it, grammar changes are unmanaged and the hash-in-metadata-header from ATV's message logging is meaningless.
- **Property-Based Testing (PBT)**: adopt now. Hypothesis library generates synthetic valid strings from grammar, runs through the ATV verifier, confirms json.loads() parses them cleanly. Runs on every grammar commit. Catches under-constrained and over-constrained grammars before the LLM ever sees them.
- **Compiler-in-the-Loop AI review**: adopt now. AI reviews proposed grammar changes; deterministic compilation feedback (XGrammar errors) drives the review, not AI syntax judgment. This IS the AI-as-watcher role in the grammar management program.
- **Differential Equivalence**: build-space placeholder, Stage 2. Trigger: when 500+ historical ATV messages exist to serve as the corpus. At that point, differential equivalence checks can meaningfully verify that v2 accepts everything v1 accepted. Until then, there is no corpus.
- **Shadow Mode**: build-space placeholder, Stage 2. Same trigger as Differential Equivalence. Seam interface specified above is built at Stage 1.
- **Canary**: build-space placeholder, Stage 3 (when system has multi-agent parallel sessions generating consistent message volume). Canary requires traffic to split.

Deferral artifacts for Shadow Mode and Canary (three-part discipline):
- **FW entry**: add Shadow Mode and Canary as a sub-item under ATV in a new FW entry (or under FW-006 back-application since these are build-space placeholders). Concrete trigger: 500 historical ATV messages (Shadow/Differential) and multi-agent parallel session volume (Canary).
- **Check-ins entry**: grammar regression suite quality review — placed in the ATV build phase Check-ins (how often to run PBT, whether coverage is expanding appropriately).
- **Build Guide build-space placeholder**: Shadow Mode and Canary live in the Stage 2 ATV section, marked with concrete triggers and the seam interface.

Cross-decision dependencies:
- Decision 2 (benchmark stack): XGrammar is the compilation backend for both the benchmark and the Schema Registry. The same XGrammar install serves both. No additional dependency.
- Decision 6 (FW-006 back-application): the Shadow Mode and Canary build-space placeholders are FW-006 work — placing them in the appropriate Build Guide phases.
- Decision 10 (form sequencing): same as Decision 2 — ATV and grammar management build happens after Build Guide update.

Confidence: **86%** on minimum viable now + Shadow/Canary deferred with seam. 73% on the specific trigger counts for Shadow and Canary (500 messages is principled but could reasonably be 200 or 1000 depending on how quickly meaningful diversity accumulates).

---

## Decision 4 — Re-Eval #1 Parked Calibration Items (4a–4d)

### 4a — Source Multiplier Values

**Restated question:** Accept provisional 1.0/1.2/1.5, lock different values, or defer to engineering iteration?

**Recommendation:** Accept provisional values (Option i); add to Check-ins for calibration after first 50 resolved contradictions.

**Reasoning:** The multipliers encode a signal hierarchy: agent-generated output < CT-curated output < Erdős-verified math. The 20% and 50% increments are reasonable first approximations for how much more reliable each tier is. There is no data to derive better values — the Brain doesn't exist yet, no contradictions have been resolved. The founding thesis: pick a principled value, build the measurement program (conflict resolution logging), tune from data. The Check-ins entry for this multiplier review is: "after 50 Layer 1 tiebreaker resolutions, audit the override rate — how often did the higher-multiplier neuron turn out to be correct based on CT review of contested cases." That review is a Check-ins entry, not a standalone trigger.

Deferral artifacts: No FW entry needed (this is a Check-ins calibration, not a one-off architectural decision). Check-ins entry: Layer 1 source multiplier calibration review after 50 resolved contradictions.

Confidence: **80%** on provisional values being close enough for initial use. The specific triggering count of 50 is a principled estimate.

### 4b — Layer 1 ε Threshold

**Restated question:** Define ε now, build as runtime-configurable, or defer to engineering iteration?

**Recommendation:** Option ii — runtime-configurable from day one. Initial value: `ε = 0.05` (5% of the score maximum, approximately `0.05 × 1.5 = 0.075` on the composite scoring scale).

**Reasoning:** The ε threshold governs when Layer 1 tiebreaker is "too close to call" and falls to Layer 2. Too small → Layer 2 fires constantly on trivially-similar scores. Too large → Layer 1 makes many wrong calls on genuinely close cases. The founding thesis: this is a runtime parameter, not a hardcoded constant. Build it as `layer1_epsilon: float` in the conflict resolution program's config. Initial value of 0.05 on the normalized composite score is a principled starting point — it means Layer 1 only calls Layer 2 when the composite scores are within 5% of the max. Check-ins entry: ε review after first 50 Layer 2 activations — if Layer 2 consistently surfaces that Layer 1 could have resolved a case, ε is too tight; if Layer 2 is never called, ε is too loose.

Confidence: **75%** on 0.05 as the right starting point. This is the weakest of the four 4x recommendations because ε is the most sensitive to how the score distribution shapes up in practice.

### 4c — Round-Cap at 3 Before Layer 3 Escalation

**Restated question:** Accept 3, change the number, or make configurable?

**Recommendation:** Option i — accept 3. Non-configurable at launch.

**Reasoning:** Three rounds before Layer 3 escalation is a balanced tradeoff: enough attempts to give automated mechanisms a genuine chance to resolve (different Erdős questions might be needed for hard cases, different Trey research might illuminate an empirical contradiction), but bounded so contested neurons don't block PPR indefinitely. Making it configurable at launch adds configuration complexity without corresponding benefit. If the first 50 Layer 3 escalations reveal a pattern (consistently failing at round 2, or consistently resolving at round 3), the round-cap is revisited via Check-ins entry. This follows the A_min pattern: lock a principled value; program measures; Check-ins tune.

Founding thesis: the round-cap is a parameter in the conflict resolution program. Three rounds is specified at build time. Check-ins entry: round-cap review after 25 Layer 3 escalations.

Confidence: **85%** on 3 being the right starting value.

### 4d — Producer-Time `contradiction_class` Tag

**Restated question:** Adopt the steel-man mitigation (factual / empirical / architectural / taste), or skip, or defer?

**Recommendation:** Option i — adopt immediately.

**Reasoning:** The `contradiction_class` tag is the structural solution to a real classification failure: without it, Layer 2's routing decision (which research domain to send the verification request to) is a stochastic LLM judgment, not a deterministic routing. That's the same classification-by-judgment problem that the Re-Eval #2 header-tag mechanism solved for IES — move classification to a structural property of the neuron (written at ingestion time), not a per-event LLM inference.

The tag is simple (one YAML field with four allowed values: factual / empirical / architectural / taste), written at neuron generation time by the ingestion pipeline's LLM-judge step. The ingestion pipeline already has an LLM-judge step for deduplication (ADD/UPDATE/DELETE/NOOP); adding `contradiction_class` classification to that step is minimal overhead.

Without this tag, taste-class contradictions (which have no research-resolvable correct answer) will route to Erdős or Trey via Layer 2, waste research resources, and return inconclusive — forcing Layer 3 anyway but burning two unnecessary research cycles first.

Founding thesis: the ingestion program writes the tag deterministically at neuron creation. AI (LLM-judge) makes the classification once at write time. The conflict resolution program reads the tag deterministically at contradiction-detection time.

Cross-decision dependency: 4d is also referenced in FW-004's Layer 3 operator architecture — the contradiction_class tag is the structural mechanism that routes deterministically into Layer 3 for taste-class items.

Confidence: **90%** on adopting the tag. The four-value taxonomy (factual/empirical/architectural/taste) covers the majority of contradiction types. Edge cases that straddle categories (e.g., an architectural claim grounded in empirical data) can be tagged "architectural" with a secondary annotation — not a blocking concern.

---

## Decision 5 — FW-007 Formal Closure

**Restated question:** Formally close FW-007 (cyclic-topology routing structurally resolved), or keep open as a watch item until the cyclic-detection prefilter is actually built and tested?

**Recommendation:** Option 1 — formally close FW-007.

**Reasoning:** FW-007's trigger condition was "Trey Non-Abelian audit returns OR Erdős Theorem 3 proof returns." Both have returned. The Causal Action Potential delivery (`Erdos.Solution.DarkSkillsTriggerlessGate.md`) provides `Φ_causal(v) = π_v / α > 1.0` as a mathematically absolute, parameter-free, trigger-free cyclic detector — it is a provable property of the graph topology, not an estimate. In a DAG, `E[N_v] ≤ 1`, so `Φ_causal > 1.0` proves a directed cycle exists without any graph-theoretic precomputation.

The FW-007 entry's revisit trigger is satisfied. Its resolution mechanism is specified (CAP gate value > 1.0 → route to Layer 3). Keeping it open as a "watch item until built" is not what FW entries are for — FW entries track architectural decisions that need a decision, not construction status of things already decided. Construction status tracks in the Build Guide (which will have a build-space placeholder for the cyclic-detection routing layer in the TAP build phase).

What changes in the Build Guide: the cyclic-routing layer sits in the TAP build phase as a gate-prefilter between Φ_causal threshold check and skill injection. When `Φ_causal > 1.0`, route to Layer 3's three-layer mechanism instead of normal skill injection. This is a Build Guide build-space placeholder per Standing Order 2, not a FW entry.

Cross-decision dependency: FW-007's closure is also a dependency for FW-008's trigger — FW-008's Check-ins design requires that the CAP gate definition is settled (it is). No blocking dependency remaining.

Confidence: **95%** on formal closure. The structural resolution is mathematically proven and the triggering condition for the revisit is satisfied.

---

## Decision 6 — FW-006 Back-Application Authorization

**Restated question:** Authorize Jiang2 to start FW-006 immediately (parallel with form finalization), hold until form is finalized + Jiang2 has rewritten synthesis in hand (sequential), or authorize Jiang to surface candidates while Jiang2 places them only at Build Guide update time?

**Recommendation:** Option 3 — Jiang surfaces candidates now (listed below); Jiang2 places them during Build Guide update, which happens after Decision 10 sequences the handoff.

**Reasoning:** FW-006 work splits cleanly into two parts:

Part A (Jiang's role): identify what needs forward-reference notes and build-space placeholders. This is analytical work — reading the architectural decisions and determining which components couple to future ones. Jiang can do this now, in this document, without needing the finalized form.

Part B (Jiang2's role): actually placing the notes and placeholders in the Build Guide files. This must happen after Decision 10 sequences the handoff, because Jiang2 placing placeholders before Decisions 2-10 are locked risks placing wrong-spec placeholders that need revision.

Option 1 (Jiang2 starts immediately) risks rework if Decisions 2-10 lock differently than expected. Option 2 (hold everything) misses the opportunity to surface the candidate list now, which Jiang2 will need regardless.

**Candidate forward-reference notes and build-space placeholders for FW-006 (Jiang's Part A — for Jiang2 to place in Part B):**

Forward-reference notes needed (cross-phase couplings where current build couples to future build):
1. Stage 0 (scribe PATH fix, gdrive service account) → Stage 4 (ingestion pipeline reads Scribe log): note at Stage 0 fix site naming Stage 4 coupling
2. Stage 1 ATV (header-tag wrapper) → Stage 5 (LoRa training pipeline, which processes agent interaction history): note at ATV site naming Stage 5's dependency on message envelope format
3. Stage 1 `base_model_config` field → Stage 5 (LoRa training pipeline reads this config): forward note at Stage 1 schema site
4. Stage 1 PPR implementation (`compute_edge_transition_weight` function seam) → Stage 5 (RoMem Semantic Speed Gate): forward note at Stage 1 PPR site naming Stage 5 mode swap
5. Stage 1 `validate_skill_edges` interface → Stage 3 (GoS sparse validation mode swap): forward note at Stage 1 skills graph site
6. Stage 1 TAP cyclic-detection routing layer → Stage 3 Layer 3 mechanism (the cyclic route target): forward note at TAP site naming Layer 3 as the destination for Φ_causal > 1.0 cases

Build-space placeholders needed (deferred items to place in Build Guide at appropriate phase):
1. **Stage 2 — Differential Equivalence + Shadow Mode** (trigger: 500 ATV messages): grammar management workflow expansion. Contains seam definition from Decision 3.
2. **Stage 3 — GoS sparse validation mode** (trigger: N skills, to be set at Build Guide update): `validate_skill_edges` mode swap from dense to sparse. Contains seam, state-handover, trigger.
3. **Stage 3 — Canary grammar rollout** (trigger: multi-agent parallel session volume): grammar deployment pattern expansion.
4. **Stage 5 — RoMem Semantic Speed Gate** (trigger: Layer 0 LoRa operational and local model selected): PPR mode swap from Ebbinghaus SDE to rotational memory. Contains `compute_edge_transition_weight` seam.
5. **Stage 5 — FW-004 Layer 3 operator architecture** (trigger: OQ-3 design work opens): operator/reviewer/authorizer role split specification.
6. **Compression event detector phase — κ empirical calibration** (FW-008): measurement program build-space with Φ_causal ground-truth tracking.
7. **TAP build phase — cyclic-detection routing layer** (FW-007 resolved): Φ_causal > 1.0 → Layer 3 routing. Marked RESOLVED with CAP gate as the mechanism.

Re-Eval #1 and #2 deferrals needing build-space:
- Source multiplier values (4a): calibration parameters, lives in conflict resolution program's config section
- ε threshold (4b): same
- Round-cap 3 (4c): same
- contradiction_class tag (4d): ingestion pipeline, Stage 1
- Verifier model selection (Decision 2, Phase 2): ATV build phase, Stage 1
- Backpressure N parameter (Re-Eval #2 lock): ATV build phase
- Anomaly queue routing transition (Re-Eval #2 lock): forward note at ATV site naming future Brain operator transition

Cross-decision dependency: FW-006 Part B executes as part of the Build Guide update task that Jiang2 executes after Decision 10 sequences the handoff.

Confidence: **90%** on Option 3 as the right sequencing. The candidate list above is complete based on the corpus in context; Window Gravity caveat — there may be coupling points in the Build Guide files that I haven't read in this session. Jiang2 should do an additional sweep of the Build Guide files during execution.

---

## Decision 7 — FW-008 κ Check-ins Concrete Design

**Restated question:** Defer concrete design to Jiang2 + CT at Build Guide update time, lock specific values now, or adopt iterative engineering pattern like A_min?

**Recommendation:** Option 3 (iterative engineering pattern like A_min) with a program specification provided now.

**Reasoning:** Erdős was explicit in `Erdos.Solution.KappaOperationalTightness.md` Answer C: the analytic formula `κ = 2C(1-α)/(αδ)` is mathematically correct as a worst-case bound but operationally too loose for hard-threshold use under realistic Velorin conditions. Specific loosening factors: Davis-Kahan looseness on non-normal sparse matrices, worst-case resolvent alignment, redistribution masking localized distortion, spectral-gap volatility from eigenvalue crowding in sparse d_max=7 graphs at scale.

The A_min pattern applies directly: there is no analytically derivable correct value for the measurement parameters; there is a correct measurement program design. Lock the program design now; values emerge from the program's first measurement cycle.

**Program specification for FW-008 (Jiang2 places in Build Guide compression event detector phase):**

```
κ_measurement_program:
  name: Compression Event Retrieval Precision Monitor
  purpose: Track actual Φ_causal degradation against ground-truth targets after test
           compression events; provide empirical calibration data for κ threshold

  ground_truth_target_set:
    initial_size: 50 neurons (seeded at Brain population Stage 1, 
                  selected to be high-frequency-retrieval c-memory neurons 
                  representative of CT's most common query topics)
    expansion_trigger: Brain reaches 200 c-memory neurons OR 90 days, whichever first
    expansion_target: 200 neurons
    curation: CT personal selection (same constraint as Golden Dataset — cannot be
              AI-curated without biasing the measurement)

  test_compression_protocol:
    mode: synthetic compression on a region COPY (never live Brain)
    trigger: when Brockett flow's commutator norm β drops below 0.15 in any region
             (indicating natural compression readiness, per Theorem 3 JSD algorithm)
    frequency: at most once per fortnight per region, to prevent compounding errors

  measurement:
    metric: mean Φ_causal reduction for ground-truth targets in the compressed region
            (measured before and after compression on the copy)
    threshold: >10% mean reduction triggers alert
    alert_artifact: flag in compressed region's _index.md: 
                    kappa_alert: {date, before_mean, after_mean, percent_reduction}
    action_protocol: halt further compression in that region pending review;
                     flag for Jiang architecture review; use alert data to recalibrate
                     the analytic formula's structural-prior scaling

  analytic_prior_engagement:
    role: structural prior only (not hard threshold)
    use_case: when α changes (architectural config update), re-scale empirical 
              threshold geometrically using the analytic formula as a proportionality
              coefficient, not a replacement for live measurement

  check_ins_entry:
    phase: compression event detector build phase (Stage 4+)
    trigger: after first 10 test compression events
    review_subject: Is the 10% alert threshold too sensitive or too loose? 
                    Is the fortnight cadence correct?
    routing: Jiang analytical review → CT approval for threshold adjustment
```

This is the program design. Jiang2 places this as a build-space placeholder in the compression event detector phase; the specific values (10% threshold, fortnight cadence) become Check-ins entries that are reviewed after the first measurement cycle.

Cross-decision dependencies: FW-008 design completion is a prerequisite for the form finalization per Decision 10. Jiang2 places FW-008's program spec in the Build Guide during the Build Guide update task. No earlier dependency.

Confidence: **82%** on this program specification being sufficient and complete. The 10% degradation threshold is a principled first value; the fortnight cadence is also principled but may be too conservative once the compression event detector is running in practice.

---

## Decision 8 — Persona-Maker Observation (from Re-Eval #7)

**Restated question:** Keep as noted observation only, formal FW-009 entry, or Trey functional research now?

**Recommendation:** Option 2 — FW-009 with concrete trigger.

**Reasoning:** CT's observation is structurally interesting and worth preserving formally: the Brain's neuron pointer graph plus pointer-rating dynamics may organically generate a persona representation from CT's interaction patterns (analogous to how Jiang/Trey/Erdős personas are built from accumulated outputs). This is not a decision to make now — CT has explicitly deferred it to future exploration. But an observation without a FW entry and trigger risks being lost across compaction events, exactly as FW-005 (skills-checker/skills-fixer) was lost.

Concrete FW-009 entry:
- **Trigger to revisit**: when Brain has 500+ c-memory neurons AND CT initiates the exploration direction. Not sooner — the persona-generation hypothesis requires Brain maturity to be testable.
- **Artifact**: FW-009 entry in `Jiang.FutureWork.md`.
- **Routing target**: CT initiates (explicit gating); Jiang analytical review surfaces candidates when trigger is met.

Option 3 (Trey functional research now) is premature and violates the founding thesis — the Brain doesn't exist yet. Trey researching "how production agent systems generate persona representations from interaction data" before there's any interaction data to generate from is Window Gravity in research form. The thesis: build the program (the Brain); AI watches what it produces; Trey researches when there's a real design question grounded in real data.

No pure-novelty audit implications: the persona-maker observation is exploratory, not a novelty claim. When CT decides to explore it, it would be functional Trey research (what patterns emerge, what mechanism amplifies them) not a novelty audit.

Cross-decision dependencies: none. This is independent of all other decisions.

Confidence: **88%** on FW-009 with the 500 c-memory neuron trigger. The count is principled but arbitrary — it represents enough Brain maturity that the pointer dynamics have had time to shape around actual CT usage patterns.

---

## Decision 9 — Bootloader Staleness Cleanup

**Restated question:** Broader bootloader refresh now, defer to a dedicated session, or leave alone until broader restructuring?

**Recommendation:** Option 1 — schedule a broader bootloader refresh pass now, before the Trey and Erdős queues refill.

**Reasoning:** The `feedback_audit_external_agent_context.md` rule locks the "audit before sending any new research request" discipline. But that discipline fires per-request — it catches contamination reactively at the point of each new request. If there are systematic patterns of staleness across the bootloaders (solved Erdős problems still listed as open in the Math Inventory, "human-curated" framing that was inline-corrected in research deliverables but not in the bootloaders themselves, OQ status descriptions for questions that are now structurally resolved like OQ-6's compression event detector criterion), each future Trey session will silently run on that stale framing until Jiang catches it and applies another inline correction.

The research queues are currently empty. This is the optimal moment for a systematic bootloader audit — no in-flight research to protect, and the contamination risk from sending new requests grows each time research files.

What the audit should cover (based on corpus read this session):
1. **Trey.Bootloader.MathInventory.md**: update to reflect all Erdős solutions delivered in Sessions 033-036 (ObliqueJBD/JSD, Causal Action Potential, Cognitive Langevin Dynamics + Brockett flow, Kappa Operational Tightness, ATV Consumer Policy Drift, VEGP Stress Test, Dark Skills Scale, ATV Math Properties)
2. **Trey.Bootloader.VelorinBrain.md** and **Trey.Bootloader.BuildPhilosophy.md**: verify human-curated framing is removed (inline corrections were done 2026-04-25 but need confirmation the right locations were caught)
3. **Erdos.Gem.Instructions.md**: verify Research_Complete load on [BOOT] sentinel is not suppressing any recently-delivered solutions
4. **Trey.Bootloader.AgentRoster.md**: verify agent roles reflect current reality (no stale role descriptions)
5. Any "open question" references in bootloaders to problems now structurally resolved (OQ-6 compression event detector now has its criterion from Brockett flow → JSD; FW-007 is closed)

Option 2 (defer to dedicated session) is suboptimal because research queues will refill before a "dedicated session" is scheduled. The discipline says audit before each request; a systematic pass now is more efficient than N inline corrections over N future sessions.

Option 3 (leave alone until restructuring) is the worst option — bootloader contamination is documented as a real data-quality failure (2026-04-25 incident), and "wait for restructuring" has no concrete trigger.

Cross-decision dependencies: bootloader cleanup can proceed immediately, independent of all other decisions. It is not gated on form finalization or Build Guide update.

Confidence: **87%** on doing it now being better than deferring. The list of what to audit is derived from this session's corpus — Window Gravity caveat: there may be other staleness patterns I haven't read that the audit would surface.

---

## Decision 10 — Form Finalization Sequencing

**Restated question:** Hand to Jiang2 immediately for synthesis rewrite, hold for one final review session, or hand to Jiang2 in stages?

**Recommendation:** Option 1 — hand to Jiang2 immediately after CT locks Decisions 2-10.

**Reasoning:** The form is structurally complete. Seven re-evals are locked with Chairman responses. Every locked outcome is thorough, cross-referenced, and internally consistent. A final review session (Option 2) would surface polish but not architectural gaps — the architecture was deeply scrutinized across seven re-evals. The cost of the review session is the time and token budget; the benefit is polish that Jiang2 can address during the rewrite anyway.

Option 3 (stages — architectural decisions first, Build Guide update later) is unnecessary given the right sequencing. The natural sequence is:
1. CT locks Decisions 2-10 using this recommendation document (now)
2. CT hands the form to Jiang2 for synthesis rewrite (`Jiang2.ReEvaluationResponses.md` updated with locked decisions)
3. Jiang2 executes Build Guide update (FW-006 back-application + Check-ins schedule design + forward references + build-space placeholders + edge ontology unification + all new schemas from 7 locked re-evals)
4. Jiang2 rewrites the Synthesis using post-re-eval locked decisions

Steps 3 and 4 can run in parallel or sequentially — both belong to Jiang2's next task. The Build Guide update does not need to wait for the synthesis rewrite, and vice versa.

**The specific immediate-next sequence:**
After CT locks Decisions 2-10 (using this document):
- CT pastes the Jiang2 prompt from `Jiang2.RecommendationOnFinalization.md` with a follow-up instruction to proceed with synthesis rewrite + Build Guide update
- Jiang2 reads locked decisions, rewrites `Jiang2.ReEvaluationResponses.md`, executes Build Guide update including FW-006 back-application and Check-ins schedule design
- MarcusAurelius (current CLI agent) commits and pushes Jiang2's file outputs

Cross-decision dependencies: all other decisions (2-9) must be locked before this one executes, since the synthesis rewrite reflects all locked decisions.

Confidence: **91%** on Option 1. The form is complete and ready.

---

## Window Gravity Self-Audit

Three things I checked this session to verify my reasoning was not bounded by what happened to be loaded:

1. **Trey VerifierBenchmarkMethodology.md Section 5.2** (vllm-mlx throughput figures): I read these in this session and cited them directly rather than inferring from the form's summary. The 21-87% throughput advantage and the 5.8× TTFT prefix caching speedup are directly from the document.

2. **Erdos.Solution.ATVConsumerPolicyDriftBound.md Proof 5** (cliff edge at τ = A_min): I read this in full this session. The Phase Transition cliff at A_min (where drift activates suddenly) is a load-bearing constraint on how the consumer policy program must monitor τ in real time. Not interpolated from the form.

3. **FW-006 candidate list**: I derived this list from the form's locked outcomes and my session reads, not from the FW registry alone. Window Gravity caveat explicitly stated: there may be coupling points in the V2 Build Guide files I haven't read this session. Jiang2 should do an additional sweep of the Build Guide files during FW-006 Part B execution.

---

[VELORIN.EOF]
