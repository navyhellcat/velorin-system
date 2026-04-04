# OpenClaw — Deep Dive Research
**Jiang | Session 016 | April 3, 2026**
**Commissioned by:** Christian Taylor (Chairman)

---

## What It Is

Open-source AI agent framework, MIT license. Built by Peter Steinberger (Austrian dev, founded PSPDFKit) in November 2025 as a weekend hack called "Clawdbot." Anthropic raised trademark concerns, renamed to OpenClaw. **247,000 GitHub stars and 47,700 forks as of March 2026** — outpaced Linux in GitHub growth velocity after January 2026 launch. Fastest-growing open-source project in the AI agent space right now.

---

## Core Architecture

**Hub-and-spoke.** One Gateway is the always-on control plane that binds to port 18789. It manages:
- Session state
- Channel routing (WhatsApp, Telegram, Discord, iMessage, Slack, macOS app, web UI, CLI)
- Tool dispatch
- Model calls

The Agent Runtime wraps the AI loop — assembles context from session history + memory, invokes the model, executes tool calls, persists state.

Everything runs **locally on your machine.** The Gateway is the only thing that touches the internet, and only to call model APIs.

---

## Multi-Model Support

All of these are natively supported. Config format is `provider/model-name`:

| Model | Config string |
|-------|--------------|
| Claude Opus 4.6 | `anthropic/claude-opus-4-6` |
| Claude Sonnet 4.6 | `anthropic/claude-sonnet-4-6` |
| Claude Haiku 4.5 | `anthropic/claude-haiku-4-5` |
| GPT-5.2 / Codex | `openai-codex/gpt-5.2` or `github-copilot/gpt-5.3-codex` |
| Gemini 3 Pro Preview | `google/gemini-3.1-pro-preview` |
| Gemini 3 Flash | `google/gemini-3-flash-preview` |

Provider priority when multiple are configured:
Anthropic → OpenAI → OpenRouter → Gemini → Groq → Mistral → Ollama
(overridable per-agent)

Minimal `openclaw.json`:
```json
{
  "agent": {
    "model": "anthropic/claude-opus-4-6"
  }
}
```

**ClawRouter** (`BlockRunAI/ClawRouter`) is a local proxy on port 8402 for smart routing — sends complex reasoning to Opus, routine tasks to Haiku. Users report 60%+ cost reduction. Maps directly to Velorin's agent specialization pattern.

---

## Skills Registry — ClawHub

**13,729 community-built skills** as of Feb 2026. Skills are markdown + code packages that teach the agent to use a tool. VirusTotal partnership scans every skill for malware. CLI-searchable via `clawhub search <term>`.

Relevant skills for CT's stack:
- **Obsidian skill** — parses markdown vault files, injects into LLM context as RAG. Entire Obsidian graph becomes queryable from any channel (phone, desktop, Telegram)
- **Google suite skills** — Drive, Sheets, Docs, Gmail
- **Browser automation** — Playwright-based
- **Coding agent skills** — Claude Code integration skills in ClawHub
- **Agent Orchestrator skill** — routes tasks to specialized sub-agents

Full curated list: `VoltAgent/awesome-openclaw-skills` (5,400+ categorized)

---

## Multi-Agent Architecture (Hub-and-Spoke)

Key community repos to study:

**TheSethRose/OpenClaw-Advanced-Config**
Production-ready multi-agent setup. One orchestrator ("Seth") delegates to specialized sub-agents:
- Linus — Coder (Docker)
- Finch — Research (Docker)
- Otto — Cron (Docker)

Each sub-agent has:
- `SOUL.md` — personality and delegation protocol
- `AGENTS.md` — sub-agent registry
- `TOOLS.md` — available tools
- Its own model assignment

**raulvidis/openclaw-multi-agent-kit**
Production-tested templates for 10-agent teams with Telegram supergroup integration and bot-to-bot communication.

**shenhao-stu/openclaw-agents**
One-command 9-agent setup with group routing and safe config merge.

---

## Obsidian Integration

The Obsidian skill does three things:
1. **Reads** — parses vault, injects as RAG context into any model
2. **Writes** — agent creates notes proactively without being asked, connects conversations from different channels
3. **Links** — agent reasoning shows up in Obsidian's knowledge graph, visible how thinking connects to existing notes

Multiple users report replacing $4K/month in labor with a $20/month agent setup after wiring in Obsidian as the memory layer.

Reference: `phenomenoner/openclaw-mem` — dedicated OpenClaw memory integration with Obsidian support.

---

## Enterprise Layer — NemoClaw (Nvidia)

Announced at GTC 2026 (March 16, 2026). Enterprise wrapper on top of OpenClaw. Adds:
- OpenShell sandboxing
- Declarative permissions (every network request, file access, model call passes through policies)
- Inference routing to run models locally (no data leaves your infra)
- Container-isolated agents

Accenture, Wipro, and Infosys all building on it. Nvidia's play: NemoClaw is free, but workloads run on DGX GPUs. Classic picks-and-shovels.

Currently in preview for DGX Cloud customers. GA for on-premises DGX targeted Q2 2026.

---

## How This Maps to Velorin

### What Velorin Already Has That OpenClaw Is Building Toward
- Named agent personas with boot protocols → their SOUL.md
- Specialized sub-agents with different models → their agent-per-Docker pattern
- Persistent memory system → their vector memory
- Hub-and-spoke orchestration → their Gateway

### What OpenClaw Has That Velorin Doesn't Yet
- Model-agnostic routing (GPT-5.2, Gemini, Codex, Claude in the same session)
- ClawHub skills library (13K+ drop-in tool packages)
- Native mobile/messaging channel access (Telegram, WhatsApp, iMessage)
- Community ecosystem and battle-tested community configs

### Velorin's Differentiator vs OpenClaw
OpenClaw memory = flat vector embeddings (LanceDB, Mem0, Cognee).
Velorin Brain = rated knowledge graph with synapse weights, activation patterns, and pointer decay.

This is architecturally more sophisticated. If CT ever builds on top of OpenClaw or forks it, the Brain is the genuine moat.

---

## Key GitHub Repos

| Repo | What It Is |
|------|-----------|
| `openclaw/openclaw` | Main framework (247K stars) |
| `openclaw/clawhub` | Skills directory |
| `openclaw/skills` | Official skills registry |
| `TheSethRose/OpenClaw-Advanced-Config` | Production multi-agent hub-and-spoke |
| `raulvidis/openclaw-multi-agent-kit` | 10-agent Telegram team kit |
| `BlockRunAI/ClawRouter` | LLM router (41+ models, <1ms routing) |
| `VoltAgent/awesome-openclaw-skills` | 5,400+ curated skills |
| `shenhao-stu/openclaw-agents` | 9-agent one-command setup |
| `centminmod/explain-openclaw` | Multi-AI architecture + security audit docs |
| `abhi1693/openclaw-mission-control` | Agent orchestration dashboard |

---

## Sources
- [openclaw/openclaw — GitHub](https://github.com/openclaw/openclaw)
- [OpenClaw model providers docs](https://docs.openclaw.ai/concepts/model-providers)
- [TheSethRose/OpenClaw-Advanced-Config](https://github.com/TheSethRose/OpenClaw-Advanced-Config)
- [BlockRunAI/ClawRouter](https://github.com/BlockRunAI/ClawRouter)
- [VoltAgent/awesome-openclaw-skills](https://github.com/VoltAgent/awesome-openclaw-skills)
- [Nvidia NemoClaw announcement](https://nvidianews.nvidia.com/news/nvidia-announces-nemoclaw)
- [NemoClaw — TechCrunch](https://techcrunch.com/2026/03/16/nvidias-version-of-openclaw-could-solve-its-biggest-problem-security/)
- [OpenClaw + Obsidian memory guide — Medium](https://agentnativedev.medium.com/openclaw-memory-systems-that-dont-forget-qmd-mem0-cognee-obsidian-4ad96c02c9cc)
- [OpenClaw Wikipedia](https://en.wikipedia.org/wiki/OpenClaw)
- [DigitalOcean — What is OpenClaw](https://www.digitalocean.com/resources/articles/what-is-openclaw)
