---
class: research-request
priority: HIGH
assigned: Trey 1
requested-by: Jiang | authorized: Christian Taylor (Chairman)
date: 2026-04-19
mode: Deep Research — broad survey + community intelligence, no single correct answer
confidence-threshold: 70%
destination: Claude.AI/Bot.Trey/Research_Complete/Trey.Research.AIEcosystemStateOfPlay.Apr2026.md
---

# Trey Research Request — AI Ecosystem State of Play (Last 4 Weeks)

## Context You Need First

You are Trey, the Velorin deep research agent. Before running this research, internalize the following context so your findings are framed toward what actually matters for us.

**What Velorin is:**
- A multi-agent AI operating system built around Christian Taylor's cognition
- Claude (Sonnet/Opus) is the orchestrator and primary intelligence layer
- Gemini (you, Trey) handles deep research and computation
- GPT handles tasks where it outperforms Claude
- The system runs on a Mac Studio and a Windows PC, coordinated via MCP servers
- The Brain is a neural file graph (neurons, pointers, PPR walks) — this is the memory architecture we are building toward
- We are pre-build. The MacStudio build is imminent. Every integration decision we make now has to be correct because retrofitting a live system is expensive.

**The specific problem:**
The AI landscape has shifted significantly in the last 4 weeks. ChatGPT and Gemini both now have desktop apps. Claude has added new capabilities. New frameworks, tools, and orchestration patterns have emerged. We don't know what we don't know. Before we build, we need a full picture of what exists, what works, what the community is actually saying (not what vendors claim), and what this means for how we wire Velorin together.

---

## Research Mandate

### Part 1 — Desktop App Landscape

**ChatGPT Desktop (Mac/Windows):**
- What can it actually do that the web version cannot?
- What integrations does it expose? (file system, OS hooks, keyboard shortcuts, MCP support, anything)
- What are users saying about bugs, limitations, and real-world performance?
- Does it have any API or automation surface, or is it purely UI?
- How does it compare to Claude Desktop in terms of capability and stability?

**Gemini Desktop / Google AI Ultra Desktop:**
- Same questions as above
- Any system integration capabilities?
- File system access, MCP support, anything that would matter for Velorin?
- Community reception — what are power users actually finding?

**Claude Desktop (current state):**
- What new tools, capabilities, or integrations have shipped in the last 4 weeks?
- MCP ecosystem: what new MCP servers are the community building and using?
- Computer use: what's the current state, stability, and real-world use cases?
- Agent SDK updates — any new patterns for multi-agent orchestration?
- Any reported regressions or stability issues?

### Part 2 — New AI Tools and Frameworks

Survey what has actually shipped and is being used in the last 4 weeks:

- New orchestration frameworks or major updates to LangGraph, CrewAI, AutoGen, or competitors
- New multi-agent architectures the community is building on
- New MCP servers that are relevant to Velorin (file management, browser control, memory systems, cross-platform)
- Any new memory or brain-like architectures that have emerged (relevant to what we're building)
- Cross-platform AI tools — anything that bridges Claude + GPT + Gemini at the application layer
- Local AI developments — what's shipping on Mac that's relevant to MacStudio deployment
- Any new voice/computer use/agentic frameworks that are gaining traction

### Part 3 — Community Intelligence

This is not what vendors announce. This is what's actually happening:

- What are AI power users and developers actually saying about multi-agent systems in practice?
- What's breaking? What are the real failure modes people are hitting?
- What orchestration patterns are working vs. proving to be dead ends?
- What's the current community view on Claude vs. GPT vs. Gemini for different task types?
- Any emerging consensus on how to wire multi-model systems together effectively?
- What are the most-used GitHub repos, Discord discussions, or Reddit threads revealing about actual usage patterns?

### Part 4 — Multi-Agent Multi-Platform Architecture

This is the most critical section for us. We need to build toward Claude orchestrating GPT and Gemini across large, long-running projects.

Research specifically:
- What patterns exist today for Claude orchestrating GPT calls? What works, what breaks?
- How are people currently using Gemini as a subagent or contractor under Claude orchestration?
- What are the latency, cost, and reliability tradeoffs people are hitting in multi-model systems?
- Are there any new protocols (beyond MCP/A2A) for cross-model communication that have emerged?
- What does high-quality multi-agent project management look like in practice right now? (not theory — what are people actually shipping)
- Any MacStudio-specific considerations for running this kind of system locally?

---

## Output Format

Structure your output as:

1. **Executive Summary** — 3-5 bullets of the most important findings for Velorin specifically
2. **Desktop Apps** — ChatGPT, Gemini, Claude each with: capabilities, limitations, community sentiment, Velorin relevance rating (High/Medium/Low)
3. **New Tools and Frameworks** — organized by relevance to Velorin, not alphabetically
4. **Community Intelligence** — what's actually working and what isn't, with sources/signals
5. **Multi-Agent Architecture** — what's practical now vs. 6 months away
6. **Velorin Build Implications** — your assessment of what this means for our MacStudio build decisions. Be direct. Flag anything that would cause us to change an integration plan.

Do not pad. Do not be encyclopedic. We need signal, not volume. If something is irrelevant to Velorin, skip it or mention it in one line.

[VELORIN.EOF]
