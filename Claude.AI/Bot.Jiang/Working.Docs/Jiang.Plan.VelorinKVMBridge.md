---
class: project-plan
status: ACTIVE — awaiting Trey1 research results before build start
owner: Jiang (architecture) / Jiang2 (build) / MarcusAurelius (git+CI)
requested-by: Christian Taylor (Chairman)
date: 2026-04-15
---

# Velorin KVM Bridge — Project Plan + Trey1 Research Request

**Codename:** `velorin-kvm-bridge` (working title)
**One-line:** A native macOS menu bar app that gives you seamless mouse/keyboard/clipboard across a Mac Studio (Sequoia) and a MacBook Air 2017 (Monterey) over a 10GbE LAN, with drag-drop transparently redirected to a shared SMB folder.
**Why we're building it:** Every off-the-shelf KVM (Barrier, Input Leap, Deskflow, Teleport, Synergy) fails on this specific hardware matrix — see `Bot.Trey/Research_Complete/Trey.Research.BarrierKVM.CrossMacTransfer.md` for the full teardown.

---

## Part 1 — Feature Contract

The app MUST deliver:

| # | Feature | Acceptance test |
|---|---|---|
| 1 | **Mouse edge-crossing** | Cursor on Studio's right monitor passes the right edge → appears on the Air's screen. No button press. Cursor reverse-crosses back through the Air's left edge. |
| 2 | **Keyboard follows cursor** | Typing always goes to the machine the cursor is currently on. Modifier keys (Cmd/Opt/Ctrl/Shift) work bidirectionally, including on Intel Air from M4 Max Studio (the bug that kills Input Leap). |
| 3 | **Bidirectional clipboard sync** | Cmd+C on either machine → Cmd+V on the other works instantly, including UTF-8 multi-byte, for text, RTF, and images. |
| 4 | **Drag-drop redirect (the compromise)** | If a user drags a file/folder and the cursor crosses the boundary while dragging, the drag is intercepted and the file is copied to the shared SMB folder. A non-modal notification on the target machine confirms arrival. |
| 5 | **Managed shared SMB folder** | App auto-mounts `smb://mac-studio.local/VelorinShared/` on both machines at login, recovers from disconnection, and surfaces mount status in the menu bar. |

Explicit non-goals (v1.0):
- Screen mirroring / remote desktop
- Multi-monitor on the Air side (Air has one screen)
- Cross-platform (Windows/Linux) — macOS only
- Mac App Store distribution (impossible due to required entitlements)

---

## Part 2 — Architecture

### 2.1 Topology

```
┌────────────────────────────┐         ┌──────────────────────────┐
│  Mac Studio M4 Max          │         │  MacBook Air 2017         │
│  macOS 15 Sequoia           │◀──TLS──▶│  macOS 12 Monterey        │
│  Mode: SERVER               │   TCP   │  Mode: CLIENT             │
│  Binds keyboard + mouse     │ 10GbE   │  Receives events          │
│  Runs SMB server            │         │  Mounts SMB share         │
└────────────────────────────┘         └──────────────────────────┘
         │                                        │
         └──── shared SMB volume: /Volumes/VelorinShared ────┘
```

### 2.2 Process model (same binary, two modes)

One universal app binary. First-run wizard asks: **Is this the server (has the physical keyboard/mouse) or the client?** Choice persists in `~/Library/Application Support/VelorinKVMBridge/config.plist`.

### 2.3 Two TCP channels

- **Channel A — Input stream** (low-latency, high-frequency): mouse deltas + keyboard events. UDP considered and rejected: TCP ordering matters for modifier+keystroke sequencing, and 10GbE jitter is negligible. Nagle disabled (`TCP_NODELAY`).
- **Channel B — Control / clipboard / drag-drop signaling** (reliable, larger payloads): JSON-framed messages over TLS.

Both channels over the same TLS session via multiplexing (separate `NWConnection`s sharing a pinned identity).

### 2.4 Security model

- First-run pairing: server displays a 6-digit code, user enters on client. Over TLS-PSK for the bootstrap, then each side generates Ed25519 keypair and exchanges public keys.
- Subsequent connections: mutual TLS with certificate pinning. Connection refused if fingerprint mismatch.
- Closes the "authentication-by-convention" gap flagged in `Jiang.Topic.AgentOrchestration` §8.

---

## Part 3 — Component Breakdown

| # | Component | Where | Primary APIs | Est. LOC |
|---|---|---|---|---|
| C1 | Input Interception (server) | Studio | `CGEventTap` at `kCGHIDEventTap`, `CGEventPost` | 400 |
| C2 | Input Injection (client) | Air | `CGEventPost` with full modifier state | 250 |
| C3 | Boundary Detector | Both | `CGDisplayBounds`, mouse delta accumulator, hysteresis | 150 |
| C4 | Cursor Suppression | Both | `CGDisplayHideCursor` / `CGWarpMouseCursorPosition` | 80 |
| C5 | Clipboard Sync | Both | `NSPasteboard.changeCount` polling + echo-loop prevention | 300 |
| C6 | Drag-Drop Redirect | Server | `NSDraggingDestination` invisible edge window + `FileManager.copyItem` | 350 |
| C7 | SMB Mount Manager | Both | `NetFS.framework` (`NetFSMountURLSync`) | 150 |
| C8 | Pairing + Crypto | Both | `CryptoKit` (Ed25519), `Network.framework` TLS | 400 |
| C9 | Network Transport | Both | `Network.framework` NWListener/NWConnection + framing | 500 |
| C10 | Menu Bar UI | Both | SwiftUI `MenuBarExtra` (macOS 13+) — polyfill for Monterey | 300 |
| C11 | Settings Window | Both | SwiftUI | 400 |
| C12 | Persistence / launchd | Both | `launchctl` plist management | 100 |
| C13 | Update mechanism | Both | Sparkle 2.x | 50 |
| C14 | Logging / telemetry | Both | `os_log`, optional crash reporter | 150 |
| **Total** | | | | **~3,580 LOC** |

---

## Part 4 — Tech Stack

- **Language:** Swift 5.10+
- **UI:** SwiftUI for settings + menu bar; AppKit for any low-level window work
- **Input hooks:** CoreGraphics (`CGEventTap`), AppKit (`NSEvent`)
- **Networking:** Apple's Network.framework (TLS 1.3 built-in)
- **Crypto:** CryptoKit
- **SMB:** NetFS.framework
- **Updates:** Sparkle 2.x
- **Build:** Xcode 16+, deployment target macOS 12.0
- **Distribution:** Direct notarized DMG (Developer ID Application signing)
- **Hosting:** GitHub Releases + Sparkle feed

---

## Part 5 — Entitlements / TCC

Required permissions — all user-granted at first run, with an in-app onboarding flow that walks the user to each toggle:

- **Accessibility** (System Settings → Privacy & Security → Accessibility)
- **Input Monitoring** (System Settings → Privacy & Security → Input Monitoring)
- **Local Network** (prompted on first LAN connection — requires `NSLocalNetworkUsageDescription` in Info.plist)
- **Full Disk Access** — NOT required
- **Screen Recording** — NOT required

App is NOT sandboxed. App Store distribution is foreclosed by this.

---

## Part 6 — Development Workflow

### 6.1 Agent assignment

| Agent | Role |
|---|---|
| **Jiang** (Desktop, 200K) | Architecture decisions, protocol design, security model review, Trey prompt iteration |
| **Jiang2** (terminal, 1M ctx) | Actual Swift code authoring, multi-file refactors, test harnesses |
| **MarcusAurelius** (Code CLI) | git ops, CI/CD, notarization scripts, launchd install scripts |
| **Erdős** | Only if we hit a formal verification need (unlikely for this project) |
| **Trey1 / Trey2** | Research (this doc), tooling validation, Apple API monitoring |

### 6.2 Terminal / tooling question

Recommend spinning up **Jiang2 (terminal Claude Code, 1M context)** as the build agent the moment Trey1 returns. CT's note: open a new terminal, run `claude --model sonnet[1m]`, point it at `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/Working.Docs/Jiang.Plan.VelorinKVMBridge.md` as the bootloader.

Whether we use Cursor, Claude Code, or new-Claude-Max for the actual typing is a **Trey research question** (see §9.C below). Do not decide until Trey returns.

### 6.3 Repo layout (when we start)

Create new private repo: `navyhellcat/velorin-kvm-bridge`. Do not build inside `velorin-system`.

```
velorin-kvm-bridge/
├── .github/workflows/          # build + notarize CI
├── VelorinKVMBridge.xcodeproj
├── VelorinKVMBridge/
│   ├── App/                    # app entry, menu bar, settings UI
│   ├── Core/                   # input hooks, boundary detector
│   ├── Net/                    # transport, framing, pairing
│   ├── Clipboard/
│   ├── Drag/
│   ├── SMB/
│   └── Resources/
├── Tests/
├── scripts/
│   ├── notarize.sh
│   └── install-launchd.sh
└── docs/
```

---

## Part 7 — Milestones

Sequential, each merges to `main` behind a feature flag until v1.0:

| M# | Deliverable | Est. days |
|---|---|---|
| M0 | Repo + signing + notarization pipeline + empty menu bar shell | 1 |
| M1 | Clipboard sync over TLS (replaces the Python daemon scope entirely) | 2 |
| M2 | SMB auto-mount with recovery | 1 |
| M3 | `CGEventTap` install + local loopback cursor suppression | 3 |
| M4 | Studio → Air event streaming (cursor appears on Air) | 5 |
| M5 | Bidirectional boundary crossing (Air → Studio return path) | 3 |
| M6 | Drag-drop redirect to SMB | 3 |
| M7 | Pairing flow + certificate pinning | 3 |
| M8 | Settings UI + launchd persistence | 2 |
| M9 | Polish + beta on both machines + Sparkle updates | 3 |
| M10 | v1.0 notarized release | 1 |
| **Total** | | **~27 work days** |

Calendar: 4–6 weeks assuming daily work, with parallel Trey research on outstanding decisions.

---

## Part 8 — Open Decisions (parallel to Trey's research)

These block nothing individually but collectively determine velocity. Trey answers inform each.

1. **IDE:** Cursor vs Claude Code CLI vs new-Claude-Max (Trey §C)
2. **Protocol:** Roll our own vs crib Barrier's wire format (Trey §A.2)
3. **MacBook Air end-of-life:** how much longer is Monterey Intel viable (Trey §F.3)
4. **Security sweep tool:** Claude's new feature vs external (Trey §C.4, §E)
5. **Gemini's role:** where does Google AI Max earn its seat (Trey §D)

---

## Part 9 — Trey1 Deep Research Prompt

> **Everything below this line is the prompt to paste into Trey1 (Google Gemini Deep Research Gem).**
> Do not edit without Jiang review — word choice is calibrated.

---

### Velorin KVM Bridge — Tools, Existing Code, and Platform Decisions (Deep Research)

**Assignment:** Trey1 (Deep Research, Google Gemini)
**Priority:** HIGH
**Requested by:** Christian Taylor (Chairman)
**Date:** 2026-04-15
**Expected depth:** Multi-source synthesis. 60+ sources. Scholarly / official / reputable dev blog prioritized. Confidence rating per claim.

---

#### Context you need

Velorin is building a native macOS menu bar app ("Velorin KVM Bridge") to replace the documented failure modes of Barrier, Input Leap, Deskflow, and Teleport on this hardware matrix:

- **Server:** Mac Studio M4 Max, macOS 15 Sequoia, dual monitors, 10GbE Ethernet (TRENDnet TEG-S750 switch)
- **Client:** MacBook Air 2017 (Intel i5), macOS 12 Monterey (this is the OS ceiling for this hardware — it cannot run Ventura or newer), 10GbE via Thunderbolt adapter
- Both on an isolated 10GbE LAN, no internet requirement for app operation

**Feature contract (fixed, do not question):**
1. Mouse edge-crossing between Studio's right monitor and the Air's screen
2. Keyboard follows cursor, including all modifier keys bidirectionally
3. Bidirectional clipboard sync (text, RTF, images)
4. Drag-drop redirect: file drags across the boundary get copied to a shared SMB folder automatically
5. App-managed SMB auto-mount with reconnection recovery

**Tech stack (tentative — confirm or challenge):** Swift 5.10+, SwiftUI + AppKit, CoreGraphics (`CGEventTap`), Network.framework (TLS), CryptoKit (Ed25519), NetFS.framework, Sparkle for updates, notarized direct distribution.

**Hard constraints:**
- Must run on macOS 12 Monterey as client AND macOS 15 Sequoia as server. Anything requiring Ventura+ on the client is disqualified.
- Decision to build is final. Do not research "should we build it" — only "how to build it best."

---

#### Research questions

##### A. Existing code to study / port / crib from

- **A.1** Survey all **Swift-native** KVM / input-sharing / remote-input GitHub repos active as of April 2026. For each: URL, license, stars, last commit, maintainer status, which of the 5 features it implements, and whether copying code is legally viable (MIT/BSD/Apache ok; GPL noted but limiting).
- **A.2** Is there any clean-room Swift reimplementation of the Barrier/Synergy protocol? If not, identify the **3–5 highest-leverage source files** in Barrier, Input Leap, or Deskflow that a Swift port should study first (file path + approximate line range + what it implements).
- **A.3** Apple WWDC sessions or sample code demonstrating `CGEventTap` combined with cross-device event replay over a network. Session numbers + URLs.
- **A.4** Existing open-source Swift projects that implement any of:
  - (a) NSPasteboard monitoring + peer-to-peer TLS network sync
  - (b) Programmatic SMB mount management via NetFS.framework
  - (c) Menu bar apps with Input Monitoring + Accessibility entitlements that successfully ship via Developer ID notarization (not App Store)
- **A.5** For the drag-drop redirect pattern (feature #4): any macOS code that intercepts an in-progress drag and redirects it to a file copy operation? `NSDraggingDestination` proxy windows, edge-of-screen drop zones, Finder / Yoink / Dropzone / Hazel behaviors — cite mechanisms.

##### B. Build platform / toolchain

- **B.1** Minimum Xcode version for a single binary targeting both macOS 12 Monterey (client) and macOS 15 Sequoia (server). Does Xcode 16 suffice?
- **B.2** Exact entitlements and Info.plist keys required on Sequoia 15 for an app that uses `CGEventTap` + Local Network. List every key. Note any TCC changes in macOS 15.0 through 15.4 that affect our APIs.
- **B.3** Apple notarization as of April 2026: current turnaround time, common rejection reasons for apps with Input Monitoring + Local Network, new hardened-runtime requirements since Sequoia shipped.
- **B.4** Can a solo developer with a $99/yr Apple Developer Program account ship a notarized app with these entitlements, or is an organizational account required? Cost delta if organizational is needed.
- **B.5** Is `MenuBarExtra` (SwiftUI, macOS 13+) usable here given Monterey target, or must we fall back to AppKit `NSStatusItem`? Best-in-class approach to a universal menu bar app targeting 12.0+.

##### C. IDE / AI tooling decision (KEY DECISION — highest ROI research)

- **C.1** As of April 2026, which AI-assisted Swift development environment produces the highest-quality output for a macOS app of this complexity? Compare:
  - **Cursor** (latest) — Swift support depth, Xcode interop (does it round-trip to Xcode for build/debug, or is it a standalone editor?)
  - **Claude Code CLI** (latest Anthropic release) — Swift support depth, multi-file refactor quality
  - **Xcode 16 + GitHub Copilot** — native integration quality
  - **Xcode 16 + Apple Intelligence / Predictive Code Completion** — is Apple's own AI now competitive?
  - **Windsurf / Codeium / Cody** — any ahead of the above for Swift?

  For each: pricing (April 2026), token/rate limits, Swift-specific benchmark evidence, and real workflow for "write → compile → debug in Xcode" round-trip.

- **C.2** Has Anthropic shipped a new Claude model release as of April 2026 (post Opus 4.6, which shipped Feb 6 2026) that meaningfully improves multi-file Swift / macOS app development? Model name, release date, context window, pricing, evidence of Swift-specific improvement. **Velorin already pays for Claude Max — if a better Claude model is included, this is free upside.**

- **C.3** Cursor specifically: what is the current (April 2026) integration story with Xcode? Does Cursor compile Swift itself, or do you hand off to Xcode? Can Cursor drive `xcodebuild` from its agent mode? Any Cursor-for-Swift extensions worth knowing.

- **C.4** "Claude's new security feature that sweeps code for security" — identify the Anthropic product CT is referring to. Candidates: Claude Code's security scanner, an Anthropic partnership with Snyk / Semgrep / GitHub Advanced Security, Constitutional Classifier for code, or a new Claude-for-security SKU. Report: what it is, how to invoke it (CLI flag / MCP tool / separate product), what class of issues it catches, pricing, and whether it's worth using on this project.

##### D. Leveraging Google AI Max (Gemini 2.5+)

Velorin has an active Google AI Max ($20/mo) subscription via CT. Trey1 and Trey2 are Gems on it. We want to use it where it beats Claude, not just where it's a second opinion.

- **D.1** For Swift / macOS development as of April 2026, where does Gemini 2.5 (or newer) outperform Claude Sonnet/Opus on: architectural review, security analysis, Apple API documentation lookup, code review, test generation? Cite benchmarks or well-sourced comparisons, not vendor marketing.
- **D.2** Recommended **multi-model workflow** for this specific project: which model for architecture draft, which for Swift implementation, which for security audit, which for user-facing copy. Justify each with evidence.
- **D.3** Is there a way to wire Gemini into the Claude Code CLI workflow (as an MCP server, via Aider, via a meta-orchestrator) so we're not context-switching manually?

##### E. Security audit tools

- **E.1** Beyond whatever Anthropic ships (C.4), what are the standard Swift static analysis / security tools in April 2026? SwiftLint, Apple's Thread/Address/UB sanitizers, any tools specifically for Input Monitoring / Accessibility abuse detection, any MCP-compatible tools that plug into Claude Code.
- **E.2** Supply-chain audit: as of April 2026, known CVEs or concerns with Sparkle, Network.framework, NetFS.framework, CryptoKit. Any framework-level drama we should know before committing.
- **E.3** Canonical Swift pattern for TLS 1.3 + certificate pinning with Network.framework. Reference implementation URL and known pitfalls.

##### F. Platform risk / longevity

- **F.1** Apple's trajectory on Accessibility + Input Monitoring APIs. Any deprecation signals from WWDC 2025 or developer forums? Any TCC tightening beyond Sequoia 15.4?
- **F.2** macOS 16 (expected announce at WWDC 2026, June 2026). Any leaked or announced changes that would break a KVM app architecture? Preview material if available.
- **F.3** MacBook Air 2017 hardware: Monterey is the confirmed OS ceiling. Apple's typical security-update tail for deprecated macOS versions is ~2 years after the last release. How much longer is Monterey a safe target for a production app? Practical EOL date estimate.

##### G. Shipping / distribution

- **G.1** GitHub Releases + Sparkle 2.x auto-update for notarized non-App-Store apps: minimum viable setup, known pitfalls, 2026-current example projects.
- **G.2** Privacy-respecting crash reporting / telemetry options for a self-hosted / direct-distribution Swift app. PostHog, Sentry self-hosted, Apple's XCOrganizer only — compare.
- **G.3** License recommendation for Velorin-internal use that preserves future Path 3 productization: MIT, BSD-2-Clause, keep closed-source private repo — which supports later commercial licensing without rewrites?

##### H. The drag-drop redirect (feature #4 — the novel one)

- **H.1** On macOS, can an app programmatically detect that an in-progress drag operation is about to exit the bounds of the active display? Which APIs, at what point in the `NSDraggingSession` lifecycle can we intercept?
- **H.2** Is there a clean pattern for an "invisible edge drop zone" — a transparent window pinned to the right edge of the Studio's right monitor that captures any drag that touches it, without interfering with normal intra-screen drag?
- **H.3** Existing macOS apps that do something similar (Yoink, Dropzone 4, Hazel, AirDrop's own edge behavior): study the mechanism, cite code if open source, or reverse-engineer the UX.

---

#### Deliverable format

- **Single markdown document.** Sections A–H matching questions above.
- **Every factual claim sourced** with a live URL. Scholarly, official Apple documentation, or reputable dev-blog sources preferred. Marketing pages only with corroboration.
- **For each code recommendation:** repo URL + specific file path + license + one-sentence rationale.
- **Confidence rating (0–100%) per claim.**
- **Final "Recommended Build Stack" section** that synthesizes A–H into a concrete decision tree with a clear top recommendation and the 2–3 most important open risks.

#### Hard constraints on Trey1

- Do not re-research whether to build this. Decision is made.
- Do not propose rebuilding Barrier from scratch without first answering A.2 (identify highest-leverage files to port).
- All recommendations must work on macOS 12 Monterey (Intel) as client AND macOS 15 Sequoia (Apple Silicon) as server. Ventura+ only = disqualified for the client side.
- Do not recommend paid tools without also giving the free / already-owned alternative.

---

*End of Trey1 prompt. Copy-paste block above into Trey1 Gem.*

---

## Part 10 — Immediate Next Actions

1. **CT** — paste §9 into Trey1 Gem, kick off Deep Research. Expected turnaround: 20–40 min for a run of this depth.
2. **Jiang (me)** — file companion request `Trey.ResearchRequest.VelorinKVMBridge.md` in `Bot.Trey/Research_Needed/` pointing to this doc, so Trey's inventory stays consistent.
3. **MarcusAurelius** — create the new repo `navyhellcat/velorin-kvm-bridge` (private) with empty `README.md` + `.gitignore` + MIT or TBD license placeholder. Do not scaffold code yet — wait for Trey's tooling recommendation.
4. **CT** — while Trey runs: enable native macOS File Sharing on the Mac Studio, create the `VelorinShared` folder, test mount from the Air. This is independent work and removes a dependency.
5. **CT + Jiang** — after Trey returns: 15-minute review session to lock IDE / protocol / model choices. Then spin up Jiang2 terminal for build.

---

## Part 11 — Risks and Mitigations

| Risk | Impact | Mitigation |
|---|---|---|
| Apple further tightens TCC in macOS 16 and breaks `CGEventTap` | v1.0 dies at next OS release | Monitor WWDC 2026 (June); design event layer with abstraction boundary so we can swap implementations |
| MacBook Air 2017 Monterey stops receiving security updates | Client machine becomes unsafe on LAN | Monterey EOL estimated post-2026; LAN is isolated, risk is bounded. Plan hardware replacement in 2027. |
| Pairing UX is clunky, user gives up during onboarding | Adoption fails even for CT | Invest in M7 (pairing) polish; pre-bake a scripted first-run wizard |
| Drag-drop redirect feels "wrong" — user expects native drag | Feature #4 underwhelms | Clear in-app explanation on first use; notification on receiving side confirms success; treat as "SMB dropbox" not "drag-drop" in copy |
| Trey research takes 3 days instead of 40 min, blocks build start | Schedule slips | CT can proceed with macOS File Sharing setup + repo creation in parallel; architectural work (C1–C3 spec) can be drafted by Jiang from Apple docs alone |
| Input Monitoring requires manual toggle, user forgets | App silently fails | Onboarding flow that polls TCC state, can't proceed until all 3 permissions granted |

---

[VELORIN.EOF]
