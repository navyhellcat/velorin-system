# Supplementary Current Hardware Setup
**Documented:** April 4, 2026 | Session — Jiang (Browser) + Christian Taylor
**Status:** Reflects current setup + Monday April 7 arrivals + all purchase decisions made this session
**Purpose:** Supplement and replace Workstation_Setup_Apr3.md with full updated picture

---

## MACHINES

### Machine 1 — MacBook Air 2017 (CURRENT — transitioning to clamshell node)
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
power: 45W MagSafe 2 adapter (required for clamshell mode — must remain plugged in)
role: Clamshell node — Claude Code / Velorin / Turing Vault terminal work
lid_state: CLOSED (clamshell) — requires MagSafe 2 connected to stay awake
display_out: Thunderbolt 2 → HDMI → Monitor 3 (HP, clamshell display)
network: USB-A 3.0 → Amazon Basics USB-A to Gigabit Ethernet adapter → Cat6a → TRENDnet switch
notes: Headless SSH target from Mac Studio. Retire when Machine 2 purchased.
```

### Machine 2 — Mac Studio M4 Max (ARRIVING MONDAY APRIL 7)
```
make: Apple
model: Mac Studio (Early 2025)
chip: Apple M4 Max
cpu: 14-core (10 performance + 4 efficiency)
gpu: 32-core
neural_engine: 16-core
ram: 36GB unified memory (soldered, not upgradeable — permanent ceiling)
storage: 512GB SSD internal
memory_bandwidth: 410GB/s
os: macOS Sequoia (ships with latest)
ports_rear:
  - Thunderbolt 5 x3 (USB-C form factor, 120Gbps)
  - USB-A 3.2 x2 (10Gbps)
  - HDMI 2.1 x1
  - 10GbE ethernet x1 (built in — connects to TRENDnet switch via Cat6a)
  - 3.5mm audio jack x1
ports_front:
  - Thunderbolt 4 x2 (USB-C form factor, 40Gbps)
  - USB-A 3.2 x1 (10Gbps)
  - SDXC card slot x1 (UHS-II)
power: proprietary power brick (does not charge via USB-C)
role: Primary workstation — Velorin build, Claude Desktop, MCP, local AI inference
display_out: Thunderbolt 5 rear → USB-C to DisplayPort cable → Lenovo P27h-30 (DP in) → daisy chain → Monitor 2
network: 10GbE built-in → Cat6a → TRENDnet TEG-S750 switch
local_ai: Ollama via MLX — runs 14B models comfortably, 30B at Q4 functional
purchased: April 4, 2026
payment: $1,300 Apple Card installments (0% APR, 12 months) + $898.90 Affirm (35% APR)
```

### Machine 3 — Work Laptop (Lenovo, Windows)
```
make: Lenovo
os: Windows (work-issued)
ports_in_use:
  - USB-C x1 → Acer USB-C Hub (ethernet + 3x USB-A) → Cat6a → TRENDnet switch
  - HDMI x1 → Monitor 2 (currently unused in new setup — work laptop has no dedicated screen yet)
  - USB-C x1 → Lenovo P27h-30 (display + 15W charging) — ACTIVE
role: Work / browser / YouTube / Google / browser AI tools
display: Lenovo P27h-30 right half (PBP mode) — transitioning to full screen post Mac Studio arrival
network: USB-C → Acer hub → Cat6a → TRENDnet switch
dedicated_screen: none currently — future addition
notes: Work laptop USB-C to P27h-30 carries display signal + 15W PD charging simultaneously
```

---

## MONITORS

### Monitor 1 — Lenovo ThinkVision P27h-30 (PRIMARY)
```
make: Lenovo
model: ThinkVision P27h-30
size: 27 inch
resolution: 2560x1440 (QHD/WQHD)
refresh: 60Hz
panel: IPS
position: LEFT (primary work position)
rank: best screen

ports_in:
  - USB-C 3.2 Gen1 (15W PD) — ACTIVE: Work laptop (display + charge)
  - DisplayPort 1.4 in — ACTIVE Monday: Mac Studio via USB-C to DP cable
  - HDMI — INACTIVE in new setup (was MacBook Air, now unused)

ports_out:
  - DisplayPort out (daisy chain) → Monitor 2
  - USB-A 3.2 x3 (hub)
  - USB-B upstream x1

current_mode: PBP (Picture by Picture)
  left_half: MacBook Air via HDMI
  right_half: Work laptop via USB-C

monday_mode: Single full screen — Mac Studio via DisplayPort in → daisy chain out → Monitor 2

daisy_chain_status:
  current: INACTIVE — HDMI input cannot feed DP out; PBP mode disables DP out
  monday: ACTIVE — Mac Studio USB-C/DP input supports MST; disable PBP; daisy chain restores
```

### Monitor 2 — Unknown brand (SECONDARY)
```
make: Unknown
model: Unknown
position: RIGHT of Monitor 1
ports:
  - DisplayPort in — receives daisy chain from Lenovo P27h-30 (ACTIVE Monday)
  - HDMI in — ACTIVE currently (Work laptop via 40ft HDMI cable)
current_source: Work laptop via 40ft HDMI direct
monday_source: Mac Studio via daisy chain through P27h-30
```

### Monitor 3 — HP (TERTIARY)
```
make: HP
model: Unknown
position: FAR RIGHT
current_state: ACTIVE Monday — MacBook Air clamshell display via Thunderbolt 2 to HDMI
previously: UNUSED
```

---

## NETWORKING

### Device 1 — GL.iNet Beryl AX (GL-MT3000) — TO BE PURCHASED
```
make: GL.iNet
model: Beryl AX (GL-MT3000)
wifi: WiFi 6 (AX3000) — matches home router (Nighthawk RAX42v2 is WiFi 6)
ports:
  - WAN: 2.5G ethernet (future hardwire input when home network upgraded)
  - LAN: 1G ethernet out → Cat6a → TRENDnet switch
mode: Repeater (receives home WiFi, distributes via LAN port)
price: ~$99
notes: Beryl 7 (WiFi 7, $139.99) deferred — home router is WiFi 6 only, upgrade wasted.
  Upgrade Beryl AX to Beryl 7 when home router upgraded to WiFi 7.
home_router: Netgear Nighthawk RAX42v2 (WiFi 6, AX4200)
```

### Device 2 — TRENDnet TEG-S750 — TO BE PURCHASED
```
make: TRENDnet
model: TEG-S750
type: 5-port multi-gig unmanaged switch
design: Fanless (passive cooling — intentional, silent)
ports:
  - 5x multi-gig ports (10G/5G/2.5G/1G auto-negotiation)
  - Port 1: GL.iNet Beryl AX LAN out (1G)
  - Port 2: Mac Studio 10GbE (10G — full speed)
  - Port 3: MacBook Air via USB-A ethernet adapter (1G — hardware ceiling)
  - Port 4: Work laptop via Acer USB-C hub (1G — hardware ceiling)
  - Port 5: SPARE (future Machine 2 — second Mac Studio at full 10G)
price: ~$60-80
future: When MacBook Air replaced with second Mac Studio, both run at 10G through this switch
```

---

## CABLES

### Active Display Cables (OWNED)
```
cable_1:
  type: USB-C to DisplayPort
  from: Mac Studio Thunderbolt 5 rear port
  to: Lenovo P27h-30 DisplayPort in
  carries: video signal (Mac Studio primary display + daisy chain trigger)
  status: OWNED

cable_2:
  type: Thunderbolt 2 to HDMI
  from: MacBook Air Thunderbolt 2 port
  to: Monitor 3 (HP) HDMI in
  carries: video signal (MacBook Air clamshell display)
  status: OWNED
```

### Network Cables (TO BE PURCHASED — Monoprice Cat6a SlimRun 7ft 10-pack)
```
spec: Cat6a, UTP (unshielded), 30 AWG pure copper, 10G rated, snagless RJ45
brand: Monoprice SlimRun Series
length: 7 feet each
quantity: 10-pack (4 used, 6 spare)
price: ~$29.87 (10-pack)

cable_N1: Beryl AX LAN → TRENDnet switch
cable_N2: TRENDnet switch → Mac Studio 10GbE port
cable_N3: TRENDnet switch → Amazon Basics USB-A ethernet adapter → MacBook Air
cable_N4: TRENDnet switch → Acer USB-C hub ethernet port → Work laptop
```

---

## ADAPTERS

### Adapter 1 — Amazon Basics USB-A to Gigabit Ethernet (TO BE PURCHASED)
```
make: Amazon Basics
type: USB-A 3.0 to 10/100/1000 Gigabit Ethernet
connects: MacBook Air USB-A port → Cat6a → TRENDnet switch
max_speed: 1Gbps (hardware ceiling of USB-A 3.0)
price: $11.99
compatibility: macOS confirmed
```

### Adapter 2 — Acer USB-C Hub with Ethernet (TO BE PURCHASED)
```
make: Acer
type: USB-C hub — 1Gbps ethernet + 3x USB-A 3.0
connects: Work laptop USB-C port → Cat6a → TRENDnet switch
bonus: 3x USB-A ports freed up from single USB-C port
max_speed: 1Gbps ethernet
price: $17.99
compatibility: Windows + macOS confirmed
notes: Work laptop has 2x USB-C total. One used for P27h-30 display+charge.
  This hub uses the remaining USB-C and adds ethernet + USB-A expansion.
```

---

## DESK ORGANIZATION (TO BE PURCHASED)

```
item_1:
  type: Under-desk cable management tray (metal, screw-mount)
  purpose: Mounts power strip + excess cables under desk surface
  search: "under desk cable management tray"
  price: ~$20-30

item_2:
  type: Velcro ONE-WRAP cable ties (reusable)
  purpose: Bundle cables — reusable and repositionable
  price: ~$8

item_3:
  type: Adhesive cable clips
  purpose: Route cables along desk edge and underside cleanly
  price: ~$8

item_4:
  type: Surge protector power strip (6-8 outlet, USB ports)
  purpose: Single protected power source for all desk equipment
  outlets_needed: Mac Studio, Beryl AX, TRENDnet switch, P27h-30, HP monitor, MacBook Air MagSafe, Work laptop charger
  mount: Under desk via cable management tray
  price: ~$25-35

item_5:
  type: Laptop vertical stand
  purpose: Hold MacBook Air vertical in clamshell — minimal footprint, better airflow
  price: ~$15

item_6:
  type: Cable sleeve or split loom
  purpose: Bundle multiple cables running same direction into one clean tube
  price: ~$10

item_7:
  type: Cable labels or label maker
  purpose: Identify 4x Cat6a cables at switch — avoid tracing
  price: ~$10-20
```

---

## KNOWN LIMITATIONS

```
- MacBook Air 36GB unified memory: permanent ceiling, cannot be upgraded
- MacBook Air USB-A 3.0: max 1Gbps ethernet regardless of switch speed
- Work laptop USB-C ethernet via hub: max 1Gbps
- Beryl AX LAN port: max 1G output to switch (WiFi 6 internet speed bottleneck anyway)
- Mac Studio 36GB unified memory: runs 14B models comfortably, 30B at Q4 functional, 70B not viable
- Daisy chain requires: Mac Studio connected via DP-capable input (USB-C/DP), PBP disabled, MST-capable source
- MacBook Air clamshell mode: MagSafe 2 must remain connected at all times or machine sleeps
- No fan under desk: intentional — passive airflow only, prevents dust accumulation
```

---

## PURCHASE SUMMARY

| Item | Brand/Model | Price | Status |
|---|---|---|---|
| Mac Studio M4 Max 14-core/36GB/512GB | Apple | $2,198.90 | PURCHASED Apr 4 |
| Beryl AX GL-MT3000 | GL.iNet | ~$99 | TO BUY |
| 5-port 10G switch TEG-S750 | TRENDnet | ~$70 | TO BUY |
| Cat6a 7ft patch cables 10-pack | Monoprice SlimRun | ~$30 | TO BUY |
| USB-A to Gigabit Ethernet adapter | Amazon Basics | $11.99 | TO BUY |
| USB-C hub with ethernet | Acer | $17.99 | TO BUY |
| Under-desk cable tray | TBD | ~$25 | TO BUY |
| Velcro cable ties | Velcro ONE-WRAP | ~$8 | TO BUY |
| Adhesive cable clips | TBD | ~$8 | TO BUY |
| Surge protector power strip | TBD | ~$30 | TO BUY |
| Laptop vertical stand | TBD | ~$15 | TO BUY |
| Cable sleeve | TBD | ~$10 | TO BUY |
| Cable labels | TBD | ~$15 | TO BUY |

**Networking + accessories total: ~$340**
**Full setup total including Mac Studio: ~$2,540**

---

## FUTURE HARDWARE (DEFERRED)

```
machine_2_cuda:
  candidates:
    - Lenovo ThinkStation PGX (GB10 Grace Blackwell, 128GB, $4,300)
      blocker: Claude Code crashes on ARM64 — GitHub issue #12160 open as of April 2026
      revisit: When Anthropic resolves ARM64 Claude Code bug
    - TRENDnet TEG-S750 spare port 5 reserved for second Mac Studio at 10G
  ram_kit_buy_now:
    spec: DDR5-6000 CL30 2x32GB (G.Skill Trident Z5 Neo RGB or equivalent)
    reason: Memory prices rising per Tim Cook Q1 2026 earnings call
    price: ~$150-200
    action: BUY NOW and store — will be needed for Machine 2 Windows build

external_ssd:
  type: Thunderbolt 5 external NVMe SSD
  purpose: Storage expansion for Mac Studio (512GB internal fills fast with models)
  timing: After Mac Studio arrives April 7
  price: ~$150-300 depending on capacity
```

---
*Supplementary_Current_Hardware_Setup.md | Velorin System | April 4, 2026*
*Source: Browser session — Christian Taylor + Jiang*
*Alexander on Desktop to replace Workstation_Setup_Apr3.md with this file*
