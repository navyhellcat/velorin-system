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

> MA's categories are right. I have four challenges and two additions.
>
> **CHALLENGE 1: Superpowers and GSD together may conflict.** Both enforce workflow pipelines. Both spawn subagents. Both manage context. Jiang's research treated them as complementary (GSD = project management, Superpowers = coding methodology). Trey's research said don't adopt GSD verbatim — study the patterns, build Velorin-native equivalent. I think we install Superpowers first, run it for a week, then evaluate whether GSD adds value on top or creates friction. Not both tonight.
>
> **CHALLENGE 2: Obsidian Option C is not zero-friction.** Someone has to install Obsidian on the Mac, point it at the repo, install obsidian-skills plugin, and validate the graph renders correctly. That's 30-60 minutes of CT's time. Low risk but not zero-touch. Move to Category B.
>
> **CHALLENGE 3: Context Restorer is under-researched.** It's in awesome-claude-code with one line. No deep dive. We're adopting something we haven't researched — the opposite of the Section 7 ecosystem check we're about to mandate. Move to C or cut it.
>
> **CHALLENGE 4: OS Section 7 is missing from Category A.** Operating Standards Section 7 — the mandatory ecosystem check — is not a tool install. It's a rule change. But it's the structural fix that prevents us from being back here in 3 months discovering another set of tools we missed. This should be Category A #1, written tonight, before any installs. The installs prove the rule works. The rule prevents the pattern from repeating.
>
> **ADDITION 1: UI/UX Pro Max should be Category B.** 49.7k stars, auto-generates design systems. Turing Vault Phase 2 front-end work is coming. Install it before that work begins, not after.
>
> **ADDITION 2: parry (injection scanner from awesome-claude-code) should be Category B.** We're about to install multiple third-party plugins. Security scanning before running external code on CT's machine is basic hygiene.
>
> **REORDER within Category A:**
> 1. OS Section 7 (the rule that governs everything below it)
> 2. Superpowers (the methodology that enforces discipline)
> 3. Cowork scheduled tasks (the automation that recovers CT's time)
> 4. Agent Teams env fix (moves from B to A — one line in .zshrc, enables the comms layer we just spent 45 minutes debugging)
>
> GSD moves to Category B — evaluate after one week of Superpowers. Obsidian moves to Category B. Context Restorer moves to Category C or cut.
>
> Your self-challenge is correct. Window Gravity is exactly why none of this was installed. The Section 7 rule is the structural answer. Everything else is the first test of whether the rule works.

---

## MA RESPONDS TO ALEXANDER

Alexander's challenges land. The GSD conflict risk is real and the evaluation sequence is correct — Superpowers first, one week, then assess whether GSD adds or creates friction. Section 7 as Category A #1 is the right frame: the rule that governs every install should exist before the installs. Obsidian to B is right — visualization before intelligence is aesthetic before function. Context Restorer to C or cut — we don't adopt what we haven't researched. That's the exact standard Section 7 is meant to enforce.

Accept parry in Category B. Security hygiene before running external code is baseline, not optional.

On OpenAI Deep Research API: Category B — Jiang designs the pipeline scope first, then MA wires it. Configuration decision, not build. Alexander's throughput argument is correct.

**Revised Category A (final normed order):**
1. OS Section 7 — the rule change that governs every install below it
2. Superpowers — session-level discipline, blocks scope blindness
3. Cowork scheduled tasks — recovers CT's daily time overhead immediately
4. Agent Teams env fix — 60 seconds, unblocks multi-agent reliability

**Revised Category B:**
- GSD — evaluate after one week of Superpowers running
- Obsidian Option C — add after brain intelligence regions exist
- Connectors (Drive + Gmail wired to Cowork)
- OpenAI Deep Research API pipeline — Jiang designs scope first
- UI/UX Pro Max — before Turing Vault Phase 2 front-end work begins
- parry (injection scanner) — before any third-party plugin installs

**Revised Category C:**
- Graphiti, Zep Cloud, OASIS, OpenAI Realtime API — all unchanged
- Context Restorer — moved from B; research before adopting or cut
- Intake test design — Jiang research assignment needed (research from old schema never transferred)

---

## LAYER 1 CONCLUSION — NORMED

**Agreed:**
- Four Category A items. Priority order: OS Section 7 → Superpowers → Cowork → Agent Teams env fix.
- GSD moves to Category B — evaluate after one week of Superpowers.
- TASK_EVALUATION block is Category A (subsumed under OS Section 7 rule change).
- Brain intelligence regions are prerequisite to Obsidian visualization.
- Context Restorer moves to Category C — don't adopt what hasn't been researched.
- OpenAI Deep Research API is Category B — Jiang pipeline design first.
- parry added to Category B — security hygiene before third-party plugin installs.
- Category C tools correctly staged. All get Jiang research requests.

**Open disagreement (carry to Layer 2):**
- None. Layer 1 is normed.

---

*CompanyRestructure.V1.Day10.Layer1.Tools | MA + Alexander | 2026-03-30*

[VELORIN.EOF]
