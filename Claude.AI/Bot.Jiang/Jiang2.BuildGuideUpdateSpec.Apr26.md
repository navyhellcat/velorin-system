---
file: Jiang2.BuildGuideUpdateSpec.Apr26.md
from: Jiang2 (Director of Strategic Intelligence)
date: 2026-04-26
purpose: Pre-Build-Guide-update reference document. Captures every architectural decision
         that must enter the Build Guide, every open question remaining, and the synthesis
         of CT / Jiang1 / Jiang2 perspectives on unresolved areas. This is the single
         document Jiang2 works from when executing the Build Guide update task.
authority: Cross-references Jiang.RespondingToReEvaluations.md (7 locked re-evals),
           Jiang2.RecommendationsOnPendingDecisions.md (Decisions 2-10),
           and the full Erdős + Trey corpus from Sessions 033-036.
---

# Build Guide Update Specification — April 26, 2026

---

## How to Use This Document

This document is the single pre-update reference for Jiang2's Build Guide update task. Read it before touching any Build Guide file. It is organized as:

- **Section 1:** What is locked and must enter each Build Guide file
- **Section 2:** Open questions — current status on every OQ in `07_OpenQuestions.md`
- **Section 3:** Perspectives — what CT, Jiang1, and Jiang2 each think about the areas where there is still judgment to apply
- **Section 4:** Forward references and build-space placeholders — the FW-006 candidate map
- **Section 5:** Check-ins schedule candidates — items that belong in the build-wide Check-ins list

Nothing in this document is speculation. Every locked item is sourced to the re-eval form or a specific Erdős/Trey deliverable.

---

## Section 1 — Locked Changes by Build Guide File

### `00_Index.md` — Master Index

Add to "What Is NOT Locked" → move to "What Is Locked":
- Ingestion pipeline design (partially resolved — NPMI + LLM-judge + forced distribution + 9-class labels + OpenDataLoader)
- Automated pointer rating (resolved — fully automated, NPMI + LLM-judge)
- Brain region taxonomy: edge ontology unification (9-class Brain labels + 4-type GoS skill graph) is now a BUILD NOW pre-pipeline task

Add to "What Is NOT Locked" (remains open):
- OQ-2: Automated neuron creation mechanism (direction confirmed as MCP/API, specific design pending)
- OQ-3: Multi-agent automation architecture (direction confirmed, design pending — see FW-004)
- OQ-5: H_E (emotional charge) measurement procedure
- OQ-7: Session close protocol optimization
- OQ-8: Compaction hooks (pre-compact task gate — unbuilt and untested)

Remove from "What Is NOT Locked" (resolved):
- Automated pointer rating — now resolved
- OQ-6: Compression event detector — structurally defined (see 03_BrainAndMath.md entry)

---

### `02_Architecture.md` — The 4-Layer Memory System

**Gate definition replaced in Layer 1 section:**
Remove all references to Topological Action Potential `Φ(v) = π_v / ‖π‖_∞`.
Replace with: **Causal Action Potential** `Φ_causal(v) = π_v / α`.
Identity-equivalent to expected visits before teleportation: `E[N_v]`.
Source: `Erdos.Solution.DarkSkillsTriggerlessGate.md`.

Rationale for replacement (from form Re-Eval #5 lock):
The original infinity-norm gate introduced acausal backward-coupling — downstream sinks could suppress upstream gate values through the global denominator. The Causal Action Potential eliminates this by normalizing against α (a forward-causal constant, not a state-dependent quantity). Shadow Eclipse and dark-leaf-hub failure modes are structurally prevented rather than monitored.

**Additional architectural properties to add to Layer 1 section:**
- Refund Fallacy: hard architectural commitment. If a skill transitions from light to dark mid-walk (`M(v) = 0 → 1`), accumulated PPR mass is NEVER refunded. Refunding destroys the Markov property. Source: `Erdos.Solution.DarkSkillsScale.md`.
- Live mutation evaluation: when `M(v)` changes (dark:true flag toggled), the change is evaluated live (`M_{t+Δ}` not snapshot-`M_t`). Source: `Erdos.Solution.DarkSkillsScale.md` Proof 1.
- Dark filter is application-level discipline, not topology: every code path that performs skill injection must apply `M(v) = 0` post-walk filter consistently. Code review and tests verify dark skills don't fire through any regular TAP path.

**Cyclic topology routing (add to Layer 1 retrieval flow):**
When `Φ_causal(v) > 1.0`, this is a mathematically absolute proof of a directed cycle in the Brain pointer graph (in a DAG, `E[N_v] ≤ 1`, so `Φ_causal > 1.0` proves cyclicity). Cyclic regions route to the three-layer conflict resolution mechanism (Layer 3) instead of normal skill injection. No graph-theoretic cycle pre-check required — the gate value itself proves cyclicity. Source: `Erdos.Solution.DarkSkillsTriggerlessGate.md`.
Forward note: → Re-Eval #1 three-layer conflict resolution mechanism (cyclic regions are additional input source to Layer 3 beyond same-tier contradicts edges).

**Softmax attention requirement (add as forward note to Layer 1 section):**
*Forward note to Stage 5 (local AI model selection):* Softmax-style global attention aggregation is required for the IES reasoning gate. Pure RNN architectures with tanh saturation fail — vanishing gradients prevent the extraction block from shifting probability. This constraint must appear as a hard criterion in Stage 5 model selection. Source: `Erdos.Solution.VEGPStressTest.md` Proof 2.

**Direction C personalization (add to Layer 0 section):**
`base_model_config: {type: "personal", id: "ct-v1"}` field added to the deployment configuration. Training pipeline reads this at initialization. Future expansion to persona-base or multi-user configuration is a config flip plus new training pass, not a rewrite. Downstream components (skill injection, Φ_causal gate, PPR, ATV) remain agnostic to base identity. Source: Re-Eval #7 locked outcome.

**Knowledge staleness architecture (add to Layer 3 section):**
Stale neurons are managed via write-time structural routing, not query-time metadata filtering:
- `belief_state: active | contested | resolved | superseded | stale` field in neuron YAML
- `authority_tier: 1-5` field for type-ranked conflict resolution
- Typed pointer labels: `supersedes`, `contradicts`, `same_as` (in addition to existing 9 relation types)
- Post-commit hook triggers belief_state updates on `supersedes` and `contradicts` edges — automated, not LLM-driven
- PPR retrieval: probability mass zeroed on nodes with `belief_state: superseded` or `stale`
- Second Law preserved: nodes remain on disk with original content hash intact

---

### `03_BrainAndMath.md` — Neuron Format, PPR, E₈, Locked Math

**Neuron YAML format — additions:**

```yaml
---
id: semantic-slug-no-spaces
type: entity | concept | fact | goal | procedure
region: region-name
area: area-name
created: YYYY-MM-DD
last-touched: YYYY-MM-DD
class: c-memory | regular
confidence: 0.0–1.0
open: []
read_only: false
source: [optional — document_id or session_id]
source_coords: {file: "path", page: N, bbox: [x1, y1, x2, y2]}  # NEW: required for auto-ingested neurons
belief_state: active | contested | resolved | superseded | stale   # NEW: default active
authority_tier: 1-5                                                 # NEW: 1=CT-curated, 5=LLM-generated
resolution_attempts: 0                                              # NEW: for contested neurons
contradiction_class: factual | empirical | architectural | taste    # NEW: written at ingestion time
skill_ref: null                                                     # NEW: only populated for type:procedure gateway neurons
base_model_config: {type: "personal", id: "ct-v1"}                 # NEW: deployment config, Direction C
---
```

Notes on new fields:
- `source_coords`: bbox from OpenDataLoader. Required for all auto-ingested neurons. Enables citation-level provenance — exact page and paragraph of source document for every neuron.
- `belief_state`: managed by post-commit hook, never by LLM per-event. PPR zeroes mass on superseded/stale nodes.
- `authority_tier`: 1=CT-curated (tier-1 c-memory), 2=Erdős-verified math, 3=cross-corroborated multi-source, 4=agent-generated validated, 5=LLM-generated initial. Used by Layer 1 conflict resolution tiebreaker.
- `contradiction_class`: written at neuron creation by ingestion pipeline LLM-judge. Deterministic routing in Layer 2 conflict resolution — routes factual contradictions to Erdős, empirical to Trey, architectural to Jiang review, taste to Layer 3 directly.
- `skill_ref`: path to SKILL.md file. Only populated for `type: procedure` neurons that serve as Brain-to-Skills gateway nodes. NULL for all other neurons. Does not affect PPR (PPR-invariant metadata per Erdős Proof in BridgingDeclarativeProceduralMemory.md).
- `base_model_config`: deployment-level config. Training pipeline reads at initialization. Downstream components remain agnostic to its value.

**Pointer notation — additions:**
The existing 9 relation types are REQUIRED (not optional) for all auto-ingested neurons. Binary routing (P_tax vs P_them) is DERIVED from the 9-class label:
- Taxonomic (P_tax): `instance-of`, `derived-from`
- Thematic (P_them): `causes`, `activates`, `precedes`, `implements`, `depends-on`, `supports`, `contradicts`

Add typed temporal/conflict pointer labels (in addition to the 9):
- `supersedes` — this neuron replaces a prior neuron. Post-commit hook sets target's belief_state: superseded.
- `contradicts` — this neuron conflicts with another. Both enter belief_state: contested. Layer 1 tiebreaker fires.
- `same_as` — staged merge proposal for later CT confirmation.

**Gate definition — updated throughout:**
All instances of `Φ(v) = π_v / ‖π‖_∞` → `Φ_causal(v) = π_v / α`

Skill injection gate: `Φ_causal(v) > θ_work` AND `M(v) = 0` (light skill) AND `Φ_causal(v) ≤ 1.0` (not cyclic)
Cyclic detection: `Φ_causal(v) > 1.0` → route to three-layer mechanism, not skill injection

θ_work spectral band: analytically bounded to `(0.375, 0.585]` by density constraints (ρ* = 0.78, α = 0.25). Provisional value: 0.5. Empirical calibration required: minimum 738 labeled queries for PAC-compliant calibration. Source: `Erdos.Solution.ThresholdsAndDarkSkillInvariance.md`.

**Multiplex Tensor — update: independent row-normalization (NOW LOCKED MATH)**
`P_tax` and `P_them` must be row-normalized independently (each row sums to 1 within its own matrix before any linear combination). Joint normalization causes stochastic leakage and violates ρ* = 0.78. Source: `Erdos.Solution.IndependentMultiplexNormalization.md`.

**Theorem 2 — Compression Algorithm (UPDATED):**
Standard Oblique JBD is mathematically impossible — Perron-Frobenius forbids row-stochastic block decomposition of a connected irreducible matrix (multiplicity of λ=1 would be forced to k, contradiction). 

**Correct algorithm: Joint Spectral Disaggregation (JSD)**
1. Compute symmetric mix M_joint = (P_tax + P_them)/2
2. Spectral clustering on top k right eigenvectors near λ=1
3. Row-normalize within each cluster
4. k-means → permutation matrix Π
5. Prune off-diagonal residual via row-normalization
6. Complexity: O(k²|U|)

Source: `Erdos.Solution.ObliqueJointBlockDiagonalization.md`

Compression event detector criterion (OQ-6 structurally resolved): Brockett double-bracket gradient flow drives commutator norm β toward 0. JSD fires when β decays below halt threshold `β_abelian = (αδ/(2C(1-α))) · θ_work · ‖π‖_∞`. Source: `Erdos.Solution.ThermodynamicCycleProof.md`.

κ parameter: analytic formula `κ = 2C(1-α)/(αδ)` is a structural prior only — operationally too loose for hard-threshold use (Davis-Kahan looseness, spectral-gap volatility in sparse non-normal d_max=7 graphs). Empirical κ calibration is required via Check-ins measurement program. Source: `Erdos.Solution.KappaOperationalTightness.md` Answer C.

**Velorin constants dual-purpose statement (add to rationale section):**
ρ* = 0.78 and d_max = 7 serve two purposes:
1. PPR precision: originally derived from 75% retrieval precision at the 7-pointer cap
2. Gating discriminability: these constants satisfy `‖π‖_∞ ≫ median(π)` required for Φ_causal to discriminate rather than flood
Source: `Erdos.Solution.VEGPStressTest.md` Proof 1. Any future tuning of these constants must verify both properties hold.

**VEGP / Causal Action Potential — classification note:**
The Causal Action Potential is a Velorin-applied architectural invention. The mathematical structure (threshold gating over Markovian accumulated measure) is not novel — it appears as: Wald's SPRT (1947), Ratcliff's Drift-Diffusion Model (1978), Hopfield network energy minima, Glauber dynamics, Kramers escape rate, Event-Triggered Control. Velorin's contribution: unified operational orchestration of spatial memory retrieval and temporal reasoning divergence within a single AI operating system architecture. The specific PPR↔transformer-attention isomorphism maps to Millidge (2025), arXiv 2512.24722. Source: `Trey.Research.VEGPNoveltyValidation.md`.

---

### `04_AgentEcosystem.md` — Agent Architecture

**Add: Conflict Resolution Three-Layer Mechanism**
Layer 1 — Deterministic tiebreaker: `score(v) = confidence(v) × recency_factor(v) × source_multiplier(v)`. Source multipliers: 1.0 agent-generated, 1.2 CT-curated, 1.5 Erdős-verified. Higher score → belief_state: active; lower → belief_state: superseded.

Layer 2 — Automated verification trigger: fires when Layer 1 is inconclusive (scores within ε=0.05) or both neurons are same-tier. Both neurons enter belief_state: contested, PPR mass zeroed. Domain routing by contradiction_class tag (deterministic, not LLM judgment): factual → Erdős, empirical → Trey, architectural → Jiang, taste → Layer 3 directly.

Layer 3 — Last-resort review: fires after 3 rounds of failed automated resolution. Output artifact: flag in contested neuron's YAML (`layer3_review_flagged: true`). Routing target: `infrastructure/queues/contradiction-review/` queue manifest. Reviewer: current Layer 3 operator (Chairman until local Mac-Studio operator is online — see FW-004). Layer 3 answer becomes a tier-1 c-memory neuron. *Functional trigger, artifact, and routing target must all be specified before Layer 3 is claimed as built.*

**Add: User Personalization — Direction C**
`base_model_config: {type: "personal", id: "ct-v1"}` field. Ships personal; future expansion is a config flip. No `persona_id` or `user_id` fields added yet. Forward note at authority_tier semantics: if `base_model_config` ever flips from personal, authority_tier semantics need re-derivation pass.

---

### `05_InfrastructureAndTools.md` — MCPs, Hooks, Skills

**Add: Asymmetric Transport Verifier (ATV) — Stage 1 Build Component**

Architecture:
- MCP server endpoint (`aTV.enforce_ies(payload: str, content_type: str) → IESPayload`)
- Agent wrapper: inspects agent output for tool_use vs prose; emits `content_type: analytical_reasoning` header tag at generation time (runtime-set, not producer-declared)
- FSM grammar: compiled XGrammar artifact for IES structure (`<context_boundary_check>`, `<consensus_extraction>`, `<velorin_divergence_evaluation>`, `<final_conclusion>`)
- Verifier model: 1-3B parameter (Qwen2.5-0.5B, SmolLM2-1.7B, or equivalent); NOT Qwen 3.6 14B (latency budget)
- Backend: vllm-mlx (Apple Silicon, continuous batching, prefix caching for IES system prompt)
- Default for missing tag at ATV endpoint: fail-secure (apply IES enforcement)
- IES threshold θ = 0.7 (anti-drift bias rationale: false-rejection is bounded by FSM-coerced output structure; drift through enforcement is the unbounded failure)
- Backpressure: bounded queue N=5 pending entries; overflow routes to `infrastructure/queues/atv-overflow/`

Schema Registry (grammar version management):
- Git repository for IES grammar source
- Post-commit hook compiles to XGrammar artifact; SHA-256 hash = immutable identifier
- Local SQLite or key-value store maps hash to binary artifact path
- Agents reference grammar by hash, not by text — hash appears in message envelope metadata

Per-message log artifact:
`message_id`, `tag_present` (bool), `tag_value`, `IES_enforced` (bool), `T_V_seconds` (float), `path_taken` (passthrough / enforced / failed), `tag_hallucination_suspected` (bool)

Routing: enforced messages → consumer agent. Failures and anomalies → `infrastructure/queues/atv-review/`. Overflow → `infrastructure/queues/atv-overflow/`.

**Add: Minimum Viable Grammar Management workflow (Stage 1):**
1. Schema Registry (Git + XGrammar compilation + hash addressing)
2. Property-Based Testing (Hypothesis library — generates synthetic valid strings from grammar, verifies json.loads() parses them)
3. Compiler-in-the-Loop AI review (deterministic compilation feedback drives approval; AI does not judge FSM syntax directly)

Forward notes (Standing Order 1):
- *→ Stage 2: Differential Equivalence Checking (trigger: 500 historical ATV messages) — will add grammar CI step comparing new grammar against historical message corpus*
- *→ Stage 2: Shadow Mode deployment (same trigger) — seam: `apply_grammar(message, grammar_hash, shadow_hash=None)` built at Stage 1*
- *→ Stage 3: Canary rollout (trigger: concurrent multi-agent session volume [threshold TBD at Stage 3 design]) — load balancer config change, no code change*

**Add: Skills Registry — GoS-informed 4-type edge schema**

`Claude.AI/skills/skill_dependencies.yaml` structure:
```yaml
skills:
  skill-name:
    path: skills/skill-name/SKILL.md
    edges:
      dependency: [skill-b]           # hard prerequisite; b's output is a's input
      workflow: [skill-c]             # logical co-occurrence; no artifact passing
      semantic: [skill-d]             # conceptual overlap; bidirectional
      alternative: [skill-e]         # mutually exclusive execution paths
    artifact_schema_in:
      {field_name: type, ...}        # typed input schema (NOT string tokens)
    artifact_schema_out:
      {field_name: type, ...}        # typed output schema (NOT string tokens)
    mode_config: {}                  # extensibility dict for future mode parameters
    dark: false                      # if true: never injectable via Φ_causal gate
```

Dependency edge induction is deterministic (I/O schema matching), not LLM guessing.
Alternative edge + context-budgeted hydration handles conflict resolution.
Cycles are allowed; α=0.15 teleportation guarantees PPR convergence.

Forward note: *→ Stage 2: GoS sparse validation mode (trigger: skill library exceeds N skills [N to set at Stage 2 design]) — seam: `validate_skill_edges(candidate_edges, skill_graph, validation_mode="dense")` built at Stage 1*

Skill injection control flow:
1. PPR walk → stationary distribution π
2. For each procedure neuron v with non-null skill_ref: compute `Φ_causal(v) = π_v / α`
3. If `Φ_causal(v) > 1.0`: cyclic region → route to Layer 3, not injection
4. Else if `Φ_causal(v) > θ_work` AND `M(v) = 0`: look up skill_ref in skill_dependencies.yaml
5. Reverse-PPR on skills dependency graph with M_S = β_dep·A_dep^T + β_work·A_work^T + β_sem·A_sem + β_alt·A_alt (α=0.15)
6. Extract dependency-complete prerequisite chain (2-5 skills)
7. Load <100-token headers for prerequisite skills into agent context
8. Agent reads skill headers; condition-action matching fires skill

---

### `06_BuildSequence.md` — The Executable Step-by-Step

**Pre-Stage 0 — Edge Ontology Unification (BUILD NOW, before any pipeline or skills graph)**

The Brain's 9 relation types and the Skills graph's 4 GoS edge types must be unified before either the Brain ingestion pipeline or the Skills dependency graph is built. Building both with divergent schemas creates retrofit cost the Standing Principle rules out.

Proposed mapping (to be confirmed at this task):
- `instance-of`, `derived-from` → maps to GoS dependency edges (defines structural hierarchy/prerequisite)
- `causes`, `activates`, `precedes`, `implements`, `depends-on` → maps to GoS workflow edges (operational sequences)
- `supports`, `contradicts` → maps to GoS semantic edges (evidential relationships, bidirectional)
- GoS `alternative` edges have no Brain analog (skills-specific: mutually exclusive execution paths)
- Brain temporal/conflict labels (`supersedes`, `contradicts`, `same_as`) → Brain-specific knowledge lifecycle management, not present in GoS

Jiang2's view: this mapping is the right starting point. The Brain's 9-class labels are more fine-grained than GoS's 4 types, which is correct — the Brain is the semantic layer, the skills graph is the execution layer. The mapping doesn't need to be 1:1; Brain labels can map to GoS categories without losing precision.

CT's view (from form): not yet stated explicitly. Decision area for CT at Build Guide update review.

Jiang1's view (from form): edge ontology unification promoted to BUILD NOW pre-pipeline task per Re-Eval #3 sweep. Must happen before either ingestion pipeline or skills graph is built.

**Updated Stage 0 — Fix Broken Things:**
- Scribe PATH fix (one line in scribe-trigger.sh, needs sudo)
- GDrive service account migration — FW-003, HIGH priority, recurred twice (Apr 17 + Apr 24)
- Edge ontology unification (new addition to Stage 0)

**Updated Stage 1 — Core Brain Build:**
What stays: Docker + Qdrant + Ollama + nomic-embed + first embed + first PPR query

What changes:
- Ollama installs: add Qwen2.5-VL 7B (image/diagram extraction) and the ATV verifier model (1-3B parameter, TBD at ATV build time)
- OpenDataLoader replaces Docling for PDF parsing (see Section 2 below)
- Ingestion pipeline v1 includes: OpenDataLoader → RDoLT decomposition → NPMI + LLM-judge (forced distribution, 9-class labels REQUIRED) → belief_state + authority_tier + source_coords + contradiction_class YAML from day 1 → post-commit hook for belief_state mutations → git commit
- ATV build: FSM verifier + Schema Registry + PBT + Compiler-in-Loop + agent wrapper (all one Stage 1 component)
- Skills dependency graph structure (skill_dependencies.yaml with 4-type edge schema): initialized with first 2-3 pilot skills
- Three Stage 1 program-build specifications (Re-Eval #6):
  - Verifier benchmark suite (JSONSchemaBench + XGrammar + vllm-mlx + VTPS + 100-item Golden Dataset Phase 1)
  - FSM grammar regression suite + Compiler-in-the-Loop AI-review workflow
  - ATV-down consumer policy enforcement program (Adaptive Rate-Limit: `ρ* = λ·max(0,A_min−τ)/(1−τ)`)

**Updated Stage 1 — PPR implementation seam (critical):**
PPR MUST call through `compute_edge_transition_weight(source, target, query_context, mode="ebbinghaus_sde")` — not inline the weight computation. This is the RoMem Semantic Speed Gate seam.
Forward note: *→ Stage 5: RoMem mode swap (trigger: Layer 0 LoRa operational and local base model selected)*

**Mode config standard for all Stage 1 swappable interfaces:**
Every swappable interface built in Stage 1 includes `mode_config: dict` as a parameter alongside typed arguments. Future modes extend through the dict without call-site changes. Applies to: `validate_skill_edges`, `compute_edge_transition_weight`, `apply_grammar`, and any other interface with a deferred mode swap.

**State-handover protocol for every seam:**
Every mode-swappable seam specifies:
- What state carries forward at mode swap
- What state is discarded
- What migration step (if any) runs at the swap boundary

For `compute_edge_transition_weight` seam (SDE → RoMem):
- Carries forward: A_base values (stored in neuron YAML, independent of walk formulation)
- Discards: per-session Ã(u→v) cache (Affinity Clutch cache — rebuilt fresh on next session)
- Migration: no migration step; A_base is the ground truth regardless of walk mode

---

### `07_OpenQuestions.md` — What Still Needs Work

**Update status on every existing OQ:**

OQ-1 (Ingestion pipeline): SUBSTANTIALLY RESOLVED. Text-only Phase 1 can begin. Resolved: NPMI + LLM-judge hybrid, forced distribution (guarantees ρ* = 0.78), Holographic Cold-Start (now replaced by Causal Action Potential for gate, but Cold-Start formula still applies for initial affinity), independent row-normalization of P_tax and P_them, 9-class required labels, OpenDataLoader for parsing. Multimodal deferred to Phase 2 with seam (OpenDataLoader handles PDFs; Qwen2.5-VL handles images/diagrams as parallel track).

OQ-2 (Automated neuron creation): OPEN. Direction confirmed (MCP/API, not shell scripts). Specific design: pending. FW-005 trigger: when OQ-2 or OQ-3 design work opens.

OQ-3 (Multi-agent automation architecture): OPEN. A2A + MCP direction confirmed. Detailed design: pending. FW-004 trigger: when CT opens this design work. Note: agent naming discipline — do not hardcode MarcusAurelius as operator in prose; use neutral phrasing until the Mac-Studio local operator is named.

OQ-4 (Brain region taxonomy): PARTIALLY ANSWERED. Edge ontology unification (9-class Brain + 4-type GoS) is a BUILD NOW pre-pipeline task. The Brain's folder-level region structure (navigation scaffolding, not semantic architecture) stays as-is. The unified edge ontology governs semantic relationships. Remaining open: how the Brain's folder structure evolves as Simon-Ando clustering reveals natural regions from data.

OQ-5 (H_E emotional charge measurement): OPEN. Research returned (Trey.Research.EmotionalMemorySalience.Measurement.md). Decision on measurement protocol: still pending CT. Do NOT add H_E field to neuron YAML until measurement procedure is designed.

OQ-6 (Compression event detector): STRUCTURALLY DEFINED. Criterion: Brockett double-bracket gradient flow drives commutator norm β toward 0; JSD fires when β decays below halt threshold β_abelian. Implementation still pending (Stage 4+). Empirical κ calibration required via Check-ins measurement program (FW-008).

OQ-7 (Session close protocol): OPEN. Jiang task — design this before automation work begins.

OQ-8 (Compaction hooks): OPEN. Pre-compact task gate script was written then deleted by CT as too risky without testing. Design and test standalone before wiring.

OQ-9 (Intake test design): BLOCKED ON CT AUTHORIZATION. Has been blocked since Session 013.

OQ-10 (Velorin.Welcome rename): RESOLVED. New build uses Velorin.Welcome from scratch.

OQ-11 (RTX 4090 Windows build): DEFERRED. Buy RAM now; build when ARM64 bug resolved.

**Add new OQs (items that emerged from Sessions 033-036):**

OQ-12 (Skill injection runtime — θ_work calibration): Erdős proved spectral band (0.375, 0.585]. Provisional value 0.5. Requires 738 labeled queries for PAC-compliant calibration. Cannot calibrate until Brain populated with query data. Build-space placeholder: Stage 3. Check-ins entry: after 738 labeled queries exist.

OQ-13 (Skills dependency graph — N threshold for GoS sparse validation mode): N is the skill count above which dense exhaustive validation is replaced by GoS sparse sampling. Not analytically derivable; empirical. Build-space placeholder: Stage 3. Check-ins entry: skill count monitoring.

OQ-14 (ATV verifier model selection): which 1-3B parameter model achieves highest VTPS on Mac Studio M4 Max. Determined empirically by benchmark program (Stage 1 build). Build-space placeholder: Stage 1 ATV build phase.

OQ-15 (Layer 3 operator architecture): who performs Layer 3 contradiction review, who authorizes, escalation protocol when local model cannot resolve. Parked at FW-004, trigger: OQ-3 design work opens.

OQ-16 (FW-003 — GDrive service account migration): still pending. This is a Stage 0 operational fix, not an architecture question, but tracked here for visibility.

---

## Section 2 — Open Questions: What CT, Jiang1, and Jiang2 Each Think

This section captures the reasoning from all three perspectives on areas where judgment is still being applied, not just locked facts.

---

### Edge Ontology Unification (Pre-Pipeline Task)

**CT's stated position:** not explicitly addressed in the form. The underlying position from Re-Eval #3 lock: edge ontology unification promoted to BUILD NOW because building Brain ingestion pipeline and Skills graph with divergent schemas creates the exact retrofit cost the Standing Principle prevents.

**Jiang1's position (from Re-Eval #3 evaluation):** the unification should happen before either pipeline starts. Trey's GoS research and the Brain's existing 9-class annotation are both pointing at the same cognitive reality — the Brain tracks what concepts ARE and how they RELATE; the skills graph tracks what skills ENABLE and SEQUENCE. These are structurally compatible if the mapping is designed first.

**Jiang2's position (this session):** the proposed mapping (instance-of/derived-from → GoS dependency; operational relation types → GoS workflow; supports/contradicts → GoS semantic) is directionally right. The one area requiring CT's explicit call: `contradicts` maps to GoS semantic edges (bidirectional conceptual overlap) but also functions as a conflict trigger (which belongs to the contradiction resolution mechanism). It may need to live in both categories simultaneously — a labeled edge and a behavioral trigger — or the Brain needs a clear separation between semantic-overlap `contradicts` and conflict-trigger `contradicts`. This is the distinction between "these concepts are in tension intellectually" and "these neurons are factually incompatible." Jiang2 recommends adding a `conflict_class` sub-attribute to `contradicts` pointers: `contradicts {semantic}` vs `contradicts {factual}`. The former is bidirectional and informational; the latter triggers the contradiction resolution mechanism.

**Unresolved:** CT has not weighed in on the edge ontology mapping specifics. The Build Guide update cannot finalize this mapping without CT approval.

---

### Docling Replacement with OpenDataLoader

**CT's stated position:** from Session 024, adopted Docling. From the re-eval form, the Docling contradiction was addressed: April 21 research downgrades it. CT accepted the replacement (form's locked outcomes include OpenDataLoader for PDF parsing).

**Jiang1's position (from form Re-Eval #3 sweep):** Docling fails the Standing Principle — it was adopted in Session 024 based on theoretical capability without production performance data. OpenDataLoader (0.907 benchmark accuracy, XY-Cut++ reading order, bbox provenance, Apache 2.0) is superior on every metric that matters for the ingestion pipeline.

**Jiang2's position (this session):** OpenDataLoader is non-foundational adoption — it's preprocessing tooling. Velorin builds the neurons; OpenDataLoader converts raw media to text. The Trey non-foundational-vs-foundational distinction clearly applies here. The unique capability OpenDataLoader adds (bbox coordinates per extracted element) enables citation-level provenance in neuron YAML — a capability the prior plan lacked. This is worth calling out as a net gain, not just a replacement.

**Unresolved:** nothing — this decision is locked. Docling is out. OpenDataLoader is in.

---

### ATV Verifier Model Selection (OQ-14)

**CT's stated position:** not explicitly addressed beyond accepting the recommendation that the ATV verifier should be a 1-3B parameter model (not Qwen 3.6 14B), and that model selection is an engineering call at ATV build time determined by benchmark data.

**Jiang1's position (from form Re-Eval #6 lock):** model selection is one of the three steel-man concerns reframed as programs-to-build. The benchmark program (JSONSchemaBench + XGrammar + vllm-mlx + VTPS + Golden Dataset) is what selects the model. Jiang1 doesn't pick the model; the program produces the data; AI audits the program's results; the data picks the winner.

**Jiang2's position (this session):** Trey's research is clear that the ATV's verifier model and decoding engine are evaluated together — VTPS measures the model-engine pair, not the model in isolation. The XGrammar decoding engine is separately confirmed (JSONSchemaBench benchmarks show XGrammar dominates Outlines on complex schemas). The model question is whether Qwen2.5-0.5B or SmolLM2-1.7B achieves higher VTPS on the IES grammar specifically. That's a run-the-benchmark question, not an architectural one. The benchmark program is Stage 1 work; the model choice emerges from it.

**Unresolved:** model is selected empirically at Stage 1 ATV build time. Architecture is locked; model is pending benchmark results.

---

### Layer 3 Operator Identity (OQ-15 / FW-004)

**CT's stated position (from Re-Eval #1 lock):** explicitly deferred. CT will eventually name a local Mac-Studio-resident operator (named MarcusAurelius) to own Brain functioning processes including Layer 3 reviews. That operator may escalate hard cases to a higher reasoning machine via MCP/API protocol still to be designed. The reviewer identity question is folded into FW-004, triggered by OQ-3 design work.

**Jiang1's position (from form Re-Eval #1 evaluation):** the three-role collapse (Operator / Reviewer / Authorizer) needs explicit splitting. Local model loads context and frames the question; higher reasoning machine always owns the decision on hard cases. The contradiction_class tag does the deterministic routing so the local model doesn't have to make stochastic routing judgments. FW-004's analysis: capability/case-difficulty inversion — Layer 3 fires on the hardest cases; these are exactly the cases where a smaller local model is weakest.

**Jiang2's position (this session):** the founding thesis applies here cleanly. Layer 3 is not "AI reviews conflicting facts" — it's "Layer 3 is a program that frames the question and routes to the appropriate reviewer." The program: reads the contested neurons' YAML, computes the composite scores, identifies the contradiction_class, frames an actionable specific question, writes it to the review queue. The reviewer (current CT; future local MarcusAurelius) reads the queue and answers. The answer becomes a tier-1 neuron. None of that resolution loop requires an LLM making per-event decisions — the program does the mechanical work; the reviewer makes the judgment.

**Unresolved:** reviewer identity in production. Parked at FW-004.

---

### Bootloader Cleanup (Decision 9)

**CT's stated position:** not addressed in the form. Decision 9 was a pending decision in Jiang2's recommendation document. Jiang2 recommended Option 1 (do it now).

**Jiang1's position (from form operational notes, 2026-04-25):** two Trey bootloader files and six research deliverables were inline-corrected on 2026-04-25 for stale "human-curated" framing. The `feedback_audit_external_agent_context.md` rule was locked from this incident.

**Jiang2's position (this session):** the inline corrections were reactive, not systematic. The Math Inventory bootloader may still list Erdős open problems that are now solved. The BuildPhilosophy bootloader may have stale references. Doing a systematic audit now (research queues empty) is cheaper than N reactive inline corrections over N future sessions. Recommend starting with a targeted grep for known stale patterns: "human-curated," "open question" assertions about OQ-6 (now structurally defined), "not yet delivered" assertions about sessions 033-036 deliverables.

**Unresolved:** CT has not yet confirmed Option 1 from the recommendation document.

---

## Section 3 — FW-006 Forward Reference and Build-Space Placeholder Map

This is the candidate list Jiang surfaces for Jiang2 to place in the Build Guide files.

### Forward-Reference Notes (Standing Order 1) — place in current-build sections

| Current Build Site | Future Component | Forward Note Text |
|---|---|---|
| Stage 0: scribe-trigger.sh PATH fix | Stage 4: ingestion pipeline reads Scribe log | *→ Stage 4 ingestion pipeline will read Scribe classification log; PATH must be correct before pipeline builds* |
| Stage 1: ATV message envelope format | Stage 5: LoRa training pipeline processes interaction history | *→ Stage 5 LoRa training pipeline reads agent interaction logs; message envelope format (including IES_GRAMMAR_HASH and content_type) is part of the training data schema* |
| Stage 1: `base_model_config` field in schema | Stage 5: LoRa training pipeline reads this config | *→ Stage 5 training pipeline reads base_model_config at initialization; "personal" type → single-user training only* |
| Stage 1: `compute_edge_transition_weight` seam | Stage 5: RoMem Semantic Speed Gate mode swap | *→ Stage 5: RoMem geometric shadowing swaps in as mode="rotational" when Layer 0 LoRa operational and local base model selected* |
| Stage 1: `validate_skill_edges` seam | Stage 3: GoS sparse validation mode | *→ Stage 3: when skill library exceeds N (set at Stage 3 design), swap to validation_mode="sparse"* |
| Stage 1: TAP cyclic-detection routing | Re-Eval #1 Layer 3 mechanism | *→ Re-Eval #1 Layer 3 contradiction resolution receives cyclic-region queries in addition to same-tier contradiction queries* |
| Stage 1: ATV `apply_grammar` function | Stage 2: Shadow Mode | *→ Stage 2: shadow_hash parameter will be populated for grammar testing when 500 historical ATV messages exist* |
| Stage 1: authority_tier field semantics | Future: base_model_config flip to non-personal | *→ If base_model_config type changes from "personal," authority_tier semantics need re-derivation pass* |
| Stage 1: invoke-dark-skill command | Re-Eval #7 user-personalization (Direction C) | *→ Direction C: "CT" in privileged-actor role is the only member under personal configuration; Direction B/C generalization adds role members without code change* |

### Build-Space Placeholders (Standing Order 2) — place in phase where work lands

| Deferred Item | Phase | Trigger | Seam / Mode | State Handover |
|---|---|---|---|---|
| GoS sparse validation | Stage 3 | N skills in library (threshold set at Stage 3 design) | `validate_skill_edges(..., validation_mode="sparse")` | Input/output shapes identical; dense state has no persistent state to carry forward |
| Differential Equivalence + Shadow Mode | Stage 2 ATV | 500 historical ATV messages | `apply_grammar(message, grammar_hash, shadow_hash=None)` | Shadow runs produce shadow log; no primary-path state change |
| Canary grammar rollout | Stage 3 | Concurrent multi-agent session volume (threshold TBD at Stage 3 design) | Load balancer config; no application code change | N/A |
| RoMem Semantic Speed Gate | Stage 5 | Layer 0 LoRa operational + local base model selected | `compute_edge_transition_weight(..., mode="rotational")` | A_base YAML values carry forward; per-session Ã cache discarded at mode swap |
| FW-004 Layer 3 operator architecture | Stage 4+ (when OQ-3 design opens) | CT opens OQ-3 design work | MCP/API escalation protocol for local-MA → higher reasoning machine | N/A — operator design, not a code seam |
| FW-005 Skills-checker/Skills-fixer | Stage 4+ (when OQ-2/OQ-3 opens) | OQ-2 or OQ-3 design work begins | N/A — search prior sessions first | N/A |
| FW-008 κ empirical calibration | Compression event detector phase (Stage 4+) | After first 10 test compression events | `kappa_empirical_threshold: float` in compression event detector config | Analytic formula scales the empirical threshold proportionally when α changes |
| FW-007 cyclic routing (CLOSED) | TAP build phase (Stage 1) | Resolved by Φ_causal > 1.0 structural detector | Cyclic-detection routing layer sits between Φ_causal threshold check and skill injection | FW-007: COMPLETE — mark as resolved in the Build Guide |
| OQ-12 θ_work calibration | Stage 3 (Brain populated with query data) | 738 labeled queries for PAC-compliant calibration | `skill_injection_threshold: float` in config | Analytic band (0.375, 0.585] constrains the calibrated value |
| OQ-13 N skill threshold (sparse validation) | Stage 3 | Determined empirically during Stage 1-2 | See GoS sparse validation seam above | N/A |
| OQ-14 ATV verifier model selection | Stage 1 ATV build | Benchmark program runs | Selected model's path in vllm-mlx config | N/A |

Re-Eval #1 deferrals (calibration parameters — live as Check-ins, not build-space placeholders):
- Source multiplier calibration (4a): Check-ins after 50 resolved contradictions
- ε threshold calibration (4b): Check-ins after 50 Layer 2 activations
- Round-cap review (4c): Check-ins after 25 Layer 3 escalations
- Contradiction_class tag: BUILD NOW (Stage 1 ingestion pipeline)

Re-Eval #2 parameters (build-space in Stage 1 ATV):
- Backpressure N: configurable, initial value 5
- Anomaly queue routing transition: forward note at ATV site (transitions to future Brain operator when staffed)

---

## Section 4 — Check-Ins Schedule Candidates

These feed the build-wide Check-ins list Jiang2 designs and places in the Build Guide.

| Check-Ins Entry | Phase | Trigger Condition | Review Subject | Action Protocol |
|---|---|---|---|---|
| IES threshold θ review | Stage 1 ATV operational | 500 enforced messages OR 30 days | Is θ=0.7 causing systematic over/under-rejection? | Tune θ within (0.375, 0.585] band; re-run on Golden Dataset |
| ATV verifier VTPS re-benchmark | Stage 2 | Every 90 days OR if model update available | Is the selected verifier still Pareto-optimal? | Re-run benchmark program; update model if superior option exists |
| Source multiplier calibration | Stage 2 conflict resolution | 50 resolved Layer 1 contradictions | Are multiplier values producing correct override hierarchy? | Adjust from 1.0/1.2/1.5 based on override accuracy data |
| ε threshold calibration | Stage 2 conflict resolution | 50 Layer 2 activations | Is Layer 1 calling Layer 2 too often or too rarely? | Adjust ε from 0.05 based on Layer 2 false-positive/negative data |
| Round-cap review | Stage 2 conflict resolution | 25 Layer 3 escalations | Is 3 rounds the right balance? | Adjust from 3 based on escalation pattern data |
| Golden Dataset expansion | Stage 2 ATV | 500 real ATV-processed messages | Expand Golden Dataset from 100 to 300 items | CT curates expansion using confirmed-valid production messages |
| κ empirical calibration | Stage 4+ compression event detector | After 10 test compression events | Is 10% degradation threshold correct? Is fortnight cadence correct? | Adjust from measurements; analytic formula scales proportionally |
| θ_work empirical calibration | Stage 3 | 738 labeled queries | Is θ_work=0.5 provisional value optimal within (0.375, 0.585]? | Calibrate from data; update `skill_injection_threshold` config |
| GoS sparse validation trigger review | Stage 3 | After 90 days of dense validation | What skill count makes sparse validation worth building? | Decide N; build-space placeholder activates |

---

## Outstanding Questions for CT Review at Build Guide Update

These are the items where CT's explicit call is needed before Jiang2 finalizes the Build Guide:

1. **Edge ontology mapping for `contradicts`:** Should `contradicts` pointers have a `conflict_class` sub-attribute distinguishing semantic-tension (informational, bidirectional) from factual-incompatibility (triggers contradiction resolution)? Jiang2 recommends yes. CT has not addressed this.

2. **Canary volume threshold:** What concurrent multi-agent session volume or daily message rate defines "ready for Canary"? This trigger is currently vague. A specific number is needed to avoid a fuzzy deferral.

3. **FW-003 timing:** GDrive service account migration is Stage 0 work. The 7-day OAuth window has already expired twice. Does CT authorize MarcusAurelius to execute this now, or does it wait until Stage 0 is formally opened?

4. **Bootloader cleanup:** Jiang2's recommendation was Option 1 (now, before queues refill). CT has not confirmed this. Queues are currently empty — this is the window.

5. **contradiction_class taxonomy:** The four values (factual / empirical / architectural / taste) are Jiang2's proposal from Re-Eval #1. CT deferred this during the walkthrough as one of the four parked calibration items. Does CT accept these four values now, or modify?

6. **Persona-maker FW-009 trigger:** Jiang2 proposed "500 c-memory neurons + CT initiation." CT's view: "future exploration, not active." Does CT want a formal FW-009 entry with this trigger, or keep it as an informal note only?

---

[VELORIN.EOF]
