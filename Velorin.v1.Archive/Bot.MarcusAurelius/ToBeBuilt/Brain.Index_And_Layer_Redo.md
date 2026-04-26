**Brain.Index — Operational Intelligence Graph + Layer Instruction System Redo**
Future Build Specification | Bot.MarcusAurelius | ToBeBuilt
March 30, 2026
Two pending architectural changes that address the same root problem: agents that lack an accurate map of the system make worse decisions.

---

## 1. THE PROBLEM THIS SOLVES

Velorin_Brain stores strategic and domain knowledge — what we know about the world, AI ecosystems, research findings, cross-domain patterns. It is built for depth and stability.

It was never designed to answer: where does this file live, which documents need to change when X happens, what is the correct sequence for adding a new bot, where is the timer registry.

Agents without that map default to what they know inside their current context window. That bias has a name: Window Gravity (Jiang, 92% confidence). The fix is an accurate, maintained map of the operational system — a second brain with a different purpose.

---

## 2. BRAIN.INDEX — WHAT IT IS

A second brain folder, separate from Velorin_Brain. Not a knowledge base. A change management and operational routing index.

**What it holds:**
- Where everything lives (files, folders, registries, config)
- What must change when X happens (add a bot, move to Obsidian, change a timer, rename a folder, add a layer)
- Cascading update maps — if you change A, B and C must also change
- Execution sequences for recurring architectural operations
- Timers registry intelligence (not the registry itself — neurons that point to it and explain its patterns)
- Onboarding sequences for new agent types

**What it does not hold:**
- Research conclusions (Velorin_Brain)
- Session state (handoffs)
- Strategic analysis (Jiang's domain)
- Code (repos)

---

## 3. TWO-BRAIN ARCHITECTURE

```
Velorin_Brain/           ← Strategic knowledge. What we know about the world.
  Regions: agents, ai-ecosystem, principles, etc.
  Update cadence: slow. Stable. Neurons are long-lived.
  Primary consumer: Jiang, Alexander (strategy)
  Failure mode: gaps in knowledge. Neurons go stale at ~2% per month.

Brain.Index/             ← Operational intelligence. How to operate the system.
  Regions: file-map, change-sequences, onboarding, registries, timers
  Update cadence: fast. Neurons go stale whenever the file structure changes.
  Primary consumer: MarcusAurelius, Alexander (execution)
  Failure mode: staleness after structural moves. Worse than no index if not maintained.
```

They share the same neuron format (15 lines max, 7 pointers, rated). They do not share regions. They serve different agents in different modes.

---

## 4. BRAIN.INDEX STRUCTURE

### Proposed Regions

```
Brain.Index/
  _index.md                ← master entry point, maps all regions
  file-map/                ← where everything lives
    _index.md
    areas: claude-ai-root, bot-folders, brain, sessions, registries, config
    neurons: specific file locations, folder patterns
  change-sequences/        ← what to do when X changes
    _index.md
    areas: add-bot, rename-folder, move-to-obsidian, change-timer, update-layer-rules
    neurons: step sequences with cascading update maps
  onboarding/              ← how to initialize new agents and agent types
    _index.md
    areas: level4, level3, level2, external
    neurons: boot sequences, required files, registration steps
  registries/              ← intelligence about global registries (not the registries themselves)
    _index.md
    neurons: timer-registry patterns, spawner-registry patterns, when to update each
  timers/                  ← all active timers, their purpose, their status
    _index.md
    neurons: one per active timer (Terry, future Jiang subbot, etc.)
```

### Indexing Convention

A-Z by area name within each region. 1-100 numbering within each area for neuron files:
`neurons.file-map.claude-ai-root.A1.md`, `neurons.change-sequences.add-bot.A1.md`

Same neuron file format as Velorin_Brain. Same pointer system. Same protection layer on activation.

---

## 5. STALENESS — THE REAL RISK

Brain.Index is only useful if it accurately reflects the actual file structure. Every structural change that is not reflected in Brain.Index makes it worse than no index — agents that trust a stale map will navigate to wrong locations with high confidence.

**Mitigation: Pre-Commit Rule**

Before any commit that changes file locations, folder names, or registry entries:
1. Agent identifies which Brain.Index neurons are affected
2. Agent updates those neurons in the same commit
3. Commit message flags the Brain.Index update explicitly

This rule must be documented in Level4.General.Rules.md and each Level 4 agent's ReadMe. It is a cardinal rule — not optional.

Until this rule is enforced by habit or automation, the risk of stale neurons is real. Note for later: a Scribe variant could watch commits for structural changes and flag Brain.Index neurons that reference the changed path.

---

## 6. CONNECTION TO WINDOW GRAVITY

Jiang's Window Gravity research (92% confidence) documents that AI agents systematically optimize toward in-window solutions. Agents with an inaccurate or absent map of the system are maximally exposed to this bias — they default to what they know, not what is correct.

Brain.Index is a direct mitigation. An agent that can look up the correct path, the correct sequence, and the correct cascading updates does not need to infer from context. The map replaces guesswork.

This is also why Brain.Index must live in GitHub, not in any single agent's session context. A map that only one agent can see is not a system map.

---

## 7. LAYER INSTRUCTION SYSTEM REDO

**Problem statement:** The current layer system (Level 4, Level 3, Level 2) was built sequentially as the system grew. The rules governing each level live across multiple files — Level4.General.Rules.md, individual ReadMe.First files, STARTUP.md, CLAUDE.md, Company.Operating.Standards. When a rule changes, it must be hunted across all of these manually. There is no single authoritative source for "what governs agents at Level X."

The system also conflates:
- Identity rules (who you are)
- Behavioral rules (how you act)
- Operational rules (what sequence to follow)
- Permission rules (what you can do)
- Structural rules (how the system is organized)

These are different things. Mixing them in a single file makes targeted updates expensive and error-prone.

**What the redo requires:**
1. Audit all current instruction files — catalog every rule by type and by level
2. Design a clean layer schema: what lives at Level 4 General, what lives at individual ReadMe, what lives in Operating Standards, what goes nowhere because it is already handled by another mechanism
3. Eliminate redundancy — the same rule appearing in 3 files is a maintenance liability
4. Separate identity from operations — ReadMe.First should be identity and role, not operational procedures
5. Create a dedicated procedures file for each level (or shared) that covers boot sequence, session close, escalation paths, sub-agent creation
6. Re-point Brain.Index change-sequences neurons to the new structure

**Priority:** This redo should happen before the next major agent addition. Every new agent added to the current system inherits the debt. The redo does not need to happen before the Brain.Index build — but both should be sequenced in the same phase.

---

## 8. RECOMMENDED BUILD SEQUENCE

**Phase 1 — Document (this file):** Done.

**Phase 2 — Layer Audit (one session, MarcusAurelius):**
- Read all current instruction files
- Map every rule: what type, what level, where it lives, where else it lives
- Identify gaps and redundancies
- Deliver audit document to Chairman for review

**Phase 3 — Layer Schema Design (Alexander + Chairman):**
- Design the new structure based on audit
- Chairman approves before any rewrites begin

**Phase 4 — Brain.Index Build (MarcusAurelius):**
- Create Brain.Index/ folder structure
- Populate file-map region first (highest immediate value)
- Add change-sequences for the top 5 recurring operations
- Wire pointers from Velorin_Brain neurons that touch operational topics

**Phase 5 — Layer Redo (MarcusAurelius + Alexander):**
- Rewrite instruction files per approved schema
- Update Brain.Index change-sequences to reflect new file locations
- Test: boot each Level 4 agent, confirm correct behavior

---

*Brain.Index_And_Layer_Redo | ToBeBuilt | MarcusAurelius | March 30, 2026*

[VELORIN.EOF]
