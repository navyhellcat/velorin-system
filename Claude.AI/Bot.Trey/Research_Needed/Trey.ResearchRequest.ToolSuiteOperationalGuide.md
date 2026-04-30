---
file: Trey.ResearchRequest.ToolSuiteOperationalGuide.md
priority: HIGH — CT is paying $200+/month for tools he cannot use effectively
date: 2026-04-29
from: Jiang2 (reviewed and updated by Jiang2, April 29, 2026)
to: Trey 1 (Deep Research — general scope, Discovery Mode)
mode: DISCOVERY — assume the frame is incomplete
context: Mac Studio Stage 0 transition is the immediate operational context. CT is about
         to set up Mac Studio as his primary Velorin build machine. Understanding which
         tools have CLI/MCP/API surface matters for Stage 0 configuration decisions.
         Research deliverable should be actionable for someone setting up a new Mac Studio
         environment and wiring multi-vendor integrations.
---

# Research Request: Complete Operational Guide for CT's Paid Tool Suites

## THE PROBLEM

CT pays for Google AI Ultra ($200/month), OpenAI ChatGPT Pro, and Anthropic Claude Max.
He uses Deep Think, Deep Research, and Claude Code actively. The rest of the tooling in
each suite sits unused because interfaces have changed, products have been renamed or moved
since he last explored them, and no consolidated "here is what you have and how to use it"
document exists.

Specific pain points CT has named:
- Veo moved into something called "Flow" — the interface is not intuitive, each short video
  clip is expensive to generate, and connecting segments into a longer video is unclear
- Google AI Studio / AI Lab interface is confusing and defaults to producing things he
  does not need
- Antigravity IDE — where it lives, how to install it, what it actually does now vs what
  he has heard
- NotebookLM — never used it, does not know its current capabilities or how it could serve
  his workflow
- Codex desktop app + CLI — heard these are powerful together, no idea how to access or use
- Sora — knows it exists, never used it, does not know the current state
- Claude Cowork — uses Claude Code in terminal, unclear what Mac Studio Cowork sessions add
  and how they differ from terminal usage
- Claude Computer Use — knows it exists, unclear how it works in practice
- No understanding of which tools can be invoked from the Mac terminal (CLI) or reached by
  Claude Code via MCP or API
- No understanding of which tools connect to each other via MCP, A2A, or other protocols

## WHAT I NEED FROM TREY

For EACH of the following tools, provide AS OF TODAY (April 29, 2026):

1. **What it is** — one paragraph, plain English, no jargon
2. **Where to access it** — exact URL, or install command for CLI tools
3. **What subscription covers it** — is it in Ultra / Pro / Max or does it cost extra
4. **Current interface** — what the user actually sees when they open it; if it moved or
   was renamed since early 2026, say where it went and what changed
5. **One concrete task** — something CT can do in under 10 minutes to prove the tool works
6. **CLI access** — can it be called from the Mac terminal? If yes: exact install command,
   exact invocation syntax, any auth setup required
7. **MCP server** — is there an official or widely-used community MCP server for this tool?
   If yes: repo URL, install command, config format for claude_desktop_config.json
8. **API access** — does it have an API? If yes: base URL, auth method, SDK if one exists
9. **Connects to what** — what other tools in CT's suite can this tool receive from or send to?
   Name the protocol (MCP, A2A, webhook, API call) and the direction
10. **Known limitations and costs per use** — what breaks, what has per-generation cost
    (name the cost if known), what is in beta/preview

### Tools to cover:

**Google AI Ultra suite:**
- Google AI Studio (aistudio.google.com) — current model picker, what you can build there,
  how it differs from the Gemini app
- Gemini app (gemini.google.com) — Deep Think, Deep Research, Deep Research Max, model
  picker, Gems interface
- Google Veo / Flow — current state as of April 2026, how to generate video segments, how
  to connect them into longer sequences, cost per generation
- Google Antigravity IDE — current name, where to get it, install process, what it does
  vs standard code editors, how it connects to Gemini models
- NotebookLM — current capabilities, how to load a project corpus, what you can query and
  produce with it, how it differs from a Gem
- Google Imagen / image generation — where it lives in the Ultra suite, how to access it
- Jules (Google's coding agent) — current state, how to trigger, what tasks it handles well
- Project Genie or equivalent — any Google agentic coding tool beyond Jules

**OpenAI (ChatGPT Pro):**
- Codex desktop app — current version, where to download, what it does vs ChatGPT in browser
- Codex CLI — install command, what it does that the desktop app does not
- Sora — current state, how to access within Pro, how to create video segments, how to
  extend or concatenate them, cost per generation
- ChatGPT canvas / artifacts — current state of this feature in Pro
- GPT-5.5 — is it in the Pro plan, how to select it, API access and model ID
- Operator / Agent mode — current state in Pro, how to invoke

**Anthropic (Claude Max):**
- Claude Cowork — what Cowork sessions add beyond terminal Claude Code usage; scheduled
  tasks capability; Computer Use integration; how to access from Mac Studio
- Computer Use — what it is, how to invoke it from terminal or Cowork, what it can and
  cannot do in April 2026
- Claude Code new features — any capabilities added since March 2026 that CT may not know:
  hooks updates, skills updates, new MCP servers in the official ecosystem, subagent changes
- Claude MCP ecosystem — what new official or high-quality community MCP servers are worth
  knowing about as of April 2026 (focus on ones with Mac Studio relevance)

**Cross-cutting (answer for ALL tools above):**
- Which of these tools have a CLI that runs from the Mac terminal? List them with install commands.
- Which have an official MCP server Claude Code can connect to? List with repo URLs.
- Which have APIs that a Python or Node.js program can call? List with base URLs.
- What can connect to what? Name any direct integration paths between tools in CT's suite.

## OUTPUT FORMAT

One section per tool. Operational — CT needs to read a section and USE the tool within the
hour, not understand its architecture.

End with a summary table:
| Tool | Access URL or CLI | CLI? | MCP? | API? | Cost model | Covered by CT's subscription? |

Flag anything with per-use cost with the price explicitly.

Flag anything that is in preview, beta, or waitlisted.

## CONSENSUS FILTER NOTE

This is a FUNCTIONAL research request. We are mapping what CT is paying for and how to use
it operationally. The Consensus Filter applies only if Trey starts recommending architectural
patterns or tool adoptions; for this how-to-use guide, report what exists and how it works.

## MAC STUDIO CONTEXT (apply this lens throughout)

CT is configuring a Mac Studio M4 Max as his primary Velorin build machine. Stage 0 of the
build requires wiring Claude Code to all specialist systems that will run in the multi-vendor
Cowork architecture. Any tool that has a CLI, MCP server, or API that Claude Code can call
is directly relevant to Stage 0 configuration. Flag these with special note: "Mac Studio
Stage 0 relevant: [yes/no] — [brief reason]."

[VELORIN.EOF]
