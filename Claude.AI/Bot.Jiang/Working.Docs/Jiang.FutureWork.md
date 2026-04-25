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

[VELORIN.EOF]
