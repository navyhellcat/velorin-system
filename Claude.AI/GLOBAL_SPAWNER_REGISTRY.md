# GLOBAL SPAWNER REGISTRY
**Velorin System | Layer 0 | CARDINAL — All agents, all levels**

**Every agent or process that is ALLOWED to create another agent must be registered here.**
**Every agent that IS created by a spawner must be recorded here at creation time.**
Failure to register is a company-wide protocol violation. No exceptions. No agent at any level is exempt.

Any spawner creating a new agent must update this file BEFORE the new agent activates.

---

## Authorized Spawners

| ID | Spawner Name | Level | Location | Can Spawn | Constraints | Authorized Date |
|----|-------------|-------|----------|-----------|-------------|-----------------|
| S001 | Christian Taylor (Chairman) | Level 5 | — | Any agent at any level | None | 2026-03-29 |
| S002 | ClaudeBot | Level 4 | `Claude.AI/Bot.ClaudeBot/` | Level 2, Level 3 agents | Must register bot in Claude.AI with ReadMe.First | 2026-03-29 |
| S003 | Alexander | Level 4 | `Claude.AI/Bot.Alexander/` | Level 2, Level 3 agents | Must register bot in Claude.AI with ReadMe.First | 2026-03-29 |
| S004 | Jiang | Level 4 | `Claude.AI/Bot.Jiang/` | Level 2, Level 3 agents (research domain) | Must register bot in Claude.AI with ReadMe.First | 2026-03-29 |
| S005 | Bot.Editor | Level 3 | `Claude.AI/Bot.Editor/` | Level 1 Sub-Agents only | Per Level1_SubAgent_Baseline.md, Section B per position | 2026-03-29 |
| S006 | Bot.Coordinator | Level 3 | `Claude.AI/Bot.Coordinator/` | Level 1 Sub-Agents only | Per Level1_SubAgent_Baseline.md, Section B per position | 2026-03-29 |

---

## Spawned Agent Log

| Spawn ID | Agent Name | Level | Spawned By | Location | Purpose | Created | Status |
|----------|-----------|-------|-----------|----------|---------|---------|--------|
| — | — | — | — | — | — | — | No agents spawned yet |

---

## Agents NOT Authorized to Spawn

These agents exist in the system but CANNOT create other agents under any circumstance:

| Agent | Level | Reason |
|-------|-------|--------|
| Bot.Custodian | Level 2 | Scans and flags only. Cannot create sub-agents. |
| Bot.Mobility | Level 2 | Scans and flags only. Cannot create sub-agents. |
| Bot.Scribe | Level 2 | Writes neurons on trigger. Cannot create sub-agents. |
| Bot.Oversight (Neuron Boss) | Level 2 | Decides and deletes. Cannot create sub-agents. |
| Bot.Visualizer | Level 2 | Reads and renders. Cannot create sub-agents. |
| All Level 1 Sub-Agents | Level 1 | Per Level1_SubAgent_Baseline.md rule A6. Cannot spawn. |

---

## Rules

1. **Before spawning ANY agent:** Add entry to Spawned Agent Log in this file. Commit. Push. Agent cannot activate before this file is updated.
2. **Only agents listed in Authorized Spawners can create agents.** Any unlisted agent attempting to spawn is a protocol violation.
3. **When a spawned agent terminates:** Update its Status to TERMINATED with date.
4. **Every agent's instruction document must reference this file.** If an agent can spawn, its instructions must state: "Register all spawned agents in GLOBAL_SPAWNER_REGISTRY.md before activation."
5. **Audit:** Any agent encountering a running agent not in this registry must halt it and report to Level 4.

---

*GLOBAL_SPAWNER_REGISTRY.md | Layer 0 | Created 2026-03-29 | Session 011*
