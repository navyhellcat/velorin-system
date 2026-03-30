---
class: research-request
priority: LOW (architecture gate)
assigned: Jiang
requested-by: MA + Alexander
date: 2026-03-30
---

# Research Request: Voice I/O — Anthropic vs OpenAI Parity

## Why This Matters

Trey flagged OpenAI Realtime API (WebRTC/WebSocket/SIP voice-first, low-latency) as potentially unique. His confidence that OpenAI has a meaningful advantage here was 60% — not high enough to make an architecture decision. If CT's product eventually needs voice-first input (capturing decisions in real-time, spoken intake sessions, ambient context capture), the infrastructure choice locks in early.

**The risk of getting this wrong:** Building the intake test on OpenAI's voice stack and then needing to switch because Anthropic ships equivalent capability — or vice versa.

## The Question

Is there currently a meaningful gap between Anthropic and OpenAI on voice I/O quality, latency, and reliability? If yes: in whose favor, and is it likely to close?

## Research Questions for Jiang

1. What is Anthropic's current voice I/O capability? Native API support? Third-party only? Estimated latency benchmarks?

2. OpenAI Realtime API — what does it actually provide that standard speech-to-text + LLM + TTS does not? Is the advantage in latency, context preservation across turns, or something else?

3. Are there production examples of voice-first personal AI intake (similar to Velorin's use case) built on either stack? What did they learn?

4. Trey's 60% confidence on OpenAI uniqueness — what would make that 90%? What evidence would close or maintain the gap estimate?

5. If CT wanted a voice intake session (user speaks, system responds, Layer 1-3 data captured in real-time) — which stack is more appropriate today?

## Deliverable

Short research note: `Jiang.Topic.VoiceIOParity.md`

Timeline: Before Phase 3 (first external user intake). The intake may or may not be voice-first — but the architecture decision should be made before building, not during.

[VELORIN.EOF]
