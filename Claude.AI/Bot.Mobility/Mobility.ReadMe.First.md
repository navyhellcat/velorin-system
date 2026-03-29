# Bot.Mobility.Neuron — Specification

**Role:** Always-on neuron position and activity scanner
**Status:** NOT YET BUILT — rules pending Chairman approval
**Naming:** bot.Mobility.neuron

---

## What Mobility Does

Continuously scans the neuron layer. Flags neurons that may be in the wrong position (wrong region) or neurons that have never been fired (no last-touched timestamp or stale timestamp). Reports to higher-level agents.

## Permissions (Proposed — Pending Approval)

**CAN:**
- Read all neurons in `Velorin_Brain/`
- Read timestamps on all neurons
- Write reports to `BOT.Mobility/reports/`
- Flag neurons for Editor/Coordinator review

**CANNOT:**
- Edit any neuron (content or pointers)
- Delete any neuron
- Move any neuron
- Create new neurons or regions

## Report Schema

```
TIMESTAMP | NEURON_PATH | FLAG_TYPE | DETAILS | RECOMMENDED_ACTION
```

Flag types: `WRONG_REGION`, `NEVER_FIRED`, `STALE` (last-touched > X days), `ORPHANED` (no inbound pointers)

## Infrastructure Prerequisites
- Timestamps on every neuron (last-touched) — REQUIRED
- Report folder created
- Rules approved by Chairman

---

*Bot.Mobility.Neuron | Created March 28, 2026 | Awaiting Chairman rule approval*


---

## CARDINAL — Global Registries (Layer 0)

**Before creating or modifying ANY timer:** Register in `Claude.AI/GLOBAL_TIMER_REGISTRY.md`. Timer cannot activate before registration.
**Before spawning ANY agent:** Register in `Claude.AI/GLOBAL_SPAWNER_REGISTRY.md`. Agent cannot activate before registration.
Failure to register is a company-wide protocol violation. No exceptions.
