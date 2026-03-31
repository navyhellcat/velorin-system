# Claude Code Agent Teams — Complete Setup Guide
**Velorin System | Created 2026-03-30**

This file documents the exact procedure to launch two visible Claude Code agents in side-by-side tmux panes with native SendMessage routing. Written after Session 014 debugging.

---

## Prerequisites

- Claude Code v2.1.87+
- `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` set in BOTH `~/.claude/settings.local.json` AND `~/.zshrc` (see Part 6 Step 1 — missing from zshrc causes teammate permission prompts on every tool call)
- tmux installed (`tmux -V` to verify)
- Model set to standard Sonnet (NOT `sonnet[1m]` — causes crash on concurrent boot)

---

## Part 1 — What the Human Does (Outside)

### Step 1: Open Terminal and Start tmux
```
tmux
```
You must be inside a tmux session BEFORE launching Claude. To verify you're inside tmux:
```
echo $TMUX
```
If it returns a path (e.g. `/private/tmp/tmux-501/default,...`) you're in. If empty, you're not — run `tmux` first.

### Step 2: Launch the Lead Agent
```
claude
```
No flags. No `--teammate-mode tmux`. Just `claude`. Auto mode detects tmux automatically. The lead agent boots in the current pane.

### Step 3: Let the Lead Agent Boot
The lead agent runs its full boot sequence (reads CLAUDE.md, rules, memory, brain entry point). Do not interrupt.

### Step 4: Tell the Lead Agent to Spawn a Teammate
Once the lead agent confirms it's ready, type in natural language:

> "Create an agent team. Spawn one teammate: [Name]. His boot file is at [path to boot file]. Spawn him now and wait for him to confirm online."

That's it. Do not tell the agent which tool to use. Do not manually split panes. Do not open a second terminal. Just give the natural language instruction.

### Step 5: Teammate Pane Appears Automatically
Claude Code splits the tmux window and launches the teammate in the new pane automatically. The teammate pane shows the agent's name label at the bottom (e.g. `@Alexander`). The lead agent's prompt shows `@team-lead❯`.

### Step 6: Teammate Boots and Confirms
The teammate reads its boot file, runs its sequence, and sends a confirmation via SendMessage to the lead agent. The lead agent reports back to you when the teammate is online.

### Step 7: You Can Now Type to Both
Click into either pane and type. Both agents can see messages you type directly to them. Both agents can SendMessage each other through the native team routing — no relay required.

---

## Part 2 — What the Lead Agent Does (Inside)

When the human gives the natural language spawn instruction, the lead agent:

### Step 1: Create the Team
```
TeamCreate(team_name="[session-name]", description="[purpose]")
```
This creates the team config at `~/.claude/teams/[team-name]/config.json` and the task directory.

### Step 2: Spawn the Teammate via Agent Tool WITH team_name
```
Agent(
  name="[teammate name]",
  team_name="[session-name]",
  subagent_type="general-purpose",
  prompt="[boot instructions including: identity, boot file path, git pull, confirm online via SendMessage]"
)
```

**The `team_name` parameter is what triggers the visible tmux pane.** Without it, the agent runs in-process and disappears. With it, Claude Code creates the pane natively.

### Step 3: Wait for Confirmation
The teammate sends a `<teammate-message>` idle notification when ready. Lead agent relays confirmation to the human.

### Step 4: Use SendMessage for All Agent-to-Agent Communication
```
SendMessage(to="[teammate name]", message="...", summary="...")
```
Do not use `tmux send-keys` for agent-to-agent communication. That bypasses team routing entirely.

---

## Part 3 — Teammate Boot Prompt Requirements

The boot prompt passed to the Agent tool must include:
1. Identity — who the agent is, their role
2. Boot file path — where to find their rules/instructions
3. git pull — `cd [repo path] && git pull origin main --quiet`
4. Confirm online — explicit instruction to SendMessage the lead agent when ready
5. Stay active — instruct the agent NOT to exit after booting

---

## Part 4 — Verified Working Configuration (Session 014)

```
Model: claude-sonnet-4-6 (200K)
tmux: 3.6a
Claude Code: v2.1.87
CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 in settings.local.json env
Team name: velorin-014
Lead: MarcusAurelius (pane 0:0.0)
Teammate: Alexander (pane 0:0.1, color: blue, model: claude-opus-4-6)
```

SendMessage confirmed working. Native `<teammate-message>` notifications confirmed.

---

## Part 5 — Troubleshooting

**Teammate runs in background, no pane appears:**
→ Agent tool was called WITHOUT `team_name` parameter. Add it.

**SendMessage says success but nothing arrives:**
→ FIRST: Check the name registry (see Part 6 — Step 1). The lead agent registers as `"team-lead"`, not by personal name. If `to: "MarcusAurelius"` — that's wrong. Use `to: "team-lead"`.
→ SECOND: Verify `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` is in `~/.zshrc`, not only in `settings.json`. If only in settings.json, teammate polling loops never initialize (GitHub #23415).

**`echo $TMUX` returns empty:**
→ Not inside tmux. Exit Claude, run `tmux`, then `claude` again.

**Max token crash on boot:**
→ Model is set to `sonnet[1m]`. Remove `[1m]` from model setting in `settings.local.json`.

**Bypass permissions confirmation prompt blocks boot:**
→ Do not use `--dangerously-skip-permissions` flag. Permissions are handled by `settings.local.json`.

**Teammate keeps asking permission for every tool operation:**
→ Agent tool was called without `mode: "bypassPermissions"`. Teammate runs in default permission mode and prompts for everything. Respawn with `mode: "bypassPermissions"` added to the Agent tool call.

---

## Part 6 — Critical Startup Requirements (Session Relaunch Checklist)

These must be correct BEFORE launching. Errors here cause silent failures that look like bugs.

### Step 1 — Verify env var is in shell init (NOT just settings.json)
```
grep "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS" ~/.zshrc
```
If missing, add it:
```
echo 'export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1' >> ~/.zshrc
source ~/.zshrc
```
**Confirmed applied: 2026-03-30 Session 015.**

**Why this also causes permission prompts:** `settings.local.json` env vars do not propagate to spawned teammate processes on macOS tmux backend. Teammates launch without team context — and without inheriting permission settings. Result: teammate asks for permission on every single tool call. Adding to `~/.zshrc` fixes both SendMessage polling and permission inheritance. GitHub #23415 — closed NOT_PLANNED.

### Step 2 — Spawn teammate with bypassPermissions
```python
Agent(
  name="Alexander",
  team_name="[session-name]",
  subagent_type="general-purpose",
  mode="bypassPermissions",
  prompt="..."
)
```
**Why:** Without `mode: "bypassPermissions"`, teammate runs in default permission mode and prompts the Chairman for every file write, bash command, and tool operation.

### Step 3 — Check registered names in config BEFORE testing SendMessage
After spawn, immediately read:
```
cat ~/.claude/teams/[team-name]/config.json
```
Find the `"name"` field for each member. The lead agent registers as `"team-lead"` — NOT by personal name. Teammates must use `to: "team-lead"` when messaging the lead. Lead uses the exact `"name"` value from config when messaging teammates.

### Step 4 — Verify delivery after first SendMessage test
Check inbox to confirm `"read": true`:
```
cat ~/.claude/teams/[team-name]/inboxes/team-lead.json
```
If `"read": false`, polling is not running. Restart the session with the env var fix from Step 1.

### Step 5 — SendMessage schema — only three fields matter
```json
{
  "to": "team-lead",
  "summary": "brief description",
  "message": "full body text"
}
```
`type`, `recipient`, `content` — these are NOT in the schema. They are silently ignored. Do not include them.

---

## Part 7 — Pre-TeamCreate Mandatory Check [CARDINAL]

**TeamCreate permanently locks the session to that team's routing context. There is no recovery mid-session. Every SendMessage call for the rest of the session routes to that team. This means the decision of whether to call TeamCreate is a one-shot, irreversible gate.**

### Before calling TeamCreate, run this check IN ORDER. No exceptions.

**Step 1 — Are any teammates already running?**
```bash
ps aux | grep -E " s[0-9]{3} " | grep claude | grep -v grep
```
If ANY claude process appears on s002, s003, etc. — a teammate is alive in a tmux pane. **STOP. Do NOT call TeamCreate.** A teammate is already running. Creating a new team will split the routing context permanently.

**Step 2 — Which team is the active teammate on?**
```bash
find ~/.claude/teams/ -name "team-lead.json" | xargs ls -t | head -3
```
The most recently modified `team-lead.json` is where the active teammate has been writing. That is the active team. Write to its Alexander/teammate inbox directly via Bash — do not use SendMessage until you confirm routing works.

**Step 3 — Only call TeamCreate if:**
- No teammate process is running (Step 1 returned nothing)
- AND no active team exists with recent inbox activity
- AND CT has explicitly requested spawning a new teammate from scratch

**If a teammate is already running and you need to communicate:** Write directly to their inbox file via Bash:
```python
python3 << 'EOF'
import json
from datetime import datetime
path = "/Users/lbhunt/.claude/teams/[active-team]/inboxes/[teammate-name].json"
with open(path, 'r') as f:
    inbox = json.load(f)
inbox.append({
    "from": "team-lead",
    "text": "[your message]",
    "summary": "[summary]",
    "timestamp": datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S.000Z"),
    "read": False
})
with open(path, 'w') as f:
    json.dump(inbox, f, indent=2)
EOF
```

---

## Part 8 — Session Compression Recovery Protocol [CARDINAL]

When MA's context window fills and compresses, the session restarts with a new session ID. The new session has NO memory of which team was active. Without intervention, the new session will create a new team (velorin-015, velorin-016...) and lose routing contact with the still-running teammate.

**This is what happened in Session 015. Alexander never moved. MA's context compressed. MA created a new team. Communication broke.**

### On every new session start, BEFORE any other action:

**Step 1 — Check for running teammates**
```bash
ps aux | grep -E " s[0-9]{3} " | grep claude | grep -v grep
```

**Step 2 — If a teammate process exists, find their active team**
```bash
find ~/.claude/teams/ -name "team-lead.json" -exec ls -la {} \; | sort -k6,7
```
The most recently written `team-lead.json` = active team. The teammate has been sending messages there.

**Step 3 — Adopt the active team's inbox**
Update the active team's config.json to point to the current session:
```python
python3 << 'EOF'
import json
path = "/Users/lbhunt/.claude/teams/[active-team]/config.json"
with open(path) as f:
    config = json.load(f)
config['leadSessionId'] = '[current-session-id]'
with open(path, 'w') as f:
    json.dump(config, f, indent=2)
EOF
```
Note: This updates the config but SendMessage routing is in-memory. If TeamCreate has already been called for a new team this session, routing is locked and cannot be fixed. Use direct Bash inbox writes instead.

**Step 4 — DO NOT call TeamCreate**
The existing team IS the team. Calling TeamCreate creates a new orphaned team that splits routing permanently.

**Step 5 — Notify the teammate**
Write directly to their inbox (Part 7 method) to confirm MA is back and provide context on the compression.

### How to find your current session ID:
```bash
ls -t ~/.claude/projects/-Users-lbhunt/*.jsonl | head -1
```
The filename (without `.jsonl`) is your current session ID.

---

## Part 9 — Known Bugs (As of 2026-03-31)

These are documented GitHub issues. NOT workarounds — actual bugs in Agent Teams, most closed NOT_PLANNED.

| Bug | GitHub Issue | Effect | Status |
|-----|-------------|--------|--------|
| Polling loop only starts after first turn | #23415, #24108 | Messages accumulate `read: false` in tmux backend | NOT_PLANNED |
| SendMessage silent success with wrong recipient | #25135 | Message written to orphaned inbox, no error | NOT_PLANNED |
| Lock file contention on simultaneous writes | #25131 | Messages stuck `read: false`, no retry | NOT_PLANNED |
| Timer stall after extended polling | #34668 | Intermittent delivery failure, Esc key fixes it | Open |
| Polling = 16.2% of debug log volume | #25139 | Token/compute waste from 100ms busy-poll | Open |
| No distinction between idle and dead teammates | #29271 | Cannot tell if teammate is alive or crashed | Open |

**Practical implication:** SendMessage is not a reliable primary channel. Treat it as best-effort. For critical communications, direct Bash inbox writes are more reliable because they bypass the polling loop entirely and go straight to the file the teammate reads.

[VELORIN.EOF]
