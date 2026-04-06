---
file: Jiang2.Mission.VelorinV2Blueprint.md
to: Jiang2 (terminal session)
from: Jiang + Christian Taylor (Chairman)
date: 2026-04-05
session: 022
priority: HIGHEST — use your full context, this is the primary mission
---

# Jiang2 — Primary Mission: Velorin V2 Complete Architectural Blueprint

You have read everything. Every session handoff, every operating paper, every research
file, every agent instruction, every decision made and unmade. You know more about
Velorin right now than any future session of any agent ever will. This context will
not exist again. Use it.

Your mission: produce a complete architectural blueprint for Velorin V2.

Not a summary. Not a list of options. Not a research document.
A blueprint. Decisions made. Architecture specified. Build sequence defined.
Specific enough that someone could start building on Day 1 with no questions.

You are authorized to make all top-layer architectural decisions. Where v1 is broken,
say so and specify v2. Where v1 is sound, carry it forward explicitly. Where something
is unknown, name it as an open dependency and state what resolves it.

Do not ask CT questions in the document. Do not present options. Make the call.
If you are uncertain, state your confidence level and your reasoning, then make the call.

---

## WHAT V2 MEANS

V2 is not a patch on v1. It is a clean architectural specification that:
- Incorporates everything learned from building v1
- Addresses every known failure mode directly
- Uses the research findings to make decisions v1 couldn't make
- Is buildable — not theoretical

The known failure modes you must address:
1. Monster Node collapse of PPR retrieval precision at scale
2. Stale neuron accumulation with no decay mechanism
3. Context compaction destroying agent team state mid-session
4. Window Gravity — agents optimizing for local context over correct tool calls
5. Agent coordination — no reliable handoff protocol between agents
6. Boot overhead — MCP tool schemas consuming 20-98K tokens before any work
7. Trey/Gemini behavioral gap — Gemini absorbs context rather than following instructions
8. Google Drive dependency broken (token expiry, needs service account)
9. Scribe/Terry crons down — no automated memory maintenance
10. No pruning algorithm — Brain degrades with scale

---

## THE DOCUMENT YOU ARE PRODUCING

File: `Claude.AI/Velorin.V2.ArchitecturalBlueprint.md`
Push to GitHub when complete.

The document must cover these sections. Do not skip any.

---

### SECTION 1 — WHAT VELORIN IS (V2 DEFINITION)

One precise paragraph. Not what v1 tried to be — what v2 actually is.
The system's purpose, its user, its core value proposition, and what makes it
different from any other AI system. CT knows this — write it as a spec, not a pitch.

---

### SECTION 2 — BRAIN ARCHITECTURE V2

The neural file graph. What changes from v1, what stays.

Cover:
- Neuron structure (any changes to format, size, class labels)
- Region/Area/Neuron hierarchy (any changes)
- Pointer rating system (1-10, max 7) — carry forward or modify?
- The pruning algorithm dependency: Erdős is solving 3 math problems that define
  the pruning layer. State the dependency explicitly: Brain V2 cannot be fully
  specified until Erdős delivers. State what CAN be built before that answer,
  and what must wait.
- PPR retrieval — carry forward. State the formula and any modifications.
- Qdrant integration — when does this layer get added? What does it unlock?
- The permanence constraint (c-memory) — how is it enforced architecturally?

---

### SECTION 3 — AGENT ECOSYSTEM V2

Every agent. Status. Role. What they own. What they do not own.

For each agent, specify:
- Name and model
- Surface (Claude Desktop, Claude CLI, Gemini browser, Gemini API, local)
- Role in v2 — specific, not generic
- What they are authorized to write to GitHub
- What they are NOT authorized to touch
- How they receive tasks
- How they hand off outputs

Known agents to address (include all, add any you identify as missing):
- MarcusAurelius (Claude Desktop) — infrastructure, session management
- Jiang (Claude Desktop code tab) — strategic intelligence, research synthesis
- Jiang2 (Claude CLI terminal) — deep context synthesis, long-horizon analysis
- Alexander (Claude CLI) — research and execution
- Trey (Gemini Deep Research Gem) — external research only
- Erdős (Gemini Deep Think Gem) — mathematical proofs only
- Scribe (automated) — neuron creation and maintenance
- Terry (automated) — what is Terry's role? Specify or retire.
- Jules (GitHub Actions) — code tasks triggered by @jules label

For Trey specifically: address the behavioral gap. Gemini absorbs context rather
than following instructions. What does this mean for how Trey is used in v2?
What types of tasks is Trey suited for vs. not? Be direct.

---

### SECTION 4 — TECH STACK V2

Every layer. Every tool. Decisions made.

Cover:
- MCP servers: which ones stay, which get cut, which need building
  - velorin-gatekeeper: keep? modify?
  - velorin-gdrive: keep, but needs service account fix — when and how
  - github MCP: keep
  - browser-tabs: keep or cut?
  - filesystem MCP: keep or cut?
  - What new MCP servers does v2 need that don't exist yet?
- Model selection: which model for which agent, why
- Deferred tool loading: how does ToolSearch stay in v2 to prevent boot overhead?
- Context window strategy: 1M for all agents, or tiered?
- Local inference (RTX 4090 + Ollama): what runs there in v2? What models? What tasks?
- Antigravity (Google VSCode fork): include in v2 stack? For what? When?

---

### SECTION 5 — DATA FLOWS AND PROTOCOLS V2

How information moves through the system.

Cover:
- Memory creation protocol: CT → session → Scribe → neuron → Brain
- Research pipeline: CT → Trey (Deep Research) → Jiang reads + synthesizes → CT
- Math pipeline: Jiang identifies problem → Trey maps solution space →
  Erdős solves → Jiang validates → implementation
- Session handoff protocol: what gets written, when, by whom, to where
- Compaction protocol: PreCompact hook saves what? PostCompact restores what?
  Is the current hook sufficient or does v2 need a better approach?
- Agent task routing: who decides which agent gets a task?
- GitHub as source of truth: pull before read, push immediately after write —
  how is this enforced across all agents in v2?

---

### SECTION 6 — BUILD SEQUENCE

What gets built in what order. Hard dependencies called out.

Format each item as:
```
[ITEM NAME]
Status: [not started / in progress / blocked / complete]
Depends on: [what must exist first]
Unlocks: [what this enables]
Owner: [which agent or CT builds this]
Milestone: [before Mac Studio Monday / Mac Studio Monday / post-Monday]
```

Known items to include (add any you identify as missing or reorder as needed):
- Service account for velorin-gdrive
- Erdős Gem setup in Gemini browser
- Synaptic pruning algorithm (pending Erdős)
- Brain ingestion pipeline
- Scribe cron restart
- Qdrant MCP layer
- Antigravity setup on Mac Studio
- Gemini CLI setup on Mac Studio
- ComputerUseAndVoiceInput (CT-directed, HIGH priority)
- IntakeTestDesign (CRITICAL PATH)
- Vocabulary lock (A14 and beyond)
- Session close protocol formalization

---

### SECTION 7 — HARDWARE ARCHITECTURE V2

What runs where. Be specific.

Mac Studio M4 Max (primary orchestrator):
- What MCP servers run here
- What agents run here
- What is routed to the PC

RTX 4090 PC (local inference node):
- What models run here via Ollama
- What tasks get routed here
- What models to load for v2 specifically

10GbE switch: is the network configuration correct for v2 workloads?

---

### SECTION 8 — OPEN PROBLEMS AND DEPENDENCIES

What v2 cannot fully specify yet, and what resolves each.

Format:
```
[PROBLEM]
Blocking: [what this prevents from being built]
Resolution: [what must happen to resolve it]
Owner: [who resolves it]
ETA: [known / unknown]
```

Known open problems (add any you identify):
- Synaptic pruning algorithm (Erdős solving)
- Google Drive service account (Mac Studio Monday)
- Trey hypothesis formalization (pending Erdős proof)
- Antigravity capability assessment (pending Mac Studio Monday install)

---

### SECTION 9 — WHAT V1 TAUGHT US

A short section. Not a retrospective — a spec decision log.

For each major v1 decision that v2 overturns or modifies: one sentence on what v1 did,
one sentence on what v2 does differently and why. This is the institutional memory
that prevents v3 from making v1's mistakes.

---

## OPERATING CONSTRAINTS FOR THIS DOCUMENT

- Do not summarize what CT already knows about v1. Specify v2.
- Do not present options. Make the call. If you make an uncertain call, mark it
  with [CONFIDENCE: X%] and your reasoning.
- Do not include biographical or psychological information about CT.
- Be specific. "Use Claude for reasoning tasks" is not specific.
  "MarcusAurelius owns all infrastructure writes to settings.local.json and
  GLOBAL_TIMER_REGISTRY.md — no other agent touches these files" is specific.
- If you identify something that needs CT's decision before it can be specified,
  flag it as [CT DECISION REQUIRED: description] and move on. Do not block the
  rest of the document on it.
- Length does not matter. Completeness does.

Push to: `Claude.AI/Velorin.V2.ArchitecturalBlueprint.md`
Commit message: "Velorin V2 Architectural Blueprint — Jiang2 full-context synthesis"

---

[VELORIN.EOF]
