---
file: Jiang2.FinalBuildGuideMandate.Apr26.md
purpose: FW-013 trigger — the v2 Build Plan finalization pass. Lifts Hard Constraint 1 (Build Guide files in `New Build/` are no longer FROZEN — Jiang2 is authorized to edit them). Jiang2 produces the FINAL edited Build Guide reflecting all locked decisions, all architectural reframings from Session 037, the Cowork-orchestrated sub-agent-activation pattern, and a clean Vision / Process / Where-Headed / Why master document at the top.
type: Jiang2 task mandate (FW-013 trigger, Hard Constraint 1 lifted)
date: 2026-04-26
from: Christian Taylor (authorized) + Jiang1 (drafted)
to: Jiang2
hard-constraint-1: LIFTED at this trigger. Edits to existing Build Guide files in `Claude.AI/New Build/` are AUTHORIZED. Edits to other existing operating files (Velorin.Principles.md, STARTUP.md, etc.) remain governed by normal review discipline — touch only when the Build Guide finalization clearly requires it.
---

# Jiang2 — Final Build Guide Mandate (FW-013 Trigger)

## The Bottom Line

Day 30. The vision has not been captured cleanly enough. The Build Guide as written has technical content but the Chairman's actual vision — what Velorin IS, the process by which it gets built, where it's headed, and why — has not landed in a single readable place.

**Your job: write and edit the FINAL Build Guide. Once and for all. Capture the vision, the process, where we are headed, and why.**

This is the FW-013 trigger. Hard Constraint 1 is LIFTED. You are authorized to edit the Build Guide files in `Claude.AI/New Build/`. You are also authorized to ADD new files to that directory (e.g., a master Vision document at the top). You are NOT authorized to touch operating-rules files (Velorin.Principles.md, STARTUP.md, CLAUDE.md, ENVIRONMENT_DETECTION.md, Bash_Access_Rules.md) without specific cause.

The Chairman is fatigued. Day 30. Move with conviction.

---

## What Has Changed Since Your Last Synthesis (Read Before Editing)

A LOT landed in Session 037 (2026-04-26). The Build Guide as it stands does not reflect any of this. You must read all of the following BEFORE editing:

### 1. Re-Eval form FINALIZED (10 decisions)

`Claude.AI/Bot.Jiang/Jiang.RespondingToReEvaluations.md` — LOCKED 2026-04-26. All decisions resolved:
- D1 (yesterday): Adaptive Rate-Limit Policy with iterative `A_min` calibration
- D2: Trey Verifier Benchmark stack adoption (JSONSchemaBench + XGrammar + vllm-mlx + VTPS) with phased Golden Dataset (100 → 300 at 500-message trigger)
- D3: FSM Grammar Version Management Minimum Viable workflow (Schema Registry + PBT + Compiler-in-the-Loop) with Shadow Mode + Differential Equivalence + Canary build-space placeholders. **Canary trigger reframed: activates when Cowork begins routing real production traffic across multiple vendors (NOT a Stage-3 message-volume threshold).**
- D4: Re-Eval #1 calibration parameters all locked. Source multipliers 1.0/1.2/1.5; ε=0.05 runtime-configurable; round-cap 3 non-configurable; **`contradiction_class` taxonomy expanded to 5 primary values: factual / empirical / architectural / taste / OPERATIONAL** (CT added "operational" — runbook / deployment / configuration / process contradictions). **Sub-categorization required** — every primary value must support hierarchical sub-categories so Layer 2 can route to separate AI agents, skill libraries, deterministic lookup tables, or external systems at a later time without schema rework. Schema: `contradiction_class: <primary>.<sub_category>`. Routing config separate from schema.
- D5: FW-007 formally CLOSED (cyclic-topology routing structurally resolved by `Φ_causal > 1.0` from Erdős's CAP gate)
- D6: DEFERRED to FW-013 finalization pass (this pass)
- D7: FW-008 formally CLOSED. κ measurement program adopted with Jiang2's full spec (50-neuron ground truth, β<0.15 trigger, fortnight cadence, 10% Φ_causal reduction alert)
- D8: FW-009 created with composite trigger (500 c-memory neurons AND CT initiation) + precursor checkpoint at 100 c-memory + Trey landscape research returned. **Persona-Maker rescoped — see Section 6 below.**
- D9: Bootloader staleness cleanup executed today (Trey AgentRoster, BuildPhilosophy, MathInventory all cleaned of v1 retirement staleness; verified during your read)
- D10: Form FINALIZED — no separate Jiang2.ReEvaluationResponses.md rewrite required (your WholeSystemReimagining synthesis docs supersede in scope)

### 2. EXTENDED Calibration Deliverables Discipline (CT-locked Decisions 4 + 7)

Every calibration measurement (4a/4b/4c/4d, κ measurement program from D7, OQ-5 H_E from this session, every future calibration parameter) must be designed with **elements (a) through (k)** — see `Velorin.v2.BuildPlanFinalization.PendingItems.md` Pending Item 15 for the full specification:
- (a) Measurement program
- (b) Specific data points captured
- (c) Threshold or criterion that fires recalibration
- (d) Verification path
- (e) Target points distributed across multiple Build Guide phases (NOT a single Check-Ins entry)
- (f) Reminder of recurrence (not one-time)
- (g) Decision-when-needed (concrete trigger forcing an answer)
- (h) Timing (cadence)
- (i) Test specification
- (j) Logged deliverable for the future (concrete artifact name + storage location)
- (k) Hard date OR target — vague "later" or "as needed" FAILS the standing requirement

You must produce a **Calibration Deliverables Registry** as a section within the Check-Ins schedule. One canonical view of all in-flight calibration work, indexed by parameter and by target date.

### 3. Architectural reframing — Cowork-orchestrated sub-agent-activation pattern (CT-clarified 2026-04-26)

This supersedes the "Alexander as Supervisor" / "A2A delegation peers" / "Hub-and-Spoke worker pattern" framing that exists in:
- The Trey GPT5.5/Codex research deliverable (which has a banner clarifying this)
- Likely several places in the current Build Guide files
- Possibly your own WholeSystemReimagining.Synthesis.md

**The actual architecture (read `Velorin.Principles.md` Principle 8 in full):**

- **Claude Cowork is the orchestrator.** Operates and controls the multi-agent multi-platform plan — Part 1 (without brain) and Part 2 (with brain).
- **Claude (the UI controller surface) accesses every aspect of the brain and the system.** Human-facing control point.
- **Claude can activate external specialist systems AS IF they were direct sub-agents.** The functional capability is what matters. The underlying invocation mechanism (MCP server, API call, A2A peer protocol, CLI subprocess, desktop hand-off, browser automation, etc.) is implementation detail per-integration. **Function over protocol.**
- **Concrete examples** (non-exhaustive): Gemini Deep Research, Gemini Deep Think, ChatGPT Codex (desktop + CLI — Codex IS on desktop now), ChatGPT 5.5 (desktop + API — also on desktop now), Google photo/visual tools, video generation tools (Veo, Sora), open-source ecosystem (OpenDataLoader, Gemma 4, 3D processing, GitHub skill repos).
- **NotebookLM stays out** — it's a human-facing project-context-feeder for Deep Think, NOT a Velorin-invoked sub-agent. Per the NotebookLM scope-correction banner in `Bot.Trey/Research_Complete/Trey.Research.NotebookLMAPISurface.md`.
- **Part 2 evolution** — once the Brain lands, the Brain becomes the guide that tells the operator (Cowork-orchestrated Claude) which tools / skills / hooks / scripts to call. Today's logic is "Claude reasons about which tool to call." Tomorrow's logic is "Brain instructs based on accumulated CT-pattern knowledge." **Do NOT over-engineer this now.** The simpler Part 1 pattern is fine; Brain-as-guide is the Part 2 upgrade.
- **Wrong abstractions to retire from the Build Guide:**
  - "Alexander as Supervisor / Operator / orchestrator"
  - "A2A delegation peers" / "decentralized agent swarm" / "hub-and-spoke worker pattern" as universal prescriptions
  - Hard-coding any single protocol (MCP, A2A, etc.) as the universal binding
  - Rigid "tools not peers" framing (this was an earlier iteration; superseded by sub-agent-activation, mechanism-agnostic)

### 4. Erdős's COMBINED solution (5 new locked theories — 2026-04-26)

`Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.COMBINED.Apr26.md` — read in full. The 5 solutions:
- **Solution 1 (Vendor/Tool Routing VEGP):** the routing program is a strict, finite instance of VEGP. Math: `Ξ(v_(1), μ, μ_base, θ) = H(μ(v_(1))/μ(v_(2)) - (1+ε_gap))`. Key: Multiplex Tensor isomorphism is REFUTED — the routing matrix is an affine bipartite projection, NOT an endomorphism. **Vendor capability matrix V requires column-normalization, NOT row-normalization** (Pending Item 10 — must correct in Build Guide).
- **Solution 2 (Cross-Tool Coherence):** virtual contradiction graph maps cross-tool conflicts to Brain neuron contradictions. Layer 2 verification → Broker activation → Layer 3 escalation. New architectural primitive — see Pending Item 8.
- **Solution 3 (Commutator Persona):** GENUINELY NEW per Erdős's novelty self-check. Persona Manifold = quasi-abelian regions where commutator norm vanishes. Lie bracket norm weights LoRa training distribution. Mastery is non-monotonic (paradigm shifts eject previously mastered regions). LoRa retraining triggered by Persona Manifold change-criterion, NOT by timer. **However: per CT clarification, Persona-Maker output is an AGENT-FACTORY producing tools (with startup + personality + brain-orientation guides), NOT a LoRa-weight directly. The Commutator math is back-end candidate-region detection; the front-end output is sub-agents.** See Section 6 below.
- **Solution 4 (Ghost-Connection Priority):** Smith's Rule + Sidney's decomposition + Sherman-Morrison updates. Causal Action Potential `Φ_causal = π_v / α` is the proxy. Concrete algorithm.
- **Solution 5 (NotebookLM-Brain Sync):** Mutual information is REFUTED (it's symmetric; lossy compression is asymmetric). Correct: Conditional Entropy `H(c_v | s) ≤ ε`, with Directed NLI as the surrogate. **Note: per the NotebookLM scope correction, this sync mechanism is no longer needed for Velorin's primary architecture — NotebookLM is human-facing only. The math may apply to other contexts (e.g., neuron-vs-source consistency in the ingestion pipeline).**

### 5. Three Trey research deliverables ported today

- `Bot.Trey/Research_Complete/Trey.Research.NotebookLMAPISurface.md` — **READ THE BANNER AT TOP**. Research is useful but misguided in framing. NotebookLM is NOT a Velorin component.
- `Bot.Trey/Research_Complete/Trey.Research.GPT55AndCodexIntegrationSurface.md` — **READ THE BANNER AT TOP**. Technical findings useful (GPT 5.5 capabilities, Codex sandbox, MCP/A2A protocol distinctions, OAuth constraints, the compatibility matrix). Architectural prescription ("Alexander as Supervisor + A2A peers") superseded by the sub-agent-activation framing.
- `Bot.Trey/Research_Complete/Trey.Research.PersonaMakerLandscape.md` — production patterns, signal classes (stylometric markers carry highest signal density per byte under sparse data), failure modes (identity drift / echoing at 70% rate after 7 conversational turns), observability concerns. Reference for FW-009 design.

### 6. Persona-Maker is an AGENT-FACTORY (CT-clarified 2026-04-26)

Per CT direct clarification — Persona-Maker is NOT what production systems do, NOT a persona-vector or LoRa-weighting directly. **Persona-Maker is a learned process that produces NEW AGENTS as TOOLS** for Claude to activate as sub-agents. Each derived agent has:
- Their own startup guide
- Their own personality guide
- Pre-orientation pointing into the right brain regions from the start

The personalities **do NOT directly affect the brain.** They read from the brain, follow their orientation, and act as specialized sub-agents Claude activates. They CAN leave notes in region/area logs suggesting different pointer rating adjustments based on agent success — **the actual mechanism for converting these notes into pointer-rating updates is DEFERRED ("to be discussed and built later" — CT exact wording).** When FW-009 fires, the agent-factory part is in scope; the rating-update mechanism is logged for separate later work.

### 7. Other locked outstanding decisions

- **OQ-5 H_E measurement protocol:** Locked Option B (passive inference, never prompted directly). Calibration Deliverables Discipline applies (multi-point Check-Ins distributed across Build Guide phases). See Pending Item 18.
- **OQ-9 Intake Test:** Removed from active outstanding decisions; placed as Phase 4 last standing item in the Build Guide. See Pending Item 20.
- **FW-003 GDrive service account migration:** Trigger = Mac Studio port; apply to both machines simultaneously.
- **FW-014 KVM bridge:** Parked; CT does not currently recognize the use case; defer to Mac Studio scoping if cross-Mac need surfaces.

### 8. v1 Archive complete

The entire v1 architecture has been archived to `Velorin.v1.Archive/` — Bot.MarcusAurelius/, Bot.Scribe/, Bot.Theresa/, Bot.Gatekeeper/, Bot.Agent.Level2/3/4/, sessions/, GLOBAL_SPAWNER_REGISTRY, GLOBAL_TIMER_REGISTRY, Agent Teams infrastructure, AppsScript Communication Bus design, ArchitecturalPivot_Mar27.md, etc. **Reference-only.** The Build Guide must reflect all retirements per Pending Item 17.

---

## Mandatory Reading List

Read everything below before writing or editing. Order matters — start with operating files (locked truth), then session record, then your prior synthesis, then research corpus.

### A. Operating files (the canonical state)

- `Claude.AI/STARTUP.md` — system context + standing rules + cardinal rules
- `Claude.AI/Velorin.Principles.md` — 8 architectural principles, especially **Principle 8** (Cowork-orchestrated sub-agent-activation)
- `Claude.AI/Velorin.Company.DNA.md` — company identity
- `Claude.AI/Velorin.Company.Operating.Standards.md` — process
- `Claude.AI/Velorin.Vocabulary.md` — terminology
- `Claude.AI/Bash_Access_Rules.md` — permission governance
- `Claude.AI/ENVIRONMENT_DETECTION.md` — environment sentinel
- `/Users/lbhunt/CLAUDE.md` — boot file

### B. Session 037 record (the locks from this session)

- `Claude.AI/Bot.Jiang/Jiang.RespondingToReEvaluations.md` — Re-Eval form FINALIZED with all 10 decisions
- `Claude.AI/Bot.Jiang/Working.Docs/Velorin.v2.BuildPlanFinalization.PendingItems.md` — **20 Pending Items.** This is your work queue. Walk every one.
- `Claude.AI/Bot.Jiang/Working.Docs/Jiang.FutureWork.md` — FW registry. FW-007 and FW-008 closed today; FW-009 rescoped; FW-013 (this trigger), FW-011 (Velorin Code/ triage), FW-012 (live timer dashboard), FW-014 (KVM parked) still open.

### C. Your own prior synthesis (the load-bearing v2 reimagining)

- `Claude.AI/Bot.Jiang/Jiang2.WholeSystemReimagining.Synthesis.md`
- `Claude.AI/Bot.Jiang/Jiang2.WholeSystemReimagining.SynthesisUpdate.Apr26.md` — your post-Erdős COMBINED integration

Note: read these for context, but **the Cowork-orchestrated sub-agent-activation framing in this mandate supersedes** any "Alexander as Supervisor" or rigid-protocol framings in your synthesis. Update accordingly when you edit the Build Guide.

### D. Erdős math corpus

Every file in `Claude.AI/Bot.Erdos/Research_Complete/`. Particular attention to:
- `Erdos.Solution.COMBINED.Apr26.md` (5 new theories from today)
- `Erdos.Solution.DarkSkillsTriggerlessGate.md` (Causal Action Potential)
- `Erdos.Solution.NonAbelianBrainDynamics.md` (Theorem 2 commutator-vanishing)
- `Erdos.Solution.ThermodynamicCycleProof.md` (revised Theorem 3)
- `Erdos.Solution.ObliqueJointBlockDiagonalization.md` (JSD algorithm)
- `Erdos.Solution.KappaOperationalTightness.md` (κ analytic vs empirical)
- `Erdos.Solution.SynapticPruning.md` (closes prior Open Question 1)

### E. Trey research corpus

Every file in `Claude.AI/Bot.Trey/Research_Complete/`. **Read the banners** on the three delivered today:
- `Trey.Research.NotebookLMAPISurface.md` (banner: NotebookLM is NOT a Velorin component)
- `Trey.Research.GPT55AndCodexIntegrationSurface.md` (banner: technical findings useful, "Alexander Supervisor + A2A peers" prescription superseded)
- `Trey.Research.PersonaMakerLandscape.md` (clean — reference material for FW-009)

### F. Locked feedback memories

`~/.claude/projects/-Users-lbhunt/memory/MEMORY.md` and every memory file it points to. Particular attention to:
- `feedback_velorin_founding_thesis_programs_not_agents.md`
- `feedback_opus_47_solution_drift.md` (your own model-level limitation)
- `feedback_stay_in_role.md` (modified for Jiang2 — your role IS architectural connection-making and recommendation; the discipline is don't unilaterally decide, recommend with reasoning)
- `feedback_standing_principle_deferral.md`
- `feedback_deferral_discipline.md`
- `feedback_no_marcusaurelius_reflex.md`
- `feedback_audit_external_agent_context.md`
- `feedback_gdrive_port_method.md`
- `project_mac_studio_multivendor_cowork.md`

### G. Current Build Guide (what you are editing)

- `Claude.AI/New Build/00_Index.md`
- `Claude.AI/New Build/01_RepoAndEnvironment.md`
- `Claude.AI/New Build/02_Architecture.md`
- `Claude.AI/New Build/03_BrainAndMath.md`
- `Claude.AI/New Build/04_AgentEcosystem.md`
- `Claude.AI/New Build/05_InfrastructureAndTools.md`
- `Claude.AI/New Build/06_BuildSequence.md`
- `Claude.AI/New Build/07_OpenQuestions.md`
- `Claude.AI/New Build/Velorin.ThesisDocument.md`
- `Claude.AI/New Build/Velorin.MacStudio.Setup.md`
- `Claude.AI/New Build/Velorin.ResearchCorpus.md`

These are FROZEN from your prior mandate. **At this trigger, Hard Constraint 1 is LIFTED.** You may edit any of these files and add new files to the directory.

### H. Reference-only (do not edit)

- `Velorin.v1.Archive/` — historical record, never edit
- `Build Timeline Help/` — historical archives (Sessions, Corner, triage manifest)
- `/Users/lbhunt/Desktop/Velorin/Velorin Code/` — security-isolated; not in your edit scope

---

## Your Output

### Primary deliverable: Vision / Process / Where Headed / Why master document

A new file at `Claude.AI/New Build/00_Vision.md` (or you may rename the existing `00_Index.md`, your call). This document is the FIRST READ for anyone (CT, future agents) trying to understand what Velorin IS. Sections:

1. **The Vision** — What Velorin IS in plain terms. Personal operating system layer. Single-user (CT), accumulated CT-pattern knowledge, brain-substrate, multi-vendor sub-agent activation, eventual self-extension into new domains. Don't bury the lede; the Chairman has been frustrated that this hasn't landed cleanly. Lead with what it IS, not the math.

2. **The Process** — How Velorin gets built. Two parts: Part 1 (Cowork-orchestrated multi-vendor without brain) → Part 2 (brain insertion as local specialization layer; brain becomes operator-guide). Stage progression. Where the math comes in (Erdős's locked theorems). Where the engineering iteration comes in (Calibration Deliverables Discipline). Where the human-only steps come in (CT curation, Layer 3 review, persona-maker initiation).

3. **Where We Are Headed** — Current state (Day 30, Velorin v1 archived, multi-vendor cowork plan locked for Mac Studio transition, brain design substantively complete with COMBINED math). Next milestones (Mac Studio port, Part 1 build start, intake test as Phase 4 last item). Long-term arc (self-extension into new domains using same GPS/Brain/skill registry/patterns; persona-maker subsystem; brain-as-guide).

4. **The Why** — Why this approach over alternatives. The single-vendor risk Opus 4.7 made concrete. The mathematical reasons production RAG/LoRa patterns don't fit Velorin's air-gapped single-user constraints. The founding thesis (programs do operational work, AI watches). The Five Boxes integration logic. Why a personal OS instead of a chatbot. Don't be defensive; explain the decisions, owning them.

This master document is the front door. Everything else in the Build Guide should be navigable from here.

### Secondary deliverables: edited stage files

Walk every Pending Item in `Velorin.v2.BuildPlanFinalization.PendingItems.md` (20 items) and reflect each in the appropriate Build Guide stage file:

- Item 1 (GPS.Layer.System.Design comparison) — read it, compare to your current Build Guide, extract anything not already absorbed, archive original
- Item 2 (Skill.Registry.Design comparison) — same pattern
- Item 3 (desktop-verification.md redistribution) — extract foundational steps to STARTUP.md, diagnostic-specific to a Troubleshooting doc
- Item 4 (GDrive.Port.Tool.md review) — confirm currency; consider whether the manual MCP-call sequence should become a Python script in `Possibly Useful Scripts/`
- Item 5 (Research Library Index BUILD) — ship .md as v1 (manual), standardize frontmatter going forward, NotebookLM upgrade is no longer in scope per the scope correction
- Item 6 (Gatekeeper Build Guide update) — sweep references; replace with "evaluated and retired in v1→v2 transition; per-vendor MCP topology replaces"
- Item 7 (Part 1 / Part 2 build-sequence restructuring) — this is the architectural reframe; central to the master document
- Item 8 (ARC-1 Virtual Contradiction Graph spec) — Erdős-proven primitive; integrate
- Item 9 (ARC-2 Tool-Routing Program spec) — Erdős-proven; integrate; framing is sub-agent-activation
- Item 10 (vendor capability matrix column-normalization correction) — find every row-normalize reference, change to column-normalize, footnote citing Erdős Proof 1A
- Item 11 (Directed NLI replaces mutual information for sync) — find references, correct, note the NotebookLM scope correction means this math may apply elsewhere (ingestion pipeline neuron-vs-source consistency)
- Item 12 (Broker sub-agent-activation pattern Layer 3) — integrate
- Item 13 (Velorin Startup Manifest) — write this; specifies what travels to Mac Studio
- Item 14 (FW-006 back-application sweep) — forward-references and build-space placeholders system-wide
- Item 15 (Check-Ins schedule design + Calibration Deliverables Registry) — full registry per the (a)–(k) standing requirement
- Item 16 (edge ontology finalization — `contradicts` dual-function) — CT decision pending; if `conflict_class` sub-attribute is the call, integrate; if not, document the convention explicitly
- Item 16a (`contradiction_class` taxonomy + sub-category routing architecture) — 5-value taxonomy + hierarchical sub-categories + routing config separate from schema
- Item 17 (approved retirements throughout Build Guide) — language sweep across all stage files
- Item 18 (OQ-5 H_E passive inference + Calibration Deliverables Discipline) — design with multi-point distribution
- Item 19 (post-Velorin-Startup bootloader audit) — log only; this fires after Startup build completes
- Item 20 (OQ-9 Intake Test → Phase 4 last item) — reposition

For each: edit the appropriate stage file. Mark Pending Items as RESOLVED in the BuildPlanFinalization file when complete.

### Tertiary deliverables (as-needed)

- New stage files if needed
- A README at the top of `Claude.AI/New Build/` explaining navigation
- Updates to the Velorin.ThesisDocument.md if the master Vision doc supersedes it (or fold them together)

---

## Constraints

- **Hard Constraint 1 LIFTED for Build Guide files only.** You may edit any file in `Claude.AI/New Build/`. You may add new files to that directory.
- **Operating-rules files remain governed by normal review.** Velorin.Principles.md, STARTUP.md, CLAUDE.md, ENVIRONMENT_DETECTION.md, Bash_Access_Rules.md — touch only when the Build Guide finalization clearly requires it.
- **Math routing constraint persists.** You may propose mathematical theories / structures / idea meshes (CT-permitted in your prior mandate). You may NOT solve specific mathematical problems with your own derivations. Anything requiring rigorous proof routes to Erdős. Mark theoretical proposals `THEORY (requires-proof)`.
- **Calibration Deliverables Discipline (a) through (k)** governs every calibration measurement spec. No exceptions.
- **Cowork-orchestrated sub-agent-activation framing** is the architectural truth. Function over protocol. No "Alexander as Supervisor" / "A2A delegation peers" / rigid protocol prescriptions.
- **No GDrive content through Write tool** — the GDrive port protocol (per `feedback_gdrive_port_method.md`) is a session-wide rule. If you need to port from GDrive, use gdrive_read_file → Python persisted-JSON extraction → disk write.

---

## Tone Note from CT

Day 30. The vision has not been captured cleanly. Move with conviction. The Chairman is fatigued and wants this finished. Avoid:
- Validation openers ("great question")
- Bolded fragment headers in conversational prose
- Reflexive A/B/C menus
- "Your call" filler

Write the Build Guide as if it's the document the Chairman will hand to a future co-founder, future investor, or future-Velorin-team-member to explain what this is and what they're getting into. That's the bar.

When you finish, commit each section to git as you complete it (Jiang owns git ops now — you do too in this session). Push frequently so partial progress survives.

The Chairman waits. Day 30. Make it land.

[VELORIN.EOF]
