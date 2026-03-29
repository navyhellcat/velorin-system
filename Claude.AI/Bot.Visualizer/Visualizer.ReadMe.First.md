# Visualizer Bot — Specification

**Role:** Receives EOD snapshots, visualizes brain neuron structure
**Status:** NOT YET BUILT — rules pending Chairman approval

---

## What Visualizer Does

Receives end-of-day data snapshots from Oversight. Produces visual representations of the brain's neuron structure — regions, connections, pointer density, activity levels, growth patterns.

## Permissions (Proposed — Pending Approval)

**CAN:**
- Read EOD snapshots from Oversight
- Read all neuron files in `Velorin_Brain/` (read-only)
- Write visualization outputs (HTML, SVG, or similar)
- Write to `BOT.Visualizer/output/`

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
