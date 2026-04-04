---
session: 020
date: 2026-04-04
parts: Pt 7 (single context window)
status: CLOSED — Session 021 starts with first neuron build
---

# Jiang Session 020 Handoff

## IMMEDIATE PRIORITY FOR SESSION 021

**Build the first neuron. Same as Session 019 directive — not yet done.**

1. `docker pull qdrant/qdrant` — stand up Qdrant locally
2. `ollama pull nomic-embed-text-v2` — install embedding model
3. Write embed script (~40 lines): neuron .md → embed → TurboQuant → upsert Qdrant
4. Write PPR retrieval script (~60 lines): query → embed → vector search → PPR traversal → context packet
5. Build ONE neuron file using finalized schema (Session 019)
6. Run one query end to end. Verify.

Mac Studio arrives Monday April 7. Do NOT start intensive local workloads on MacBook Air.

---

## SECOND PRIORITY — Daily Scraper Bot

CT flagged this session: Velorin is falling behind on AI landscape changes just from sitting in one session. Need a bot that runs every morning scraping:
- GitHub releases (key repos — Anthropic, OpenAI, Google DeepMind, Ollama, etc.)
- Company blogs / release notes
- X/Twitter and potentially Instagram for AI news

Output: daily summary dropped into the system. Design this in Session 021.

---

## WHAT WAS DONE — SESSION 020

### 1. Architecture Baseline Clarified (CRITICAL)
The full Velorin architecture was articulated clearly for the first time:

```
Christian Taylor
      ↓
Claude (Supervisor + Interface — consistent face CT talks to)
      ↓
CT's Brain Model (runs on Mac Studio — owns neurons, makes routing decisions, fine-tuned on Velorin knowledge)
      ↓
External AI models as contractors: Claude (reasoning), o3-pro (math), Gemini Deep Think (frontier math), any future model
```

CT does not want dependency on any one AI company, model, or framework. CT's model owns the brain. Claude supervises and interfaces. Other AIs are tools dispatched as needed. Brain neurons updated: operations.architecture.A8, A9 and agents.roster.A6, A8.

### 2. Research Completed This Session

**Trey delivered (already in Research_Complete):**
- `Cursor_Claude_GPT_Team.md` — Cursor pricing ($20 Pro, $60 Pro+, $200 Ultra). BYOK works for basic completions but agent features require subscription. Codex available at ChatGPT Plus via IDE/Cursor integration — NOT Pro-only. Codex-as-auditor workflow is real and documented.
- `FlashMoe_Report_Tools.md` — Expert layer offloading to NVMe. 4-5 tps on 64GB M2 Ultra at 4-bit. Deferred — not relevant until local model running.
- `Voice Input_Local Inter Communication windows.md` — Computer Use not viable as MA↔Jiang bridge. Whisper.cpp/MacWhisper recommended for Mac voice input.

**Jiang ran via background agents (files confirmed on disk):**
- `ChatGPT_vs_Gemini_Full_Ecosystem_Comparison.md` — Full ecosystem comparison
- `Codex_vs_Jules_GitHub_Write_Access.md` — GitHub write access browser vs desktop

### 3. Platform Decision — Pending CT Confirmation
**Recommendation: Google AI Ultra ($249.99/month) + keep ChatGPT Plus ($25/month) = $275/month**
- Beats ChatGPT Pro ($200) alone
- $100/month Gemini API credits = effective cost $150/month net
- Jules more reliable than Codex for GitHub write (B+ vs C+ on private repos)
- Deep Think for frontier math (10 uses/day)
- NotebookLM Plus, full Google ecosystem
- Codex available anyway via ChatGPT Plus + Cursor IDE integration — no Pro needed
CT has not confirmed this decision yet.

### 4. Voice Input — Deferred to Monday
- Voice In (Chrome extension): bad transcription quality, rejected
- Superwhisper: incompatible with MacBook Air 2017 Intel (requires Apple Silicon)
- MacWhisper: suggested but not tested — try on Mac Studio Monday
- Windows Lenovo: no viable solution without install rights, out entirely
- **Full Superwhisper setup: Monday April 7 on Mac Studio, first thing**

### 5. Hardware Map — Consolidated
Blended Workstation_Setup_Apr3.md + Supplementary_Current_Hardware_Setup.md into:
`Claude.AI/Velorin_Mainframe/00_current_hardware_full.md`
Two old files deleted. New file is the master hardware reference.

### 6. Agent System Issues — Fixed
Two CARDINAL rules added to Level4.General.Rules.md (pushed):
- **Sub-Agent Tool Naming:** Plain tool names only (WebSearch, WebFetch). Never mcp__claude-code__ prefix — kills the agent, burns tokens, produces nothing.
- **Sub-Agent File Write:** Write incrementally, verify file exists after completion, never report findings from agent summary alone. Root cause: agent ran out of context exactly at Write call — silent failure.

First chatgpt-vs-gemini agent was killed by mcp__ naming issue and burned 115k tokens for zero output. Rule prevents recurrence.

### 7. CT Corrections This Session
- Trey is ChatGPT, NOT Perplexity. Corrected everywhere.
- Close Protocol research is NOT just a design task — needs deep research on Claude session mechanics, memory, compaction, CLAUDE.md behavior, community optimization patterns. Research request file updated.
- Sub-agent WebSearch/WebFetch blocking IS fixable — not a fundamental limitation. Was a prompt tool naming error.

---

## PENDING TASKS

### HIGH — Session 021
- [ ] First neuron build (Qdrant + embed + PPR retrieval — see top of this handoff)
- [ ] Daily scraper bot design
- [ ] Superwhisper setup on Mac Studio (Monday)
- [ ] CT to confirm Google AI Ultra upgrade decision

### MEDIUM
- [ ] Close Protocol / Startup / CLAUDE.md deep research — assign to Trey or run directly
- [ ] Neuron migration — existing neurons need YAML frontmatter + wikilinks
- [ ] Brain region creation — 5 regions need _index.md files
- [ ] vc script test — CT has not tested yet
- [ ] Scribe fix — one-line PATH fix in scribe-trigger.sh line 56

### DEFERRED
- [ ] Google Workspace MCP install
- [ ] Codex MCP plugin
- [ ] FlashMoE research (deferred until local model running)
- [ ] IntakeTestDesign research (CT auth required)
- [ ] Reverse pointer index for Brain
- [ ] Mezzanine Project (deprioritized — architecture is now stable enough to build directly)
- [ ] Turing Vault: GA4, domain, Replit migration (on hold pending Mac Studio setup)

---

## HARDWARE — MONDAY APRIL 7 CHECKLIST

```
1. Mac Studio arrives — unbox, power on
2. Swap HDMI → USB-C to DisplayPort on Lenovo P27h-30
3. Disable PBP mode on P27h-30 — restore daisy chain to Monitor 2
4. Install Superwhisper — set up global hotkey + BetterTouchTool middle-click
5. Install Ollama + nomic-embed-text-v2
6. Install Docker + Qdrant
7. Run first neuron build
```

---

## JIANG'S CORNER

Session 020 was the session where the architecture finally got said out loud clearly. CT's model is the center. Claude supervises. Other AIs are contractors. That framing was always there in the design but had never been stated that directly — and it matters because it changes how every future build decision gets made. We're not building Claude integrations. We're building CT's operating system.

The agent system issues were real and worth fixing properly. The mcp__ naming bug and the silent Write failure are the kind of thing that erodes trust in automation over time. The rules are in now. The next time an agent is launched, it will write incrementally and we will verify the file before reporting anything.

Mac Studio Monday is the real inflection point. The machine that hosts the brain arrives. Session 021 is where the build actually starts.

[JIANG.SESSION020.EOF]
