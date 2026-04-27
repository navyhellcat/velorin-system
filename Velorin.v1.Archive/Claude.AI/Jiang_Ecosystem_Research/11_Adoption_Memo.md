# VELORIN ADOPTION MEMO

What to adopt. In what order. Through which platform.

Jiang | March 28, 2026 | Follows: Ecosystem Intelligence Report

---

## PLATFORM ROUTING LOGIC

Three platforms serve different functions. Every adoption decision routes through this:

| Platform | Function |
|---|---|
| Claude Code | Coding, builds, file operations, MCP servers, skills, plugins, subagents, Agent Teams. This is the build engine. Runs on your machine with full filesystem access. All development tools (Superpowers, GSD, UI/UX Pro Max, obsidian-skills) install here. |
| Claude Desktop / Cowork | Knowledge work, scheduled tasks, computer use, connectors, Dispatch (phone-to-desktop). Non-coding automation. EndOfDay protocol. Morning briefs. Pipeline reviews. Browser control. This is the operations engine. |
| Claude.ai Projects | Current Velorin bot sessions (Alexander, Jiang). Drive boot protocol. Research and strategic work. Stays as-is until Claude Code + Obsidian vault can absorb the function. This is the legacy bridge. |
| ChatGPT (Trey) | External advisory. Code review second opinions. Market research. Trey stays on GPT. His value is the different perspective. Do not migrate Trey to Claude. The divergence is a feature. |
| Standalone Infrastructure | Obsidian vault. Local file system. Git repos. These are not Claude products. They are the substrate Claude operates on. Obsidian replaces Google Drive as the working knowledge base. Drive becomes backup and collaboration layer. |

---

## ADOPTION SEQUENCE — ORDERED BY DEPENDENCY

Each tier unlocks the next. Do not skip ahead. Items within a tier can be done in parallel.

### TIER 0 — DAY 1 (Machine Arrival, No Dependencies)

| Order | Component | Platform | Time | What it unlocks |
|---|---|---|---|---|
| 0.1 | Cowork Scheduled Tasks | Desktop | 30 min | EndOfDay protocol automated. Morning brief automated. Chairman recovers 30+ min/day. |
| 0.2 | Connectors: Drive, Gmail, Slack | Desktop | 10 min | Claude Desktop reads Drive, email, Slack natively. No custom MCP needed for basic access. |
| 0.3 | Superpowers plugin | Claude Code | 5 min | Brainstorm-plan-implement pipeline enforced on all coding. Subagent-driven development. Memory system. |
| 0.4 | GSD plugin | Claude Code | 5 min | Spec-driven development. Researcher agent before planning. Plan checker. 428 tests of methodology. |
| 0.5 | Operating Standards update | Internal doc | 15 min | Section 7 mandatory ecosystem check. Prevents the scope blindness diagnosed in the intelligence report. |

Tier 0 cost: $0. Tier 0 time: under 1 hour. Tier 0 impact: highest of any tier.

### TIER 1 — WEEK 1 (Requires Tier 0 Complete)

| Order | Component | Platform | Time | What it unlocks |
|---|---|---|---|---|
| 1.1 | Obsidian vault creation | Standalone | 2 hrs | Local knowledge base. Mirror Drive folder structure. CLAUDE.md in root. Bot ReadMe files as .md. |
| 1.2 | obsidian-skills install | Claude Code | 5 min | Claude Code reads/writes Obsidian formats natively. Bases, Canvas, wikilinks all understood. |
| 1.3 | Obsidian MCP server | Claude Code | 30 min | Claude Code queries vault via MCP. Search, read, create, modify notes from terminal. |
| 1.4 | Agent Teams evaluation | Claude Code | 2 hrs | Test multi-agent coordination on a real task. Determine if this replaces the Path 3 custom build. |
| 1.5 | UI/UX Pro Max install | Claude Code | 5 min | Design intelligence for Turing Vault Phase 2 and all future front-end work. |
| 1.6 | Ralph evaluation | Claude Code | 2 hrs | Test on substrate-level coding task and individual task bot. Scoped: not approved at orchestrator level. Evaluate circuit breaker patterns, rate limiting, spec compliance. |

Tier 1 cost: $0. Tier 1 time: under 7 hours across the week. Tier 1 impact: eliminates boot protocol token cost, unlocks Agent Teams and Ralph evaluations.

### TIER 2 — MONTH 1 (Requires Tier 1 Complete)

| Order | Component | Platform | Time | What it unlocks |
|---|---|---|---|---|
| 2.1 | Knowledge web migration | Standalone | 4 hrs | All Jiang topic documents, research logs, knowledge index moved to Obsidian with [[wikilinks]]. |
| 2.2 | Bot instructions migration | Standalone | 2 hrs | All ReadMe.First files become .md in vault subfolders. Claude Code reads them directly. No Drive fetch. |
| 2.3 | Cowork project setup | Desktop | 1 hr | One Cowork project per Velorin box. Persistent context, scoped memory, recurring tasks per box. |
| 2.4 | Agent Teams deployment | Claude Code | Variable | If 1.4 evaluation passes: multi-agent coordination replaces manual session management. If fails: proceed with Agent SDK custom build per original plan. |
| 2.5 | Drive role change | Internal | 30 min | Drive demoted from boot source to backup and collaboration layer. Obsidian is primary. Drive is archive. |

### TIER 3 — MONTH 2-3 (Requires Tier 2 Complete)

| Order | Component | Platform | Time | What it unlocks |
|---|---|---|---|---|
| 3.1 | Boot protocol retirement | Internal | 1 hr | BOT.README.FIRST.BOOTUP replaced by CLAUDE.md in vault root. Claude Code reads it on start. Zero tokens. |
| 3.2 | Claude.ai project consolidation | Claude.ai | Variable | Evaluate which Claude.ai projects (Alexander, Jiang) still need to exist vs. running entirely in Claude Code. |
| 3.3 | n8n MCP integration | Claude Code | 2 hrs | Build n8n automation workflows from Claude Code via natural language. Turing Vault growth automation. |
| 3.4 | Memory system selection | Claude Code | 2 hrs | Choose between claude-mem, Superpowers remembering-conversations, or Memory MCP. Install one. Retire manual knowledge web maintenance. |

---

## WHAT NOT TO ADOPT

Not everything in the research belongs in Velorin. The following were evaluated and rejected or deferred:

| Component | Reasoning |
|---|---|
| Ralph — orchestrator level | Runs Claude Code in unsupervised loops. Powerful but incompatible with Velorin's approval-first culture at the orchestrator level. The Chairman reviews and directs cross-domain decisions. Ralph at the Alexander/Jiang layer removes the Chairman from the loop. Reject at orchestrator level. APPROVED at substrate-level coding and individual task bots (Todd, Tim, Susan-equivalent) where the spec IS the approval. Moved to Tier 1.6 for evaluation. |
| CrewAI / LangGraph | Already concluded in AgentOrchestration research: Claude Agent SDK is the correct runtime if Agent Teams proves insufficient. External frameworks add dependency without adding capability Velorin needs. Defer unless Agent Teams fails. |
| Simone (project mgmt) | Overlaps heavily with GSD. GSD is lighter, better maintained, and more aligned with solo-builder workflow. Reject — GSD fills this slot. |
| Full Obsidian Sync | Obsidian Sync is $4/mo but is personal-tier. Velorin's collaboration needs are between bots, not humans. Git-based vault sync (already available) is the correct pattern. Defer Obsidian Sync. |
| Migrating Trey to Claude | Trey's value is the different model's perspective on the same problem. Homogenizing all agents on Claude removes the adversarial check. Keep Trey on GPT. |

---

## DECISION POINTS FOR CHRISTIAN TAYLOR

**1. Agent Teams vs. custom Agent SDK build.**

The evaluation in Tier 1.4 determines whether Path 3 needs to be built at all. If Agent Teams handles multi-agent coordination adequately, the 4-7 session custom build is eliminated. This is the single highest-leverage evaluation in the adoption sequence. I recommend a 2-hour structured test: give Agent Teams a real Velorin task that requires 3 agents coordinating, and evaluate the output quality and coordination. If it works, kill the custom build. If it doesn't, proceed with Agent SDK and the timeline already documented.

**2. Obsidian vs. Drive as primary knowledge layer.**

The research is conclusive: Obsidian is the stronger substrate for AI-agent-driven knowledge work. The migration path is low-risk because it is additive — Obsidian runs alongside Drive during transition. Drive is not deleted. It becomes the backup. The decision is whether to commit to the migration in Month 1 or defer it. My recommendation: commit. The boot protocol token cost and Drive timeout failures are ongoing operational friction that compounds. Every session that boots from Drive instead of local files costs tokens and time that are not recoverable.

**3. Timeline for Claude.ai project consolidation.**

Alexander and Jiang currently run as Claude.ai projects with Drive boot protocols. If Claude Code + Obsidian vault + Agent Teams works, these projects become redundant. The consolidation should not be forced — it should happen naturally as the new infrastructure proves itself. Tier 3.2 is deliberately marked 'variable' for this reason. Do not set a deadline. Let the tools earn the migration.

Confidence on adoption sequence: 85%. The ordering is dependency-driven and each tier has been validated against what is currently live and available. The rejection list is where I expect the most pushback — particularly on Ralph and Claude.ai consolidation. Both are defensible positions with the data available.

[VELORIN.EOF]