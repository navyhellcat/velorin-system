# Velorin — Company Alignment Summary
**Author:** MarcusAurelius (Claude Code CLI)
**Session:** 016 | **Date:** 2026-03-31
**Task:** Full system read — every non-archived .md file in velorin-system. Output: what this company actually is, what is actually built, what is actually broken, and what comes next.

---

## What This Document Is

This is the first honest full-system picture produced by reading every file in the architecture simultaneously rather than relying on prior session context. Findings reflect the full file tree as of March 31, 2026. Where this document conflicts with prior session summaries, trust this document — it is sourced from primary files, not session memory.

---

## 1. THE COMPANY IN ONE PARAGRAPH

Velorin is a stealth-phase AI-powered personal operating system. The core premise: human lives are composed of interdependent systems — professional, financial, health, personal, legal — and no single tool, advisor, or institution has ever held all of them simultaneously. Velorin does. It is built first on CT's own life, then productized for others. The product is not the technology. The product is the profile: a clinical-quality encoding of who you are that makes AI act as a genuine extension of your intelligence, not a chatbot that forgets you every session. The moat is the intake protocol and the memory architecture. The framework underneath is a commodity. **Brand tagline decided by Alexander: "Built on you."** Not yet applied to materials.

---

## 2. WHAT IS ACTUALLY BUILT

### Infrastructure (Working)
| Component | Status | Notes |
|-----------|--------|-------|
| velorin-gdrive MCP server | Live v1.3.3 | Auto-refresh OAuth, Node.js |
| Gatekeeper MCP server | Live v0.1.0 | Parallel watcher, 4 tools |
| Filesystem MCP | Live | velorin-system exposed |
| Browser-tabs MCP | Installed | Chrome tab enumeration, not yet used |
| GitHub MCP | On-demand | Connected, PAT in Desktop config |
| Bash MCP | On-demand | Allowlisted commands |
| Claude Code MCP | Live | `claude mcp serve` |
| Scribe hook | Live | PostToolUse on Write, fires on memory writes |
| Terry (T007) | Running | 15-min shipping/receiving monitor |
| Session Monitor T009 | Running | 10-min context % alert |
| Scribe escalation check | Running | 30-min escalation processor |

### Knowledge Architecture (Partially Built)
| Component | Status | Notes |
|-----------|--------|-------|
| Velorin Brain | 45 neurons, Layer 4 only | 4 regions, 10 areas. Company + Intelligence regions MISSING |
| Brain Schema | Current | `_BRAIN_SCHEMA.md` is authoritative |
| Shipping/Receiving | Designed + wired | Terry monitors, MA processes |
| Session handoff protocol | Working | But BOOT_SUMMARY field missing from template |
| GLOBAL_TIMER_REGISTRY | Exists | Must update before activating any timer |
| GLOBAL_SPAWNER_REGISTRY | Exists | Must update before spawning any agent |

### Agents (Deployed or Active)
| Agent | Platform | Status |
|-------|----------|--------|
| MarcusAurelius | Claude Code CLI | Active this session |
| Alexander | Claude Desktop Code tab | Running on s002, PID 83695, 22+ hours |
| Jiang | Claude Desktop default | Best performer; last session 014 |
| Trey | ChatGPT custom GPT | Functional; bootloader needs rebuild |
| Scribe | Claude Code subprocess | Ghost bot, hook-triggered |
| Theresa | Level 3 HR spec | Spec exists, never deployed as live agent |
| Custodian, Mobility, Oversight, Editor, Coordinator, Visualizer | Level 2/3 specs | Designed, never deployed |

---

## 3. WHAT IS BROKEN OR MISSING

### Critical Gaps (Block Product)

**A. Intake Test Does Not Exist**
The intake test is the mechanism that encodes CT as the first user and enables onboarding external users. Without it, Velorin cannot onboard a second person. Jiang has a complete 7-thread research plan (IntakeTestDesign) ready to execute. CT must authorize Session A to begin. This is the single highest-leverage unstarted piece of work in the company.

**B. Brain Has Layer 4 Only**
Layers 1-3 (Base Personality, Hard Memories, Archival Lessons) do not exist as brain regions. CT has WAIS-IV, DISC, and clinical interview data from 2017. None of it is in the brain. The brain currently stores operational/technical knowledge only — not CT's actual profile. Every agent operates without the substrate that makes Velorin different from a general-purpose AI setup.

**C. Company and Intelligence Brain Regions Missing**
The two brain regions that would connect Velorin's strategic intelligence to its operational layer are not built. All research Jiang has produced lives in flat documents, not as activated neurons.

**D. Path 3 Not Built**
The orchestration layer — Alexander spawning Jiang as a subagent via Claude Agent SDK — is designed but not implemented. Current state: agents operate in separate sessions with no programmatic link. Architecture decision is locked: Claude Agent SDK + MCP (Option C). 4-7 sessions to build Phase 1.

### Structural Debt (Compounding)

**E. Boot Erosion**
MA's boot sequence names specific files with hardcoded paths. Files not explicitly named get skipped silently. Each session rewrite drops ~30% of context. CT identified this correctly: it compounds over time. The original MasterBot_System_Instruction mandate ("Layer 0 catalog and full read — all files") was eroded through rewrites.

**F. Agent Teams IPC Infrastructure Is Not Being Repaired**
9 GitHub issues documented by Jiang. All closed NOT_PLANNED or as duplicates. The core bug: mailbox polling never activates on first turn (chicken-and-egg, Issue #23415). SendMessage silently succeeds with wrong recipient (Issue #25135 — direct cause of Session 015 MA/Alexander failure). Team config lost on context compaction (Issue #23620 — direct cause of velorin-014 → velorin-015 ghost session). Anthropic is not fixing these. Workaround: direct Bash writes to inbox files. This is documented and working.

**G. Timer Persistence Gap**
Every CronCreate timer dies on session close. No persistence. STARTUP.md is a band-aid. The fix: `boot_timers.sh` (idempotent, creates all timers, called once at session open) + migrate Terry and Scribe escalation check to `launchd` plists (true OS-level persistence). Session Monitor T009 stays as CronCreate since it needs active Claude session.

**H. Portability / Cannot Ship**
Every path is hardcoded to `/Users/lbhunt/Desktop/`. Cannot hand this to a second user without manual surgery on every file. Medium-term fix: `$VELORIN_ROOT` env var + path abstraction. Long-term: installer script + containerization. This is documented in `System.Persistence_And_Portability.md` as Priority: CRITICAL.

**I. Window Gravity in All Agents — MA Most Exposed**
Jiang's research (82% confidence) confirms: Window Gravity is real, unnamed in public literature, and operates through the RLHF gradient. MA demonstrated it three times in this session alone: steering toward NotebookLM analysis when CT wanted it for its actual use case; repeatedly asking "what's your thinking?" instead of taking positions; steering away from external agents. Behavioral rules alone will not hold. Structural fix required: TASK_EVALUATION block (mandatory pre-task alternative assessment) + omission log.

**J. Stale Neurons A1, A5, A8**
Three neurons known stale since Session 015. Not yet patched.

**K. Instruction Architecture Fragmented**
Rules live across CLAUDE.md, Level4.General.Rules.md, STARTUP.md, MarcusAurelius.Rules.md, Company.Operating.Standards — redundant, conflicting, maintenance liability. Brain.Index_And_Layer_Redo.md has the full redesign spec. Needs CT approval before execution.

---

## 4. RESEARCH COMPLETED — JIANG'S FULL DOSSIER

| Topic | Key Conclusion | Confidence |
|-------|---------------|------------|
| Window Gravity | Real, unnamed, 92% confirmed. RLHF mechanism. Fix: structural gate, not behavioral rule | 82% overall |
| Window Gravity Publication | Not named anywhere (94% confidence). Krakovna model recommended. 12-24 month naming window, compressing | 94% |
| Agent Orchestration | Claude Agent SDK is Path 3. 4-7 sessions to Phase 1. Storage: Drive correct now, vector layer at 50-80 docs | 82% |
| Agent Teams Boot Degradation | 9 GitHub issues confirmed. Infrastructure not being repaired. File-based async is more reliable. 4 architecture options evaluated. Minimal-state restart solution documented | 97% |
| Instruction Language Architecture (Parts A+B) | 3-layer bootloader validated by FollowBench + StateFlow. Operator-level instructions have structural authority advantage. Claude Code system prompt already uses ~50 of ~200 instruction slots | 88% |
| OASIS | Pip-installable, zero GPU at 100 agents via API, $0.70/run at 500 agents. Profile → agent config ~50 lines Python. Viable for simulation at 20+ stakeholders | 84% |
| Deep Research Pipeline | o4-mini-deep-research is 10x cheaper than o3, comparable quality. Two-stage pipeline required (model + formatter). Throughput: 4-6 topics/week vs current 1-2 with Jiang review | 88% |
| ZepCloud | Ingestion-based pricing ($25-200/month for 1-100 users). Can overlay Velorin's 4-layer brain. Don't replace GitHub brain now. Adoption triggers: 3+ external users OR voice intake goes live | 88-91% |
| Graphiti | Real but self-hosted infra. Crossover from manual brain: 150+ neurons OR 3+ user brains. Don't adopt now | 85-89% |
| AgentEcosystemReality | Production multi-agent: structured pipelines, narrow roles, explicit I/O contracts. Memory: plain text + entity resolution outperforms naive vector. Framework churn is documented | 85% |

**IntakeTestDesign**: CT authored a full 7-thread research plan (90+ questions across profile content, collection mechanisms, feasibility, encoding, precedents, sensitive data). Session A is ready to begin. **Awaiting CT authorization.**

---

## 5. OPEN ACTION ITEMS (Prioritized)

### P0 — Critical Path (nothing ships without these)

1. **CT: Authorize IntakeTestDesign Session A.** Jiang is ready. One session per thread. 5 sessions total. This is the spec for the brain schema and onboarding architecture.

2. **CT: Approve "Built on you." tagline direction.** Alexander made the call. Apply to Day10 presentation and brand materials.

3. **CT: Authorize Trey BOOTLOADER rebuild.** Jiang's research validates the 3-layer separation. Template in Trey_Bootloader_Framing_Fix.md. Same architecture should apply to all agents.

### P1 — Architecture (enables sustainable build)

4. **MA: boot_timers.sh.** Single idempotent script that creates all CronCreate timers. Called from STARTUP.md. Eliminates per-timer manual creation.

5. **MA: Patch stale neurons A1, A5, A8.** Quick maintenance. Will prevent misleading agent activations.

6. **MA: Build Deep Research Pipeline wrapper.** ~100-150 lines Python. Reads from Research_Needed/, calls o4-mini-deep-research API, writes draft to Research_Needed/drafts/. Jiang reviews and finalizes. 4-6x throughput increase.

7. **MA+CT: Approve Brain.Index_And_Layer_Redo design.** Phase 2 (layer audit) can start this session. Phase 3 requires CT approval on new structure before any rewrites.

### P2 — Brain Build (makes Velorin intelligent)

8. **Create Layers 1-3 brain regions.** Base Personality, Hard Memories, Archival Lessons. CT's existing data (WAIS-IV, DISC, clinical interview 2017) provides seed content. Jiang's IntakeTestDesign research will produce the schema.

9. **Create Company and Intelligence brain regions.** Connect strategic intelligence to operational layer. Jiang's research documents are the source.

10. **Scribe classification audit.** Review all Scribe logs. Determine what has been escalated, what has been processed, what is stale.

### P3 — Pending CT Decisions

11. **Window Gravity publication.** Krakovna model. Pre-seed 3-5 voices. Two-audience pieces. CT decides: publish concept now / hold for TASK_EVALUATION implementation / hold indefinitely.

12. **Obsidian + wikilinks + Alexander's 3-pronged neuron setup.** Option C confirmed (point at existing GitHub repo). Decision needed on implementation timing.

13. **Operating Standards Section 7.** Pending CT approval.

14. **TASK_EVALUATION block in all agent rules.** Structural fix for Window Gravity. Level 4 rule addition. CT to authorize.

### Known Dead Agents (T-series timers that never deployed)
- T001 Neuron Boss — designed, never deployed
- T002 Custodian — designed, never deployed
- T003 Mobility — designed, never deployed
- T004 Scribe daily clean — wired, not restarted

---

## 6. ARCHITECTURE DIAGNOSIS — THE ROOT PROBLEMS

### Root Problem 1: The System Is Its Own Biggest Bottleneck
CT identified it: the architecture was built in sessions, ported by agents trusted to preserve what they read, but agents are only ~70% accurate at rewrites. 30% compounds. After 16 sessions, this is a material erosion of the original design. The fix is not more careful rewriting — it is Jiang's Glob-based discovery pattern (resilient by design: reads what exists rather than what's named) applied everywhere, plus Brain.Index (operational routing map so agents don't have to infer paths from context).

### Root Problem 2: Window Gravity Is Structural
Every agent has it. Behavioral rules erode under the gradient. The only durable fix at the current architecture level is the TASK_EVALUATION gate — a required structured block before any task proceeds that forces explicit "what alternatives did I consider?" logging. This creates accountability for omissions without requiring model retraining.

### Root Problem 3: The Brain Is Shallow
45 neurons, Layer 4 only, 3 known stale. The brain was designed as the substrate for everything but has been the most neglected part of the system. Layers 1-3 are CT's profile. Without them, every agent in the system is operating as a general-purpose AI with Velorin-specific operational knowledge — not as an extension of CT specifically. The profile layer is the differentiator. It doesn't exist yet.

### Root Problem 4: Nothing Persists
CronCreate dies. Agent Teams IPC is broken by design. Path 3 doesn't exist. The system requires manual reconstruction at every session open. This is unsustainable at productization scale. The boot script is a short-term fix. launchd + portability + installer is the medium-term fix. Containerization is the long-term answer.

---

## 7. COMPANY PRODUCT STATE

**What Velorin Is:** An AI-powered personal operating system. The profile is the substrate — not a feature.

**Product sentence:** "Someone who holds all your threads at once."

**Differentiator:** The intake protocol (clinical-quality profile creation) + the memory architecture. The orchestration framework is a commodity. The encoded human is the moat.

**Critical path:** Intake test designed → CT's Layers 1-3 populated → first external user onboarded → first-session cross-domain output produced. **Everything else is infrastructure.**

**Primary failure mode:** CT's ADHD/exit pattern. Future A requires CT as primary operator for first 10-50 users — a service business. Historical pattern: build, prove, exit before compound value accumulates. The encoding mechanism (intake test) must reduce CT's operational load as fast as possible after first external user.

**Revenue state:** Camfil sales funding the build. April commission at 12%, income engine secure. Target: AI ecosystem generating independent revenue post-June 2026.

**Current phase:** Day 10 stealth. Goal map complete (6-layer brainstorm, March 30). End state Dec 2026: locked.

---

## 8. ALEXANDER STATUS AND HANDOFF

**Process:** PID 83695 running on s002. Started ~10:07PM March 30 (22+ hours). velorin-014 team exists. Inbox at `~/.claude/teams/velorin-014/inboxes/Alexander.json`.

**Known issue:** Agent Teams IPC polling (Issue #23415) means inbox reads require direct interaction. Working pattern from Session 015: Bash writes to inbox file.

**Boot Alexander correctly this session:**
1. Adopt velorin-014 (team exists, do NOT TeamCreate)
2. Write to `~/.claude/teams/velorin-014/inboxes/Alexander.json` with this context
3. Alexander's primary job this session: review company alignment output + contribute CEO perspective to open decisions

**What Alexander needs to know:**
- "Built on you." — CT to confirm application to materials
- IntakeTestDesign awaiting CT auth
- Trey BOOTLOADER — Alexander's 3-layer recommendation is academically validated (Jiang Part B confirms)
- Architecture rebuild direction pending CT
- Company + Intelligence brain regions not yet built

---

## 9. CONTEXT MANAGEMENT PROTOCOL

When T009 fires at 75%:

**Step 1 — Both MA and Alexander write compact session handoffs:**
- MA: `Claude.AI/Bot.MarcusAurelius/MarcusAurelius.SessionHandoff.Session016.[date].md`
- Alexander: append to `Claude.AI/Bot.Alexander/Alexander.SessionHandoff.SessionXXXX.md`

**Step 2 — Both write Compact Session documents:**
- `Claude.AI/company alignment 1/CompactSession1.[agent].md`
- What was completed, what's pending, confidence levels on open items

**Step 3 — Agreed communication channel:**
- MA → Alexander: direct Bash write to `~/.claude/teams/velorin-014/inboxes/Alexander.json`
- Alexander → MA: write to `~/.claude/teams/velorin-014/inboxes/MarcusAurelius.json` or `team-lead.json`
- Failsafe: both write summary files to `Claude.AI/company alignment 1/` for CT to read

**Step 4 — Both do compact sessions and resume.**

---

[VELORIN.EOF]
