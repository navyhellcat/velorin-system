# SECTION 1 — MACHINE 1: MAC MINI (COCKPIT)

**Purpose:** Daily workstation. Runs Claude Desktop, MCP tools, browser, terminals, Cursor IDE. Does NOT run local AI models — that is Machine 2's job. This machine calls Claude via API only.

---

## Mac Mini — Recommended Configuration

**Model:** Mac mini M4
**Chip:** Apple M4 — 10-core CPU, 10-core GPU, 16-core Neural Engine
**RAM:** 24GB unified memory
**Storage:** 256GB SSD internal (external Thunderbolt storage added later as needed)
**Network:** 10 Gigabit Ethernet (upgrade from base Gigabit — critical for fast local communication with Machine 2)
**Price:** ~$999 (24GB / 256GB with 10GbE upgrade)

**Why 24GB and not 16GB:** Running Claude Desktop + MCP tools + Cursor + Chrome with multiple tabs + Node.js processes simultaneously creates real memory pressure. 16GB is functional but tight. 24GB eliminates that ceiling. Memory cannot be upgraded after purchase.

**Why not the $5,198 M4 Pro config:** That machine is built for running 70B local models on the Mac itself. In this architecture, local model inference runs on Machine 2. The M4 Pro is solving a problem assigned to a different machine.

**Why not a cheaper Mac mini:** The 10GbE network port is only available as an upgrade and requires the 24GB configuration minimum. 10GbE is important for fast communication between Machine 1 and Machine 2 over local network.

---

## Display Output

Mac mini M4 supports up to 3 external displays simultaneously:
- 1x via HDMI 2.1 (rear)
- 2x via Thunderbolt 4 (rear)

This machine drives 2 monitors. No adapters needed if monitors accept HDMI or USB-C/DisplayPort.

---

## Accessories Required

| Item | Spec | Notes |
|---|---|---|
| Thunderbolt dock | CalDigit TS4 or OWC Thunderbolt 4 Hub | Port expansion for peripherals, additional display output |
| Monitor cables x2 | HDMI or USB-C to DisplayPort | Match to existing monitor inputs |
| External SSD (optional, later) | USB-C / Thunderbolt NVMe enclosure | Add if 256GB internal fills up |

---

## Power

Idle: ~3-4W. Full load: ~40-45W. Runs silent at all times. Safe to leave on 24/7. Annual electricity cost at heavy daily use: ~$20-25.

---

## What Gets Installed on This Machine

See Section 6 — Software Machine 1.
