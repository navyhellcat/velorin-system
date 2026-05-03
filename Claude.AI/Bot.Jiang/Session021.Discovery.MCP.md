---
document: Session 021 - MCP Ecosystem Discovery
session: "021"
date: 2026-04-05
status: DISCOVERY ONLY - research findings, not build decisions
author: Jiang (post-compact, five parallel Discovery Mode agents)
framing: |
  CRITICAL - Read this before reading anything else in this file.

  Everything in this file was found by five research agents running in
  Discovery Mode. None of it is a build decision. None of it is an
  adoption recommendation.

  The correct reading frame:
  "The community proved this is buildable. Now we understand how it works.
   Now we decide what Velorin builds, in Velorin's way, using Velorin's
   unique architecture."

  DO NOT read this file as "things to onboard."
  DO read this file as "things to understand deeply before designing."

  Velorin builds at the foundational level. Outside code is not adopted
  at the foundational level. Frameworks and architectural patterns can
  inform builds. Code is not imported at the foundation.
---

# Session 021 — MCP Ecosystem Discovery

## HOW TO USE THIS FILE

This file captures everything five parallel agents discovered about the
MCP ecosystem, agent protocols, and bridge architecture. For each finding:

1. What was found (factual — stars, names, capabilities)
2. What it proves (the architectural concept is viable — not "use this")
3. What is still surface-level (what Gemini Deep Research needs to go find)
4. Velorin build implication (what this means for what we design and build)

The Gemini Deep Research prompt for going deeper is at:
`Bot.Jiang/Working.Docs/Gemini.DeepResearch.MCP.Ecosystem.Prompt.md`

---

## SECTION 1: THE PROTOCOL LAYER

### Finding 1.1 — MCP Is Now Industry Standard Infrastructure

**What was found:**
MCP (Model Context Protocol) was donated by Anthropic to the Agentic AI Foundation
(Linux Foundation directed fund). Co-founded by Anthropic, Block, and OpenAI.
OpenAI joined the steering committee. MCP is in the OpenAI Responses API, the
OpenAI Agents SDK, and the ChatGPT desktop app. SDKs exist in Python, TypeScript,
Go (Google collaboration), C# (Microsoft collaboration), Java (Spring collaboration),
Kotlin (JetBrains collaboration), PHP, Swift, Ruby, Rust.

**What this proves:**
Agent-to-tool communication as a formal protocol layer is viable and necessary.
The spec exists. Multi-language implementations exist. Major vendors agree on the
protocol boundary.

**What is still surface-level:**
We do not know the wire format. We do not know the full message schema. We do not
know the transport layer details. We do not know the authentication spec. We do not
know the conformance requirements. We have not read the spec.

**Velorin build implication:**
Velorin needs a tool communication protocol. MCP proves the concept is right.
Before deciding whether to implement MCP natively or build a custom protocol,
Velorin must understand MCP's spec at the wire level. This is Tier 1 research
before any tool integration is designed. See Gemini prompt Part 1.

---

### Finding 1.2 — A2A Protocol (Agent-to-Agent Peer Delegation)

**What was found:**
Google built the A2A (Agent-to-Agent) protocol. Donated to Linux Foundation
June 2025. 150+ organizational supporters including OpenAI, Atlassian, Salesforce,
SAP, ServiceNow. Fills a gap MCP does not cover: MCP handles agent-to-tool
(structured I/O). A2A handles agent-to-agent as peers (autonomous delegation —
one agent assigns another agent a task without controlling its internals).
SDK exists in Python and JavaScript. `ai-boost/awesome-a2a` (550 stars) tracks
implementations.

**What this proves:**
Peer agent delegation as a formal protocol is viable and is being standardized.
The architectural distinction between "calling a tool" and "delegating to an agent"
is real and requires different protocol design.

**What is still surface-level:**
We have not read the A2A spec. We do not know the wire format. We do not know how
agent discovery works. We do not know the task lifecycle model. We do not know the
error handling patterns. We do not know how A2A handles long-running tasks.

**Velorin build implication:**
Alexander orchestrating Jiang, Trey, MA — this IS the A2A use case. Velorin has
been designing this pattern without knowing the protocol for it exists. Before
designing Velorin's agent delegation model, the A2A spec must be read and evaluated.
This does not mean Velorin implements A2A. It means Velorin understands what problems
A2A solves and how it solves them, then makes an informed design decision.
See Gemini prompt Part 2.

---

## SECTION 2: THE REGISTRY AND TIERING LAYER

### Finding 2.1 — Community Living Signal (The awesome-mcp-servers Equivalent)

**What was found:**
`punkpeye/awesome-mcp-servers` — 84,257 stars, updated daily (including today).
Backed by Glama.ai which auto-syncs and assigns quality scores. Tracks 45+ categories.
Has official vs community badges, scope badges (Cloud/Local/Embedded), OS badges.
Companion lists: awesome-mcp-clients, awesome-mcp-devtools.
Adjacent ecosystem: `appcypher/awesome-mcp-servers` (5.4K, stale), `wong2/awesome-mcp-servers`
(3.9K, backed by mcp.so), `jaw9c/awesome-remote-mcp-servers` (1K, remote-specific),
`rohitg00/awesome-devops-mcp-servers` (970, DevOps-focused).

**What this proves:**
A community-maintained living signal for a plugin ecosystem is viable and achieves
massive adoption. The awesome-* pattern works at scale for plugin/tool discovery.
Quality signals can be embedded in the living signal (Glama scores).

**What is still surface-level:**
We do not know how Glama scores are calculated. We do not know the methodology.
We do not know how the official-vs-community badge is determined.
We do not know the update frequency mechanics.

**Velorin build implication:**
Velorin's skill registry already uses awesome-claude-code as its living signal.
The same pattern applies to Velorin's MCP registry. Velorin does not adopt
punkpeye — Velorin builds its own registry with its own living signal monitor
that reads punkpeye (and similar) to discover candidates. punkpeye is an INPUT
to Velorin's discovery process, not the registry itself. See Gemini prompt Part 3.

---

### Finding 2.2 — Official Registry (The npm Equivalent)

**What was found:**
`modelcontextprotocol/registry` — 6,638 stars. Official Anthropic-backed registry.
Co-maintained by Anthropic, GitHub, PulseMCP, Stacklok. Self-hostable via Docker + Go.
Stable API (v0.1 frozen October 2025). CLI publisher tool (`mcp-publisher`).
Preview launched September 2025. Positioned as the canonical app store for MCP.

**What this proves:**
A self-hostable, versioned, stable registry for tool/plugin ecosystems is buildable.
The design exists. The API is public and stable.

**What is still surface-level:**
We do not know the registry's data model. We do not know the full API surface.
We do not know how entries are added/removed/updated. We do not know the
authentication model for publishing. We have not read the registry spec.

**Velorin build implication:**
Velorin needs its own private registry for its MCP tier. The official registry
proves the concept. Velorin reads the registry spec to understand the data model
and API design, then builds its own version adapted to Velorin's tiering system.
Self-hosting is the correct path — no dependency on Anthropic's infrastructure
at the registry layer. See Gemini prompt Part 3.

---

### Finding 2.3 — Package Manager Architecture

**What was found:**
`pathintegral-institute/mcpm.sh` — 919 stars. CLI package manager for MCP servers.
Positioned as "npm for MCP." Cross-platform. Manages install, update, remove
of MCP server configurations. `mcp-get/community-servers` backs another CLI registry.
`milisp/mcp-linker` syncs MCP configs across Claude Code, Cursor.
`OldJii/mcp-dock` — cross-platform GUI manager for Cursor, Claude, Windsurf, Zed.

**What this proves:**
Package management for AI tools is a solved problem at the design level.
Config sync across clients is a needed capability that the community has built.

**What is still surface-level:**
We do not know how mcpm.sh stores configs. We do not know its install mechanics.
We do not know how it handles version conflicts.

**Velorin build implication:**
Velorin's skill registry recheck system (8-hour passive check, active flag) is
analogous to a package manager. The package manager pattern can inform the design
of Velorin's registry update mechanics. Read mcpm.sh's architecture before
finalizing the passive recheck design. See Gemini prompt Part 3.

---

### Finding 2.4 — Quality Gate and Security Scoring Systems

**What was found:**
Glama.ai scores are the de facto quality signal — embedded as badges in punkpeye.
Security audit tools exist: `AgentSeal/agentseal`, `apisec-inc/mcp-audit`,
`HeadyZhang/agent-audit` (49 rules, OWASP Agentic Top 10 2026),
`HarmonicSecurity/claudit-sec` (macOS), `Adversis/mcp-snitch` (real-time intercept),
`peg/rampart` (policy engine firewall for AI agents).
OWASP Agentic Top 10 (2026) has been published.
`harishsg993010/damn-vulnerable-MCP-server` — intentionally vulnerable training server.
**66% of scanned MCP servers have security findings.**

**What this proves:**
Quality gates and security scanning for AI plugin ecosystems are buildable and necessary.
The security surface of MCP-based systems is non-trivial and documented.

**What is still surface-level:**
We do not know the OWASP Agentic Top 10 items. We do not know how Glama scores
are computed. We do not know what the 66% finding methodology was.

**Velorin build implication:**
Velorin's MCP registry admission process must include security scanning.
The Skill Registry's quality gates (stars, last commit, parseable) are a starting
point but insufficient for MCP servers. Read the OWASP Agentic Top 10 before
designing the security layer of Velorin's registry. See Gemini prompt Parts 3 and 9.

---

## SECTION 3: THE MULTI-MODEL BRIDGE LAYER

### Finding 3.1 — Multi-Model Bridge Architecture

**What was found:**
`BeehiveInnovations/pal-mcp-server` — 11,400 stars, 973 forks, 1,150+ commits.
Connects Claude Code, Codex CLI, Cursor to: Anthropic, Google, OpenAI, Azure,
Grok, OpenRouter, Ollama, custom endpoints via one MCP server. Context flows
across model calls. Built-in: chat, consensus (multi-model agreement), planner,
deep thinking, code review, precommit, debug, refactor, security audit.
"Clink" feature: CLI-to-CLI bridging with isolated sub-agent contexts.

`religa/multi_mcp` — parallel calls to GPT, Claude, Gemini via asyncio.gather().
Gets all responses in slowest-model time, not sum. Specialized for code review,
compare, debate patterns.

`sjquant/llm-bridge-mcp` — single run_llm() tool accepting model_name, prompt,
temperature. Supports OpenAI, Anthropic, Google, DeepSeek. Pydantic AI based.

**What this proves:**
Multi-model routing with cross-model context persistence is buildable. The routing
layer can sit at the MCP layer. Parallel multi-model calls are viable.

**What is still surface-level:**
We do not know PAL's routing algorithm. We do not know how cross-model context
is serialized. We do not know how the consensus mechanism works algorithmically.
We do not know how "clink" achieves sub-agent context isolation.

**Velorin build implication:**
Velorin's multi-agent system will route tasks across Claude, Gemini, and potentially
GPT. Velorin builds its own routing layer using Velorin's tier model and GPS
navigation. PAL proves the concept. Velorin does not use PAL — Velorin understands
PAL's architecture and builds a routing layer that matches Velorin's unique structure.
See Gemini prompt Part 4.

---

### Finding 3.2 — Cross-Provider Adversarial Review Pattern

**What was found:**
`openai/codex-plugin-cc` — Published under the official OpenAI GitHub org.
First-party tool from a competitor to extend the rival's product. Exposes Codex CLI
as an MCP server consumed by Claude Code. Slash commands: /codex:review,
/codex:adversarial-review, /codex:rescue, /codex:status, /codex:result, /codex:cancel.
The "grading your own homework" problem: different models have different failure modes.
Cross-provider review catches what single-model review misses.

**What this proves:**
Cross-provider adversarial review is a viable and valued architectural pattern.
The pattern is valued enough that a competitor built an official tool to enable it.

**What is still surface-level:**
We do not know how the adversarial review prompt is constructed. We do not know
what makes adversarial review from a different model better than the same model.

**Velorin build implication:**
Velorin's build process (especially Tier 1 program development) should include
an adversarial review step. This does not require Codex. Velorin designs an
adversarial review pattern into its build workflow using whatever models are available.
The pattern is: writer and reviewer are different models. That is the insight.

---

## SECTION 4: THE BROWSER AUTOMATION BRIDGE LAYER

### Finding 4.1 — The Foundation Layer

**What was found:**
`microsoft/playwright-mcp` — 30,308 stars. Microsoft owns both Playwright and
co-developed MCP. The foundational layer that most unofficial bridges build on.
Two modes: accessibility-snapshot (no vision model needed) and screenshot mode.
Official Puppeteer MCP is dead — deprecated by the MCP team in favor of Playwright.

`browser-use` (underlying library) — ~86,000 stars. Most-starred AI browser
automation library. MCP-wrapped via `Saik0s/mcp-browser-use`.

**What this proves:**
Browser automation as a bridge mechanism is mature infrastructure with institutional
backing. The pattern is production-viable, not experimental.

**What is still surface-level:**
We do not know how Playwright MCP translates MCP tool calls to Playwright operations.
We do not know the accessibility-snapshot mode architecture. We have not profiled
the stability characteristics in production.

**Velorin build implication:**
When Velorin needs to bridge a closed system, Playwright is the correct foundation.
Puppeteer is eliminated. Velorin does not adopt Playwright MCP as-is — Velorin
builds specific bridges using Playwright as the underlying tool, wrapped in
Velorin's own MCP-compliant server structure. See Gemini prompt Part 5.

---

### Finding 4.2 — ApiTap — The Architectural Alternative to Browser Automation

**What was found:**
`n1byn1bt/apitap` — 78 stars, but conceptually the most significant bridge finding.
Does NOT use browser simulation. Sniffs the internal API calls a website's own
JavaScript makes. Learns those endpoints. Calls them directly. Returns clean JSON.
Works on any modern React/Next.js/Vue SPA. Discovery pass uses logged-in Chrome
session once. Every subsequent call is a direct API hit. 20-100x cheaper than
browser automation. Reusable "skill files" per site.

**What this proves:**
For modern web applications, direct API endpoint discovery is architecturally
preferable to browser automation. The browser is only needed for the discovery pass.
This is a fundamentally different approach with dramatically better economics.

**What is still surface-level:**
We do not know the discovery algorithm. We do not know what sites this fails on.
We do not know how "skill files" are structured. We do not know the failure conditions.
We do not know what happens when a site changes its internal API.

**Velorin build implication:**
Before building any browser automation bridge, Velorin evaluates whether ApiTap's
approach works for the target system. If the target is a modern SPA, the direct
endpoint discovery approach is superior. This is a decision tree, not a default.
Read the ApiTap architecture before finalizing any bridge design. See Gemini prompt Part 5.

---

### Finding 4.3 — The Anti-Detection Layer

**What was found:**
Camoufox — Firefox modified at C++ level (not JS injection, which is detectable).
Multiple MCP wrappers exist. Patchright — patched Chromium, anti-detection focused.
LinkedIn bridge switched to Patchright in February 2026 when LinkedIn improved
bot detection. The switch demonstrates an arms race: standard Playwright gets caught
→ anti-detect Playwright → C++ modified browser.

**What this proves:**
Anti-detection browser automation is a distinct architectural tier with different
tools and stability properties. The arms race is real and ongoing.

**What is still surface-level:**
We do not know how Camoufox modifies Firefox at C++. We do not know what specific
fingerprint signals are modified. We do not know the current state of detection
countermeasures and which bypass techniques work as of April 2026.

**Velorin build implication:**
Anti-detection is a last resort tier for Velorin bridges, not a default. If a
standard Playwright bridge gets detected, the upgrade path is Patchright, then
Camoufox. The tier decision is automatic based on detection failure events.
This maps to Velorin's passive/active replacement pattern from the Skill Registry.
See Gemini prompt Part 5.

---

## SECTION 5: THE SPECIFIC SYSTEMS DISCOVERED

### Finding 5.1 — Qdrant Has an Official MCP Server

**What was found:**
`qdrant/mcp-server-qdrant` — 1,321 stars. Official Qdrant-maintained MCP server.

**What this proves:**
Velorin's vector database (Qdrant) is already MCP-addressable via an official
server maintained by Qdrant themselves.

**What is still surface-level:**
We do not know the full capability scope of the Qdrant MCP server. We do not know
whether it exposes all the operations Velorin's Brain needs.

**Velorin build implication:**
The Brain can be MCP-addressable from day one using the official Qdrant server.
Evaluate whether this server covers Velorin's use cases or whether a custom
Brain MCP server is needed. This is a decision for after the Brain is built.

---

### Finding 5.2 — NotebookLM Has a Production Bridge

**What was found:**
`jacob-bd/notebooklm-mcp-cli` — 3,282 stars, updated April 5 2026 (today).
`PleasePrompto/notebooklm-mcp` — 1,778 stars. Multiple competing implementations.
`Pantheon-Security/notebooklm-mcp-secure` — adds 17 security hardening layers.
Six total implementations, all actively maintained.

**What this proves:**
Browser automation bridges to closed systems achieve production-scale adoption.
The "no official API" limitation is not permanent — the community bridges it.

**What is still surface-level:**
We do not know the stability profile of this bridge under Google UI changes.
We do not know the security implications of the browser automation approach.

**Velorin build implication:**
NotebookLM can serve as a human-facing documentation companion for Velorin.
If Velorin builds its own local NotebookLM equivalent (which the community has
also built — Docker + open-weights models + local vector DB), the bridge is not
needed. The local clone is architecturally superior for Velorin's independence goal.

---

### Finding 5.3 — Google Workspace Has a Community MCP Server

**What was found:**
`taylorwilsdon/google_workspace_mcp` — Covers 12 services in one MCP server:
Gmail, Drive, Calendar, Docs, Sheets, Slides, Forms, Chat, Apps Script, Tasks,
Contacts. OAuth 2.1, remote multi-user auth, 1-click installer.

**What this proves:**
A single MCP server can wrap an entire productivity suite. The pattern of
"one server, multiple integrated services" is viable.

**What is still surface-level:**
We do not know the architecture of how 12 services are wrapped in one server.
We do not know the OAuth flow. We do not know the failure modes.

**Velorin build implication:**
CT uses Google Workspace. Velorin may eventually need Google Workspace integration.
When the time comes, this server is the reference implementation to read and
understand before building Velorin's own integration.

---

## SECTION 6: THE GOOGLE AI ULTRA SUITE (CORRECTED PICTURE)

### Finding 6.1 — Jules Is a Programmable Async Coding Agent

**What was found:**
Jules is a fully separate product (not a Gemini feature). Async by design.
Provisions Google Cloud VMs, clones repos, installs dependencies, writes/tests code,
submits PRs. REST API launched October 2025 (alpha). Can be embedded in Slack,
Linear, CI/CD. Ultra tier: ~300 tasks/day, 20 concurrent. Has a CLI/TUI.
Triggered by `@jules` label on GitHub issues. github Action: `google-labs-code/jules-action`.
Gemini CLI can call Jules via extension (`gemini-cli-extensions/jules`).

**What this proves:**
Async cloud-based coding agents with GitHub integration are viable infrastructure.
The Jules API makes this programmable, not just UI-driven.

**Velorin build implication:**
Jules is a candidate for Velorin's Tier 1 "grunt work" automation (tests, dependency
bumps, linting). The decision of whether to use Jules or build Velorin's own equivalent
requires understanding Jules' architecture. Jules API: assess after Brain is built.

---

### Finding 6.2 — Deep Think vs Deep Research vs Agent Mode — Resolved

**What was found:**
Three distinct execution modes — not the same product:

Deep Think: System 2 reasoner. Evaluates up to 16 simultaneous logical paths.
Reinforcement learning. Slow, methodical. Best for: complex math, algorithms,
multi-step logic. Ultra-only, US-only. API: available as reasoning mode within
Gemini models, not a standalone endpoint.

Deep Research: Async web-browsing synthesizer. Spawns sub-agents to scour internet,
read PDFs, synthesize reports. Takes several minutes. Available via Interactions API
(beta, `deep-research-pro-preview-12-2025`). Known bug: complex prompts get stuck
`in_progress` indefinitely.

Agent Mode: ReAct loop running inside Gemini Code Assist (VS Code) and Gemini CLI.
Reads/writes files, runs terminal commands, connects to LOCAL MCP servers.
This is Gemini's equivalent of Claude Code's agentic mode.

**Velorin build implication:**
Deep Think is the right mode for the compression math session (hours 9-11).
Trey should be running Deep Research for landscape research tasks (the multi-part
research prompts). Agent Mode is the surface for Trey's operational work on Velorin.
Gemini CLI (not the web app) is Trey's correct primary surface.

---

### Finding 6.3 — Gemini CLI Is Open-Source and Fully Capable

**What was found:**
Official Google Gemini CLI: `github.com/google-gemini/gemini-cli`. Open-source.
ReAct loop. Built-in tools: Shell, ReadFile, WriteFile, EditFile, ReadFolder,
FindFiles, SearchText, WebFetch, GoogleSearch, SaveMemory, WriteTodos.
Full MCP client — connects to any MCP server. 1M token context. Can call Jules
via extension. Free: 60 requests/min, 1,000/day via free Gemini Code Assist license.

**Velorin build implication:**
Gemini CLI is Trey's boot surface on Gemini — not the web app. Trey reads from
GitHub via CLI, runs research tasks, calls Jules for async code tasks. The Trey
Gemini boot protocol should be built for Gemini CLI as the primary surface.

---

## SECTION 7: THE OPENAI/GPT ECOSYSTEM

### Finding 7.1 — MCP Is Not Claude's Protocol

**What was found:**
Anthropic donated MCP to Linux Foundation. OpenAI co-founded the Agentic AI
Foundation. OpenAI joined the MCP steering committee. OpenAI's Responses API
supports calling remote MCP servers natively. OpenAI's Agents SDK officially
supports MCP. OpenAI has MCP documentation at developers.openai.com.

**What this proves:**
MCP is neutral infrastructure. It is not Anthropic's property. Building on MCP
is not creating an Anthropic dependency.

**Velorin build implication:**
If Velorin builds its own protocol layer (custom agent-tool communication),
MCP is the reference spec. If Velorin implements MCP natively, it is building
on neutral ground. The decision is architectural, not vendor loyalty.

---

### Finding 7.2 — The OpenAI API Stack Has Changed

**What was found:**
Three API tiers now:
1. Chat Completions API — stateless, indefinitely supported, manage state yourself
2. Responses API (March 2025) — server-managed state, natively supports MCP, web search,
   code execution in one call. Recommended primary API for agents.
3. Assistants API — BEING SUNSET August 2026. Do not build on this.

GPT Actions — effectively deprecated. Superseded by Responses API + Agents SDK.

OpenAI Agents SDK — open source, provider-agnostic (100+ LLMs), Python + TypeScript.
Handoffs, guardrails, tracing, sessions. Production successor to Swarm.

AgentKit — sits on top of Agents SDK. OpenAI-model-ONLY. Vendor lock-in by design.

**Velorin build implication:**
If Velorin ever integrates GPT as a secondary model, the Responses API is the
correct surface. The Agents SDK is interesting as reference architecture for
Velorin's own agent orchestration layer — it's provider-agnostic and open-source.
AgentKit is never relevant to Velorin.

---

## SECTION 8: THE DEVELOPER TOOL LANDSCAPE

### Finding 8.1 — OpenCode (120K Stars) and the Architecture It Proves

**What was found:**
`opencode-ai/opencode` — 120,000+ GitHub stars as of March 2026. Go binary, <200ms
startup, zero dependencies. 75+ LLM providers. LSP integration (Language Server
Protocol — gives AI the same code intelligence as an editor: jump-to-definition,
find-references, type information). Terminal-based. Grew 18,000 stars in two weeks
in January 2026 (partly responding to Anthropic blocking third-party consumer auth).

**What this proves:**
A zero-dependency, provider-agnostic, LSP-integrated coding agent is buildable.
The architecture: Go binary + LSP + provider abstraction layer. The speed and
independence are achieved through architectural choices (Go, no framework, direct
LSP integration).

**Velorin build implication:**
OpenCode's architecture is a reference for how to build independent tooling.
The Go binary + LSP approach is worth understanding for Velorin's own build tooling.
The 120K star signal tells us what the developer community values: speed,
independence, no vendor lock-in. These are Velorin's values. The architectures align.

---

### Finding 8.2 — Claude Code Has More Capability Than We Were Using

**What was found:**
12 hook events (not just the ones we knew about). Key undisclosed capabilities:
- Elicitation hook (March 2026): Claude pauses autonomous workflows to gather
  information without breaking context, then resumes.
- async: true flag (January 2026): Hooks run in background without blocking execution.
- MCP Tool Search: lazy loading of MCP servers. Reduces context usage by up to 95%.
  Critical for heavy MCP users.
- `/loop` command + cron scheduling (March 2026): Recurring autonomous workflows.
- Agent Teams (official, with Opus 4.6): One orchestrator + multiple teammate sessions,
  each with own context window, communicating directly.
- GitHub Actions official action: `anthropics/claude-code-action`. @claude mention
  trigger on PRs/issues. Supports Anthropic API, Bedrock, Vertex, Foundry.

**Velorin build implication:**
Velorin's hook system design should account for all 12 events, including elicitation
and async hooks. The MCP lazy loading feature directly addresses context pressure.
The loop/cron capability enables Velorin's recurring programs (8-hour registry recheck)
as Claude Code-native rather than requiring external cron infrastructure.

---

### Finding 8.3 — Windsurf + Devin Under One Roof

**What was found:**
OpenAI's $3B acquisition of Windsurf collapsed (Microsoft contractual issues).
Cognition AI (the Devin company) acquired Windsurf in December 2025 for ~$250M.
Devin (most autonomous cloud coding agent, fully sandboxed, dropped from $500/month
to $20/month Core) and Windsurf (1M+ users, #1 in LogRocket rankings February 2026,
59% of Fortune 500) are now under one company.

**What this proves:**
The most autonomous cloud coding agent and the most enterprise-adopted AI IDE
are now combined. This is a significant market structure event.

**Velorin build implication:**
Velorin's architecture should not depend on Cursor as infrastructure. Understanding
what Windsurf + Devin's combined architecture achieves is important competitive
context. Neither is a Velorin dependency.

---

## SECTION 9: WHAT REMAINS SURFACE-LEVEL

The following things were found but NOT deeply understood. Each requires the
Gemini Deep Research prompt to go deeper:

1. **MCP wire format and full spec** — found it exists, never read it
2. **A2A full spec** — found it exists, never read it
3. **Glama score methodology** — found it's the quality signal, don't know how it works
4. **OWASP Agentic Top 10** — found it was published, don't know the items
5. **PAL routing algorithm** — found it works, don't know how
6. **ApiTap discovery algorithm** — found the concept, don't know the implementation
7. **Camoufox C++ modification scope** — found it exists, don't know what it modifies
8. **PPR implementation options** — know PPR is right, don't know which algorithm to implement
9. **HippoRAG and GAAMA internals** — know they validated PPR, don't know their full architecture
10. **Jules API session model** — know the API exists, don't know the endpoint design
11. **ACP (Agent Client Protocol) spec** — found it's analogous to LSP, never read it
12. **Semantic compression algorithms** — know the concept, don't know the algorithm landscape
13. **The OWASP tool poisoning attacks** — know 66% of servers have findings, don't know the attack vectors
14. **Registry data model** — know registries exist, don't know their schemas

All of the above are inputs to the Gemini Deep Research prompt at:
`Bot.Jiang/Working.Docs/Gemini.DeepResearch.MCP.Ecosystem.Prompt.md`

---

## SECTION 10: THE BUILD VS ADOPT DECISION FRAMEWORK

This section is the most important in this file.

**The principle CT established this session:**
"If they can build this shit, you can build this shit our way with our unique
stripping and Graph RAG and anything else."

**The decision framework for every finding in this file:**

NEVER at the foundational level:
- Adopt another company's registry as Velorin's registry
- Adopt another company's routing layer as Velorin's routing layer
- Adopt another company's orchestration framework as Velorin's orchestration
- Depend on any outside company's continued existence for Velorin's core function

EVALUATE case by case:
- Open protocols (MCP, A2A) — implement the protocol, not the other company's code
- Official tools that interact with Velorin's external integrations (Jules, GitHub MCP)
- Research-phase tools (NotebookLM for CT's human queries)

BUILD in Velorin's way:
- The registry (reads punkpeye as input signal, Velorin stores and vets)
- The routing layer (understands PAL's patterns, builds using GPS + Brain)
- The orchestration model (understands A2A spec, builds using Tier 1/2/3 separation)
- The bridge layer (uses Playwright as underlying tool, wraps in Velorin's MCP structure)
- The compression algorithm (understands existing approaches, builds novel version)
- The knowledge graph construction (understands NER/RE pipelines, builds Velorin's version)

**The test for any decision:**
"If this outside company disappeared tomorrow, would Velorin's core function break?"
If yes: build Velorin's own version.
If no: evaluate whether adopting is faster than building without creating dependency.

---

[SESSION021.DISCOVERY.MCP.EOF]
