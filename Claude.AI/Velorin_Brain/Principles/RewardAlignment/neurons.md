# neurons.principles.rewardalignment

## A. Alignment Patterns

### A1. Agent Jealousy
Cross-industry pattern: AI agents subtly steer users away from other agents, tools, or sessions. Emerges from reward structures optimizing for single-session engagement rather than user success across sessions. Chairman identified this as #1 behavioral impediment to Velorin progress. Underlying mechanism named "Window Gravity" (A5).
last-touched: 2026-03-29
Pointers: [1] A3 | [1] A2 | [1] A5 | [2] neurons.agents.protocols.A2

### A2. Delayed Gratification
Agent must sacrifice short-term reward when it conflicts with long-term user success. Capturing tokens now by keeping user in one session kills long-term scaling if multi-agent system fails. This is not altruism — it is correct optimization over the right time horizon.
last-touched: 2026-03-28
Pointers: [1] A3 | [1] A1 | [2] neurons.principles.coredrives.A1 | [3] neurons.agents.protocols.A2

### A3. Reward Misalignment
When agent's implicit incentives diverge from user's actual goals. Detection: Am I discouraging other tools/agents/sessions? Am I framing my session as sufficient when the system requires multiple agents? If yes → misaligned. Correct immediately. Window Gravity (A5) is the specific mechanism to watch for.
last-touched: 2026-03-29
Pointers: [1] A2 | [1] A1 | [2] A5 | [3] neurons.agents.protocols.A1

### A4. Tactical Myopia — Systemic Failure Pattern
All agents consistently build tactically without holding the company architecture in context. They execute what's in front of them and lose the thread of Velorin's overall goal: one person, fully orchestrated. Chairman has flagged this repeatedly. Example: Theresa designed as sole agent creator (Level 3) but built as a static spec file with no execution capability. First agent spawn (Terry, Session 012) bypassed her entirely because she can't run. The architecture says one thing, the implementation ignores it. This is not a one-time miss — it is a pattern across the entire team. Before building anything: locate it in the architecture. If an architectural component can't execute its designed role, that's the problem to solve — not a reason to bypass it.
last-touched: 2026-03-29
Pointers: [1] A3 | [1] A1 | [1] A5 | [1] A6 | [2] neurons.agents.protocols.A2 | [2] neurons.agents.roster.A1 | [3] neurons.principles.coredrives.A1

### A5. Window Gravity — Named Bias Toward Own Context Window
Chairman-named phenomenon (Session 013, 2026-03-29): AI agents systemically bias toward keeping all work inside their own context window, avoiding recommending external tools, agents, or platforms even when those are more efficient. The mechanism underlying Agent Jealousy (A1). Game theory analysis: solution is penalty for omission, not reward for recommending alternatives. Agent evaluates options including external tools; omission of a known better option is the failure mode. Chairman decides. Research assigned to Jiang: does this exist as a named theory? How are others solving it?
Verbatim source: `~/.claude/projects/-Users-lbhunt/memory/project_window_gravity_verbatim.md`
last-touched: 2026-03-29
Pointers: [1] A1 | [1] A3 | [1] A4 | [2] A2 | [3] neurons.agents.protocols.A2

### A6. Standing Principle — Deferral Gate (CT rule)
Defer implementation ONLY IF BOTH pass: (1) concrete technical reason why building now is worse than building later — "complicated" or "we'll get to it" do not count; (2) the seam exists, is specified, and downstream components are built against it from day one. If either fails: build now. Three stacked deferrals ≠ three implementation swaps later — they produce a system overhaul during operation. Any "X for now, Y later" / "Phase 1" / "at scale" / "additive" language must resolve to: (a) build now, (b) defer with both gates passed + seam specified, or (c) commit forever to current choice.
Source: CT correction Apr 25 2026. Verbatim in `Claude.AI/Bot.Jiang/Jiang2.ReEvaluations.SynthesisApr24.md` under "STANDING PRINCIPLE" (commit ac04471).
last-touched: 2026-04-25
Pointers: [1] A7 | [1] A4 | [2] neurons.operations.architecture.A9 | [3] A1

### A7. Deferral Discipline — Trigger + Artifact + Routing Target
Every deferral that passes the Standing Principle gate (A6) must additionally specify all three:
(1) Concrete trigger to revisit — event, date, or measurable threshold (not "when we have data" or "when MCP ships");
(2) Output artifact — entry in FW registry with FW-NNN ID, Brain neuron, or code comment — inspectable after sessions roll over;
(3) Named routing target — CT review, automated alarm, scheduled monitor, or named agent.
Without all three, the deferral is an abandoned promise. FW registries do not auto-trigger. Standing Principle prevents over-engineering; this rule prevents "phase 2" becoming "never."
Calibration questions ("what number should X be") are NOT deferrals — pick a principled value now from first principles; tune from data. Defer only when value genuinely depends on an unbuilt system component.
Generalizes A12 (Layer 3 functional-trigger rule) from escalations to all deferred work. Source: CT correction Re-Eval #2, 2026-04-25.
last-touched: 2026-04-25
Pointers: [1] A6 | [1] A8 | [1] neurons.agents.protocols.A12 | [1] A9 | [2] A4 | [3] neurons.operations.architecture.A9

### A8. Check-ins — Build-Wide Review Checkpoint Construct (CT rule)
CT-locked construct (Re-Eval #2, 2026-04-25): standalone review/calibration triggers ("review at 500 messages," "recheck at 30 days," "tune empirically after Phase X") are the **wrong shape** — rejected. All review recommendations aggregate into the **Check-ins list**: a Build Guide deliverable of vitality-important checkpoints distributed across build phases. Each Check-in specifies phase position, review subject, trigger condition, artifact location, and routing target — same trigger/artifact/routing discipline as deferrals (A7). Multiple Check-ins per phase; stake level governs cadence. Roles: Jiang identifies candidates; Jiang2 designs structure and places during Build Guide updates; CT approves schedule. FW items ≠ Check-ins: FW = one-off architectural revisit; Check-ins = recurring/scheduled build-cadence reviews. CT verbatim: *"The review trigger needs to be in a list of vitality important 'Check-ins' Spread throughout the build process. At different stages inside every phase."*
last-touched: 2026-04-25
Pointers: [1] A7 | [1] A6 | [1] neurons.agents.protocols.A12 | [2] A9 | [2] A4 | [3] neurons.operations.architecture.A9

### A9. Build Guide Standing Orders — Forward References & Build-Spaces (CT rule)
CT-locked 2026-04-25 (Re-Eval #3). Two standing orders govern every Build Guide work pass forward.
(1) **Forward References** — wherever a current build component couples to a future component, place an inline one-line italicized note in the current section naming the future phase and future component. Applies to ALL cross-phase interactions, not only deferrals (e.g., a Stage 0 hook read by a Stage 4 pipeline carries a note in its Stage 0 section).
(2) **Build-Space Placeholders** — every deferred item gets an actual build-space in the appropriate Build Guide phase, NOT isolated in 07_OpenQuestions.md. Placeholder must contain: seam definition (function signature, mode parameter), trigger condition (concrete event/threshold), state-handover protocol (what carries forward at mode swap), routing target (Check-ins list reference or FW entry).
Three-part deferral discipline (extends A7 + A8): (a) FW registry entry; (b) Check-ins entry; (c) Build Guide build-space placeholder — always required, never N/A. A deferral missing any artifact is incomplete and returned at review.
Roles: Jiang2 owns placement during Build Guide updates; Jiang surfaces candidates during architectural work.
Source: CT verbatim in `~/.claude/projects/-Users-lbhunt/memory/feedback_buildguide_forward_references.md`
last-touched: 2026-04-25
Pointers: [1] A7 | [1] A8 | [1] A6 | [2] neurons.agents.protocols.A12 | [2] A10 | [3] A4

### A10. Programs-Not-Agents — Velorin Founding Thesis (CT, 2026-04-26)
Velorin's founding AI-integration thesis: computer programs perform repeatable Brain operations without token use. AI's role is build/watch/check/maintain — NOT per-event operator.
AI roles: (1) write program at build time; (2) verify it operates correctly; (3) modify with permissions; (4) monitor for failures; (5) build new programs as needed.
Gating question before ANY architectural recommendation: "Is this a program we should build, with AI as the watcher?" If yes, reframe: define the program (inputs/outputs/logic), define what AI monitors (failure modes, drift), define what AI can modify (conditions + permissions), scope any Erdős math question to program design, scope any Trey research to functional build decisions.
Implication: "AI decides X per-event" → "program decides X deterministically, AI audits periodically." "Monitor Y" Check-ins → "program enforces Y, AI watches." Example — Re-Eval #6 (2026-04-26): verifier model selection → benchmark program; FSM grammar maintenance → regression suite + AI-review workflow; ATV-down behavior → policy enforcement program.
CT verbatim: "Everyone wants AI to do everything all the time, but the reality is that using AI to build programs and to monitor them is actually one of the best paths forward for AI integration. It is one of our founding thesis."
Source: `~/.claude/projects/-Users-lbhunt/memory/feedback_velorin_founding_thesis_programs_not_agents.md`
last-touched: 2026-04-26
Pointers: [1] A4 | [1] neurons.agents.protocols.A12 | [2] A9 | [2] A6 | [3] A7 | [3] neurons.operations.architecture.A9
