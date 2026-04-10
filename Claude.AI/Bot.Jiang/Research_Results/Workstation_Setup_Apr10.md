# Supplementary Current Hardware Setup
**Documented:** April 10, 2026 | Session — Jiang (Browser) + Christian Taylor
**Replaces:** Workstation_Setup_Apr3.md
**Status:** Current — Mac Studio arrived April 7, all decisions finalized

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
ethernet_driver: ASIX AX88179 DEXT v2.0.0 required for Monterey
  download: https://plugable.s3.amazonaws.com/bin/AX88179/ASIX_AX88179_DEXT_v2.0.0.zip
  note: Without driver, adapter does not appear in Network settings on Monterey
notes:
  - Retire when Machine 2 purchased
  - Wired ethernet ~25x faster than WiFi on this hardware
  - FileVault: check status — if on, machine requires manual login after reboot before processes start
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
  - Monitor 1: Thunderbolt 5 rear → USB-C to DisplayPort cable → Lenovo P27h-30 (USB-C/DP input)
  - Monitor 2: HDMI rear → HDMI cable → Monitor 2 (direct — daisy chain not used)
network: 10GbE built-in → Cat6a → TRENDnet TEG-S750 switch
local_ai:
  - 14B models: comfortable
  - 30B models at Q4: functional
  - 70B models: NOT viable at 36GB
purchased: April 4, 2026
payment: $1,300 Apple Card installments (0% APR, 12mo) + $898.90 Affirm (35% APR)
```

### Machine 3 — Work Laptop (Lenovo, Windows, work-issued)
```
os: Windows
ports_in_use:
  - USB-C x1 → Acer USB-C Hub (ethernet + 3x USB-A) → Cat6a → TRENDnet switch
  - USB-C x1 → Lenovo P27h-30 USB-C input (display + 15W PD charging)
role: Work / browser / YouTube / Google / browser AI tools
display: Lenovo P27h-30 — currently sharing with Mac Studio via input switching
network: USB-C → Acer hub → Cat6a → TRENDnet switch
dedicated_screen: none currently — future addition
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

ports:
  in:
    - USB-C (active: Mac Studio via USB-C to DP cable)
    - DisplayPort 1.4 in (unused)
    - HDMI (unused)
  out:
    - DisplayPort out — INACTIVE and NOT USED
    - USB-A 3.2 x3 (hub)
    - USB-B upstream x1

current_mode: Single full screen — Mac Studio primary display
PBP: OFF

DAISY CHAIN STATUS — ABANDONED:
  Mac computers do NOT support DisplayPort MST daisy-chaining.
  The P27h-30 DP out requires an MST-capable source.
  Apple only supports Thunderbolt daisy-chaining, not DP MST.
  Monitor 2 is now connected directly via HDMI from Mac Studio.
  Do not attempt daisy chain again with any Mac source.
```

### Monitor 2 — Unknown brand (SECONDARY)
```
position: RIGHT of Monitor 1
current_source: Mac Studio HDMI out → HDMI cable → Monitor 2 HDMI in (DIRECT — working)
previous_attempts:
  - Daisy chain via P27h-30 DP out — FAILED (Mac does not support DP MST)
  - Work laptop via 40ft HDMI direct — was working pre-Mac Studio
```

### Monitor 3 — HP (TERTIARY)
```
position: FAR RIGHT
current_source: MacBook Air Thunderbolt 2 → HDMI → HP HDMI in (clamshell display)
status: ACTIVE
```

---

## NETWORKING

### Device 1 — GL.iNet Beryl AX (GL-MT3000)
```
make: GL.iNet
model: Beryl AX (GL-MT3000)
wifi: WiFi 6 (AX3000)
ports:
  - WAN: 2.5G ethernet (future hardwire input)
  - LAN: 1G ethernet → Cat6a → TRENDnet switch
mode: Repeater (receives 5G_VELORIN_OFFICE WiFi, distributes via LAN)
vpn: Mullvad (WireGuard) — configured at router level, all devices behind VPN
  note: Monitor for interference with Claude API / Anthropic services
  note: Work laptop may need per-device VPN bypass for corporate access
wifi_output: DISABLED (both 2.4GHz and 5GHz radios turned off in OSD at 192.168.8.1)
home_router: Netgear Nighthawk RAX42v2 (WiFi 6, AX4200)
beryl7_upgrade: Deferred until home router upgraded to WiFi 7
```

### Device 2 — TRENDnet TEG-S750
```
make: TRENDnet
model: TEG-S750
type: 5-port multi-gig unmanaged switch
design: Fanless (intentional — silent, no dust accumulation)
ports:
  1: GL.iNet Beryl AX LAN out (1G)
  2: Mac Studio 10GbE (10G full speed)
  3: MacBook Air via USB-A ethernet adapter (1G ceiling)
  4: Work laptop via Acer USB-C hub (1G ceiling)
  5: SPARE — reserved for Machine 2 (second Mac Studio at 10G)
```

---

## CABLES — ACTIVE

```
display:
  D1: Mac Studio TB5 rear → USB-C to DisplayPort → P27h-30 USB-C in (Monitor 1)
  D2: Mac Studio HDMI rear → HDMI cable → Monitor 2 HDMI in (direct)
  D3: MacBook Air TB2 → Thunderbolt 2 to HDMI → HP Monitor 3 (clamshell)

network (Monoprice Cat6a SlimRun, 7ft, 10-pack, UTP 30AWG):
  N1: Beryl AX LAN → TRENDnet switch
  N2: TRENDnet switch → Mac Studio 10GbE
  N3: TRENDnet switch → Amazon Basics USB-A ethernet adapter → MacBook Air
  N4: TRENDnet switch → Acer USB-C hub → Work laptop
```

---

## ADAPTERS

```
adapter_1:
  make: Amazon Basics
  type: USB-A 3.0 to Gigabit Ethernet
  connects: MacBook Air USB-A → TRENDnet switch
  driver_required: YES — ASIX AX88179 DEXT v2.0.0 for Monterey
  max_speed: 1Gbps

adapter_2:
  make: Acer
  type: USB-C hub (1Gbps ethernet + 3x USB-A 3.0)
  connects: Work laptop USB-C → TRENDnet switch
  max_speed: 1Gbps ethernet
```

---

## KNOWN ISSUES AND CORRECTIONS

```
correction_1:
  claim: Daisy chain would work via USB-C to DP cable from Mac Studio
  reality: Macs do not support DisplayPort MST — DP out on P27h-30 is greyed out
  and non-functional with any Mac source
  fix: HDMI direct from Mac Studio to Monitor 2
  status: RESOLVED

correction_2:
  claim: Amazon Basics USB-A ethernet adapter would show up in Network settings on Monterey
  reality: ASIX chipset requires driver install on Monterey — does not appear without it
  fix: Install ASIX AX88179 DEXT v2.0.0 from plugable S3 link
  status: RESOLVED

limitation_1:
  MacBook Air 36GB unified memory: permanent ceiling
  MacBook Air USB-A 3.0: max 1Gbps ethernet regardless of switch
  Work laptop USB-C ethernet via hub: max 1Gbps
  Beryl AX LAN port: max 1G output (WiFi 6 internet is bottleneck anyway)
  Mac Studio 36GB: 14B comfortable, 30B Q4 functional, 70B not viable
  MacBook Air clamshell: MagSafe 2 must remain plugged in
  Mullvad VPN: may interfere with some cloud services — toggle off to test
```

---

## FUTURE HARDWARE

```
machine_2_candidates:
  - Lenovo ThinkStation PGX (GB10 Grace Blackwell, 128GB, ~$4,300)
    blocker: Claude Code crashes on ARM64 — GitHub issue open as of April 2026
    revisit: When Anthropic resolves ARM64 Claude Code bug
  - Switch port 5 reserved for second Mac Studio at 10G

ram_buy_now:
  spec: DDR5-6000 CL30 2x32GB (G.Skill Trident Z5 Neo RGB)
  reason: Memory prices rising per Tim Cook Q1 2026 earnings
  price: ~$150-200
  action: BUY NOW — store for Machine 2 Windows build

external_ssd:
  type: Thunderbolt 5 external NVMe
  purpose: Storage expansion for Mac Studio
  timing: Soon — 512GB internal fills fast with models
  price: ~$150-300

network_upgrade_path:
  trigger: Replace MacBook Air with second Mac Studio
  action: Both Macs at 10G via TRENDnet switch (port 5 already reserved)
  router: Upgrade Nighthawk RAX42v2 to WiFi 7 → then upgrade Beryl AX to Beryl 7
```

---

## DESK ORGANIZATION (PENDING PURCHASE)

```
- Under-desk cable management tray (metal, screw-mount) ~$25
- Velcro ONE-WRAP cable ties (reusable) ~$8
- Adhesive cable clips ~$8
- Surge protector (6-8 outlet + USB, mount under desk) ~$30
- Laptop vertical stand for MacBook Air clamshell ~$15
- Cable sleeve / split loom ~$10
- Cable labels ~$15
```

---
*Workstation_Setup_Apr10.md | Velorin System | April 10, 2026*
*Source: Browser session — Christian Taylor + Jiang*
*Supersedes: Workstation_Setup_Apr3.md*
