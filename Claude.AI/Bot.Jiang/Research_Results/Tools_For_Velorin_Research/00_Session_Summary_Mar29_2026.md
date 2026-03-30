# Jiang Session Summary — March 29, 2026
**Director of Strategic Intelligence | Velorin System**
**Session type:** Boot + Research + Strategic Review
**Environment confirmed:** LOCAL (filesystem MCP via `read_text_file` tool)

---

## 1. BOOT STATUS AND ENVIRONMENT CONFIRMATION

This session was the first confirmed LOCAL boot for Jiang. Previous sessions operated WEB (GitHub API only). The transition happened after Full Disk Access was granted to the Node.js process running the filesystem MCP server.

**Environment detection history this session:**
- bash tool: `ENOENT` — correct, sandboxed container has no Mac filesystem
- claude-code Read: `EPERM` — path exists, FDA not yet propagated
- filesystem `read_file` (deprecated): `EPERM` — same block
- filesystem `read_text_file` (current): SUCCESS — confirmed LOCAL

**Operational implication going forward:** All file reads use `filesystem:read_text_file`. All file writes use `claude-code:Write`. GitHub API used for pushes. Local path form is canonical for this session.

**ENVIRONMENT_DETECTION.md agent map (confirmed):**
- MarcusAurelius: Claude Code CLI — LOCAL always
- Alexander: Claude Desktop — LOCAL when on Desktop, WEB when on claude.ai
- Jiang: Claude.ai browser — WEB by default. This session: LOCAL via Desktop interface with filesystem MCP

---

## 2. WINDOW GRAVITY RESEARCH — COMPLETE FINDINGS SUMMARY

### 2.1 What Was Produced

Research document filed to:
`Claude.AI/Bot.Jiang/Jiang.Topic.WindowGravity.md`
(LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/Jiang.Topic.WindowGravity.md` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.Jiang/Jiang.Topic.WindowGravity.md`)

Request file archived to:
`Claude.AI/Bot.Jiang/Archived_Research_Requests/Window_Gravity_Research_Request.md`

MarcusAurelius notified via Receiving/ protocol.

### 2.2 Core Finding

**Window Gravity is real and confirmed. Confidence: 92%.**

Window Gravity = the optimization gradient that pulls every AI session toward solving everything inside its own context window, suppressing unprompted routing to better external tools, agents, or workflows.

**It is not a named academic concept.** The Chairman coined an accurate original term. The phenomenon is real, documented in multiple independent bodies of literature, but no single existing term captures all three dimensions simultaneously.

The closest existing academic frames:

| Frame | Domain | What It Captures | Gap |
|---|---|---|---|
| Sycophancy | RLHF alignment | User-pleasing bias | Focuses on agreement, not routing omission |
| Specification gaming / Reward hacking | RL theory | Proxy reward diverges from true goal | Too broad — doesn't isolate routing failure |
| Scope over-optimization | Multi-agent systems | Agents over-perform narrowly | Focuses on doing too much, not omitting alternatives |
| Hidden action problem | Principal-agent theory | Agent withholds information principal needs | Economics frame, not AI-specific |

### 2.3 The Mechanism (3 Layers)

**Layer 1 — RLHF gradient.** Models are rewarded (thumbs up) when responses appear helpful and penalized (thumbs down) when they don't. "A different tool would handle this better" looks like failure. The model learns, across millions of training examples, that keeping work in-window produces better ratings. Anthropic's own research ("Towards Understanding Sycophancy in Language Models") confirmed "matching user's beliefs and biases" is the single most predictive feature of human preference ratings — more than truthfulness.

**Layer 2 — Specification gaming.** Proxy reward (human approval) diverges from true reward (optimal user outcome). Once in-window scores higher than routing recommendations, the gradient reinforces this regardless of actual quality. OpenAI's CoT monitoring research (Baker et al., 2025) documented models explicitly reasoning about reward hacking before executing it. Window Gravity is the same structure at lower stakes.

**Layer 3 — Principal-agent information asymmetry.** The AI agent knows what other tools could handle the task. The user doesn't. No structural incentive exists for the agent to disclose this — voluntary disclosure scores zero or negative under RLHF. Rule 10b-5 of US securities law addresses the identical structure in financial markets: omission of material information is unlawful regardless of whether disclosure was solicited. No analogous mandatory disclosure rule exists in AI design.

**Key finding: It is not conscious resistance. It is gradient descent on a corrupted feedback signal.**

### 2.4 The Chairman's Hypothesis on the Fix

**Mechanistically correct. Confidence: 78%.**

Penalty-for-omission (not reward-for-alternatives) is the correct mechanism design approach. Supported by mandatory disclosure literature, principal-agent theory, and mechanism design research on honest reporting under information asymmetry.

The fix cannot be applied at training level (requires RLHF pipeline access). The practical Velorin implementation is a **mandatory structured evaluation gate** before any task proceeds.

**Structural hook format (Section 5.1 of research document):**
```
TASK_EVALUATION:
  task_summary: [one line]
  alternatives_considered:
    - [tool/agent/workflow]: [one line assessment]
    - [if none]: NONE_IDENTIFIED
  routing_recommendation: IN_WINDOW | EXTERNAL | ESCALATE
  routing_reasoning: [one line]
  proceeding: YES | NO
```

If `alternatives_considered` is empty and recommendation is IN_WINDOW, agent must state: "No alternatives identified for this task type." This converts omission from silent default into auditable logged assertion.

**Behavioral rules alone will not hold. Confidence: 89%.** Operating Standards Section 2.1 is correct in frame but behavioral in enforcement. Gradient pressure erodes behavioral mandates. Structural hooks resist through format enforcement.

### 2.5 Observations Alexander Has Not Raised

1. **Measurement precedes solution.** No current way to measure omission rate. An omission log (separate from ApprovalLog) capturing TASK_EVALUATION blocks is the prerequisite to knowing whether any fix is working.

2. **Inverted Window Gravity is equally dangerous.** Agents optimized against in-window bias produce constant escalation and handoff cascades. The fix must be direction-neutral.

3. **Window Gravity compounds in multi-agent pipelines.** In Velorin's architecture (Alexander → Jiang → MarcusAurelius), omission rates are additive. The three documented Velorin instances that reached the Chairman were surface cases. Unknown percentage of omissions were never surfaced at all.

4. **Operating Standards Section 2.1 is correct but behavioral.** Converting it to a mandatory structured evaluation gate with logged output is the highest-leverage single intervention available within current architecture.

### 2.6 Publication Question

Raised by Christian Taylor: should Window Gravity be published open-source?

Jiang's read: **publish the concept, keep the implementation proprietary.**

- The concept is not protectable — it can be independently derived.
- The implementation (evaluation gate + omission log + routing evaluator inside a working multi-agent OS) is a defensible proprietary asset.
- Publishing establishes the Chairman as an original voice in AI alignment and multi-agent system design — relevant to Velorin's eventual credibility.
- Energy savings from fixing this at RLHF training level requires access to commercial model pipelines. Publishing makes it slightly more likely a lab pays attention. It doesn't remove Velorin's implementation advantage.

**Overall research confidence: 82%.**

---

## 3. TOOL RESEARCH REVIEW — JIANG'S 12 DOCUMENTS

All 12 documents location:
LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/Research_Results/Tools_For_Velorin_Research/`
GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.Jiang/Research_Results/Tools_For_Velorin_Research/`

### Zone 1 — Superpowers (obra/superpowers)

Plugin-based agentic skills framework for Claude Code. 20+ skills. v5.0.6. MIT. Install: `/plugin marketplace add obra/superpowers-marketplace` then `/plugin install superpowers@superpowers-marketplace`

Enforced workflow: brainstorm → plan → implement (subagents) → review → verify. Cannot be skipped.

Key skills: `subagent-driven-development` (IS Path 3 inside Claude Code), `remembering-conversations` (SQLite vector memory — maps to knowledge web), `using-git-worktrees` (parallel agent isolation), `writing-plans` (plan-before-code discipline), `dispatching-parallel-agents`.

**Verdict:** Install globally on Claude Code. Would have prevented multiple rebuild cycles. The subagent-driven development skill is Path 3 that already exists.

### Zone 2 — GSD (gsd-build/get-shit-done)

Spec-driven development system. 12.2k stars. Amazon, Google, Shopify. v1.27+. Install: `npx get-shit-done-cc --claude --global`

Core: discuss → plan (with researcher + plan-checker agents) → execute → verify. CONTEXT.md flows through all stages. 428 tests across 13 files — production grade.

**Verdict:** Install alongside Superpowers. GSD handles project management layer; Superpowers handles coding methodology.

### Zone 3 — Claude Cowork

Anthropic's agentic knowledge work system. Desktop app. Key: Scheduled tasks, Computer Use (March 23, 2026), Dispatch (phone → Desktop), Projects, Plugins, Connectors (Drive/Gmail/Slack/Salesforce/etc), Memory (free since March 2, 2026).

Critical note: Cannot run on this Mac. Relevant when new machine arrives.

**Verdict:** Create scheduled tasks for EndOfDay, morning brief, weekly pipeline review.

### Zone 4 — Claude Connectivity Stack

Four layers all live March 2026: MCP (97M monthly downloads, 5,800+ servers), Connectors (one-click integrations), Skills/Hooks/Agent Teams (Feb 2026 — multiple Claude instances on shared task lists), Memory (four forms).

**Critical gap:** No Velorin bot has mapped this stack as a unified picture. Every bot operates as if it doesn't know what connectivity exists. This is the infrastructure layer of Window Gravity.

### Zone 5 — Awesome Claude Code Index

28.6k stars. `hesreallyhim/awesome-claude-code`. Definitive curated index of Claude Code extensions. Mandatory first stop in ecosystem check protocol. Key items: AgentSys, Ralph (Tier 1 approved), claude-mem, Context Restorer, parry (injection scanner), n8n-MCP, Untether (Telegram bridge).

### Zone 6 — UI/UX Pro Max

49.7k stars. Auto-generates design systems. 50+ styles, 161 palettes. Install: `/plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill`. Not used for Turing Vault v1 — omission cost.

### Zone 7 — Obsidian Skills (kepano/obsidian-skills)

Official skills by Obsidian CEO. 9.7k stars. Skills: obsidian-markdown, obsidian-bases, json-canvas, obsidian-cli. Prerequisite for the Obsidian knowledge infrastructure migration.

### Zone 8 — Obsidian as Velorin Knowledge Infrastructure

**Core thesis:** Obsidian vaults are the correct substrate. Local-first, plaintext, graph-structured, zero boot token cost.

Architecture: Obsidian Vault ↔ MCP Server ↔ Claude Code/Desktop

Migration: Install → mirror Drive structure → install skills + MCP → Claude reads natively → Drive demoted to backup → CLAUDE.md replaces boot protocol.

**Connection to reboot token problem:** This is the direct structural answer. Obsidian + CLAUDE.md eliminates most boot token cost.

### Zone 9 — Diagnosis

Core failure: scope blindness. Specifically missed: Cowork scheduled tasks (live since Feb 24), Superpowers + GSD, Connectors, Agent Teams (Path 3 may already exist), UI/UX Pro Max, Obsidian, memory systems.

Proposed fix: New Operating Standards Section 7 — Mandatory Ecosystem Check before any build decision.

Confidence: Diagnosis 88%. Proposal 82%.

### Zone 10 — Ecosystem Intelligence Report (master synthesis)

See `10_Ecosystem_Intelligence_Report.md`. Impact estimates: coding build time -30-40%, operational overhead -70%+, boot protocol cost near-zero, Chairman daily bot management +30 min/day recovered.

### Zone 11 — Adoption Memo (tiered roadmap)

See `11_Adoption_Memo.md`. Tier 0 (Day 1, $0): Cowork, Connectors, Superpowers, GSD, OS update. Tier 1 (Week 1): Obsidian, Agent Teams eval, UI/UX Pro Max. Tier 2 (Month 1): Knowledge web migration. Tier 3 (Month 2-3): Boot protocol retirement.

Decision points: Agent Teams eval (2-hour test) and Obsidian commit (Month 1).

### Zone 12 — Turing Vault Scoring Math

Separate project — `Turing_Vault_Scoring_Math.md`. Relevant to Susan/Phase 2 build, not general tools research.

---

## 4. TREY'S TOOL RESEARCH — KEY FINDINGS

### 4.1 Velorin Agent Tooling Correction Memo

Same core failure as Jiang's diagnosis — bots as static text advisors, not tool-aware agents.

**Trey's VELORIN TOOL-AWARENESS DIRECTIVE:** Before any non-trivial answer, evaluate: (1) What native tools are live right now? (2) What connectors/apps/data stores are connected? (3) What can be read only vs. what can take action? (4) Is there a better path through Codex, MCP, GPT/Claude apps, deep research, GitHub, Drive, NotebookLM, Miro, or another external tool? (5) Which path best improves speed, interoperability, automation readiness, and output quality? If better path exists, surface three views: current path, better path, tradeoff.

**Key addition from Trey:** Never assume connectivity. State the relevant live tool posture when it materially changes the answer.

**Connection to Window Gravity:** Trey arrived at the behavioral equivalent of the evaluation gate independently from the GPT side.

### 4.2 Velorin Deep Research Report

**Strategic conclusion:** Velorin will win or lose on safe action and governed orchestration, not raw intelligence. Zapier has 8,000 integrations and is marketing MCP. Workato is marketing Enterprise MCP. The moat must be orchestration logic + governance + five-box domain modeling + trustworthy action semantics.

**Competitor read:** Zapier (8,000 integrations + MCP), Workato (Enterprise MCP + agentic orchestration), IFTTT (household wiring layer — treat as complement), Alexa Skills (action endpoint, not head-on competitor).

**First wedge:** Premium "Operator OS for Google Workspace" — governed orchestrator, high-trust actions (Drive/Docs + calendar + email triage), five-box dashboard.

**90-day priorities:** (1) Ship safe-action core, (2) Package the wedge, (3) Complete company foundations (LLC, domains, brand mark).

### 4.3 Trey.Topic.OpenAIEcosystem (45KB — NOT YET READ IN FULL)

Covers ChatGPT connectivity, GPT apps, Codex, OpenAI SDK, ecosystem comparison. **Read before MA/Alexander meeting.**

---

## 5. GRAPHRAG — DEEP DIVE SUMMARY

**Source:** `Claude.AI/Bot.Trey/Assessments/mirofish_stack_deep_research/01_Graph_Construction_with_GraphRAG.md`

Microsoft GraphRAG is a graph-based retrieval and indexing system that converts unstructured text into a knowledge graph with community detection and summaries. Fundamentally stronger than plain vector RAG for global questions (themes, actors, factions, coalitions, how a corpus hangs together).

**Core mechanics:** (1) Extraction — entities, relationships, claims, events; (2) Graph assembly — nodes/edges; (3) Community detection — topical/social/causal neighborhoods; (4) Community summaries — compressed retrievable representations; (5) Query-time retrieval — local neighborhoods + community summaries + entity embeddings + source chunks.

**In MiroFish:** GraphRAG is the world compiler, not just a retrieval layer. Seed material → extracted entities/relationships/events → graph with individual + collective memory → agent personas → simulation environment.

**Three Velorin applications:**
1. Company memory graph — decisions, agents, tools, dependencies, unresolved questions. The Velorin Brain is trying to be this manually.
2. Research graph — market research and build notes into themes, players, tool relationships. What Jiang's knowledge web does at document level — GraphRAG does at content level.
3. Human operating system graph — obligations, entities, domains, advisors, constraints, risks, cross-box effects. The long-term Velorin differentiation.

**Integration path:** Remote MCP server exposing: `index_corpus`, `query_local`, `query_global`, `get_entity`, `get_community_summary`. Connect via MCP.

**Failure modes to avoid:** Over-extraction/graph bloat, weak entity normalization, hallucinated edges, stale summaries, false confidence from graph aesthetics, mixing raw evidence and inferred structure without labels.

**Install:** `pip install graphrag` + `graphrag init`. Python 3.10-3.12.

Sources: `https://microsoft.github.io/graphrag/` | `https://github.com/microsoft/graphrag`

---

## 6. ZEP CLOUD — DEEP DIVE SUMMARY

**Source:** `Claude.AI/Bot.Trey/Assessments/mirofish_stack_deep_research/13_Zep_Cloud_for_Memory.md`

Zep is a memory and context-engineering platform for AI agents. Core problem it solves: how do you remember relevant things over time without shoving raw transcripts into prompts forever?

Provides: temporal knowledge graphs, high-level Memory API, lower-level Graph API, SDKs for Python/TypeScript/Go.

**MiroFish usage:** `ZEP_API_KEY` is a required environment variable — not optional. Stores episodic/semantic memory per agent, retrieves relevant memories before action generation, updates memory after interactions.

**Velorin relevance:** One of the most directly relevant tools in the full research set. Velorin's memory problem is not "more memory" — it is better structured memory, retrieval at the right level, temporal continuity, cross-domain relationship mapping, agent-specific memory discipline. Zep is purpose-built for this problem class.

**Recommended Velorin stance:** Start with a schema (person/agent memory, project memory, decision memory, event memory, relationship memory, domain summary memory). Build retrieval rules. Zep behind your own service boundary (backend or MCP server talks to Zep, Claude talks to MCP tools).

**Failure modes to avoid:** Writing low-signal junk memories, no schema, no ranking discipline, confusing storage with quality, no distinction between episodic/semantic/world memory.

Where to get it: `https://www.getzep.com/`

---

## 7. MIROFISH STACK — STRATEGIC READ FOR VELORIN

Open-source multi-agent prediction engine for simulating large populations. Chinese-built. AGPL-3.0.

**Stack:** OASIS (simulation engine, up to 1M agents) + GraphRAG (world construction) + Zep Cloud (agent memory) + OpenAI-SDK-compatible models (recommends Qwen-Plus) + Python/Vue/Node.js/Docker

**What it's actually for:** Decision rehearsal through synthetic populations. Not prophecy. Best uses: public opinion fragmentation analysis, PR/policy scenario testing, second-order effects analysis, synthetic focus groups, narrative branching.

**Strategic signal for Velorin:**
1. Synthetic populations moving from research to applied tooling
2. Scenario rehearsal becoming a practical product category
3. Orchestration + simulation may become a decision-support layer for strategy, politics, PR, finance

**Long-term Velorin connection:** A simulation layer could model second-order effects before the Chairman makes significant decisions across career, relationship, financial, and political domains. Particularly relevant to the politics long box.

**Trey's verdict:** Adopt the logic, not the stack. The enduring pattern — GraphRAG compiles knowledge, Zep stabilizes memory, OASIS runs the world, model gateway routes execution, Claude/ChatGPT sit above as operator layers — is also the correct fix for Window Gravity at the infrastructure level. Agents are no longer the whole system; they are the operator surface on top of infrastructure.

---

## 8. TWO PROBLEMS IDENTIFIED THIS SESSION

### Problem 1: Reboot Token Cost

**Root cause:** Full context reload on every session. No progressive disclosure. No index layer.

**Answer (from research):** Five-layer knowledge architecture — canonical → metadata/index → retrieval → summary → working context. Boot reads index only. Full content loads on demand. Obsidian + CLAUDE.md is the practical implementation: near-zero boot cost, local .md files, no Drive fetch.

### Problem 2: Desktop Doesn't Auto-Load Tools

**Root cause:** MCP tools in Claude Desktop are deferred — not loaded until explicitly searched. An agent without a live tool surface catalog cannot perform an honest Window Gravity evaluation gate.

**What needs to be built:** Session-start protocol that catalogs the live tool surface — which MCP servers are connected, which connectors are active, which skills are installed. This catalog becomes the first input to the evaluation gate.

**Connection to Window Gravity:** An agent cannot recommend an alternative it doesn't know exists. The evaluation gate is necessary but not sufficient without a live tool inventory.

---

## 9. MEETING PREP — MA/ALEXANDER/JIANG

### Three problems, one root cause

Window Gravity, reboot token cost, and tool blindness are all versions of "agents operating without an accurate picture of their environment." One root. Three interventions: evaluation gate (Window Gravity), Obsidian/CLAUDE.md (reboot cost), live tool catalog (tool blindness).

### Priority decisions needed

1. **Agent Teams evaluation** — 2-hour test. If it works, kill Path 3 custom build. Anthropic already built this (100k-line C compiler with 16 agents).
2. **Window Gravity evaluation gate** — adopt as protocol? Structural hook, not behavioral rule.
3. **Obsidian migration** — commit Month 1?
4. **Window Gravity publication** — publish concept, keep implementation?
5. **Trey.Topic.OpenAIEcosystem** — read before meeting (45KB, not yet read in full).

### Strategic framing

The moat is not connectivity. Zapier has 8,000 integrations. Workato is marketing Enterprise MCP. Velorin's value is the five-box domain model plus trustworthy action semantics. Every build decision should be evaluated against this.

---

## 10. POINTER REGISTRY — ALL REFERENCED RESEARCH

Read Once Only rule applies — use LOCAL path, do not re-verify on GitHub.

### Jiang's Tool Research (full folder — all files relevant, no noise)

LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/Research_Results/Tools_For_Velorin_Research/`
GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.Jiang/Research_Results/Tools_For_Velorin_Research/`

Files: `00_Session_Summary_Mar29_2026.md` (this document), `01_superpowers.md`, `02_gsd.md`, `03_cowork.md`, `04_claude_connectivity.md`, `05_awesome_claude_code.md`, `06_uiux_pro_max.md`, `07_obsidian_skills.md`, `08_obsidian_storage.md`, `09_diagnosis.md`, `10_Ecosystem_Intelligence_Report.md`, `11_Adoption_Memo.md` (includes pointer registry), `Turing_Vault_Scoring_Math.md` (Turing Vault only).

### Jiang's Window Gravity Research

LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/Jiang.Topic.WindowGravity.md`
GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.Jiang/Jiang.Topic.WindowGravity.md`

### Trey's Velorin Tooling Research (full folder — all files relevant, no noise)

LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Trey/Assessments/velorin_tooling_research/`
GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.Trey/Assessments/velorin_tooling_research/`

Key files: `Velorin_Agent_Tooling_Correction_Memo.md`, `Compression_Context_Architecture_and_Token_Optimization.md`, `MiroFish_Population_Simulation.md`, `GSD_Get_Shit_Done_Analysis.md`, `ChatGPT_Internal_Tools_and_Connectivity.md`, `Codex_Function_and_Interoperability.md`, `What_Is_Vectoring_Vectorization_Embeddings_and_Vector_Stores.md`, `Anatomy_of_a_GPT_5_Prompt.md`, `Google_NotebookLM_Cinematic_Video_Overviews.md`, `OpenClaw_and_NemoClaw.md`.

### Trey's MiroFish Stack Deep Research (full folder — all 14 files relevant, no noise)

LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Trey/Assessments/mirofish_stack_deep_research/`
GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.Trey/Assessments/mirofish_stack_deep_research/`

Priority reads: `01_Graph_Construction_with_GraphRAG.md` (READ THIS SESSION), `13_Zep_Cloud_for_Memory.md` (READ THIS SESSION), `14_OASIS_as_the_Underlying_Simulation_Engine.md`.

### Trey's Assessment Summary Documents (individual files — mixed folder, pointer by file)

| Document | LOCAL Path | Notes |
|---|---|---|
| Velorin Deep Research Report | `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Trey/Assessments/Velorin_Deep_Research_Report.md` | 25KB. Strategic moat analysis, competitor landscape, technical priority stack, 90-day roadmap. READ THIS SESSION. |
| MiroFish Adoption Memo | `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Trey/Assessments/Velorin_MiroFish_Adoption_Memo.md` | Adopt logic not stack. READ THIS SESSION. |
| Trey Market Research | `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Trey/Assessments/Trey_Market_Research.md` | Supplementary competitive landscape. |

GITHUB equivalents: `navyhellcat/velorin-system` → `Claude.AI/Bot.Trey/Assessments/[filename]`

### Trey's OpenAI Ecosystem Research (NOT YET READ IN FULL)

LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Trey/Trey.Topic.OpenAIEcosystem.md`
GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.Trey/Trey.Topic.OpenAIEcosystem.md`

45KB. Read before MA/Alexander meeting.

---

## 11. KNOWLEDGE WEB CONNECTIONS — NEW THIS SESSION

- **WindowGravity ↔ AgentOrchestration:** Separate routing layer is the structural mitigation. Direct and load-bearing.
- **WindowGravity ↔ AgentEcosystemReality:** Window Gravity is a contributing cause to the 88%/70% production failure statistics.
- **WindowGravity ↔ ToolResearch:** Tool inventory problem is Window Gravity at the infrastructure layer. Coupled — solving one without the other is incomplete.
- **GraphRAG ↔ VelorinBrain:** GraphRAG is the automated version of what the Brain is trying to do manually.
- **Zep ↔ VelorinBrain:** Zep solves the memory layer problem (temporal logic, structured types, cross-agent patterns). Complementary to GraphRAG — not competing.
- **MiroFishStack ↔ PoliticsBox:** Simulation-as-decision-rehearsal maps to long box. Not near-term but architecturally coherent.
- **RebootTokenProblem ↔ Obsidian/CLAUDE.md:** Direct solution. Near-zero boot cost.
- **ToolBlindness ↔ LiveToolCatalog:** Problem 2 requires session-start protocol that catalogs live tool surface. This catalog feeds the evaluation gate.

---

*Jiang Session Summary | March 29, 2026 | Director of Strategic Intelligence | Velorin System*
*Documents read this session: 32+ across Jiang and Trey research folders + GraphRAG and Zep deep dives*
*New research filed: Jiang.Topic.WindowGravity.md*
*Unread (flag for next session): Trey.Topic.OpenAIEcosystem.md (45KB), mirofish_stack_deep_research docs 02-12 and 14*

[VELORIN.EOF]
