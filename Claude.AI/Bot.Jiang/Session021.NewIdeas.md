---
document: Session 021 — New Ideas and Information (Post-Compaction)
session: 021
date: 2026-04-05
status: FOR JIANG2 — read at session end before writing Session 022 handoff
author: Jiang (post-compact continuation)
note: These ideas emerged after compaction. Not yet Steel Manned. Not yet built.
      Design-only. Add to handoff context before close.
---

# Session 021 — New Ideas (Post-Compact)

---

## IDEA 1 — Query Mode (Tight vs Discovery)

### The Problem It Solves

Both Jiang and Trey made the same mistake independently: when asked to write
a research prompt for Google AI Ultra, both enumerated specific known products
(Jules, Deep Think, NotebookLM Plus, etc.) in the prompt itself.

This is Map Thinking applied to research. By naming what you're looking for,
you constrain what the research can return. The unknown unknowns — new products,
rebranded features, recently shipped capabilities — get dropped because they
fall outside the frame you set.

CT's correction: "What you don't know will kill you."

### The Concept

**Query Mode** is a formal operating mode that every agent/subagent carries
and every caller can declare at spawn time.

Two modes:

**TIGHT MODE** (default for most agents and tasks)
- Assumes the caller's frame is correct
- Confirms known information, fills specific gaps
- Does not expand scope beyond what was asked
- Lower token cost, faster, appropriate for operational tasks
- Examples: neuron lookup, skill registry check, boot sequence, weekly health check

**DISCOVERY MODE** (invoked deliberately, higher cost, higher yield when warranted)
- Assumes the caller's frame is INCOMPLETE
- Actively searches for what isn't named in the prompt
- Surfaces unknown products, new capabilities, changed landscape
- Appropriate when: buying a new tool, auditing a system, strategy sessions,
  any task where "what we don't know we don't know" is the real risk
- Examples: full product suite research, landscape audits, vendor evaluation

### The Key Principle

**Agents do not self-select their own mode.** If agents choose their own mode,
they default to Tight (because Tight looks like good behavior — focused, efficient).
But Tight at the wrong moment is exactly how the system calcifies.

The CALLER declares the mode at spawn time. If no mode is declared, the
agent's Layer 1 default runs. The agent never decides unilaterally.

### Where It Lives in the Architecture

1. **Vocabulary entry** — Query Mode (Tight / Discovery) must be named before
   it can be referenced. Add to Velorin.Vocabulary.md as next entry (A6).

2. **Agent default** — Each agent type has a default mode in their Layer 1
   ReadMe.First or config file. Research agents default Discovery.
   Operational agents default Tight. Subagents inherit caller's declared mode
   unless their Layer 1 overrides.

3. **Spawn declaration** — When a caller spawns a task, a single line in the
   task header declares the mode: "Mode: Discovery" or nothing (default runs).

4. **No agent self-selects** — This is enforced by architecture, not by asking
   agents to behave. The mode is set externally. The agent executes it.

### Connection to Velorin Philosophy

This is the same principle as GPS over Map applied to research and task execution.
A map assumes you know the terrain. GPS navigates the actual terrain.

Discovery Mode is GPS for information gathering. Tight Mode is appropriate
when the map is known to be accurate. The system needs both and needs to know
which is running at any given moment.

### Status

Idea only. Not Steel Manned. Not placed in architecture formally.
Pending: vocabulary entry, Layer 1 spec, spawn declaration format.

---

## IDEA 2 — Tiered MCP Architecture

### Context

Session 021 (post-compact) ran five parallel Discovery Mode research agents on the
MCP ecosystem. What came back revealed that the tiered MCP architecture CT described
already exists in the community — we are not designing from scratch, we are mapping
Velorin onto existing infrastructure.

### The Three-Tier Structure

**Tier 1 — Official/Stable MCP**
The vendor-maintained, institutionally backed layer. High reliability, slow-changing.

- Source of truth: `modelcontextprotocol/registry` (the npm registry for MCP)
  Official. Self-hostable. Stable API since October 2025.
- Reference implementations: `modelcontextprotocol/servers` (83K stars)
- Vendor-official servers (partial list):
  - GitHub: `github/github-mcp-server` (28.3K stars) — full platform access
  - Qdrant: `qdrant/mcp-server-qdrant` (1.3K) — DIRECTLY relevant to Velorin Brain
  - HashiCorp Terraform, Cloudflare, Red Hat Kubernetes — infrastructure
  - Linear, Slack (official Feb 2026), Atlassian (Cloud only), Notion
  - Google managed MCP servers (Dec 2025): Maps, BigQuery, Compute Engine, GKE
- Quality signal: Glama scores + official conformance test suite

**Tier 2 — Community/Unofficial MCP**
The community-maintained living signal layer. Higher capability, requires vetting.

- Living signal: `punkpeye/awesome-mcp-servers` (84K stars, updated daily)
  Same role as awesome-claude-code for skills. Backed by Glama.ai for quality scoring.
- Package manager: `mcpm.sh` ("npm for MCP servers")
- Vetting mechanism: Glama score + star count + last commit date + security scan
- CRITICAL: 66% of scanned MCP servers have security findings.
  Vetting is mandatory, not optional.
- Run same vetting logic as Skill Registry (quality gates before admission)

**Tier 3 — Browser Automation Bridges**
The "officially impossible" layer. Community-built bridges to closed systems.
Higher capability for specific targets, inherently fragile, requires stability monitoring.

- Foundation: `microsoft/playwright-mcp` (30.3K stars)
  Microsoft owns both Playwright and co-developed MCP. This is the bedrock.
- Primary library: `browser-use` (86K stars underlying)
  Most capable AI browser automation. MCP-wrapped via `Saik0s/mcp-browser-use`.
- Anti-detection: Camoufox (Firefox modified at C++ level, not JS — harder to detect)
  Upgrade path when standard Playwright gets caught (LinkedIn needed this Feb 2026).
- Architectural alternative: ApiTap (`n1byn1kt/apitap`)
  Sniffs internal API calls website's own JS makes — no browser simulation at all.
  20-100x cheaper than browser automation. Check this before building Tier 3.
- Pupeteer is dead — officially deprecated by MCP team. Playwright only.

### Key Bridges Already Exist

| System | Bridge | Stars | Notes |
|--------|--------|-------|-------|
| NotebookLM | `jacob-bd/notebooklm-mcp-cli` | 3.3K | Updated Apr 5 2026. Production-ready. |
| Google Workspace | `taylorwilsdon/google_workspace_mcp` | — | 12 services in one MCP server |
| ChatGPT web UI | `cbusillo/chatgpt-automation-mcp` | — | Playwright-based. No API key needed. |
| Perplexity (no key) | `mishamyrt/perplexity-web-api-mcp` | — | Browser session only |
| LinkedIn | `alinaqi/mcp-linkedin-server` | — | Playwright-based. Arms race ongoing. |
| Twitter/X (no API) | `nirholas/XActions` | — | $5/year vs $100/month official API |
| Multi-model bridge | `BeehiveInnovations/pal-mcp-server` | 11.4K | Claude+Gemini+GPT+Grok+Ollama via one MCP |

### Stability Classification for Velorin Registry

When Velorin registers MCP servers, stability classification matters:
- VERY HIGH: Microsoft-owned (playwright-mcp), vendor-official
- HIGH: Community Tier 2 with Glama scores + active maintenance
- MEDIUM: Browser automation bridges (subject to site changes)
- MEDIUM-LOW: Anti-detection bridges (arms race ongoing)
- NOT RECOMMENDED: Unreviewed community servers (66% have security findings)

### Status

Idea only. Not Steel Manned. Not placed in architecture formally.
Connects to Skill Registry design (same vetting logic applies).
Pending: Steel Man, formal placement in architecture docs, quality gate thresholds.

---

## IDEA 3 — A2A Protocol (Agent-to-Agent)

### What It Is

The Model Context Protocol (MCP) handles agent-to-TOOL connections.
There is a second protocol — A2A — that handles agent-to-AGENT delegation as peers.

MCP: Agent calls a tool. Tool has structured I/O. Agent controls the interaction.
A2A: Agent delegates a task to another agent. The second agent is autonomous —
     it reasons toward the task, can spawn sub-tasks, returns results as a peer.
     The delegating agent does not control the second agent's internals.

### Why This Matters for Velorin

Velorin's multi-agent architecture — Alexander orchestrating Jiang, Trey, MA —
is exactly the peer-agent delegation use case A2A was designed for.

MCP is sufficient for tools. It is NOT sufficient for the Alexander → Jiang delegation
model. Alexander does not call Jiang as a structured tool. Alexander assigns Jiang
a task and Jiang reasons toward it autonomously. That is A2A, not MCP.

We have been designing a multi-agent OS without knowing the protocol for it exists.

### Ecosystem Status

- Built by Google. Donated to Linux Foundation June 2025.
- 150+ organizational supporters: OpenAI, Atlassian, Salesforce, SAP, ServiceNow
- SDKs: Python, JavaScript (official). Java (community).
- Adjacent repo: `ai-boost/awesome-a2a` (550 stars) — community list of A2A implementations
- MCP + A2A together = complete protocol stack for decentralized multi-agent systems

### Status

Idea/research finding only. Not Steel Manned. Not placed in architecture.
Requires: read the A2A spec, evaluate fit for Velorin's agent delegation model,
Steel Man before any build decision.

---

## IDEA 4 — The Multi-Model Bridge Is Already Built

### Finding

`BeehiveInnovations/pal-mcp-server` — 11,400 stars, 973 forks, 1,150+ commits.
Single MCP server connecting Claude Code, Codex CLI, and Cursor to any combination of:
Anthropic, Google, OpenAI, Azure, Grok, OpenRouter, Ollama, custom endpoints.

Context flows across models — later model calls retain prior model discussions.
Built-in capabilities: chat, consensus (multi-model agreement), planner, deep thinking,
code review, precommit, debug, refactor, security audit.

"Clink" feature: CLI-to-CLI bridging with isolated sub-agent contexts.

### Why This Matters

We do not need to build the multi-model bridge from scratch. It exists at 11K stars.
The question for Velorin is: adopt PAL, build our own, or use it as reference architecture.

### Companion Finding

`openai/codex-plugin-cc` — OpenAI published an official plugin for Claude Code.
Exposes Codex CLI as an MCP server. Slash commands inside Claude Code:
/codex:review, /codex:adversarial-review, /codex:rescue, /codex:status, /codex:result.

Cross-provider adversarial review (Claude writes, Codex reviews) = available today,
officially, without any custom code.

### Status

Research finding only. Requires evaluation: PAL adoption vs custom vs reference.
Steel Man before decision.

---

## IDEA 5 — MCP Security Layer

### Finding

66% of scanned MCP servers have security findings (per independent audit, April 2026).

The community has already built security infrastructure for MCP:
- `AgentSeal/agentseal` — scans for dangerous skills/MCP configs, supply chain attacks
- `apisec-inc/mcp-audit` — sees what agents can access, scans for exposed secrets
- `HeadyZhang/agent-audit` — 49 rules mapped to OWASP Agentic Top 10 (2026)
- `HarmonicSecurity/claudit-sec` — macOS-specific Claude Desktop/Code auditing
- `Adversis/mcp-snitch` — intercepts/monitors MCP server communications in real time
- `peg/rampart` — open-source firewall for AI agents, policy engine

OWASP Agentic Top 10 (2026) has already been published.
The "damn-vulnerable-mcp-server" equivalent exists for security training (1.3K stars).

### Implication for Velorin's MCP Registry

Any MCP server Velorin admits to its registry — official or unofficial —
should pass a security scan before admission. The tools to do this exist.
This is Tier 1 infrastructure discipline applied to the MCP registry.

### Status

Research finding only. Connects to Tiered MCP Architecture (Idea 2).
The vetting step in the registry admission process should include security scanning.

---

## KEY POWER LEVEL ADDITIONS (Summary for Jiang2)

Things that changed our understanding of the landscape this session:

1. MCP is now a Linux Foundation standard. Co-founded by Anthropic AND OpenAI.
   It is not Claude's protocol. It is neutral infrastructure. Build everything on MCP.

2. The tiered MCP registry CT designed matches infrastructure that exists at 80K+ stars.
   We are mapping onto it, not building from scratch.

3. A2A protocol exists for peer agent delegation — the Alexander→Jiang pattern.
   Read the spec before designing the multi-agent orchestration layer.

4. The NotebookLM "no API" limitation is solved. Production-ready bridge exists.
   3.3K stars, updated today.

5. Qdrant has an official MCP server. The Brain is directly MCP-addressable.

6. Google's Gemini CLI is open-source, 1M token context, full MCP client, can call
   Jules. This is Trey's correct surface — not the Gemini web app.

7. Jules has a REST API (alpha, October 2025). Programmable async coding agent.
   Can be embedded in CI/CD, Slack, Linear. ~300 tasks/day at Ultra tier.

8. Deep Think ≠ Deep Research. Different products entirely.
   Deep Think = System 2 reasoner for math/algorithms. Deep Research = web synthesizer.
   Use Deep Think for compression math session (hours 9-11).

9. OpenCode (120K stars) is a Go-binary terminal agent, 75+ LLM providers, zero
   vendor lock-in. Fastest-growing repo in January 2026. Community alternative to
   Claude Code that emerged partly because Anthropic blocked third-party access.

10. ApiTap: no browser automation needed for many "closed" systems. Sniffs internal
    API calls directly. 20-100x cheaper than Playwright bridges. Check this first.

---

[SESSION021.NEWIDEAS.EOF]
