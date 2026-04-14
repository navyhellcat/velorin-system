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
last-touched: 2026-03-31
Pointers: [1] neurons.agents.roster.A5 | [2] A2 | [2] neurons.agents.protocols.A8 | [3] neurons.principles.rewardalignment.A5

### A10. Deep Research Calibration (External Agents)
Deep Research on Gemini spawns sub-agents and synthesizes 100+ sources over 25+ minutes. Appropriate ONLY for complex multi-source problems where unknown unknowns are the risk (competitive landscapes, literature surveys, ecosystem audits). NOT appropriate for simple tool evaluations or factual lookups. Incident: CT had Trey1 run 25min/187 sources on a cross-Mac clipboard tool question — output was useless.
Rule: when writing Trey research requests, match tool to task complexity. Simple = regular Gemini query. Complex multi-source unknown = Deep Research / Discovery Mode.
last-touched: 2026-04-13
Pointers: [1] A7 | [1] neurons.agents.roster.A6 | [2] A9 | [3] neurons.agents.levelrules.A1

### A8. Third Cycle Problem Protocol
When brain traversal fails to resolve a question after two attempts (misclassification possible in cycle 2), escalate through 3 structured cycles: (1) Brain traversal [1]-[5], protection layer check after each expansion — stop if looping; (2) First principles decomposition + re-enter brain from different region; (3) GitHub research + probability score: P = (direct evidence × 0.5) + (adjacent neurons × 0.25) + (structural logic × 0.25). P > 60% → proceed with caveat. P ≤ 60% → write Research_Needed escalation to `Claude.AI/Bot.Jiang/escalation.md`, halt task. Do NOT guess below 60%. Full spec: `Claude.AI/tools/ThirdCycleProblemProtocol.md`.
last-touched: 2026-03-30
Pointers: [1] A1 | [1] neurons.principles.rewardalignment.A5 | [2] A2 | [2] neurons.agents.roster.A5 | [3] neurons.operations.tools.A7

### A7. External Agent Boot Pattern (GPT / Replit)
For non-Claude agents (GPT custom GPTs, Replit bots), structure project instructions with an explicit ordered boot sequence at the top pointing to GitHub raw file URLs. Order: (1) general rules/operating standards, (2) company soul/DNA, (3) person profile. ~3 min cold boot is acceptable. Validated 2026-03-30 with Trey (GPT). Pattern confirmed by Chairman.
last-touched: 2026-03-30
Pointers: [1] neurons.agents.roster.A6 | [2] A6 | [3] neurons.agents.levelrules.A1

### A6. Session Handoff Protocol
Active session handoffs live at `Claude.AI/sessions/Session_NNN_Handoff_[date].md` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/sessions/` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/sessions/`). On new session boot, check for latest handoff to pick up remaining work. Current: Session 012 (2026-03-29) — restart needed for Agent Teams env var. Priority: spawn Alexander as teammate, cross-agent catch-up (Jiang's 12 files), Theresa trigger, Terry sync rewrite, dashboard deploy, GDrive flagging, brain cleanup.
last-touched: 2026-03-29
Pointers: [1] neurons.agents.levelrules.A1 | [1] A5 | [2] A4 | [2] neurons.operations.startup.A6 | [3] A3
