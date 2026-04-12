# Research: Google Antigravity — Gemini AI Agent Platform
**Researched by:** Jiang
**Date:** 2026-04-05
**Commission:** What is "Antigravity" in the context of Gemini AI? Reddit users recommended setting it up immediately.

---

## What It Is (Confirmed Facts)

Google Antigravity is an **"agent-first" IDE** — a heavily modified fork of Visual Studio Code — released by Google in public preview on **November 18–20, 2025**, alongside Gemini 3. It is NOT a Chrome extension, MCP server, library, or configuration pattern. It is a full desktop application (standalone IDE), downloadable and locally installed.

**Official download:** `antigravity.google/download`
**Official docs:** `antigravity.google/docs`
**Current version:** 1.21.9 (as of March 30, 2026)
**Platform:** macOS, Windows, Linux
**Cost:** Free during public preview (personal Gmail only; Workspace accounts not yet supported)

The core premise: instead of "AI assistant that helps you code," Antigravity positions AI agents as **independent actors** that plan, execute, test, and verify tasks autonomously — with the human reviewing artifacts rather than directing every step.

**Primary model:** Gemini 3.1 Pro (free with generous rate limits for personal Gmail)
**Also supports:** Claude Sonnet 4.6, Claude Opus 4.6, GPT-OSS-120B (open-source OpenAI variant)
**Google AI Ultra subscribers** get the highest rate limits for Gemini 3 Pro within Antigravity, plus priority access to all Vertex AI Model Garden models.

---

## What Problem It Solves

### The Reddit complaint: "browser interface is poor, but the underlying platform is excellent"
This is accurate. The complaint refers to Gemini's web browser interface at gemini.google.com — which is a chat-style interface with limited tool access, no persistent agent state, no parallel execution, and no IDE integration. The "underlying platform" is Gemini 3's actual model capabilities, which are substantially better than the web interface lets you reach.

Antigravity solves the interface gap. It gives you:

1. **Multi-agent parallel execution** — spawn multiple subagents working simultaneously on different tasks (bug fix + architecture review + test generation, all at once). The browser interface is single-thread conversational.

2. **Agent Manager ("Mission Control")** — a dedicated orchestration surface for dispatching, monitoring, and reviewing agent work. The web interface has none of this.

3. **Full environment access** — agents can write code, run terminal commands, launch servers, and control a browser for testing. Not possible in the Gemini web interface.

4. **Artifacts system** — agents produce verifiable deliverables: task lists, implementation plans, code diffs, screenshots, browser recordings. Instead of "AI said it worked," you get proof.

5. **MCP integration** — direct, secure connections to external services (databases, deployment tools, GitHub issues). The MCP config lives in `mcp_config.json` inside Antigravity.

6. **Persistent context across a project** — the IDE maintains full codebase context; the web interface requires you to paste snippets manually.

**Summary:** Antigravity unlocks what Gemini 3 can actually do. The browser chat interface is the bottleneck, not the model.

---

## How It Connects to Gemini CLI / API / Browser Interface

| Interface | What It Is | Limitation |
|-----------|------------|-----------|
| gemini.google.com | Browser chat UI | Single-threaded, no tool access, no agent state, no IDE |
| Gemini CLI | Terminal assistant + VSCode plugin | Single conversational agent, non-invasive, good for CI/CD |
| Antigravity IDE | Full standalone IDE, agent-first | Requires full migration from existing IDE |
| Gemini API | Direct API calls | Requires your own infrastructure |

**When to choose Antigravity over Gemini CLI:**
- Need parallel multi-agent execution
- Want autonomous orchestration (agents decide what to do next)
- Comfortable migrating away from Cursor/VS Code
- Running complex, multi-step development tasks

**When to choose Gemini CLI instead:**
- Want to stay in your existing IDE (non-invasive plugin)
- Need CI/CD integration via GitHub Actions
- Working within Google Cloud infrastructure
- Not ready to commit to a full IDE migration

**Context windows:**
- Antigravity: 1M+ tokens (Gemini 3 Pro configs, some community claims of "infinite context" which is marketing language for effective context assembly, not a literal guarantee)
- Gemini CLI: 1M (free) to 2M (Enterprise)

---

## Setup / Installation

**Prerequisites:**
- Chrome web browser
- Personal Gmail account (Workspace accounts not supported in preview)
- macOS, Windows, or specific Linux distribution

**Steps:**
1. Go to `antigravity.google/download`, select your OS
2. Run the installer
3. Launch Antigravity — configure:
   - Import from VS Code/Cursor settings or start fresh
   - Choose editor theme
   - Set **Agent Autonomy Policy** (four options):
     - Secure Mode (agent restricted from external resources)
     - Review-driven development (recommended — agent asks before acting)
     - Agent-driven development (agent acts autonomously, no approval requests)
     - Custom configuration
4. Sign in with personal Gmail account (browser OAuth flow)
5. On first browser task: Antigravity auto-installs the **Antigravity Chrome extension** from the Chrome Web Store (`eeijfnjmjelapkebgockoeaadonbchdd`)

**MCP Server setup (inside Antigravity):**
1. Open Agent Panel → `...` menu → `MCP Servers`
2. Click `Manage MCP Servers` → `Edit configuration`
3. Edit `mcp_config.json` — use environment variable substitution for secrets
4. Restart Antigravity and verify: ask the agent "What tools do you have access to?"

**Optional:** Install the `agy` command-line tool for terminal access to Antigravity agents.

**Security configuration:**
- Terminal Execution Policy — control whether agents auto-run commands
- Browser URL Allowlist — restrict which sites agents can visit (prevents prompt injection)
- Use "Trusted Workspaces" — only enable write-access MCP servers in repos you own

---

## GitHub Presence

**Primary repo:** Not a public GitHub project in the traditional sense — Antigravity is a Google-owned product distributed via `antigravity.google`.

**Adjacent GitHub resources:**

- **`antigravity.codes`** — community hub with 1,500+ MCP servers, 500+ rules and workflows for Antigravity, Cursor, and Windsurf. Active community resource.

- **`github.com/NoeFabris/opencode-antigravity-auth`** — OAuth bridge that let OpenCode authenticate against Antigravity to use its rate limits for Claude Opus 4.6, Gemini 3.1 Pro. **10,000+ stars. ARCHIVED March 30, 2026. No longer maintained.** WARNING: Google ToS violation; users reported account bans/shadow-bans.

- **`gist.github.com/tanaikech/da7deaad19f75db0fd473e84e856529e`** — "Agentic Automation in Google Workspace: Bridging Antigravity and Gemini 3.0" — Google Apps Script patterns for connecting Workspace to Antigravity workflows.

- **`github.com/ChromeDevTools/chrome-devtools-mcp`** — Official Chrome DevTools MCP server; pairs well with Antigravity for browser automation and debugging.

---

## MCP Integration Details

Antigravity uses MCP as its primary external connectivity layer. The platform's official description: "MCP is the open standard that powers AntiGravity's ability to understand your world."

**MCP operates through three pillars inside Antigravity:**
1. **Resources** — read-only data access (database schemas, repo structures)
2. **Tools** — executable actions (create issues, run queries, trigger deployments)
3. **Prompts** — pre-written workflow sequences

**Verified working integrations:**
- Supabase (live SQL queries)
- Vercel (deployment monitoring, build logs)
- Cloudflare (edge functions, object storage)
- Firebase (Firestore, auth, cloud functions)
- n8n-MCP (1,084+ workflow nodes, 2,700+ templates)
- Google Data Cloud: AlloyDB, BigQuery, Spanner, Cloud SQL, Looker

**Community hub:** `antigravity.codes` — 1,500+ curated MCP servers

---

## Velorin Relevance

**High relevance.** Key connection points:

1. **Trey's platform.** Trey moved to Gemini per Session 021 handoff. Antigravity is the correct way to unlock Gemini 3's full capabilities beyond the browser chat interface. If Trey is operating via gemini.google.com, he is working with the bottlenecked interface. Antigravity is the answer.

2. **Google AI Ultra integration.** Christian purchased Google AI Ultra. Antigravity gives Ultra subscribers the highest rate limits on Gemini 3 Pro within the IDE — this is the correct way to extract maximum value from that subscription for agentic coding work.

3. **Multi-agent architecture.** Antigravity's Agent Manager (spawn multiple agents in parallel) maps directly onto Velorin's multi-agent philosophy. This is the Gemini-native equivalent of Claude Code's Agent Teams feature.

4. **MCP compatibility.** Antigravity uses the same MCP protocol that Claude Code uses. MCP servers built for Velorin (GitHub, databases, etc.) should be portable between Claude Code and Antigravity — the `mcp_config.json` format is standard.

5. **Claude support inside Antigravity.** Antigravity supports Claude Sonnet 4.6 and Claude Opus 4.6 as models within the IDE. This means Antigravity could serve as a unified interface running both Gemini and Claude agents from a single orchestration surface.

6. **1M context for deep research.** Antigravity's Gemini 3 Pro configuration supports 1M+ token context, making it suitable for Jiang-style deep research tasks, codebase-wide analysis, and multi-document synthesis.

7. **Not a replacement for Claude Code.** Antigravity is Google's answer to Claude Code — an "agent-first IDE" that competes directly. For Velorin's architecture, the two could run as parallel systems: Claude Code for Claude agents, Antigravity for Gemini/Trey agents, with shared MCP server infrastructure.

---

## Controversy / Current Issues

- **Performance degradation complaints (March 2026):** r/GeminiAI reports that Gemini 3 Pro was replaced or throttled with shorter context and higher hallucination rates after launch — the "paperweight" controversy. Google developer forum has an open request to re-add Gemini 2.5 Pro. This is unresolved as of research date.

- **Stability issues:** IDE freezes 5 seconds when agents start tasks, high CPU/battery drain, sidebar bugs, Svelte extension breaks editor entirely. Not production-ready for deadline work per multiple reviewers.

- **Pricing uncertainty:** Free during preview; future pricing model undetermined. Community fear of "bait and switch" after preview ends — one Register article headline: "Users protest as Google Antigravity price floats upward" (March 12, 2026).

- **Workspace accounts excluded:** Personal Gmail only for preview — blocks enterprise and team usage.

- **No ToS-safe way to use Antigravity rate limits in other tools:** The opencode-antigravity-auth repo (10K stars) solved this but was archived and carries ToS risk. Google banned accounts using it.

---

## Confidence Level

**What is confirmed (high confidence):**
- Antigravity is a real, Google-developed, downloadable AI IDE. Not a Chrome extension or MCP server.
- Launched November 2025 alongside Gemini 3. Free public preview.
- VSCode fork with agent-first architecture.
- Supports MCP natively. Supports Claude models alongside Gemini.
- Google AI Ultra members get highest rate limits within Antigravity.
- Community MCP hub at antigravity.codes is active.

**What is plausible but less confirmed:**
- The specific Reddit thread recommending "set up immediately" could not be located. The recommendation pattern matches real community sentiment visible across multiple sources.
- "Infinite context" claims are community shorthand — actual limits are model-dependent (Gemini 3 Pro: 1M+).

**What remains unknown:**
- Exact pricing model post-preview.
- Whether performance degradation issues (the "paperweight" complaints) have been resolved.
- Whether Antigravity will add Workspace/enterprise account support.
- Whether the Gemini 2.5 Pro model will be added to Antigravity's model picker (forum request open, not resolved).
- Exact status of multi-agent execution with Claude models inside Antigravity (Gemini 3 Pro is clearly the primary agent model; Claude support may be editor-only).
- Full feature parity timeline vs Cursor/Claude Code.

---

## Sources

- [Google Developers Blog — Antigravity launch](https://developers.googleblog.com/build-with-google-antigravity-our-new-agentic-development-platform/)
- [Google Codelabs — Getting Started with Antigravity](https://codelabs.developers.google.com/getting-started-google-antigravity)
- [Wikipedia — Google Antigravity](https://en.wikipedia.org/wiki/Google_Antigravity)
- [Google Cloud Blog — Antigravity vs Gemini CLI](https://cloud.google.com/blog/topics/developers-practitioners/choosing-antigravity-or-gemini-cli)
- [Antigravity.codes — MCP tutorial](https://antigravity.codes/blog/antigravity-mcp-tutorial)
- [Augment Code — Antigravity vs Gemini CLI comparison](https://www.augmentcode.com/tools/google-antigravity-vs-gemini-cli)
- [DEV.to — Honest Review of Antigravity](https://dev.to/fabianfrankwerner/an-honest-review-of-google-antigravity-4g6f)
- [Substack — From Gemini CLI to Antigravity](https://aipositive.substack.com/p/from-gemini-cli-to-antigravity-why)
- [GitHub — opencode-antigravity-auth (archived)](https://github.com/NoeFabris/opencode-antigravity-auth)
- [Google One — AI Ultra plans](https://gemini.google/subscriptions/)
- [The Register — Antigravity pricing controversy](https://www.theregister.com/2026/03/12/users_protest_as_google_antigravity/)
- [leaveit2ai — Antigravity review](https://leaveit2ai.com/ai-tools/code-development/antigravity)
