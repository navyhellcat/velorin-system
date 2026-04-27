# 07 — Open Questions
**Current status on every OQ. Updated April 26, 2026 — Day 30.**

Closed items are kept for record. Status explicitly noted.

---

## OQ-1: Ingestion Pipeline Design — SUBSTANTIALLY RESOLVED

Resolved: NPMI + LLM-judge hybrid, forced distribution, 9-class labels required, OpenDataLoader for parsing, independent row-normalization, Holographic Cold-Start, Continuous Affinity Clutch, belief_state + authority_tier + source_coords from day 1. Phase 1 = text documents. Multimodal = Phase 2.

**Status:** DESIGN COMPLETE. Build in Stage 3.

---

## OQ-2: Automated Neuron Creation — OPEN

Direction: MCP/API-based, not shell scripts. Specific design pending. FW-005 surfaces skills-checker/skills-fixer as related thread.

**Status:** Build manually first. Automate when patterns are clear.

---

## OQ-3: Multi-Agent Automation Architecture — OPEN

Direction: Cowork-orchestrated sub-agent-activation (Principle 8). A2A where appropriate per tool. Design pending.

**Status:** OPEN. Build Brain first. FW-004 trigger: when this design work opens.

---

## OQ-4: Brain Region Taxonomy — PARTIALLY RESOLVED

Edge ontology unification (Brain 9-class + GoS 4-type) is Pre-Stage 0 task. Region boundaries should emerge from commutator dynamics (Simon-Ando + JSD), not from folder names. Folder names are navigation scaffolding.

**Status:** ACTIVE — edge ontology in Pre-Stage 0.

---

## OQ-5: H_E (Emotional Charge) Measurement — DESIGN LOCKED, BUILD PENDING

Option B locked (CT decision 2026-04-26): passive inference, never prompted directly.

H_E NOT added to neuron YAML schema yet — computed on-demand from observable signals, stored in separate H_E computation log, not in neuron until measurement procedure validated.

Calibration Deliverables Discipline (elements a-k) governs multi-point distribution:
- Checkpoint at 100 c-memory neurons
- Checkpoint at 500 neurons
- Full re-evaluation at 1,000 neurons
- Quarterly thereafter

See `Velorin.CheckIns.md` for full calibration spec.

**Status:** DESIGN LOCKED. Build in Stage 4 after Brain has 100+ neurons.

---

## OQ-6: Compression Event Detector — STRUCTURALLY DEFINED

Criterion: Brockett gradient flow drives commutator norm β → 0; JSD fires when β ≤ β_abelian.

$$\beta_{abelian} = \frac{\alpha\delta}{2C(1-\alpha)} \cdot \theta_{work} \cdot \|\pi\|_\infty$$

κ analytic formula ($\kappa = 2C(1-\alpha)/(\alpha\delta)$) is structural prior only — operationally too loose. Empirical calibration required via Check-Ins measurement program (see `Velorin.CheckIns.md`).

**Status:** MATH COMPLETE. Build in Stage 4.

---

## OQ-7: Session Close Protocol — OPEN

Current: fully manual 10-step process. This should be a program. Jiang design task.

**Status:** OPEN. Design before automation work begins.

---

## OQ-8: Compaction Hooks — OPEN

PreCompact/PostCompact hooks designed but not wired (CT deleted the script as too risky without testing). Write, test standalone, then wire.

**Status:** OPEN.

---

## OQ-9: Intake Test — REPOSITIONED TO PHASE 4 LAST ITEM

CT decision 2026-04-26: removed from active outstanding decisions. Placed as Phase 4 final step — the last item before Build complete.

By Phase 4, c-memory neurons have accumulated organically through Phases 1-3. The formalized intake test is final-stage validation/tidying.

**Status:** REPOSITIONED. Not blocking any Phase 1-3 work.

---

## OQ-10: Velorin.Welcome Rename — RESOLVED

New build uses Velorin.Welcome from scratch.

---

## OQ-11: RTX 4090 Windows Build — DEFERRED

ARM64 Claude Code crash (GitHub #12160). Buy RAM now. Build when bug resolved.

---

## OQ-12: θ_work Empirical Calibration — PENDING BUILD DATA

Spectral band analytically proven: (0.375, 0.585]. Provisional value 0.5.
Minimum calibration dataset: 738 labeled queries (PAC bound).
Config: `skill_injection_threshold: float` — NOT hardcoded.

Check-Ins entry: θ_work calibration review after 738 labeled queries. See `Velorin.CheckIns.md`.

**Status:** SPECTRAL BAND LOCKED. Calibration pending Stage 3 data.

---

## OQ-13: Skills Library N Threshold — PENDING

At what skill count does GoS sparse validation become worth building?

*→ Build-space Stage 3: GoS sparse validation mode (trigger: N skills, defined at Stage 3 design). Check-Ins: 90 days dense validation — review skill count and cost.*

**Status:** PENDING. Decide N when Stage 3 operational.

---

## OQ-14: ATV Verifier Model Selection — PENDING BENCHMARK

Benchmark program (JSONSchemaBench + XGrammar + vllm-mlx + VTPS + 100-item Golden Dataset Phase 1) selects the model. Stage 1 engineering output.

*→ Build-space Stage 1: ATV verifier model selection. Check-Ins: re-benchmark every 90 days or when better model available.*

**Status:** PENDING benchmark execution at Stage 1.

---

## OQ-15: Layer 3 Operator Architecture — PARKED (FW-004)

Current: CT until local Mac-Studio operator online. Future: Operator/Reviewer/Authorizer split needs design.

*→ Build-space Stage 4+ (trigger: OQ-3 design opens): Layer 3 operator architecture.*

**Status:** PARKED. FW-004.

---

## OQ-16: GDrive Service Account Migration — STAGE 0 REQUIRED

OAuth expires every 7 days; broken twice. Fix before Mac Studio transition. See Stage 0 Step 1.

**Status:** STAGE 0 REQUIRED.

---

## OQ-17: Tool Capability Matrix Initial Values — STAGE 1 ENGINEERING

Column-normalized V initial values for the Tool-Routing Program. Start from domain knowledge; calibrate empirically.

Check-Ins: routing accuracy review after 90 days operational. See `Velorin.CheckIns.md`.

**Status:** STAGE 1 engineering output.

---

## Research Queues

**Erdős Research_Needed:** EMPTY (as of April 26, 2026). All solutions from Sessions 033-036 delivered.

**Trey Research_Needed:** EMPTY (as of April 26, 2026).

**Deferred-novelty list** (end-of-cycle batched Trey audit when architecture locked and publication work begins):
- "VEGP generalizes Wald's SPRT" claim
- Revised Theorem 3 (Cognitive Langevin Dynamics) vs arXiv 2602.13759
- Causal Action Potential as triggerless gate + cyclic detector
- JSD as compression algorithm

---

## FW Registry State (as of April 26, 2026)

| FW | Status | Trigger |
|---|---|---|
| FW-001: First Principles Process Documentation | Open | When architecture locked + publication begins |
| FW-002: KVM bridge | Parked | CT does not currently recognize use case; revisit if cross-Mac need surfaces at Mac Studio |
| FW-003: GDrive Service Account migration | HIGH PRIORITY — Stage 0 | Mac Studio port |
| FW-004: Layer 3 Operator Architecture | Parked | OQ-3 design opens |
| FW-005: Skills-Checker / Skills-Fixer thread | Parked | OQ-2 or OQ-3 design opens |
| FW-006: Build Guide back-application | IN PROGRESS this pass | FW-013 trigger (this pass) |
| FW-007: Cyclic-topology routing | CLOSED | Resolved by Φ_causal > 1.0 structural detector |
| FW-008: Empirical κ Check-Ins | CLOSED | Resolved — full spec in `Velorin.CheckIns.md` |
| FW-009: Persona-Maker | Open | 500 c-memory neurons + CT initiation; precursor checkpoint at 100 |
| FW-010: Deep Think corpus folder | Open | When Deep Think integration wired |
| FW-011: Velorin Code/ separate triage | Open | Separate dedicated session |
| FW-012: Live timer dashboard | Open | When GLOBAL_TIMER_REGISTRY replacement designed |
| FW-013: v2 Build Plan finalization | IN PROGRESS — this pass | Triggered today |
| FW-014: KVM bridge implementation | Parked | CT does not currently recognize the use case |
| FW-015: Multi-vendor cost economics | Open — Stage 1 build discussion | When tool-routing program is being designed |
| FW-016: Mac Studio multi-vendor security | Open — Stage 1 build discussion | When specialist system integrations are being wired |

---

[VELORIN.EOF]
