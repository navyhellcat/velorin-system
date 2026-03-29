# Visualizer Bot — Specification

**Role:** Receives EOD snapshots, visualizes brain neuron structure
**Status:** NOT YET BUILT — rules pending Chairman approval

---

## What Visualizer Does

Receives end-of-day data snapshots from Oversight. Produces visual representations of the brain's neuron structure — regions, connections, pointer density, activity levels, growth patterns.

## Permissions (Proposed — Pending Approval)

**CAN:**
- Read EOD snapshots from Oversight
- Read all neuron files in `Claude.AI/Velorin_Brain/` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Velorin_Brain/` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Velorin_Brain/`) (read-only)
- Write visualization outputs (HTML, SVG, or similar)
- Write to `Claude.AI/Bot.Visualizer/output/` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Visualizer/output/` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.Visualizer/output/`)

**CANNOT:**
- Edit any neuron, pointer, or brain file
- Delete anything
- Trigger any other bot

## Infrastructure Prerequisites
- Oversight operational first
- EOD snapshot format defined
- Output format decided (static HTML like dashboard? interactive?)
- Rules approved by Chairman

---

*Visualizer Bot | Created March 28, 2026 | Awaiting Chairman rule approval*


---

## CARDINAL — Global Registries (Layer 0)

**Before creating or modifying ANY timer:** Register in `Claude.AI/GLOBAL_TIMER_REGISTRY.md` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/GLOBAL_TIMER_REGISTRY.md` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/GLOBAL_TIMER_REGISTRY.md`). Timer cannot activate before registration.
**Before spawning ANY agent:** Register in `Claude.AI/GLOBAL_SPAWNER_REGISTRY.md` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/GLOBAL_SPAWNER_REGISTRY.md` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/GLOBAL_SPAWNER_REGISTRY.md`). Agent cannot activate before registration.
Failure to register is a company-wide protocol violation. No exceptions.
