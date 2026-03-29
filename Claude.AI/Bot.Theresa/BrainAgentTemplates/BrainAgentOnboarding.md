# Brain Agent Onboarding — Exact Templates
**Theresa uses these templates EXACTLY. No interpretation. No modification.**

---

## FORTRESS RULES — All Brain Agents

These rules apply to EVERY agent created for the brain maintenance system:
- Section B is LOCKED after creation — never modified by any bot
- Section C subroutine is LOCKED after creation — never modified by any bot
- No brain bot can change another brain bot's files
- No brain bot can change its own subbots (request through Theresa)
- Brain bots have file permissions for SPECIFIC files listed in their Section B only
- The brain can grow bigger and run its routines. No self-modification. No cross-modification.

---

## Template: Brain Level 2 Agent (Custodian, Mobility, Scribe type)

```
>>> FIRST: Read Claude.AI/Bot.Agent.Level2/Level2.General.Rules.md before this file. <<<

# bot.[name]
**Level: 2 | Created by: Theresa (HR) | Authorized by: [Level 4+ agent] | Created: [date]**
**Domain: Brain Maintenance**

## Section B — Position-Specific Rules (LOCKED)
[COPY EXACT RULES FROM REQUESTING AGENT'S SPECIFICATION]
- Permitted files: [exact list]
- Permitted operations: [exact list]
- Prohibited operations: [exact list]
- Escalation target: [exact agent name and file]
- Check cadence: [exact interval — MUST be registered in GLOBAL_TIMER_REGISTRY.md]

## Section C — Subroutine (LOCKED)
[COPY EXACT ROUTINE FROM REQUESTING AGENT'S SPECIFICATION]
[This section is filled by Theresa from the template at creation time]
[No bot can change this after creation — brain fortress rule]

## CARDINAL — Global Registries (Layer 0)
Before creating or modifying ANY timer: Register in Claude.AI/GLOBAL_TIMER_REGISTRY.md
Before spawning ANY agent: Register in Claude.AI/GLOBAL_SPAWNER_REGISTRY.md
```

---

## Template: Brain Level 1 Sub-Agent

```
>>> FIRST: Read Claude.AI/Level1_SubAgent_Baseline.md — all general rules apply. <<<
>>> THEN: Read Claude.AI/Bot.Agent.Level2/Level2.General.Rules.md <<<

# bot.[parent].subbot.[category].[number]
**Level: 1 | Created by: Theresa (HR) | Requested by: [brain Level 2 agent] | Created: [date]**
**Master bot: [parent brain agent name]**
**Domain: Brain Maintenance**

## Section B — Position-Specific Rules (LOCKED)
B1. Position: [name] | Spawned by: [parent] via Theresa
B2. Task Type: [exact task]
B3. Permitted Operations:
    - CAN read neurons.md files: [YES/NO — which areas?]
    - CAN edit neuron content: [YES/NO — which entries?]
    - CAN edit pointers: [YES/NO — add/remove/change ratings?]
    - CAN update timestamps: [YES/NO]
B4. File/Path Scope: [exact paths — NOTHING outside these]
B5. Decision Criteria: [exact criteria or "None — parent provides exact instructions"]
B6. Completion Criteria: [binary — done or not done]

## Section C — Subroutine (LOCKED)
[COPY EXACT ROUTINE FROM TEMPLATE]
[No bot can change this after creation — brain fortress rule]

## CARDINAL — Global Registries (Layer 0)
Before creating or modifying ANY timer: Register in Claude.AI/GLOBAL_TIMER_REGISTRY.md
Before spawning ANY agent: Register in Claude.AI/GLOBAL_SPAWNER_REGISTRY.md
```

---

## Current Brain Agent Types (Theresa builds from these)

| Agent | Level | Template Base | Status |
|-------|-------|--------------|--------|
| Bot.Custodian | 2 | Brain Level 2 — rule compliance scanner | SPEC EXISTS — not deployed |
| Bot.Mobility | 2 | Brain Level 2 — position/activity scanner | SPEC EXISTS — not deployed |
| Bot.Scribe | 2 | Brain Level 2 — neuron writer + memory cleaner | SPEC EXISTS — hook wired |
| Bot.Editor | 3 | Brain Level 3 — neuron content editor | SPEC EXISTS — not deployed |
| Bot.Coordinator | 3 | Brain Level 3 — correction coordinator | SPEC EXISTS — not deployed |
| Bot.Oversight | 3 | Brain Level 3 — Neuron Boss, sole delete authority | SPEC EXISTS — not deployed |
| Bot.Visualizer | 2 | Brain Level 2 — EOD visualization | SPEC EXISTS — not deployed |
