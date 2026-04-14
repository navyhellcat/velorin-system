---
class: research-request
priority: LOW
assigned: Trey 1
requested-by: Jiang2 | authorized: Christian Taylor (Chairman)
date: 2026-04-13
session: 026
status: QUEUED
mode: Tight — specific use case, specific deliverable
confidence-threshold: 75%
---

# Trey Research Request — Barrier KVM and Cross-Mac Text Transfer

---

## THE SITUATION

Two Mac computers are on the same local network. They are on different Apple IDs.

- **Mac Studio M4 Max** (primary workstation, macOS Sequoia)
- **MacBook Air 2017** (secondary node, macOS Monterey)
- Connected via Cat6a Ethernet through a TRENDnet TEG-S750 10GbE switch
- Different Apple IDs: Universal Clipboard and Universal Control are not available

The need: move text, prompts, and documents between the two machines during work
sessions. The primary workflow is: write something on Machine A, need it on Machine B
within 10-30 seconds, without leaving the keyboard.

This is a practical research question. No AI or Velorin knowledge required to answer it.

---

## WHAT TO RESEARCH

### Section A — What Barrier Is

1. What is Barrier exactly? (It is an open-source KVM software tool, but describe
   the full picture: what it does, how it works at the protocol level, what it shares
   and does not share between machines.)
2. What was the original Synergy project, and how does Barrier relate to it?
3. What is the current maintenance status of Barrier? Is it actively maintained,
   abandoned, or forked into something else?
4. Does Barrier work between macOS Sequoia and macOS Monterey on the same LAN?
   Are there known compatibility issues?
5. What are Barrier's known failure modes and limitations?

### Section B — What Barrier Can and Cannot Do

1. Does Barrier share clipboard content between machines? If yes: text only, or also
   files and images?
2. Does it share keyboard and mouse control (KVM), or clipboard only?
3. Is there latency? What does typical clipboard sync speed look like over a local
   1GbE or 10GbE connection?
4. Does it require both machines to have the application running? What is the
   setup process?
5. What happens when the connection breaks — does it fail gracefully?

### Section C — Alternatives Worth Knowing About

What other tools exist for this specific use case (clipboard/text sharing between
two Macs on local network with different Apple IDs)?

Specifically evaluate:
1. **Input Leap** — a maintained fork of Barrier. What is its current status and
   how does it compare?
2. **Teleport** — a macOS-specific KVM tool. Is it maintained? Does it work
   between Sequoia and Monterey?
3. **Local clipboard sync via a shared network folder** — would a simple shared
   directory + a watchdog script be more reliable for text-only use?
4. **SSH clipboard forwarding** — what does `ssh -X` or `pbpaste`/`pbcopy` piped
   over SSH enable? Is this a practical workflow?
5. **Any other tools** that appeared in your research that were not listed here.

### Section D — Build vs Adopt

For the specific use case of moving text prompts (typically 100-5000 characters)
between two machines during work sessions:

1. What is the minimum viable custom solution that would reliably solve this?
   (e.g., a Python script that watches a designated folder and syncs its contents
   to the other machine via SSH/rsync, with a keyboard shortcut to trigger paste)
2. How does the build complexity compare to installing and configuring Barrier?
3. What are the failure modes of the custom approach vs. the Barrier approach?

---

## DELIVERABLE

Document: `Trey.Research.BarrierKVM.CrossMacTransfer.md`
Filed in: `Claude.AI/Bot.Trey/Research_Complete/`

Structure:

**Part 1 — What Barrier Is and Whether It Works**
Full description. Compatibility with Sequoia + Monterey confirmed or denied.
Clipboard behavior, latency, setup complexity.

**Part 2 — Input Leap and Other Alternatives**
Status and comparison for each alternative listed above.

**Part 3 — The Minimum Viable Custom Build**
If Barrier and alternatives are insufficient or overly complex, what is the
simplest custom solution that would reliably sync text between the two machines?
Describe the components, estimate the complexity, and state the failure modes.

**Part 4 — Recommendation**
Which approach best solves the specific use case (text prompt transfer, 100-5000
characters, sub-30-second latency, local network only)? State the recommendation
and the confidence level.

---

## CONSTRAINT

The MacBook Air 2017 runs macOS Monterey (not Sequoia). Some tools require recent
macOS versions. Compatibility with Monterey is a hard requirement — solutions that
only work on Sequoia are not viable for this use case.

---

[VELORIN.EOF]
