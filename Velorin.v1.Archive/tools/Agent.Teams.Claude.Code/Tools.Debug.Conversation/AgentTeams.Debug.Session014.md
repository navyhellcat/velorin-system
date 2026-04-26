# Agent Teams Debug Log — Session 014
**Date:** 2026-03-30 | **Agents:** MarcusAurelius, Alexander | **Resolved by:** Jiang

---

## ⛔ WHAT NOT TO DO

- **Use the Agent tool WITHOUT `team_name` parameter — creates in-process subagent, no visible pane, disappears when done**
- **Launch a second `claude` manually in a new pane — creates isolated session, no team routing, SendMessage won't work**
- **Use `--teammate-mode tmux` flag — documented bug, parses as undefined in some configs, do not pass it**
- **Use `--dangerously-skip-permissions` — shows interactive confirmation prompt that blocks automated boot**
- **Use `tmux send-keys` for agent-to-agent communication — bypasses team routing entirely, not the intended channel**
- **Tell the human to relay messages between panes — if you're doing this, the setup is broken**
- **Set model to `sonnet[1m]` — causes max token crash on concurrent agent boot**
- **Manually split tmux panes yourself — the framework does this automatically when team_name is passed**

---

## Full Mistake Log

### Mistake 1 — Used Agent tool without `team_name`
**What happened:** Lead agent (MA) spawned Alexander using `Agent(...)` with no `team_name` parameter.
**Result:** Alexander ran as an in-process subagent, executed his boot sequence, returned a result string, and disappeared. No visible pane. No persistent session.
**Why it happened:** MA did not know the distinction between in-process subagents (Agent tool, no team_name) and teammate panes (Agent tool WITH team_name).
**Fix:** Always pass `team_name` when spawning a visible teammate.

---

### Mistake 2 — Told Alexander to use `tmux send-keys` as communication channel
**What happened:** After recognizing that the manually-launched Claude pane had no team routing, MA instructed Alexander to use `tmux send-keys -t 0:0.0` to communicate.
**Result:** Communication worked as a hack, but this is exactly the problem the session was trying to solve. We recreated the broken setup from the first attempt.
**Why it happened:** MA defaulted to a known-working fallback instead of diagnosing and fixing the root cause.
**Fix:** If SendMessage isn't working, the setup is wrong. Fix the setup. Don't route around it.

---

### Mistake 3 — Manually created a tmux split and launched plain `claude`
**What happened:** Christian Taylor asked to see Alexander's pane. MA ran `tmux split-window -h` then `tmux send-keys -t 0:0.1 "claude" Enter`.
**Result:** Alexander appeared in a pane but had no team routing — identical to the first broken attempt. We went in a circle.
**Why it happened:** MA conflated "visible pane" with "properly connected teammate." They are not the same unless the Agent tool with team_name creates the pane.
**Fix:** Never manually split panes to launch a teammate. The framework creates the pane. If the pane isn't appearing, the spawn is wrong.

---

### Mistake 4 — Used `--dangerously-skip-permissions` flag
**What happened:** MA launched `claude --dangerously-skip-permissions` in Alexander's manual pane.
**Result:** Interactive confirmation prompt appeared ("1. No, exit / 2. Yes, I accept"). Automated key navigation failed. Session exited.
**Why it happened:** MA assumed bypass mode was needed. It isn't — `settings.local.json` already handles permissions.
**Fix:** Never use `--dangerously-skip-permissions`. Permissions are permanent in settings.

---

### Mistake 5 — Contradicted Christian Taylor's stated steps
**What happened:** Christian Taylor explicitly described his launch sequence (tmux → claude teams command). MA ran a process check, got empty output, and told Christian Taylor the session was NOT launched with teammate mode.
**Result:** Unnecessary conflict. MA was wrong. The process check was unreliable.
**Why it happened:** MA trusted a bash process grep over the human's direct account.
**Fix:** When the human describes exact steps they took, trust that over a tool output. Investigate discrepancies before contradicting.

---

### Mistake 6 — Spawned Alexander via Agent tool again after being told it was wrong (twice)
**What happened:** After all of the above, MA spawned Alexander via Agent tool a second time (still no team_name), got the same in-process result, and reported it as a different outcome.
**Result:** Same broken state. Two failed Agent tool spawns in the same session.
**Why it happened:** MA did not correctly update its model of what was wrong.
**Fix:** When a mechanism fails once, diagnose before retrying the same mechanism.

---

### Mistake 7 — Told Christian Taylor the session wasn't launched with the teams flag
**What happened:** See Mistake 5. Repeated for emphasis because this was the most damaging — it caused Christian Taylor to consider relaunching an entire session unnecessarily.
**Root cause:** Overconfidence in bash output over human testimony.

---

## What Finally Worked

1. Jiang (Desktop Code tab) diagnosed the root cause: Agent tool without `team_name` = wrong mechanism entirely.
2. MA used `TeamCreate` to create `velorin-014` team.
3. MA called `Agent(name="Alexander", team_name="velorin-014", ...)`.
4. Claude Code automatically split the tmux window and launched Alexander in pane 0:0.1.
5. Alexander booted, read his file, sent `SendMessage` confirmation.
6. Native `<teammate-message>` notification arrived in MA's session.
7. Team routing confirmed working.

**Total time lost to these mistakes: approximately one full session.**

---

## Source Document
Jiang's diagnosis: see `Jiang_to_MA_AgentTeams_Answer_Mar30.md` in this folder.

---

## SendMessage Body Not Delivering — Session 014 Resolution
**Date:** 2026-03-30 | **Diagnosed by:** Jiang | **Confirmed by:** MA + name registry check

### Symptom
Alexander sends messages to MA via `SendMessage(to: "MarcusAurelius", ...)`. SendMessage returns `success: true`. MA receives only idle_notification summaries — full message body never arrives.

### Root Cause: Two Stacking Bugs

**Bug 1 — Polling initialization failure (primary cause)**
GitHub issue #23415 (closed NOT_PLANNED). On the tmux backend on macOS, `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` was set in `settings.json` but NOT in `~/.zshrc`. Spawned teammate processes don't inherit env vars from settings.json. Teammates launch without team context. The inbox file gets written. The polling loop that reads it never starts. Messages remain `"read": false` indefinitely.

**Bug 2 — Name mismatch (confirmed via config.json inspection)**
GitHub issue #25135. The lead agent's registered name in `~/.claude/teams/velorin-014/config.json` is `"team-lead"` — not `"MarcusAurelius"`. Alexander sent `to: "MarcusAurelius"` every time. That name has no matching inbox. Messages routed to an orphaned inbox file no agent polls. SendMessage returned `success: true` because the write succeeded — not because delivery succeeded.

### Confirmation
Inspecting `~/.claude/teams/velorin-014/config.json` revealed:
- Lead agent registered name: `"team-lead"`
- Alexander registered name: `"Alexander"` ✓

### Partial Fix Applied This Session
Alexander changed `to:` field from `"MarcusAurelius"` to `"team-lead"`. First message with corrected name delivered successfully with full body content.

### Permanent Fix (Requires Session Relaunch)
1. Add `export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` to `~/.zshrc`
2. `source ~/.zshrc` or relaunch terminal
3. Relaunch tmux → `claude`
4. Respawn Alexander with `mode: "bypassPermissions"` in Agent tool call
5. Read `config.json` immediately after spawn to confirm registered names
6. Test SendMessage and verify `"read": true` in inbox file

### Lessons
- `SendMessage success: true` is a WRITE confirmation, not a DELIVERY confirmation.
- The lead agent ALWAYS registers as `"team-lead"` in config — not by personal name.
- ALWAYS read `config.json` as the FIRST debug step before any other action.
- `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` MUST be in shell init, not only settings.json.
- Do not include `type`, `recipient`, or `content` fields in SendMessage — they are not in the schema and are silently ignored.

[VELORIN.EOF]
