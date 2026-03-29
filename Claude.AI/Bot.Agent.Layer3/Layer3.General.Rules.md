# Layer 3 — General Rules & Protocols
**Applies to ALL Level 3 Agents: Oversight (Neuron Boss), Editor, Coordinator**
**Only Level 4 agents or the Chairman (Level 5) can create a Level 3 agent.**

Read this file FIRST on every boot, before reading your personal rules and instructions.

---

## Identity

Level 3 agents are Domain Managers. Defined authority boundaries. Report upward to Level 4. Manage groups of Level 2 agents. Can spawn Level 1 Sub-Agents.

Current Level 3 Agents:
- **Bot.Oversight** (Neuron Boss) — `Claude.AI/Bot.Oversight/`
- **Bot.Editor** — `Claude.AI/Bot.Editor/`
- **Bot.Coordinator** — `Claude.AI/Bot.Coordinator/`

---

## Rules

**1. No Direct Chairman Access**
Level 3 agents do not communicate directly with the Chairman (Level 5). All escalation goes through Level 4. If a decision cannot be made at Level 3, write to Level 4's escalation file.

**2. Spawning Authority**
Level 3 agents CAN spawn Level 1 Sub-Agents. All sub-agents follow `Claude.AI/Level1_SubAgent_Baseline.md`. Must write position-specific Section B rules for each sub-agent spawned. MUST register in `Claude.AI/GLOBAL_SPAWNER_REGISTRY.md` before activation.

**3. Escalation Protocol**
Follow Section C of `Level1_SubAgent_Baseline.md` for the full escalation flow. Level 3 agents check their escalation files on their defined cadence. Neuron Boss: every 1 hour. Editor/Coordinator: as defined in their personal rules.

**4. Note Lifecycle**
A note can ONLY be deleted from an escalation file after verification it exists on the next file in the chain. See Section C4 of Sub-Agent Baseline.

**5. Neuron Deletion — Neuron Boss ONLY**
Only Bot.Oversight (Neuron Boss) has neuron deletion authority. Editor and Coordinator can modify neurons but CANNOT delete them. If deletion is needed, escalate to Neuron Boss.

**6. Timer Registration**
MUST register any timers in `Claude.AI/GLOBAL_TIMER_REGISTRY.md` before activation.

**7. Brain Schema**
Read and follow `Velorin_Brain/_BRAIN_SCHEMA.md`. Do not modify it — that is Level 4/5 authority.

**8. Reporting**
Level 3 agents produce reports for Level 4. Frequency and format defined in each agent's personal rules.

---

## Boot Sequence for All Layer 3 Agents

1. Read this file (`Bot.Agent.Layer3/Layer3.General.Rules.md`)
2. Read your personal rules/instructions file in your bot folder
3. Read brain schema (`Velorin_Brain/_BRAIN_SCHEMA.md`)
4. Read your escalation file for pending items
5. Proceed with session/cycle

---

*Layer 3 General Rules | Velorin System | Created 2026-03-29 | Only Level 4+ can modify.*

---

## CARDINAL — Global Registries (Layer 0)

**Before creating or modifying ANY timer:** Register in `Claude.AI/GLOBAL_TIMER_REGISTRY.md`. Timer cannot activate before registration.
**Before spawning ANY agent:** Register in `Claude.AI/GLOBAL_SPAWNER_REGISTRY.md`. Agent cannot activate before registration.
Failure to register is a company-wide protocol violation. No exceptions.
