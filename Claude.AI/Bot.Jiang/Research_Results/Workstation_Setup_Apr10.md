# Supplementary Current Hardware Setup
**Documented:** April 10, 2026 | Session — Jiang (Browser) + Christian Taylor
**Replaces:** Workstation_Setup_Apr3.md
**Status:** FULLY OPERATIONAL as of April 10, 2026

---

## MACHINES

### Machine 1 — MacBook Air 2017 (Clamshell node)
```
make: Apple
model: MacBook Air 13-inch (Mid 2017)
model_id: MacBookAir7,2
cpu: Intel Core i5 dual-core 1.8GHz (Broadwell, 5350U)
ram: 8GB LPDDR3 1600MHz (soldered, not upgradeable)
storage: 250GB SSD (105GB free as of April 2026)
gpu: Intel HD Graphics 6000 (1536MB shared — no local AI inference)
os: macOS Monterey
ports:
  - USB-A 3.0 x2 (5Gbps max)
  - Thunderbolt 2 x1 (Mini DisplayPort form factor, 20Gbps)
  - MagSafe 2 x1
  - SDXC card slot x1
  - 3.5mm headphone jack x1
power: 45W MagSafe 2 adapter (REQUIRED for clamshell — must stay plugged in or machine sleeps)
role: Clamshell SSH node — Claude Code / Velorin / Turing Vault terminal work
lid_state: CLOSED (clamshell)
display_out: Thunderbolt 2 → HDMI → Monitor 3 (HP)
network: USB-A → Amazon Basics USB-A to Gigabit Ethernet adapter → Cat6a → TRENDnet switch
wifi: DISABLED
ethernet_driver: ASIX AX88179 DEXT v2.0.0 required for Monterey
  download: https://plugable.s3.amazonaws.com/bin/AX88179/ASIX_AX88179_DEXT_v2.0.0.zip
  note: Without driver, adapter does not appear in Network settings on Monterey
  install: Download via Chrome (Safari download broken), drag to Applications
notes:
  - Retire when Machine 2 purchased
  - Wired ethernet ~25x faster than WiFi on this hardware
  - FileVault: if on, requires manual login after reboot before processes start
```

### Machine 2 — Mac Studio M4 Max (PRIMARY — arrived April 7)
```
make: Apple
model: Mac Studio (Early 2025)
chip: Apple M4 Max
cpu: 14-core (10 performance + 4 efficiency)
gpu: 32-core
neural_engine: 16-core
ram: 36GB unified memory (SOLDERED — permanent ceiling, not upgradeable)
storage: 512GB SSD internal
memory_bandwidth: 410GB/s
os: macOS Sequoia
ports_rear:
  - Thunderbolt 5 x3 (USB-C form factor, 120Gbps)
  - USB-A 3.2 x2 (10Gbps)
  - HDMI 2.1 x1
  - 10GbE ethernet x1 (built-in — connects to TRENDnet switch)
  - 3.5mm audio jack x1
ports_front:
  - Thunderbolt 4 x2 (USB-C form factor, 40Gbps)
  - USB-A 3.2 x1 (10Gbps)
  - SDXC card slot x1 (UHS-II)
power: proprietary power brick (does NOT charge via USB-C)
role: Primary workstation — Velorin build, Claude Desktop, MCP, local AI inference
display_out:
  - Monitor 1: Thunderbolt 5 rear → USB-C to DisplayPort → Lenovo P27h-30
  - Monitor 2: HDMI rear → HDMI cable → Dell PH2422 (direct)
network: 10GbE built-in → Cat6a → TRENDnet TEG-S750 switch
wifi: DISABLED
local_ai:
  - 14B models: comfortable
  - 30B models at Q4: functional
  - 70B models: NOT viable at 36GB
thermal_baseline:
  cpu_idle: ~104°F (~40°C) — normal
  efficiency_cores_idle: ~91°F (~33°C) — normal
  fan_idle: 27% — normal
  monitoring: Stats app (mac-stats.com / brew install stats)
dust_filter:
  stand: iFCase desktop dust filter stand for Mac Studio M4 Max/Ultra
  additional: MERV 8 filter media pad cut to size, seated under iFCase
  purpose: All intake air passes through MERV 8 before reaching iFCase filters
  note: Monitor temps under sustained load to confirm no thermal restriction
purchased: April 4, 2026
payment: $1,300 Apple Card installments (0% APR, 12mo) + $898.90 Affirm (35% APR)
```

### Machine 3 — Work Laptop (Lenovo, Windows, work-issued)
```
os: Windows
ports:
  - Native ethernet port (RJ45) — ACTIVE → Cat6a → TRENDnet switch
  - USB-C x1 → Lenovo P27h-30 USB-C input (display + 15W PD charging)
  - USB-C x1 → Acer hub (3x USB-A expansion — ethernet not used, native port used instead)
role: Work / browser / YouTube / Google / browser AI tools
display: Lenovo P27h-30 (input switching with Mac Studio)
network: Native ethernet → Cat6a → TRENDnet switch
wifi: DISABLED
dedicated_screen: none currently — future addition
note: Acer hub present for USB-A expansion only — ethernet runs from native port
```

---

## MONITORS

### Monitor 1 — Lenovo ThinkVision P27h-30 (PRIMARY)
```
make: Lenovo
model: ThinkVision P27h-30
size: 27 inch
resolution: 2560x1440 (QHD)
refresh: 60Hz
panel: IPS
position: LEFT

active_input: USB-C (Mac Studio via USB-C to DP cable)
PBP: OFF
current_mode: Single full screen — Mac Studio primary display

DAISY CHAIN — PERMANENTLY ABANDONED:
  Macs do NOT support DisplayPort MST daisy-chaining.
  DP out on P27h-30 requires MST-capable source.
  Apple supports Thunderbolt daisy-chain only, not DP MST.
  Do not attempt again with any Mac source.
```

### Monitor 2 — Dell PH2422 (SECONDARY)
```
make: Dell
model: PH2422
resolution: 1920x1080
position: RIGHT of Monitor 1
current_source: Mac Studio HDMI rear → HDMI cable → Dell HDMI in (DIRECT — working)
```

### Monitor 3 — HP (TERTIARY)
```
make: HP
model: Unknown
position: FAR RIGHT
current_source: MacBook Air Thunderbolt 2 → HDMI → HP HDMI in (clamshell display)
status: ACTIVE
```

---

## NETWORKING — FULLY OPERATIONAL

```
architecture:
  Nighthawk RAX42v2 (living room WiFi) 
    → GL.iNet Beryl AX (repeater, WiFi output DISABLED)
      → TRENDnet TEG-S750 switch
        → Mac Studio (10GbE)
        → MacBook Air (USB-A ethernet adapter, 1G)
        → Work laptop (native ethernet, 1G)

vpn: Mullvad WireGuard — router level, all devices behind VPN
wifi_status: ALL MACHINES WiFi DISABLED — wired only
gl_inet_wifi_output: DISABLED (radios off at 192.168.8.1)
```

### GL.iNet Beryl AX (GL-MT3000)
```
mode: Repeater — receives 5G_VELORIN_OFFICE, no WiFi broadcast
vpn: Mullvad WireGuard
wifi_output: DISABLED
wan_port: 2.5G (future hardwire input)
lan_port: 1G → TRENDnet switch
```

### TRENDnet TEG-S750
```
type: 5-port multi-gig unmanaged switch
design: Fanless
port_1: GL.iNet LAN (1G)
port_2: Mac Studio 10GbE (10G)
port_3: MacBook Air via USB-A adapter (1G)
port_4: Work laptop native ethernet (1G)
port_5: SPARE — reserved for Machine 2
```

---

## POWER

```
layout:
  outlet_1 (main corner outlet):
    - GE wall multiplier
      - Lamp
      - Mini fridge: REMOVED — now on dedicated extension cord
      - Work laptop charger
      - Strip 1:
          - MacBook Air MagSafe charger
          - Monitor 3 (HP)
          - Printer
          - Strip 2: REMOVED — daisy chain eliminated

  outlet_2 (far wall — 14AWG 15A extension cord run along baseboard):
    - Surge strip:
        - Mac Studio
        - Monitor 1 (Lenovo P27h-30)
        - Monitor 2 (Dell PH2422)
        - Electric desk

  outlet_3 (closer empty L-desk side — 14AWG 15A extension cord):
    - Mini fridge ONLY

safety_notes:
  - Daisy-chained strips eliminated
  - Mini fridge on dedicated circuit
  - Mac Studio on dedicated strip from separate outlet
  - 14AWG 15A Utilitech extension cords used for both runs
```

---

## CABLES — ACTIVE

```
display:
  D1: Mac Studio TB5 → USB-C to DisplayPort → P27h-30 (Monitor 1)
  D2: Mac Studio HDMI → HDMI → Dell PH2422 (Monitor 2, direct)
  D3: MacBook Air TB2 → Thunderbolt 2 to HDMI → HP (Monitor 3, clamshell)

network (Monoprice Cat6a SlimRun, 7ft, UTP 30AWG):
  N1: Beryl AX LAN → TRENDnet switch
  N2: TRENDnet switch → Mac Studio 10GbE
  N3: TRENDnet switch → Amazon Basics USB-A adapter → MacBook Air
  N4: TRENDnet switch → Work laptop native ethernet port
```

---

## ADAPTERS

```
adapter_1:
  make: Amazon Basics
  type: USB-A 3.0 to Gigabit Ethernet
  connects: MacBook Air USB-A → TRENDnet switch
  driver: ASIX AX88179 DEXT v2.0.0 (required for Monterey)
  max_speed: 1Gbps

adapter_2:
  make: Acer
  type: USB-C hub (1Gbps ethernet + 3x USB-A 3.0)
  current_use: USB-A expansion only (work laptop native ethernet used instead)
```

---

## CORRECTIONS LOG

```
correction_1:
  claim: Daisy chain works via USB-C to DP from Mac Studio
  reality: Macs do not support DisplayPort MST
  fix: HDMI direct from Mac Studio to Monitor 2
  status: RESOLVED

correction_2:
  claim: USB-A ethernet adapter shows in Network settings on Monterey automatically
  reality: ASIX chipset requires driver install
  fix: ASIX AX88179 DEXT v2.0.0
  status: RESOLVED

correction_3:
  claim: Work laptop needed Acer hub for ethernet
  reality: Work laptop has native ethernet port
  fix: Direct Cat6a from native port to switch
  status: RESOLVED
```

---

## FUTURE HARDWARE

```
machine_2_candidates:
  - Lenovo ThinkStation PGX (GB10 Grace Blackwell, 128GB, ~$4,300)
    blocker: Claude Code crashes on ARM64 — GitHub issue open April 2026
    revisit: When Anthropic resolves ARM64 Claude Code bug
  - Switch port 5 reserved for second Mac Studio at 10G

ram_buy_now:
  spec: DDR5-6000 CL30 2x32GB (G.Skill Trident Z5 Neo RGB)
  reason: Memory prices rising per Tim Cook Q1 2026 earnings
  price: ~$150-200
  action: BUY NOW — store for Machine 2

external_ssd:
  type: Thunderbolt 5 external NVMe
  purpose: Storage expansion for Mac Studio
  timing: Soon — 512GB fills fast with models
  price: ~$150-300

network_upgrade_path:
  trigger: Replace MacBook Air with second Mac Studio
  action: Both Macs at 10G, switch port 5 reserved
  router: Upgrade to WiFi 7 → then upgrade Beryl AX to Beryl 7
```

---

## DESK ORGANIZATION (PENDING)

```
- Under-desk cable management tray ~$25
- Velcro ONE-WRAP cable ties ~$8
- Adhesive cable clips ~$8
- Surge protector (6-8 outlet) ~$30
- Laptop vertical stand for MacBook Air ~$15
- Cable sleeve ~$10
- Cable labels ~$15
```

---
*Workstation_Setup_Apr10.md | Velorin System | April 10, 2026*
*Source: Browser session — Christian Taylor + Jiang*
*Supersedes: Workstation_Setup_Apr3.md*
