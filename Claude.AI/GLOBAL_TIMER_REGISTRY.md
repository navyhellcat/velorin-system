# GLOBAL TIMER REGISTRY
**Velorin System | Layer 0 | CARDINAL — All agents, all levels**

**Every process, agent, bot, script, or system with ANY timed interval MUST be registered here.**
Failure to register is a company-wide protocol violation. No exceptions. No agent at any level is exempt.

Any agent creating or modifying a timer must update this file BEFORE activating the timer.

---

## Active Timers

| ID | Name | Interval | Owner | Location | Purpose | Created | Status |
|----|------|----------|-------|----------|---------|---------|--------|
| T001 | Neuron Boss escalation check | 1 hour | Bot.Oversight (Level 2) | `Claude.AI/Bot.Oversight/` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Oversight/` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.Oversight/`) | Reads escalation file, makes final decisions, pushes commands or deletes neurons | 2026-03-29 | DESIGNED — not yet deployed |
| T002 | Level 1 agent escalation check | 30 minutes | Bot.Custodian (Level 2) | `Claude.AI/Bot.Custodian/` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Custodian/` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.Custodian/`) | Reads escalation file, processes entries, escalates or commands down | 2026-03-29 | DESIGNED — not yet deployed |
| T003 | Level 1 agent escalation check | 30 minutes | Bot.Mobility (Level 2) | `Claude.AI/Bot.Mobility/` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Mobility/` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.Mobility/`) | Reads escalation file, processes entries, escalates or commands down | 2026-03-29 | DESIGNED — not yet deployed |
| T004 | Scribe daily clean | 24 hours | Bot.Scribe (Level 2) | `Claude.AI/Bot.Scribe/scribe-daily-clean.sh` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Scribe/scribe-daily-clean.sh` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.Scribe/scribe-daily-clean.sh`) | Scans MarcusAurelius memory, verifies neurons, deletes regular memories, consolidates rules | 2026-03-28 | DESIGNED — hook wired, needs restart |
| T005 | GDrive token auto-refresh | On expiry (~1 hour) | velorin-gdrive-mcp | `Velorin Code/velorin-gdrive-mcp/server.js` | Refreshes OAuth access token before expiry | 2026-03-26 | ACTIVE |
| T006 | Resend storage monitor | 6 hours | Turing Vault backend | `turingvault.replit.app` | Monitors session count, sends warning at 300K, critical at 370K | 2026-03-26 | ACTIVE |

---

| T007 | Terry — Shipping/Receiving check | 15 minutes | bot.marcusaurelius.subbot.logistics.01 (Level 1) | `Bot.MarcusAurelius.Subbots/Bot.MarcusAurelius.Subbots.Logistics/` | Checks Shipping/ and Receiving/ for new files, alerts MarcusAurelius | 2026-03-29 | ACTIVE |

## Retired / Inactive Timers

| ID | Name | Interval | Retired Date | Reason |
|----|------|----------|-------------|--------|
| T008 | Terry — Bidirectional GitHub ↔ Local sync | 60 minutes | 2026-03-29 | Replaced by Receiving protocol — MarcusAurelius handles all git operations |

---

## Rules

1. **Before activating ANY timer:** Add entry to this file. Commit. Push. Timer cannot go live before this file is updated.
2. **When modifying a timer interval:** Update this file first. Old interval is overwritten, not appended.
3. **When retiring a timer:** Move entry from Active to Retired with date and reason.
4. **Every agent's instruction document must reference this file.** If an agent can create timers, its instructions must state: "Register all timers in `Claude.AI/GLOBAL_TIMER_REGISTRY.md` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/GLOBAL_TIMER_REGISTRY.md` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/GLOBAL_TIMER_REGISTRY.md`) before activation."
5. **Audit:** Any agent encountering a running timer not in this registry must halt it and report to Level 4.

---

*GLOBAL_TIMER_REGISTRY.md | Layer 0 | Created 2026-03-29 | Session 011*

[VELORIN.EOF]
