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
Claude Code hooks in `~/.claude/settings.local.json` under `"hooks"`. Scripts at `.../hooks/`. Active: empty-result-handler.py (PostToolUse on Bash) — detects empty output, injects debugging context. Scribe trigger (PostToolUse on Write) — fires on memory writes.
last-touched: 2026-03-28
Pointers: [1] neurons.agents.roster.A2 | [1] neurons.operations.startup.A5 | [2] neurons.operations.tools.A5 | [2] neurons.operations.architecture.A1

### A4. Memory Protocol
Before creating ANY neuron: (1) Find region → read `_index.md`, (2) Find area → read `neurons.md`, (3) If duplicate → update/append/shift, do NOT create new, (4) If new → add in A-Z position, wire pointers, update `last-touched`. Max 7 pointers per neuron. Neurons ~10 lines max. Local memory = pointers only, brain = knowledge.
last-touched: 2026-03-28
Pointers: [1] neurons.agents.roster.A2 | [1] neurons.agents.roster.A1

### A5. Agent Teams (Claude Code)
Native Claude Code feature (Opus 4.6, Feb 2026). Experimental — enable: CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 in settings.json. One lead session + independent teammates, each with own context window. Teammates communicate directly with each other. Requires v2.1.32+. Strategic fit: built for MarcusAurelius's native workload — parallel coding, cross-layer coordination, competing hypotheses. Changes the Alexander-Marcus channel dynamic.
last-touched: 2026-03-29
Pointers: [1] A1 | [1] neurons.agents.roster.A2 | [2] A2 | [3] A3

### A6. Session Handoff Protocol
Active session handoffs live at `Claude.AI/sessions/Session_NNN_Handoff_[date].md` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/sessions/` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/sessions/`). On new session boot, check for latest handoff to pick up remaining work. Current: Session 011 (2026-03-29) — items 6-9 remain (Scribe hook, dashboard deploy, GDrive flagging, brain cleanup).
last-touched: 2026-03-29
Pointers: [1] neurons.agents.levelrules.A1 | [2] A4 | [2] neurons.operations.startup.A6 | [3] A3 | [3] A5
