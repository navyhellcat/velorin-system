---
file: Velorin.v2.BuildPlanFinalization.PendingItems.md
purpose: Items deferred from the v1 archive execution pass that must be addressed before the final v2 Build Plan is locked. These BLOCK final Build Plan lock.
type: pending-items registry
date: 2026-04-26
from: Jiang
status: ACTIVE — these block v2 Build Plan finalization
---

# Velorin v2 Build Plan — Pending Finalization Items

These items were surfaced during the v1 archive execution pass but require careful review against the v2 Build Plan before disposition. They block the final Build Plan lock.

When the v2 Build Plan finalization pass runs (Jiang2 + Deep Think audit, per FW-013), each item below must be walked and resolved.

---

## Pending Item 1 — GPS.Layer.System.Design.md

**Current location:** `Claude.AI/architecture/GPS.Layer.System.Design.md`

**What it is:** Design doc for a "Global Positioning System" layer — likely a coordination/state-tracking layer that knows where each agent is in workflow and what state each task is in.

**What needs to happen:** Read the doc in full, compare against the current Build Guide files (`Claude.AI/New Build/`). Determine whether the GPS concept's substantive ideas are absorbed in the Build Guide (state tracking via `belief_state`, `authority_tier`, `contradiction_class`, FW registry, session handoffs). If absorbed: archive after extraction. If novel ideas remain (a coordination/orchestration layer not addressed elsewhere), flag for Jiang2 + Deep Think before final Build Plan lock. Don't let architectural novelty get archived by default — that's how systems lose ideas they later have to re-derive at higher cost.

**Why deferred:** The v1 archive execution pass did not have authority to modify Build Guide files (FROZEN per Jiang2's WholeSystemReimagining mandate Hard Constraint 1). Comparison + decision must happen during the v2 finalization pass when Build Guide edits are authorized.

---

## Pending Item 2 — Skill.Registry.Design.md

**Current location:** `Claude.AI/architecture/Skill.Registry.Design.md`

**What it is:** Earlier design for skill catalog, indexing, invocation. Predates the current `skill_dependencies.yaml` 4-type GoS edge schema in the Build Guide.

**What needs to happen:** Read in full, compare against the current Build Guide skills section (in `New Build/05_InfrastructureAndTools.md` and related). Extract anything not in current Build Guide (likely small — most patterns absorbed). Archive original after extraction. The current skills architecture is more mathematically grounded; the older design's main contribution was probably the concept of "skills are first-class" — likely already absorbed.

**Why deferred:** Same as Item 1 — Build Guide is FROZEN; extraction-and-port requires authorized Build Guide edit cycle.

---

## Pending Item 3 — desktop-verification.md

**Current location:** `Claude.AI/tools/desktop-verification.md`

**What it is:** Diagnostic checklist for verifying Claude Desktop / Code Tab environment is working (MCP health, filesystem access, specific tool availability).

**What needs to happen:** Parse the file. Extract foundational environment-confirmation steps into `Claude.AI/STARTUP.md` (which already has an Environment section that can absorb), or into `Claude.AI/ENVIRONMENT_DETECTION.md` if more appropriate. Extract diagnostic-specific steps into either `Claude.AI/STARTUP.md` Troubleshooting section OR a new `Claude.AI/Troubleshooting.md` if substantial enough. Archive original after extraction.

**Why deferred:** STARTUP.md has been edited multiple times in this session; further structural changes risk introducing inconsistency without a focused review pass. Also, the diagnostic content may need updating against the current MCP topology before extraction.

---

## Pending Item 4 — GDrive.Port.Tool.md

**Current location:** `Claude.AI/tools/GDrive.Port.Tool.md`

**What it is:** Documentation of the GDrive porting process — the inbound channel for all external research deliverables from Trey/Erdős. Critical operational reference paired with the velorin-gdrive MCP.

**What needs to happen:** Read in full, confirm currency against the actual MCP API (the trash-permission failure during this session suggests something needs attention). Consider promoting from documentation to executable: a Python port script in `Possibly Useful Scripts/` that wraps the gdrive MCP calls into a single `gdrive-port [filename]` operation, with the .md as reference. Currently every port is a manual sequence of MCP calls; could be one script call with safe defaults.

**Why deferred:** Substantial review work + script-build decision belongs in the v2 finalization pass, not the v1 archive cleanup. Pairs with the MCP trash-permission issue surfaced today.

---

## Pending Item 5 — Research Library Index (BUILD)

**What it is:** Doesn't exist yet. To be built. Single consolidated index for all research docs across `Bot.Erdos/Research_Complete/`, `Bot.Trey/Research_Complete/`, `Bot.Trey/Assessments/`, plus topic and synthesis docs. Per dispositions: navigation table + per-entry metadata (tags, related docs, key findings, status: active / superseded / theoretical).

**What needs to happen:** Three options to evaluate:
- (a) **Static .md file manually maintained** — drifts immediately, minimum viable, ships fastest
- (b) **Auto-generated from per-doc YAML frontmatter** — more reliable, requires standardizing frontmatter across all research docs (most don't have it currently)
- (c) **NotebookLM-backed query layer** — aligns with the stated NotebookLM-as-context-of-record direction; largest build

Pragmatic path: ship (a) as v1 (manual but immediate value) → standardize frontmatter as new research docs arrive → upgrade to (c) when NotebookLM is wired. The .md is the bridge.

**Why deferred:** Substantial build with structural decisions (which option, frontmatter schema, NotebookLM integration timing) that should be made alongside the v2 Build Plan's NotebookLM context layer architecture, not in isolation. Cross-references FW-010 (Deep Think corpus folder) — both depend on a curated-vs-canonical separation.

---

## Pending Item 6 — Gatekeeper Build Guide Update

**What it is:** Per dispositions Action 15, after Gatekeeper retirement, the Build Guide must be updated to reflect Gatekeeper is retired and note what (if anything) replaces its function. (Nothing replaces — the function never produced value the alternatives didn't already provide.)

**What needs to happen:** During the v2 Build Plan finalization pass, find Build Guide references to Gatekeeper (`Claude.AI/New Build/05_InfrastructureAndTools.md` is the likely location — verify) and update them: replace with a note that Gatekeeper was evaluated and retired in the v1→v2 transition; multi-vendor cowork makes per-vendor MCP topology cleaner than a unified pre-MCP registry.

**Why deferred:** Build Guide files are FROZEN per Jiang2's mandate. This edit happens in the authorized v2 finalization pass, not now.

**Operational follow-up (separate from Build Guide):** The `velorin-gatekeeper` MCP server itself lives in `Velorin Code/velorin-gatekeeper/` and needs uninstalling. That falls under FW-011 (Velorin Code/ separate triage pass).

---

---

## Items Surfaced from Jiang2's SynthesisUpdate (2026-04-26)

After receiving Erdős's COMBINED solution to his 5 math gap theories, Jiang2 produced `Jiang2.WholeSystemReimagining.SynthesisUpdate.Apr26.md` and surfaced 11 additional Build-Guide edits required before final lock. They are added below as Items 7-17.

---

## Pending Item 7 — Part 1 / Part 2 Build-Sequence Restructuring

**What it is:** The current Build Guide stages (00-07) do not explicitly reflect the two-part build sequence locked in Jiang2's WholeSystemReimagining synthesis: Part 1 = Velorin without the Brain (multi-vendor Cowork integration); Part 2 = Brain insertion into already-functional integrated system.

**What needs to happen:** Reframe Stage 0-1 explicitly as Part 1 deliverables (vendor routing, Cowork integration, no Brain dependency). Reframe Stages 3-5 as Part 2 (Brain insertion). Update `06_BuildSequence.md` to make the part-boundary visible. Add explicit "Brain not required to function at this point" markers through Part 1 stages.

**Why deferred:** Build Guide is FROZEN per Jiang2's mandate Hard Constraint 1. Restructuring the build sequence is a substantive Build Guide edit that requires the finalization pass.

---

## Pending Item 8 — ARC-1 Virtual Contradiction Graph Spec

**What it is:** New architectural primitive proven by Erdős (Solution 2 in `Erdos.Solution.COMBINED.Apr26.md`). Cross-vendor context conflict is formally equivalent to Brain neuron contradiction under a bipartite source-graph transformation. Each external vendor claim becomes a virtual neuron; logical inconsistency becomes a `contradicts` pointer; the existing Layer 1/2/3 conflict resolution mechanism applies natively.

**What needs to happen:** Add ARC-1 (Virtual Contradiction Graph) as a Stage 1 Part 1 build component. Specify: (a) the asymmetric NLI surrogate that detects mutual exclusion across vendor outputs, (b) the virtual-neuron encoding of vendor claims, (c) the routing of detected contradictions through Layer 1 composite scoring → Layer 2 verification → Layer 3 escalation, (d) the propagation step that overwrites the losing vendor's context window via system prompt injection.

**Why deferred:** New architectural primitive not yet in the Build Guide. Mathematically proven, ready to integrate during finalization pass.

---

## Pending Item 9 — ARC-2 Vendor Routing Program Spec

**What it is:** Vendor routing program proven by Erdős (Solution 1) as a strict, finite instance of the Velorin Epistemic Gating Primitive (VEGP). The vendor routing map is an affine bipartite projection (NOT an endomorphism — the original Multiplex Tensor isomorphism claim is REFUTED). Optimal routing evaluates `Ξ(v_(1), μ, μ_base, θ) = H(μ(v_(1))/μ(v_(2)) - (1+ε_gap))`.

**What needs to happen:** Add ARC-2 (Vendor Routing Program) as a Stage 1 Part 1 build component. Specify: (a) the vendor capability matrix V (rectangular, bipartite — see Pending Item 10 for normalization correction), (b) the task-alignment scoring `μ(v_i) = (V·ω_task)_i`, (c) the VEGP gate evaluation against capability margin ε_gap, (d) fallback logic when Ξ=0 (capability gap topologically ambiguous → ensemble polling).

**Why deferred:** New architectural primitive. Ready to integrate during finalization pass.

---

## Pending Item 10 — Vendor Capability Matrix: Column-Normalization Correction

**What it is:** Erdős's Proof 1A explicitly REFUTED the Multiplex-Tensor isomorphism in Jiang2's original synthesis. Original synthesis assumed V required row-normalization (matching `P_tax`/`P_them` independent row-normalization in the Brain). Erdős proved this is structurally wrong for a rectangular bipartite projection — row-normalizing would enforce a zero-sum capability budget (penalizing a vendor in writing because it's good at coding). V requires **column-normalization** (relative scoring within a single cognitive task) to prevent scalar magnitude distortion.

**What needs to happen:** Find every Build Guide reference that says "row-normalize the vendor capability matrix" or implies it via Multiplex-Tensor analogy. Update to specify column-normalization. Add the explanatory footnote citing `Erdos.Solution.COMBINED.Apr26.md` Proof 1A.

**Why deferred:** Build Guide is FROZEN. Mandatory correction during finalization pass.

---

## Pending Item 11 — Directed NLI Replaces Mutual Information for NotebookLM-Brain Sync

**What it is:** Erdős's Solution 5 REFUTED the use of mutual information `I(c_v; s)` as the consistency criterion for neuron↔source synchronization. Mutual information is symmetric; lossy compression is violently asymmetric. Correct formulation: Conditional Entropy `H(c_v | s) ≤ ε` — the source fully explains the compression. The cheap surrogate is Directed Natural Language Inference: `P(Entails | Premise: source, Hypothesis: neuron)`.

**What needs to happen:** Find every Build Guide reference to mutual information as the NotebookLM-Brain sync consistency check (likely in `02_Architecture.md` or the Brain layer sections). Replace with Conditional Entropy formulation. Specify the directed NLI surrogate as the operational implementation. Distinguish stale (source updates and crosses ε) from superseded (new source logically contradicts neuron, requires overwrite).

**Why deferred:** Build Guide is FROZEN. Mandatory correction during finalization pass.

---

## Pending Item 12 — Broker Pattern for Layer 3 Cross-Vendor Coherence

**What it is:** New architectural primitive from Erdős's Derivation 2B. When Layer 2 verification yields Ξ=0 (composite scores within ε), the conflict is routed to an orthogonal, high-authority vendor (the Broker) for evaluation. If the Broker also returns Ξ=0 (epistemic deadlock), it escapes to the Chairman.

**What needs to happen:** Add the Broker pattern to the Layer 3 conflict resolution mechanism specification (currently in `04_AgentEcosystem.md`). Specify: (a) what makes a vendor a valid Broker (orthogonal to the conflicting vendors, higher authority_tier), (b) Broker selection logic (deterministic from contradiction_class tag + vendor capability matrix), (c) the deadlock-to-Chairman escalation artifact + queue.

**Why deferred:** New primitive. Ready to integrate during finalization pass.

---

## Pending Item 13 — Velorin Startup Manifest

**What it is:** The document specifying exactly what travels from the v1 system to Mac Studio for v2 build initialization. The "Velorin Startup folder" composition that bridges in-progress Velorin into the new fully-integrated system being built around it. Per Jiang2's WholeSystemReimagining mandate Section 11 — proposed but not yet written.

**What needs to happen:** Compose the manifest. Specify: (a) load-bearing state that travels (Bot.Jiang/, Brain region state, Build Guide files, operating rules cleaned of staleness, locked feedback memories, Research_Complete archives), (b) format (git repo / packaged archive / Cowork-readable manifest), (c) sequencing (Build thesis defines target operating model first, then manifest composed against thesis), (d) cleanup-before-travel rules (operating rules carry rewritten versions, not stale verbatim), (e) bridge-vs-destination boundaries (what the startup folder is allowed to do vs not — keep in-progress work alive but not become a parallel architecture competing with new build).

**Why deferred:** Substantial document requiring sequencing decisions and Build Thesis alignment. Best done during finalization pass with full v2 architecture in view.

---

## Pending Item 14 — FW-006 Back-Application Sweep

**What it is:** Forward-reference notes (Standing Order 1) and build-space placeholders (Standing Order 2) need to be back-applied across the entire Build Guide. The candidate map exists in `Jiang2.BuildGuideUpdateSpec.Apr26.md` Section 3 (substantial table with draft text). Held until Decisions 2-10 lock so placeholders reflect final decisions.

**What needs to happen:** Walk the candidate map. Place forward-reference notes inline at each cross-phase coupling site in the Build Guide files. Place build-space placeholders in the appropriate phase for each deferred item. After CT lock on Decisions 2-10, this becomes mechanical placement.

**Why deferred:** Mechanical placement gated on CT lock of Decisions 2-10 (otherwise placeholders may need revision). Build Guide is FROZEN until finalization pass.

---

## Pending Item 15 — Check-Ins Schedule Design (with Provable Data-Driven Calibration — CT STANDING REQUIREMENT)

**What it is:** The full vitality-important Check-Ins list spread across Build Guide phases. Per the locked feedback memory `feedback_checkins_construct.md`, recurring reviews aggregate into the Build-Guide-wide Check-Ins list (not standalone triggers). Candidate entries surfaced in `Jiang2.BuildGuideUpdateSpec.Apr26.md` Section 4. Jiang2 designs and places.

**STANDING REQUIREMENT (CT-locked 2026-04-26 with Decision 4 + EXTENDED with Decision 7):** Every Check-Ins entry must specify, in concrete and buildable form:

**Decision 4 four-element specification** — what each entry contains:
- (a) **Measurement program** — what process collects the data (program name, where it lives, what it observes)
- (b) **Specific data points captured** — exact fields recorded per event, sufficient to reconstruct the calibration question
- (c) **Threshold or criterion that fires recalibration** — measurable, not vague (e.g., "override accuracy drops below 70% across 50 contested cases" — not "if it seems off")
- (d) **Verification path** — how we know recalibration succeeded vs failed; before/after metric comparison protocol

**Decision 7 multi-point distribution extension** — how each measurement is structured across the Build Guide:
- (e) **Target points distributed across multiple Build Guide phases**, NOT a single Check-Ins entry. Each calibration parameter has multiple checkpoint events along the build timeline (e.g., post-50-contradictions review, post-100-contradictions review, quarterly review thereafter), not just one.
- (f) Per target point: a **reminder** that the measurement/calibration needs to be re-run (recurrence, not one-time)
- (g) Per target point: **decision-when-needed** — concrete trigger forcing an answer (event count, date, threshold crossing, or composite)
- (h) Per target point: **timing** — cadence of recurrence
- (i) Per target point: **test specification** — the specific calibration test to run at this point
- (j) Per target point: **logged deliverable for the future** — concrete artifact name + storage location, so it's findable not lost across sessions
- (k) Per target point: **hard date OR target** — either a calendar date or a measurable event-target. Vague "later" or "as needed" FAILS the standing requirement.

This requirement applies to every calibration measurement without exception, including: 4a source multipliers, 4b ε threshold, 4c round-cap, 4d contradiction_class taxonomy + per-path routing accuracy, 7 κ measurement program, **OQ-5 H_E passive-inference measurement (Pending Item 18)**, and every future calibration parameter introduced by Build Guide additions.

**Calibration Deliverables Registry** — the Build Guide finalization pass (FW-013) must produce this as a section within the Check-Ins schedule. Lists every calibration measurement with its full multi-point distribution, deliverable artifacts, and hard dates/targets. One canonical view of all in-flight calibration work, indexed by parameter and by target date.

Vague Check-Ins entries fail the standing rule and must be redesigned with concrete elements (a) through (k) before they can land in the Build Guide.

**What needs to happen:** Take the candidate Check-Ins entries from BuildGuideUpdateSpec Section 4 PLUS the four entries locked from Decision 4 (source multiplier review at 50 contradictions; ε threshold review at 50 Layer 2 activations; round-cap review at 25 Layer 3 escalations; contradiction_class routing accuracy per path) PLUS any others surfaced during finalization. Design the unified schedule with the four-element specification above for each entry. Place in the Build Guide as an explicit Check-Ins section per phase or as a single Build-Guide-wide schedule document.

**Why deferred:** Substantive design work coupled to Build Guide structure. Finalization pass scope.

---

## Pending Item 16a — `contradiction_class` Taxonomy + Sub-Category Routing Architecture (CT-locked 2026-04-26)

**What it is:** Decision 4d locked the `contradiction_class` tag with **five primary values** (`factual / empirical / architectural / taste / operational`) and a CT requirement that every primary value support **hierarchical sub-categories** for routing to separate AI agents, skill libraries, deterministic lookup tables, or external systems at a later time without schema rework.

**What needs to happen:**
1. **Schema specification** — Build Guide neuron YAML schema updated to: `contradiction_class: <primary>.<sub_category>` (e.g., `factual.scientific`, `operational.deployment`, `taste.aesthetic`). Primary value required at neuron creation; sub_category optional initially, populated as the routing taxonomy fills out.
2. **Routing config — separate file** — routing destinations live in a separate config file (e.g., `Claude.AI/conflict_routing.yaml`), NOT hardcoded in Layer 2 code. Maps path-prefixes to destinations. Destinations can be: AI agent (Erdős, Trey, Jiang, future Cowork agents), skill library (deterministic table lookup), external system (specific MCP, NotebookLM corpus query), or queue (Layer 3 / Chairman review).
3. **Initial routing config (Stage 1):**
   - `factual.*` → Erdős
   - `empirical.*` → Trey
   - `architectural.*` → Jiang (analytical review)
   - `taste.*` → Layer 3 directly (no LLM mediation; CT or named reviewer decides)
   - `operational.*` → Jiang (interim) until a dedicated operational agent or skill-library router is wired
4. **Extensibility test** — adding a new sub-category (e.g., `operational.deployment.kubernetes`) must NOT require schema rework. Only routing config addition.
5. **Check-Ins entry — routing accuracy per path** (locked under Pending Item 15 standing requirement): measurement program collects routing outcomes per `<primary>.<sub_category>` path. Captures: routing decision, downstream resolution outcome, agent/skill that produced the resolution, time-to-resolve. Threshold: if routing-accuracy on any path drops below 70% over 50 contested cases, fires recalibration (taxonomy split, routing reconfiguration, or new destination wired). Verification path: before/after accuracy measurement on the same path.

**Why deferred:** Build Guide is FROZEN. Schema + routing config + Check-Ins entry land together during the finalization pass.

---

## Pending Item 16 — Edge Ontology Finalization (`contradicts` Dual-Function Question)

**What it is:** In the edge ontology, `contradicts` currently serves two functions: (a) semantic label (informational, bidirectional, indicating intellectual tension), (b) `belief_state` trigger (fires the conflict resolution mechanism, indicating factual incompatibility). Jiang2's recommendation: add `conflict_class` sub-attribute to `contradicts` pointers — `contradicts {semantic}` vs `contradicts {factual}`. Distinguishes "these concepts are in tension intellectually" from "these neurons are factually incompatible." CT has not confirmed or rejected this.

**What needs to happen:** **Decision needed from CT first.** Then finalize the Pre-Stage 0 Edge Ontology Unification specification in `06_BuildSequence.md`. If CT accepts Jiang2's `conflict_class` proposal: add the sub-attribute schema, update the conflict resolution mechanism to filter on `conflict_class=factual` only. If CT rejects: maintain current dual-function `contradicts` and document the convention explicitly.

**Why deferred:** Blocked on CT decision. Build Guide edit follows.

---

## Pending Item 17 — Approved Retirements Reflected Throughout Build Guide

**What it is:** The v1 archive execution pass (2026-04-26) operationally retired: MarcusAurelius (folder archived), Bot.Theresa (already archived), Bot.Scribe (folder archived), Bot.Gatekeeper (folder archived — see Pending Item 6), the Level 1/2/3/4 agent hierarchy (Bot.Agent.Level2/3/4 folders archived; Level 4 General Rules cardinal sections extracted to STARTUP.md), GLOBAL_SPAWNER_REGISTRY, GLOBAL_TIMER_REGISTRY (Pending FW-012 replacement), Agent Teams / tmux teammate pattern, AppsScript Communication Bus design. The Build Guide files in `New Build/` were written before these retirements happened and may still reference these systems.

**What needs to happen:** Sweep every Build Guide file for references to retired systems. Update language to either remove the references (if the function isn't replaced) or describe the v2 replacement (if there is one — e.g., Cowork replaces Agent Teams; multi-vendor MCP topology replaces Gatekeeper; rolling handoff per bot replaces sub-bot taxonomy). Specifically:
- Replace "MarcusAurelius does X" with neutral role-based phrasing or specific v2 binding
- Replace "Level [1-4] agent" references with "Programs / Program-managers / Operational AI" per `Velorin.Principles.md` Principle 3
- Replace Gatekeeper references with "evaluated and retired in v1→v2 transition; per-vendor MCP topology replaces"
- Replace Agent Teams / tmux references with "Cowork-based multi-vendor coordination"
- Replace Scribe references with the v2 ingestion-pipeline design (whatever replaces Scribe's automated session logging — design TBD or already in the Build Guide under a different name)

**Why deferred:** Build Guide is FROZEN. Mandatory cleanup during finalization pass.

---

---

## Pending Item 18 — OQ-5 H_E Measurement Protocol (CT-locked 2026-04-26)

**What it is:** OQ-5 (the Affective Hamiltonian H_E measurement procedure) was an Open Question in the v2 Build Guide. Trey research returned in Session 028 with the recommendation **Option B — passive inference, never prompted directly** (the system infers H_E from observable signals during normal operation; never asks CT to label H_E directly). CT lock 2026-04-26: **Adopt Option B (the consensus from Trey's Session 028 recommendation) AND apply the full Calibration Deliverables Discipline (elements (a)-(k) from Decision 4 + Decision 7 standing requirement)** — multiple Check-Ins / engineering test moments / re-evaluations distributed throughout the build, not a single Check-Ins entry.

**What needs to happen:** Build Guide finalization pass (FW-013) lands the H_E measurement design with:
- The passive-inference algorithm (never prompts CT directly; infers from observable signals: query patterns, dwell time on neurons, retrieval-then-edit cycles, post-retrieval action sequences, cross-domain reference patterns, neuron creation cadence, etc. — exact signal set defined during finalization based on Trey research recommendations)
- Multiple target points across the Build Guide: initial-calibration checkpoint after first 100 c-memory neurons, follow-up at 500 neurons, full re-evaluation at 1000 neurons, plus any phase-boundary checkpoints introduced by Build Guide stage progression
- Per checkpoint: measurement program / data points captured / threshold or criterion / verification path / reminder / decision-when-needed / timing / test specification / logged deliverable / hard date or target — full element (a)-(k) compliance
- Engineering test moments at each checkpoint: synthetic neuron with known H_E ground truth (CT spot-curates a small validation set), measure inferred H_E vs ground truth, recalibrate if drift exceeds threshold

**Why deferred:** Build Guide is FROZEN until FW-013. Lock recorded here; concrete checkpoint placement happens during finalization pass.

**Cross-references:**
- `Bot.Trey/Research_Complete/Trey.Research.EmotionalMemorySalience.Measurement.md` (the source research for Option B)
- Decision 4 + Decision 7 standing requirement (Calibration Deliverables Discipline)
- New Build/02_Architecture.md (Layer 3 section, where H_E neuron YAML field sits) — note: H_E should NOT be added to neuron YAML schema until measurement procedure is built; until then, H_E is computed-on-demand from observable signals, not stored

---

## Pending Item 19 — Post-Velorin-Startup Bootloader Audit (CT-locked 2026-04-26 with Decision 9 caveat)

**What it is:** A second bootloader audit pass that runs AFTER the full Velorin Startup portion of the v2 build is complete (i.e., after Mac Studio / multi-vendor cowork integration has been built out). Decision 9 (locked 2026-04-26) authorized the immediate audit pass to clean v1 retirement staleness; this Pending Item captures the follow-up pass that cleans whatever new staleness emerges from the v2 build itself.

**What needs to happen:**
1. Identify what's stale in the bootloaders post-Startup. Likely candidates:
   - Vendor references that drifted (GPT 5.x version numbers, Codex product framing, Cowork API specifics, NotebookLM integration patterns) since the v1 audit
   - Agent roster updates (any new Cowork-based agents; any vendor-specific bots wired during Startup)
   - Math inventory updates (any Erdős solutions delivered between now and Startup completion)
   - Retired Velorin v1 references that survived the first cleanup
   - "Open question" status drift (OQs locked or surfaced during Startup build)
   - Decision-status drift (further form decisions locked, plus any new architectural locks)
2. Same scope and methodology as the Decision 9 audit — find pattern, inline-correct, verify, commit
3. Preserve evidence of the CHANGE between v1-cleaned bootloaders and v2-cleaned bootloaders for the Calibration Deliverables Registry (this is itself a calibration-of-bootloaders measurement)

**Trigger to revisit:** When the v2 Velorin Startup portion of the build is signaled complete by CT. Concrete trigger: CT writes "Velorin Startup complete" or initiates the first post-Startup operational session.

**Why deferred:** Cannot execute before the Startup build that creates the new staleness has happened. The audit is for staleness emerging from work not yet done.

**Cross-references:**
- Decision 9 lock in `Jiang.RespondingToReEvaluations.md`
- `feedback_audit_external_agent_context.md` (the per-request audit discipline)
- FW-013 (v2 Build Plan finalization pass)
- The Calibration Deliverables Registry (this audit's deliverable lands there)

**Assigned to:** Jiang (audit execution) + CT (trigger signal + final approval of corrected bootloaders)

---

---

## Pending Item 20 — OQ-9 Intake Test (CT-locked 2026-04-26: Deferred to Phase 4 Last Standing Item)

**What it is:** OQ-9 (Intake Test Design) had been blocked since Session 013 — originally scoped as a deliverable that generates the Brain's first 50-100 c-memory neurons (the boot state). Jiang2's WholeSystemReimagining synthesis identified it as a Part 1 deliverable. CT lock 2026-04-26: **Remove from current outstanding decision list. Place as Phase 4 last standing item in the Build Guide.** Rationale: not needed for the v2 architecture as it's been reframed; it becomes the final tidying-up step at the end of the Build, not a gating Part 1 / Part 2 component.

**What needs to happen:** Build Guide finalization pass (FW-013) places OQ-9 explicitly as the **last item in Phase 4**. Specifically:
- Remove OQ-9 from the active "Open Questions" list in `New Build/07_OpenQuestions.md`
- Add OQ-9 as a Phase 4 final-step entry in `New Build/06_BuildSequence.md` — explicit position: last build item before Build complete
- Note: the c-memory neurons that the intake test was originally designed to generate will accumulate organically through normal CT-Brain interaction during Phases 1-3; the formalized intake test is no longer the boot mechanism, just a final-stage validation/tidying step

**Why deferred:** Build Guide is FROZEN until FW-013. Repositioning OQ-9 happens during the finalization pass, not now.

---

## Updated Sequencing Recommendation

**Decisions that must land FIRST (CT calls):**
- Decisions 2-10 from the Re-Eval form (lock the architecture before edits begin)
- Item 16 (`contradicts` dual-function — `conflict_class` sub-attribute or not)
- Intake test authorization (OQ-9, blocked since Session 013 — first Brain neurons depend on it)
- H_E measurement protocol (OQ-5, Trey research returned, decision pending)

**Build Guide edits that happen as one finalization pass (after decisions land):**
- Items 7, 8, 9, 10, 11, 12, 14, 15, 16, 17 — all touch Build Guide files
- Items 1, 2, 6 — also Build Guide coupled, handle in same pass
- Item 13 (Velorin Startup Manifest) — write during this pass

**Items handled separately:**
- Item 3 (desktop-verification.md) — STARTUP.md-coupled, separate review
- Item 4 (GDrive.Port.Tool) — operational tool maintenance
- Item 5 (Research Library Index) — large independent build, sequenced with NotebookLM integration

**Dependencies:**
- Items 8, 9, 10, 11, 12 are Erdős-proven and ready to integrate — minimal additional design needed
- Items 7, 13, 17 are Jiang2-architectural and require synthesis judgment
- Items 14, 15 are mechanical placement once their inputs land

[VELORIN.EOF]
