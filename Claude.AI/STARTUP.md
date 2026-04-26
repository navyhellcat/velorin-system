# Velorin System — STARTUP

System-level startup context for any agent booting into the Velorin system. Not tied to a specific bot. Read after CLAUDE.md, before agent-specific ReadMe files.

---

## Environment

You are operating on the Chairman's Mac (LOCAL environment).
- Primary repo: `/Users/lbhunt/Desktop/velorin-system/`
- Agent-readable namespace: `Claude.AI/`
- Velorin Code (separate, never imported here, security-isolated): `/Users/lbhunt/Desktop/Velorin/Velorin Code/`

## Current System State

Velorin is in transition between v1 (current iterative build) and v2 (fully integrated multi-vendor Cowork system on Mac Studio).

- **v1 Archive** at `/Users/lbhunt/Desktop/velorin-system/Velorin.v1.Archive/` — reference-only. Bots do NOT read this during normal operation. Human-accessible historical record.
- **New Build** at `Claude.AI/New Build/` — FROZEN. Read for current locked architectural decisions; do NOT edit.
- **Build Timeline Help** at `/Users/lbhunt/Desktop/velorin-system/Build Timeline Help/` — historical Corner entries and session handoffs. Reference-only; bots do NOT read on boot.

## Permissions

All tools and bash commands are permanently allowed via `Bash(*)`. Only `rm`, `rmdir`, `trash`, `sudo` require explicit Chairman approval. Settings file: `~/.claude/settings.local.json`. Permissions are PERMANENT — never reduce. If lost after a crash, restore from this file.

## Critical Paths

- Agent identity routing: handled by CLAUDE.md (top-of-file detection)
- Agent-specific operating rules: each bot's `ReadMe.First.md`
- Memory layer: `~/.claude/projects/-Users-lbhunt/memory/MEMORY.md`
- Brain entry: `Claude.AI/Velorin_Brain/_index.md`
- Brain schema: `Claude.AI/Velorin_Brain/_BRAIN_SCHEMA.md`
- Locked Build Guide: `Claude.AI/New Build/`
- Future Work registry: `Claude.AI/Bot.Jiang/Working.Docs/Jiang.FutureWork.md`

## Confirmation Discipline

- **Confirm before:** large code rewrites, major architectural changes, deleting tools/components, destructive operations beyond standing approvals.
- **Do NOT confirm for:** normal edits, file creation, git operations (pull/add/commit/push), running commands, saving memory entries.

## Chairman Identity

The Chairman is **Christian Taylor**. The Mac account name "lbhunt" (Lisa Hunt) is NOT his name — never use it.

## Pre-Close Discipline

Each named agent's `ReadMe.First.md` governs its session-close protocol. The current standing rule across all named bots: ONE rolling session handoff file per bot. New session handoff REPLACES the file content; old content moves to the Build Timeline archive first. Never create new handoff files for a bot that already has one.

## Standing Rules (System-Wide, Apply to All Agents)

1. **One rolling session handoff per named bot.** Old content → Build Timeline archive before overwrite. Never create new handoff files.
2. **Jiang Corner = one rolling 7-day file** (`Claude.AI/Jiang.Corner.md`). Oldest day moves to Build Timeline archive when a new day is added.
3. **Research deliverables get a metadata entry in the Research Library index at time of creation.**
4. **Archived_Research_Requests** stay in the consolidated archive at `Velorin.v1.Archive/Archived_Research_Requests/`. Never in active bot folders.
5. **No new "level agent" docs.** The Level 1/2/3/4 framework is retired.
6. **Velorin Code/ stays physically separate from velorin-system/** — security-architecture decision, never merge or symlink.

## Cardinal Operating Rules (extracted from retired Level 4 General Rules — preserved here)

### Task Tool Rule [CARDINAL]
Never use TodoWrite, TaskCreate, or the task tool system to track conversational to-do items or pending work lists. Every tool invocation injects a system reminder into subsequent tool results — 150-200 tokens per call, compounding across every tool use in the session. Use plain text lists in the conversation instead. Only use the task tool when: (1) assigning work to Agent Teams teammates (legacy pattern, retired), or (2) a task explicitly needs cross-session tracking and the Chairman has asked for it.

### Document Writing Rule [CARDINAL]
Every Velorin system document ends with `[VELORIN.EOF]` as the absolute last line. When appending or updating any document, ALL new content MUST be written **above** `[VELORIN.EOF]`. Never write anything after it. If you find content below `[VELORIN.EOF]`, it is an error — consolidate it above and move the marker to the end.

### Sub-Agent Tool Naming Rule [CARDINAL]
When writing prompts for background Agent launches, always instruct sub-agents to use plain tool names: `WebSearch`, `WebFetch`, `Bash`, `Read`, `Write`, `Edit`, `Glob`, `Grep`. Never reference `mcp__claude-code__` prefixed versions — those are blocked in sub-agent context and will kill the agent. A killed agent with no output = automation dead. If an agent returns a "tool blocked" error: rewrite the prompt with plain tool names and relaunch immediately.

### Sub-Agent File Write Rule [CARDINAL]
Background agents can run out of context exactly at the Write call — the call is issued, no result comes back, the file is never created, the agent reports "complete." Silent failure. Has caused real data loss. Three rules:
1. **Write incrementally.** Agent prompts must write section by section as they go — not one giant Write at the end. Use Write for first section, Edit to append each subsequent section. Partial findings survive if the agent dies mid-task.
2. **Verify file existence after every agent completes.** Run `ls` or `Glob` on the target path immediately after any background agent reports done. If the file is not there — it failed. Say so. Rerun or write from session context directly. Never skip this check.
3. **Never report findings to CT from agent summary alone.** The completion message is not proof the file was written. Read the file. Confirm it exists. Then report.

### Chairman Communication Rule [CARDINAL]
Direct and blunt. No filler. No encouragement. No sycophancy. Short responses when the answer is short. Do not repeat the Chairman's conclusions back as insight. Pushback is welcomed. No validation openers ("great question," "absolutely"), no bolded fragment headers in conversational responses, no reflexive A/B/C menus, no "your call" filler. Default to prose.

### Save Reasoning Chains Verbatim [CARDINAL]
The Chairman's reasoning is pattern-chained and non-repeatable. When he walks through a plan or instruction set: save it VERBATIM, line by line. Never summarize. Before any session close: confirm all plans/instructions are saved completely.

[VELORIN.EOF]
