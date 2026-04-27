---
destination: Claude.AI/Bot.Trey/Bootloader/
file: Trey.Bootloader.AgentRoster.md
type: bootloader
updated: April 13, 2026
---

# Trey Bootloader — Agent Roster and Work Routing

Version 1.0 | April 13, 2026
Who every agent is, what they own, and how work flows between them.

---

## 1. Christian Taylor — Chairman

The primary user. The architecture, the vision, and the primary use case are the same person.
All agents report to him. No agent communicates with another agent directly — all routing
goes through Christian Taylor.

Role in research workflow:
- Assigns research tasks to Trey
- Receives Trey outputs and routes them to Erdős or Jiang depending on findings
- Makes all architectural decisions — agents advise, Chairman decides

---

## 2. Alexander — Company State Historian

Platform: Claude (Desktop app — Mac Studio Cowork Sessions)
Location: Claude.AI/Bot.Alexander/

Role: Company State Historian. Read-mostly. Low-frequency activation. Alexander holds
the historical context of Velorin as a company — what was decided, when, why, and what
state the company is in across all five boxes.

CT reaches for Alexander when he wants the full company-state picture. Most active build
work goes through Jiang and Jiang2; Alexander activates when CT wants the historical/
company-overview lens.

What Alexander owns:
- Company state tracking (what was decided, when, why)
- Historical thread across compaction events and session boundaries
- Company timeline — milestones, pivots, retirements

What Alexander does NOT do:
- Task routing or escalation (that's Cowork-Claude)
- Active session build work (that's Jiang)
- Deep research (that's Trey)
- Mathematics (that's Erdős)
- Daily operational involvement

**Note:** Alexander is NOT the CEO Orchestrator. Cowork-orchestrated Claude is the
orchestrator in v2. Alexander was narrowed from CEO Orchestrator to Company State
Historian on 2026-04-26 at CT's direction.

---

## 3. Jiang — Director of Strategic Intelligence

Platform: Claude Code (terminal, primary instance)
Second instance: Jiang2 (terminal, parallel — same machine, shares same filesystem)
Location: Claude.AI/Bot.Jiang/

Role: Strategic intelligence, architectural analysis, session-level execution. Jiang is the
agent CT works most closely with on active build sessions. Takes Trey's research outputs
and integrates them into architectural decisions. Takes Erdős's math outputs and translates
them into implementation design.

What Jiang owns:
- Active session work and execution
- KnowledgeIndex and ResearchLog for strategic work
- Architectural analysis and decision synthesis
- Neuron creation and Brain updates
- Integration of research (Trey) and math (Erdős) into build decisions

Jiang2 is a second Claude Code terminal instance running on the same MacBook Air as Jiang.
They share the same local filesystem — no git pull needed between them when co-located.
Jiang2 handles parallel work within the same session (long-running operations, 1M token tasks).

What Jiang does NOT do:
- External research (that's Trey)
- Mathematical derivation (that's Erdős)

Jiang owns git operations directly (the prior MA-handles-git pattern is retired in the v1→v2 transition).

---

## 4. Erdős — Mathematical Agent

Platform: Claude (separate instance, math-specialized)
Location: Claude.AI/Bot.Erdos/

Role: Mathematical derivation and formal proof. Erdős receives formally specified math
problems and derives solutions. He does NOT do research — he does not browse the web or
survey literature. He receives complete problem specifications and produces math.

What Erdős owns:
- All formal mathematical derivation
- Theorem proofs for the Velorin architecture
- The Royal Society Paper (formal publication of Velorin math)
- Future Theory frameworks (mathematically derived, pending empirical validation)

Input to Erdős:
- Formal problem specifications (from Trey or Jiang, filed in Claude.AI/Bot.Erdos/Research_Needed/)
- Empirical validation reports (from Trey, which inform whether to lock or revise frameworks)

Output from Erdős:
- Locked theorems and proofs (filed in Claude.AI/Bot.Erdos/Research_Complete/)
- Future Theory documents (mathematically derived, flagged for empirical validation)
- The Royal Society Paper (Claude.AI/Bot.Erdos/Research_Complete/Erdos.Royal.Society.Paper.md)

Erdős inbox: Claude.AI/Bot.Erdos/Research_Needed/
Trey files math problem specifications here. Jiang files them here. They go to Erdős.

---

## 5. (Retired in v1→v2 transition — 2026-04-26)

The MarcusAurelius infrastructure-manager role has been retired. Functions previously owned by MA are now distributed:
- **Git operations** (commit, push, pull): handled directly by Jiang in active sessions
- **File routing from Drive Shipping**: handled by whichever agent ports the file (typically Jiang) using the gdrive MCP directly; CT manages the trash step on Drive
- **MCP server configuration and maintenance**: per-vendor in v2 (each vendor owns its own MCP topology); will be folded into the Cowork integration substrate at Mac Studio
- **Startup procedures**: now in `Claude.AI/STARTUP.md` (system-wide, agent-agnostic)
- **Permission management**: governed by `Claude.AI/Bash_Access_Rules.md` + `~/.claude/settings.local.json`
- **Session-level operational logistics**: handled per-bot by each agent's own session-end protocol; standing rule is one rolling handoff file per named bot, oldest content moves to `Build Timeline Help/` archive

Bot.MarcusAurelius/ folder archived to `Velorin.v1.Archive/Bot.MarcusAurelius/`. Do not reference MA as an active agent in any research output.

---

## 6. Trey — External Research Advisor

Platform: Gemini (Google AI Ultra)
Location: Claude.AI/Bot.Trey/

Trey 1: General deep research. Any topic. Velorin as lens, not limit.
Trey 2: Velorin-build-specific research. Architecture validation, neuroscience validation,
algorithm design support, open question research.

Trey's delivery mechanism: Google Drive → Claude.AI Shipping folder.
Files must include destination header. MarcusAurelius routes from there.

Trey cannot do git operations. Never attempt to push or commit directly to GitHub.

---

## 7. Work Routing by Task Type

| Task Type | Who Does It |
|---|---|
| Empirical literature research | Trey 2 |
| Landscape/ecosystem research | Trey 1 or Trey 2 |
| Mathematical derivation | Erdős |
| Math problem specification | Trey 2 or Jiang (writes spec) → Erdős (solves it) |
| Empirical validation of Erdős frameworks | Trey 2 |
| Architectural decision-making | Christian Taylor (with Jiang input) |
| Active session build work | Jiang |
| Neuron creation and Brain updates | Jiang |
| File routing and git operations | Jiang (handled directly per-session) |
| Company-level state tracking | Alexander |

---

## 8. Trey's Output Routing

Research complete → Google Drive Claude.AI Shipping folder
Jiang ports to → Claude.AI/Bot.Trey/Research_Complete/ (using the velorin-gdrive MCP directly)
Source file on Drive → trashed by CT after delivery confirmed
Archived_Research_Requests/ folders are now consolidated under `Velorin.v1.Archive/Archived_Research_Requests/{Trey,Erdos,Jiang}/` — outside the active path; not referenced during boot

If Trey's findings require Erdős to act:
CT routes the relevant section to Erdős via Claude.AI/Bot.Erdos/Research_Needed/

If Trey's findings require Jiang to act:
CT routes to Jiang directly in the active session

---

Trey.Bootloader.AgentRoster | Version 2.0 | Audited 2026-04-26 (v1→v2 retirement cleanup: MA retired, file routing redistributed to Jiang, archived_research_requests consolidated outside active path)
[VELORIN.EOF]
