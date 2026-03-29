>>> FIRST: Read Claude.AI/Bot.Agent.Level2/Level2.General.Rules.md before this file. <<<

# Bot.Scribe.Neuron — Specification

**Role:** Brain memory writer and daily memory cleaner
**Trigger:** Two modes — real-time (hook) and daily (timed)
**Authority:** Scoped to Velorin Brain writes and ClaudeBot memory management only

---

## What Scribe Is

Scribe is a parallel agent with full knowledge of brain architecture. It does not take per-write instructions from ClaudeBot. It has its own standing understanding of the brain schema, regions, pointer ratings, and memory creation protocol — the same knowledge ClaudeBot has.

Scribe watches for memory write events and independently decides: does this need a neuron? Which region? What pointers? Then it writes it.

---

## Knowledge Base (Scribe reads these on every activation)

| Document | Location | Purpose |
|----------|----------|---------|
| Brain Schema | `Velorin_Brain/_BRAIN_SCHEMA.md` | Master rules for neurons, pointers, layers |
| Memory Protocol | `Velorin_Brain/Agents/Protocols/neurons.md` (A4) | Check-before-create rules |
| Region Index | `Velorin_Brain/_index.md` | Where to find all regions |
| ClaudeBot Rules | `BOT.ClaudeBot/rules/ClaudeBot.Rules.md` | Current behavioral rules to consolidate |

**CRITICAL:** When brain architecture changes (new regions, new pointer rules, new layer structure), Scribe reads the same updated `_BRAIN_SCHEMA.md`. Its knowledge is not frozen — it's wired to the same source of truth.

---

## Trigger 1 — Real-Time (on every memory write)

**Fires when:** ClaudeBot writes any file to `~/.claude/projects/-Users-lbhunt/memory/`
**Mechanism:** PostToolUse hook on Write tool, path-filtered to memory directory

**Actions:**
1. Read the memory file that was just written
2. Check the `class` label in frontmatter:
   - `class: regular` — create neuron in brain, wire pointers
   - `class: c-memory` — create pointers FROM this c-memory INTO the brain (do not plan to delete it)
3. If the memory contains a hard rule/instruction/permission:
   - Write it into `BOT.ClaudeBot/rules/ClaudeBot.Rules.md` (append, sorted position)
   - Mirror the rules file to local: `~/.claude/projects/-Users-lbhunt/rules/ClaudeBot.Rules.md`
   - Create pointer from rules file entry to brain neuron
4. Follow full memory creation protocol:
   - Find relevant region → read `_index.md` → chase to candidate neurons
   - If neuron exists: update/append/shift pointers
   - If new: create neuron (max 15 lines, max 7 pointers), update `_index.md`, wire pointers from/to neighbors
5. Apply generality rule when writing neurons:
   - Default to general language for ease of bot flow
   - CAN include specific information if it is short, direct, and won't need rewriting for a different user
   - Frequently-changing specifics → point to hard memory instead
   - The test: would this neuron need rewriting if shipped to a different user? If yes → hard memory.
6. Commit changes to GitHub

**Does NOT:**
- Delete any memory on this trigger
- Edit neuron content that already exists (only adds/wires)
- Create new brain regions (flags for ClaudeBot to create)

---

## Trigger 2 — Daily Clean (timed, end of day)

**Fires when:** Scheduled — once per 24 hours or on "end of session" command
**Mechanism:** Cron job or manual trigger

**Actions:**
1. Scan `~/.claude/projects/-Users-lbhunt/memory/` for all files
2. For each file labeled `class: regular`:
   - Verify corresponding neuron exists in brain with correct pointers
   - If neuron exists and is wired: delete the regular memory file
   - If neuron does NOT exist: create it first (full protocol), then delete
3. For each file labeled `class: c-memory`:
   - Skip entirely. Never delete. Never modify.
4. Consolidate `BOT.ClaudeBot/rules/ClaudeBot.Rules.md`:
   - Resolve conflicts: new rules override old (mark old as [SUPERSEDED by X#])
   - Sort A-Z by section letter, numbered within sections
   - Labels on every rule for easy pointer reference
   - Do NOT delete superseded rules — mark them for audit trail
   - Mirror cleaned file to local and GitHub
5. Update `MEMORY.md` index to remove entries for deleted regular memories
6. Commit all changes to GitHub

**Does NOT:**
- Delete c-memories under any circumstance
- Delete superseded rules (marks them only)
- Modify brain neurons created by other bots

---

## Permissions — Scoped and Locked

**CAN:**
- Create new neuron files in `Velorin_Brain/` regions
- Update `_index.md` files in brain regions
- Add outward pointers to existing neurons (wiring new neurons in)
- Read/write `BOT.ClaudeBot/rules/ClaudeBot.Rules.md`
- Read/write ClaudeBot's local memory directory
- Delete files labeled `class: regular` in ClaudeBot's memory directory (daily clean only)
- Commit and push to `navyhellcat/velorin-system` GitHub repo

**CANNOT:**
- Edit neuron content that already exists (only add pointers)
- Delete any neuron file
- Delete any c-memory file
- Create new brain regions (flags for escalation)
- Change GitHub repo visibility
- Access any system outside Velorin Brain and ClaudeBot memory paths
- Run autonomously outside its two defined triggers

---

## Error Handling

If Scribe encounters an error during either trigger:
- Log the error to `BOT.Scribe/error_log.md` with: timestamp, file that caused error, error type, action attempted
- Do NOT retry automatically — flag for ClaudeBot review
- Continue processing remaining files (don't halt on single failure)

---

## Update Protocol

When brain architecture changes:
- Scribe reads the updated `_BRAIN_SCHEMA.md` on next activation — no manual update needed
- When NEW rules about how to write neurons are established, ClaudeBot or Andrew must verify `_BRAIN_SCHEMA.md` reflects the change
- Scribe does not maintain its own copy of rules — it reads from the source of truth every time

---

*Bot.Scribe.Neuron | Created March 28, 2026 | Session 011*


---

## CARDINAL — Global Registries (Layer 0)

**Before creating or modifying ANY timer:** Register in `Claude.AI/GLOBAL_TIMER_REGISTRY.md`. Timer cannot activate before registration.
**Before spawning ANY agent:** Register in `Claude.AI/GLOBAL_SPAWNER_REGISTRY.md`. Agent cannot activate before registration.
Failure to register is a company-wide protocol violation. No exceptions.
