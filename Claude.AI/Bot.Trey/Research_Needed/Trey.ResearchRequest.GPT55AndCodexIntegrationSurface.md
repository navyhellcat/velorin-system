---
file: Trey.ResearchRequest.GPT55AndCodexIntegrationSurface.md
purpose: Functional research — verify the actual integration surface for GPT 5.5 desktop and ChatGPT Codex as of April 2026, so Velorin's multi-vendor Cowork architecture can be designed against real capabilities, not assumed ones.
type: Trey research request (functional, NOT novelty audit)
date: 2026-04-26
from: Jiang
to: Trey (via GPT/Gemini Deep Research)
priority: HIGH — blocks Part 1 architecture for v2 multi-vendor cowork
---

# Trey Research Request — GPT 5.5 + ChatGPT Codex Integration Surface (April 2026)

## Why This Research Is Needed

Velorin's v2 architecture treats GPT 5.5 desktop and ChatGPT Codex as first-class Cowork agents alongside Claude, Gemini, and NotebookLM. The Build Guide's vendor routing program assumes:

- **A2A (Agent-to-Agent) protocol** connectivity between vendors via Cowork
- **MCP support** so vendors can share tool surfaces
- **Programmatic invocation** of GPT 5.5 from a Claude UI controller or vice versa
- **Codex coordination** for code-execution tasks routed by the vendor router

None of this has been verified against current OpenAI product reality. The Chairman's direct assessment is that GPT 5.5 desktop is "remarkable" and outpaces current Claude in some dimensions — making it an essential Cowork participant, not optional.

This is functional research, not novelty audit. We need to know what's actually buildable.

## Specific Questions to Answer

For each question, cite the source (OpenAI official docs, developer announcements, third-party verified, etc.) and date of the source. Flag anything unverified, scheduled but not shipped, or conflicting across sources.

### GPT 5.5 Desktop / API

**1. What is GPT 5.5 as a product as of April 2026?**
- Is "GPT 5.5" the model identifier or a product name? Confirm.
- Available surfaces: ChatGPT desktop app, ChatGPT Plus/Pro web, OpenAI API
- Model variants if any (Reasoning, mini, etc.)
- Stated capabilities (context window, multimodal, tool use, scheduled tasks, memory)

**2. API surface for GPT 5.5**
- Standard OpenAI Chat Completions API support? Responses API support?
- Tool use: function calling format, parallel function calls, streaming tool calls
- File upload / Files API support
- Computer use / browser tool support (similar to Anthropic's computer use)
- Agentic features: native scheduling, persistent memory, autonomous task execution

**3. Multi-agent / coordination protocols**
- A2A (Agent-to-Agent) protocol — is this an OpenAI-supported standard, an Anthropic-published standard adopted by OpenAI, or something else?
- MCP (Model Context Protocol) — does OpenAI support MCP servers in GPT 5.5 / ChatGPT?
- If yes: where does the MCP support live (API, ChatGPT app, Codex)? What MCP transport (stdio, SSE, HTTP)?
- Are there published patterns for OpenAI-Anthropic-Google multi-vendor agent coordination?

### ChatGPT Codex

**4. What is ChatGPT Codex as a product as of April 2026?**
- Confirm: is Codex a separate product surface, an agent within ChatGPT, a developer tool in the API?
- Where does it run (cloud, local, both)?
- Pricing model

**5. Codex capabilities**
- Programmatic invocation (API or CLI)
- File operations (read, write, edit local files)
- Bash / shell execution
- Git operations
- Long-running tasks / async execution
- Computer use (browser, desktop control)

**6. Codex integration with the broader ecosystem**
- Can Codex be invoked from a Claude Code session? From a Gemini CLI session?
- Does Codex expose itself as an MCP server or consume MCP servers?
- Cowork compatibility — can a Cowork-orchestrated session route a coding task to Codex specifically?

### Cowork Integration Surface

**7. What is "Cowork" as a product/protocol as of April 2026?**
- Confirm vendor: is Cowork an Anthropic product, a cross-vendor standard, an open-source framework, something else?
- Current product status (GA / beta / preview)
- What does "multi-vendor Cowork" actually mean operationally — same chat surface with multiple model backends? Coordinated agents with handoffs? Shared MCP namespace?

**8. Vendor compatibility within Cowork**
- Confirmed: does Cowork support Claude (yes, presumably) + GPT 5.5 + Codex + Gemini + NotebookLM?
- For each vendor, what's the integration mechanism (native API, MCP wrapper, browser automation)?
- Limitations on cross-vendor capability (e.g., file operations work across all vendors, or only on the host vendor)?

**9. Practical multi-vendor patterns**
What are people actually building with multi-vendor agent coordination in April 2026? Specifically:
- UI-controller-with-vendor-routing pattern (Velorin's design)
- Specialized-agent-per-task pattern
- Ensemble / verification patterns
- Handoff patterns

For each: published examples, common pitfalls, what's working and what isn't.

## Out of Scope

- Novelty audit on multi-vendor cowork as a pattern. Defer to end-of-cycle batched novelty pass.
- Detailed model-quality benchmarks (GPT 5.5 vs Claude vs Gemini on specific tasks). We care about integration surface.
- Pricing optimization. Capability first, cost noted.

## Format

Standard Trey research format. Sections:
1. Executive Summary (one paragraph: are GPT 5.5 + Codex genuinely integratable into a Velorin-style multi-vendor architecture as of April 2026)
2. Per-question answers with citations
3. **Critical compatibility matrix** — single table: rows = capabilities (MCP support, A2A, file ops, computer use, Cowork integration), columns = Claude / GPT 5.5 / Codex / Gemini / NotebookLM. Cell = supported / partial / no / unknown.
4. Recommendation (what's buildable today, what needs workarounds, what should wait until a specific vendor capability ships)
5. Confidence-weighted conclusions

## Velorin Consensus Filter

Apply the three questions explicitly:
1. What is consensus (how is multi-vendor agent coordination typically built today)?
2. Why does that consensus exist (which constraint shaped it)?
3. Does Velorin share that constraint, or is the Velorin architecture different enough that the consensus answer is wrong?

Particular concern: most published multi-vendor patterns are research demos or thin wrappers. Velorin needs production-grade reliability for a UI controller that orchestrates massive one-shot projects. Don't recommend a fragile pattern just because it's the published one.

[VELORIN.EOF]
