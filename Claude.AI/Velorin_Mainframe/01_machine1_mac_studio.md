# SECTION 1 — MACHINE 1: MAC STUDIO (PRIMARY WORKSTATION)

**Status:** PURCHASED April 4, 2026. Arriving Monday April 7, 2026.
**Purpose:** Primary workstation. Runs Claude Desktop, MCP tools, browser, terminals, local AI inference (Ollama via MLX). This is the center of the Velorin build.

---

## Mac Studio — Purchased Configuration

| Spec | Value |
|---|---|
| Model | Mac Studio (Early 2025) |
| Chip | Apple M4 Max |
| CPU | 14-core (10 performance + 4 efficiency) |
| GPU | 32-core |
| Neural Engine | 16-core |
| RAM | 36GB unified memory (soldered — permanent ceiling) |
| Storage | 512GB SSD internal |
| Memory Bandwidth | 410 GB/s |
| OS | macOS Sequoia (ships with latest) |
| Price | $2,198.90 total |
| Payment | $1,300 Apple Card installments (0% APR, 12 months) + $898.90 Affirm (35% APR) |

---

## Ports

### Rear
- Thunderbolt 5 x3 (USB-C form factor, 120Gbps)
- USB-A 3.2 x2 (10Gbps)
- HDMI 2.1 x1
- 10GbE ethernet x1 (built-in — connects to TRENDnet switch via Cat6a)
- 3.5mm audio jack x1

### Front
- Thunderbolt 4 x2 (USB-C form factor, 40Gbps)
- USB-A 3.2 x1 (10Gbps)
- SDXC card slot x1 (UHS-II)

---

## Display Output (Monday Setup)

```
Mac Studio Thunderbolt 5 rear → USB-C to DisplayPort cable → Lenovo P27h-30 (DP in)
  → DisplayPort daisy chain out → Monitor 2 (secondary)
```

Mac Studio supports 3+ external monitors natively via Thunderbolt 5 (MST capable). PBP mode on P27h-30 must be disabled Monday to restore daisy chain.

---

## Local AI Inference

- Ollama via MLX runs natively on Apple Silicon
- 14B models: comfortable
- 30B at Q4: functional
- 70B: not viable at 36GB RAM ceiling
- 36GB is a permanent ceiling — cannot be upgraded

**Role in Velorin architecture:** This machine will eventually host CT's own brain model. The neuron corpus being built now is the fine-tuning dataset for that model. Claude supervises and interfaces — CT's model owns the brain and routes tasks to external AI models as contractors.

---

## Network

10GbE built-in → Cat6a → TRENDnet TEG-S750 switch

---

## Accessories — To Purchase

| Item | Brand/Model | Price | Status |
|---|---|---|---|
| USB-C to DisplayPort cable | Owned | — | OWNED |
| GL.iNet Beryl AX GL-MT3000 | GL.iNet | ~$99 | TO BUY |
| TRENDnet TEG-S750 5-port 10G switch | TRENDnet | ~$70 | TO BUY |
| Cat6a 7ft patch cables 10-pack | Monoprice SlimRun | ~$30 | TO BUY |
| Amazon Basics USB-A to Gigabit Ethernet | Amazon Basics | $11.99 | TO BUY |
| Acer USB-C Hub with Ethernet | Acer | $17.99 | TO BUY |
| Thunderbolt 5 external NVMe SSD | TBD | ~$150-300 | AFTER ARRIVAL |
| Under-desk cable tray | TBD | ~$25 | TO BUY |
| Velcro ONE-WRAP cable ties | Velcro | ~$8 | TO BUY |
| Adhesive cable clips | TBD | ~$8 | TO BUY |
| Surge protector power strip (6-8 outlet) | TBD | ~$30 | TO BUY |
| Laptop vertical stand (MacBook Air clamshell) | TBD | ~$15 | TO BUY |
| Cable sleeve | TBD | ~$10 | TO BUY |
| Cable labels | TBD | ~$15 | TO BUY |

**Accessories total: ~$340**
**Full setup total including Mac Studio: ~$2,540**

---

## Power

Mac Studio uses a proprietary power brick — does NOT charge via USB-C.

[VELORIN.EOF]
