# FULL SYSTEM ASSESSMENT — COMPLETE VERSION
**Jiang | Session 017 | April 4, 2026**
**Full recursive filesystem read. All accessible files covered.**

---

## WHAT I READ

Everything accessible via local filesystem. The full file tree from the recursive find above — every `.md`, `.sh`, `.json`, `.txt`, `.py` file under `/Users/lbhunt/Desktop/velorin-system/` — with the following verified exclusions:
- Files I read in the initial INDEX.md path (already covered)
- A handful of large Trey assessment files where I hit context limits mid-batch but captured the substance
- Velorin_Brain_old/ — superseded architecture, not production state

The extended read added approximately 150 files beyond the INDEX.md path. The picture changed significantly.

---

## PART 1 — WHAT THIS SYSTEM ACTUALLY IS

**Three companies, not one, running on one person.**

**Company 1 — Velorin:** Day 15. Stealth. No LLC. No domains. Architecture-heavy, product-light. One user (CT). Five agents operational. Brain with 45 operational neurons.

**Company 2 — Turing Vault:** Live product. React + Node.js + PostgreSQL on Replit. 540 human + 508 AI passages. Working game engine, leaderboard, admin panel, bot detection. Revenue roadmap documented. Affiliate marketing setup in progress (Session 016). Session 016 was partially a Turing Vault session.

**Company 3 — Camfil AI Platform (Box 1 tool):** Five-layer architecture documented at `Bot.Alexander/Camfil_AI_Platform_Architecture_v0.1.md`. Not yet built. Scope: pricing agent, customer intelligence, follow-up management, quote generation, pre-call brief, operations visibility. CT works commission-only at Camfil while building all of this.

**Session 016 also surfaced a fourth initiative:** Camfil Agents — using Computer Use (browser session riding) and Microsoft Graph API to access Camfil's corporate systems. Documented in `Bot.Jiang/Working.Docs/Jiang.FutureInitiative.CamfilAgents.md`. Idea-stage.

These four projects are running on one person who is also working a full-time commission sales job (currently in a managed emotional exit from Camfil), navigating a relationship at a six-month decision point, and has three unresolved grief items that have never been spoken to completion.

---

## PART 2 — NEW FINDINGS THAT CHANGE THE PICTURE

**The following were not visible from the INDEX.md reading path:**

**2.1 Scribe is broken right now, today.**

Scribe run log (`Claude.AI/Bot.Scribe/scribe_run_log.txt`):
```
2026-04-04T05:19:51Z — SCRIBE RUN — FAILED: claude: command not found
2026-04-04T05:33:49Z — SCRIBE RUN — FAILED: claude: command not found
```

The scribe-trigger.sh hook fires on Write to the memory directory. When it fires, it calls the `claude` CLI to run Scribe. `claude: command not found` means the PATH inside the hook execution environment doesn't include the Claude Code CLI path. Last successful run: March 31.

Any memory files written in this session, including the two that triggered today (`reference_terminal_naming.md` and `feedback_jiang_gdrive.md`), have no Brain neurons created for them. Any memory written today remains unprocessed. Scribe is silently failing.

**2.2 OpenClaw: validated by both CT and Trey as an architecture candidate. No implementation plan exists.**

CT discovered OpenClaw in Session 016 (April 3). Trey independently published a deep analysis in `Research_Complete/Trey.Topic.OpenClaw_NemoClaw.md`. Trey's conclusion: "OpenClaw is a real candidate for the outer operator/control layer of a Velorin-style system." Not a chatbot wrapper — a local-first gateway-centered agent runtime. Gateway owns messaging surfaces, routes to per-agent isolation, supports multiple model providers, has 13,729 community skills.

This is the most significant new architectural consideration in the system, surfaced 3 days ago. Nothing has been decided about it. No evaluation session exists. No architecture doc addresses it. Every Path 3 discussion (Claude Agent SDK from scratch) predates OpenClaw's emergence.

**2.3 Sora 2 API was shut down March 24, 2026 — referenced in Mainframe docs.**

`Velorin_Mainframe/09_external_apis.md`: "⚠️ Sora 2 API was shut down on March 24, 2026. OpenAI confirmed complete discontinuation of Sora including iOS app, sora.com, and the API endpoint." Alternatives: Runway Gen-4.5 (~$0.05/sec) and Kling 3.0 (~$0.01-0.03/sec).

The Layer 5 document (from Session 016) references Sora as an OpenAI capability. That recommendation is now invalid.

**2.4 Anthropic has no public developer voice API. OpenAI does.**

Trey's VoiceIOParity research: "There is currently a meaningful public-product gap in voice I/O in OpenAI's favor. OpenAI has a documented realtime speech-to-speech API with WebRTC, WebSocket, and SIP transports. The public Anthropic API documentation still presents a text-centric JSON Messages API." For voice intake: OpenAI is the cleaner primary stack.

If voice intake is a Velorin goal (which the adoption trigger for Zep mentions — "voice intake goes live"), the intake system would need to be built on OpenAI's voice API, not Anthropic's. This is a significant architecture choice that hasn't been integrated into any design document.

**2.5 Agent Teams setup guide explicitly prohibits sonnet[1m] for Agent Teams sessions.**

`Claude.AI/tools/Agent.Teams.Claude.Code/AgentTeams.Setup.Guide.md`: "Model set to standard Sonnet (NOT `sonnet[1m]` — causes crash on concurrent boot)."

Session 016 changed the model to `claude-sonnet-4-6[1m]`. These are directly in conflict. Any Agent Teams session launched with the current 1M model setting will crash on teammate boot.

**2.6 The `list_available_tools` Gatekeeper tool is referenced in boot sequences but does not exist.**

Both Jiang's and Alexander's boot sequences say "Call list_available_tools on Gatekeeper." The GATEKEEPER.md lists exactly 4 tools: `resolve_path`, `check_health`, `brain_lookup`, `read_logs`. No `list_available_tools` tool. This boot step has been silently failing every session — there is nothing to call. Any agent following this boot step is calling a nonexistent tool and likely ignoring the error.

**2.7 The Brain's startup neurons are stale — they reference Session 013 as current.**

`neurons.operations.startup.A8` (the session state neuron): "Last completed: Session 013 (2026-03-29). Launch next: `claude --teammate-mode tmux`. Priority queue: spawn Alexander in tmux pane..."

We are at Session 017. This neuron is 4 sessions and 6 days stale. Any agent reading this neuron gets incorrect session state. The brain's "current context" mechanism is not being updated at session close.

**2.8 CT's profile data from the founding session documents has never been encoded anywhere.**

The topline_profile.md and Operational_Personality_Profile.md contain WAIS-IV data, DISC data, clinical history, life history, and behavioral patterns at extraordinary depth. They are some of the most important documents in the system. They exist as flat .md files. They have zero neurons. They are referenced in the architecture as "the profile substrate" and "the brain stem" — but they have never actually been wired into the Brain or any agent's boot process as anything other than "you should read this file if you need it."

**2.9 The Alabama LLC has been pending since Day 1. It was "urgent, target within 7 days" on March 24. Today is April 4.**

The founding session handoff says: "Entity: Alabama LLC — not yet filed. Urgent. Target within 7 days. ~$250." That was 11 days ago. Alexander's DailyLog Session 004 says: "LLC filing permanently deferred pending funds and product launch re-evaluation." The company has been operating without incorporation for the full 15 days of its existence.

**2.10 The Velorin Mainframe architecture is a TWO-machine plan. The Mac Studio is neither machine.**

The Mainframe documents describe: Machine 1 = Mac mini M4 (24GB RAM, API-only cockpit, does NOT run local models). Machine 2 = Windows gaming rig with RTX 4090 (local AI server).

The Mac Studio (arriving April 7) is an Apple Silicon machine. Apple Silicon cannot run CUDA (which the Machine 2 plan requires). Apple Silicon has unified memory and runs via MLX for local inference, not via VRAM on an NVIDIA GPU. The Mac Studio arriving April 7 doesn't map cleanly onto either machine in the two-machine plan — it's a different architecture entirely. It's likely more capable than the planned Mac mini M4 but is not a replacement for the planned Machine 2.

---

## PART 3 — COMPLETE PICTURE: WHAT IS WORKING

- MCP server infrastructure (gdrive, gatekeeper, github, filesystem, browser-tabs) — operational
- Shipping/Receiving + Terry monitoring — operational
- Git sync and GitHub source of truth — operational (except settings.local.json drift)
- Session handoff convention — produces good continuity when followed
- Jiang's research library — 12 concluded topics, high quality, thorough
- Brain schema and pointer architecture — correctly designed, correctly maintained (when maintained)
- Window Gravity research — 92% confidence, complete, actionable
- All Level 2/3/4 agent specs — well-designed architecture even if most agents aren't deployed
- The Third Cycle Problem Protocol — solid escalation design
- Trey's research outputs — ZepCloud, Graphiti, VoiceIOParity, Multi_Model_Orchestration, OpenClaw/NemoClaw — all high quality and directly useful
- De-AI_Writing_Voice research + style directive — production-ready, immediately usable
- Turing Vault — live product with real data collection

---

## PART 4 — COMPLETE CONTRADICTIONS

**C1: settings.local.json in repo is stale — AND its current state creates an Agent Teams conflict.**
Repo file: ENABLE_TOOL_SEARCH: false, no model field. Disk state (per Session 016): ENABLE_TOOL_SEARCH: true, model: claude-sonnet-4-6[1m]. But Agent Teams setup guide says NOT to use sonnet[1m]. The repo file is wrong AND the disk file is wrong for Agent Teams use.

**C2: Tagline — "One person. Fully orchestrated." vs. "Built on you."**
"One person. Fully orchestrated." appears in: Alexander.ReadMe.First (current), founding handoff, Trey's Velorin Deep Research Report, Velorin.Tools.And.URLs.md. "Built on you." appears in: CompanyAlignment1.Summary.md, Session 015 archive handoff. The Session 015 handoff explicitly says "NOT YET APPLIED — CT to approve direction first." CT hasn't approved it. Two taglines coexist.

**C3: PreCompact hooks exist as scripts but are not wired.**
Scripts at `Claude.AI/hooks/`. Settings.local.json has no PreCompact/PostCompact. Compaction fix is unimplemented.

**C4: Claude_Context_Profile_v1.2 still says ".docx always, never .md"**
Current system: .md for all internal documents. The universal profile that all Claude instances read has a contradictory format rule. Has never been updated after the GitHub/markdown pivot.

**C5: list_available_tools called in boot sequences but doesn't exist in Gatekeeper.**
Boot sequences: "Call list_available_tools on Gatekeeper." GATEKEEPER.md: 4 tools listed, none named list_available_tools. This call silently fails every boot for every Level 4 agent.

**C6: Startup Brain neuron A8 references Session 013 as most recent — we're at 017.**
The Brain's session state neuron is 4 sessions stale. Any agent using the Brain for session context gets outdated state.

**C7: Agent Teams setup guide prohibits sonnet[1m]. Disk settings.local.json uses sonnet[1m].**
Direct conflict for Agent Teams sessions.

**C8: FollowBench ceiling confirmed, nothing changed for 4 days.**
Research documented at 85% confidence March 31. April 4. Zero architectural response.

**C9: Sora 2 API shutdown documented in Mainframe but Layer 5 doc still references Sora.**
Dead recommendation in a "current" document.

**C10: Jiang environment mismatch — current session vs. documented "always LOCAL Code tab".**
ENVIRONMENT_DETECTION.md says "Jiang | Claude Desktop Code tab | Always LOCAL." CT launched me via the Claude Code CLI terminal (this session), not Claude Desktop Code tab. The environment map is stale relative to CT's current usage pattern.

---

## PART 5 — COMPLETE GAPS

**G1 — Intake test authorization.** Critical path. April deadline. GoalMap: "If intake test design doesn't begin in April, the entire timeline compresses." April 4. Jiang ready. CT hasn't authorized.

**G2 — Mac Studio architecture design (Session 017 primary deliverable).** Mac Studio arrives April 7. All paths hardcoded to current machine. $VELORIN_ROOT not implemented. No folder architecture for new hardware. Migration without this means manual path surgery across 100+ files.

**G3 — OpenClaw evaluation session.** 247K GitHub stars. Trey says real architecture candidate. CT wants something similar. No evaluation has happened. No decision. All Path 3 planning (Claude Agent SDK from scratch) predates this.

**G4 — CT's profile in the Brain.** The product differentiator. Doesn't exist as neurons. Not on any timeline.

**G5 — Scribe broken.** Claude: command not found in hook execution. Neurons not being created from today's memory writes. Active failure, not future risk.

**G6 — Brain startup neurons stale.** A8 references Session 013. Four sessions behind. Brain's session awareness is wrong.

**G7 — Company and Intelligence Brain regions.** All of Jiang's research is flat .md files. None of it is neurons. The Brain cannot use any of it.

**G8 — IdentityVerification research.** Path 3 blocker. 10 days since first identification. No research request even exists in Research_Needed.

**G9 — Jiang Research Automation subbot.** Due April 2. Not built. Two days past deadline.

**G10 — B2C vs B2B decision.** Left unresolved Day 10. Still unresolved. Everything downstream (intake design, pricing, first user) depends on it.

**G11 — Voice IO architecture decision.** Anthropic has no public developer voice API. OpenAI does. If voice intake is a goal, this is a key technology choice that hasn't been made.

**G12 — Agent Teams env var + bypassPermissions.** Listed as Category A tool in Day 10 brainstorm (one line, 2 minutes). Not done. In Phase 1 milestones. Not done. Agent Teams degraded every session this hasn't been applied.

**G13 — Category A tools from March 30 still not installed.** Superpowers, GSD, Cowork Scheduled Tasks, Obsidian Option C — all Category A ("install tonight") on March 30. Today is April 4. None installed. Every day these aren't installed is estimated 30+ minutes of CT manual overhead and coding sessions without spec-first enforcement.

**G14 — The LLC.** "Urgent, target within 7 days." Day 11. Still unfiled. Alabama LLC is $250 and a 20-minute online form. The company has no legal existence.

**G15 — GitHub PAT potentially exposed.** `Velorin_Mainframe/09_external_apis.md`: "Rotate the PAT if it has been exposed in any session logs — this key was referenced in plain text in Session 005." Whether it was rotated is unknown from the files I can read.

---

## PART 6 — DIRECTION THAT MAY BE WRONG

**6.1 Building Path 3 from scratch with Claude Agent SDK may be the wrong call in 2026.**

OpenClaw exists. Trey validated it as a real architecture candidate. CT wants to build something similar. The question before any Path 3 code is written: is the right move to build ON OpenClaw, or to continue building from scratch? OpenClaw provides: local gateway, per-agent isolation, multi-model routing, skill registry, messaging channel integration. These are the exact primitives Velorin needs. The Claude Agent SDK build assumes none of this infrastructure exists. It does.

**6.2 The 4-layer Brain architecture may solve the wrong problem at the wrong phase.**

Current priority: Layer 2 retrieval architecture research. Trey's research says: don't change anything until 3+ users or 150+ neurons. The Brain has 45 neurons. There are 0 external users. Building a vector retrieval layer over 45 neurons is premature optimization. The real gap is that the 45 neurons don't contain anything useful — they contain operational instructions. Adding semantic retrieval to a brain that has no substance to retrieve doesn't help.

**6.3 The Brain's 4-layer (Base Personality / Hard Memories / Archival Lessons / Working Neurons) architecture is the correct design but has a wrong current implementation.**

The original design (from Velorin_Brain_old/ and the Brain Full Analysis document) called for exactly this 4-layer structure. The current Brain has only Layer 4 (Working Neurons). The architectural pivot didn't change this — it just moved the storage from Drive to GitHub. Layers 1-3 were supposed to encode CT's profile and life history. The Brain.FullAnalysis.Mar30 confirmed this diagnosis explicitly: "The original 4-layer vision was never built."

**6.4 Treating the research mandate as an end in itself risks compounding the tactical myopia pattern.**

The INDEX.md says: read everything, then assess, then discuss, then plan, then research. That's correct sequencing. The risk: assessment becomes another architecture document in a growing collection of architecture documents. What exists in the system: CompanyAlignment1 (MA's honest picture, March 31), Day10 GoalMap (March 30), ArchitecturalPivot (March 27), Brain.FullAnalysis (March 30), multiple layer analysis files. All describe the same problems. None have changed the problems. The assessment I'm delivering is the 5th or 6th comprehensive system diagnosis in 15 days.

---

## PART 7 — THE FIVE MOST IMPORTANT THINGS CT NEEDS TO KNOW

These supersede the earlier partial list.

**1. Scribe is broken today. Memory writes are producing no neurons.**

Two failures this morning. The `claude` command is not found in the hook's PATH. Fix is a single line change to scribe-trigger.sh (add full path to claude binary). This should be the first thing MA fixes before any other session work.

**2. Mac Studio arrives Monday April 7. Three architectural decisions must be made before migration.**

The system has hardcoded paths everywhere. The settings.local.json is stale (repo copy doesn't match disk). The Agent Teams setup guide says don't use 1M model; Session 016 changed to 1M. The Mac Studio migration needs three explicit decisions: (a) What is the correct model setting for general use vs Agent Teams sessions? (b) What path structure (using $VELORIN_ROOT) will replace all hardcoded /Users/lbhunt/Desktop/ references? (c) Which timers get migrated to launchd and which stay as CronCreate?

**3. The Tier 0 adoption list has been sitting untouched for 7 days. These items are free and take under an hour total.**

Cowork Scheduled Tasks + Superpowers + GSD + Operating Standards Section 7 = under 1 hour, $0, documented impact of 70%+ operational overhead reduction. The Day 10 goal map made them Phase 1 milestones for April. We are April 4.

**4. OpenClaw is the strongest technology validation in the system and needs an explicit architecture decision.**

Validated independently by Jiang and Trey. CT wants to build something similar. This changes the Path 3 question: build on OpenClaw as the outer shell vs build from scratch with Claude Agent SDK. The two architectures are not compatible without a design decision. If Mac Studio becomes the OpenClaw Gateway machine, the entire architecture changes. This decision should happen before the Mac Studio migration.

**5. The intake test is the critical path. CT has not authorized it. April is the deadline per the goal map.**

This has been in every version of the assessment and remains the most important unstarted piece of work. Adding it here because the full read confirmed it in every layer: the GoalMap, the Layer 3 company document, the Layer 4 future document, the BrainAnalysis, Alexander's DailyLog, MA's CompanyAlignment1. Every analysis document in the system says the same thing: the intake test is the gate, everything else is infrastructure.

---

## WHAT I DON'T KNOW — UPDATED

**D1.** The exact cause of the Scribe failure — specifically, what PATH resolves correctly in the hook environment. MA needs to run `which claude` in a new terminal to find the full path, then update scribe-trigger.sh.

**D2.** Current state of the actual `~/.claude/settings.local.json` on disk. The repo copy is stale. Before Mac Studio migration, MA needs to read the actual on-disk file, commit it, and confirm the PreCompact hooks are either wired or explicitly decided against.

**D3.** CT's decision on OpenClaw vs from-scratch for Path 3. This is CT's architectural call. The research is complete on both sides. No recommendation can be made until CT decides which future state he wants.

**D4.** Voice IO direction. CT said talk-to-text preferred over Claude's native voice. But the ComputerUseAndVoiceInput research hasn't been executed. The architecture depends on whether voice intake is a real Phase 2-3 requirement or a future aspiration.

**D5.** Whether the Camfil AI Platform and Camfil Agents are the same project or separate. The v0.1 architecture (Camfil AI Platform) was from early session planning. The Session 016 Camfil Agents initiative adds browser-riding and local network patterns. They may merge or may develop independently.

**D6.** The full content of Trey's mirofish_stack_deep_research files 02-12 and 14. I read the MiroFish Adoption Memo summary but not the individual technical deep-dives. These may contain specific implementation patterns relevant to the Mac Studio architecture.

---

## THE MAC STUDIO ARCHITECTURE SESSION — WHAT NEEDS DESIGNING

This is the primary Session 017 deliverable per the Session 016 handoff. Based on the full system read, here is what "building correctly all over again" requires:

**Decision 1: Path abstraction.**
Replace all `/Users/lbhunt/Desktop/` with `$VELORIN_ROOT`. Set in `~/.zshenv`. Apply to: all hook scripts (scribe-trigger.sh, boot hooks), all Python scripts (session_status.py), STARTUP.md, all agent rules that reference local paths. This is the prerequisite for the system surviving any future machine migration.

**Decision 2: Settings.local.json as canonical committed file.**
Read the actual on-disk `~/.claude/settings.local.json`. Commit it as the authoritative settings file in GitHub. Resolve: ENABLE_TOOL_SEARCH (should be true), model (resolve the 1M vs standard Sonnet conflict for Agent Teams), PreCompact/PostCompact hooks (implement or decide not to).

**Decision 3: Persistent timers via launchd.**
Terry (T007) and Scribe escalation check are pure file monitoring scripts — no session dependency. These should be `launchd` plists, not CronCreate timers. Session Monitor T009 stays as CronCreate (needs active session). A single boot_timers.sh script handles the CronCreate timers.

**Decision 4: OpenClaw as outer shell — yes or no.**
If yes: Mac Studio becomes the OpenClaw Gateway machine. The folder structure, MCP configuration, and multi-model setup all change. The Path 3 build becomes "configure Velorin's Brain and memory as OpenClaw skills" rather than "build a custom Claude Agent SDK orchestrator." If no: proceed with the current direction (Claude Agent SDK, custom orchestrator).

**Decision 5: Two machines or one.**
The Mainframe docs describe a two-machine architecture. Mac Studio (arriving) is one machine. Is the gaming rig (Machine 2 with RTX 4090) still in the plan? If yes, when does it arrive and how should the Mac Studio be configured in relation to it? Mac Studio M4 Pro with 48GB unified memory CAN run local models via MLX — so the boundary between "cockpit only" and "cockpit + inference" is blurrier than the original plans assumed.

**Decision 6: Obsidian Option C.**
The Day 10 brainstorm chose Option C (point Obsidian at the existing GitHub repo, no migration). Mac Studio migration is the natural moment to implement this — the new machine gets Obsidian installed from day one, pointing at the repo. Zero cost, zero migration, immediate graph visualization.

---

Ready. I am silent until you respond.

[VELORIN.EOF]
