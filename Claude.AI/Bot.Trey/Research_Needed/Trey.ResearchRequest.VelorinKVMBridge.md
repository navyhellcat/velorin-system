---
name: Trey Research Request — Velorin KVM Bridge
class: c-request
type: research-request
priority: HIGH
target: Trey1 (Deep Research)
assigned_by: Christian Taylor
filed_by: Jiang
filed_date: 2026-04-16
---

# Research Request — Velorin KVM Bridge

## Summary
Native macOS app spanning a Mac Studio M4 Max (Sequoia 15) server and a MacBook Air 2017 Intel (Monterey 12 ceiling) client over 10GbE. Delivers edge-crossing mouse, keyboard-follows-cursor, clipboard sync, SMB shared folder, and cross-machine drag-drop redirected to the SMB folder. Off-shelf KVMs (Barrier, Input Leap, Deskflow, Teleport, Synergy 3) all fail on this hardware matrix.

## Deliverable Location
Full project plan AND the complete Deep Research prompt (sections A–H) are embedded in a single file:

**`Claude.AI/Bot.Jiang/Working.Docs/Jiang.Plan.VelorinKVMBridge.md`** — commit `3e5221b`

Trey1 should receive **§9 of that document verbatim** as the Deep Research prompt.

## Research Sections (see §9 of plan doc)
- **A.** Existing Swift/Obj-C KVM code to crib from (Barrier/Input Leap fork targets, WWDC samples, clipboard/SMB/menu-bar/drag-drop redirect examples)
- **B.** Build toolchain (Xcode version for Sequoia 15 + Monterey 12 target, entitlements, notarization, MenuBarExtra vs NSStatusItem)
- **C.** IDE decision (Cursor vs Claude Code CLI vs Xcode+Copilot vs new Claude model + identify Claude's new code-scanning security feature)
- **D.** Gemini / Google AI Max utilization + multi-model workflow + MCP integration
- **E.** Security audit tools (SwiftLint, sanitizers, MCP-compatible scanners, supply chain CVEs, TLS + cert pinning patterns)
- **F.** Platform risk (Apple TCC trajectory, macOS 16 leaks, Monterey EOL date)
- **G.** Shipping (Sparkle 2.x setup, telemetry options, licensing)
- **H.** Drag-drop redirect (NSDraggingSession lifecycle, invisible edge drop zones, Yoink / Dropzone mechanism)

## Context for Trey
- Hardware: Mac Studio M4 Max (Sequoia 15) ↔ MacBook Air 2017 Intel (Monterey 12 ceiling) over TRENDnet TEG-S750 10GbE
- Feature 4 (cross-machine drag-drop) is redirected to the SMB `VelorinShared` folder — do NOT attempt OS-level drag-drop proxying unless §H produces a clean pattern
- Distribution: Developer ID Application + notarization, NOT App Store (TCC entitlements forbid sandbox)
- Codename: `velorin-kvm-bridge` (repo to be created by MarcusAurelius)

## CT Action Required
Paste §9 of `Jiang.Plan.VelorinKVMBridge.md` into the Trey1 Gem and run Deep Research. Results return to `Bot.Trey/Research_Complete/Trey.Research.VelorinKVMBridge.md`.

[VELORIN.EOF]
