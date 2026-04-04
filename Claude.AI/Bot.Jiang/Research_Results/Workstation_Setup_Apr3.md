# Workstation Hardware & Connection Map
**Documented:** 2026-04-03 | Session 016 | Jiang

---

## MACHINES

```
machine_1:
  type: MacBook Air
  year: 2017
  model_id: MacBookAir7,2
  cpu: Intel Core i5 Dual-Core @ 1.8GHz
  ram: 8GB
  storage: 250GB SSD
  os: macOS Monterey
  gpu: Intel HD Graphics 6000 (1536MB VRAM, no local inference capable)
  ports:
    - Thunderbolt 2 (Mini DisplayPort form factor) x1
    - USB 3.0 x2
    - MagSafe 2 x1
    - 3.5mm audio x1
    - SD card x1
  native_display_out: 1 external max (hardware limit)
  mst_support: false  # Apple Intel Mac — MST blocked at OS level
  lid_state: CLOSED (clamshell mode active)
  primary_use: Claude Code / Velorin / Turing Vault

machine_2:
  type: Work Laptop (Windows)
  ports_in_use:
    - USB-C x1 → Lenovo P27h-30 (power + display)
    - HDMI x1 → Screen 2 (display)
  lid_state: CLOSED
  primary_use: Browser / YouTube / Google / Browser AIs
```

---

## MONITORS

```
monitor_1:
  make: Lenovo
  model: ThinkVision P27h-30
  size: 27in
  resolution: 2560x1440 (QHD/WQHD)
  refresh: 60Hz
  panel: IPS
  ports:
    in:
      - USB-C 3.2 Gen1 (15W PD) — ACTIVE: Work laptop
      - DisplayPort 1.4 in — UNUSED
      - HDMI — ACTIVE: MacBook Air
    out:
      - DisplayPort out (daisy chain) — INACTIVE (dead — see notes)
    usb_hub:
      - USB-A 3.2 x3
      - USB-B upstream x1
  features:
    - PBP (Picture by Picture) — ACTIVE
    - PIP (Picture in Picture) — available
    - Daisy chain capable — hardware yes, active no
  current_display_mode: PBP
    left_half: MacBook Air (via HDMI input)
    right_half: Work laptop (via USB-C input)
  position: LEFT (primary work position)
  rank: best screen

monitor_2:
  make: Unknown
  model: Unknown
  size: Unknown
  ports:
    - DisplayPort in — receives 8K DP cable from Lenovo (INACTIVE)
    - HDMI in — ACTIVE: Work laptop direct
  current_display_mode: FULL SCREEN
  source: Work laptop via HDMI (40ft cable)
  position: RIGHT of Lenovo
  rank: second screen

monitor_3:
  make: HP (old)
  model: Unknown
  current_state: UNUSED
  position: far right
  rank: tertiary
```

---

## CABLES & CONNECTIONS

```
connections:
  active:
    - id: A1
      from: MacBook Air (Thunderbolt 2 / Mini DisplayPort)
      cable: Thunderbolt 2 to HDMI
      to: Lenovo P27h-30 HDMI input
      carries: video signal (MacBook Air display)
      note: HDMI input cannot feed DP out — root cause of dead daisy chain

    - id: A2
      from: Work laptop (USB-C)
      cable: USB-C
      to: Lenovo P27h-30 USB-C input
      carries: video signal + power (charges work laptop)
      note: USB-C input could feed DP out but PBP disables it

    - id: A3
      from: Work laptop (HDMI out)
      cable: HDMI (40ft)
      to: Monitor 2 HDMI input
      carries: video signal (Work laptop second display)
      note: direct connection, bypasses daisy chain entirely

  inactive:
    - id: I1
      from: Lenovo P27h-30 DP out (daisy chain port)
      cable: DisplayPort 8K ("D 8K" label)
      to: Monitor 2 DisplayPort input
      carries: nothing
      reason_dead:
        - HDMI input cannot feed DP out (hardware signal path)
        - PBP mode disables DP out regardless of input
        - macOS Intel does not support MST
      fix_monday: USB-C→DP cable + Mac Studio + disable PBP + re-enable daisy chain
```

---

## CURRENT ACTIVE LAYOUT (left to right)

```
layout:
  position_1:
    screen: Lenovo P27h-30 (left half)
    source: MacBook Air
    mode: PBP left
    content: Claude Code / Velorin work

  position_2:
    screen: Lenovo P27h-30 (right half)
    source: Work laptop
    mode: PBP right
    content: Browser / YouTube / Google / AI tools

  position_3:
    screen: Monitor 2
    source: Work laptop
    mode: Full screen extended
    content: Work laptop overflow

  position_4:
    screen: HP monitor
    source: nothing
    mode: UNUSED
```

---

## KNOWN LIMITATIONS

```
limitations:
  - MacBook Air 2017: 1 native external display max (hardware)
  - macOS Monterey Intel: MST/DisplayPort daisy chain blocked at OS level
  - Daisy chain on P27h-30 requires: USB-C or DP input (not HDMI) + MST source
  - PBP mode disables DP out port entirely
  - Intel HD Graphics 6000: no local LLM inference
  - 8GB RAM: constrains parallel heavy applications
```

---

## MAC STUDIO ARRIVAL — Monday April 7

```
mac_studio_changes:
  ports: Thunderbolt 4 (native MST, multiple displays)
  display_support: 3+ external monitors natively
  actions:
    - swap Thunderbolt 2→HDMI with USB-C→DisplayPort to Lenovo
    - disable PBP, revert Lenovo to full single-source
    - test daisy chain: Mac Studio → Lenovo DP in → DP out → Monitor 2
    - assign full 2560x1440 Lenovo to Mac Studio primary
    - rebuild full workspace layout
```

---

## WORKAROUND HISTORY

```
attempts:
  1: native daisy chain (Lenovo DP out) → FAIL (HDMI input blocks DP out)
  2: enable MST in Lenovo OSD → FAIL (no MST option in menu)
  3: PBP mode + check DP out → FAIL (PBP disables DP out)
  4: work laptop USB-C→Lenovo→daisy chain → FAIL (PBP still blocking)
  5: work laptop HDMI→Monitor 2 direct → SUCCESS
  6: PBP on Lenovo (Mac left / Work laptop right) → SUCCESS
  outcome: back pain resolved, workflow unblocked until Mac Studio Monday
```
