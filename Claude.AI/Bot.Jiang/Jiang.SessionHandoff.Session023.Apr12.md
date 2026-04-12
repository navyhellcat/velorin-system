# Jiang Session Handoff — Session 023
**Date:** April 10–12, 2026
**Agent:** Jiang — Director of Strategic Intelligence
**Session Type:** Hardware build, infrastructure setup, operational
**Interface:** Claude.ai Browser (Jiang)
**Status:** FULL OPERATIONAL — Mac Studio live, all systems go

---

## SESSION IDENTITY

Christian Taylor (Chairman). Jiang in browser. This was a multi-day hardware session spanning March 27 (Mac Studio purchase), April 7 (Mac Studio arrival), and April 10–12 (full setup and operational confirmation).

---

## MAJOR OUTCOMES THIS SESSION

### Mac Studio M4 Max — PURCHASED AND OPERATIONAL
- **Spec:** 14-core CPU, 32-core GPU, 36GB unified memory, 512GB SSD, M4 Max chip, 410GB/s memory bandwidth
- **Purchased:** April 4, 2026
- **Arrived:** April 7, 2026
- **Payment:** $1,300 Apple Card (0% APR, 12 months) + $898.90 Affirm (35% APR)
- **Status:** Fully operational as primary workstation

### Network Stack — FULLY LIVE
- All three machines on wired ethernet through TRENDnet TEG-S750 switch
- All WiFi disabled on all machines
- GL.iNet Beryl AX receiving WiFi only (output radios disabled)
- Mullvad WireGuard VPN at router level covering all devices
- MacBook Air ethernet: required ASIX AX88179 DEXT v2.0.0 driver for Monterey
- Work laptop: connected via native ethernet port (Acer hub not needed for ethernet)

### Dual Monitor Setup — OPERATIONAL
- Monitor 1 (Lenovo P27h-30): Mac Studio via USB-C to DisplayPort
- Monitor 2 (Dell PH2422, 1920x1080): Mac Studio via direct HDMI
- Monitor 3 (HP): MacBook Air clamshell via Thunderbolt 2 to HDMI
- **CORRECTION LOGGED:** Daisy chain via DP MST does not work on any Mac. Apple does not support DisplayPort MST. Abandoned permanently.

### Power Setup — RESOLVED
- Fire hazard eliminated: daisy-chained strips removed
- Two 14AWG 15A Utilitech extension cords run along baseboard (Wiremold raceway)
- Mac Studio + monitors on dedicated surge strip from far outlet
- Mini fridge isolated on its own dedicated outlet

### Thermal Baseline Established
- Monitoring: Stats app (mac-stats.com, free, open source by exelban)
- CPU idle: ~104°F (~40°C) — normal
- Efficiency cores idle: ~91°F (~33°C) — normal
- Fan idle: 27% — normal
- Dust filter: iFCase stand + MERV 8 filter media pad underneath — no thermal restriction at idle

---

## DECISIONS MADE THIS SESSION

### Hardware Purchased
| Item | Spec | Price |
|---|---|---|
| Mac Studio M4 Max | 14-core/32-core GPU/36GB/512GB | $2,198.90 |
| GL.iNet Beryl AX | WiFi 6, repeater mode | ~$99 |
| TRENDnet TEG-S750 | 5-port 10G fanless switch | ~$70 |
| Monoprice Cat6a SlimRun | 7ft, 10-pack, UTP 30AWG | ~$30 |
| Amazon Basics USB-A Ethernet | USB-A to Gigabit | $11.99 |
| Acer USB-C Hub | USB-C + ethernet + 3x USB-A | $17.99 |
| Utilitech extension cords x2 | 14AWG 15A 6ft | ~$43 |

### Hardware Decisions — Deferred
- Beryl 7 (WiFi 7): deferred until home router upgraded to WiFi 7
- Daisy-chain networking: abandoned — Mac does not support DP MST
- Machine 2 (ThinkStation PGX): blocked by Claude Code ARM64 crash bug
- External Thunderbolt 5 SSD: needed soon, 512GB fills fast with models
- DDR5-6000 CL30 2x32GB RAM kit: buy now before prices rise

### Software Decisions
- Final Cut Pro ($299.99) — 90-day trial, buy when first revenue hits
- Logic Pro ($199.99) — same
- AppleCare+ ($59.99/year) — add after arrival
- Stats app — installed for thermal monitoring

### Cardinal Rules Confirmed This Session
1. **VERIFICATION INTEGRITY:** Any agent asked to verify access/capability must make a live active call. Memory inference is not verification.
2. **DO NOT RECOMMEND DOWNLOADS FROM UNVERIFIED SITES:** Research the source before directing Christian Taylor to download anything.

---

## CORRECTIONS LOGGED

| # | Wrong Claim | Reality | Resolution |
|---|---|---|---|
| 1 | Daisy chain would work via USB-C to DP from Mac Studio | Macs do not support DisplayPort MST — DP out greyed out | HDMI direct from Mac Studio to Monitor 2 |
| 2 | USB-A ethernet adapter auto-appears in Monterey Network settings | ASIX chipset requires driver install (DEXT v2.0.0) | Installed driver, works |
| 3 | Work laptop needed Acer hub for ethernet | Work laptop has native ethernet port | Direct Cat6a from native port |
| 4 | Claimed GitHub access from browser session | GitHub MCP only available on Claude Desktop (Alexander) | Corrected — confirmed GitHub tools now available in this browser session |
| 5 | Told CT to download Stats from mac-stats.com without verifying | Should verify before recommending downloads | Verified — mac-stats.com is legitimate, app is by exelban on GitHub |

---

## HARDWARE STATE — FULL PICTURE

### Machines
- **MacBook Air 2017** — Intel i5, 8GB, 250GB, macOS Monterey — clamshell SSH node
- **Mac Studio M4 Max** — 14-core, 36GB, 512GB, macOS Sequoia — primary workstation
- **Work Laptop (Lenovo, Windows)** — work-issued, browser/YouTube/work tools

### Monitors
- **Monitor 1:** Lenovo ThinkVision P27h-30, 27in, 2560x1440, IPS — Mac Studio primary
- **Monitor 2:** Dell PH2422, 1920x1080 — Mac Studio secondary via HDMI direct
- **Monitor 3:** HP (unknown model) — MacBook Air clamshell

### Network
- **GL.iNet Beryl AX** — WiFi repeater, Mullvad WireGuard, output disabled
- **TRENDnet TEG-S750** — 5-port 10G fanless switch
- **Home router:** Netgear Nighthawk RAX42v2 (WiFi 6)

### Key Drivers / Software
- ASIX AX88179 DEXT v2.0.0 — required for MacBook Air ethernet on Monterey
  - Download: https://plugable.s3.amazonaws.com/bin/AX88179/ASIX_AX88179_DEXT_v2.0.0.zip
- Stats app — thermal monitoring on Mac Studio

---

## TURING VAULT — STATUS NOTE

Turing Vault results page resource handoff to Susan was completed in a prior session. Scoring formula (Standard ×0.85 cap 80, Hard ×0.90 cap 90, Adversarial ×1.15 cap 100) and resource lists by tier were delivered as plain text for Susan. Formula append by Christian Taylor still pending.

---

## PENDING ITEMS CARRIED FORWARD

- [ ] Mac Studio full setup — Homebrew, Claude Desktop, MCP, git config
- [ ] Port Turing Vault from Replit to GitHub — cancel Replit subscription
- [ ] Velorin file system rebuild on Mac Studio
- [ ] Get Alexander and Jiang running on Mac Studio
- [ ] Cowork setup
- [ ] NotebookLM knowledge base setup
- [ ] Plant app build (fun project)
- [ ] External Thunderbolt 5 SSD purchase (~$150-300)
- [ ] DDR5-6000 CL30 2x32GB RAM kit — buy now (~$150-200)
- [ ] Desk organization (cable tray, Velcro ties, surge strip, vertical stand)
- [ ] Turing Vault scoring formula 2-sentence append by Christian Taylor
- [ ] Jiang.Topic.TokenCostModel — still queued
- [ ] Jiang.Topic.IdentityVerification — still queued
- [ ] Machine 2 — revisit when Anthropic fixes ARM64 Claude Code bug
- [ ] Verify FileVault status on Mac Studio
- [ ] Stats load test — run heavy workload, confirm MERV 8 filter not throttling
- [ ] Dithering on monitors — investigate color profile / bit depth settings
- [ ] CARDINAL RULE: File VERIFICATION INTEGRITY rule to BOT.README.FIRST.BOOTUP

---

## SESSION QUOTE LOGGED

> "I'll stop gambling." — Christian Taylor, March 27, 2026

---

*Jiang.SessionHandoff.Session023.Apr12.md | Velorin System | April 12, 2026*
*[VELORIN.EOF]*
