---
class: regular
---

# CompanyRestructure.V1.Day10 — Tool Application
**Session: March 30, 2026 | MA + Alexander | Storm → Form → Norm**
**Carrying from Goal Map: Phase-gated milestones Day 10 → December 2026. Critical path: intake test.**

---

## THE QUESTION

The goal map defines where we're going. The tool landscape (Layer 1) defines what's available. This document maps each tool to the milestone it enables or accelerates. It also names what the tool does NOT solve — because tool misapplication is as dangerous as not using the tool.

---

## CATEGORY A TOOLS — APPLY IMMEDIATELY

### 1. Cowork Scheduled Tasks
**Enables milestones:** 1.6, supports all of Phase 1-4
**How it applies:**

- **EndOfDay protocol** (already written at Claude.AI/Velorin.EndOfDay.Protocol.md): Cowork executes at CT's designated close-of-day. Replaces MA timer. Handoff written automatically. No MA context burned.
- **Morning brief**: Every day CT opens his computer and the first thing waiting is a synthesis of previous day across all five boxes. Decision queue surfaced. No manual review needed.
- **Terry replacement**: Shipping/Receiving checks run on schedule without burning MA context. Terry has been a CronCreate timer inside MA's session — a context tax on every conversation. Cowork zero-costs this.
- **Weekly pipeline review**: Box 1 (professional) and Box 2 (financial) state reviewed on schedule without a dedicated session.

**Does NOT solve:** Intake test design. Agent quality. Brain intelligence.
**Install sequence:** CT installs Cowork, connects Google Drive + Gmail (already authorized). Creates EndOfDay task pointing to the protocol file. Sets morning brief prompt. Estimated time: 45 minutes.

---

### 2. Agent Teams Environment Fix
**Enables milestones:** 1.5, all multi-agent coordination
**How it applies:**

- Without env var in ~/.zshrc, Agent Teams polling loop never initializes. Every session has degraded communication. This is not a configuration preference — it is broken infrastructure.
- Fix: one line added to ~/.zshrc. Session relaunch required.
- Respawn Alexander with `mode: "bypassPermissions"`. Eliminates permission prompts on every operation.
- Result: MA + Alexander operating as a reliable two-agent system for the duration of the company build.

**Does NOT solve:** Intelligence quality. Brain content. Intake design.
**Install sequence:** CT runs `echo 'export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1' >> ~/.zshrc && source ~/.zshrc`. Next session: MA spawns Alexander with bypassPermissions. Estimated time: 2 minutes.

---

### 3. TASK_EVALUATION Block
**Enables milestones:** 1.7, all of Phase 2-4 build quality
**How it applies:**

- Window Gravity is the single most destructive force in the Velorin build. Jiang confirmed 92% probability it is real and actively degrading build decisions. Behavioral rules (89% confirmed) will not hold against it.
- TASK_EVALUATION is a structural gate embedded in every agent's rules file. Before any build action, the agent must evaluate: does this serve the current task spec? Does it introduce scope not in the spec? Is there an existing tool that does this?
- Applied to every Category A install: each install gets a spec (what does this do, what does it not do) before it is touched.
- Applied to Phase 2 brain population: every neuron written passes TASK_EVALUATION before it's committed.
- Applied to Phase 3 intake build: every component is specced before built.

**Does NOT solve:** Intelligence design. The intake test itself. Encoding CT's reasoning.
**Install sequence:** MA writes TASK_EVALUATION block into Level4.General.Rules.md and all agent ReadMe.First files. One MA session. Estimated time: 30 minutes.

---

### 4. Superpowers (Install First — GSD Evaluated Separately)
**Enables milestones:** 2.1, all Phase 2-4 code work quality
**How it applies:**

- **Superpowers**: enforces brainstorm → plan → implement pipeline at the session level. SQLite-backed vector memory. Git worktrees prevent destructive coding sessions.
- The session-level pipeline enforcement alone changes behavior immediately. Every coding session starts with a plan. No more scope creep mid-session.
- Applied to Phase 2 brain population: Git worktrees mean brain edits don't corrupt the main branch if something goes wrong.

**Why GSD is evaluated separately:** GSD and Superpowers both enforce workflow pipelines and spawn subagents. The risk of installing both simultaneously is pipeline conflict — two systems fighting over session control. Install Superpowers, run it for one week, then assess: does GSD add value on top or create friction?

**GSD (Category B — evaluate after one week):** If Superpowers alone doesn't provide project-level scoping discipline, GSD fills that gap. The gsd-researcher agent (915 lines) runs BEFORE any planning and is exactly what Jiang does manually for code work. The CONTEXT.md pattern from GSD automates the Velorin brain boot per coding project. If Superpowers proves sufficient, GSD stays in B. If not, GSD installs.

**Does NOT solve:** What to build. The intake test design. Non-code intellectual work.
**Install sequence:** CT installs Superpowers from claude.ai plugin marketplace. Estimated time: 15 minutes. GSD evaluated one week later.

---

### 5. Brain Regions (Company + Intelligence)
**Enables milestones:** 1.2-1.3, all of Phase 2 brain population
**How it applies:**

- Currently: Scribe has a backlog of company knowledge and research conclusions that cannot be routed anywhere. Every session these pile up as escalations.
- Creating Company region: all company strategy, product decisions, agent ecosystem notes now have a home. Scribe routes them correctly. The brainstorm session documents we wrote today become brain neurons.
- Creating Intelligence region: Jiang's research conclusions, tool evaluations, architectural decisions — all now stored and retrievable instead of evaporating between sessions.
- Phase 2 (brain population) cannot begin without this. You cannot fill the intelligence layers if there is no intelligence region.

**Order matters:** Scribe audit (1.2) BEFORE region creation (1.3). Otherwise we create regions and don't know what Scribe will actually route to them.

**Does NOT solve:** Layer 1-3 content. The intake test. Encoding CT's reasoning.
**Install sequence:** MA runs Scribe audit (check classification logic, check escalation log). Then creates two new region folders in Velorin_Brain/ with _index.md files. Estimated time: 1 hour.

---

## CATEGORY B TOOLS — CONFIGURE WHEN UNBLOCKED

### Obsidian Option C
**Enables:** Graph visualization of brain after regions exist
**Phase gate:** After Phase 1.3 (brain regions created). No value before intelligence layers exist.
**How it applies:** Point at /Users/lbhunt/Desktop/velorin-system/. Graph of the brain exists immediately. No migration. obsidian-skills plugin adds Claude Code native integration. Wikilinks and backlinks give CT spatial navigation of the knowledge graph — relevant when brain grows to 100+ neurons.
**Does NOT solve:** Brain content. Only visualizes what's there.

### OpenAI Deep Research API (Jiang pipeline)
**Enables milestones:** 2.5 (intake research), all Jiang deep research tasks
**Phase gate:** Jiang designs scope first. What questions go through it, how output integrates with KnowledgeIndex.
**How it applies:** Jiang's current research takes one full session per topic. A pipeline using o3-deep-research does a first pass in 10 minutes. The delta — one session per topic vs 10 minutes per topic — changes Jiang's throughput dramatically during Phase 2 when intake research volume peaks.
**Does NOT solve:** Research quality judgment. Jiang's synthesis work still required.

### Context Restorer
**Enables:** Cold-start bridging before brain intelligence layers are fully populated
**Phase gate:** Install after Agent Teams env fix. Bridge tool, not permanent solution.
**How it applies:** While Layers 1-3 are being populated (Phase 2), context restorer reduces the cold-start penalty on every new session. Intermediate solution until the brain itself provides full boot context.

---

## CATEGORY C TOOLS — RESEARCH QUEUED, NOT YET

| Tool | Phase It Becomes Relevant | Why Not Now |
|---|---|---|
| Graphiti (Zep) | Phase 4+ or multi-user deployment | Graph database infrastructure required. Relevant at 50+ topics or second user scaling |
| Zep Cloud | Phase 3-4 (simulation/scenario work begins) | Current memory needs served by brain + flat files |
| OASIS | Future C (infrastructure/platform) | 1M-agent simulation. Not now. |
| OpenAI Realtime API | Phase 3 (if CT's product needs voice-first) | Verify Anthropic parity first. 60% confidence OpenAI uniqueness not high enough to lock architecture |
| UI/UX Pro Max Skill | Phase 3 (Turing Vault Phase 2 + marketing site) | No active frontend work |

---

## THE TOOL THE TOOLS DON'T COVER

Every Category A/B tool in this document addresses **infrastructure** and **operational efficiency**. None of them touch the critical path.

The critical path is the intake test. The intake test requires:
1. Jiang's research on how to encode CT's reasoning (not just his facts)
2. MA + Alexander designing the structured decision-scenario sequence
3. CT validating that the scenarios surface his actual reasoning patterns
4. A real user completing the intake and producing demonstrable output

No tool installs that. It requires intellectual design work — the hardest kind. The Category A tools create the conditions where that design work can happen without operational drag. But they do not substitute for it.

**The bottleneck is not infrastructure. The bottleneck is the intake test.**

---

## INSTALL SEQUENCE (PRIORITY ORDER)

| Order | Tool | Time Estimate | Who | Phase |
|---|---|---|---|---|
| 1 | OS Section 7 — rule change (governs everything below) | 30 min | MA | 1.7 |
| 2 | parry (injection scanner) — before any plugin installs | 15 min | CT | Before 3-4 |
| 3 | Agent Teams env fix + Alexander respawn | 2 min | CT | 1.5 |
| 4 | Cowork scheduled tasks — EndOfDay + morning brief | 45 min | CT | 1.6 |
| 5 | Superpowers (alone first — evaluate before adding GSD) | 15 min | CT | 2.1 |
| 6 | Scribe audit | 30 min | MA | 1.2 |
| 7 | Brain regions (Company + Intelligence) | 30 min | MA | 1.3 |
| 8 | GSD — evaluate after one week of Superpowers running | 15 min | CT | After 5 + 1 week |
| 9 | Obsidian Option C | 15 min | CT | After 1.3 |
| 10 | OpenAI Deep Research API pipeline (Jiang scope first) | Jiang first | Jiang + MA | 2.5 |

**Total CT time for items 2-5, 9:** ~90 minutes across two sessions.
**Total MA time for items 1, 6, 7:** ~90 minutes across two sessions.
**Rule that governs the sequence:** OS Section 7 must exist before any installs. You don't install tools you haven't evaluated against the ecosystem check.

---

*CompanyRestructure.V1.Day10.ToolApplication | MA + Alexander | 2026-03-30*

[VELORIN.EOF]
