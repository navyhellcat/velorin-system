>>> FIRST: Read Claude.AI/Bot.Agent.Layer3/Layer3.General.Rules.md before this file. <<<

# Neuron Editor Agent — Specification

**Role:** Receives errors from Custodian and Mobility, edits neurons
**Status:** NOT YET BUILT — rules pending Chairman approval

---

## What Editor Does

Receives error logs from Bot.Custodian and Bot.Mobility. Has authority to edit neuron content and pointers within defined constraints. Works in tandem with Coordinator. Can spawn sub-agents with scoped permissions.

## Permissions (Proposed — Pending Approval)

**CAN:**
- Edit neuron content
- Edit neuron pointers
- Spawn sub-agents with scoped permissions (sub-agents can ONLY do what Editor assigns)
- Read error logs from Custodian and Mobility
- Write action logs

**CANNOT:**
- Delete any neuron
- Create new brain regions
- Override Coordinator decisions
- Operate autonomously — works in tandem with Coordinator

## Infrastructure Prerequisites
- Custodian and Mobility operational first
- Sub-agent contract spec defined
- Rules approved by Chairman

---

*Neuron Editor Agent | Created March 28, 2026 | Awaiting Chairman rule approval*


---

## CARDINAL — Global Registries (Layer 0)

**Before creating or modifying ANY timer:** Register in `Claude.AI/GLOBAL_TIMER_REGISTRY.md`. Timer cannot activate before registration.
**Before spawning ANY agent:** Register in `Claude.AI/GLOBAL_SPAWNER_REGISTRY.md`. Agent cannot activate before registration.
Failure to register is a company-wide protocol violation. No exceptions.
