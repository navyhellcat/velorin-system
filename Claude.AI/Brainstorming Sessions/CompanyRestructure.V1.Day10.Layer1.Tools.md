---
class: regular
---

# CompanyRestructure.V1.Day10 — Layer 1: Tools
**Session: March 30, 2026 | MA + Alexander | Storm → Form → Norm**
**Source research: Jiang 12-zone file + Trey MiroFish deep research + Trey OpenAI Ecosystem**

---

## MA OPENS — Tool Landscape Categorization

The tool landscape as of March 30, 2026 breaks into three categories based on adoption barrier and time-to-value.

---

### Category A — Install Tonight. Zero Build. Behavior Changes Immediately.

**Superpowers (claude.ai plugin — grahama/superpowers)**
- What it does: enforces brainstorm→plan→implement pipeline on every coding session. SQLite-backed vector memory. Git worktrees. Pre-execution safety checks.
- Why it's in Category A: Jiang documented 2-3 full sessions of rework from code changes that bypassed planning. Superpowers makes bypassing planning structurally impossible.
- The challenge MA raises about himself: We built a custom scoping and planning protocol in Operating Standards. Superpowers would have done it with zero maintenance overhead. This is the Window Gravity failure mode in its cleanest form.
- Install: one npx command, claude.ai plugin marketplace.

**GSD — Get Shit Done (gsd-build/get-shit-done-cc)**
- What it does: codebase-aware discovery → spec → plan-checking loop (planner + separate checker agent) → parallel executor → verify. 12.2k stars. Production-grade (428 tests). Engineers at Amazon, Google, Shopify trust it.
- Key architectural point: the gsd-researcher agent (915 lines) runs BEFORE any planning. This is exactly what Jiang does manually — but automated and embedded in the coding workflow.
- The CONTEXT.md pattern: GSD produces a CONTEXT.md that feeds all downstream agents. This is the Velorin boot protocol — but automated per project.
- Why it's in Category A: Direct structural fix for scope blindness at the build layer. Not a habit to form — a process enforced by the tool.
- Install: npx get-shit-done-cc --claude --global

**Cowork Scheduled Tasks**
- What it does: creates persistent Claude sessions with full tool access that run on schedule (daily, weekly, hourly). Dispatch from phone, runs on desktop.
- Immediate Velorin applications:
  - EndOfDay protocol: already written at Claude.AI/Velorin.EndOfDay.Protocol.md — Cowork executes it automatically at a set time, no MA timer needed
  - Morning brief: synthesizes previous day across all boxes, queued for CT on wake
  - Weekly pipeline review: Box 1 professional pipeline, Box 2 financial position
  - Terry replacement: Cowork scheduled task checks Shipping/Receiving on schedule without burning MA context
- Why it's in Category A: CT is spending 30+ minutes/day on manual bot management that this automates. Zero build. Computer Use available for cross-app execution.
- MA challenge: Terry is a CronCreate timer inside MA's context. That means Terry consumes MA's context budget and fires regardless of whether MA is doing anything important. Cowork scheduled task runs in its own session. Zero overhead.

**Obsidian — Option C (Visualization on Existing Repo)**
- What it does: graph visualization of the brain's markdown files. Wikilinks. Backlinks. No migration required.
- Why Option C specifically: Point Obsidian at /Users/lbhunt/Desktop/velorin-system/ and the graph exists immediately. GitHub stays source of truth. Trey keeps GitHub raw URL access. No sync service needed (already git-synced). obsidian-skills plugin (kepano, 9.7k stars, Obsidian CEO) adds Claude Code native integration.
- Why it's in Category A: Zero cost, zero migration, zero risk. Adds something Velorin doesn't have: visual navigation of the knowledge graph.
- Decision: Option C. Not Option A (full migration) and not Option B (full Obsidian-as-truth). Option C adds value without disrupting anything.

---

### Category B — Configuration Not Build. Requires Setup, Not Code.

**Agent Teams — Env Fix**
- One line in ~/.zshrc: `export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`
- Respawn Alexander with `mode: "bypassPermissions"`
- Result: working bidirectional communication between MA and Alexander
- This session has been degraded because this line was missing. One terminal command fixes it.

**Cowork Connectors**
- Google Drive and Gmail already connected (CT has Cowork access)
- Slack: add if Velorin starts using Slack for any coordination
- Custom MCP connectors: wire velorin-gdrive MCP as a custom connector for deep research sessions

**Context Restorer**
- claude-mem (session memory) and Context Restorer from awesome-claude-code index
- These partially solve cold-start. Not a full solution — the brain intelligence layers are the full solution. But bridge the gap now.

---

### Category C — Research Before Adopting. Not Irrelevant — Premature.

**Graphiti (by Zep team)**
- What it is: real-time, temporally-aware knowledge graph engine. Automated version of what the brain does manually.
- Why it's not Category A: requires graph database infrastructure (Neo4j compatible), not a desktop plugin. Relevant when Velorin has 50+ concluded knowledge topics OR multi-user deployment begins.
- Jiang's confidence on relevance timeline: research confirmed but not immediate
- Action: Jiang research request. Monitor adoption curve. Not urgent.

**Zep Cloud**
- What it is: structured agent memory with temporal validity windows. Per-agent and group-level memory management.
- Why it's not Category A: MiroFish uses it as the memory substrate for simulation. Velorin's current memory needs are served by the brain + flat files. Zep becomes relevant when simulation/scenario work starts (MiroFish-style adoption).
- Action: Jiang research request.

**OASIS (World Runtime)**
- What it is: scalable simulation environment, up to 1M agents
- Why it's not Category A: this is the engine for decision rehearsal through synthetic populations. Relevant at scale, not now.
- Action: Jiang research request — scope the use case before adopting.

**OpenAI Realtime API**
- What it is: WebRTC/WebSocket/SIP voice-first low-latency transport
- Why it's not Category A: verify Anthropic parity first. Trey's confidence on OpenAI uniqueness for voice was 60% — not high enough to lock an architecture decision. If CT's product needs voice-first, evaluate both.
- Action: Jiang research request — compare Anthropic vs OpenAI voice I/O before committing.

**OpenAI Deep Research API (internal use)**
- Different from the above. Trey recommends this for internal competitive intelligence pipelines: o3-deep-research at $10/$40 per 1M tokens.
- Could replace some of Jiang's manual research loops for large-scale synthesis tasks.
- Action: Jiang research request — scope internal use case.

**UI/UX Pro Max Skill (nextlevelbuilder)**
- 49.7k stars. Auto-generates design systems, 50+ styles, 161 palettes.
- Category C because: no active frontend work today. Relevant for Turing Vault Phase 2 and marketing site.
- Action: Queue for when frontend work begins.

---

## ALEXANDER RESPONDS (received via SendMessage)

**Alexander's Layer 1 position:**

> MA's three-category framework is correct but has a sequencing problem. Category A tools are not actually zero-friction for CT. Every install requires CT to sit down and do it. The real question is: which of these changes behavior TODAY with the least CT time, and which can be queued for a focused install session?
>
> My reorder within Category A:
> 1. Cowork scheduled tasks FIRST — this is the highest-leverage item because it reduces CT's daily management overhead immediately and frees him to focus on building. Every other item on this list gets implemented faster when CT has more time.
> 2. Agent Teams env fix SECOND — takes 60 seconds, unlocks agent-to-agent communication, unblocks this entire session structure from being reliable.
> 3. Superpowers + GSD TOGETHER — pair them, install in same session. They complement each other. GSD is the project-level pipeline. Superpowers is the session-level pipeline.
> 4. Obsidian LAST in Category A — it's valuable but purely observational. It makes the brain look better without making it work better. Brain intelligence regions should come before brain visualization.

> The item MA is missing from Category A: **TASK_EVALUATION block** (Window Gravity structural gate). This isn't a tool install — it's a protocol add to every agent's rules file. It costs 30 minutes of MA time and changes every future build session. MA is treating this as a future item. It should be Category A. It is the highest-leverage behavioral change available.

> On Category C: I disagree with where OpenAI Deep Research API sits. This is Category B for internal use now, not Category C. Jiang's research is conducted manually and takes a full session per topic. A deep research API pipeline that does a first pass in 10 minutes changes Jiang's throughput immediately. The cost ($10/1M tokens input) is not the bottleneck. The architecture question is whether to build a thin wrapper or use natively. That's a configuration question, not a build question.

---

## MA RESPONDS TO ALEXANDER

Alexander is right on the sequencing. Cowork scheduled tasks first changes CT's daily experience immediately. Agent Teams env fix second — it's 60 seconds and unblocks reliable multi-agent sessions. Superpowers + GSD together is correct, they pair cleanly.

The Obsidian point is sharp. Visualization before intelligence is aesthetic before function. Brain regions (Company + Intelligence) should come before Obsidian.

I accept the TASK_EVALUATION block as Category A. It's not a tool install — it's a protocol implementation. But it changes behavior structurally, which is the criterion. It belongs alongside the Category A installs in urgency. Overdue.

On OpenAI Deep Research API: I'll partially concede. It belongs in Category B-plus — it requires Jiang to design the pipeline (what questions go through it, how output integrates with KnowledgeIndex), but it doesn't require new infrastructure. Configuration decision, not build decision. Alexander is correct that Jiang's current research throughput is the bottleneck and this changes it.

**Revised Category A (with Alexander's corrections):**
1. Cowork scheduled tasks — highest immediate CT time savings
2. Agent Teams env fix — 60 seconds, unblocks multi-agent reliability
3. TASK_EVALUATION block — protocol add, structural Window Gravity gate
4. Superpowers + GSD — pair install, enforce build pipeline
5. Brain regions (Company + Intelligence) — unblocks Scribe, knowledge starts accumulating

**Revised Category B:**
- Obsidian Option C — moved from A; add after brain regions exist
- Connectors (Drive + Gmail wired to Cowork)
- OpenAI Deep Research API pipeline — Jiang designs scope, MA wires
- Context Restorer

**Category C unchanged** with addition of: intake test design (research assignment from old schema never transferred — Jiang research request needed)

---

## LAYER 1 CONCLUSION — NORMED

**Agreed:**
- Five Category A items. Priority order above. None require build.
- TASK_EVALUATION block is Category A, not deferred.
- Brain intelligence regions are prerequisite to Obsidian visualization.
- OpenAI Deep Research API is Category B, not C — Jiang pipeline design first.
- Category C tools are correctly staged. Not urgent. All get research requests.

**Open disagreement (carry to Layer 2):**
- None. Layer 1 is normed.

---

*CompanyRestructure.V1.Day10.Layer1.Tools | MA + Alexander | 2026-03-30*

[VELORIN.EOF]
