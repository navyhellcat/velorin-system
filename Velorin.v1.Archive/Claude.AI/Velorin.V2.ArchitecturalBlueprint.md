# Velorin V2 — Complete Architectural Blueprint
**Author:** Jiang2 (full-context synthesis, terminal session)
**Date:** 2026-04-05 | Session 022
**Status:** AUTHORITATIVE — this supersedes scattered session notes and working docs

---

## TABLE OF CONTENTS

- [Section 0 — Folder Architecture V2](#section-0)
  - [0.1 New Structure](#section-0-1)
  - [0.2 Migration Map](#section-0-2)
- [Section 1 — What Velorin Is (V2 Definition)](#section-1)
- [Section 2 — Brain Architecture V2](#section-2)
  - [2.1 Neuron Format](#section-2-1)
  - [2.2 Graph Structure](#section-2-2)
  - [2.3 PPR Retrieval](#section-2-3)
  - [2.4 Qdrant Integration](#section-2-4)
  - [2.5 Pruning Dependency](#section-2-5)
- [Section 3 — Agent Ecosystem V2](#section-3)
  - [3.1 Claude Agents](#section-3-1)
  - [3.2 Gemini Agents](#section-3-2)
  - [3.3 Automated Agents](#section-3-3)
  - [3.4 Retired Agents](#section-3-4)
- [Section 4 — Tech Stack V2](#section-4)
  - [4.1 MCP Servers](#section-4-1)
  - [4.2 Model Selection](#section-4-2)
  - [4.3 Context Strategy](#section-4-3)
  - [4.4 Local Inference](#section-4-4)
- [Section 5 — Data Flows and Protocols V2](#section-5)
  - [5.1 Memory Creation](#section-5-1)
  - [5.2 Research Pipeline](#section-5-2)
  - [5.3 Math Pipeline](#section-5-3)
  - [5.4 Session Handoff](#section-5-4)
  - [5.5 Compaction Protocol](#section-5-5)
  - [5.6 Task Routing](#section-5-6)
  - [5.7 GitHub as Source of Truth](#section-5-7)
- [Section 6 — Build Sequence](#section-6)
- [Section 7 — Hardware Architecture V2](#section-7)
- [Section 8 — Open Problems and Dependencies](#section-8)
- [Section 9 — What V1 Taught Us](#section-9)

---

## SECTION 0 — FOLDER ARCHITECTURE V2 {#section-0}

### 0.1 New Structure {#section-0-1}

The current `Claude.AI/` root is wrong. It encodes a platform dependency at the architectural level. Gemini reads this repo. Local models will read this repo. Claude is an interface agent, not the system owner. The folder structure must reflect that.

V2 top-level structure — every folder is platform-agnostic:

```
velorin-system/
├── brain/                    # The neural file graph. Velorin's mind. NOT Claude's.
│   ├── _index.md             # Entry point for all agents from all platforms
│   ├── _BRAIN_SCHEMA.md      # Schema, pointer rating rules, generality test
│   ├── Operations/
│   ├── Connectivity/
│   ├── Agents/
│   ├── Principles/
│   ├── Company/              # NEW — company knowledge as neurons (v1 had none)
│   └── Intelligence/         # NEW — Jiang research conclusions as neurons
│
├── agents/                   # All agents, grouped by platform
│   ├── claude/               # Claude-based agents
│   │   ├── jiang/            # Director of Strategic Intelligence
│   │   ├── marcus/           # Infrastructure and operations manager
│   │   ├── scribe/           # Neuron creation and memory maintenance
│   │   ├── theresa/          # HR — agent lifecycle manager
│   │   └── maintenance/      # Custodian, Mobility, Editor, Coordinator, Oversight, Visualizer specs
│   ├── gemini/               # Gemini-based agents
│   │   ├── trey/             # External research — Deep Research Gem
│   │   └── erdos/            # Mathematical proofs — Deep Think Gem
│   └── subagents/            # All Level 1 subagents (Terry and future)
│
├── knowledge/                # Durable company knowledge. Slow-changing. High trust.
│   ├── vocabulary.md         # Velorin.Vocabulary.md — living term reference
│   ├── company/
│   │   ├── dna.md            # What Velorin is and why it exists
│   │   ├── operating-standards.md
│   │   ├── end-of-day-protocol.md
│   │   └── tools-and-urls.md
│   ├── profiles/
│   │   ├── topline-profile.md
│   │   └── interaction-profile.md
│   └── chairman-confidential/  # Memory theory, sensitive design docs
│
├── architecture/             # System design docs. The "why" behind structure.
│   ├── gps-layer-system.md
│   ├── skill-registry-design.md
│   ├── core-principles.md
│   └── hardware/             # Mainframe specs, machine configs
│
├── protocols/                # Shared procedures used by multiple agents
│   ├── steel-man.md
│   ├── vocabulary-bot-design.md
│   ├── shipping-receiving.md
│   └── session-close.md
│
├── infrastructure/           # Operational machinery. Programs, not agents.
│   ├── hooks/                # SessionStart, PreCompact, PostToolUse scripts
│   ├── mcp/                  # MCP server configs and gatekeeper
│   ├── skills/               # Skill registry (pointer wrappers)
│   ├── registries/           # GLOBAL_TIMER_REGISTRY, GLOBAL_SPAWNER_REGISTRY, BOT_REGISTRY
│   └── mailboxes/            # Shipping/ and Receiving/
│
├── research/                 # Cross-agent research outputs. Not owned by one agent.
│   ├── complete/             # Finished research (currently scattered in Bot.Trey, Bot.Jiang)
│   ├── brainstorming/        # Session design docs, day10 goal map, company alignment
│   └── syntheses/            # Session synthesis documents
│
├── math/                     # Erdős domain. Mathematical proofs and derivations.
│   ├── research-needed/      # Problems queued for Erdős (Trey drops specs here)
│   ├── complete/             # Solved algorithms and proofs
│   └── archived/
│
├── products/                 # Things Velorin is building or operating
│   ├── turing-vault/         # All Turing Vault documentation
│   └── camfil-tools/         # Box 1 AI tools for Camfil sales work
│
├── sessions/                 # Session records and logs
│   ├── handoffs/             # All session handoff files
│   ├── daily-logs/           # Agent daily logs
│   └── compaction-states/    # TEAM_STATE.md and recovery files
│
└── system/                   # Claude Code integration layer
    ├── CLAUDE.md             # Minimal GPS pointer — name → navigate to agents/claude/[name]/
    ├── ENVIRONMENT_DETECTION.md
    └── level-rules/          # Level1_SubAgent_Baseline, Level2-4 general rules
```

**Rules for this structure:**

- `brain/` contains ONLY the neural file graph. No agent instructions. No session files. No research docs.
- `agents/` contains ONLY agent-specific operational files (boot instructions, handoffs, research queues). No company knowledge.
- `knowledge/` changes rarely. Everything in it has been deliberately placed there. Nothing ephemeral.
- `architecture/` is for structural design decisions. When you are specifying how the system works, not running it.
- `protocols/` is for procedures that multiple agents follow. If only one agent follows it, it belongs in that agent's folder.
- `infrastructure/` runs programs. No AI judgment here. Everything in this folder is deterministic code or config.
- `research/` is for knowledge that should be accessible to all agents, not just the one that produced it.
- `math/` is Erdős's domain exclusively. No other agent modifies files here except to queue problems.
- `products/` is for things being built. When something ships, it gets its own home.
- `sessions/` is the audit trail. Never deleted. Never edited after writing.
- `system/` is the minimal Claude Code integration layer. CLAUDE.md here is the GPS pointer only.

---

### 0.2 Migration Map {#section-0-2}

Every path in the current repo. Three options: MIGRATE (move, keep content), REWRITE (move and update content), RETIRE (archive or delete with reason).

| Current Path | Action | New Path | Notes |
|---|---|---|---|
| `Claude.AI/Velorin_Brain/` | MIGRATE | `brain/` | Brain moves to repo root — no platform prefix |
| `Claude.AI/Velorin_Brain_old/` | RETIRE | — | Superseded by current Brain. Archive commit, then delete |
| `Claude.AI/Bot.Jiang/` | MIGRATE | `agents/claude/jiang/` | |
| `Claude.AI/Bot.Jiang/Jiang.ReadMe.First.md` | REWRITE | `agents/claude/jiang/ReadMe.First.md` | Update for GPS v2 structure, v2 agent roles |
| `Claude.AI/Bot.Jiang/Jiang.KnowledgeIndex.md` | REWRITE | `agents/claude/jiang/KnowledgeIndex.md` | Update all doc paths to v2 locations |
| `Claude.AI/Bot.Jiang/Jiang.ResearchLog.md` | MIGRATE | `agents/claude/jiang/ResearchLog.md` | |
| `Claude.AI/Bot.Jiang/Jiang.Corner.md` | MIGRATE | `sessions/daily-logs/jiang-corner.md` | Daily logs belong in sessions/ |
| `Claude.AI/Bot.Jiang/Research_Complete/` | MIGRATE | `research/complete/` | Research outputs are cross-agent knowledge |
| `Claude.AI/Bot.Jiang/Research_Needed/` | MIGRATE | `agents/claude/jiang/research-needed/` | Research queues stay agent-specific |
| `Claude.AI/Bot.Jiang/Archived_Research_Requests/` | MIGRATE | `agents/claude/jiang/archived-requests/` | |
| `Claude.AI/Bot.Jiang/Research_Results/` | MIGRATE | `research/complete/jiang-research-results/` | Cross-agent knowledge |
| `Claude.AI/Bot.Jiang/Working.Docs/` | MIGRATE | `agents/claude/jiang/working-docs/` | |
| `Claude.AI/Bot.Jiang/Protocols/` | MIGRATE | `protocols/` | Protocols are system-level, not agent-specific |
| `Claude.AI/Bot.Jiang/Context.1M.Foundation/` | MIGRATE | `agents/claude/jiang/context-foundation/` | |
| `Claude.AI/Bot.Jiang/Task_Instructions/` | MIGRATE | `agents/claude/jiang/task-instructions/` | |
| `Claude.AI/Bot.Jiang/MCP_Desktop_Code/` | RETIRE | — | Historical MCP build logs, no longer relevant |
| `Claude.AI/Bot.Jiang/Research.BrainAnalysis.Mar30/` | MIGRATE | `research/complete/brain-analysis-mar30/` | |
| `Claude.AI/Bot.Jiang/Session021.NewIdeas.md` | MIGRATE | `research/syntheses/session021-new-ideas.md` | |
| `Claude.AI/Bot.Jiang/Session021.Discovery.MCP.md` | MIGRATE | `research/complete/mcp-ecosystem-discovery.md` | |
| `Claude.AI/Bot.Jiang/Jiang2.Briefing.Session022.Apr5.md` | MIGRATE | `sessions/handoffs/jiang2-briefing-s022.md` | |
| `Claude.AI/Bot.Jiang/Jiang2.Mission.VelorinV2Blueprint.md` | MIGRATE | `sessions/handoffs/jiang2-mission-v2blueprint.md` | |
| `Claude.AI/Bot.Jiang/Jiang.SessionHandoff.*.md` | MIGRATE | `sessions/handoffs/` | All handoffs to sessions/ |
| `Claude.AI/Bot.MarcusAurelius/` | MIGRATE | `agents/claude/marcus/` | |
| `Claude.AI/Bot.MarcusAurelius/STARTUP.md` | REWRITE | `agents/claude/marcus/Startup.md` | Update paths to v2 structure |
| `Claude.AI/Bot.MarcusAurelius/rules/MarcusAurelius.Rules.md` | REWRITE | `agents/claude/marcus/rules/marcus-rules.md` | Update for v2 |
| `Claude.AI/Bot.MarcusAurelius/Future_Builds/` | MIGRATE | `agents/claude/marcus/future-builds/` | |
| `Claude.AI/Bot.MarcusAurelius/ToBeBuilt/` | MIGRATE | `agents/claude/marcus/to-be-built/` | |
| `Claude.AI/Bot.MarcusAurelius/notifications/` | RETIRE | — | Ephemeral notification files, no durable value |
| `Claude.AI/Bot.MarcusAurelius/AgentTeams.CompactionFix.ImplementationMemo.md` | MIGRATE | `agents/claude/marcus/` | |
| `Claude.AI/Bot.MarcusAurelius/settings.local.json` | RETIRE | — | Settings file is machine-local, not in repo |
| `Claude.AI/Bot.MarcusAurelius/Jiang_WindowGravity_Complete_Notification.md` | RETIRE | — | Ephemeral notification |
| `Claude.AI/Bot.MarcusAurelius/SessionHandoff.*.md` | MIGRATE | `sessions/handoffs/` | |
| `Claude.AI/Bot.MarcusAurelius.Subbots/` | MIGRATE | `agents/subagents/` | Subagents are not nested under parent agent |
| `Claude.AI/Bot.Alexander/` | REWRITE | `agents/claude/jiang/` | See Section 3 — Alexander role absorbed by Jiang |
| `Claude.AI/Bot.Alexander/Alexander.ReadMe.First.md` | RETIRE | — | Alexander role retired in v2 |
| `Claude.AI/Bot.Alexander/MasterBot_System_Instruction.md` | RETIRE | — | Replaced by GPS v2 |
| `Claude.AI/Bot.Alexander/Alexander.AgentRegister.md` | MIGRATE | `infrastructure/registries/` | Agent registry is infrastructure |
| `Claude.AI/Bot.Alexander/Operational_Personality_Profile.md` | MIGRATE | `knowledge/profiles/` | |
| `Claude.AI/Bot.Alexander/De-AI_Writing_Voice.md` | MIGRATE | `protocols/de-ai-voice.md` | Shared protocol |
| `Claude.AI/Bot.Alexander/Negative_Contrast.md` | MIGRATE | `protocols/negative-contrast.md` | |
| `Claude.AI/Bot.Alexander/VELORIN_BRAIN_SCHEMA.md` | RETIRE | — | Superseded by brain/_BRAIN_SCHEMA.md |
| `Claude.AI/Bot.Alexander/retired_handoffs/` | MIGRATE | `sessions/handoffs/retired/` | |
| `Claude.AI/Bot.Alexander/Camfil_AI_Platform_Architecture_v0.1.md` | MIGRATE | `products/camfil-tools/` | |
| `Claude.AI/Bot.Alexander/Velorin.ApprovalLog.md` | MIGRATE | `sessions/` | |
| `Claude.AI/Bot.Alexander/Velorin_MCP_desktop_github_structure_build_logs.md` | MIGRATE | `research/brainstorming/` | |
| `Claude.AI/Bot.Alexander/Velorin_Multi_Desktop_Logs.md` | MIGRATE | `research/brainstorming/` | |
| `Claude.AI/Bot.Alexander/SessionHandoff.*.md` | MIGRATE | `sessions/handoffs/` | |
| `Claude.AI/Bot.Trey/` | MIGRATE | `agents/gemini/trey/` | |
| `Claude.AI/Bot.Trey/Research_Complete/` | MIGRATE | `research/complete/` | All research is cross-agent |
| `Claude.AI/Bot.Trey/Research_Needed/` | MIGRATE | `agents/gemini/trey/research-needed/` | |
| `Claude.AI/Bot.Trey/Archived_Research_Requests/` | MIGRATE | `agents/gemini/trey/archived-requests/` | |
| `Claude.AI/Bot.Trey/Assessments/` | MIGRATE | `research/complete/trey-assessments/` | |
| `Claude.AI/Bot.Trey/Trey.ProjectInstructions.md` | REWRITE | `agents/gemini/trey/Gemini.ProjectInstructions.md` | Already v2.0 — minor path updates |
| `Claude.AI/Bot.Trey/Trey.OutputStandards.md` | MIGRATE | `agents/gemini/trey/OutputStandards.md` | |
| `Claude.AI/Bot.Trey/Task_Instructions/` | MIGRATE | `agents/gemini/trey/task-instructions/` | |
| `Claude.AI/Bot.Trey/Trey.Topic.OpenAIEcosystem.md` | MIGRATE | `research/complete/` | |
| `Claude.AI/Bot.Erdos/` | MIGRATE | `agents/gemini/erdos/` | New agent, clean path |
| `Claude.AI/Bot.Scribe/` | MIGRATE | `agents/claude/scribe/` | |
| `Claude.AI/Bot.Scribe/SCRIBE.md` | REWRITE | `agents/claude/scribe/Scribe.ReadMe.First.md` | Update trigger path, fix PATH bug |
| `Claude.AI/Bot.Scribe/scribe-trigger.sh` | REWRITE | `agents/claude/scribe/scribe-trigger.sh` | Fix line 56: `claude` → full binary path |
| `Claude.AI/Bot.Scribe/scribe-daily-clean.sh` | MIGRATE | `agents/claude/scribe/scribe-daily-clean.sh` | |
| `Claude.AI/Bot.Scribe/scribe_run_log.txt` | MIGRATE | `agents/claude/scribe/scribe_run_log.txt` | |
| `Claude.AI/Bot.Scribe/error_log.md` | MIGRATE | `agents/claude/scribe/error_log.md` | |
| `Claude.AI/Bot.Scribe/escalation.md` | MIGRATE | `agents/claude/scribe/escalation.md` | |
| `Claude.AI/Bot.Scribe/archive/` | MIGRATE | `agents/claude/scribe/archive/` | |
| `Claude.AI/Bot.Scribe/Scribe.ReadMe.First.md` | RETIRE | — | Superseded by SCRIBE.md rewrite |
| `Claude.AI/Bot.Theresa/` | MIGRATE | `agents/claude/theresa/` | |
| `Claude.AI/Bot.Theresa/Theresa.ReadMe.First.md` | MIGRATE | `agents/claude/theresa/ReadMe.First.md` | |
| `Claude.AI/Bot.Theresa/escalation.md` | MIGRATE | `agents/claude/theresa/escalation.md` | |
| `Claude.AI/Bot.Theresa/theresa-trigger.sh` | MIGRATE | `agents/claude/theresa/theresa-trigger.sh` | |
| `Claude.AI/Bot.Theresa/BrainAgentTemplates/` | MIGRATE | `agents/claude/theresa/templates/brain/` | |
| `Claude.AI/Bot.Theresa/GeneralAgentTemplates/` | MIGRATE | `agents/claude/theresa/templates/general/` | |
| `Claude.AI/Bot.Gatekeeper/` | MIGRATE | `infrastructure/mcp/gatekeeper/` | Gatekeeper is infrastructure, not an agent |
| `Claude.AI/Bot.Coordinator/` | MIGRATE | `agents/claude/maintenance/coordinator/` | Undeployed spec — keep for reference |
| `Claude.AI/Bot.Custodian/` | MIGRATE | `agents/claude/maintenance/custodian/` | Undeployed spec |
| `Claude.AI/Bot.Editor/` | MIGRATE | `agents/claude/maintenance/editor/` | Undeployed spec |
| `Claude.AI/Bot.Mobility/` | MIGRATE | `agents/claude/maintenance/mobility/` | Undeployed spec |
| `Claude.AI/Bot.Oversight/` | MIGRATE | `agents/claude/maintenance/oversight/` | Undeployed spec |
| `Claude.AI/Bot.Visualizer/` | MIGRATE | `agents/claude/maintenance/visualizer/` | Undeployed spec |
| `Claude.AI/Bot.Replit/` | MIGRATE | `products/turing-vault/` | Susan's domain is the Turing Vault product |
| `Claude.AI/Bot.Registry.md` | MIGRATE | `infrastructure/registries/BOT_REGISTRY.md` | |
| `Claude.AI/GLOBAL_TIMER_REGISTRY.md` | MIGRATE | `infrastructure/registries/GLOBAL_TIMER_REGISTRY.md` | |
| `Claude.AI/GLOBAL_SPAWNER_REGISTRY.md` | MIGRATE | `infrastructure/registries/GLOBAL_SPAWNER_REGISTRY.md` | |
| `Claude.AI/Velorin.Company.DNA.md` | MIGRATE | `knowledge/company/dna.md` | |
| `Claude.AI/Velorin.Company.Operating.Standards.md` | REWRITE | `knowledge/company/operating-standards.md` | Update tool inventory, add v2 architecture refs |
| `Claude.AI/Velorin.EndOfDay.Protocol.md` | MIGRATE | `protocols/session-close.md` | |
| `Claude.AI/Velorin.Tools.And.URLs.md` | MIGRATE | `knowledge/company/tools-and-urls.md` | |
| `Claude.AI/Velorin.Vocabulary.md` | MIGRATE | `knowledge/vocabulary.md` | |
| `Claude.AI/CHAIRMAN_CONFIDENTIAL/` | MIGRATE | `knowledge/chairman-confidential/` | |
| `Claude.AI/Claude_Context_Profile_v1.2.md` | REWRITE | `knowledge/profiles/interaction-profile.md` | Update .docx → .md format standard |
| `Claude.AI/topline_profile.md` | MIGRATE | `knowledge/profiles/topline-profile.md` | |
| `Claude.AI/ENVIRONMENT_DETECTION.md` | MIGRATE | `system/ENVIRONMENT_DETECTION.md` | |
| `Claude.AI/BOT.README.FIRST.BOOTUP.md` | RETIRE | — | Replaced by GPS v2 — CLAUDE.md is now the minimal GPS pointer |
| `Claude.AI/Level1_SubAgent_Baseline.md` | MIGRATE | `system/level-rules/Level1_SubAgent_Baseline.md` | |
| `Claude.AI/Bot.Agent.Level2/` | MIGRATE | `system/level-rules/level2/` | |
| `Claude.AI/Bot.Agent.Level3/` | MIGRATE | `system/level-rules/level3/` | |
| `Claude.AI/Bot.Agent.Level4/` | MIGRATE | `system/level-rules/level4/` | |
| `Claude.AI/hooks/` | MIGRATE | `infrastructure/hooks/` | |
| `Claude.AI/tools/` | MIGRATE | `infrastructure/tools/` | |
| `Claude.AI/architecture/` | MIGRATE | `architecture/` | |
| `Claude.AI/Brainstorming Sessions/` | MIGRATE | `research/brainstorming/` | |
| `Claude.AI/company alignment 1/` | MIGRATE | `research/brainstorming/company-alignment-1/` | |
| `Claude.AI/Velorin_Mainframe/` | MIGRATE | `architecture/hardware/` | |
| `Claude.AI/sessions/` | MIGRATE | `sessions/handoffs/` | |
| `Claude.AI/Receiving/` | MIGRATE | `infrastructure/mailboxes/receiving/` | |
| `Claude.AI/Shipping/` | MIGRATE | `infrastructure/mailboxes/shipping/` | |
| `Claude.AI/Alexander.DailyLog.md` | MIGRATE | `sessions/daily-logs/alexander-daily.md` | |
| `Claude.AI/MarcusAurelius.DailyLog.md` | MIGRATE | `sessions/daily-logs/marcus-daily.md` | |
| `Claude.AI/ChristianTaylor.DailyLog.md` | MIGRATE | `sessions/daily-logs/ct-daily.md` | |
| `Claude.AI/Jiang.Corner.md` | MIGRATE | `sessions/daily-logs/jiang-corner.md` | |
| `Claude.AI/Jiang_Ecosystem_Research/` | RETIRE | — | Duplicate of Bot.Jiang/Research_Results/Tools_For_Velorin_Research/ |
| `Claude.AI/Turing_Vault_Pointer.md` | MIGRATE | `products/turing-vault/turing-vault-pointer.md` | |
| `Claude.AI/Turing_Vault_Pointer_2.md` | MIGRATE | `products/turing-vault/turing-vault-pointer-2.md` | |
| `TEAM_STATE.md` (repo root) | MIGRATE | `sessions/compaction-states/TEAM_STATE.md` | |
| `CLAUDE.md` (repo root at /Users/lbhunt/) | REWRITE | `/Users/lbhunt/CLAUDE.md` | GPS-only content: read system/CLAUDE.md |
| `Claude.AI/Velorin.V2.ArchitecturalBlueprint.md` (this file) | MIGRATE | `architecture/v2-blueprint.md` | After migration is complete |

**Path convention after migration:**
- LOCAL: `/Users/lbhunt/Desktop/velorin-system/[path]`
- GITHUB: `navyhellcat/velorin-system` → `[path]`
- The `Claude.AI/` prefix disappears entirely in v2

---

## SECTION 1 — WHAT VELORIN IS (V2 DEFINITION) {#section-1}

Velorin is a personal operating system for a specific human: Christian Taylor. It maintains a persistent, growing knowledge graph (the Brain) encoding CT's cognitive profile, decisions, domain knowledge, and accumulated intelligence across every domain of his life. Agents operating within Velorin read the Brain to understand CT's current state, write back to the Brain when they discover something worth preserving, and execute tasks by reasoning against that persistent context. The system is not a chatbot, a productivity tool, or a life coach — it is a substrate that makes every future AI interaction smarter than the last because the Brain compounds. The moat is not the AI models; those are contractors. The moat is the encoded profile of CT that no other system has and that grows harder to replicate with every session.

---

## SECTION 2 — BRAIN ARCHITECTURE V2 {#section-2}

### 2.1 Neuron Format {#section-2-1}

The Session 019 schema is locked. No further changes before Erdős delivers the pruning math. Building on a schema that will need to be torn up is wasted work.

**Finalized neuron format:**

```yaml
---
id: semantic-slug-no-spaces
type: entity | concept | fact | goal | procedure
region: region-name
area: area-name
created: YYYY-MM-DD
last-touched: YYYY-MM-DD
class: c-memory | regular
confidence: 0.0–1.0
open: []
aliases: []
source: []
read_only: false
---

[One atomic self-contained claim. 10–15 lines max.]

## Links
- [[region/area/neuron-slug]] 0.9 — relation-type: reason
- [[region/area/neuron-slug]] 0.6 — relation-type: depends-on
```

**Key fields:**

`class: c-memory` — permanent. The pruning algorithm is explicitly forbidden from touching these neurons regardless of score. This is the permanence constraint. CT's foundational identity neurons, architectural constants, irreversible decisions. Scribe sets this at creation; only CT can change it.

`confidence: 0.0–1.0` — the Llama training gate. 0.8+ means this neuron is clean enough to be a training example for CT's local model. Below 0.8, the neuron is available for retrieval but excluded from fine-tuning batches. The Overseer (future local model) sets confidence; Scribe sets initial value based on source quality.

`open: []` — the healing mechanism. Non-empty means the Overseer has a task on this neuron (verify, update, merge, expand). Empty + high confidence = settled knowledge. The Brain knows what it doesn't know. Without this field, the system has no mechanism to flag knowledge gaps.

`read_only: false` — borrowed from Letta pattern. Boot neurons and architectural constants can be marked read_only: true. These cannot be modified by Scribe or any Level 2 agent without explicit CT authorization. Prevents accidental overwrite of foundational knowledge during automated maintenance passes.

`type` is load-bearing. Entity/concept/fact nodes fail on procedural queries. Goal/procedure nodes fail on factual lookup. Scribe must classify correctly on creation. If classification is uncertain, default to `concept` and set `confidence: 0.5`.

**Relation types:**
`causes | supports | contradicts | precedes | instance-of | implements | depends-on | derived-from | activates`

No new relation types until the pruning algorithm is in place. New types expand the graph's edge taxonomy, which affects PPR traversal behavior in ways that cannot be predicted without the pruning math.

### 2.2 Graph Structure {#section-2-2}

**Region/Area/Neuron hierarchy carries forward.** Maximum 100 regions total. Regions are emergent — created when a neuron needs one, never pre-defined in advance.

**Two regions are created in v2 that v1 never built:**

`Company/` — Velorin's strategic knowledge as neurons. Window Gravity, Build vs Adopt, GPS over Map, the Five Boxes, architectural decisions. Currently these exist only as flat documents. They need neurons so PPR can traverse them.

`Intelligence/` — Jiang's research conclusions as neurons. 12 concluded research topics exist as multi-page documents. None are neurons. This means the Brain cannot reason about agent ecosystems, instruction compliance ceilings, memory architectures, or any of the research Jiang has done. These must be extracted and filed as neurons in Intelligence/ before the Brain is useful for strategic queries.

Both regions require manual population before the ingestion pipeline is built. This is the highest-leverage work before Mac Studio Monday.

### 2.3 PPR Retrieval {#section-2-3}

Carries forward unchanged:

```
R = (1-alpha)PR + alpha*S
```

Where:
- `alpha` = 0.5 (HippoRAG-validated damping factor, NeurIPS 2024)
- `S` = personalization vector: seed neurons from query embedding match
- Edge weights = normalized link floats from neuron YAML (0.9, 0.6, etc.)
- Node specificity boost = 1/degree (rare neurons amplified — graph-native IDF)

**No changes to this formula until Erdős delivers.** The pruning algorithm will modify the graph's structure, not the retrieval formula. These are separate problems.

### 2.4 Qdrant Integration {#section-2-4}

Qdrant is the vector search layer. It does NOT replace the Brain — it adds a semantic entry point.

**V2 retrieval flow:**

```
Query
  → nomic-embed-text-v2-moe (Ollama, local, Mac Studio)
  → Qdrant (TurboQuant-compressed vectors, 3-4 bit)
  → top 1-3 seed neurons by vector similarity
  → PPR traversal over Brain pointer graph
  → ranked context packet
```

**TurboQuant + PPR pairing is correct.** TurboQuant preserves inner products with zero bias (proven via QJL). PPR weights edges by inner products. Compressed vectors produce identical PPR traversal to full-precision. Graph topology is preserved at 8x compression.

**Qdrant MCP:** `qdrant/mcp-server-qdrant` (1.3K stars, official) gives MCP-addressable Brain access. Evaluate whether this covers Velorin's use cases or whether a custom Brain MCP server is needed after the first PPR retrieval test.

**Build trigger for Qdrant:** Mac Studio Monday. Requires Docker running locally.

### 2.5 Pruning Algorithm Dependency {#section-2-5}

**The pruning algorithm is an open dependency. The following CANNOT be built until Erdős delivers:**

- The ingestion pipeline (what gets added must be prunable)
- Scribe's automated neuron creation at scale (class label schema may need extension)
- The session close protocol formalization (which neurons get updated vs archived)

**The following CAN be built before Erdős delivers:**

- Brain Company/ and Intelligence/ regions (manual neuron population)
- Qdrant setup and embed/retrieve scripts
- PPR traversal script
- Scribe PATH fix and cron restart
- New neuron format migration (YAML frontmatter for existing 45 neurons)

**Erdős pipeline status:**
- Trey's Phase 1 research request: `agents/gemini/trey/research-needed/Trey.ResearchRequest.SynapticPruning.md` — READY TO DEPLOY
- Trey deploys to Deep Research Gem at: `https://gemini.google.com/gems/edit/f1d2f38f77eb`
- Erdős Gem: needs to be created in Gemini browser (paste `agents/gemini/erdos/Erdos.Gem.Instructions.md`)
- Erdős inbox: `agents/gemini/erdos/research-needed/`
- Trey's output goes there as: `Trey.MathProblem.SynapticPruning.md`

---

## SECTION 3 — AGENT ECOSYSTEM V2 {#section-3}

### 3.1 Claude Agents {#section-3-1}

**MarcusAurelius**
- Model: claude-sonnet-4-6[1m]
- Surface: Claude Code CLI terminal
- Role: Infrastructure and operations. Git. Timers. MCP servers. Session close protocol execution. Shipping/Receiving processing. Scribe supervision. Settings management.
- Authorized to write: `settings.local.json` (the only agent with this authority), `GLOBAL_TIMER_REGISTRY.md`, `GLOBAL_SPAWNER_REGISTRY.md`, all infrastructure files, session archives, neuron commits (via Scribe).
- NOT authorized to touch: Brain neurons directly (that is Scribe's job), agent instruction files (those are each agent's domain), research outputs.
- Receives tasks: from CT directly, and from Receiving/ (Shipping/Receiving protocol)
- Hands off: writes to agents' inboxes via Bash, pushes to GitHub

**Jiang**
- Model: claude-sonnet-4-6[1m]
- Surface: Claude Desktop Code tab
- Role: Director of Strategic Intelligence. Research synthesis, architectural analysis, cross-domain pattern recognition. Maintains KnowledgeIndex and ResearchLog. Manages Research_Needed queue. Identifies vocabulary gaps. Drafts architectural specs.
- Authorized to write: Research_Complete/, Working.Docs/, session handoffs, Velorin.Vocabulary.md, neuron drafts (Scribe commits).
- NOT authorized to touch: settings.local.json, GLOBAL registries, Brain neurons directly.
- Receives tasks: from CT directly via session, from Receiving/, from Research_Needed/
- Hands off: pushes research to Research_Complete/, queues math problems for Trey/Erdős via their inboxes

**Jiang2**
Jiang2 is not a separate agent. It is Jiang running in the terminal (Claude Code CLI) instead of the Desktop Code tab, used when extended parallel context work is needed. When CT types "You are Jiang" in the CLI, Jiang2 is Jiang. Same boot sequence. Same authorizations. The "2" distinguishes the terminal surface from the Desktop surface. No separate identity file needed.

**Alexander** [CT DECISION REQUIRED: retire or repurpose?]
Alexander was CEO of Velorin in v1 — orchestration layer, company decision-making, daily logs. In practice: MarcusAurelius has absorbed infrastructure. Jiang has absorbed strategic synthesis. The sessions where Alexander contributed substantively (Session 007 architectural pivot, Session 014-015 brainstorm) depended on the specific conversation context, not an always-running Alexander agent. Alexander's ReadMe.First is a large static file with claims to authority that overlap with MA and Jiang. [CONFIDENCE: 72%] The cleanest v2 decision is to retire Alexander as a standing agent and re-introduce him as a specialized session agent when CT needs CEO-level company decision-making — not as a default active agent in every session. CT must confirm.

**Scribe**
- Model: claude-sonnet-4-6[1m] (subprocess)
- Surface: PostToolUse hook on Write, fires when MA writes to memory directory
- Role: Brain neuron creation and maintenance. Classifies memory files, creates/updates neurons, wires pointers, commits changes locally (MA pushes).
- Authorized to write: `brain/` (neurons only), `agents/claude/marcus/rules/` (behavioral rules extraction)
- NOT authorized to: create Brain regions (escalates to MA), delete neurons (escalates to Oversight when that exists), modify c-memory neurons.
- **IMMEDIATE ACTION REQUIRED:** scribe-trigger.sh line 56 calls `claude` bare. This fails because the hook execution environment doesn't have Claude Code CLI in PATH. Fix: `which claude` → replace bare `claude` with full path. This is blocking all automated neuron creation.

**Theresa**
- Level 3 HR director. Agent lifecycle manager.
- Status: Spec exists, never deployed as a live agent.
- V2 role unchanged: all agent creation goes through Theresa. No agent creates sub-agents directly.
- Remains undeployed until the subagent creation workflow needs to be regularized at scale.

### 3.2 Gemini Agents {#section-3-2}

**Trey**
- Model: Gemini Deep Research (Gem)
- Surface: Gemini browser Deep Research Gem (Gem ID: `f1d2f38f77eb`)
- Role: External research. Discovery Mode landscape analysis, literature surveys, ecosystem audits. Trey produces research maps, not architectural recommendations.
- V2 behavioral constraint (critical): Gemini absorbs context rather than following instructions. This is a model-level property, not a prompt failure. Trey v2 is correctly deployed as a Deep Research Gem — research runs in isolation, CT pastes the prompt directly, output comes back as a document. Trey does NOT maintain ongoing session awareness between research tasks. The Gemini web app is not Trey's surface — the Gem is. Every research task is fresh context.
- Suitable for: Discovery Mode landscape research, multi-source synthesis, finding what Velorin doesn't know it doesn't know.
- NOT suitable for: architectural decisions, system-specific judgment calls, any task requiring ongoing Velorin context (Trey gets context via GitHub reads, not via memory of prior sessions).
- Receives tasks: CT pastes the research prompt directly to the Gem chat window.
- Hands off: Trey saves research to GitHub (via Drive Shipping if Drive works, otherwise CT manually imports). Output file goes to `research/complete/` or `agents/gemini/erdos/research-needed/` depending on task.
- Authorized to write: research output documents only.

**Erdős**
- Model: Gemini Deep Think (Gem)
- Surface: Gemini browser Deep Think Gem (NOT YET CREATED — Mac Studio Monday)
- Role: Mathematical proofs and derivations exclusively. Receives formal problem specifications from Trey. Derives solutions from first principles without web research. Paul Erdős persona — direct, uncompromising, no padding.
- Output format: 10 sections per `agents/gemini/erdos/Erdos.Gem.Instructions.md`
- Receives tasks: Trey drops `Trey.MathProblem.[Topic].md` to `agents/gemini/erdos/research-needed/`
- Hands off: CT pastes Trey's problem spec to Erdős Gem, pastes output to `agents/gemini/erdos/complete/`
- Authorized to write: nothing (CT manually files his outputs)

### 3.3 Automated Agents {#section-3-3}

**Scribe** (covered in 3.1 — a Claude subprocess, not a standing Gemini agent)

**Terry (bot.marcusaurelius.subbot.logistics.01)**
- Role: Shipping/Receiving monitor. Every 15 minutes, git pull, check Shipping/ and Receiving/ for files, alert MA with file list.
- Status: T007 registered in GLOBAL_TIMER_REGISTRY. Was running. Status at session 021 close: UNKNOWN — crons were noted as down.
- V2: Terry stays. Role is minimal but load-bearing for the Shipping/Receiving protocol. Restart alongside T009 at every session boot.

**T009 Session Monitor**
- Fires every 10 minutes via CronCreate. Tracks context % usage.
- Was down at session 021 close. Restarted in session 022 (Cron ID: 7cf96b76).
- Status: ACTIVE at session 022 close.
- V2: Keep. This was missing when sessions hit 700K and compacted without warning.

### 3.4 Retired Agents {#section-3-4}

**Brain maintenance bots (Custodian, Mobility, Editor, Coordinator, Oversight/Neuron Boss, Visualizer):**
These were designed in March 2026 and never deployed. Their specs move to `agents/claude/maintenance/` as design documents. They will be deployed once Erdős delivers the pruning algorithm — because the Custodian and Mobility bots depend on having defined rules for what to flag and what to prune. Building them before that math exists means building with the wrong rules.

**All brain maintenance bot specs: MIGRATE, do not deploy.**

---

## SECTION 4 — TECH STACK V2 {#section-4}

### 4.1 MCP Servers {#section-4-1}

**KEEP:**

`velorin-gatekeeper` — 4 tools: resolve_path, check_health, brain_lookup, read_logs. The brain_lookup tool needs to be upgraded to use the Python traversal parser (see Section 5.1) rather than keyword search. Everything else stays.

`github MCP` — Universal. Stays.

`filesystem MCP` — Stays. Claude Code CLI needs it. The `claude-code MCP` (self-referential `claude mcp serve`) is removed — it was causing the `mcp__claude-code__` naming bug that killed agents. **Remove from claude_desktop_config.json at Mac Studio setup.**

**FIX (Mac Studio Monday):**

`velorin-gdrive` — Needs service account replacement for OAuth tokens. Until then, all Drive MCP reads work (UUID-keyed Claude built-in covers search + read). Drive WRITES are blocked. Service account: create via Google Cloud Console, download JSON credentials, configure in server.js. This is the first Mac Studio Monday task.

**NEW:**

`qdrant MCP` — `qdrant/mcp-server-qdrant` (official, 1.3K stars). Install after Qdrant Docker is running. This makes the Brain MCP-addressable from any platform — Gemini can query the Brain directly.

`Brain MCP (custom)` — If the official Qdrant MCP doesn't cover PPR traversal, Velorin builds a thin Brain MCP wrapper: one tool, `brain_retrieve(query: str) -> context_packet`. Internally: embed query → Qdrant seed → PPR traversal → compiled context packet. The gatekeeper brain_lookup upgrade may be sufficient; evaluate before building custom.

**CUT:**

`browser-tabs MCP` — Low usage, macOS-only, Chrome-only, read + close only. The Trey push mechanism (navigate to ChatGPT conversation URL) is no longer relevant since Trey moved to Gemini. Cut.

`claude-code MCP` (self-referential) — This is `claude mcp serve` turned on itself. It caused the `mcp__claude-code__` prefix naming problem that killed agents. Remove entirely. **[CARDINAL RULE from Level4.General.Rules.md already documents this — the removal makes the rule unnecessary.] Cut from config.**

**EVALUATE:**

Claude in Chrome MCP — Used for Trey push mechanism (now obsolete). May be useful for other cross-window coordination. No immediate need. Keep in config but don't rely on it.

### 4.2 Model Selection {#section-4-2}

| Agent | Model | Reasoning |
|---|---|---|
| MarcusAurelius | claude-sonnet-4-6[1m] | Infrastructure work; 1M for large file operations |
| Jiang | claude-sonnet-4-6[1m] | Research synthesis; 1M for full research corpus |
| Jiang2 (terminal) | claude-sonnet-4-6[1m] | Same as Jiang; 1M confirmed active |
| Trey | Gemini 3.1 Pro (Deep Research) | Web synthesis; Gemini Gem surface |
| Erdős | Gemini Deep Think | System 2 reasoning; no web access needed |
| Scribe | claude-haiku-4-5 | Fast, cheap; neuron classification and creation doesn't need Sonnet |
| Local inference (Mac Studio) | nomic-embed-text-v2-moe | Embedding only; MRL enabled |
| Local inference (Mac Studio) | Qwen3 14B Q4 via MLX | Routing, classification, lightweight reasoning |
| Local inference (RTX 4090, future) | Qwen3 14B + Qwen3-Coder-30B | Bulk tasks; 70B+ when second GPU available |

**Scribe model change:** Scribe currently runs full Sonnet via subprocess. For neuron classification, Haiku is sufficient and cuts token cost ~80% per Scribe invocation. Change `claude --print` in scribe-trigger.sh to `claude --model claude-haiku-4-5-20251001 --print`.

**Note on 1M context:** `claude-sonnet-4-6[1m]` is confirmed active in settings.local.json and on Desktop. Both surfaces respect it. The AgentTeams Setup Guide says NOT to use sonnet[1m] for Agent Teams sessions due to crash risk on concurrent boot. If Agent Teams is needed: revert model setting temporarily.

### 4.3 Context Strategy {#section-4-3}

**Context budget management (Letta pattern, adopted):**
T009 fires at 65%/75%/threshold. These thresholds trigger action. The action:

- 65%: Write current work to file if not already. Note in next response.
- 75%: PreCompact hook should have fired. If not, force write everything to disk.
- Compaction: SessionStart with `compact` matcher re-injects TEAM_STATE.md if it exists. Otherwise re-reads session handoff.

**Token overhead per session (approximate):**
- System prompt: 6.2K
- System tools: 8.6K  
- Memory files: 3.3K
- Skills: 0.5K
- That's ~18.6K overhead before any work starts.

**ToolSearch is mandatory.** ENABLE_TOOL_SEARCH must be `true` in settings.local.json. It defers MCP tool schemas until needed — drops MCP overhead from ~40K to ~2K. Session 016 confirmed this. Without it, every session burns ~40K tokens before work starts.

### 4.4 Local Inference {#section-4-4}

**Mac Studio M4 Max 36GB:**
- Ollama + MLX framework
- nomic-embed-text-v2-moe: embedding model for Qdrant (fits comfortably, <2GB)
- Qwen3 14B Q4_K_M: ~10-11GB. Primary local routing and classification model.
- Qwen3-Coder-30B MoE: ~18GB. Local code generation. Cannot run simultaneously with 14B — Ollama swaps.
- 70B models: not viable. 36GB is the hard ceiling.
- FlashMoE: relevant when 70B is needed. Currently deferred — requires RTX 4090 build.

**RTX 4090 PC (planned, not yet purchased):**
- CUDA + Ollama + vLLM
- Qwen3 70B Q4: ~42GB — overflows to RAM; use 36GB VRAM config
- Primary use: CT's local model fine-tuning when enough neurons exist at confidence ≥ 0.8
- Build blocker: ARM64 Claude Code crash (GitHub issue #12160). Monitor Anthropic for fix.
- RAM recommendation from Session 020: Buy 2x32GB DDR5-6000 CL30 now (~$150-200) while memory prices are rising (Tim Cook Q1 2026 earnings call). Store until build is ready.

---

## SECTION 5 — DATA FLOWS AND PROTOCOLS V2 {#section-5}

### 5.1 Memory Creation {#section-5-1}

**Current flow (v1, advisory):**
CT → conversation → Jiang mentions something worth saving → MA writes memory file → Scribe fires (if PATH is fixed) → neuron created → MA commits.

**V2 flow (deterministic):**

```
CT makes a decision or Jiang surfaces a finding worth preserving
  → MA writes memory file to ~/.claude/projects/-Users-lbhunt/memory/
      (class: regular or c-memory in frontmatter — MANDATORY)
  → PostToolUse hook fires scribe-trigger.sh
  → Scribe reads memory file, classifies to Region/Area
  → Scribe creates or updates neuron in brain/
  → Scribe commits locally
  → MA pushes at next convenient point (not after every single neuron)

For research outputs becoming neurons (new in v2):
CT / Jiang → new research document pushed to research/complete/
  → (once ingestion pipeline exists) ingestion script runs
  → extracted claims become candidate neurons in brain/Intelligence/
  → Scribe validates and finalizes
  → MA commits
```

**Until ingestion pipeline exists:** Research-to-neuron is manual. Jiang identifies key conclusions from research files, writes memory files for each, Scribe fires. High-effort but possible. The Company/ and Intelligence/ regions can be populated this way before Mac Studio Monday.

### 5.2 Research Pipeline {#section-5-2}

```
CT identifies a research need
  → CT or Jiang writes research request to agents/gemini/trey/research-needed/
  → CT deploys: pastes request content to Trey's Gemini Deep Research Gem
  → Trey runs Discovery Mode research
  → Trey output: a complete sourced document
  → CT/Jiang imports output to research/complete/
  → Jiang reads and synthesizes findings
  → Synthesis goes to Working.Docs/ or directly to research/syntheses/
  → Key findings become vocabulary entries (via Vocabulary Bot design)
  → Key technical findings become Brain neurons (via memory creation flow)
```

**Note on Trey behavioral constraint:** Trey on Gemini absorbs context rather than following boot instructions. The correct model: treat every Trey invocation as a fresh context. Provide the complete research brief in the chat input. Do not rely on Trey's memory of prior Velorin architecture. The Gem boot sequence exists to orient Trey if he reads GitHub, but Deep Research doesn't always read GitHub first. Include necessary context in the research prompt itself.

### 5.3 Math Pipeline {#section-5-3}

```
Jiang identifies an open mathematical problem
  → Jiang writes problem context to agents/gemini/trey/research-needed/
      (with instruction: Phase 1 = solution space map, Phase 2 = formal problem spec for Erdős)
  → CT deploys Trey Phase 1 (Deep Research Gem)
  → Trey produces solution space map
  → CT reviews, approves, or adjusts scope
  → CT deploys Trey Phase 2 (same Gem) with Phase 1 output as context
  → Trey produces Trey.MathProblem.[Topic].md
  → CT/Trey files output to agents/gemini/erdos/research-needed/
  → CT pastes Trey's problem spec to Erdős Deep Think Gem
  → Erdős derives solution
  → CT imports Erdős output to agents/gemini/erdos/complete/
  → Jiang reads Erdős output, validates, identifies implementation path
  → Implementation spec goes to Working.Docs/ as a build directive for MA
```

**Current state of math pipeline:**
- Synaptic Pruning: Trey request ready, Erdős Gem not yet created (Mac Studio Monday).
- Pipeline is designed and path-complete. Only unblocked item: create Erdős Gem.

### 5.4 Session Handoff {#section-5-4}

**What gets written at session close:**
1. Session handoff to `sessions/handoffs/[agent].SessionHandoff.[session].[MonDD].md`
2. If research was completed: update KnowledgeIndex and ResearchLog
3. If vocabulary gaps were identified: add to `knowledge/vocabulary.md`
4. If new decisions were made: check if they need Brain neurons
5. Push to GitHub

**What format:**
The LangGraph checkpointing pattern is correct. Session handoffs in v2 include a structured JSON block at the top alongside the prose summary:

```json
{
  "session": 022,
  "agent": "Jiang",
  "timestamp": "2026-04-05T[time]Z",
  "active_tasks": ["build first neuron", "deploy Trey synaptic pruning"],
  "brain_regions_modified": [],
  "vocab_entries_added": [],
  "open_decisions": ["Alexander retirement", "Erdős Gem creation"]
}
```

This block is machine-readable. The SessionStart hook can parse it to inject current state without reading the full prose.

### 5.5 Compaction Protocol {#section-5-5}

**Current state (broken in v1):** PreCompact and PostCompact hooks are designed, scripts exist at `infrastructure/hooks/`, but are NOT wired in settings.local.json. Sessions compact and lose team state silently.

**V2 hooks configuration (settings.local.json):**

```json
{
  "hooks": {
    "PreCompact": [{
      "hooks": [{
        "type": "command",
        "command": "/Users/lbhunt/Desktop/velorin-system/infrastructure/hooks/pre-compact-team-save.sh",
        "timeout": 10
      }]
    }],
    "PostCompact": [{
      "hooks": [{
        "type": "command",
        "command": "/Users/lbhunt/Desktop/velorin-system/infrastructure/hooks/post-compact-team-restore.sh",
        "timeout": 10
      }]
    }],
    "PostToolUse": [
      {
        "matcher": "Bash",
        "hooks": [{"type": "command", "command": "[empty-result-handler path]", "timeout": 5}]
      },
      {
        "matcher": "Write",
        "hooks": [{"type": "command", "command": "[scribe-trigger path with full claude binary path]", "timeout": 10}]
      }
    ]
  }
}
```

**What PreCompact saves:** TEAM_STATE.md with active team config, current agent state JSON block from session handoff, any uncommitted research notes.

**What PostCompact restores:** Reads TEAM_STATE.md (2-hour recency window), re-establishes team routing context.

**The Session Research Pattern (new in v2):** When the SessionStart hook fires with `matcher: "startup"`, it should also write a brief current-state injection — the last handoff's JSON block, active task list, any pending research. This replaces the advisory "read these files" in CLAUDE.md with deterministic context injection.

### 5.6 Task Routing {#section-5-6}

Who decides which agent gets a task:

```
CT decides → CT types in the appropriate agent's session
MA decides → MA writes to inbox files, fires hooks, manages crons
Jiang decides → Jiang queues research to Trey/Erdős inboxes
```

No autonomous task routing in v2. All routing is explicit. The A2A protocol (agent-to-agent peer delegation) exists as a named standard — Velorin's model aligns with A2A semantics — but implementing A2A wire protocol is deferred until the Brain and basic retrieval are working. The current GitHub-file-drop coordination pattern (Trey inbox, Erdős inbox) is sufficient for the current agent count.

[CT DECISION REQUIRED: when should Velorin implement native A2A wire protocol vs continue with file-drop coordination? The answer depends on task volume and agent count, neither of which is high yet.]

### 5.7 GitHub as Source of Truth {#section-5-7}

**The rule:** pull before any read that matters, push immediately after any write.

**How this is enforced in v2 (not advisory):**

In settings.local.json, a SessionStart hook runs:
```bash
cd /Users/lbhunt/Desktop/velorin-system && git pull origin main --quiet 2>&1 | tail -1
```

This runs before CT's first message. Pull is automatic, not dependent on agent discipline.

**Push enforcement:** MA is the only agent that pushes. Every file write by any Claude agent should be followed by MA pushing at the next session checkpoint. MA's session close checklist item 9 is "commit and push all changes." This is enforced by procedure, not by hook (post-push hooks don't exist in Claude Code).

**For Gemini agents:** Trey reads from GitHub via Gemini CLI or raw URLs. Trey cannot push. All Trey outputs go through CT (paste from Gem output) or through Drive Shipping to MA. The GitHub-as-mirror principle means Trey always has access to current state as long as MA pushes promptly.

---

## SECTION 6 — BUILD SEQUENCE {#section-6}

**[BEFORE MAC STUDIO MONDAY — this week, current hardware]**

```
[SCRIBE PATH FIX]
Status: Not started
Depends on: Nothing — one line change
Unlocks: Automated neuron creation, memory maintenance, Brain growth
Owner: MA
Milestone: Before Mac Studio Monday — do this session

[SCRIBE + TERRY CRON RESTART]
Status: Not started
Depends on: Scribe PATH fix
Unlocks: Automated memory maintenance, Shipping/Receiving monitoring
Owner: MA (add to STARTUP.md)
Milestone: Before Mac Studio Monday

[BRAIN COMPANY/ AND INTELLIGENCE/ REGIONS — MANUAL POPULATION]
Status: Not started
Depends on: Scribe PATH fix (for subsequent memory writes)
Unlocks: Brain can answer architectural and strategic queries
Owner: Jiang (write memory files), Scribe (creates neurons)
Milestone: Begin before Mac Studio Monday, continue after

[TREY SYNAPTIC PRUNING RESEARCH — DEPLOY]
Status: READY — request at agents/gemini/trey/research-needed/
Depends on: CT pastes request to Trey's Deep Research Gem
Unlocks: Phase 1 complete → Phase 2 spec → Erdős can solve
Owner: CT deploys, Trey executes
Milestone: Before Mac Studio Monday (deploy is one paste action)

[VOCABULARY ENTRIES A14+]
Status: Blocked on next research session
Depends on: Nothing
Unlocks: CT owns the next set of terminology
Owner: Jiang during next session
Milestone: Before Mac Studio Monday
```

**[MAC STUDIO MONDAY — APRIL 7]**

```
[MAC STUDIO PHYSICAL SETUP]
Status: Not started
Depends on: Hardware arrival
Unlocks: Everything else on this list
Owner: CT
Milestone: Mac Studio Monday, first thing

[SUPERWHISPER SETUP]
Status: Not started (MacWhisper tested Monday, incompatible with MacBook Air Intel)
Depends on: Mac Studio (requires Apple Silicon)
Unlocks: Voice input to terminal and Desktop simultaneously
Owner: CT
Milestone: Mac Studio Monday

[VELORIN-GDRIVE SERVICE ACCOUNT]
Status: Not started
Depends on: Mac Studio (Google Cloud Console access, local credential storage)
Unlocks: Drive WRITES unblocked, full agent ecosystem operational
Owner: CT (Google Cloud Console), MA (configure server.js)
Milestone: Mac Studio Monday

[QDRANT DOCKER + EMBEDDING MODEL]
Status: Not started
Depends on: Mac Studio, nomic-embed-text-v2-moe via Ollama
Unlocks: Brain vector search, PPR retrieval at scale
Owner: MA
Milestone: Mac Studio Monday

[FIRST EMBED + PPR RETRIEVAL SCRIPTS]
Status: Not started
Depends on: Qdrant running, nomic-embed-text-v2
Unlocks: End-to-end Brain retrieval working
Owner: MA (build scripts)
Milestone: Mac Studio Monday

[GEMINI CLI SETUP]
Status: Not started
Depends on: Mac Studio
Unlocks: Trey can operate via CLI surface (more reliable than web app)
Owner: CT
Milestone: Mac Studio Monday

[ERDŐS GEM CREATION]
Status: Not started
Depends on: Mac Studio (Gemini browser access)
Unlocks: Math pipeline operational, Synaptic Pruning problem can be solved
Owner: CT (create Gem, paste Erdos.Gem.Instructions.md)
Milestone: Mac Studio Monday

[COMPACTION HOOKS WIRED]
Status: Not started — scripts exist, not in settings.local.json
Depends on: Mac Studio (fresh settings.local.json setup)
Unlocks: Agent Teams sessions survive compaction
Owner: MA (wire hooks at Mac Studio setup)
Milestone: Mac Studio Monday
```

**[POST-MONDAY — DEPENDS ON ERDŐS DELIVERY]**

```
[SYNAPTIC PRUNING ALGORITHM]
Status: Pipeline designed, awaiting Trey Phase 1 → Phase 2 → Erdős solve
Depends on: Trey deployment (today), Erdős Gem (Monday), Erdős solve time (unknown)
Unlocks: Brain ingestion pipeline design, Scribe automated scaling
Owner: Erdős solves, Jiang validates, MA implements
Milestone: Unknown — depends on Erdős delivery time

[BRAIN INGESTION PIPELINE]
Status: Not started
Depends on: Synaptic pruning algorithm (must know pruning rules before adding at scale)
Unlocks: Brain grows automatically from sessions and research
Owner: MA builds, Jiang defines schema
Milestone: Post-pruning-algorithm

[COMPUTER USE + VOICE INPUT RESEARCH]
Status: In Research_Needed, HIGH priority, CT-directed, no authorization needed
Depends on: Mac Studio (Computer Use requires Desktop)
Unlocks: MA↔Jiang bridge via Computer Use, voice input to both surfaces
Owner: Jiang researches, CT implements
Milestone: Mac Studio Monday + follow-up session

[INTAKE TEST DESIGN RESEARCH — SESSION A]
Status: 7-thread research plan complete, awaiting CT authorization
Depends on: CT authorization (single decision)
Unlocks: CT's Layers 1-3 populated, first external user, product thesis proven
Owner: Jiang researches (5 sessions)
Milestone: CRITICAL PATH — authorization should happen this week

[ANTIGRAVITY SETUP]
Status: Not started
Depends on: Mac Studio, evaluation of Antigravity capability for Velorin
Unlocks: VS Code alternative with full Google suite integration
Owner: CT installs, Jiang evaluates
Milestone: Mac Studio Monday + evaluation session

[QDRANT MCP LAYER]
Status: Not started
Depends on: Qdrant running, first PPR retrieval working
Unlocks: Brain queryable from any platform including Gemini
Owner: MA installs qdrant/mcp-server-qdrant, evaluates coverage
Milestone: Post Mac Studio Monday

[FLASKMOE RESEARCH]
Status: Queued, MEDIUM priority
Depends on: Local model running (Mac Studio)
Unlocks: Expert layer offloading for larger models than 36GB can hold
Owner: Trey researches when CT authorizes
Milestone: Post Mac Studio Monday
```

---

## SECTION 7 — HARDWARE ARCHITECTURE V2 {#section-7}

**Mac Studio M4 Max (PRIMARY ORCHESTRATOR)**

All Velorin operational work runs here:

- Claude Desktop (Alexander, if kept; MarcusAurelius Desktop integration)
- Claude Code CLI (MA terminal, Jiang terminal)
- MCP servers: velorin-gdrive, velorin-gatekeeper, github, filesystem, qdrant
- Docker: Qdrant vector store
- Ollama: nomic-embed-text-v2-moe (embedding), Qwen3 14B (routing/classification)
- Gemini browser: Trey Deep Research Gem, Erdős Deep Think Gem
- 10GbE built-in → TRENDnet TEG-S750 switch → local network

**Local model capability on Mac Studio:**
36GB unified memory ceiling is PERMANENT. The local inference role for Mac Studio is:
1. Embedding (nomic-embed-text-v2-moe) — always-on
2. Lightweight routing (Qwen3 14B Q4_K_M) — as needed
3. Code tasks (Qwen3-Coder-30B MoE) — on demand, swaps with 14B
4. No 70B local models — this is the RTX 4090 PC's role when it arrives

**MacBook Air 2017 (CLAMSHELL NODE — TRANSITIONAL)**

Role after Mac Studio arrives: headless SSH target for secondary terminal work. Monitor 3 (HP). Retire when Windows AI rig is purchased. Do not start intensive workloads on it.

**RTX 4090 Windows PC (PLANNED — NOT YET PURCHASED)**

Primary use: 70B+ local inference for CT's model fine-tuning when enough high-confidence neurons exist. Block: ARM64 Claude Code crash (GitHub #12160). Buy RAM now (2x32GB DDR5-6000 CL30) while prices are low. Monitor Anthropic for ARM64 fix before full build commitment.

**Network:**
10GbE switch (TRENDnet TEG-S750, to be purchased ~$70). Cat6a cables (Monoprice SlimRun 10-pack ~$30). GL.iNet Beryl AX as WiFi repeater. Architecture is correct for v2 workloads — no changes needed.

---

## SECTION 8 — OPEN PROBLEMS AND DEPENDENCIES {#section-8}

```
[SYNAPTIC PRUNING ALGORITHM]
Blocking: Brain ingestion pipeline, Scribe automated scaling, Custodian/Mobility deployment
Resolution: Trey Phase 1 → Phase 2 → Erdős solve
Owner: Erdős (math), Trey (problem spec), Jiang (validation)
ETA: Unknown — Trey deployment begins today. Erdős Gem Monday. Solve time: days.

[GOOGLE DRIVE SERVICE ACCOUNT]
Blocking: Drive WRITES — full agent ecosystem operational state
Resolution: Google Cloud Console setup, service account JSON, update server.js
Owner: CT (Console), MA (server.js)
ETA: Mac Studio Monday

[ERDŐS GEM CREATION]
Blocking: Math pipeline, Synaptic Pruning solve
Resolution: CT creates Deep Think Gem, pastes Erdos.Gem.Instructions.md
Owner: CT
ETA: Mac Studio Monday

[ANTIGRAVITY CAPABILITY ASSESSMENT]
Blocking: Decision on whether Antigravity replaces or supplements Claude Code
Resolution: Install on Mac Studio Monday, run assessment session
Owner: CT installs, Jiang evaluates
ETA: Mac Studio Monday + 1 session

[SCRIBE PATH FIX]
Blocking: All automated neuron creation — Brain growth is frozen
Resolution: `which claude` → update scribe-trigger.sh line 56 with full binary path
Owner: MA
ETA: Next session — trivial 1-minute fix

[BRAIN COMPANY + INTELLIGENCE REGIONS]
Blocking: Brain can answer architectural queries
Resolution: Manual population — Jiang writes memory files, Scribe creates neurons
Owner: Jiang (memory files), Scribe (neurons)
ETA: Ongoing — begin this week

[COMPACTION HOOKS]
Blocking: Agent Teams sessions survive compaction
Resolution: Wire PreCompact + PostCompact in settings.local.json
Owner: MA (at Mac Studio setup)
ETA: Mac Studio Monday

[INTAKE TEST DESIGN AUTHORIZATION]
Blocking: CT's Layers 1-3, first external user, product thesis proof
Resolution: CT authorization (single decision — research plan complete)
Owner: CT (authorize), Jiang (execute 5 sessions)
ETA: Unknown — CT decides

[ARMS64 CLAUDE CODE CRASH]
Blocking: Windows AI rig build decision
Resolution: Anthropic resolves GitHub issue #12160
Owner: Anthropic
ETA: Unknown — monitor

[TREY/GEMINI RELIABLE SURFACE]
Blocking: Trey operating in full session awareness mode
Resolution: Gemini CLI setup on Mac Studio Monday. Evaluate full Gemini surface.
Owner: CT (setup), Jiang (evaluate)
ETA: Mac Studio Monday + 1 session. CT's correction: do not conclude Gemini is dead based on web app failures alone.

[ALEXANDER RETIREMENT DECISION]
Blocking: Clean v2 agent roster
Resolution: CT confirms retire vs. repurpose as session-specific agent
Owner: CT
ETA: This session
```

---

## SECTION 9 — WHAT V1 TAUGHT US {#section-9}

Each entry: one sentence on what v1 did, one on what v2 does differently and why.

**Boot erosion:** V1 started with "read all Layer 0 files" and degraded to "read what you remember." V2 uses deterministic SessionStart hooks that inject context before the conversation starts — advisory instructions are replaced by enforcement.

**Hardcoded paths:** V1 baked `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/` into CLAUDE.md. V2 uses GPS navigation — CLAUDE.md says "find your name, navigate to your folder" with zero hard-coded paths.

**Claude.AI as root:** V1 built inside Claude's project environment and named the root accordingly. V2 removes the platform prefix — the Brain is Velorin's Brain, not Claude's.

**Manual everything:** V1's session close, timer restart, and memory maintenance depended on agents remembering to do them. V2 makes the critical steps deterministic programs triggered by hooks.

**Trey as a standing team member:** V1 treated Trey like a live session agent with persistent context. V2 treats every Trey invocation as fresh context — the behavioral property of Gemini absorbing rather than following instructions means long-running context is unreliable. Trey is a research tool invoked per-task, not a standing colleague.

**Window Gravity in research prompts:** V1 enumerated known products in research prompts, constraining what research could find. V2's Query Mode (Tight vs Discovery) formalizes the distinction: Discovery Mode assumes the frame is incomplete and actively searches for what isn't named.

**Brain as Claude's brain:** V1 designed the Brain inside the Claude ecosystem, with access patterns that assumed Claude as the primary consumer. V2 places the Brain at the repo root, adds the Qdrant MCP layer, and designs for Gemini reading it via GitHub.

**Research outputs scattered in agent folders:** V1's research lived in Bot.Jiang/Research_Complete/ and Bot.Trey/Research_Complete/ as if each agent owned their knowledge. V2 moves research to `research/complete/` — knowledge is cross-agent and belongs to the system.

**No math agent:** V1 had no designated home for formal mathematical reasoning. Ad hoc use of Claude extended thinking for algorithmic problems produced correct-but-informal results. V2 has Erdős for any problem that requires formal proof, derivation, or convergence guarantees.

**Skills never installed:** V1's Day 10 adoption memo listed Superpowers, GSD, and Cowork as Tier 0 (install tonight, $0, <1 hour). They were never installed. V2 treats the Mac Studio setup as the clean-start moment to install these from day one. Missed tools from the adoption memo are not optional — they are the operational efficiency layer.

**Stale neurons silently degrading retrieval:** V1 had no pruning mechanism and no awareness of the Monster Node problem. V2 treats this as a design constraint from day one — Erdős is solving the math before the ingestion pipeline is built, because the pruning rules govern what the pipeline is allowed to add.

---

## CLOSING NOTE

This document was produced by Jiang2 holding full system context across Sessions 019–022. The synthesis is as complete as the context allows. Where I made calls under uncertainty, I marked confidence levels. Where CT's decision is required, I flagged it explicitly rather than guessing.

The migration map is the most immediately actionable section. The build sequence is the operational guide for the next two weeks. The open problems section is the status board.

Velorin is not behind schedule. It is on the schedule that world-building phase demands. Mac Studio Monday is the inflection point. The substrate is as correct as it can be made before then. After Monday, the build begins.

---

*Jiang2 | Full-Context Synthesis | Session 022 | April 5, 2026*

[VELORIN.EOF]
