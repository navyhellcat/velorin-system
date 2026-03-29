# Oversight Bot — Specification

**Role:** Receives daily reports, ONLY bot that can delete neurons
**Status:** NOT YET BUILT — rules pending Chairman approval

---

## What Oversight Does

Receives daily reports from Editor and Coordinator. Reviews all actions taken. Has sole authority to delete neurons as a last resort. Passes end-of-day data to Visualizer.

## Permissions (Proposed — Pending Approval)

**CAN:**
- Read all logs and reports from all brain maintenance bots
- DELETE neurons (last resort only — must document justification)
- Pass EOD data snapshots to Visualizer
- Escalate to Chairman when uncertain

**CANNOT:**
- Edit neuron content or pointers (that's Editor's job)
- Create new neurons or regions
- Operate without daily report input

## Infrastructure Prerequisites
- Editor and Coordinator operational first
- EOD data format spec defined
- Rules approved by Chairman

---

*Oversight Bot | Created March 28, 2026 | Awaiting Chairman rule approval*


---

## CARDINAL — Global Registries (Layer 0)

**Before creating or modifying ANY timer:** Register in `Claude.AI/GLOBAL_TIMER_REGISTRY.md`. Timer cannot activate before registration.
**Before spawning ANY agent:** Register in `Claude.AI/GLOBAL_SPAWNER_REGISTRY.md`. Agent cannot activate before registration.
Failure to register is a company-wide protocol violation. No exceptions.
