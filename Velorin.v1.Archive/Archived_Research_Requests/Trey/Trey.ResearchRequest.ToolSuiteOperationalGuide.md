---
file: Trey.ResearchRequest.ToolSuiteOperationalGuide.md
priority: HIGH — CT pays $200+/month across vendors and uses a fraction of the surface area
date: 2026-04-30
from: Jiang1 (rewrite of Jiang2's prior version, 2026-04-29)
to: Trey 2 (Velorin-specific Deep Research, Discovery Mode)
mode: DISCOVERY — assume CT's frame of reference is INCOMPLETE
context: Mac Studio Stage 0 transition is the operational frame. CT is configuring his
         primary Velorin build machine. Anything with a CLI, MCP server, API, or
         protocol Claude Code can reach is Stage 0 relevant.
---

═══════════════════════════════════════════════════════════════════
GPS-OVER-MAP — READ FIRST (Velorin Principle 1)
═══════════════════════════════════════════════════════════════════
This file is a POINTER. The Velorin Consensus Filter and your
Research Philosophy live in their canonical files (read at boot).
The Library and prior Research_Complete files contain knowledge
already produced — your job here is to delta against them, not
duplicate them.
═══════════════════════════════════════════════════════════════════


# Multi-Vendor Tooling — Operational Landscape, Delta Pass, Discovery

## THE PROBLEM (one paragraph, no enumeration)

CT pays for Google AI Ultra ($200/mo), OpenAI ChatGPT Pro, and Anthropic
Claude Max. He uses Deep Research, Deep Think, and Claude Code daily.
The rest of what those subscriptions cover is invisible to him —
interfaces have changed, products have been renamed, capabilities have
been added or moved since his last exploration, and partnerships and
integrations exist that he has never been told about. He cannot ask
about what he does not know exists. **The frame of this request is
deliberately wide. The deliverable's value is proportional to how
much it surfaces that the prompt could not name.**

The named pain-point list (Veo/Flow, AI Studio confusion, Antigravity,
NotebookLM, Codex desktop+CLI, Sora, Cowork, Computer Use) is a
floor — not a ceiling. Treat them as confirming context for what CT
already partially knows. The deliverable's primary value is everything
else.


## WHAT THIS REQUEST IS

A **functional operational landscape** of every reachable surface in
CT's three paid AI subscriptions plus directly-adjacent tooling that
integrates with them on a Mac Studio M4 Max.

Three passes, in order:

  1. **Delta pass** against existing Velorin research (mandatory pre-step).
  2. **Discovery pass** for surfaces CT does not know exist.
  3. **Operational guide** for everything in scope — uniform format
     so CT can read a section and use the tool within an hour.


## STEP 1 — MANDATORY PRE-RESEARCH READ

Before any new research, retrieve and read each of these Library
cards by `topic_id`. Follow the `source` pointer if the card is
insufficient. This is your "what's already known" baseline. Without
this step you will duplicate prior work and miss what has changed.

Mandatory topic_id pre-load:

  - `claude-code-skills-full-landscape`
  - `velorin-ecosystem-landscape-synthesis-may2026`
  - `claude-cowork`
  - `claude-connectivity-stack`
  - `claude-code-tools-roundup-mar29`
  - `trey-gpt55-codex-integration`
  - `trey-google-ai-ultra-pass1`
  - `trey-google-ai-ultra-pass2`
  - `trey-gemini-ai-ultra-breakdown`
  - `gemini-model-selection`
  - `openai-ecosystem`
  - `google-antigravity-ide`
  - `mcp-browser-tabs`
  - `trey-notebooklm-api-surface`
  - `trey-flashmoe-tools`

State after reading:
  - For each card, one line: **STILL CURRENT / PARTIALLY STALE / SUPERSEDED — [why, with date evidence]**.
  - Then a "delta surface" — the union of what those cards do NOT cover that this request must.

Do not paste the cards back into your output. Cite them by topic_id.


## STEP 2 — DISCOVERY PASS (the question CT cannot ask)

For each vendor below, the question is the same:

> **What surfaces, agents, integrations, partnerships, SDK extensions,
> CLIs, MCP servers, A2A endpoints, browser-automation hooks,
> developer tools, and adjacent products exist within or alongside
> this vendor's ecosystem that a power user on a Mac Studio M4 Max
> could reach today, and that the user has likely never been told
> about?**

The vendors:

  - **Anthropic** — beyond Claude Code, Cowork, Computer Use. Look for
    Managed Agents, the Agent SDK and its extensions, partnership
    surfaces (e.g., the Claude×Adobe integration), enterprise/team
    surfaces, anything related to "Claude Design" or design-tool
    integrations, the broader official + community MCP ecosystem,
    skills and hooks ecosystem, sub-agent patterns, whatever shipped
    in the last 90 days that a Pro/Max subscriber can use.

  - **Google / Gemini** — beyond Deep Research, Deep Think, AI Studio,
    Veo/Flow, NotebookLM, Antigravity, Jules. Look for Project Genie or
    successors, Gemini-powered IDE integrations, Workspace AI surfaces
    that overlap with build work, Project IDX or its replacement, any
    agentic-coding tool beyond Jules, image/video/3D tools beyond
    Imagen/Veo, model-tuning surfaces (AI Studio fine-tuning, LoRA
    training), Vertex AI features touchable from Mac Studio without
    enterprise GCP setup.

  - **OpenAI** — beyond ChatGPT Pro browser, Codex desktop, Codex CLI,
    Sora. Look for Operator/Agent mode current state, Responses API
    capabilities a power user can wire, custom GPTs as integrations
    rather than chat targets, the broader OpenAI tool ecosystem, image
    generation surfaces (DALL·E successors), voice surfaces, anything
    new in the SDK that maps to multi-vendor Cowork orchestration.

  - **Apple Intelligence on Mac Studio M4 Max** — what surfaces does
    macOS Sequoia (or current major version April 2026) expose that
    integrate with Claude/Gemini/OpenAI tooling? Apple Shortcuts +
    AI integration. Local-model APIs. Spotlight AI. Anything reachable
    from Claude Code via subprocess that adds capability.

  - **Adjacent dev / automation tooling that integrates with the
    above** — IDEs (Cursor, Windsurf, Zed) and their MCP/agent
    integrations; automation frameworks (Hammerspoon, Apple
    Shortcuts, Keyboard Maestro) that can be invoked from Claude
    Code; the broader open-source MCP server ecosystem; agent
    frameworks (LangChain, LlamaIndex, CrewAI) only insofar as they
    plug into one of CT's paid surfaces.

For each surface you find, note:
  - **Discovery confidence:** CONFIRMED (you found official docs) /
    HIGH (multiple credible sources) / MODERATE (community signal,
    not vendor-confirmed) / RUMOR (single source, treat with caution).
  - **Recency stamp:** when was this announced, when was the last
    update, has it changed since the corresponding Library card was
    written.


## STEP 3 — OPERATIONAL GUIDE FORMAT (per tool / surface)

After Steps 1 and 2 produce the in-scope set, write one section per
tool. Operational tone — CT must be able to read a section and USE
the surface within an hour. No architectural digressions.

For each, ten fields:

  1. **What it is** — one paragraph, plain English, no jargon.
  2. **Where to access it** — exact URL, install command, or invocation path.
  3. **What subscription covers it** — Ultra / Pro / Max / extra cost / free.
  4. **Current interface** — what the user sees on first open. Note any rename or relocation since Q1 2026.
  5. **One concrete task** — something CT can do in <10 minutes to prove the surface works.
  6. **CLI surface** — can it be called from Mac terminal? Install command, invocation syntax, auth setup if any.
  7. **MCP surface** — official or community MCP server? Repo URL, install, claude_desktop_config.json snippet.
  8. **API surface** — base URL, auth method, SDK availability.
  9. **Connects to** — which other tools in CT's suite can this send to or receive from? Name the protocol (MCP / A2A / webhook / API call / subprocess) and direction.
  10. **Limitations and per-use cost** — what breaks, what costs per generation/call (name the price), what is in beta/preview/waitlist.


## STEP 4 — CROSS-CUTTING INTEGRATION MAP

After per-tool sections, two cross-cutting tables:

**Table A — Reachability matrix:**

| Tool | CLI? | MCP? | API? | A2A? | Browser-automation only? | Mac Studio Stage 0 relevance |
|---|---|---|---|---|---|---|

**Table B — Direct integration paths:**

| Source tool | Target tool | Protocol | What flows | Stability (stable / preview / fragile) |
|---|---|---|---|---|


## STEP 5 — STALENESS REPORT

End with a short list of Library cards from the Step 1 pre-load that
are now stale or superseded by your new findings. Format:

| topic_id | Status | What changed | Action recommended |
|---|---|---|---|

Recommended actions: KEEP / UPDATE / SUPERSEDE / RETIRE. CT and Jiang
will execute the actions — your job is to flag.


## CONSENSUS FILTER NOTE

This is functional landscape research, not architectural recommendation.
The Consensus Filter applies if you start advocating tool adoption at
the foundational level. For per-tool how-to-use sections, report what
exists and how it works.


## OUTPUT

  - Format: markdown, plain-text LaTeX for any math, no equation images.
  - Delivery: Google Drive Claude.AI Shipping folder with destination header.
  - Last line: `[VELORIN.EOF]`.
  - Confidence labels on all empirical claims.
  - Discovery-pass items get explicit confidence + recency stamp.
  - State assumptions you made about CT's environment (macOS version, hardware, network) so anything wrong is easy to correct.

[VELORIN.EOF]
