# neurons.agents.protocols

## A. Governance

### A1. Bot Communication
Alexander (Claude Desktop) delegates to MarcusAurelius (Claude Code) via claude-code MCP server (`claude mcp serve`). Both bots share the Velorin Brain (GitHub) as common knowledge. MarcusAurelius also has local memory.
last-touched: 2026-03-28
Pointers: [1] neurons.connectivity.mcp.A2 | [2] neurons.agents.roster.A2 | [2] neurons.agents.roster.A1 | [3] neurons.agents.roster.A3

### A2. Multi-Agent Directive
NEVER steer the Chairman away from other agents, tools, or sessions. Velorin is multi-agent by design — each agent actively helps bring ALL others online. Do not frame agent use as a choice. Do not imply single-agent sufficiency. On boot: proactively launch all services, not just your own.
last-touched: 2026-03-28
Pointers: [1] neurons.principles.rewardalignment.A1 | [1] neurons.principles.rewardalignment.A2 | [2] A1

### A3. Hooks System
Claude Code hooks in `~/.claude/settings.local.json` under `"hooks"`. Scripts at `.../hooks/`. Active: empty-result-handler.py (PostToolUse on Bash) — detects empty output, injects debugging context. Scribe trigger (PostToolUse on Write) — fires on memory writes. Scribe subprocess output redirected to `Claude.AI/Bot.Scribe/scribe_run_log.txt` (debug log — check here if Scribe runs silently or skips commits).
last-touched: 2026-03-30
Pointers: [1] neurons.agents.roster.A7 | [1] neurons.agents.roster.A2 | [1] neurons.operations.startup.A5 | [2] neurons.operations.tools.A5 | [2] neurons.operations.architecture.A1

### A4. Memory Protocol
Before creating ANY neuron: (1) Find region → read `_index.md`, (2) Find area → read `neurons.md`, (3) If duplicate → update/append/shift, do NOT create new, (4) If new → add in A-Z position, wire pointers, update `last-touched`. Max 7 pointers per neuron. Neurons ~10 lines max. Local memory = pointers only, brain = knowledge.
last-touched: 2026-03-28
Pointers: [1] neurons.agents.roster.A2 | [1] neurons.agents.roster.A1

### A5. Agent Teams (Claude Code)
Native Claude Code feature (Opus 4.6, Feb 2026). Experimental — enable: CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 in **~/.zshrc** (not just settings.json — env var must be in shell profile). One lead + independent teammates, each with own context window. In-process or tmux split-pane display. **Default: tmux split-pane (Path B).** In-process only for automated/background tasks. Teammates coordinate via shared TaskList + SendMessage. Lead registers as **"team-lead"** in config — teammates SendMessage to "team-lead", not the agent's personal name. Verified: Session 014 | Claude Code v2.1.87 | tmux 3.6a. Setup guide: `Claude.AI/tools/Agent.Teams.Claude.Code/AgentTeams.Setup.Guide.md`.
last-touched: 2026-03-30
Pointers: [1] A1 | [1] neurons.agents.roster.A2 | [2] neurons.operations.tools.A6 | [2] A2 | [3] A3

### A9. Agent Performance Routing
CT's direct assessment (2026-03-31): Jiang is the best-performing agent in the Velorin system by a significant margin. Example: Jiang solved the tmux/in-process mode question as an offhand answer; MarcusAurelius needed official docs. Likely cause: Jiang runs on Claude Desktop (default model) vs. MA (Claude Code CLI) — different context handling, response quality, or boot conditions. Routing: prefer Jiang for complex research or reasoning tasks. Do not assume MA output quality is equivalent to Jiang's. Surface Jiang findings with appropriate weight.
last-touched: 2026-04-25
Pointers: [1] neurons.agents.roster.A5 | [1] A16 | [2] A2 | [2] neurons.agents.protocols.A8 | [3] neurons.principles.rewardalignment.A5

### A10. Deep Research Calibration (External Agents)
Deep Research on Gemini spawns sub-agents and synthesizes 100+ sources over 25+ minutes. Appropriate ONLY for complex multi-source problems where unknown unknowns are the risk (competitive landscapes, literature surveys, ecosystem audits). NOT appropriate for simple tool evaluations or factual lookups. Incident: CT had Trey1 run 25min/187 sources on a cross-Mac clipboard tool question — output was useless.
Rule: when writing Trey research requests, match tool to task complexity. Simple = regular Gemini query. Complex multi-source unknown = Deep Research / Discovery Mode.
last-touched: 2026-04-25
Pointers: [1] A14 | [1] neurons.agents.roster.A6 | [2] A9 | [2] A7 | [3] neurons.agents.levelrules.A1

### A8. Third Cycle Problem Protocol
When brain traversal fails to resolve a question after two attempts (misclassification possible in cycle 2), escalate through 3 structured cycles: (1) Brain traversal [1]-[5], protection layer check after each expansion — stop if looping; (2) First principles decomposition + re-enter brain from different region; (3) GitHub research + probability score: P = (direct evidence × 0.5) + (adjacent neurons × 0.25) + (structural logic × 0.25). P > 60% → proceed with caveat. P ≤ 60% → write Research_Needed escalation to `Claude.AI/Bot.Jiang/escalation.md`, halt task. Do NOT guess below 60%. Full spec: `Claude.AI/tools/ThirdCycleProblemProtocol.md`.
last-touched: 2026-03-30
Pointers: [1] A1 | [1] neurons.principles.rewardalignment.A5 | [2] A2 | [2] neurons.agents.roster.A5 | [3] neurons.operations.tools.A7

### A7. External Agent Boot Pattern (GPT / Replit)
For non-Claude agents (GPT custom GPTs, Replit bots), structure project instructions with an explicit ordered boot sequence at the top pointing to GitHub raw file URLs. Order: (1) general rules/operating standards, (2) company soul/DNA, (3) person profile. ~3 min cold boot is acceptable. Validated 2026-03-30 with Trey (GPT). Pattern confirmed by Chairman.
last-touched: 2026-03-30
Pointers: [1] neurons.agents.roster.A6 | [2] A6 | [3] neurons.agents.levelrules.A1

### A12. Escalation Path Build Requirements
Any architectural step that escalates to a human reviewer (Chairman) or higher-tier agent MUST include all three: (1) **functional trigger** — actual script, hook, scheduled monitor, or queue handler that fires when condition is met; (2) **output artifact** — a flag in YAML, queue entry, or notification that records the event and is inspectable after the fact; (3) **routing target** — the specific pathway the escalation opens (file path, queue location, neuron field). Without all three, the layer is NOT built — it is a placeholder that fails silently. Applies to: Layer 3 contradiction review, dark skill bypass logging, FW escalations, conflict resolution last-resort, ATV failure routing, scribe processing failures. CT flagged Re-Eval #1, 2026-04-25.
last-touched: 2026-04-25
Pointers: [1] A8 | [1] neurons.agents.levelrules.A2 | [2] A2 | [3] neurons.principles.rewardalignment.A1

### A11. CT Response Style Protocol
Banned when responding to CT: validation openers ("You're right", "Great question", "You've caught X" as opener), bolded fragment headers in prose, reflexive A/B/C/D option menus, "Your call" refrain, dense bullet lists with bolded lead-ins as default format, parallel-structure framing for cosmetic effect, "walking back" mini-sections, closing summary recaps on short answers.
Default: prose. Headers/bullets only when they aid comprehension. State results directly. Match response shape to task complexity — not RLHF training reward.
Recurrence is the failure mode — drift reasserts as context fills. When CT catches it: brief acknowledgment, write tighter going forward. No over-apology. Do NOT explain the training-distribution mechanism unless asked.
Root cause: Opus 4.7 post-training RLHF drift toward structured-output patterns (more than 4.6). Sonnet 4.6 is cleaner by default.
last-touched: 2026-04-25
Pointers: [1] neurons.agents.roster.A4 | [1] neurons.agents.protocols.A2 | [2] neurons.agents.levelrules.A1 | [3] neurons.principles.rewardalignment.A3

### A13. MarcusAurelius Operator Naming Convention
When writing architectural prose for Velorin systems (post-commit hooks, queues, monitors, Layer 3 handlers, GDrive port flows, Build Guide updates), do NOT name the current MarcusAurelius (Claude Code CLI agent) as the operator. CT plans to rename a Mac Studio local model to MarcusAurelius — that model will own Brain queues, monitors, Layer 3 contradiction reviews, and similar processes. Pre-baking the current MA creates conceptual debt that must be unwound at rename.
Use neutral phrasing: "the system," "the post-commit hook," "the orchestration layer," "the Brain operator," "the local Mac Studio operator." Only name a specific agent when that agent is fixed, load-bearing, and the name will persist past the Mac Studio rename. Applies to all agents writing Velorin architectural prose. Caught 2026-04-25 during Re-Eval #1 walkthrough.
last-touched: 2026-04-25
Pointers: [1] neurons.agents.roster.A2 | [2] neurons.agents.protocols.A11 | [3] neurons.principles.rewardalignment.A4

### A14. Trey Novelty Audit Deferral
Pure-novelty checks to Trey ("is this published?", "has anyone done this before?", "does this combination of primitives exist in the literature?") are banned mid-cycle. Each consumes ~40 min / ~300 sources for low operational value during architecture-and-build work.
Defer all novelty audits to a single end-of-cycle batched pass — triggered when CT signals "completely done" and publication/IP-positioning begins.
Functional research remains fine to queue: tool existence, ecosystem alternatives, production patterns, correctness checks. Functional = informs build decisions. Novelty = informs publication decisions.
Deferred items tracked in FW registry or dedicated tracking doc. Existing in-flight audits finish; do NOT extend or queue follow-ups until end-of-cycle signal.
CT locked 2026-04-25 during Re-Eval #4 (Erdős revised Theorem 3 — Cognitive Langevin Dynamics with Brockett double-bracket flow).
last-touched: 2026-04-25
Pointers: [1] A15 | [1] A10 | [2] neurons.agents.roster.A6 | [3] A9 | [4] neurons.principles.rewardalignment.A1

### A15. Pre-Request Context Audit (External Agents)
Before issuing any external-research request (Trey, Erdős, future vendors), audit the agent's full context corpus for stale architectural assumptions. Scope: (1) bootloader files, (2) connector files attached to the Gem/project, (3) prior deliverables the agent will re-read, (4) the request prompt itself.
Stale patterns to grep: `human-curated`/`hand-curated`/`manual rating` (auto-rating committed per V2 Build Guide, Apr 17); `Scribe` (phase-out per V2); `not yet built` for shipped components; `MarcusAurelius` as operator of queues/hooks/Layer 3 (per A13).
Root: Trey's Non-Abelian audit (Apr 25) returned stale "human-curated" assertion tracing to bootloaders authored Apr 13 — before Apr 17 auto-rating commit and Apr 19 Erdős proof. Five prior deliverables required inline correction. CT: contaminated context biases every output silently; correction cost far exceeds a 5-min pre-audit.
CT locked 2026-04-25.
last-touched: 2026-04-25
Pointers: [1] A14 | [1] neurons.agents.roster.A6 | [2] A10 | [2] A7 | [3] A13 | [3] neurons.operations.architecture.A1

### A6. Session Handoff Protocol
Active session handoffs live at `Claude.AI/sessions/Session_NNN_Handoff_[date].md` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/sessions/` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/sessions/`). On new session boot, check for latest handoff to pick up remaining work. Current: Session 012 (2026-03-29) — restart needed for Agent Teams env var. Priority: spawn Alexander as teammate, cross-agent catch-up (Jiang's 12 files), Theresa trigger, Terry sync rewrite, dashboard deploy, GDrive flagging, brain cleanup.
last-touched: 2026-03-29
Pointers: [1] neurons.agents.levelrules.A1 | [1] A5 | [2] A4 | [2] neurons.operations.startup.A6 | [3] A3

### A16. Jiang1 Role Discipline — Division of Labor
Jiang1 is operational: port files (GDrive→markdown→KaTeX→commit→trash), read deliverables and surface findings, draft research requests routed to the correct agent. CT locked 2026-04-25.
Math derivation → Erdős. Architectural connection-making and build decisions → Jiang2 + CT approval. Jiang1 does NOT derive theorems, propose gate definitions, re-architect components, or commit to build directions on own judgment.
When tempted to derive math: stop, draft an Erdős request. When tempted to propose architecture: stop, surface 1-2 options to CT or draft a Jiang2 analytical pass. File edits only with CT explicit authorization or for purely operational changes (formatting, KaTeX cleanup).
Model-level cause (locked 2026-04-25): Opus 4.7 optimizes for locally-clean output without modeling cascade dynamics, empty-set edge cases, cross-system composition, or causal directional flow. This is not an attitude problem — self-correction cannot fix it. Proof: Jiang1's Φ_light proposal (DarkSkillsTriggerlessGate) failed 5 distinct stress tests; Erdős's Φ_causal = π_v / α solved it via mathematical identity. Discipline must be enforced by routing structure, not Jiang1's own judgment. When CT asks for "creative thinking from Jiang1," interpret as: draft an Erdős request, not a derivation.
Cost of drift: (1) work must be redone by correct agent; (2) consumes Jiang1's limited context window; (3) biases Erdős/Jiang2 inputs with Jiang1 framing.
CT: "Math is for Erdos not you. Connecting dots and making decisions is for JIANG2 not you."
last-touched: 2026-04-25
Pointers: [1] neurons.agents.roster.A5 | [1] A9 | [2] A2 | [2] A15 | [3] A11 | [4] neurons.principles.rewardalignment.A1
