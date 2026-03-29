# GLOBAL SPAWNER REGISTRY
**Velorin System | Layer 0 | CARDINAL — All agents, all levels**

**Every agent or process that is ALLOWED to request agent creation must be registered here.**
**Every agent that IS created must be recorded here at creation time.**
**ALL agent creation is executed by Bot.Theresa (HR, Level 3). No other bot builds agents directly.**
Failure to register is a company-wide protocol violation. No exceptions. No agent at any level is exempt.

Any agent requesting creation must have Theresa update this file BEFORE the new agent activates.

---

## Agent Creator

| Role | Bot | Level | Location |
|------|-----|-------|----------|
| **Sole Agent Creator** | Bot.Theresa | Level 3 | `Claude.AI/Bot.Theresa/` |

Theresa executes ALL agent creation and termination. Other bots REQUEST through her escalation file. They do not build directly.

---

## Authorized Requesters (can request agent creation from Theresa)

| ID | Requester Name | Level | Location | Can Request | Constraints | Authorized Date |
|----|---------------|-------|----------|-------------|-------------|-----------------|
| S001 | Christian Taylor (Chairman) | Level 5 | — | Any agent at any level | None — MarcusAurelius executes L4 builds | 2026-03-29 |
| S002 | MarcusAurelius | Level 4 | `Claude.AI/Bot.MarcusAurelius/` | Level 3 and below via Theresa | Must create subfolder structure first | 2026-03-29 |
| S003 | Alexander | Level 4 | `Claude.AI/Bot.Alexander/` | Level 3 and below via Theresa | Must create subfolder structure first | 2026-03-29 |
| S004 | Jiang | Level 4 | `Claude.AI/Bot.Jiang/` | Level 3 and below via Theresa | Must create subfolder structure first | 2026-03-29 |
| S005 | Bot.Editor | Level 3 | `Claude.AI/Bot.Editor/` | Level 1 Sub-Agents via Theresa | Brain fortress rules apply | 2026-03-29 |
| S006 | Bot.Coordinator | Level 3 | `Claude.AI/Bot.Coordinator/` | Level 1 Sub-Agents via Theresa | Brain fortress rules apply | 2026-03-29 |
| S007 | Bot.Oversight | Level 3 | `Claude.AI/Bot.Oversight/` | Level 1 Sub-Agents via Theresa | Brain fortress rules apply | 2026-03-29 |

## HARD REJECT — These CANNOT request agent creation:
- Any bot with `.subbot` in the name
- Any bot not in this registry
- Any Level 2 agent (Custodian, Mobility, Scribe — they request through their Level 3 manager)

---

## Spawned Agent Log

| Spawn ID | Agent Name | Level | Spawned By | Location | Purpose | Created | Status |
|----------|-----------|-------|-----------|----------|---------|---------|--------|
| SP001 | Terry (bot.marcusaurelius.subbot.logistics.01) | Level 1 | MarcusAurelius (via Chairman direct order) | `Bot.MarcusAurelius.Subbots/Bot.MarcusAurelius.Subbots.Logistics/` | Shipping/Receiving folder monitor — 15min check | 2026-03-29 | ACTIVE |

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
