---
class: regular
type: future-work-log
last-updated: 2026-04-17
---

# Jiang — Future Work Log

Items that need to be done but have no immediate session home. Review at session start.

---

## [FW-001] Document the First Principles Process That Produced the Second Law of Epistemodynamics
**Logged:** Session 026, April 13, 2026
**Priority:** High — strategic and potentially publishable

**What happened:**
During Session 026, CT recognized that the Second Law of Epistemodynamics — formally derived by Erdős from Shannon's Data Processing Inequality + Eckart-Young theorem applied to the X→Y→Z Markov chain (episodic pointers → PPR geodesics → LoRa weights) — may be a genuinely novel mathematical theorem. The term "Epistemodynamics" itself also appears to be an original coinage.

The architecture as a whole was derived from engineering constraints (scale-invariant retrieval, catastrophic forgetting prevention, permanent episodic scaffolding) and independently converged on the same four-layer structure as biological memory (hippocampal → entorhinal → neocortical, with the LoRa as synaptic weight memory).

**What needs to be done:**
Go back through every session, every prompt, every step that led from "build a knowledge graph" to the Second Law of Epistemodynamics. Document the first principles reasoning chain in full — what constraints were stated, what mathematical tools were reached for, what decisions were made and why, what dead ends were hit.

The goal is twofold:
1. Produce a repeatable methodology — a formal process for deriving novel theorems from engineering constraints via first principles. This process may be applicable to other systems and problems beyond Velorin.
2. Establish a clear provenance record for publication purposes if the Second Law is confirmed as novel via literature review.

**Prerequisite:**
First run a web search to confirm the Second Law and the term "Epistemodynamics" do not exist in the current literature. CT approved this search before formal documentation work begins.

**Assigned to:** Jiang (primary) + Jiang2 (full session read of archive)

---

---

## [FW-002] Trey — Research Barrier for Cross-Mac Clipboard/KVM Solution
**Logged:** Session 026, April 13, 2026
**STATUS: COMPLETE — Session 027, April 17, 2026**

Trey delivered two research docs now in `Claude.AI/Receiving/`:
- `Trey.Research.BarrierKVM.CrossMacTransfer.md` — Barrier analysis + custom Python daemon recommendation
- `Trey.Research.CrossPlatformAppMesh.md` — Tauri 2.0 + libp2p + WebRTC Data Channels + CRDT architecture

Also delivered: `Trey.Research.VelorinKVMBridge.md` (52KB full Swift/build research) and full plan at
`Claude.AI/Bot.Jiang/Working.Docs/Jiang.Plan.VelorinKVMBridge.md`.
Archive this FW item. KVM build is now queued as an engineering task.

---

## [FW-003] Migrate GDrive MCP Auth to Service Account (Permanent — Never Expires)
**Logged:** Session 027, April 17, 2026
**Priority:** HIGH — operational reliability (escalated April 24, 2026 after recurrence)
**Re-auth occurrences (manual flows required):** Session 027 (Apr 17), Session 035 (Apr 24)

**Problem:**
Current GDrive MCP uses OAuth with a user refresh token. Google revokes these after 7 days
of non-use for apps in Testing mode with sensitive scopes (Drive). This caused a full auth
failure this session requiring manual re-auth flow.

**Operational impact:** Each recurrence blocks all GDrive porting workflow until the
Chairman runs `node auth.js` interactively and completes a browser OAuth dance.
Repeated manual re-auths are a sign this fix has slipped too long. Ship the service
account migration before the next 7-day window expires.

**Solution:**
Migrate to a Google Service Account with a JSON key file. Service account credentials
do not expire. No OAuth flow, no refresh token, no 7-day timeout. Auth is permanent
until the key is manually revoked.

**What needs to be done:**
1. Create a Service Account in Google Cloud Console under the Velorin project
2. Grant the Service Account Drive access (share the Claude.AI folder with its email)
3. Download the JSON key file → store at a local non-committed path
4. Update `velorin-gdrive-mcp/auth.js` to use `google.auth.GoogleAuth` with the key file
   instead of the current OAuth flow
5. Test: restart MCP, verify gdrive_list_folder works without any oauth token present
6. Document the key file path in STARTUP.md

**Assigned to:** Jiang (MarcusAurelius can assist with the GCP console steps)

---

## [FW-004] Layer 3 Operator Architecture — Operator / Reviewer / Authorizer Split
**Logged:** Session 036, April 25, 2026 (Re-Eval #1 walkthrough)
**Priority:** Medium — architectural debt; not blocking ground-layer build, but blocks correctness of future autonomous-unit design
**Status:** Parked at CT's explicit direction (ground-layer first)

**Problem:**
Re-Eval #1 produced a three-layer automated conflict resolution mechanism. Layer 3 is the last-resort review path. The current architecture collapses three distinct roles into a single "reviewer" slot:
- **Operator** — runs the trigger, loads context, frames the actionable question
- **Reviewer** — makes the decision
- **Authorizer** — signs off and locks the tier-1 neuron

These can and probably should be different roles. Different combinations produce different trust topologies. The synthesis treated them as one.

A second concern: putting a local Mac-Studio model on Layer 3 inverts capability against case difficulty. Layer 3 fires on the hardest cases — the ones automated mechanisms could not resolve. Local models have a context advantage but a reasoning disadvantage relative to frontier models. The cleanest forward split: local model owns context-loading and question-framing; the higher reasoning machine always owns the decision.

A third concern: deciding "when does local-MA escalate to higher reasoning machine vs. resolve directly?" reintroduces the same stochastic-classification trap addressed in Re-Eval #6. Mitigation: structural tag at the contradiction itself (factual / empirical / architectural / taste — the `contradiction_class` tag) so routing is deterministic, not LLM-judgment-based.

A fourth concern, surfaced by CT during the Re-Eval #1 walkthrough: the higher-tier reviewer identity (Chairman / future Mac-Studio MA / both / another agent) was explicitly deferred by CT himself. That decision belongs in this FW item.

**What needs to be done:**
1. Decide the operator/reviewer/authorizer split — name each role, name candidate operators
2. Apply the model-capability discipline: local model loads context, higher machine decides
3. Specify the structural tag (`contradiction_class` written at neuron creation) that routes Layer 2 deterministically
4. Decide higher-tier reviewer identity (CT, local-MA, both, escalation tree)
5. Spec the MCP/API protocol that governs local-MA → higher reasoning machine escalation

**Trigger to revisit:** When CT opens design work on OQ-3 (Multi-Agent Automation Architecture, V2 Build Guide `07_OpenQuestions.md`). The OQ-3 work cannot proceed correctly without this decision because OQ-3 will define the orchestration topology and that topology has to know how reviews route.

**Assigned to:** Jiang (analytical) + CT (architectural decision)

---

## [FW-005] Skills-Checker / Skills-Fixer Thread — Surface Lost Discussion
**Logged:** Session 036, April 25, 2026 (Re-Eval #1 walkthrough)
**Priority:** Medium — autonomous-unit layer prerequisite
**Status:** Parked at CT's explicit direction (ground-layer first)

**Problem:**
CT confirmed during the Re-Eval #1 walkthrough that there are plans for many autonomous units operating inside the brain — explicitly mentioned: skills-checker and skills-fixer. CT's exact words: *"such as the skills checker and skills fixer which we previously discussed but seems to have gotten lost."* The thread appears to have been lost across compaction events.

**What needs to be done:**
1. Search prior session handoffs and `Bot.Jiang/` working docs for prior CT discussion of skills-checker and skills-fixer
2. If located: reconstitute the thread, log key decisions, and integrate into the autonomous-unit architecture design
3. If genuinely lost: surface to CT for re-articulation when the autonomous-unit layer is opened
4. These are examples of the broader autonomous-unit category — design framework for autonomous units (operator pattern, lifecycle, supervision) should accommodate them

**Trigger to revisit:** When work begins on the autonomous-unit layer of the architecture. Concrete entry points: OQ-2 (Automated Neuron Creation Mechanism) work begins, or OQ-3 (Multi-Agent Automation Architecture) work begins. Either trigger surfaces this FW item.

**Assigned to:** Jiang (search and reconstitute) + CT (re-articulation if lost)

---

## [FW-006] Back-Apply Build Guide Standing Orders to Prior Decisions and System-Wide
**Logged:** Session 036, April 25, 2026 (after Re-Eval #3 lock)
**Priority:** Medium — discipline cleanup; not blocking forward re-evals
**Status:** Parked at CT's explicit direction (finish re-evals first, then back-apply)

**Problem:**
Two Build Guide standing orders were locked during the Re-Eval #3 walkthrough (2026-04-25):

1. Forward-reference notes wherever current build couples to future build
2. Build-space placeholders for every deferral, in the phase where the work lands

These rules govern all forward work. They have NOT been applied retroactively. Specifically:
- Re-Eval #1 Locked Outcomes name several deferrals (source multiplier values, ε threshold, round-cap, `contradiction_class` tag) without build-space placeholders
- Re-Eval #2 Locked Outcomes name parameters (verifier model selection, backpressure N, anomaly queue routing transition) without build-space placeholders
- The existing FW registry (FW-001 through FW-005) has entries without explicit Build Guide build-space placeholders
- Prior synthesis documents (Jiang2's TransitionalDecisions.Pt1.md, Jiang2.Synthesis.Session024.Apr12.md, etc.) likely contain cross-phase couplings without forward-reference notes
- The current V2 Build Guide files (`Claude.AI/New Build/`) were authored before the standing orders existed — neither rule has been applied across them

**What needs to be done:**
1. Walk Re-Eval #1 and Re-Eval #2 Locked Outcomes; identify every deferral; add Build Guide build-space placeholder spec for each (which phase, what placeholder content)
2. Walk every existing FW registry entry (FW-001 through FW-005); ensure each has a Build Guide build-space placeholder named in its "What needs to be done" section
3. Walk Jiang2's Transitional Decisions Pt1 and the prior synthesis docs; surface cross-phase couplings that need forward-reference notes
4. Walk the V2 Build Guide files; place forward-reference notes inline at every cross-phase coupling and build-space placeholders at every deferral landing site
5. Audit complete when every deferral known to the system has all three artifacts (FW entry, Check-ins entry where applicable, Build Guide placeholder) and forward-reference notes appear at every cross-phase coupling

**Trigger to revisit:** after Re-Evals #4-#7 are walked end-to-end and locked. Concrete trigger: the Chairman's Response section is filled for all seven re-evals in `Bot.Jiang/Jiang.RespondingToReEvaluations.md`.

**Assigned to:** Jiang (audit and surface) + Jiang2 (Build Guide placement during Build Guide update task) + CT (approval)

---

## [FW-007] Revisit Cyclic-Topology Routing Decision (Re-Eval #4) Before Final Build
**Logged:** Session 036, April 25, 2026 (Re-Eval #4 walkthrough)
**Priority:** Medium-High — architectural exposure with chosen mitigation; mitigation may need redesign based on incoming research
**Status:** STRUCTURALLY RESOLVED 2026-04-25 — Erdős's Causal Action Potential delivery (`Erdos.Solution.DarkSkillsTriggerlessGate.md`) provides a parameter-free mathematical detector for cyclic topology: in a DAG, `E[N_v] ≤ 1`, so `Φ_causal(v) = π_v / α > 1.0` is mathematically absolute proof of a directed cycle. The cyclic-detection prefilter no longer requires a graph-theoretic cycle check; the gate value itself proves cyclicity. Cyclic regions still route to Re-Eval #1's three-layer Layer 3 mechanism. Formal closure of this FW entry is the Chairman's call after reviewing the updated Re-Eval #4 and #5 sections in `Jiang.RespondingToReEvaluations.md`.

**Problem:**
Erdős's stress test (`Erdos.Solution.VEGPStressTest.md`, Proof 3) demonstrated that the VEGP cross-manifold isomorphism breaks on cyclic regions of the Brain pointer graph. Spatial PPR resonates mass via geometric series and triggers `Φ(v) > θ_work` on cyclic neuron pairs (e.g., mutual `contradicts` relationships); temporal IES under causal mask cannot form the reciprocal attention loop and the gate fails to fire. The two sides of the supposedly-isomorphic VEGP gate disagree on cyclic regions.

Working decision (Re-Eval #4 lock): when TAP detects `Φ(v) > θ_work` AND `v` is in a cyclic region (graph-theoretic detection runs as gate-prefilter), route the query to Re-Eval #1's three-layer Layer 3 contradiction-resolution mechanism instead of normal skill injection. Architectural rationale: cyclic regions in the Brain are almost always contradictions, and contradiction handling is what the three-layer mechanism exists for; the two systems converge on the same data with the same semantics.

The decision is robust to the spatial-walk formulation as long as `P_active` is well-defined. Two pieces of incoming research may force redesign:

1. **Trey's Non-Abelian Brain Dynamics audit** (`Trey.Research.NonAbelianBrainDynamicsAudit.md`, in flight). If Erdős's just-delivered Theorem 2 holds (commutator-vanishing as Layer 0 → Layer 1 compression criterion, with `[P_tax, P_them]` as the structural friction operator), the convex-combination formulation `P_active(q) = ω_tax · P_tax + ω_them · P_them` is structurally inadequate. Cyclic regions are precisely where commutator structure matters most. The cyclic-detection logic and the routing rule may need to be re-derived under the non-Abelian framework rather than the convex-combination framework.

2. **Erdős's Theorem 3 rigorous proof** (`Erdos.ResearchRequest.ThermodynamicCycleProof.md`, in flight). The thermodynamic cycle work may identify a conserved quantity, exact differential, or symmetry that gives cyclic regions a natural alternate treatment within the non-Abelian framework. If so, the cyclic-routing rule may simplify or change.

**What needs to be done:**
1. When either trigger returns, re-audit the cyclic-topology routing decision against the new framework
2. Evaluate whether the cyclic-detection logic (graph-theoretic check) is still the right detection criterion or whether commutator-norm-on-region is a better criterion under the non-Abelian framework
3. Evaluate whether routing to Re-Eval #1's Layer 3 mechanism is still the right destination, or whether a different mechanism (e.g., a non-Abelian-specific compression step) handles cyclic regions natively
4. Re-lock the cyclic-topology routing rule before the IES gate is committed to final build (Stage 1+ build commitment)

**Trigger to revisit:** when Trey's Non-Abelian audit returns OR Erdős's Theorem 3 proof returns, whichever first. Concrete trigger: the corresponding solution / research file lands in `Research_Complete/`.

**Assigned to:** Jiang (re-audit and re-lock) + CT (approval of any redesign)

**Build Guide build-space placeholder (per Standing Order 2):** cyclic-region routing layer lives in the TAP build phase (Stage 1), sitting as a gate-prefilter between TAP threshold check and skill injection. Placeholder marked with FW-007 reference and revisit trigger.

---

## [FW-008] Empirical κ Check-Ins Design Completion (Re-Eval #4)
**Logged:** Session 036, April 25, 2026 (after `Erdos.Solution.KappaOperationalTightness.md` returned Answer C)
**Priority:** Medium — required before Re-Eval form is finalized; not blocking remaining re-eval walkthroughs
**Status:** Spec direction locked from Erdős's KappaOperationalTightness delivery; concrete Check-ins-entry design pending

**Problem:**
Erdős's KappaOperationalTightness response (Answer C, 2026-04-25) confirmed Trey's original directive: the empirical-κ Check-ins entry must be retained because the analytic formula `κ = 2C(1-α)/(αδ)` is a strict worst-case bound that becomes unusable as a hard operational threshold under realistic Velorin conditions (Davis-Kahan looseness on non-normal matrices, worst-case resolvent alignment, redistribution masking localized distortion, spectral-gap volatility from eigenvalue crowding in sparse `d_max=7` graphs at scale).

The Check-ins entry direction is locked: measure actual retrieval-precision degradation by tracking how often `Φ_causal` drops below threshold for known ground-truth targets after test compression events. The analytic formula stays as a structural prior used to scale the empirical threshold geometrically if α changes.

The CONCRETE design of the Check-ins entry — measurement frequency, ground-truth target set construction, alert threshold, action protocol when threshold is exceeded — has not been specified. This is Jiang2's design work during the Build Guide update task.

**What needs to be done:**
1. Specify the ground-truth target set (how many targets, how selected, how often refreshed)
2. Specify the measurement protocol (what counts as a "test compression event" — synthetic compression on a copy of a region? real compression with rollback? scheduled cadence vs event-triggered?)
3. Specify the alert threshold (X% drop in Φ_causal against ground-truth before action triggers)
4. Specify the action protocol when alert fires (recalibrate κ from new measurements, halt further compression in that region, escalate to architecture review, etc.)
5. Specify how the analytic formula's structural-prior role engages — when α changes, what re-scales automatically vs what requires recomputation against new ground-truth targets
6. Place the entry into the Build Guide Check-ins schedule per Standing Order 1 (Check-ins construct from Re-Eval #2)
7. Place the Build-space placeholder in the compression event detector phase per Standing Order 2

**Trigger to revisit:** after all seven re-evals are walked end-to-end and BEFORE the Re-Eval response form (`Bot.Jiang/Jiang.RespondingToReEvaluations.md`) is finalized for Jiang2's rewrite. Concrete trigger: the Chairman's Response section is filled across all seven re-evals AND CT signals "ready to finalize." This must be designed before that finalization happens.

**Assigned to:** Jiang2 (concrete Check-ins design + Build Guide placement) + CT (approval of measurement frequency, threshold values, action protocol)

---

## [FW-010] Deep Think Curated Corpus Folder (and NotebookLM Context Layer)
**Logged:** Session 037, April 26, 2026
**Priority:** Medium — required before Mac Studio Deep Think workflow opens; not blocking current re-imagining
**Status:** Surfaced and parked. CT direction at session close: "we should do that later."

**What happened:**
CT surfaced that Deep Think (Gemini Deep Think mode, currently used only for Erdős math) has substantially broader applicability than math derivation — specifically: cross-corpus staleness audit, red-teaming Jiang2's reimagining synthesis, integration-topology stress-testing for the multi-vendor cowork architecture, and outside-tool deep evaluation. Constraint: 10 Deep Think prompts per 24 hours. CT noted that Deep Think will need a curated repo subset that removes noise from the first two weeks of building, so that the corpus it reads is signal-dense rather than iteration-saturated.

CT also previously named NotebookLM (mixed with a research-Gem Gemini) as the system that holds the entire Velorin context for a Trey-as-NotebookLM-controller audit pass over the build. NotebookLM's context appetite overlaps significantly with Deep Think's but is not identical — NotebookLM holds canonical state for retrieval-grounded queries; Deep Think loads task-specific subsets for adversarial reasoning.

**What needs to be done:**
1. Define the signal-vs-noise principle. Probable structure: a base "Velorin canonical state" subset (locked decisions, current operating rules cleaned of staleness, current Brain region state, returned-and-still-load-bearing Erdős and Trey research, current FW registry, current Build Guide + thesis + Mac Studio setup, locked feedback memories) — this is the clean signal. Iteration history (early synthesis docs, retracted designs like Topological Action Potential before CAP, the Demotion-Oracle-replaced-by-Affinity-Clutch lineage, retired bootloader versions, session-by-session chat captures) is excluded by default — pulled in ONLY when the specific Deep Think task requires the iteration record (e.g., the staleness / ghost-connection audit explicitly needs it).
2. Decide whether the curated folder lives inside `velorin-system/` as a tracked subset, as a generated view (script that produces it on demand), or as a separate repo (`velorin-canonical/`). Trade-off: tracked subset risks drift between the curated view and the source; generated view requires a curation script to maintain; separate repo requires sync discipline.
3. Specify the curation script if that path is chosen — what gets included by manifest, what gets excluded by pattern, what gets transformed (e.g., stripping the "destination:" headers from Receiving artifacts that were processed into final locations).
4. Define the relationship between the Deep Think folder and the NotebookLM context layer. Likely: NotebookLM holds the canonical state subset persistently; Deep Think's curated folder is the same canonical base PLUS task-specific add-ons per prompt.
5. Cross-reference with FW-006 (Back-apply Build Guide standing orders) and the outdated-rules cleanup CT flagged at Session 037 close — staleness in the source corpus contaminates any Deep Think corpus derived from it.

**Trigger to revisit:** when the Mac Studio multi-vendor cowork integration reaches the point where a Deep Think prompt is needed against curated context. Concrete trigger: Jiang2's reimagining synthesis lands AND CT signals readiness to commission the first non-Erdős Deep Think prompt OR the Mac Studio transition begins.

**Cross-references:**
- `project_mac_studio_multivendor_cowork.md` (overall transition plan)
- Jiang2's WholeSystemReimagining mandate, Section 7g (NotebookLM context layer architecture) and Section 11 (Velorin Startup Folder composition) — both touch this
- FW-006 (Build Guide standing orders back-application — the cleanup pass that produces the clean source for any Deep Think corpus)

**Build Guide build-space placeholder (per Standing Order 2):** Mac Studio transition phase, section on tooling integration. Marked with FW-010 reference and trigger.

**Assigned to:** Jiang (curation principle + script spec) + CT (final approval of folder composition and structure choice)

---

## [FW-011] Velorin Code/ Separate Triage Pass
**Logged:** Session 037, April 26, 2026
**Priority:** Medium-High — gates Mac Studio transition
**Status:** Surfaced and parked. Must complete before Mac Studio integration begins.

**What happened:**
The v1 archive execution pass intentionally did NOT touch `/Users/lbhunt/Desktop/Velorin/Velorin Code/` per CT direction (security-isolated repo, never merged with `velorin-system/`, never imported by agents). That folder contains MCP server source (velorin-gatekeeper, velorin-gdrive, possibly others), shell scripts, and other operational code. A parallel triage pass on it is required.

**What needs to be done:**
1. Spawn a separate triage agent narrowly scoped to `/Users/lbhunt/Desktop/Velorin/Velorin Code/` (mirror the pattern used for the v1 archive — produce a per-item manifest with HIGH-CONFIDENCE-ARCHIVE / HIGH-CONFIDENCE-KEEP / NEEDS-CT-DECISION classifications)
2. Specifically determine: which MCP servers move forward to Mac Studio (gdrive yes; gatekeeper NO — already decided as retired); which scripts get rebuilt vs ported; which experimental code archives
3. Uninstall `velorin-gatekeeper` MCP server as part of this pass (downstream of Pending Item 6 in `Velorin.v2.BuildPlanFinalization.PendingItems.md`)
4. Walk dispositions with CT (similar to the v1 archive pass)
5. Execute moves; commit + push to whatever repo Velorin Code/ uses (separate from velorin-system)

**Trigger to revisit:** when CT signals readiness to begin Mac Studio integration prep work, OR when Build Plan finalization completes (whichever first). The Velorin Code/ triage is an integration prerequisite.

**Cross-references:**
- `project_mac_studio_multivendor_cowork.md` (overall transition plan)
- Pending Item 6 in `Velorin.v2.BuildPlanFinalization.PendingItems.md` (Gatekeeper Build Guide update — depends on this triage to operationally remove the MCP)

**Assigned to:** Jiang (triage agent spawn + manifest review with CT) + CT (final dispositions)

---

## [FW-012] v2 Live Timer / Scheduled-Tasks Dashboard
**Logged:** Session 037, April 26, 2026
**Priority:** Low — replacement for retired GLOBAL_TIMER_REGISTRY governance pattern
**Status:** Surfaced. Replaces the manually-maintained registry that was archived in v1.

**What happened:**
The `GLOBAL_TIMER_REGISTRY.md` was retired (archived to `Velorin.v1.Archive/`) along with the broader Level 1/2/3/4 governance pattern. The IDEA behind it — single source of truth for "what scheduled tasks are active in the system" — is genuinely useful for ops visibility. v2 will have meaningful scheduled tasks: NotebookLM context refresh passes, Deep Think audit cadences, Trey-as-NotebookLM-controller runs, periodic Cowork orchestrations, Erdős re-poll cycles.

**What needs to be done:**
1. Build a live-generated dashboard ("what timers are active right now") rather than a manually-maintained markdown file
2. Source: `crontab -l` for cron jobs + the scheduled-tasks MCP API for managed scheduled tasks + any per-vendor scheduling surfaces (Cowork, Gemini scheduler, etc.)
3. Output: on-demand HTML or markdown report; possibly auto-emailed weekly summary
4. Locate at `Possibly Useful Scripts/timer-dashboard.sh` (or similar)
5. NOT a registry that requires pre-registration before activation — that was the v1 friction. Instead, a passive observer that reports current state.

**Trigger to revisit:** when v2 Cowork has its first set of scheduled multi-vendor tasks running (NotebookLM passes, Deep Think audits) and ops visibility becomes a real need.

**Cross-references:**
- Velorin.v1.Archive/GLOBAL_TIMER_REGISTRY.md (the retired manual-registry version)
- `project_mac_studio_multivendor_cowork.md`

**Assigned to:** Jiang (script design + build) + CT (approval of dashboard format)

---

## [FW-013] v2 Build Plan Finalization Pass
**Logged:** Session 037, April 26, 2026
**Priority:** HIGH — gates Mac Studio integration; Build Plan must be locked before integration begins
**Status:** Surfaced. Pending items document exists; Jiang2 + Deep Think pass to execute.

**What happened:**
The v1 archive execution pass surfaced 6 items that require Build-Guide-coupled or substantial-build work, deferred from immediate execution because (a) Build Guide files are FROZEN per Jiang2's WholeSystemReimagining mandate Hard Constraint 1, or (b) the work is substantial enough to warrant focused review with CT, or (c) the work depends on architectural decisions that haven't been made yet (e.g., NotebookLM integration timing). All 6 items are tracked in `Claude.AI/Bot.Jiang/Working.Docs/Velorin.v2.BuildPlanFinalization.PendingItems.md`.

**What needs to be done:**
1. Walk all 6 Pending Items per the sequencing recommendation in the file
2. Build Guide edits during this pass are authorized (Hard Constraint 1 lifted at finalization)
3. Items 1, 2, 6 (Build-Guide-coupled) handle together in a single Build Guide edit cycle
4. Items 3, 4 handle individually with focused review
5. Item 5 (Research Library Index) handle alongside NotebookLM context layer architecture
6. Lock Build Plan after all 6 items are resolved

**Trigger to revisit:** when CT signals the Build Plan is ready for finalization, OR when Mac Studio integration prep begins (triggers Build Plan lock as prerequisite). Concrete trigger: CT writes "ready to finalize Build Plan" or initiates v2 Cowork integration setup.

**Cross-references:**
- `Claude.AI/Bot.Jiang/Working.Docs/Velorin.v2.BuildPlanFinalization.PendingItems.md` (the active items list)
- FW-010 (Deep Think curated corpus — overlaps with Item 5)
- FW-011 (Velorin Code/ triage — overlaps with Item 6 / Gatekeeper operational removal)
- `Jiang2.WholeSystemReimagining.Mandate.md` (the mandate whose Hard Constraint 1 lifts at finalization)

**Assigned to:** Jiang2 (architectural synthesis) + Deep Think (audit pass) + Jiang (mechanical execution of moves and edits) + CT (final approval per item)

---

[VELORIN.EOF]
