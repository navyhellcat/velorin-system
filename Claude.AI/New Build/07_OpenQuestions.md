# 07 — Open Questions
**Current status on every OQ. Updated April 26, 2026 to reflect Sessions 033-036 outcomes.**

---

## OQ-1: Ingestion Pipeline Design — SUBSTANTIALLY RESOLVED

**Original question:** How does raw input automatically become neurons with rated pointers?

**Resolved (confirmed locked):**
- Rating metric: NPMI + LLM-judge hybrid (cosine similarity formally rejected — symmetric, cannot model directed logical dependency)
- LLM-judge calibration: forced distribution output (guarantees ρ* = 0.78 density constraint)
- Initial affinity: Holographic Cold-Start (geometric projection residual from W_global)
- Updates: Continuous Affinity Clutch + A_base SDE (Hebbian reinforcement + Ebbinghaus decay)
- Relation-type classification: 9-class labels REQUIRED for all auto-ingested neurons (binary routing derived from label; LLMs can reliably do tax/them binary classification zero-shot; 9-class has ~70-80% accuracy with few-shot examples — acceptable for initial build, fine-tuned classifier is the long-term plan)
- Deduplication: NPMI filter → LLM-judge with ADD/UPDATE/DELETE/NOOP gate (cosine similarity alone causes fatal corruption)
- Region/area assignment: community detection via connectivity (not static taxonomy)
- Contradiction handling: provenance weighting (recency + source authority)
- PDF parsing: OpenDataLoader PDF v2.0 (replaces Docling — 1GB footprint, times out on >1MB)
- Source provenance: bbox coordinates from OpenDataLoader → `source_coords` YAML field

**Still pending — execution (not design):**
- Full ingestion pipeline not yet built or tested (Stage 3 in 06_BuildSequence.md)
- Multimodal input handling (photos, audio, video beyond AffectNet approach) — deferred to Phase 2

**Status:** DESIGN COMPLETE. Start building text-only Phase 1. Multimodal deferred.

---

## OQ-2: Automated Neuron Creation Mechanism — OPEN

**Question:** What creates neurons automatically? How does the system detect what's worth ingesting?

**Known:**
- The old Scribe approach (PostToolUse hook → shell script → Claude subprocess) is legacy
- Direction confirmed: MCP/API-based automation
- Any automation should be an MCP tool call, not a standalone subprocess

**Pending:**
- Specific MCP architecture for automated neuron creation
- Whether this happens in the ingestion pipeline or separately
- What triggers it (session close? file write? API call from Claude?)

*→ Build-space placeholder Stage 4+: FW-005 skills-checker/skills-fixer thread surfaces here
(trigger: OQ-2 or OQ-3 design work opens).*

**Status:** OPEN. Build manually first. Automate when you understand the pattern.

---

## OQ-3: Multi-Agent Automation Architecture — OPEN

**Question:** How does NemoClaw-style orchestration work for Velorin? Claude as primary interface, specialized tools and models via MCP/API.

**Known:**
- Direction confirmed: A2A protocol for agent-to-agent delegation; MCP for agent-to-tool
- PAL MCP worth evaluating as orchestration layer once Brain operational
- A2A: Gemini subagents for research via A2A delegation from Claude

**Pending:**
- Specific MCP orchestration design
- How task routing decisions are made (which model gets which task)
- Alexander's role in this architecture

*→ Build-space placeholder Stage 4+: FW-004 Layer 3 operator architecture lives here
(trigger: this OQ opens). Cannot design OQ-3 correctly without FW-004's decisions.*

**Status:** OPEN. Build Brain first.

---

## OQ-4: Brain Region Taxonomy — PARTIALLY ANSWERED

**Question:** How should Brain regions and areas be organized? Neuroscience-derived or emergent?

**Resolved:**
- Edge ontology unification (9-class Brain + 4-type GoS) is a BUILD NOW pre-pipeline task (see Pre-Stage 0 in 06_BuildSequence.md)
- Unified mapping established: instance-of/derived-from → dependency; operational thematic → workflow; supports/contradicts → semantic; alternative is skills-specific
- The Brain's folder-level region structure (Operations, Connectivity, Agents, Principles, Company, Intelligence) is navigation scaffolding — it stays as-is
- Semantic organization happens in E₈ crystal layer via Pointer Gravity and PPR traversal
- Five Boxes are life domains (administrative overlay) — NOT Brain regions

**Remaining open:**
- How the Brain's folder structure evolves as Simon-Ando clustering reveals natural regions from data
- Whether Community/ and Intelligence/ regions are the right two additions beyond the original four

**Status:** ACTIVE — edge ontology unification in progress (Pre-Stage 0).

---

## OQ-5: H_E (Emotional Charge) Measurement — OPEN

**Question:** How does the system assign emotional charge (H_E) to a neuron?

**Known:**
- H_E mathematically defined: δ*(u→v) = (1+H_E(u))·δ(u→v) — high H_E prevents demotion
- Research returned: Trey.Research.EmotionalMemorySalience.Measurement.md
  - Self-report (CES-7, IES-R) measures narrative anchoring, not raw arousal — inadequate alone
  - GSR/EDA tracks sympathetic nervous system activation — proxy for H_E
  - Observer effect: asking CT to rate a memory's emotional charge alters the trace
  - Passive inference (involuntary intrusion frequency, response latency) is the correct measurement approach
  - fNIRS + EEG headband: viable non-invasive hardware for future H_E inference
- CT recommendation from Session 028: Option B — passive tracking + qualitative prior (high/medium/low) at neuron creation, never prompted directly

**Pending decision (CT):**
- Exact YAML field format (float? categorical scale?)
- Whether H_E is set at neuron creation or updated over time
- Hardware acquisition (fNIRS + EEG — optional, not blocking the build)

**Do NOT add H_E to neuron YAML until this is resolved.** C-memory neurons without H_E are
still protected (class: c-memory is the protection mechanism).

**Status:** RESEARCH COMPLETE. Protocol decision pending from CT.

---

## OQ-6: Compression Event Detector — STRUCTURALLY DEFINED

**Original question:** How does the system detect that a pattern has become load-bearing enough to encode in the LoRa?

**Resolved (Sessions 034-035):**
- Criterion: Brockett double-bracket gradient flow drives commutator norm β → 0
- JSD fires when β ≤ β_abelian where:

$$\beta_{abelian} = \frac{\alpha \delta}{2C(1-\alpha)} \cdot \theta_{work} \cdot \|\pi\|_\infty$$

- Commutator norm β = ‖[P_tax, P_them]‖_F is the structural friction operator
- As CT applies a framework consistently across diverse contexts, P_tax and P_them commute more closely
- κ: analytic formula $\kappa = 2C(1-\alpha)/(\alpha\delta)$ is a structural prior only — empirical calibration required

*→ Build-space placeholder Stage 4+: κ empirical calibration. Check-ins entry: after 10 test compression events.*

**Pending — implementation (not math):**
- Compression event detector program that monitors β per region
- JSD algorithm implementation on region copies
- Connection to LoRa training pipeline (Stage 5)

**Status:** MATH COMPLETE. Implementation deferred to Stage 4+.

---

## OQ-7: Session Close Protocol — OPEN

**Question:** At the end of each session, what exactly happens automatically?

**Known:**
- Current close protocol is fully manual
- The optimization is a design task — Jiang should do it directly
- Eats ~12,000 tokens in current form

**Status:** JIANG TASK. Design this before automation work begins.

---

## OQ-8: Compaction Hooks — OPEN

**Question:** How do PreCompact/PostCompact hooks save/restore state during context compaction?

**Known:**
- pre-compact-task-gate.sh was written, then deleted by CT (too risky without testing)
- exit code 2 blocks compaction; exit code 1 does not
- TEAM_STATE.md with 2-hour recency window is the correct pattern
- autoCompactEnabled and autoCompactWindow are real settings

**Process (required before wiring):**
1. Write the script
2. Test standalone several times
3. Add to settings.local.json with short timeout
4. Monitor for one session before relying on it

**Status:** DESIGN ONLY. Build and test standalone before wiring.

---

## OQ-9: Intake Test Design — BLOCKED

**Question:** The structured decision-scenario experience that reveals CT's reasoning patterns and produces Layer 1-3 material for a new user.

**Status:** BLOCKED ON CT AUTHORIZATION since Session 013.

---

## OQ-10: Velorin.Welcome Rename — RESOLVED

The new build uses Velorin.Welcome/ as the name from the start. No rename needed.

---

## OQ-11: RTX 4090 Windows Build — DEFERRED

**Spec:** RTX 4090, AMD Ryzen 9 X3D, 64GB DDR5-6000 CL30, AM5
**Blocked on:** ARM64 Claude Code crash (GitHub issue #12160)
**Action:** Buy 2×32GB DDR5-6000 CL30 RAM kit now while prices low.

**Status:** DEFERRED. Buy RAM. Build when bug resolved.

---

## OQ-12: θ_work Empirical Calibration — PENDING BUILD DATA

**Question:** What is the exact optimal θ_work within the spectral band (0.375, 0.585]?

**Known:**
- Spectral band analytically derived: (0.375, 0.585]
- Provisional value 0.5 is within the band
- Minimum dataset: 738 labeled queries (PAC bound, ε=0.05, δ=0.05)

**Pending:** Brain populated with 738+ labeled queries from actual use.

*→ Build-space placeholder Stage 3: θ_work calibration. Check-ins entry: after 738 labeled queries exist. Config: skill_injection_threshold: float — NOT hardcoded.*

**Status:** SPECTRAL BAND LOCKED. Empirical calibration pending Stage 3 data.

---

## OQ-13: Skills Library N Threshold (Sparse vs Dense Validation) — PENDING

**Question:** At what skill count does GoS sparse validation become worth building?

*→ Build-space placeholder Stage 3: GoS sparse validation mode (trigger: N skills, defined at Stage 3 design). Check-ins entry: 90 days of dense validation — review skill count and cost.*

**Status:** PENDING. Decide N when Stage 3 is operational.

---

## OQ-14: ATV Verifier Model Selection — PENDING BENCHMARK

**Question:** Which 1-3B parameter model achieves highest VTPS on IES grammar on Mac Studio M4 Max?

**Candidates:** Qwen2.5-0.5B, SmolLM2-1.7B
**Benchmark:** JSONSchemaBench + XGrammar + vllm-mlx + VTPS metric + 100-item Golden Dataset Phase 1
**Primary metric:** VTPS = (N_total × C) / T_total (schema-invalid outputs are zero-throughput events)
**Secondary metric:** FRR (false-reject rate) — prioritized over FAR per anti-drift discipline

*→ Build-space placeholder Stage 1: ATV verifier model selection is Stage 1 engineering output.*

**Status:** PENDING benchmark program execution.

---

## OQ-15: Layer 3 Operator Architecture — PARKED (FW-004)

**Question:** Who performs Layer 3 contradiction review; who authorizes; what is the escalation protocol when local model cannot resolve?

*→ Build-space placeholder Stage 4+: FW-004 (trigger: OQ-3 design work opens). Operator/Reviewer/Authorizer role split for future local Mac-Studio MA.*

**Status:** PARKED per CT at Stage 0. Trigger: OQ-3 design work opens.

---

## OQ-16: GDrive Service Account Migration — STAGE 0 OPERATIONAL FIX

This is not an architectural question but it blocks the porting workflow.

**Problem:** OAuth tokens expire every 7 days (recurred Session 027 and Session 035).
**Fix:** Google Service Account with JSON key file (permanent credentials).
**Priority:** HIGH — must ship before next 7-day window expires.

**Status:** STAGE 0 REQUIRED. See FW-003.

---

## Research Still Queued

**All Trey and Erdős queues are currently empty** (as of Session 036).

Deferred-novelty list (for end-of-cycle batched pass when architecture is locked and publication begins):
- "VEGP generalizes Wald's SPRT" claim (steel-man from Re-Eval #4)
- Revised Theorem 3 (Cognitive Langevin Dynamics / Brockett flow) vs arXiv 2602.13759
- Causal Action Potential as triggerless gate + cyclic detector
- JSD as compression algorithm vs Double-Bracket Flows literature

No pure-novelty Trey audits until end-of-cycle batched pass per `feedback_no_pure_novelty_audits.md`.

---

[VELORIN.EOF]
