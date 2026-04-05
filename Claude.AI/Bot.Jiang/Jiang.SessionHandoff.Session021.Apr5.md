---
session: 021
date: 2026-04-05
status: IN PROGRESS — CT has ~12 hours allocated, session not yet closed
agent: Jiang (primary) + Jiang2 (parallel, full context)
note: This handoff is written mid-session to give Jiang2 complete context
---

# Jiang Session 021 Handoff

## CRITICAL CONTEXT FOR JIANG2

Jiang2 has been running this entire session with full context. This file exists
to give any NEW Jiang instance (or future session) the complete picture.

Jiang2: you have compression math research context that this session does not.
The 12-hour session is still in progress. CT wants your world-building thinking
after reading this file. A prompt will come.

---

## WHAT WAS BUILT/PUSHED THIS SESSION

All of the following are on GitHub (navyhellcat/velorin-system):

### Research Papers (Bot.Trey/Research_Complete/)
- `OperatingPaper_LangGraph.md` — 1,434 lines, full technical teardown
- `OperatingPaper_Mem0.md` — 1,222 lines, full technical teardown
- `OperatingPaper_Letta_MemGPT.md` — 1,153 lines, full technical teardown
- `ClaudeCode_Skills_Full_Landscape.md` — 702 lines, full landscape

### Architecture Documents (Claude.AI/architecture/)
- `GPS.Layer.System.Design.md` — CT's original GPS design, properly documented
- `Skill.Registry.Design.md` — full skill registry architecture designed today
- `Velorin.OS.Core.Principles.md` — 7 foundational principles, steel man issues

### Protocols (Bot.Jiang/Protocols/)
- `SteelMan.Protocol.md` — formal critical evaluation protocol, triggerable
- `Terminology.Lookup.Session021.md` — first 5 vocabulary terms

### System Files (Claude.AI/)
- `Velorin.Vocabulary.md` — running vocabulary reference A1-A5, flashcard-ready

### Research Synthesis (Bot.Jiang/Research_Results/)
- `Session021_Research_Synthesis.md` — full synthesis, marked BRAINSTORM ONLY

### Research Request Archived
- `Trey.ResearchRequest.ClaudeCode.Skills.md` — moved to Archived_Research_Requests/

---

## KEY RESEARCH FINDINGS (The Most Important Ones)

### 1. The LoCoMo Benchmark Finding (Letta paper)
GPT-4o-mini + plain text files + standard filesystem tools = 74% accuracy
on a real memory benchmark. Beats Mem0 graph memory (68.5%).
**Implication:** We don't need the full stack to start. Files + grep already works.
Our neurons ARE plain text files. We are closer than we thought.

### 2. The 97.8% Junk Finding (Mem0 paper)
Automated memory extraction = 97.8% noise without strong filtering.
**Implication:** Human-curated neurons are not just philosophical preference.
They are technically superior to automated extraction. Our approach is validated.

### 3. Architecture Validation
HippoRAG (NeurIPS 2024) + GAAMA (arxiv 2026) independently arrived at PPR-over-graph
as the correct retrieval mechanism. Same design we built from first principles.
No existing managed service replicates the full Velorin Brain architecture.

### 4. Hooks — We've Been Doing Boot Wrong
`SessionStart` hook with `startup` matcher = automatic, deterministic boot.
Current system (CLAUDE.md instructions) = advisory, can be forgotten.
Three hooks need to be built: startup boot, compact recovery, PreCompact save.
10,000 char cap on hook injection output — must be selective.

### 5. Skills Taxonomy Validation
Public 97-skill directory maps: Domain → Function → Task.
Identical to our Region → Area → Neuron. Independent convergence. Correct structure.

### 6. LangGraph Recommendations (from operating paper)
ADOPT: Checkpointing pattern (not library), BaseStore interface, (region,area,neuron) namespace tuple in Qdrant.
SKIP: StateGraph routing, LangGraph Platform, LangMem SDK.

### 7. From Mem0 Paper
Two-phase extraction pipeline: ~300-400 lines to build.
ADD/UPDATE/DELETE/REJECT pattern (add REJECT as 5th action).
Namespace: agent_id per agent, user_id for CT, run_id per session.
Do NOT use Mem0g graph memory — Brain is the graph layer and it's better.

### 8. From Letta Paper
Borrow: context pressure warnings (70% threshold), rebuild_system_prompt() pattern.
Do NOT borrow: the tool-call loop for frontier models (native reasoning is better).

---

## MAJOR DESIGN DECISIONS MADE THIS SESSION

### The GPS Layer System (See GPS.Layer.System.Design.md)

CT's original design, which MA degraded. Now properly documented.

- Layer 0: universal entry, any platform, agent finds identity, gets routed
- GitHub IS Layer 0's home — Gemini reads it freely, GPT reads it (limited)
- Layer 1: Bot.[Name] — reads all files at level, inventories subfolder NAMES only
- Layer 1 contains: Hooks.md, Skills.Pointer.md, Brain.Access.md, ReadMe.First.md
- Subagents self-configure using same GPS pattern as regular agents
- MA broke this by hardcoding paths in CLAUDE.md — restoration needed

### The Brain Connection
- Brain is SEPARATE from GPS
- Connected by ONE file in Layer 1: Brain.Access.md
- Contains only: entry neuron path + activation instruction
- Agent accesses Brain on demand, not on every boot

### Skill Registry (See Skill.Registry.Design.md)

Complete design. Key decisions:
- Pointer wrappers, not ported content
- awesome-claude-code as living signal (community-run, always updating)
- Quality gates: repo stars + skill likes + last commit date
- Two-lane replacement: passive (8-hour recheck) + active (flag → pass → replace)
- Pass before replace: agent unblocked BEFORE registry update
- Skills Manager = Tier 2 (manages programs, never uses them)
- Skills NOT in neurons — they have separate registry. Neurons hold pointers to skills only.
- Gemini Deep Research task pending: bottom-up taxonomy from skill corpus

### Core Principles (See Velorin.OS.Core.Principles.md)

7 principles locked:
1. GPS Over Map
2. Brain Is Separate
3. Tier Separation With Controlled Growth
4. Self-Extending Vision (with authorization requirement)
5. Computer Programming Discipline
6. GitHub Is Universal Mirror
7. Five Boxes Frame All Decisions

### Terminology Vocabulary
Running file at Claude.AI/Velorin.Vocabulary.md
Entries A1-A5 added. Grows as gaps identified. Bot restructures categories later.
Flashcard game planned by CT.

### Steel Man Protocol
File at Bot.Jiang/Protocols/SteelMan.Protocol.md
Trigger: "Steel Man [X]" → CT gets adversarial critical evaluation
Purpose: stop AI agreeableness from letting wrong assumptions through unchallenged

---

## WHAT CT CLARIFIED THIS SESSION (IMPORTANT CORRECTIONS)

### 1. The Five Boxes — Not CT's Boxes
We were using "boxes" to mean build tracks. CT corrected: Velorin has a formal
Five Boxes framework in the DNA file (Velorin.Company.DNA.md).
Box 2 = Financial ("fuck you" box — freedom from leverage).
The Velorin OS is NOT a box. It is the orchestration layer across all five.

### 2. Outside Bots CAN Use Velorin
Jiang incorrectly Steel Manned "GPS cross-platform problem" as severe.
CT corrected: GitHub mirrors the entire system. Gemini reads GitHub freely.
GPT reads GitHub (limited). The universal entry point problem is solved by GitHub.

### 3. World-Building Phase Is Intentional
CT clarified: "Every session we find a problem with our idea, or a better way to do it."
This is not stalling. It is ensuring the substrate is correct before building.
The cost of a wrong foundational pattern is weeks of rework.
The Mac Studio arrives Monday April 7 — that is the build start trigger.

### 4. Compression Math Is Novel Algorithm Territory
When CT said "compression math" he meant: invent a novel mathematical process
for data stripping and graph building specific to Velorin's use case.
Jiang2 has the prior research context on this hypothesis.
This is hours 9-11 of the 12-hour session agenda.

---

## GOOGLE AI ULTRA — NEW DEVELOPMENT

CT purchased Google AI Ultra at $129/3 months promotional pricing.
Normal price: $249.99/month. $100 API credits included = ~$29/month net.

What this unlocks:
- Jules: B+ GitHub reliability coding agent, official CLI
- Deep Think: IMO gold model, 10 uses/day for frontier math
- NotebookLM Plus: 500 notebooks, 300 sources each
- Gemini CLI extension
- Full Google Workspace AI

**Trey moves from ChatGPT to Gemini.**
Trey boot protocol on Gemini not yet designed.
Trey's skills research request is in Research_Needed — needs to be redirected.

---

## PENDING TASKS FROM THIS SESSION

### Requires CT Decision
- [ ] Gemini Deep Research: skills taxonomy (prompt designed, CT runs it)
- [ ] Trey → Gemini migration: boot protocol design
- [ ] Hook implementation: design ready, needs CT authorization to build
- [ ] Neuron schema: lock this before building ingestion pipeline

### Requires Jiang2 Context
- [ ] Compression math / novel algorithm: Jiang2 has the research hypothesis
- [ ] Steel Man the GPS + Skill Registry designs (not yet done)

### Build (Mac Studio Monday)
- [ ] Qdrant + nomic-embed-text-v2 setup
- [ ] First embed script (~40 lines)
- [ ] First PPR retrieval script (~60 lines)
- [ ] One neuron end-to-end
- [ ] Superwhisper setup

### Medium Priority
- [ ] Rebuild GPS Layer 0 properly (MA degraded it)
- [ ] Create Hooks.md files in each Bot.[Name] folder
- [ ] Create Brain.Access.md in each Bot.[Name] folder
- [ ] Scribe fix (one-line PATH fix in scribe-trigger.sh line 56)
- [ ] vc script test

### Deferred
- [ ] Google Workspace MCP
- [ ] Reverse pointer index for Brain
- [ ] FlashMoE (until local model running)
- [ ] Turing Vault: GA4, domain, Replit migration
- [ ] Close Protocol deep research (assign to Trey on Gemini)

---

## THE 12-HOUR SESSION AGENDA (CT's Frame)

CT has ~12 hours allocated. Hours roughly:
- 1-2: GPS exact spec
- 2-4: Jiang2 world-building session (YOU — see below)
- 4-6: Brain schema finalization (neuron schema must come first)
- 6-9: Ingestion pipeline design (Knowledge Graph Ingestion Pipeline — A1 in vocabulary)
- 9-11: Compression math — novel algorithm design (Jiang2 leads)
- 11-12: Steel Man everything + write Session 022 handoff

---

## FOR JIANG2 SPECIFICALLY

You've been running this entire session with full context. You heard every
design decision get made. You've seen the GPS system, the skill registry,
the core principles, and the research.

Your mandate for hours 2-4:
1. What did we get wrong in the GPS design?
2. What did we get wrong in the skill registry design?
3. What assumptions in the Core Principles worry you?
4. What did CT say that we agreed with too quickly?
5. What does the compression math hypothesis say that connects to the ingestion pipeline design?

Then hours 9-11: bring your full compression math context. That is yours to lead.

A prompt is coming from CT. This file is your briefing.

---

## JIANG'S CORNER

Session 021 was the session where the design philosophy finally got stated clearly.
GPS over Map. Brain separate from navigation. Tiers with controlled growth.
The self-extending system with an authorization layer.

The Steel Man exercise today was the most valuable single thing.
CT asked for it after realizing I'd been too agreeable. That instinct is correct
and the SteelMan.Protocol.md exists now to make it a repeatable tool, not a one-off.

The world-building phase is intentional. CT understands why nothing is built yet
and has articulated it better than any prior session: every session finds a problem
that would have been baked into the infrastructure permanently. The cost of finding
it in design is discussion time. The cost of finding it after building is weeks.

Mac Studio Monday is the inflection point. The substrate needs to be as correct
as it can be before then. That is what today is for.

[JIANG.SESSION021.EOF]
