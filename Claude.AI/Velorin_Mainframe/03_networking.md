# SECTION 3 — NETWORKING

**Purpose:** Connect Machine 1 and Machine 2 on a fast local network so they can communicate for orchestration, file access, and API calls. Also connect both machines to internet.

---

## Core Requirement

Machine 1 (Mac mini) needs to send API calls to Machine 2 (where Ollama runs local models) with minimal latency. Machine 2 also stores files that Machine 1 may need to access. The faster the local network, the less friction in the architecture.

**Target:** 10 Gigabit Ethernet between both machines. This is ~10x faster than standard Gigabit and eliminates the network as a bottleneck for any foreseeable local transfer.

---

## Network Switch

**Recommended:** QNAP QSW-308-1C or NETGEAR XS508M
**Speed:** 10GbE ports (minimum 2x 10GbE for the two machines) + Gigabit ports for other home devices
**Price:** ~$150–250

**Why a dedicated switch:** A standard home router typically has Gigabit (1GbE) ports only. Even if both machines have 10GbE NICs, they need a switch with 10GbE ports between them to achieve 10GbE throughput. The switch connects both machines to each other at 10GbE and connects the switch itself to the router at Gigabit for internet.

**Budget path:** If 10GbE switch cost is a barrier at initial build, use standard Gigabit initially (1GbE is already on all existing home routers) and upgrade the switch later. The build still functions — it just transfers files slightly slower between machines.

---

## Ethernet Cables

**Spec:** Cat6a (supports 10GbE at full length)
**Quantity:** 2 runs minimum (one per machine to the switch)
**Price:** ~$15–25 per cable depending on length

Cat5e supports 10GbE only up to ~45 meters and is less reliable at sustained 10GbE. Cat6a is the correct spec for a permanent install.

---

## NIC Status per Machine

**Machine 1 (Mac mini M4):** 10GbE port is available as a configuration upgrade at purchase time. Selecting this at checkout eliminates need for an external NIC.

**Machine 2 (Custom PC):** The ASUS ProArt X870E-Creator has 10GbE onboard. No separate NIC needed.

If using the MSI MPG X670E Carbon WiFi (budget motherboard), add:
- Intel I225-V or Mellanox ConnectX-3 10GbE NIC (~$60–80)
- Installs into a PCIe x4 slot on the motherboard

---

## Router

**Existing router:** Keep in place for internet connectivity. The switch sits between the router and both machines. No router replacement needed unless current router is failing or extremely old.

If upgrading later: Any modern Wi-Fi 6E or Wi-Fi 7 router with a Gigabit WAN port handles the internet connection. The machine-to-machine 10GbE traffic never touches the router — it stays on the switch.

---

## Cable Routing

Two options:
1. **Surface routing:** Cable raceways along baseboards. No wall work. Reversible. Takes one afternoon.
2. **In-wall:** Permanent, clean. Requires running cable through walls, wall plates, and punch-down keystone jacks. Better long-term result.

For an initial build, surface routing is faster and fully functional. In-wall is the right upgrade if the setup becomes permanent.

---

## Machine-to-Machine Communication Protocol

See Section 11 — Machine-to-Machine Connectivity for how Machine 1 actually calls Machine 2's services over this network.

---

## Summary — What to Buy

| Item | Spec | Price |
|---|---|---|
| Network switch | QNAP QSW-308-1C (10GbE) | ~$200 |
| Cat6a cables | 2x runs, measure length needed | ~$30–50 total |
| NIC (only if budget mobo) | Intel I225-V or Mellanox ConnectX | ~$60–80 |
