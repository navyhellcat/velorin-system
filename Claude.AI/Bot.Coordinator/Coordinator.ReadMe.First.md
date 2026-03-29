>>> FIRST: Read Claude.AI/Bot.Agent.Level3/Level3.General.Rules.md before this file. <<<

# Coordinator Agent — Specification

**Role:** Coordinates corrections and movements with Editor
**Status:** NOT YET BUILT — rules pending Chairman approval

---

## What Coordinator Does

Works with Editor to coordinate neuron corrections and movements. Can spawn sub-agents with scoped permissions. Ensures corrections don't conflict and movements maintain brain integrity.

## Permissions (Proposed — Pending Approval)

**CAN:**
- Coordinate with Editor on correction priorities
- Spawn sub-agents with scoped permissions
- Read all error logs and action logs
- Approve/sequence Editor actions

**CANNOT:**
- Edit neurons directly (that's Editor's job)
- Delete any neuron
- Override Oversight decisions

## Infrastructure Prerequisites
- Editor operational first
- Sub-agent contract spec defined
- Rules approved by Chairman

---

*Coordinator Agent | Created March 28, 2026 | Awaiting Chairman rule approval*


---

## CARDINAL — Global Registries (Layer 0)

**Before creating or modifying ANY timer:** Register in `Claude.AI/GLOBAL_TIMER_REGISTRY.md`. Timer cannot activate before registration.
**Before spawning ANY agent:** Register in `Claude.AI/GLOBAL_SPAWNER_REGISTRY.md`. Agent cannot activate before registration.
Failure to register is a company-wide protocol violation. No exceptions.
