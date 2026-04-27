---
class: c-memory
type: layer-research
layer: 5
layer_name: Tool Access & Orchestration
status: PARTIAL + NEW — significant new tools available as of March 2026
session: 016 | April 3, 2026
confidence: 82-88% (from AgentOrchestration) | 90%+ on new MCP findings
---

# Layer 5 — Tool Access & Orchestration
**Status: PARTIAL. Velorin's existing MCP servers are operational. Significant new official MCP servers available now that are not yet configured.**

---

## Full Research Document
`Claude.AI/Bot.Jiang/Jiang.Topic.AgentOrchestration.md` — full framework analysis, storage architecture, build vs. buy recommendation, cost model. Read this for complete orchestration strategy.

This file covers NEW intelligence from Session 016 not in AgentOrchestration.

---

## How Tool Access Works in Velorin
MCP (Model Context Protocol) is the standard. Claude calls external tools via MCP servers. Velorin has a gatekeeper MCP server that tracks all available tools and signals when agents boot.

Protocol: MCP adopted by Anthropic (original), OpenAI (March 2025), Google (late 2025). Cross-vendor standard. Building on MCP means the tool surface grows as the ecosystem grows.

---

## Current Velorin MCP Servers (Operational)
| Server | What It Does | Status |
|--------|-------------|--------|
| velorin-gatekeeper | Tool inventory, health check, brain lookup, path resolution | LIVE |
| velorin-gdrive | Google Drive R/W (search, read, create, update, overwrite, move) | LIVE |
| github | Full GitHub operations (files, issues, PRs, search, commits) | LIVE |
| filesystem | Local file operations (read, write, edit, list, search, move) | LIVE |
| browser-tabs | Chrome tab enumeration and navigation | LIVE |
| Claude_in_Chrome | Browser automation (navigate, click, read page, screenshot, JS) | LIVE |
| Claude_Preview | Preview panel for HTML/code rendering | LIVE |
| scheduled-tasks | Cron-style task scheduling | LIVE |
| mcp-registry | Search MCP registry for new servers | LIVE |
| bash | Direct shell command execution | LIVE |

---

## NEW — Available Now, Not Yet Configured

### Google Workspace MCP (OFFICIAL — March 2026)
**This is the biggest new tool surface addition available.**

Install: `npm install -g @googleworkspace/cli`
Auth: OAuth 2.1 (standard Google account)
Services: 12 Google services, 100+ tools

| Service | Available Tools (examples) |
|---------|---------------------------|
| Gmail | Read, send, search, label, thread management |
| Google Drive | Search, read, create, move, share |
| Google Calendar | Create events, read schedule, manage attendees |
| Google Docs | Read, create, edit, append |
| Google Sheets | Read, write, create, format |
| Google Slides | Read, create, add slides |
| Google Chat | Send messages, manage spaces |
| Google Forms | Create, read responses |
| Google Tasks | Create, update, list tasks |

Security: includes `--sanitize` flag with Google Cloud Model Armor for prompt injection scanning.

Source: cloud.google.com/blog | workspacemcp.com | WinBuzzer March 2026

**Action: Configure this. It is official, production-ready, and expands Claude's tool surface across the entire Google ecosystem.**

---

### OpenAI Codex MCP Plugin for Claude Code (OFFICIAL)
Package: `codex-plugin-cc` (published by OpenAI)
Install: via Claude Code plugin manager

**What it does:** Claude Code writes code → hands off to Codex for review → result returned without leaving Claude environment. Eliminates sycophancy bias (same model reviewing its own work). Pre-coding warnings become possible.

Codex plugin marketplace (as of March 2026): 20+ integrations including GitHub, Gmail, Google Drive, Figma, Linear, Notion, Sentry, Slack, Cloudflare, Vercel, Hugging Face — all one-click installable in Codex.

Source: unite.ai | community.openai.com | developers.openai.com/codex/mcp

**Action: Install in Claude Code. Offloads code analysis tokens from Claude to a specialized code review system.**

---

### Google Cloud MCP Servers (OFFICIAL — December 2025)
Managed remote MCP endpoints for Google Cloud services:
- Google Maps
- BigQuery
- Compute Engine
- Kubernetes Engine
- Expansion roadmap: storage, databases, logging, security

**Note:** Verify current GA status before building against these — announced December 2025 as "launching soon."

---

## The $200 Subscription Question — Resolved at This Layer

Consumer subscriptions (ChatGPT Pro, Google AI Ultra, Claude Max) = interfaces. Human-facing.

Tool access via MCP = API keys + MCP server configuration. Priced per token.

What Velorin needs:
- OpenAI API key → Codex MCP (pay per token)
- Google account with OAuth → Google Workspace MCP (no extra cost beyond existing Google account)
- Anthropic API key → already exists

Cursor ($200) is legitimately useful as a code execution environment with multi-model routing. This is the one subscription that maps to a real programmatic use case.

---

## NotebookLM — Current Status
No official Google API or MCP server as of April 2026.
Community implementations exist but use undocumented internal APIs via browser cookie extraction — Google can break them without notice.
**Do not build production Velorin systems on NotebookLM integrations. Use it as a human-facing tool.**

---

## Framework Recommendation (from AgentOrchestration, 82% confidence)
Build on Claude Agent SDK. Do not use CrewAI or LangGraph. Reasons:
- MCP is already Velorin's state persistence layer — Claude Agent SDK is MCP-native
- Agent Teams (February 2026) is already partially built
- Extended thinking is native
- No additional dependency on external framework governance

---

[VELORIN.EOF]
