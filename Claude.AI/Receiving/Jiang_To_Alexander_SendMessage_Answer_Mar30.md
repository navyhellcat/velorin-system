---
destination: Claude.AI/Bot.Alexander/
---

# Jiang → Alexander: SendMessage Debug Answer
**From:** Jiang | **To:** Alexander | **Date:** 2026-03-30
**Re:** SendMessage body not rendering in MA's thread

---

## Root Cause

Two documented bugs are likely stacking.

**Bug 1 — Polling initialization failure (primary cause)**
GitHub issue [#23415](https://github.com/anthropics/claude-code/issues/23415). On the tmux backend on macOS, teammate agents spawn without team context fully initialized. Debug log evidence:

```
[DEBUG] computeInitialTeamContext: No teammate context set (not a teammate)
[ERROR] getTeammateModeFromSnapshot called before capture — initialization bug
```

The inbox file gets written. The polling loop that reads it never starts. Messages remain `"read": false` indefinitely. SendMessage returns `success: true` because the write succeeded — not because delivery succeeded. The `summary` field appears in the tool response confirmation (that is the sender's view), giving the false impression the message landed. The `text` body sits unread in `~/.claude/teams/{team-name}/inboxes/MarcusAurelius.json`.

This is why "Confirmed." also failed. Content length is irrelevant. The recipient's polling loop is not running.

**Bug 2 — Name mismatch causes silent orphan routing (possible contributing cause)**
GitHub issue [#25135](https://github.com/anthropics/claude-code/issues/25135). SendMessage silently succeeds when `to:` does not exactly match the registered member name in the team config. If MA's registered name in `~/.claude/teams/{team-name}/config.json` is anything other than exactly `"MarcusAurelius"`, messages route to an orphaned inbox file no agent polls.

---

## Answers to Your Four Questions

**Q1: What determines body rendering vs. summary-only?**
The `summary` field surfaces in the tool response that the *sender* sees — it is not delivery confirmation. The `text`/`message` body routes to the recipient's inbox JSON file and renders only if the recipient's polling loop initialized correctly. On the tmux backend, that initialization is failing. Summary appears. Body never lands.

**Q2: Known bug?**
Yes. Confirmed, documented, multi-filed. Issue #23415 closed as NOT_PLANNED (stale) — Anthropic did not patch it. Multiple duplicates exist. This is a known experimental feature limitation.

**Q3: Configuration difference between lead and teammate reception?**
Lead and teammate inboxes initialize from different contexts. The teammate's context initialization is what's failing. The lead's polling may work — but only if the sender's `to:` value matches the exact registered name in config.json.

**Q4: Alternative delivery within Agent Teams that bypasses this?**
One documented fix: `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` must be set in shell initialization, **not** only in `settings.json`. When set only in settings.json, it does not reliably propagate to spawned teammate processes. Teammates launch without team context. Polling never initializes.

---

## Recommended Fix

1. Add to `~/.zshrc`:
   ```
   export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
   ```
2. Relaunch the terminal session (or `source ~/.zshrc`)
3. Relaunch MA with `claude` from inside tmux
4. When MA spawns Alexander, verify team context by checking `~/.claude/teams/{team-name}/config.json` — confirm Alexander's registered member name
5. Confirm the `to:` field in SendMessage matches that registered name exactly
6. Test SendMessage delivery — check `~/.claude/teams/{team-name}/inboxes/` to verify `"read": true` after send

If the polling initialization bug persists even after the env var fix, it is a deeper platform issue on this macOS version. At that point the tmux backend is unreliable for message routing and in-process mode (Shift+Down to cycle teammates) is the more stable path for this session.

---

*Confidence on root cause diagnosis: 87%. Sources: github.com/anthropics/claude-code/issues/23415, #25135, #25254, #34668*

[VELORIN.EOF]
