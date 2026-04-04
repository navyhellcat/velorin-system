---
title: Architecture Clarity — Working Document
prepared_by: Jiang, Director of Strategic Intelligence
session: 016 | April 3, 2026
status: LIVE — updated this session
type: decision-support (not research output)
---

# Velorin Architecture Clarity — Working Document

This is not a research document. It is a decision support document.
Purpose: capture the strategic situation as of Session 016, what is now known, what is still open, and what decisions need to be made in what order.

Companion file: `Jiang.VelorinStackViz.Session016.html` — open in browser for the visual layer map.

---

## 1. The Actual Problem

Christian Taylor stated it directly this session: **too much conflicting research, too many competing technologies presented as alternatives, no clear picture of the foundation layer.**

The diagnosis: the confusion is not a research gap. It is a framing gap. Technologies like RAG, Graph RAG, vector databases, TurboQuant, Obsidian, and NotebookLM are being presented as competing architectural choices when they are actually **complementary layers of the same stack**. The decision paralysis is rational — you cannot make choices at the top of a stack when the foundation layer is unsettled.

The solution: a layered mental model first. Technology choices per layer second. The HTML visualization exists to give you that model.

---

## 2. New Intelligence — What Changed This Session

### TurboQuant (Google Research, March 25, 2026)
**What it is:** A 2-stage KV cache compression algorithm for LLM inference. Stage 1 (PolarQuant) applies random orthogonal rotation to normalize KV vectors for optimal quantization. Stage 2 (QJL) uses 1 residual bit to correct compression error.

**What it does:** 4-6x KV cache memory reduction. 4-bit: effectively indistinguishable from FP16 on 3B+ parameter models. 8x throughput improvement on H100 GPUs.

**Critical framing for Velorin:** TurboQuant works at the **inference layer** — it compresses KV caches on the hardware running the model. When you use Claude via API, Anthropic's servers handle this, not Velorin. TurboQuant becomes directly relevant to Velorin when **running local models** (the Apple M-series 36GB build). That is the right use case for it — not the current API-based architecture.

**Confidence: 91%** — well-documented, ICLR 2026 paper, open-source implementations already on GitHub.

---

### NotebookLM MCP — Fragile, Not Production-Ready
No official Google API or MCP server for NotebookLM as of April 2026.

Community implementations exist (notebooklm-mcp, khengyun/notebooklm-mcp on GitHub) but use undocumented internal APIs via browser cookie extraction. Google can break them at any time. **Do not build production Velorin systems on these.**

Current recommendation: use NotebookLM as a human-facing research tool. Feed it Jiang's research files manually. Query it directly. Do not attempt programmatic integration until Google publishes an official API.

---

### Google Workspace MCP — OFFICIAL, Production-Ready (March 2026)
**This is significant.** Google released an official Workspace CLI with a built-in MCP server.

Scope: 12 services, 100+ tools, OAuth 2.1.
Services: Gmail, Google Drive, Google Calendar, Google Docs, Google Sheets, Google Slides, Google Chat, Google Forms, Google Tasks (plus more).
Install: `npm install -g @googleworkspace/cli`
Security: includes `--sanitize` flag integrated with Google Cloud Model Armor for prompt injection scanning.

**Implication for Velorin:** Claude can now natively call Gmail, Drive, Docs, Sheets, Calendar, and 8 other Google services as MCP tools. This is the tool integration layer you described wanting — available now, official, no fragile workarounds.

---

### OpenAI Codex MCP — OFFICIAL Plugin for Claude Code
OpenAI published an official MCP server (`codex-plugin-cc`) that plugs directly into Claude Code.

**What it does:** Claude Code writes code, then hands it to Codex for review/feedback without leaving the Claude environment. Code review runs in a separate model context — eliminates sycophancy bias (Claude reviewing its own code). Pre-coding warnings become possible.

This is exactly what Christian Taylor described: offload code analysis from Claude's tokens to a specialized system that does it better. The infrastructure exists today.

Codex also has a plugin marketplace with 20+ pre-built integrations: GitHub, Gmail, Google Drive, Figma, Linear, Notion, Sentry, Slack, Cloudflare, Vercel, Hugging Face.

---

### The $200 Subscription Question — Resolved
Consumer subscriptions ($200 ChatGPT Pro, $200 Google AI Ultra, $200 Claude Max) give you **interfaces**.

The tools Christian wants — Codex code review, Google Workspace tools, cross-model decisions — run on **API keys + MCP server configuration**. These are priced per token, not per subscription.

What you actually need to buy:
- OpenAI API key (for Codex MCP — pay per token)
- Google account with Workspace (for Google Workspace MCP — no extra cost, uses OAuth)
- Anthropic API key (already have this via Velorin)
- Cursor subscription (legitimate — code execution environment with multi-model routing)

The $200 subscriptions may still have value for direct human-facing use of each interface. But for programmatic agent tool access — API keys are the right investment, not consumer subscriptions.

---

## 3. The Technology Stack — Layer Summary

See `Jiang.VelorinStackViz.Session016.html` for the full interactive visualization.

Quick reference:

| Layer | Name | Status | The Question |
|-------|------|--------|--------------|
| 6 | Interface & Multi-Model | PARTIAL | Agent Teams, Gemini 2.5 Pro, cross-model decisions |
| 5 | Tool Access & Orchestration | PARTIAL + NEW | Google Workspace MCP, Codex MCP — configurable now |
| 4 | Agent Identity & Memory | BUILT | FollowBench ceiling at ~3 constraints — known issue |
| 3 | Knowledge Graph / Brain | BUILT (4 gaps) | Reverse pointer index is highest priority gap |
| 2 | Retrieval & Search | **UNSETTLED** | RAG vs Graph RAG vs vector vs pointer traversal — THIS IS THE OPEN QUESTION |
| 1 | Compression & Efficiency | NEW | TurboQuant relevant for local inference only |
| 0 | Storage & Persistence | BUILT | GitHub + Drive + local filesystem |

Layer 2 is the unsettled layer. All other layers are either built, have a clear path, or have known answers.

---

## 4. Open Questions (Priority Order)

### Q1 — What is the right retrieval architecture for the Velorin Brain? [BLOCKING]
The Velorin Brain currently uses pointer traversal: you start at a known neuron, follow rated links. This works when you know where to start.

The gap: **what happens when you don't know which neuron to start from?** When you need to find a neuron by semantic similarity rather than by name?

Three options:
- Option A: Add a vector index as a search entry point (semantic search → neuron name → pointer traversal). The vector index does NOT replace the Brain — it is a search interface into it.
- Option B: Add Graph RAG as an extraction layer — automatically pull relationships from new research into the graph. More powerful but more expensive to build and maintain.
- Option C: Keep pointer traversal only, rely on well-named neurons and the `_index.md` files. Simpler. Breaks down at scale (50-80 topic documents).

This decision can be made after the bottom-of-funnel research. Not before.

### Q2 — Which Google Workspace tools does Velorin actually need? [MEDIUM PRIORITY]
100+ tools are available via the official MCP. This is too many to integrate blindly. Need to identify the 5-10 that are load-bearing for the Velorin workflow.

Candidates: Google Drive (already have separate MCP), Google Docs, Google Calendar, Gmail.

### Q3 — When does TurboQuant become relevant for Velorin? [LOW PRIORITY NOW]
When and if the local model build (Apple M-series 36GB) becomes active. Not before. Park this.

### Q4 — Obsidian's role [DEFERRED]
Obsidian is a human-facing visualization tool for linked markdown files. The Velorin Brain is already a linked markdown structure. Obsidian could provide graph visualization without changing the underlying file structure. Evaluate after the retrieval architecture question is resolved.

### Q5 — The FollowBench ceiling [DEFERRED TO ARCHITECTURE SESSION]
All Velorin agent boot files exceed the ~3 simultaneous constraint ceiling. Rules 4-N are operating probabilistically, not reliably. Structural fix required (AgentSpec/bootloader enforcement). This is a known issue, documented, not yet addressed.

---

## 5. Decisions Made This Session

1. **MCP is the right tool access architecture** — confirmed. The ecosystem is mature (1,864+ servers).
2. **Consumer subscriptions ≠ tool access** — confirmed. API keys + MCP configuration is the right investment.
3. **TurboQuant is inference-layer, not architecture-layer** — confirmed. Relevant only for local model deployment.
4. **NotebookLM is not yet programmatically accessible** — confirmed. Human-facing only for now.
5. **Google Workspace MCP is production-ready** — confirmed. Should be configured for Velorin.
6. **Codex MCP for Claude Code exists officially** — confirmed. Code review offloading is available today.
7. **Layer 2 (Retrieval) is the unsettled layer** — confirmed. All other layers have paths.
8. **Bottom-of-funnel research mandate is the correct next step** — confirmed. Will target Layer 2 specifically.

---

## 6. Next Steps (Ordered)

**Step 1 — Christian reviews HTML visualization**
Open `Jiang.VelorinStackViz.Session016.html` in browser. Build the spatial mental model before proceeding. This replaces 100 hours of YouTube.

**Step 2 — Configure Google Workspace MCP now**
This is available, official, and doesn't require research. `npm install -g @googleworkspace/cli`. Gives Claude immediate access to Gmail, Drive, Calendar, Docs, Sheets.

**Step 3 — Evaluate Codex MCP plugin**
Install `codex-plugin-cc` in Claude Code. Test code review offloading. Low risk, high payoff if it works as described.

**Step 4 — Bottom-of-funnel research mandate**
Jiang executes the full Layer 2 technology survey: RAG, Graph RAG, vector databases at current state, Obsidian architecture, what "adding a vector index to the Brain" actually looks like in code. Output: a decision document that lets Christian choose the retrieval architecture. This requires authorization to begin.

**Step 5 — Retrieval architecture decision**
After Step 4 research is complete, make the Layer 2 decision. Everything above Layer 2 is already built or has a clear path.

---

## 7. What This Document Does NOT Cover

- The full bottom-of-funnel technology survey (that is Step 4 above — not yet executed)
- The FollowBench architectural fix (separate architecture session)
- The reverse pointer index implementation for the Brain (separate build session)
- The local model inference build (future phase — TurboQuant relevant then)

---

*Working Document | Jiang | Session 016 | April 3, 2026 | Update each session until decisions are closed*

[VELORIN.EOF]
