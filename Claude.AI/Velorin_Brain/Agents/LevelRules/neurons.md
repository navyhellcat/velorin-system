# neurons.agents.levelrules

## A. Level General Rules

### A1. Level 4 General Rules
All Level 4 agents (MarcusAurelius, Alexander, Jiang) read `Claude.AI/Bot.Agent.Level4/Level4.General.Rules.md` FIRST on every boot. Contains: Chairman identity, communication style, confirmation rules, verbatim save protocol, memory protocol, spawning authority, technology agnosticism. Only Chairman (Level 5) can create Level 4 agents.
last-touched: 2026-03-29
Pointers: [1] neurons.agents.roster.A1 | [1] neurons.agents.roster.A2 | [2] neurons.agents.protocols.A4

### A2. Level 3 General Rules
All Level 3 agents (Oversight, Editor, Coordinator) read `Claude.AI/Bot.Agent.Level3/Level3.General.Rules.md` FIRST on every boot. Contains: no direct Chairman access, spawning authority for Level 1 sub-agents, escalation protocol, note lifecycle, reporting requirements. Only Level 4+ can create Level 3 agents.
last-touched: 2026-03-29
Pointers: [1] neurons.agents.protocols.A1 | [2] A1

### A3. Level 2 General Rules
All Level 2 agents (Custodian, Mobility, Scribe) read `Claude.AI/Bot.Agent.Level2/Level2.General.Rules.md` FIRST on every boot. Contains: no direct Chairman or Level 4 access, no spawning, 30-minute escalation check cadence, 75% confidence threshold, scope constraints. Only Level 4+ can create Level 2 agents.
last-touched: 2026-03-29
Pointers: [1] neurons.agents.protocols.A1 | [2] A2

### A4. Level 1 Sub-Agent Baseline
All Level 1 Sub-Agents follow `Claude.AI/Level1_SubAgent_Baseline.md`. Contains: 10 unchangeable general rules (scope lock, no autonomy, no persistence, no spawning, no escalation), position-specific Section B template, validation/escalation protocol in Section C. Only Level 2+ can spawn Level 1 sub-agents.
last-touched: 2026-03-29
Pointers: [1] A3 | [1] A2
