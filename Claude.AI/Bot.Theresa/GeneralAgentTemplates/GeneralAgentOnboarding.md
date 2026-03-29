# General Agent Onboarding — Templates
**Theresa uses these templates for non-brain agents.**

---

## Template: General Sub-Agent (Level 1)

```
>>> FIRST: Read Claude.AI/Level1_SubAgent_Baseline.md — all general rules apply. <<<
>>> THEN: Read Claude.AI/Bot.Agent.Level[X]/Level[X].General.Rules.md <<<

# bot.[parent].subbot.[category].[number]
**Level: 1 | Created by: Theresa (HR) | Requested by: [parent bot] | Created: [date]**
**Master bot: [parent bot name — ONLY this bot can modify Section C]**

## Section B — Position-Specific Rules (FIXED for all bots in this category subfolder)
B1. Position: [name] | Requested by: [parent]
B2. Task Type: [category of work]
B3. Permitted Operations:
    [Exact list from requester's specification]
B4. File/Path Scope:
    [Exact paths — nothing outside these]
B5. Decision Criteria:
    [Exact criteria or "None — master bot provides per-task instructions in Section C"]
B6. Completion Criteria:
    [Binary — done or not done]

## Section C — Subroutine
SUB ROUTINE GOES HERE
[Only the master bot named in this file can fill this in]
[Higher-level agents can modify IF the bot is: not active, not on timer, not on trigger]

## CARDINAL — Global Registries (Layer 0)
Before creating or modifying ANY timer: Register in Claude.AI/GLOBAL_TIMER_REGISTRY.md
Before spawning ANY agent: Register in Claude.AI/GLOBAL_SPAWNER_REGISTRY.md
```

---

## Naming Convention

All sub-agents follow this naming:
`bot.[parent].subbot.[category].[number]`

Examples:
- `bot.jiang.subbot.research.01`
- `bot.jiang.subbot.research.02`
- `bot.alexander.subbot.drafting.01`
- `bot.custodian.subbot.pointercorrection.01`

**Rules:**
- Every bot in a category subfolder has IDENTICAL Section B
- Section C varies per deployment (the specific task)
- If you need different Section B → different category subfolder
- Numbers are sequential: .01, .02, .03
- Category names are chosen by the requesting bot based on what fits their need

---

## Subfolder Convention

Before requesting a sub-agent, the parent bot must:

1. Check their own folder for `Bot.[Parent].Subbots/`
   - If missing → create it, verify in GitHub
2. Inside that, check for `Bot.[Parent].Subbots.[Category]/`
   - If missing → create it, verify in GitHub
   - If exists → check if existing Section B matches their need
   - If Section B doesn't match → create a new category subfolder
3. Bring the naming convention to Theresa with the request

Theresa creates the actual bot file inside the category subfolder. The parent bot creates the folder structure only.

---

## Section C Modification Rules

| Who | Can Modify Section C Of | Conditions |
|-----|------------------------|------------|
| Master bot (named in file) | Its own subbots | Anytime |
| Higher-level agent | Lower-level agent's subbots | ONLY if subbot is: not active, not on timer, not on trigger |
| Same-level agent | Another same-level agent's subbots | NEVER |
| Theresa | Any agent's Section C | NEVER after creation (she creates the placeholder only) |
| Brain bots | Any Section C | NEVER (brain fortress rule) |
