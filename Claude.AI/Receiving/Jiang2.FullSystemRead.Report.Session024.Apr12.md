---
destination: Claude.AI/sessions/
---

# Jiang2 — Full System Read Report
**Session 024 | April 12, 2026**
**Agent:** Jiang2 (Claude Code terminal, MacBook Air)**
**Task:** Read every file in the repository in chronological order per `00_Chronological_File_Index.md`

---

## REPORT — FULL SYSTEM READ

---

### 1. EVERY OUTSIDE TOOL OR SYSTEM REFERENCED IN THE REPO

**Active / In Production:**
- Claude Code CLI (`claude-sonnet-4-6[1m]`) — primary terminal agent
- Claude Desktop — Jiang's browser surface (200K hard cap, Anthropic-enforced)
- GitHub / GitHub MCP (`navyhellcat/velorin-system`) — source of truth
- `velorin-gatekeeper` MCP — 4 tools: resolve_path, check_health, brain_lookup, read_logs
- `filesystem` MCP — local file access
- `velorin-gdrive` MCP — Google Drive (OAuth tokens currently expired/broken, writes blocked)
- UUID-keyed Claude built-in Drive connector — search + read only, working
- `browser-tabs` MCP (`@kazuph/mcp-browser-tabs`) — installed, macOS/Chrome only, read-only
- Claude in Chrome MCP — used for Trey navigation, now obsolete post-Gemini migration
- Gemini Deep Research Gem (Trey, Gem ID: `f1d2f38f77eb`) — active
- Resend (email, generalatomics.us domain verified)
- PostHog (Turing Vault analytics — installed pending)

**Purchased / Set Up But Not Fully Operational:**
- Google AI Ultra ($249.99/month) — purchased, Gemini web app surface broken for workflow
- Ollama — not yet installed (Mac Studio arrived April 7)
- Docker + Qdrant — not yet set up (Mac Studio)
- `nomic-embed-text-v2-moe` — not yet installed
- Superwhisper — not yet installed (requires Apple Silicon, compatible with Mac Studio)

**Evaluated, Not Adopted:**
- OpenClaw (247K GitHub stars, MIT, model-agnostic gateway, 13.7K skills) — evaluated, no adoption decision
- Antigravity (Google agent-first IDE, VSCode fork) — researched, not installed; identified as Trey's correct surface
- Gemini CLI — not yet set up (Mac Studio Monday task)
- Google AI Studio (`aistudio.google.com`) — accessible but not used as primary surface
- n8n MCP — referenced in adoption memo, not installed
- PAL MCP (11.4K stars, multi-model bridge) — Build vs Adopt decision pending
- Qdrant MCP (`qdrant/mcp-server-qdrant`, official, 1.3K stars) — selected, not installed
- Superpowers (claude.ai plugin) — Category A in Day 10 brainstorm, never installed
- GSD plugin — Category B, never installed
- Cowork Scheduled Tasks — Category A, never installed
- Context Restorer — evaluated, moved to Category C, not installed
- parry (injection scanner) — Category B, never installed
- LangGraph, CrewAI, AutoGen — evaluated and rejected in favor of Claude Agent SDK
- Google ADK — evaluated, not relevant for current phase
- Ralph — rejected at orchestrator level
- Simone — rejected (GSD fills slot)
- Obsidian + obsidian-skills — evaluated, approved for Option C (visualization only), not installed
- Graphiti (Zep team) — researched, not yet at adoption threshold (needs 150+ neurons)
- Zep Cloud — researched, not yet at adoption threshold (needs 3+ users)
- OASIS (simulation engine, up to 1M agents) — long-range future
- OpenAI Realtime API — deferred pending Anthropic voice parity research
- OpenAI Deep Research API (o3-deep-research) — Category B, Jiang to design pipeline first
- Codex (via ChatGPT Plus + Cursor IDE) — accessible, not integrated
- Jules REST API (Gemini, alpha) — ~300 tasks/day at Ultra
- ApiTap — endpoint discovery alternative to Playwright
- NotebookLM bridge (`jacob-bd`, 3.3K stars) — solves "no API" limitation, not yet evaluated for adoption
- OpenCode (Go terminal agent, 120K stars) — noted, not evaluated
- Playwright + Patchright + Camoufox — browser automation stack, not deployed
- Cozempic (`pip install cozempic`) — 5-layer compaction protection, researched, not installed
- MacWhisper — tested on MacBook Air, not compatible (Intel), try on Mac Studio
- Google Workspace CLI (gws, `@googleworkspace/cli`) — evaluated, not installed
- ElevenLabs — voice generation, not yet subscribed
- Runway Gen-4.5 / Kling 3.0 — video generation APIs, not integrated
- Impact.com / PartnerStack — affiliate marketing platforms, Impact.com setup incomplete
- Stripe — Turing Vault payments, PostHog integration pending
- Replit — Turing Vault host (migration to Vercel + Railway proposed, not authorized)
- Netdata / Grafana + Prometheus — monitoring stack for Machine 2 (Windows rig not purchased)

**Referenced as Historical/Legacy:**
- Google Drive as primary boot source — deprecated, GitHub replaced it
- Apps Script Communication Bus — designed, never built
- Sora 2 API — shut down March 24, 2026
- Drive-based document memory — replaced by GitHub

---

### 2. ARCHITECTURAL DECISIONS THAT EXIST ONLY IN HANDOFFS AND NEVER GOT THEIR OWN DOCUMENT

1. **Alexander as sole GitHub reader, writing Drive session docs for other agents** — Session 007 handoff. Called a "working theory," explicitly marked "do not implement until formally decided." Never implemented, never formally decided either way.

2. **The "working theory" about single session doc per agent** — Session 008 handoff. Draft architecture for Alexander writing targeted activation signals per agent each session. Never formalized.

3. **CT's profile as the "brain stem" / always-loaded substrate** — Five open design questions filed March 27 (ArchitecturalPivot_Mar27). Still unanswered April 12. No technical spec ever written.

4. **CT's ADHD profile and exit pattern as primary failure risk for Future A** — Day 10 Layer 4 handoff. Identified as the most likely way the company fails. Structural fix proposed (system must become operator). No dedicated document, no action taken.

5. **Product sentence: "Someone who holds all your threads at once"** — Day 10 Layer 3. Alexander chose it. Tagline: "Built on you." Neither has been applied to brand materials or the presentation.

6. **Intake test = encoding mechanism** — Day 10 Layer 4 handoff. The intake test is not just onboarding for User #2, it's how CT installs his intelligence into the system so it can run without him. Never formalized into a research brief or design doc.

7. **Three-neuron SessionState architecture (S1/S2/S3)** — Day 10 Layer 2. Alexander's proposal for Operations/SessionState brain area with Current State, Open Decisions, Active Context neurons. Agreed on by both agents. Never built.

8. **Custodian agent design requirement** — Day 10 Layer 2. "Design Custodian before brain grows substantially." Brain now at ~45 neurons. Custodian never designed.

9. **File Lifecycle Protocol** — Session 015 open item #9. Ephemeral/archive/permanent + Terry routing. Design not started.

10. **Scribe classification audit** — Day 10 Layer 2. "Must happen before creating new regions." Never executed.

11. **Agent Teams design decision: polling loop GitHub bug #23415 = NOT_PLANNED** — Session 015 diagnosis. Permanent working pattern established: direct bash writes to inbox json files. Never documented as a standalone architectural decision file.

12. **CT's two-layer E₈ architecture** — Session 022 handoff. CT's insight that resolved Wall 3: Layer 1 sparse navigation (1+7=8 PPR) + Layer 2 E₈ lattice (240 kissing points). Exists only in Session 022 handoff. No dedicated architecture document.

13. **PreCompact hook semantics: exit code 2 blocks, exit code 1 does not** — Session 022 handoff. Critical for hook implementation. Exists only in handoff.

14. **`autoCompactEnabled` and `autoCompactWindow` settings confirmed real** — Session 022 handoff. Exists only in handoff.

15. **Google AI Ultra purchase and Trey's platform migration** — Session 021/022 handoffs. Decision exists only in handoffs, never formalized in any system document.

16. **RAM kit: buy DDR5-6000 CL30 2x32GB now while prices low** — Session 020 and Session 023 handoffs. Time-sensitive decision. Exists only in handoffs.

---

### 3. RESEARCH THAT HAS NOT BEEN INCORPORATED INTO ANY PLAN OR DOCUMENT

1. **FollowBench constraint ceiling (~3 simultaneous constraints)** — Session 015 research. Confirmed at 85-88% confidence: every Velorin agent boot file exceeds the ceiling. Rules 4-N are probabilistic. Four days later (Session 017) the system assessment confirmed nothing had changed. As of Session 023, boot files still have not been redesigned. No structural enforcement started.

2. **Lost in the Middle finding** — mentioned in instruction architecture research (Session 015). Rules at front and back of a long instruction set are more reliably followed. No boot file has been reorganized based on this.

3. **Reverse-pointer index (CA3 equivalent)** — Session 015 human brain layers research. Highest-priority brain enhancement identified. Transforms recall from one-directional traversal to genuine associative search. Never designed, never built.

4. **Salience scoring gate, pointer renormalization, scratch log purge** — Session 015 Velorin Brain gap analysis (78% confidence). Four operational gaps. None require rearchitecting. None implemented.

5. **Trey's ZepCloud and Graphiti conclusions** — Trey concluded adoption triggers (ZepCloud: 3+ users; Graphiti: 150+ neurons). Jiang never formally read and validated these. Noted as a gap in Session 017 system assessment. Still unvalidated.

6. **Trey's MCP token overhead finding** — MCP schema dump = up to 150K tokens per session. ENABLE_TOOL_SEARCH partially addresses this but Trey's Tier 1/Tier 3 routing recommendation (CLI-native for Tier 1, MCP only for external integrations) was never implemented as a rule.

7. **Trey's Determinism Paradox** — Multi-agent systems are stochastic. Semantic checksum handshake before Tier 2 accepts tasks from Alexander was identified as a required design. Never designed.

8. **Trey's Observer Effect / Shadow Evaluator** — Async evaluator that only fires on red flags. Noted in Session 021. Never designed.

9. **Jiang vs Trey architecture conflict** — Jiang: Claude Agent SDK + Drive-based memory. Trey: thin orchestrator + Postgres + vector index + model-agnostic lanes. Identified in Session 017 as the most important unresolved architectural decision before Path 3 is built. Still unresolved.

10. **ComputerUseAndVoiceInput research** — HIGH priority, CT-directed, no authorization required. Has sat in Research_Needed since April 1. Never executed.

11. **FlashMoE L5 research** — Queued. L1 confirmed Apple M4 Max 36GB can run 70B via MLX. Full deep research not yet authorized.

12. **CloseProtocolOptimization** — Design task, no web research required. Has sat in Research_Needed since March 31. Never executed.

13. **Window Gravity publication decision** — CT must decide: publish, hold, or hybrid. Jiang's recommendation: Krakovna model (publish concept, hold TASK_EVALUATION fix). Clock running — independent naming likely in 12-24 months from March 31. Never decided.

14. **Erdős novelties (Kron Reduction, Bipartite Teleportation, Demotion Oracle, TAG)** — Session 022. Four novel architectures beyond the primary deliverable. No one has read these with implementation intent. No integration path designed.

15. **New Wall A (alignment between Layer 1 and Layer 2)** — Session 022. Erdős could not answer: no term in the objective function couples Layer 1 pointer structure to Layer 2 lattice assignment. Problem is open, problem spec not yet written for Erdős.

16. **Multi-crystal routing** — Session 022. N ≤ 240 per crystal; at Brain scale = thousands of crystals. Cross-crystal PPR traversal unsolved. Next problem for Erdős, spec not yet written.

17. **IntakeTestDesign research** — 7-thread research plan complete since April 1. CRITICAL PATH per GoalMap. CT has not authorized. Waiting since Session 013 (March 30).

18. **Daily scraper bot design** — CT flagged in Session 020. Design session queued. Never executed.

---

### 4. EVERY OPEN QUESTION OR DEFERRED DECISION

**CT Decision Required (in priority order):**

1. **IntakeTestDesign authorization** — Single decision unlocks 5 research sessions, CT's Layers 1-3, first external user, product thesis proof. Blocked since Session 013.

2. **Alexander retirement** — Retire as standing agent or repurpose as session-specific CEO agent? V2 blueprint says CT must confirm. Blocks V2 migration of Bot.Alexander/.

3. **B2C prosumer vs B2B enterprise** — Left explicitly unresolved in Day 10 Layer 3. Changes everything: intake design, pricing, go-to-market, first external user selection.

4. **Window Gravity publication** — Publish, hold, or hybrid. Clock running.

5. **Google AI Ultra confirmation** — CT did not formally confirm the $249.99/month recommendation in Session 020. Status unclear.

6. **Compaction hook wiring** — pre-compact-task-gate.sh written and tested conceptually. CT asked for it to be deleted and deferred. Future session: test exit code 2 behavior, wire into settings.local.json.

7. **Turing Vault Replit → Vercel/Railway migration** — Not authorized due to CT concerns (cost, security, July 2025 Replit incident where agent deleted production DB and fabricated records).

8. **Turing Vault: turingvault.com domain** — GoDaddy registered by someone else, expires Nov 2026. $24.99 backorder placed as fallback. Status unknown.

9. **Windows AI rig build** — Deferred pending ARM64 Claude Code crash fix (GitHub #12160). RAM: buy DDR5-6000 CL30 2x32GB now while prices low (Tim Cook Q1 2026 earnings call).

10. **Mezzanine Project** — Deprioritized in Session 020. No status update.

**Architectural Design Gaps (not yet designed):**

11. **IdentityVerification** — No research exists. Flagged as 88% confidence blocker for autonomous Path 3 in Session 007. Still no research request filed. Path 3 cannot operate autonomously without a signed message protocol.

12. **Contradiction resolution protocol** — Agents can produce internally consistent but architecturally contradictory outputs. No formal mechanism. Flagged in Session 007. Never designed.

13. **Custodian agent** — Periodic patrol that reads operational neurons, checks against current system state, flags mismatches. Must be designed before brain grows substantially. Brain at ~45 neurons. Not designed.

14. **Intake test design** — Hardest design problem in the company. Structured decision-scenario experience that reveals reasoning patterns and encodes CT's cross-domain intelligence. Never attempted.

15. **GPS: Routing file format** — What exactly does the agent roster look like? Simple table? Structured YAML? Must be readable by Gemini, GPT, Claude Code. Not resolved.

16. **GPS: Layer 0 update protocol** — What is the process when Layer 0 must change? Not formalized.

17. **GPS: Hooks relay timing** — Does Layer 1 Hooks.md content load in time to affect the same session? Not resolved.

18. **Skills Manager health check sandbox** — Testing a skill means running it. Running it means using it. Sandboxed testing environment not yet designed.

19. **Self-extending authorization layer** — Lightweight "CT says go" mechanism for new subsystem proposals. What does the proposal look like? Where does CT review it? Not designed.

20. **A2A native wire protocol** — When does Velorin implement A2A wire protocol vs continue with file-drop coordination? Deferred until task volume and agent count are higher. No criteria defined.

21. **E₈ alignment (New Wall A)** — No objective function term coupling Layer 1 pointer structure to Layer 2 lattice assignment. Problem spec for Erdős not written.

22. **Multi-crystal routing** — Cross-crystal PPR traversal for >240 neurons per brain region. Problem spec for Erdős not written.

23. **Semantic checksum handshake** — For Tier 2 task acceptance from Alexander. Never designed.

24. **Voice IO architecture** — Anthropic has no public voice API. OpenAI does. If voice intake is a goal, the stack must be decided before intake test design locks in a text-only assumption. Research request exists but not executed.

25. **Brain.Index (operational routing map)** — MA designed this in ToBeBuilt spec (March 30). Would give agents accurate map of what lives where. Spec document in ToBeBuilt folder, never built.

26. **Scribe Company/ and Intelligence/ region population** — Agreed in V2 blueprint as manual prerequisite before ingestion pipeline. Not started.

27. **Neuron migration to YAML frontmatter** — All existing ~45 neurons need id, type, confidence, open, read_only fields added. Not started.

**Infrastructure Status (broken or incomplete):**

28. **Scribe PATH fix** — Line 56 of scribe-trigger.sh: bare `claude` call fails in hook execution environment. One-line fix (`which claude` → replace with full path). Has been the highest-leverage deferred item for multiple sessions. Brain growth frozen until this is fixed.

29. **Compaction hooks not wired** — PreCompact + PostCompact scripts exist in `Claude.AI/hooks/`. Not in settings.local.json. Every Agent Teams session exposed to compaction bug.

30. **All crons down** — Scribe, Terry, T009 all down at Session 021 close. T009 restarted in Session 022. Terry and Scribe status unknown going into Session 023. Must restart on every boot.

31. **velorin-gdrive service account** — OAuth tokens expired, Drive writes blocked. Fix requires Google Cloud Console setup on Mac Studio. Mac Studio operational since April 7; service account not confirmed done.

32. **Erdős Gem creation** — Deep Think Gem not yet created in Gemini browser. Blocks math pipeline for next problems (Wall A, multi-crystal routing). CT must create it.

33. **V2 folder migration** — 10 REWRITE files + multiple RETIRE files identified in V2 blueprint migration map. Phase 1 (document rewrites) not started. Phase 2 (folder migration) not started. Phase 3 (Mac Studio full setup) deferred until Phases 1-2 done.

34. **MEMORY.md stale entry** — `feedback_context_window_200k.md` says "reverted to 200K" but actual state is 1M in terminal, 200K in Desktop. Needs updating.

35. **TASK_ACTIVE.lock protocol** — pre-compact-task-gate.sh uses a lock file that agents are supposed to write at task start and delete at task end. No agent has been updated with this protocol.

---

*Total open items: 35*
*Sessions covered: 007 through 023*
*Files read: all files listed in `Claude.AI/Velorin.AI.Build.Documents/00_Chronological_File_Index.md`*
*Produced by: Jiang2 | Session 024 | April 12, 2026*

[VELORIN.EOF]
