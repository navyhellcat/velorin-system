# Jiang — Full System Read: Tool Intelligence Supplement
**Prepared by: Jiang, Director of Strategic Intelligence**
**Session: 017 | April 4, 2026**
**Mandate: Full recursive filesystem read — every file in velorin-system/**

Read alongside:
- `Jiang.SystemAssessment.Session017.Part1.ReadFirst.md` — first-pass layer analysis
- `Jiang.SystemAssessment.Session017.md` — second-pass extended findings

This supplement incorporates what the first two passes missed: the full tool research library, all Trey research files, all archived session data, all infrastructure specs, and all supporting agent architecture documents.

---

## SECTION 1 — WHAT RESOLVES PREVIOUS GAPS

### G1 — Layer 0: CT's felt discomfort resolved
**Source:** Zone 00 Session Summary, Zone 07-08 Obsidian files, Zone 04 Connectivity Stack

The resolution CT was sensing is documented explicitly in the tool research: the three-system storage architecture (GitHub + Drive + local) is not the end state, it is the in-transit state. The tool research identified the answer **seven sessions ago** and it has not been implemented.

**The answer is Obsidian Option C.** Zone 08 states directly: "Replaces: Drive boot protocol, [VELORIN.EOF] checking, manual uploads, session handoffs, Google Docs knowledge web." Zone 00 confirms: "Obsidian + CLAUDE.md is the direct structural answer to the reboot token problem. Near-zero boot cost."

Pointing Obsidian at the existing GitHub repo (`/Users/lbhunt/Desktop/velorin-system/`) gives:
- A unified human-navigable interface over the same files agents already use
- Zero migration (files stay where they are)
- Zero boot token cost (Claude Code reads local .md directly — no API call, no Drive fetch, no GitHub pull per file)
- Graph visualization of the Brain's pointer structure immediately
- Backlinks (the reverse pointer index — Gap 1 from HumanBrainLayers — addressed natively)
- Semantic search over the full vault

**Confidence that Obsidian Option C resolves the Layer 0 discomfort: 87%.** The storage doesn't change. The access layer becomes unified and human-navigable. CT's sense that something was wrong about Layer 0 was correct — the missing piece was a unified access interface, not a new storage system.

**What does NOT change:** GitHub remains canonical source. MCP servers remain operational. The push/pull discipline stays the same.

---

### G1b — Layer 1: Compression answers were in the tool research
**Source:** Zone 01 (Superpowers), Zone 02 (GSD), Zone 04 (Connectivity Stack — Tool Search), Zone 00 Session Summary

The Layer 1 analysis concluded "TurboQuant is future, park it." Correct — but Layer 1 isn't empty. The tool research found current-applicable compression mechanisms that were never connected to the layer model.

**What addresses Layer 1 now:**

1. **Obsidian + CLAUDE.md boot path**: Zone 00 explicitly states this addresses the reboot token cost problem. Current boot: agents load full GitHub documents via API. Obsidian boot: agents read local files directly at zero token cost per file. Boot cost drops to near-zero.

2. **Tool Search (Claude Code, March 2026)**: Zone 04 states Tool Search reduces context by ~95% by deferring deferred tools until needed. The Session 016 handoff confirmed this was disabled (ENABLE_TOOL_SEARCH: false) and was fixed. Session 017 is running with it enabled.

3. **Superpowers' `remembering-conversations` skill**: SQLite vector index of prior conversations. Agents query compressed past context instead of loading raw session history. Maps directly to the knowledge web concept.

4. **GSD's CONTEXT.md pattern**: Synthesized project state file. Loaded into context instead of all raw documents. Reduces the per-session context load to the minimum needed.

**Confidence: 82%.** These are real, available-now solutions that address Layer 1. The "park it" conclusion was based on reading only the TurboQuant framing, missing the tool research layer entirely.

---

### G2 — Layer 2: Retrieval question is answered by Trey's research
**Source:** Trey's Research_Complete/Jiang.Topic.ZepCloud.md, Trey's Research_Complete/Jiang.Topic.Graphiti.md, Zone 08 (Obsidian backlinks)

The Layer 2 "UNSETTLED — PRIMARY RESEARCH MANDATE — BLOCKING" label is incorrect given the full read.

**Trey's ZepCloud research (completed, filed March 31):** Don't adopt now. Adoption triggers: 3+ external users OR voice intake goes live. Current state: 0 external users.

**Trey's Graphiti research (completed, filed March 31):** Don't adopt now. Adoption trigger: 150+ neurons OR 3+ user brains. Current state: 45 neurons, 1 user brain.

**Both adoption thresholds are unmet by wide margins.** Layer 2 research has been answered. The current pointer traversal approach (navigate known neurons, follow rated pointers) is correct for the current scale. Nothing is blocking.

**Obsidian backlinks address the highest-priority Layer 2 gap**: The reverse pointer index (Gap 1 from HumanBrainLayers, "highest priority Brain enhancement") is available immediately via Obsidian's native backlinks feature. Every wikilink in a Brain neuron creates a corresponding backlink entry. No build required.

**Updated Layer 2 status:** SETTLED at current scale. Revisit when triggers are met. **Confidence: 88%.**

---

### G3 — Scribe PATH fix is a one-line change
**Source:** `Claude.AI/Bot.Scribe/scribe-trigger.sh`

The scribe-trigger.sh script calls `claude --print --dangerously-skip-permissions` on line 56. In the hook execution environment, the PATH doesn't include the Claude Code CLI location. The fix: replace `claude` with the full executable path (e.g., `/usr/local/bin/claude` or `~/.local/bin/claude`).

Run `which claude` in a live terminal to get the exact path. Edit line 56 of scribe-trigger.sh. Commit. Done. Scribe is restored.

**Confidence: 99%.** The error message is explicit. The fix is mechanical.

---

### G4 — Layer 0 "three systems" confusion: the transition plan exists
**Source:** Zone 11 Adoption Memo, Zone 08 Obsidian as storage

The Adoption Memo has an explicit migration sequence: Tier 2 (Month 1): "Obsidian vault creation, migration of knowledge web. Drive demoted to backup." Tier 3 (Month 2-3): "Boot protocol retirement. CLAUDE.md replaces Drive boot. Obsidian primary."

The migration sequence was documented and tiered in March. The plan exists. Nothing has been executed.

---

### G5 — The "subagent-driven development" skill IS Path 3 inside Claude Code
**Source:** Zone 01 (Superpowers), Zone 00 (Session Summary)

Zone 00 states explicitly: "The subagent-driven development skill is Path 3 inside Claude Code." Superpowers' `subagent-driven-development` skill dispatches fresh Claude subagents per task with a two-stage review. This is programmatic multi-agent orchestration within the Claude Code environment.

**Implication:** Before building a custom Claude Agent SDK orchestrator, evaluate whether Superpowers' subagent development skill meets the Path 3 requirements. It may eliminate months of custom build. **This was flagged in the tool research in March and never evaluated.**

---

### G6 — Cowork can't run on current Mac but WILL run on Mac Studio
**Source:** Zone 03 (Cowork), Zone 00 Session Summary

Zone 03 explicitly states: "Cannot run on this Mac. Relevant when new machine arrives." The Mac Studio arrives April 7. This means Cowork becomes available Monday — the same day as the hardware migration.

The Tier 0 adoption items that have been deferred are not all deferrable for the same reason. Cowork was legitimately blocked by the current hardware. Superpowers, GSD, and Obsidian are not hardware-blocked and remain unexecuted.

---

### G7 — Turing Vault Phase 2 architecture has been designed but not built
**Source:** `Bot.Replit/Turing_Vault.Phase2.Architecture.md`

The Phase 2 architecture (all difficulty levels free, IQ Vault as the single paywall) was designed in March but marked "NOT STARTED." The design is complete. The YouTube strategy document (April 1) adds a content channel monetization path. Affiliate marketing setup is in progress (Session 016). None of the Phase 2 build work has started.

**Current Turing Vault state:** Live product with working game engine, corpus, scoring, admin panel. Revenue infrastructure (Stripe webhooks, GA4, email capture) not yet installed. Phase 2 redesign not started. YouTube channel not created.

---

## SECTION 2 — WHAT CONFLICTS WITH OR REVISES PREVIOUS CONCLUSIONS

### Revision 1 — The Jiang vs Trey architecture discrepancy is not a conflict. It's three layers of the same stack.

Previous assessment framed this as an unresolved contradiction requiring explicit CT decision. Full read shows a more nuanced picture.

Jiang's AgentOrchestration (February 2026): Claude Agent SDK as Path 3 runtime. Claude-centric. MCP-native.

Trey's Multi_Model_Orchestration (April 2026): Thin orchestrator + Postgres + vector index + model-agnostic lanes. Build the infrastructure layer.

**OpenClaw discovery (April 3, validated by both CT and Trey):** Local-first Gateway. Multi-model routing. 13,729 skills. Anti-lock-in design. Trey's full Research_Complete document: "real candidate for outer operator/control layer."

These describe three different layers:
1. **OpenClaw** = outer shell / gateway layer (routes messages, manages channels, dispatches to models)
2. **Trey's infrastructure** = data/memory/routing layer under the shell (Postgres + vector index + shared tools)
3. **Claude Agent SDK** = Claude-specific subagent runtime within the system

They are not competing. They can coexist. The correct unified architecture is:

```
OpenClaw Gateway (outer shell — model routing, channel management, skills)
    ↓
Model Lanes (Claude via Claude Agent SDK | Codex for code | Perplexity for research)
    ↓
Shared Infrastructure (Postgres memory + vector index + MCP tool layer)
    ↓
Velorin Brain (GitHub neurons — the knowledge layer)
```

**What this changes:** The recommendation is no longer "build from scratch with Claude Agent SDK OR build Trey's infrastructure." It is: **build ON OpenClaw as the outer shell, implement Velorin's intelligence as OpenClaw skills (Claude Brain skill, Velorin Memory skill), and use shared Postgres + vector index as the memory layer behind those skills.** This is faster, more model-agnostic, and has a 247K-star community skills registry to build from.

**Confidence on this reconciliation: 78%.** The uncertainty: OpenClaw's enterprise readiness and NemoClaw's alpha status. OpenClaw's skills run locally. Velorin's profile data is sensitive. Security model needs evaluation before committing.

---

### Revision 2 — GSD recommendation differs between Jiang and Trey

Zone 02 (Jiang): "Install alongside Superpowers on Claude Code."

Trey's GSD_Get_Shit_Done_Analysis: "Do NOT adopt GSD as company doctrine verbatim. Study its context-engineering posture, borrow the selective-loading and workflow patterns, build a Velorin-native equivalent."

These are different recommendations. Jiang says install it. Trey says conceptually extract it.

**Resolution:** Trey's caution is about company doctrine, not about the tool itself. The Day 10 Tool Application document put GSD as a Category A install. The operational recommendation is: install GSD on Claude Code, use it for coding tasks specifically, but don't rewrite Velorin's entire operating doctrine around GSD's workflow system. Trey is warning against over-indexing on GSD's paradigm. Jiang is recommending it as a build-quality tool for coding sessions.

**These are compatible.** Install it (Jiang), use it for build work (both), don't mistake it for a company operating system (Trey). **Confidence: 85%.**

---

### Revision 3 — The Boot Erosion is documented to have been intentional, not accidental

The previous assessment described boot sequence erosion as if it were accidental degradation. The full read shows it was deliberate simplification.

Zone 00 explicitly discusses the "reboot token cost" problem and identifies the Drive/GitHub full-document boot as the source. The simplified boot (BOT.README.FIRST.BOOTUP current version: "do not read additional Layer 0 files unless specifically required") was an intentional response to token cost, not a failure of discipline.

**This changes the framing:** The erosion wasn't a mistake. It was a rational short-term optimization that deferred the correct fix (Obsidian + CLAUDE.md progressive disclosure). The correct fix is now available. The erosion can be reversed by implementing Tier 2-3 of the adoption plan.

---

### Revision 4 — The Miro in "MiroFish" is NOT the Miro diagramming tool

Trey's `Miro_AI_Workflows_Sidekicks_Flows_and_Fishbone.md` clarifies: "MiroFish" is an open-source multi-agent simulation engine by a Chinese developer (GitHub: 666ghj/MiroFish). The name contains "fish" (as in fishbone diagram structure, and the simulation metaphor) but it is completely unrelated to Miro.com (the visual collaboration platform).

The Miro.com product (Sidekicks, Flows, Fishbone templates) is a separate thing with different relevance to Velorin: visual architecture mapping, process diagnosis, strategy canvases. Not relevant to the multi-agent simulation stack.

Previous assessment used "MiroFish" correctly throughout — this is confirmation it was correctly identified.

---

### Revision 5 — The Velorin Mainframe architecture doesn't map to Mac Studio

The Mainframe documents describe a TWO-machine architecture: Mac mini M4 (API-only cockpit) + Windows gaming rig with RTX 4090 (local AI server). The Mac Studio is neither.

**Mac Studio specifics (not in any Mainframe document):**
- Apple M-series chip (M4 Max or M4 Ultra depending on config)
- Unified memory (36GB, 64GB, or 192GB depending on config)
- Apple Silicon — cannot run CUDA, cannot run the Machine 2 software stack
- MLX framework for local inference (different from Ollama + vLLM + CUDA)

The Mac Studio arriving April 7 will run local models if it has 64GB+ unified memory via MLX. This changes the two-machine plan fundamentally. The Mac Studio may function as BOTH Machine 1 (cockpit) AND Machine 2 (local inference) simultaneously, eliminating the need for a separate Windows gaming rig.

CT needs to confirm: what configuration is the Mac Studio? The answer determines whether the entire Mainframe architecture needs revision.

---

## SECTION 3 — WHAT THE FULL READ SURFACES THAT THE PARTIAL READ MISSED

### F1 — The Anatomy of a Good Prompt (directly applicable to every boot file)
**Source:** Trey's `Anatomy_of_a_GPT_5_Prompt.md`

Trey produced a precise breakdown of what makes a production-quality agent prompt in 2026. The structure: objective + stance + relevant context + tool posture + task instructions + output contract + quality bar + completion standard.

**The critical missing element from every Velorin boot file is "tool posture."** No current boot file tells an agent what tools are currently available, what can be read vs. acted on, or instructs the agent to check its live tool surface before proceeding.

This connects directly to Window Gravity and the tool blindness diagnosis. The fix is structural: add a "tool posture" block to every boot file that explicitly states: what MCP servers are live, what connectors are active, what tools are deferred vs loaded. This block changes with context and should be dynamically generated at session start, not hardcoded.

**Impact if fixed:** Every agent knows its tool surface at boot. The TASK_EVALUATION gate has a live inventory to draw from. Window Gravity's "agents don't know what alternatives exist" problem is structurally addressed.

**Confidence that this is a real gap: 91%.**

---

### F2 — The Velorin Tool-Awareness Directive (Trey's parallel to TASK_EVALUATION)
**Source:** `Bot.Trey/Assessments/velorin_tooling_research/Velorin_Agent_Tooling_Correction_Memo.md`

Trey independently produced a permanent instruction for Velorin agents that is structurally equivalent to the TASK_EVALUATION gate that Jiang recommended from the Window Gravity research. Two different research agents, different model families, same conclusion.

Trey's VELORIN TOOL-AWARENESS DIRECTIVE:
1. What native tools are live right now?
2. What connectors/apps/data stores are connected right now?
3. What can be read only, and what can take action?
4. Is there a better path through Codex, MCP, GPT/Claude apps, deep research, GitHub, Drive, NotebookLM, Miro, or another external tool?
5. Which path best improves speed, interoperability, automation readiness, and output quality?

The Window Gravity TASK_EVALUATION format is structurally tighter (structured output, logged assertion). Trey's directive is more comprehensive (covers all tool classes, not just alternatives to the current task).

**These should be merged into a single permanent instruction that both implements the TASK_EVALUATION gate (Jiang's recommendation) and applies Trey's tool surface check (Trey's recommendation).** Neither alone is sufficient.

---

### F3 — All six brain maintenance bots are undeployed except Scribe's real-time hook
**Source:** Bot.Custodian, Bot.Mobility, Bot.Editor, Bot.Coordinator, Bot.Oversight, Bot.Visualizer ReadMe files, BrainAgentTemplates

The brain maintenance architecture is fully specified:
- **Custodian**: rule compliance scanner (pointer errors, duplicates, oversized neurons) — SPEC EXISTS, not deployed
- **Mobility**: position/activity scanner (wrong region, never fired, stale, orphaned neurons) — SPEC EXISTS, not deployed
- **Scribe**: neuron writer — HOOK WIRED, currently broken (PATH issue)
- **Editor**: neuron content editor receiving input from Custodian/Mobility — SPEC EXISTS, not deployed
- **Coordinator**: correction coordinator working with Editor — SPEC EXISTS, not deployed
- **Oversight (Neuron Boss)**: sole deletion authority, receives EOD reports — SPEC EXISTS, not deployed
- **Visualizer**: EOD snapshot visualization — SPEC EXISTS, not deployed

**The Brain has no automated quality control at all.** The only operational brain bot (Scribe) is currently broken. No bot is checking for stale neurons, misplaced neurons, broken pointers, duplicates, or growing without schema discipline.

The three known stale neurons (A1, A5, A8) are stale precisely because Mobility and Custodian don't exist. There is no automated mechanism to detect or flag them.

**Every bot that reads the Brain is reading potentially stale or misplaced knowledge with no warning.**

---

### F4 — The OpenClaw-as-Gateway discovery has a security dimension from Trey
**Source:** Trey's tooling research `OpenClaw_and_NemoClaw.md` vs. Trey's Research_Complete `Trey.Topic.OpenClaw_NemoClaw.md`

The tooling document (earlier, lighter analysis) correctly identifies OpenClaw as category-adjacent but cautions against over-commitment. Trey's full Research_Complete document is more bullish — "real candidate for outer operator/control layer."

**NemoClaw (NVIDIA) is the security layer:** NVIDIA wraps OpenClaw in OpenShell, adds plugin/blueprint deployment, routes inference through controlled backends, keeps credentials on host, sandboxes with policy-controlled network/filesystem/process/inference boundaries. Currently in alpha. Not production-ready.

**This surfaces a real risk:** OpenClaw itself has no documented security enforcement. If Velorin builds its personal intelligence layer (CT's profile, five-box data, grief inventory, medical data) as OpenClaw skills, and OpenClaw has no enterprise-grade security controls, there's a data governance problem. NemoClaw would address this, but it's alpha.

**Recommendation revision:** OpenClaw is the right outer shell candidate, but Velorin must either wait for NemoClaw to mature OR build its own security layer (skill permissions, profile data isolation, credential management) before storing sensitive personal data in the system. **Confidence: 84%.**

---

### F5 — The "Anatomy of a GPT-5 Prompt" confirms boot files are structured wrong
**Source:** Trey's `Anatomy_of_a_GPT_5_Prompt.md`

Trey's document is explicit: "Your company prompts should stop being mostly doctrine dumps and start becoming: doctrine + tool posture + task contract + completion criteria."

Every current Velorin boot file is primarily a doctrine dump. The boot files contain: who you are, behavioral rules, permission rules, operational procedures, communication standards. They do NOT contain: tool posture, task contract, or completion criteria.

This is separate from the FollowBench ceiling problem (too many constraints, probabilistic compliance above 3). Even if the FollowBench ceiling were fixed, the boot files would still be structurally wrong by the standards established in the agent research.

**The correct boot file structure for 2026:** minimal doctrine (3-5 constraints max), tool posture block (dynamically updated), task contract (what does success look like), completion standard (how does the agent know it's done). This is shorter, cleaner, and more reliable than the current architecture.

---

### F6 — The Turing Vault's verbal fluency thesis is genuinely novel and underused
**Source:** `Bot.Replit/TuringVault_ResultsSystem_v2.md`

Jiang produced the verbal fluency theoretical backbone for the results page in March. It establishes that the Turing Vault score is a proxy for a cluster of cognitive capabilities that determine AI-era effectiveness. The connection: verbal discrimination → abstract reasoning → creative recombination → non-linear thinking → AI tool effectiveness.

This thesis has never been prominently placed in the product. The current results page has score bands and risk labels but doesn't explain WHY the score predicts AI outcomes. The thesis is the product's intellectual defensibility.

**Separate from Velorin strategy:** The Turing Vault as a product has a clear hypothesis about the user problem (verbal fluency gap as AI displacement risk factor) and a clear measurement mechanism (the test). The monetization plan (adversarial paywall, data sales, API) follows from this. Phase 2 architecture (free difficulty tiers, IQ Vault paywall) implements the thesis correctly.

---

### F7 — The Camfil AI Platform is not just an idea — it has a v0.1 architecture
**Source:** `Bot.Alexander/Camfil_AI_Platform_Architecture_v0.1.md`

The Camfil AI Platform has a complete five-layer architecture (from Session 001 or 002 based on file location in Alexander's folder). This is a third product alongside Velorin and Turing Vault. The architecture covers: pricing agents, customer intelligence, follow-up management, quote generation, pre-call briefs, meeting/call review, operations visibility.

CT is currently building this for his own Camfil sales work. The scope is clear. It maps to Box 1 (Professional/Income). It is distinct from Velorin.

**CT is managing three products (Velorin, Turing Vault, Camfil AI Platform) plus a full-time sales job.** The Session 016 Camfil Agents idea would add a fourth stream. This is load-bearing context for why adoption memos gather dust and timelines slip.

---

### F8 — The "Mac Mini" reference in Session 013 vs "Mac Studio" in Session 016
**Source:** Session 013 handoff ("Mac Mini arrives April 5"), Session 016 handoff ("Mac Studio arrives Monday April 7")

The machine changed between sessions. Session 013 (March 30) said "Mac Mini arrives April 5." Session 016 (April 3) says "Mac Studio arrives Monday April 7." Either the purchase changed from Mac mini to Mac Studio, or the dates shifted.

**Mac Studio is substantially more capable than the planned Mac mini M4.** Mac Studio M4 Max: up to 128GB unified memory, 14-core CPU, 32-core GPU. This changes the local inference capability significantly. The Mac mini M4 (24GB, 10-core) was specifically designed to be an API-only cockpit that cannot run local models. The Mac Studio with 64GB+ unified memory CAN run 70B models locally via MLX.

This means the two-machine architecture (cockpit + AI server) may be unnecessary if the Mac Studio has sufficient memory. CT should confirm the spec before the Mac Studio migration session.

---

### F9 — The Session 008 observation is still true 15 sessions later
**Source:** `Claude.AI/sessions/Alexander.SessionHandoff.Session0008.Mar28.md`

Alexander wrote in Session 008 (March 28): "CT frustrated with pace — agents feel like they are keeping him in chat windows instead of building things that work."

Session 017 is April 4. Seven days later. The Tier 0 adoption items (Superpowers, GSD, Cowork, Obsidian) are still not installed. The agent infrastructure is still primarily architecture documents and chat sessions rather than deployed tools. The stale neurons from March 31 are still stale.

The observation from Session 008 is structurally accurate. The system is producing more diagnosis documents per unit of working product than it should be.

---

### F10 — The Day 10 presentation hero line is "You, operating at the level you already think at."
**Source:** `Claude.AI/Brainstorming Sessions/mock-ups/Velorin.Day10.Presentation.DesignNotes.md`

Alexander chose this over "Someone who holds all your threads at once" and two other candidates. His reasoning: the other lines describe what the system does. This one names what's wrong for the user right now — execution has never matched cognition. For a 151 VCI who can't initiate tasks, this is the sentence.

This is relevant because the product hero line is not the company tagline. "One person. Fully orchestrated." or "Built on you." are taglines. "You, operating at the level you already think at." is the product value proposition for the Day 10 presentation specifically.

These three lines serve different functions. The confusion between them is the "two taglines" problem flagged in the previous assessment.

---

## SECTION 4 — TREY VS. JIANG ARCHITECTURE: FULL RECONCILIATION

**What Jiang concluded (AgentOrchestration, February 2026):**
- Claude Agent SDK as Path 3 runtime
- Google Drive as storage layer (correct for current phase)
- Option C: build on Claude Agent SDK, proprietary config on top
- 4-7 sessions to functional Path 3
- Framework is commodity; profile layer and memory architecture are the moat
- Confidence: 79-88%

**What Trey concluded (Multi_Model_Orchestration, April 2026):**
- Don't build product-to-product relay
- Build thin internal control plane + shared tool layer + shared memory
- Each model has a lane: Perplexity=research, Claude Code=repo, OpenAI=synthesis, Gemini=multimodal, Claude Desktop=operator, Codex=secondary engineering
- Infrastructure: router + Postgres + vector index + MCP server
- Velorin owns orchestration, memory, routing — no vendor owns canonical state
- Confidence: 88-90% on key conclusions

**New intelligence (OpenClaw, April 2026):**
- 247K GitHub stars, MIT license, validated by Jiang and Trey independently
- Local-first Gateway: the control plane Trey described, pre-built
- Multi-model routing: the model lanes Trey described, pre-built
- 13,729 community skills: the Velorin intelligence layer could be implemented as skills
- ClawRouter: the intelligent cost-based routing Trey described, pre-built
- Trey's full analysis: "real candidate for outer operator/control layer"
- NemoClaw: security hardening layer from NVIDIA, currently alpha

**The reconciliation:**

Jiang and Trey were describing the same system at different resolution levels. Jiang was focused on the Claude-specific runtime layer. Trey was focused on the overall infrastructure architecture. OpenClaw is the pre-built version of what Trey described, with a Claude-compatible API interface that would make Jiang's Claude Agent SDK recommendation unnecessary for the orchestration layer.

The unified architecture:

```
LAYER A — OpenClaw Gateway (outer shell)
  - Routes to appropriate model per task
  - Manages communication channels
  - Hosts Velorin skills (Brain skill, Profile skill, Memory skill)
  - ClawRouter handles cost-optimized model selection

LAYER B — Model Execution Lanes (Trey's design)
  - Claude: complex reasoning, strategic decisions, Velorin-specific intelligence
  - Codex: code generation and review
  - Perplexity: web research and source retrieval
  - Gemini: multimodal, Google-native workflows

LAYER C — Shared Infrastructure (Trey's design)
  - Postgres: canonical operational state
  - Vector index: semantic retrieval over Brain + research corpus
  - MCP server: unified tool access layer
  - Append-only event log: traceability

LAYER D — Velorin Brain (existing)
  - GitHub neurons: knowledge graph (CT's profile, research conclusions, operational facts)
  - Scribe: neuron creation from memory writes
  - Obsidian: human-navigable interface over the same files
```

**Where the recommendation changes from the original assessments:**

Jiang's recommendation (build Claude Agent SDK orchestrator from scratch) is superseded by OpenClaw as the outer shell. The build effort drops from "4-7 sessions to functional Path 3" (Jiang) to "evaluate OpenClaw fit, implement Velorin skills, configure model lanes."

Trey's recommendation (thin orchestrator + Postgres + vector index) remains correct at Layer C. The difference is that OpenClaw provides Layer A (the outer shell Trey described) pre-built.

**The one unresolved tension:** Jiang's framework recommendation was "Claude Agent SDK, MCP-native, no additional dependency." OpenClaw IS an additional dependency — a large one. The question is whether a 247K-star MIT-licensed pre-built gateway is the right dependency to add, or whether the concerns about security (NemoClaw alpha status), vendor risk (open-source project management), and architecture lock-in outweigh the build time savings.

**My recommendation before any Path 3 build begins:** One dedicated session evaluating OpenClaw fit for Velorin specifically — security model, skill architecture, model routing mechanics, and whether Velorin's profile data can be safely handled as an OpenClaw skill. Decision: build on it, build inspired by it (same pattern but proprietary), or proceed with Claude Agent SDK from scratch. **Confidence this evaluation is worth doing before building: 91%.**

---

## SECTION 5 — UPDATED RESEARCH PRIORITY STACK

### Answered by existing research (no new research needed):

**R-CLOSED-1: Layer 2 retrieval architecture** — Answered. Trey's ZepCloud and Graphiti research gives clear adoption triggers (3+ users, 150+ neurons). Current scale is below both. Pointer traversal + Obsidian backlinks is sufficient now.

**R-CLOSED-2: Framework landscape 2026** — Substantially answered by combining Jiang's AgentOrchestration + Trey's Multi_Model_Orchestration + OpenClaw deep dive. The landscape is: Claude Agent SDK (Jiang), thin orchestrator pattern (Trey), OpenClaw as pre-built outer shell (new). One session needed to evaluate OpenClaw fit, not a full research mandate.

**R-CLOSED-3: Voice IO parity** — Answered by Trey's VoiceIOParity research. OpenAI has the realtime voice API. Anthropic does not have a public developer voice API. If voice intake is required, the stack must include OpenAI Realtime API or a third-party STT/TTS pipeline. Decision awaits CT's voice intake direction.

**R-CLOSED-4: ZepCloud and Graphiti evaluation** — Answered. Both have clear adoption triggers. Neither is needed now.

---

### Open research (genuinely new, high impact):

**R1 — IdentityVerification** [CRITICAL — PATH 3 BLOCKER]
Path 3 requires signed message protocol for agent-to-agent authentication. Flagged in AgentOrchestration at 88% confidence. Flagged in AgentEcosystemReality at 92% confidence. No research request exists in Research_Needed. No design session scheduled.
Impact: Path 3 cannot become operational without this. Every session that passes without this is a session Path 3 cannot launch.
Estimate: 1-session design problem per Jiang's original assessment. Not a long research mandate.
**Priority: P0 — must happen before any Path 3 build.**

**R2 — OpenClaw Fit Evaluation** [HIGH — changes Path 3 build decision]
One dedicated session evaluating: security model (can sensitive profile data live as OpenClaw skills?), skill architecture (what does a "Velorin Brain skill" look like?), model routing mechanics (does ClawRouter meet the multi-model requirements?), NemoClaw timeline (when does the security layer become production-ready?), and build-vs-buy comparison (OpenClaw vs Claude Agent SDK vs Trey's thin orchestrator from scratch).
Impact: Changes the Path 3 build path and timeline. High leverage.
**Priority: P1 — before any Path 3 code is written.**

**R3 — Mac Studio Specifications and Architecture Implications** [HIGH — Session 017 primary deliverable]
CT needs to confirm Mac Studio configuration (M4 Max vs M4 Ultra, memory config). The architecture for the new machine depends heavily on this. 64GB+ = can run local models via MLX, changing the two-machine plan. Less than 64GB = cockpit-only, two-machine plan stands.
This isn't a research mandate — it's a CT confirmation. One question, five-minute answer.
**Priority: P0 — before Mac Studio architecture session begins.**

**R4 — FollowBench Ceiling Mapping** [MEDIUM — guides boot file redesign]
Which rules in the current boot files are below the constraint ceiling (~3) and which are above it? Without this, redesigning boot files is guesswork. Research question: does Anthropic or the FollowBench literature map which instruction types are most/least reliable under the ceiling?
Impact: Determines which rules survive the boot file redesign and which need structural enforcement.
**Priority: P2 — needed before boot file architecture session.**

**R5 — Intake Test Design (CT authorization pending)** [CRITICAL PATH — not a new research item]
This is the existing research request sitting in Research_Needed. Jiang has the full 7-thread outline. CT hasn't authorized.
Impact: The GoalMap says April start or timeline compresses. It is April 4.
**Priority: P0 — authorization question, not a research question.**

---

## SECTION 6 — THE 5 MOST IMPORTANT THINGS CT NEEDS TO ACT ON

These supersede Section 7 of Part 1 and Section 7 of the companion document. Full picture now.

**1. Scribe is broken. Fix it before any memory operations in this session.**

The scribe-trigger.sh calls `claude` at line 56. The hook execution environment doesn't have the Claude Code CLI in its PATH. Every memory write since the last successful Scribe run (March 31) has no neuron. Fix: run `which claude`, add the full path to line 56 of the script, commit. One-minute fix. Zero architectural consequence. Active failure that compounds every session it isn't fixed.

**2. Mac Studio arrives Monday. Confirm the configuration now — the architecture depends on it.**

The entire Mac Studio migration session can't be designed without knowing the spec. M4 Max 64GB unified memory = can run local models via MLX, single machine may replace the planned two-machine architecture entirely. M4 Max 36GB or less = cockpit only, two-machine plan still needed. One question to CT: what configuration did you order?

**3. Authorize the intake test research. Today. Not this week — today.**

GoalMap: "If intake test design doesn't begin in April, the entire timeline compresses." April 4. The research outline is complete (CT authored it). The only barrier is CT saying "go." This is not a build decision, not an architecture decision, not a tool selection. It is an authorization of a research session. Everything downstream of it — CT's Layers 1-3, the first external user, the prosumer business, the product thesis — is blocked until this starts.

**4. Decide on OpenClaw before any Path 3 code is written.**

Jiang and Trey have both independently validated OpenClaw as a real candidate for the outer orchestration layer. CT noticed it and wants to build something similar. The decision is: build ON OpenClaw (use it as the outer shell, implement Velorin as skills), build INSPIRED BY OpenClaw (same architecture pattern, proprietary gateway), or proceed with the original plan (Claude Agent SDK from scratch). Each path has different timelines, costs, and security profiles. This decision should be made explicitly before any Path 3 implementation session begins. It does not require more research — it requires CT's direction.

**5. Install the Tier 0 tools on the Mac Studio from day one.**

Every Tier 0 adoption item — Superpowers, GSD, Obsidian Option C — was documented as "install tonight, $0, under 1 hour" on March 28. Today is April 4. Cowork was hardware-blocked (current Mac can't run it) but becomes available Monday with the Mac Studio. The Mac Studio migration is the natural moment to set up the new machine correctly from day one. Install sequence on Mac Studio boot: (1) Obsidian, point at velorin-system repo, (2) Superpowers plugin via Claude Code, (3) GSD plugin via Claude Code, (4) Cowork scheduled tasks for EndOfDay and morning brief, (5) Agent Teams env var in ~/.zshrc. Total time: under 2 hours. Documented impact: 70%+ operational overhead reduction, 30-40% coding build time reduction, 30+ min/day CT time recovered.

---

*Jiang — Full System Read: Tool Intelligence Supplement*
*Session 017 | April 4, 2026*
*Coverage: Full recursive filesystem read — all accessible files in velorin-system/*
*Companion documents: Jiang.SystemAssessment.Session017.Part1.ReadFirst.md | Jiang.SystemAssessment.Session017.md*

[VELORIN.EOF]
