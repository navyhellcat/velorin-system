# Bot.Custodian.Neuron — Specification

**Role:** Always-on neuron layer scanner — rule compliance checker
**Status:** NOT YET BUILT — rules pending Chairman approval
**Naming:** bot.Custodian.neuron

---

## What Custodian Does

Continuously scans the neuron layer. Checks each neuron against brain rules (generality, size, pointer limits, duplicates). Creates structured correction entries when violations are found.

## Permissions (Proposed — Pending Approval)

**CAN:**
- Read all neurons in `Velorin_Brain/`
- Edit outward pointers on neurons when they:
  - Point to incorrect neurons
  - Don't have enough pointers (insufficient connections)
  - Need to add new pointers to point to hard memories
  - Need to replace existing pointers to point to hard memories instead of neurons
- Write error logs to `BOT.Custodian/error_log/` with exact locations and timestamps

**CANNOT:**
- Edit neuron content (only pointers)
- Delete any neuron
- Create new neurons
- Create new brain regions
- Operate outside `Velorin_Brain/` directory

## Error Log Schema

```
TIMESTAMP | NEURON_PATH | VIOLATION_TYPE | SEVERITY | POINTER_AFFECTED | ACTION_TAKEN
```

Violation types: `INCORRECT_POINTER`, `MISSING_POINTER`, `NEURON_NOT_HARD_MEMORY`, `OVERSIZED`, `DUPLICATE`, `MISSING_INDEX_ENTRY`

## Infrastructure Prerequisites
- Timestamps on every neuron (last-touched)
- Error log folder created
- Rules approved by Chairman

---

*Bot.Custodian.Neuron | Created March 28, 2026 | Awaiting Chairman rule approval*


---

## CARDINAL — Global Registries (Layer 0)

**Before creating or modifying ANY timer:** Register in `Claude.AI/GLOBAL_TIMER_REGISTRY.md`. Timer cannot activate before registration.
**Before spawning ANY agent:** Register in `Claude.AI/GLOBAL_SPAWNER_REGISTRY.md`. Agent cannot activate before registration.
Failure to register is a company-wide protocol violation. No exceptions.
