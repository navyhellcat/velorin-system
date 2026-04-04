# Velorin Workstation — Full Hardware Map
**Last updated:** April 4, 2026 | Session 020 Pt 7 | Jiang
**Status:** Reflects current setup + Monday April 7 arrivals + all purchase decisions made April 4, 2026

---

## MACHINES

### Machine 1 — Mac Studio M4 Max (PRIMARY — arriving Monday April 7)
```
make: Apple
model: Mac Studio (Early 2025)
chip: Apple M4 Max
cpu: 14-core (10 performance + 4 efficiency)
gpu: 32-core
neural_engine: 16-core
ram: 36GB unified memory (soldered — permanent ceiling)
storage: 512GB SSD internal
memory_bandwidth: 410GB/s
os: macOS Sequoia
ports_rear:
  - Thunderbolt 5 x3 (USB-C form factor, 120Gbps)
  - USB-A 3.2 x2 (10Gbps)
  - HDMI 2.1 x1
  - 10GbE ethernet x1 (built-in → TRENDnet switch via Cat6a)
  - 3.5mm audio jack x1
ports_front:
  - Thunderbolt 4 x2 (USB-C form factor, 40Gbps)
  - USB-A 3.2 x1 (10Gbps)
  - SDXC card slot x1 (UHS-II)
power: proprietary power brick (does not charge via USB-C)
role: Primary workstation — Velorin build, Claude Desktop, MCP, local AI inference
display_out: Thunderbolt 5 rear → USB-C to DP cable → Lenovo P27h-30 (DP in) → daisy chain → Monitor 2
network: 10GbE built-in → Cat6a → TRENDnet TEG-S750 switch
local_ai: Ollama via MLX — 14B comfortable, 30B Q4 functional, 70B not viable
purchased: April 4, 2026
payment: $1,300 Apple Card (0% APR 12mo) + $898.90 Affirm (35% APR)
```

### Machine 2 — MacBook Air 2017 (CLAMSHELL NODE — transitioning)
```
make: Apple
model: MacBook Air 13-inch (Mid 2017)
model_id: MacBookAir7,2
cpu: Intel Core i5 dual-core 1.8GHz
ram: 8GB LPDDR3 1600MHz (soldered — not upgradeable)
storage: 250GB SSD (105GB free April 2026)
gpu: Intel HD Graphics 6000 (no local AI inference)
os: macOS Monterey
ports:
  - USB-A 3.0 x2 (5Gbps max)
  - Thunderbolt 2 x1 (Mini DisplayPort form factor)
  - MagSafe 2 x1
  - SDXC card slot x1
  - 3.5mm audio jack x1
power: 45W MagSafe 2 (must remain connected in clamshell mode or machine sleeps)
role: Clamshell node — Claude Code / Velorin / Turing Vault terminal work
lid_state: CLOSED (clamshell)
display_out: Thunderbolt 2 → HDMI → Monitor 3 (HP)
network: USB-A 3.0 → Amazon Basics USB-A to Gigabit Ethernet → Cat6a → TRENDnet switch
notes: Headless SSH target from Mac Studio. Retire when Machine 3 (Windows) purchased.
```

### Machine 3 — Work Laptop (Lenovo, Windows — work-issued)
```
make: Lenovo
os: Windows (work-issued — no software installs, no admin rights)
ports_in_use:
  - USB-C x1 → Lenovo P27h-30 (display + 15W PD charging)
  - USB-C x1 → Acer USB-C Hub (ethernet + 3x USB-A) → Cat6a → TRENDnet switch
  - HDMI x1 → Monitor 2 (currently — unused in new setup post Mac Studio)
role: Work / browser / YouTube / Google / browser AI tools / ChatGPT (Trey)
display: Lenovo P27h-30 right half (PBP mode currently) → full screen post Mac Studio
network: USB-C → Acer hub → Cat6a → TRENDnet switch
dedicated_screen: none currently — future addition
notes: Cannot install software. No admin rights. Voice input not viable on this machine.
```

---

## MONITORS

### Monitor 1 — Lenovo ThinkVision P27h-30 (PRIMARY — best screen)
```
make: Lenovo
model: ThinkVision P27h-30
size: 27 inch
resolution: 2560x1440 (QHD)
refresh: 60Hz
panel: IPS
position: LEFT (primary work position)

ports_in:
  - USB-C 3.2 Gen1 (15W PD) — ACTIVE: Work laptop (display + charge)
  - DisplayPort 1.4 in — ACTIVE Monday: Mac Studio via USB-C to DP cable
  - HDMI — INACTIVE in new setup (was MacBook Air)
ports_out:
  - DisplayPort out (daisy chain) → Monitor 2
  - USB-A 3.2 x3 (hub)
  - USB-B upstream x1

current_mode: PBP (Picture by Picture)
  left_half: MacBook Air via HDMI
  right_half: Work laptop via USB-C

monday_mode: Single full screen — Mac Studio via DisplayPort in → daisy chain out → Monitor 2

daisy_chain:
  current: INACTIVE — HDMI input cannot feed DP out; PBP disables DP out
  monday: ACTIVE — Mac Studio USB-C/DP supports MST; disable PBP; daisy chain restores
```

### Monitor 2 — Unknown (SECONDARY)
```
position: RIGHT of Monitor 1
ports:
  - DisplayPort in — daisy chain from P27h-30 (ACTIVE Monday)
  - HDMI in — ACTIVE currently (Work laptop via 40ft HDMI direct)
current_source: Work laptop via 40ft HDMI
monday_source: Mac Studio via daisy chain through P27h-30
```

### Monitor 3 — HP (TERTIARY)
```
position: FAR RIGHT
current_state: ACTIVE Monday — MacBook Air clamshell display via Thunderbolt 2 to HDMI
previously: UNUSED
```

---

## NETWORKING

### Device 1 — GL.iNet Beryl AX GL-MT3000 (TO BUY ~$99)
```
wifi: WiFi 6 (AX3000) — matches home router (Netgear Nighthawk RAX42v2, WiFi 6)
ports:
  - WAN: 2.5G ethernet
  - LAN: 1G ethernet out → Cat6a → TRENDnet switch
mode: Repeater (receives home WiFi, distributes via LAN)
notes: Beryl 7 (WiFi 7, $139.99) deferred — home router is WiFi 6 only.
  Upgrade Beryl AX → Beryl 7 when home router upgraded to WiFi 7.
home_router: Netgear Nighthawk RAX42v2 (WiFi 6, AX4200)
```

### Device 2 — TRENDnet TEG-S750 (TO BUY ~$70)
```
type: 5-port multi-gig unmanaged switch
design: Fanless (silent — intentional)
ports:
  - Port 1: GL.iNet Beryl AX LAN (1G)
  - Port 2: Mac Studio 10GbE (10G full speed)
  - Port 3: MacBook Air via USB-A ethernet adapter (1G ceiling)
  - Port 4: Work laptop via Acer USB-C hub (1G ceiling)
  - Port 5: SPARE (future Machine 2 Windows rig or second Mac Studio at 10G)
future: When MacBook Air retired, Port 3 freed for second Mac Studio at 10G
```

---

## CABLES

### Display (OWNED)
```
cable_1: USB-C to DisplayPort — Mac Studio Thunderbolt 5 → P27h-30 DP in
cable_2: Thunderbolt 2 to HDMI — MacBook Air → Monitor 3 (HP)
```

### Network (TO BUY — Monoprice Cat6a SlimRun 7ft 10-pack, ~$30)
```
spec: Cat6a, UTP, 30 AWG pure copper, 10G rated, snagless RJ45
cable_N1: Beryl AX LAN → TRENDnet switch
cable_N2: TRENDnet switch → Mac Studio 10GbE
cable_N3: TRENDnet switch → USB-A ethernet adapter → MacBook Air
cable_N4: TRENDnet switch → Acer USB-C hub → Work laptop
6 spares
```

---

## ADAPTERS

### Adapter 1 — Amazon Basics USB-A to Gigabit Ethernet (TO BUY $11.99)
```
connects: MacBook Air USB-A → Cat6a → TRENDnet switch
max_speed: 1Gbps (USB-A 3.0 ceiling)
```

### Adapter 2 — Acer USB-C Hub with Ethernet (TO BUY $17.99)
```
connects: Work laptop USB-C → Cat6a → TRENDnet switch
bonus: 3x USB-A expansion
max_speed: 1Gbps ethernet
notes: Work laptop has 2x USB-C total. One used for P27h-30. This uses the other.
```

---

## DESK ORGANIZATION (TO BUY ~$120 total)

| Item | Price |
|---|---|
| Under-desk cable management tray (metal, screw-mount) | ~$25 |
| Velcro ONE-WRAP cable ties | ~$8 |
| Adhesive cable clips | ~$8 |
| Surge protector power strip (6-8 outlet, USB ports) | ~$30 |
| Laptop vertical stand (MacBook Air clamshell) | ~$15 |
| Cable sleeve / split loom | ~$10 |
| Cable labels | ~$15 |

---

## KNOWN LIMITATIONS

```
- Mac Studio 36GB unified memory: permanent ceiling. Cannot be upgraded.
- Mac Studio local AI: 14B comfortable, 30B Q4 functional, 70B not viable
- MacBook Air USB-A 3.0: max 1Gbps ethernet regardless of switch speed
- Work laptop: no software installs, no admin rights, 1Gbps ethernet ceiling
- Beryl AX LAN port: 1G output to switch (WiFi 6 internet bottleneck anyway)
- Daisy chain requires: Mac Studio DP-capable input, PBP disabled, MST-capable source
- MacBook Air clamshell: MagSafe 2 must remain connected or machine sleeps
- No fan under desk: intentional — passive airflow, prevents dust
```

---

## PURCHASE SUMMARY

| Item | Brand/Model | Price | Status |
|---|---|---|---|
| Mac Studio M4 Max 14-core/36GB/512GB | Apple | $2,198.90 | PURCHASED Apr 4 |
| Beryl AX GL-MT3000 | GL.iNet | ~$99 | TO BUY |
| TEG-S750 5-port 10G switch | TRENDnet | ~$70 | TO BUY |
| Cat6a 7ft 10-pack | Monoprice SlimRun | ~$30 | TO BUY |
| USB-A to Gigabit Ethernet | Amazon Basics | $11.99 | TO BUY |
| USB-C Hub with Ethernet | Acer | $17.99 | TO BUY |
| Thunderbolt 5 external NVMe SSD | TBD | ~$150-300 | AFTER ARRIVAL |
| Under-desk cable tray | TBD | ~$25 | TO BUY |
| Velcro cable ties | Velcro ONE-WRAP | ~$8 | TO BUY |
| Adhesive cable clips | TBD | ~$8 | TO BUY |
| Surge protector power strip | TBD | ~$30 | TO BUY |
| Laptop vertical stand | TBD | ~$15 | TO BUY |
| Cable sleeve | TBD | ~$10 | TO BUY |
| Cable labels | TBD | ~$15 | TO BUY |

**Networking + accessories: ~$340**
**Full setup total: ~$2,540**

---

## FUTURE HARDWARE (DEFERRED)

### Machine 4 — Windows AI Rig (not yet purchased)
```
purpose: CUDA inference, heavy local models (70B+), gaming
primary_gpu: NVIDIA RTX 4090 (24GB VRAM) — or used RTX 3090
cpu: AMD Ryzen 9 9950X3D or 7950X3D (AM5, X3D V-Cache)
ram: 64GB DDR5-6000 CL30
storage: 2TB NVMe OS drive + 4TB NVMe model storage
blocker: Claude Code crashes on ARM64 (GitHub issue #12160 open April 2026)
revisit: When Anthropic resolves ARM64 Claude Code bug
ram_kit_action: BUY DDR5-6000 CL30 2x32GB NOW (~$150-200) — memory prices rising
  per Tim Cook Q1 2026 earnings call. Store until build is ready.
trendnet_port_5: Reserved for this machine at 10G
```

### External Storage
```
type: Thunderbolt 5 external NVMe SSD
purpose: Storage expansion for Mac Studio (512GB internal fills fast with models)
timing: After Mac Studio arrives April 7
price: ~$150-300
```

### Network Upgrade Path
```
home_router: Upgrade to WiFi 7 when budget allows → then upgrade Beryl AX to Beryl 7
second_mac_studio: TRENDnet Port 5 reserved at 10G
```

---

## WORKAROUND HISTORY (pre Mac Studio)

```
1. Native daisy chain (Lenovo DP out) → FAIL (HDMI input blocks DP out)
2. Enable MST in Lenovo OSD → FAIL (no MST option in menu)
3. PBP mode + check DP out → FAIL (PBP disables DP out)
4. Work laptop USB-C → Lenovo → daisy chain → FAIL (PBP still blocking)
5. Work laptop HDMI → Monitor 2 direct → SUCCESS
6. PBP on Lenovo (Mac left / Work laptop right) → SUCCESS
outcome: back pain resolved, workflow unblocked until Mac Studio Monday
```

[VELORIN.EOF]
