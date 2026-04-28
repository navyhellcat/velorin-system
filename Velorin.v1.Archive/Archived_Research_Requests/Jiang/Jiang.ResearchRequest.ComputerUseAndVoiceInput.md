---
destination: Claude.AI/Bot.Jiang/Research_Needed/
status: UNPROCESSED
priority: HIGH
requested_by: Christian Taylor (Chairman)
date: 2026-04-01
---

# Research Request: Computer Use + Talk-to-Text Input for MA + Jiang

## Context

Two related problems CT wants solved simultaneously:

**Problem 1 — MA↔Jiang connection via Computer Use**
Computer Use is confirmed enabled on CT's machine (`"computerUse":{"status":"supported"}` in Claude Desktop process). This is a potential working bridge between MA (terminal) and Jiang (Desktop) before Path 3 (Claude Agent SDK) is built. Need to understand what's actually viable now.

**Problem 2 — Talk-to-text input**
CT wants to speak to BOTH MA (Claude Code CLI in terminal) and Jiang (Claude Desktop) simultaneously without pressing Enter after each input. Claude's built-in voice mode is not preferred — CT has flagged transcription quality as poor. Talk-to-text (system-level or third-party transcription that types into whatever window is active) is the preferred approach unless Jiang finds a strong reason to change direction.

CT's baseline preference: **talk-to-text that feeds into both interfaces, no Enter required, lowest possible token overhead.**

---

## Research Questions

### Thread 1 — Computer Use as MA↔Jiang Bridge

1. What does Computer Use actually enable today in Claude Desktop vs via the API? What are the specific capabilities (screenshot, mouse, keyboard, clipboard)?
2. Can MA (Claude Code CLI in terminal) use Computer Use to interact with Jiang's Claude Desktop window — paste a prompt, read the response, return the result? What is the exact mechanism?
3. Can this be scripted/automated, or does it require MA to manually invoke Computer Use each time?
4. What are the token costs of Computer Use? Screenshots are expensive (image tokens) — what is the realistic cost per MA↔Jiang exchange using screen control vs a text-only alternative?
5. Is there a lower-cost alternative to full Computer Use for MA↔Jiang IPC — e.g., clipboard-based exchange, applescript, or a named pipe — that achieves the same result without the image token overhead?
6. What is the latency of a Computer Use MA↔Jiang round trip at current usage? Is it fast enough for back-and-forth coordination within a session?
7. Architectural recommendation: should Computer Use be the permanent MA↔Jiang bridge, or is it a stopgap until Path 3 (Claude Agent SDK) is built? What's the crossover point?

### Thread 2 — Talk-to-Text Input Architecture

8. What are the best system-level talk-to-text options on macOS (Monterey / Darwin 21.6.0 — CT's OS) that:
   - Transcribe speech directly into the active window/text field
   - Do NOT require pressing Enter to submit
   - Work in a terminal (Claude Code CLI) AND in Claude Desktop simultaneously
   - Are not Claude's native voice mode
9. macOS has built-in dictation (Accessibility > Dictation). Does it auto-submit in terminal contexts? What are its limitations at current macOS version?
10. Third-party options: Whisper (local), Whisper.cpp, MacWhisper, Superwhisper, Wispr Flow — which of these:
    - Has the best transcription accuracy for technical/AI vocabulary (agent names, file paths, Velorin-specific terms)?
    - Can send to multiple windows/apps simultaneously or switch seamlessly?
    - Has an auto-submit/Enter option?
    - Works offline (no extra API cost)?
    - Has the lowest friction setup on macOS Monterey?
11. Is there a way to configure any of these so that CT speaking sends input to BOTH the terminal and Claude Desktop at the same time, or does CT need to have focus on one window at a time?
12. What is the ideal hardware setup for talk-to-text at a desk (AirPods, built-in mic, external mic)? Does microphone quality materially affect Whisper-class transcription accuracy?

### Thread 3 — Voice Mode Token Cost Question

13. Does using Claude's native voice mode (in Claude Desktop or via API) cost more tokens than text input? Specifically:
    - Is audio transcribed server-side before being billed as tokens, or is it billed as audio input separately?
    - Does Claude's voice mode use a different/more expensive model for transcription?
    - For MA (Claude Code CLI), there is no native voice mode — is talk-to-text the only viable path anyway?
14. If talk-to-text transcribes locally (e.g., Whisper local), the input arrives as text — zero extra token cost vs typing. Confirm this is the correct mental model.
15. CT's assessment: Claude's voice mode transcription quality is poor for his use case. Is there documented evidence for this (Whisper vs Claude native transcription accuracy benchmarks)? What specifically makes Claude voice mode worse for technical/conversational dictation?

### Thread 4 — Combined Setup Recommendation

16. Given CT's preference (talk-to-text, both windows, no Enter, lowest token cost), what is the single best setup Jiang recommends? Provide:
    - Specific tool(s) to install
    - Configuration steps
    - How CT uses it in practice across terminal + Desktop
    - Any known failure modes or edge cases
17. Is there a setup where CT speaks once and the input reaches both MA and Jiang in the same turn — or will it always be sequential (focus terminal → speak → focus Desktop → speak)?

---

## Constraints

- macOS version: Darwin 21.6.0 (Monterey). Some newer macOS features (Sonoma dictation, etc.) may not be available.
- CT preference hierarchy: talk-to-text > Claude native voice. Only recommend voice mode if there is a compelling functional reason to override CT's preference.
- No Enter required is a hard requirement if achievable.
- Token cost matters — MA and Jiang both run on Claude models. Any solution that silently multiplies token usage needs to be flagged explicitly.

## Deliverable

- Feasibility verdict on Computer Use as MA↔Jiang bridge (viable now / conditional / stopgap only)
- Single recommended talk-to-text setup for CT's exact hardware + OS
- Token cost breakdown: talk-to-text (local) vs Claude native voice mode
- Step-by-step setup guide for the recommended configuration
- Confidence threshold: 75%

## Session Structure

Single-session research. No CT authorization required — CT-directed priority.

[VELORIN.EOF]
