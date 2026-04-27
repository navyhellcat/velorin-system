# Velorin — Check-Ins Schedule and Calibration Deliverables Registry
**All vitality-important recurring reviews and calibration measurements.**
**April 26, 2026 — Produced under FW-013, Decision 4 + Decision 7 standing requirement.**

Every entry specifies: measurement program, data points, threshold, verification path, multi-point distribution, cadence, test specification, logged deliverable, and hard date or target — elements (a) through (k). No vague entries. No "as needed." No "later."

---

## How to Read This Document

Each calibration parameter has MULTIPLE Check-Ins entries — distributed across build phases, not consolidated into one. Each entry specifies what to measure, how to measure it, when the measurement fires, and what artifact proves the measurement happened.

The Calibration Deliverables Registry at the bottom consolidates all measurements into one indexed view, sorted by target date.

---

## Check-Ins by Build Phase

---

### Stage 1 Check-Ins

---

#### CI-S1-01 — ATV Verifier Model VTPS Benchmark (Initial Selection)

**Parameter:** ATV verifier model (Qwen2.5-0.5B vs SmolLM2-1.7B vs other 1-3B models)

**(a) Measurement program:** `infrastructure/atv/benchmark.py` — runs JSONSchemaBench against each candidate model with XGrammar grammar + vllm-mlx backend on Mac Studio M4 Max

**(b) Data points captured:** per-candidate: VTPS (Valid Tokens Per Second = N_total × C / T_total), FRR (false-reject rate), FAR (false-accept rate), OPIS (operating-point inconsistency score across 100-item Golden Dataset Phase 1), average latency, max queue depth before saturation

**(c) Threshold:** select model with highest VTPS while FRR < 5% on Golden Dataset Phase 1. If no candidate satisfies both, escalate to CT before proceeding.

**(d) Verification path:** run the benchmark twice across different times of day (thermal throttling variance on M4 Max); confirm results within 10% variance.

**(e) Multi-point distribution:** one time at Stage 1 ATV build; recurring re-benchmark quarterly.

**(f) Recurrence reminder:** quarterly re-benchmark catches model updates and capability improvements.

**(g) Decision-when-needed trigger:** model update announced by candidate vendor (pull immediately) OR quarterly date elapses.

**(h) Timing:** initial benchmark at ATV Stage 1 build. Quarterly recurrence thereafter.

**(i) Test specification:** 100-item Golden Dataset Phase 1 (CT personally curated: 40 clean analytical, 40 high-complexity multi-domain, 20 edge cases). Synthetic adversarial inputs from the IES grammar. Structural compliance (binary: json_validity + schema_compliance) + semantic fidelity (LLM-as-judge comparison against two-step unconstrained baseline).

**(j) Logged deliverable:** `infrastructure/atv/benchmark_results_YYYY-MM-DD.md` — full VTPS table, FRR/FAR per model, winner selection rationale, Golden Dataset version used.

**(k) Hard target:** complete within 2 days of Stage 1 ATV build completion.

---

#### CI-S1-02 — Tool Capability Matrix Initial Values Review

**Parameter:** Column-normalized tool capability matrix V (initial values for tool-routing program)

**(a) Measurement program:** `infrastructure/tool_router/routing_log_analyzer.py` — reads routing decision log, computes per-tool accuracy across task types

**(b) Data points captured:** per task type per tool: routing decisions, downstream outcome quality (CT rating 1-5, captured in session log), routing override rate (how often CT explicitly overrode the routing program's choice)

**(c) Threshold:** if override rate for any tool×task_type combination exceeds 30% over 100 routing decisions, recalibrate that cell in V.

**(d) Verification path:** before/after comparison of override rate on the same cell after recalibration.

**(e) Multi-point distribution:** first review after 100 routing decisions; quarterly reviews thereafter.

**(f) Recurrence reminder:** quarterly routing log review until override rate stabilizes below 10% across all cells.

**(g) Decision-when-needed:** 100 routing decisions logged OR 90 days elapsed, whichever first.

**(h) Timing:** initial review at ~100 routing decisions; quarterly thereafter.

**(i) Test specification:** compute mean override rate per tool×task_type from routing log. Flag cells above 30%. Compare V column values against outcome quality scores.

**(j) Logged deliverable:** `infrastructure/tool_router/calibration_YYYY-MM-DD.md` — V matrix before/after, override rates, recalibration decisions.

**(k) Hard target:** first review within 30 days of Stage 1 tool-routing program deployment.

---

### Stage 2 Check-Ins

---

#### CI-S2-01 — Source Multiplier Calibration (4a — CT Decision)

**Parameter:** Layer 1 contradiction resolution source multipliers (1.0 agent-generated / 1.2 CT-curated / 1.5 Erdős-verified)

**(a) Measurement program:** `infrastructure/conflict_resolution/multiplier_calibrator.py` — reads Layer 1 resolution log; computes override accuracy (what fraction of Layer 1 "higher-score wins" decisions were later confirmed correct by Layer 2 or CT review)

**(b) Data points captured:** per resolution event: both neuron scores, winning neuron, whether the Layer 2 or Layer 3 confirmation later agreed or disagreed with Layer 1's choice, source_multiplier contribution to the score differential

**(c) Threshold:** if Layer 1 override accuracy drops below 75% over 50 contested cases, recalibrate multipliers.

**(d) Verification path:** run Layer 1 decisions on holdout set of 20 known-resolution cases; confirm accuracy improves or stays stable after recalibration.

**(e) Multi-point distribution:** first review at 50 Layer 1 resolved contradictions; second review at 150; quarterly thereafter.

**(f) Recurrence reminder:** quarterly review of multiplier accuracy until stable above 85% for 6 consecutive months.

**(g) Decision-when-needed:** 50 Layer 1 resolved contradictions OR 90 days post-Stage 3 activation, whichever first.

**(h) Timing:** first at 50 Layer 1 resolutions (~early Stage 3). Quarterly thereafter.

**(i) Test specification:** for each resolution, label it correct (Layer 2/CT confirmed) or incorrect (Layer 2/CT overrode). Compute accuracy per source-multiplier combination. If 1.2 multiplier cases resolve with >80% accuracy, leave unchanged. If below 75%, consider increasing to 1.3.

**(j) Logged deliverable:** `infrastructure/conflict_resolution/multiplier_calibration_YYYY-MM-DD.md` — per-combination accuracy table, recalibration decision.

**(k) Hard target:** first review within 60 days of Stage 3 ingestion pipeline activation.

---

#### CI-S2-02 — ε Threshold Calibration (4b)

**Parameter:** Layer 1 ε threshold (0.05 = "scores within ε → fall to Layer 2")

**(a) Measurement program:** `infrastructure/conflict_resolution/epsilon_calibrator.py` — logs how often Layer 2 was called and whether the Layer 2 result aligned with or contradicted what Layer 1 would have decided with a tiebreaker.

**(b) Data points captured:** count of Layer 2 activations per week, fraction of Layer 2 activations where the composite score difference was < ε vs > ε, quality of Layer 2 resolutions vs simulated Layer 1 tiebreaker outcomes.

**(c) Threshold:** if Layer 2 activation rate exceeds 40% of all contradictions (ε too large, calling Layer 2 unnecessarily), or is below 5% (ε too small, Layer 1 incorrectly resolving cases that need Layer 2), recalibrate.

**(d) Verification path:** simulate Layer 1 tiebreakers on the Layer 2 activation cases; compare outcome quality to actual Layer 2 outcomes. If simulated Layer 1 would have gotten >80% right, ε was too large.

**(e) Multi-point distribution:** first review at 50 Layer 2 activations; quarterly thereafter.

**(f) Recurrence:** quarterly until stable.

**(g) Decision-when-needed:** 50 Layer 2 activations OR 120 days post-Stage 3, whichever first.

**(h) Timing:** first at 50 Layer 2 activations.

**(i) Test specification:** compute Layer 2 activation rate. Compute quality differential between Layer 2 outcome and simulated Layer 1 tiebreaker outcome.

**(j) Logged deliverable:** `infrastructure/conflict_resolution/epsilon_calibration_YYYY-MM-DD.md`

**(k) Hard target:** first review within 90 days of Stage 3 ingestion activation.

---

#### CI-S2-03 — Round-Cap Review (4c)

**Parameter:** Layer 3 escalation round-cap (3 rounds before CT escalation)

**(a) Measurement program:** `infrastructure/conflict_resolution/roundcap_reviewer.py` — reads Layer 3 escalation log; computes resolution rate per round (how many resolve at round 1 vs 2 vs 3 vs not at all).

**(b) Data points captured:** per Layer 3 escalation: round at which resolution occurred, domain (contradiction_class.sub_category), whether CT resolution was definitive or required follow-up.

**(c) Threshold:** if > 60% of cases resolve before round 3 (cap may be too high, CT is getting cases earlier than needed) OR if CT frequently flags "this should not have reached me" (cap too low), recalibrate.

**(d) Verification path:** simulation on historical cases with alternative cap values.

**(e) Multi-point distribution:** first review at 25 Layer 3 escalations; quarterly thereafter.

**(f) Recurrence:** quarterly until pattern stabilizes.

**(g) Decision-when-needed:** 25 Layer 3 escalations OR 180 days post-Stage 3, whichever first.

**(h) Timing:** first at 25 Layer 3 escalations.

**(i) Test specification:** compute round-distribution histogram. CT qualitative review of "should this have reached me?" on 10 sampled cases.

**(j) Logged deliverable:** `infrastructure/conflict_resolution/roundcap_calibration_YYYY-MM-DD.md`

**(k) Hard target:** first review within 120 days of Stage 3 ingestion activation.

---

#### CI-S2-04 — contradiction_class Routing Accuracy Per Path (4d)

**Parameter:** Routing accuracy for each `<primary>.<sub_category>` path in conflict_routing.yaml

**(a) Measurement program:** `infrastructure/conflict_resolution/routing_accuracy.py` — per routing path, computes fraction of resolutions where the routed destination (Erdős/Trey/Jiang/Layer 3) produced a definitive resolution within 1 round vs required escalation.

**(b) Data points captured:** per routing event: contradiction_class label, routing destination, resolution outcome (definitive/escalated/unresolved), time-to-resolve.

**(c) Threshold:** if routing accuracy for any path drops below 70% over 50 contested cases on that path, fires recalibration (taxonomy split, routing reconfiguration, or new destination wired).

**(d) Verification path:** before/after accuracy measurement on the same path after reconfiguration.

**(e) Multi-point distribution:** first review per path at 50 cases on that path; quarterly check across all paths.

**(f) Recurrence:** quarterly across all paths until all paths stable above 80% for 6 months.

**(g) Decision-when-needed:** 50 contested cases on any path OR quarterly date.

**(h) Timing:** per-path at 50 cases; quarterly across all paths.

**(i) Test specification:** per path: compute resolution rate, escalation rate, time-to-resolve.

**(j) Logged deliverable:** `infrastructure/conflict_resolution/routing_accuracy_YYYY-MM-DD.md` — per-path accuracy table, reconfiguration decisions.

**(k) Hard target:** first per-path review within 90 days of each path being activated in Stage 3.

---

#### CI-S2-05 — IES Threshold θ Review (ATV)

**Parameter:** IES enforcement threshold θ = 0.7 (anti-drift bias)

**(a) Measurement program:** `infrastructure/atv/threshold_reviewer.py` — reads ATV log; computes false-reject rate (valid analytical content incorrectly failed) and drift-pass rate (consensus-aligned content passed without IES enforcement).

**(b) Data points captured:** per ATV-enforced message: θ at time, IES enforcement decision, downstream CT quality rating (1-5) for enforced vs non-enforced samples.

**(c) Threshold:** if FRR (false-reject rate on structurally valid analytical content) exceeds 15%, lower θ. If drift-pass rate (consensus-aligned content passing without divergence section) exceeds 10%, raise θ.

**(d) Verification path:** before/after quality comparison on Golden Dataset Phase 1.

**(e) Multi-point distribution:** first review at 500 enforced messages; second review at 500 messages after any θ adjustment.

**(f) Recurrence:** every 500 enforced messages until θ stable for 2,000 consecutive messages.

**(g) Decision-when-needed:** 500 enforced messages logged OR 90 days post-Stage 1 ATV activation.

**(h) Timing:** first at 500 enforced messages.

**(i) Test specification:** compute FRR and drift-pass rate from log. CT samples 20 enforced messages for quality rating. Compare quality distribution enforced vs non-enforced.

**(j) Logged deliverable:** `infrastructure/atv/threshold_review_YYYY-MM-DD.md`

**(k) Hard target:** first review within 60 days of Stage 1 ATV activation.

---

### Stage 3 Check-Ins

---

#### CI-S3-01 — θ_work Empirical Calibration

**Parameter:** Skill injection gate threshold θ_work (provisional 0.5, spectral band 0.375-0.585)

**(a) Measurement program:** `infrastructure/ppr_retrieve.py` skill-injection logging — records every Φ_causal value at skill injection decision point, injection outcome (fired/not), and downstream CT quality rating.

**(b) Data points captured:** per skill injection opportunity: Φ_causal value, θ_work at time, injection decision, skill ID, CT quality rating (1-5) for the resulting skill execution.

**(c) Threshold:** if correct injection accuracy (skill should have fired AND did, or should not have AND didn't) drops below 80% over 50 labeled queries, recalibrate.

**(d) Verification path:** PAC bound requires 738 labeled queries for 5% error / 95% confidence. Use holdout set of 50 labeled queries for before/after comparison after recalibration.

**(e) Multi-point distribution:** first review at 738 labeled queries; second review at 1,500 queries; quarterly thereafter.

**(f) Recurrence:** quarterly until θ_work stable for 3,000 consecutive labeled queries.

**(g) Decision-when-needed:** 738 labeled queries accumulated OR 180 days post-Stage 3.

**(h) Timing:** first at 738 labeled queries.

**(i) Test specification:** label 50 query-skill pairs as "should inject" or "should not inject." Compute accuracy of current θ_work. Adjust within (0.375, 0.585] to maximize accuracy.

**(j) Logged deliverable:** `infrastructure/skill_injection/theta_work_calibration_YYYY-MM-DD.md` — PAC-compliant accuracy table, recalibration decision, new θ_work value.

**(k) Hard target:** first calibration within 60 days of 738 labeled queries being accumulated.

---

#### CI-S3-02 — Golden Dataset Phase 2 Expansion

**Parameter:** ATV Golden Dataset (100 Phase 1 → 300 Phase 2)

**(a) Measurement program:** `infrastructure/atv/golden_dataset_expander.py` — CT curates new cases from production ATV-processed messages.

**(b) Data points captured:** VTPS and FRR/FAR on Golden Dataset v2 vs v1. Distribution of message types in v2 vs v1.

**(c) Threshold:** trigger when 500 real ATV-processed messages accumulated; CT curates expansion from confirmed-valid production messages.

**(d) Verification path:** run full benchmark on v2; compare VTPS/FRR to v1 benchmark results. Confirm v2 covers more message type diversity.

**(e) Multi-point distribution:** one-time expansion trigger at 500 ATV messages.

**(f) Recurrence:** no further expansion until 2,000 messages (at which point v3 optional).

**(g) Decision-when-needed:** 500 ATV-processed messages logged.

**(h) Timing:** at 500 ATV-processed messages.

**(i) Test specification:** CT personally reviews and accepts/rejects each candidate for Golden Dataset. Rejected candidates do not count toward 300 target. Must include at minimum: 60 clean analytical, 60 high-complexity multi-domain, 30 adversarial/edge cases.

**(j) Logged deliverable:** `infrastructure/atv/golden_dataset/v2.json` — 300-item dataset with CT review metadata.

**(k) Hard target:** complete within 30 days of 500th ATV message being logged.

---

### Stage 4 Check-Ins

---

#### CI-S4-01 — κ Empirical Calibration (Commutator Norm Compression Threshold)

**Parameter:** κ for commutator norm compression trigger (analytic formula too loose operationally per Erdős KappaOperationalTightness Answer C)

**(a) Measurement program:** `infrastructure/commutator_monitor/kappa_calibrator.py` — runs test compression events on Brain region COPIES; measures Φ_causal degradation on 50-neuron ground truth set before and after compression.

**(b) Data points captured:** per test compression event: region ID, pre-compression mean Φ_causal on 50-neuron ground truth, post-compression mean Φ_causal, percent reduction, β value at compression trigger, δ (spectral gap) at time of compression, α (fixed 0.25).

**(c) Threshold:** if mean Φ_causal reduction exceeds 10% on ground truth targets → alert (compression degrading retrieval); halt compression in that region; escalate to Jiang review.

**(d) Verification path:** compare Φ_causal before and after on the SAME 50-neuron ground truth set. Also compare against a simulated non-compressed control region.

**(e) Multi-point distribution:** first review after 10 test compression events; second after 25; quarterly thereafter.

**(f) Recurrence reminder:** fortnight cadence for test compression trigger check; quarterly κ parameter review.

**(g) Decision-when-needed trigger:** 10 test compression events completed OR 90 days post-Stage 4 commutator monitor activation.

**(h) Timing:** fortnight cadence for β monitoring; quarterly for κ parameter review.

**(i) Test specification:** 50-neuron ground truth set (CT spot-curates from representative c-memory neurons; refreshed when Brain reaches 200 c-memory neurons). Synthetic compression on a copy of the target region. Measure Φ_causal before/after on ground truth set.

**(j) Logged deliverable:** `infrastructure/commutator_monitor/kappa_calibration_YYYY-MM-DD.md` — per-event compression outcome, Φ_causal delta, κ adjustment decision.

**(k) Hard target:** first κ review within 30 days of 10 test compression events completing.

---

#### CI-S4-02 — H_E Passive Inference Calibration (OQ-5 — Multi-Point Distribution)

**Parameter:** H_E passive inference signal weights and threshold

**(a) Measurement program:** `infrastructure/h_e/inference_calibrator.py` — CT spot-curates a validation set of 30 neurons with known H_E ground truth (CT manually labels); program compares inferred H_E to ground truth.

**(b) Data points captured:** per validation neuron: inferred H_E score (from observable signals), CT ground-truth H_E label (high/medium/low), agreement/disagreement, which signals drove the inference.

**(c) Threshold:** if agreement rate on 30-neuron validation set drops below 70%, recalibrate signal weights.

**(d) Verification path:** before/after agreement rate comparison on same validation set after recalibration.

**(e) Multi-point distribution:**
- **Checkpoint 1 (100 c-memory neurons):** first calibration. Validation set = 20 neurons. Focus: does the system correctly identify the obvious high-H_E cases?
- **Checkpoint 2 (500 neurons):** second calibration. Validation set = 30 neurons. Focus: borderline cases, false positives.
- **Checkpoint 3 (1,000 neurons):** full re-evaluation. Validation set = 30 neurons. Consider adding new signal types.
- **Quarterly thereafter.**

**(f) Recurrence reminder:** quarterly review of signal weights after Checkpoint 3.

**(g) Decision-when-needed trigger:** 100/500/1,000 c-memory neuron milestones. Quarterly dates thereafter.

**(h) Timing:** per checkpoint milestones; quarterly after Checkpoint 3.

**(i) Test specification:** CT personally selects 20-30 neurons and provides H_E ground truth labels. Program computes inferred H_E. Agreement = inferred matches ground truth within one category (e.g., inferred "medium" and ground truth "high" = disagree; inferred "high" and ground truth "high" = agree).

**(j) Logged deliverable:** `infrastructure/h_e/calibration_YYYY-MM-DD.md` — validation set, per-neuron comparison, agreement rate, signal weight adjustments.

**(k) Hard targets:**
- Checkpoint 1: within 30 days of 100th c-memory neuron being written
- Checkpoint 2: within 30 days of 500th c-memory neuron
- Checkpoint 3: within 30 days of 1,000th c-memory neuron
- Quarterly: first quarterly on the 3-month anniversary of Checkpoint 3

---

### Stage 5 Check-Ins

---

#### CI-S5-01 — LoRa Retraining Trigger Threshold (ε_LoRa)

**Parameter:** Persona Manifold change threshold for LoRa retraining (ε_LoRa)

**(a) Measurement program:** `infrastructure/commutator_monitor/persona_manifold_tracker.py` — computes Lebesgue measure of symmetric difference between current and previous Persona Manifold snapshots after each compression event.

**(b) Data points captured:** per snapshot: set of quasi-abelian regions (commutator below β_abelian), symmetric difference from previous snapshot, measure of the difference, LoRa retraining decision (yes/no).

**(c) Threshold:** if μ(P(t_now) △ P(t_prev)) > ε_LoRa → trigger LoRa retraining. Initial ε_LoRa = 0.15 (15% of Persona Manifold changed). Recalibrate after first 3 retraining events.

**(d) Verification path:** compare LoRa perplexity on CT query holdout set before and after retraining. Confirm perplexity decreases (or stays stable within 5%).

**(e) Multi-point distribution:** first ε_LoRa review after 3 retraining events; second after 10; quarterly thereafter.

**(f) Recurrence:** quarterly ε_LoRa review until retraining frequency stabilizes.

**(g) Decision-when-needed:** 3 LoRa retraining events completed.

**(h) Timing:** per retraining trigger (event-driven); quarterly parameter review.

**(i) Test specification:** CT query holdout set (20 queries sampled from recent CT sessions). Compute LoRa perplexity before/after. Confirm improvement.

**(j) Logged deliverable:** `infrastructure/lora/retraining_log_YYYY-MM-DD.md` — Persona Manifold snapshot, ε_LoRa threshold decision, perplexity comparison.

**(k) Hard target:** first ε_LoRa review within 30 days of 3rd LoRa retraining event.

---

## Calibration Deliverables Registry

One canonical view of all calibration work, indexed by parameter and earliest target date.

| ID | Parameter | First Target | Trigger | Deliverable Location |
|---|---|---|---|---|
| CI-S1-01 | ATV verifier model selection | Stage 1 ATV build + 2 days | ATV build complete | `infrastructure/atv/benchmark_results_*.md` |
| CI-S1-02 | Tool capability matrix V | 30 days post routing program deployment | 100 routing decisions | `infrastructure/tool_router/calibration_*.md` |
| CI-S2-01 | Source multipliers (4a) | 60 days post Stage 3 activation | 50 Layer 1 resolutions | `infrastructure/conflict_resolution/multiplier_calibration_*.md` |
| CI-S2-02 | ε threshold (4b) | 90 days post Stage 3 | 50 Layer 2 activations | `infrastructure/conflict_resolution/epsilon_calibration_*.md` |
| CI-S2-03 | Round-cap (4c) | 120 days post Stage 3 | 25 Layer 3 escalations | `infrastructure/conflict_resolution/roundcap_calibration_*.md` |
| CI-S2-04 | contradiction_class routing accuracy (4d) | 90 days post each path activation | 50 cases per path | `infrastructure/conflict_resolution/routing_accuracy_*.md` |
| CI-S2-05 | IES threshold θ | 60 days post ATV activation | 500 enforced messages | `infrastructure/atv/threshold_review_*.md` |
| CI-S3-01 | θ_work skill injection | 60 days post 738th labeled query | 738 labeled queries | `infrastructure/skill_injection/theta_work_calibration_*.md` |
| CI-S3-02 | Golden Dataset Phase 2 | 30 days post 500th ATV message | 500 ATV messages | `infrastructure/atv/golden_dataset/v2.json` |
| CI-S4-01 | κ compression threshold | 30 days post 10th test compression | 10 test compressions | `infrastructure/commutator_monitor/kappa_calibration_*.md` |
| CI-S4-02a | H_E inference (Checkpoint 1) | 30 days post 100th c-memory neuron | 100 c-memory neurons | `infrastructure/h_e/calibration_*.md` |
| CI-S4-02b | H_E inference (Checkpoint 2) | 30 days post 500th c-memory neuron | 500 c-memory neurons | `infrastructure/h_e/calibration_*.md` |
| CI-S4-02c | H_E inference (Checkpoint 3) | 30 days post 1,000th c-memory neuron | 1,000 c-memory neurons | `infrastructure/h_e/calibration_*.md` |
| CI-S5-01 | ε_LoRa retraining threshold | 30 days post 3rd retraining event | 3 LoRa retraining events | `infrastructure/lora/retraining_log_*.md` |

---

[VELORIN.EOF]
