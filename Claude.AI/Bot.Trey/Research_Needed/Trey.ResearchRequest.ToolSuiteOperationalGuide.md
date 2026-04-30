---
file: Trey.ResearchRequest.ToolSuiteOperationalGuide.md
priority: HIGH — CT is paying $200+/month for tools he can't use
date: 2026-04-29
from: Jiang2
to: Trey (Deep Research)
mode: DISCOVERY — assume the frame is incomplete
---

# Research Request: Complete Operational Guide for CT's Paid Tool Suites

## THE PROBLEM

CT pays for Google AI Ultra ($200/month), OpenAI ChatGPT Pro, and Anthropic Claude Max. He uses Deep Think, Deep Research, and Claude Code. Everything else sits unused because the interfaces have changed, products have been renamed or moved, and nobody has written a "here's what you have and here's how to use each thing" guide.

Specific pain points CT has named:
- Veo moved into something called "Flow" — the interface isn't intuitive, each 8-second video costs a lot, he can't figure out how to connect segments into a longer video
- Google AI Lab / AI Studio interface is confusing and defaults to making bad websites
- Antigravity IDE — where is it, how to install it, what does it actually do now
- NotebookLM — never used it, doesn't know what it can do for Velorin
- Codex 5.3 + SeedDance 2.0 — heard they're great together, no idea how to access or use them
- Claude Managed Agents — new feature, never explored
- Claude Design System — new feature, never explored
- No understanding of what tools can be called via CLI, MCP, or API from his terminal
- No understanding of what "CLI" means operationally (he knows it's "command line interface" now but doesn't know which tools have one and what that gets him)

## WHAT I NEED FROM TREY

For EACH of the following tools, provide AS OF TODAY (April 29, 2026):

1. **What it is** — one paragraph, plain English
2. **Where to access it** — exact URL or install command
3. **What subscription includes it** — is it in Ultra/Pro/Max or does it cost extra
4. **Current interface** — what does the user actually see when they open it. If it moved or was renamed, say where it went
5. **One concrete task** — something CT can do in under 10 minutes to prove the tool works
6. **Can it be called from the terminal** — CLI, MCP server, API endpoint? If yes, give the install/setup command
7. **Can it connect to other tools** — MCP, A2A, webhook, API? What integrations exist
8. **Known limitations / gotchas** — what breaks, what costs money per use, what's in preview/beta

### Tools to cover:

**Google AI Ultra suite:**
- Google AI Studio (aistudio.google.com) — current models, interface, what you can build
- Gemini app (gemini.google.com) — current picker, Deep Think, Deep Research, Deep Research Max
- Google Veo / Flow — current state, how to make video, how to connect segments, cost per generation
- Google Antigravity IDE — where to get it, install, what it does
- NotebookLM — current capabilities, how to load a project, what it can do with uploaded documents
- Google Imagen / image generation — where is it now, how to access
- Project Genie — is this still a thing, what does it do
- Jules (Google's coding agent) — current state

**OpenAI (ChatGPT Pro):**
- Codex desktop app + CLI — current version, how to install, what it does vs ChatGPT
- Sora — current state, how to make video segments, how to connect them, cost
- ChatGPT with canvas/artifacts — what's the current state
- GPT-5.5 — is it in the Pro plan, how to access via API
- SeedDance 2.0 — what is it, where is it, how does it connect to Codex
- Operator / Agent mode — current state

**Anthropic (Claude Max):**
- Claude Managed Agents — what is it, how to use it, is it in Max
- Claude Design System — what is it, how to use it
- Claude Cowork — current state, scheduled tasks, Computer Use
- Claude Code — any new features since April that CT might not know about (hooks, skills, plugins updates)
- Claude MCP ecosystem — what new MCP servers are worth knowing about

**Cross-cutting:**
- Which of ALL the above tools have CLI interfaces that can be run from the Mac terminal
- Which have MCP servers that Claude Code can call
- Which have APIs that programs can call
- What can connect to what (e.g., can Codex CLI talk to Claude Code, can Antigravity call Claude models, etc.)

## OUTPUT FORMAT

One section per tool. Keep it operational — CT needs to be able to read a section and USE the tool, not understand its architecture. URLs, commands, screenshots descriptions where helpful. Flag anything that costs money per use (Veo generations, Sora seconds, etc.) with the price.

End with a summary table: Tool | Access | CLI? | MCP? | API? | Cost model | CT's subscription covers it?

## CONSENSUS FILTER NOTE

This is a FUNCTIONAL research request. We are not adopting architectures or frameworks — we are mapping what CT is paying for and how to use it. The Consensus Filter applies only if Trey starts recommending architectural patterns; for operational how-to-use guides, report what exists.

[VELORIN.EOF]
