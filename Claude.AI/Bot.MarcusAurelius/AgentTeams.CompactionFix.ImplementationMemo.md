
# Agent Teams Compaction Fix — Implementation Memo
## Proposed Code + Rule Requirements
Prepared by Jiang | March 31, 2026


---

## PROBLEM

When any agent in an active Agent Teams session (team lead OR teammate) has its context compacted, it loses all team awareness. It cannot message teammates, coordinate tasks, or acknowledge the team exists. The teammate continues running but is orphaned. This is a two-way failure — compression on either side breaks the connection.

**Root cause:** Team configuration is not persisted across compaction. Unlike `CLAUDE.md` which is re-injected verbatim after summarization, team metadata is stripped. Anthropic has closed the bug NOT_PLANNED (issues #25131, #26265). They are not fixing this at the code level.

**Available fix mechanism:** `PreCompact` and `PostCompact` hooks exist in Claude Code and fire on `auto` or `manual` compaction. These can run side-effect scripts. Combined with CLAUDE.md's guaranteed re-injection behavior, this gives us a complete workaround.

---

## THE FIX — THREE COMPONENTS

### Component 1: Hook Scripts

Create two scripts at:
- `Claude.AI/hooks/pre-compact-team-save.sh`
- `Claude.AI/hooks/post-compact-team-restore.sh`

**LOCAL PATHS:**
- `/Users/lbhunt/Desktop/velorin-system/Claude.AI/hooks/pre-compact-team-save.sh`
- `/Users/lbhunt/Desktop/velorin-system/Claude.AI/hooks/post-compact-team-restore.sh`

---

**pre-compact-team-save.sh**

```bash
#!/bin/bash
# pre-compact-team-save.sh
# Fires before context compaction. Saves active team state to a stable path
# outside the session directory so it survives compaction.
# If no active team exists, clears any stale TEAM_STATE.md.

TEAM_DIR="$HOME/.claude/teams"
OUTPUT="/Users/lbhunt/Desktop/velorin-system/TEAM_STATE.md"

# Check for active team configs (ignore .gitkeep)
ACTIVE_CONFIGS=$(find "$TEAM_DIR" -name "config.json" 2>/dev/null)

if [ -z "$ACTIVE_CONFIGS" ]; then
  # No active team — remove stale state file if it exists
  rm -f "$OUTPUT"
  exit 0
fi

# Check if any team has inbox activity in the last 2 hours
# (prevents restoring a team from a previous day's session)
RECENT_ACTIVITY=$(find "$TEAM_DIR" -name "*.json" -newer "$TEAM_DIR" -mmin -120 2>/dev/null | grep -v config)

if [ -z "$RECENT_ACTIVITY" ] && [ -z "$(find "$TEAM_DIR" -name "config.json" -mmin -120 2>/dev/null)" ]; then
  # Team configs exist but are stale (older than 2 hours) — remove state file
  rm -f "$OUTPUT"
  exit 0
fi

# Active team with recent activity found — save state
{
  echo "# TEAM_STATE — Active Agent Team Recovery File"
  echo "# Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "# Source: PreCompact hook (pre-compact-team-save.sh)"
  echo "# Purpose: Re-establish team context after context compaction"
  echo ""
  echo "## INSTRUCTION FOR ANY AGENT READING THIS FILE"
  echo "Your context was recently compacted. You were part of an active Agent Team."
  echo "Read the team configuration below and re-establish your team context before proceeding."
  echo "Do not treat compaction as a session end. Your team is still running."
  echo ""

  for config in "$TEAM_DIR"/*/config.json; do
    [ -f "$config" ] || continue
    team=$(dirname "$config" | xargs basename)
    echo "## Team: $team"
    echo "\`\`\`json"
    cat "$config"
    echo "\`\`\`"
    echo ""

    # Also capture inbox state (who is alive)
    inbox_dir="$(dirname "$config")/inboxes"
    if [ -d "$inbox_dir" ]; then
      echo "### Active Inboxes (teammates)"
      for inbox in "$inbox_dir"/*.json; do
        [ -f "$inbox" ] || continue
        member=$(basename "$inbox" .json)
        echo "- $member"
      done
      echo ""
    fi
  done

  echo "## RECOVERY STEPS"
  echo "1. Identify which team you are on from the config above"
  echo "2. Identify your role (team-lead or named teammate)"
  echo "3. Re-establish SendMessage routing to the correct inbox paths"
  echo "4. Resume work — do not call TeamCreate (a team already exists)"
  echo "5. Delete or ignore this file once team context is restored"

} > "$OUTPUT"

exit 0
```

---

**post-compact-team-restore.sh**

```bash
#!/bin/bash
# post-compact-team-restore.sh
# Fires after context compaction completes.
# Verifies TEAM_STATE.md was written by the PreCompact hook.
# If no team state exists (solo session), ensures no stale file persists.

OUTPUT="/Users/lbhunt/Desktop/velorin-system/TEAM_STATE.md"
TEAM_DIR="$HOME/.claude/teams"

# If state file doesn't exist, nothing to do
if [ ! -f "$OUTPUT" ]; then
  exit 0
fi

# Verify the state file is fresh (written in the last 5 minutes)
# If it's stale, the PreCompact hook didn't fire this cycle — remove it
if [ -n "$(find "$OUTPUT" -mmin +5 2>/dev/null)" ]; then
  rm -f "$OUTPUT"
  exit 0
fi

# State file is fresh and valid.
# CLAUDE.md will instruct the agent to read it on next turn.
# Nothing else needed here — the re-injection happens via CLAUDE.md.
exit 0
```

---

### Component 2: settings.local.json Additions

Add the following hook blocks to `~/.claude/settings.local.json`.

Add inside the existing `"hooks"` object, alongside the current `"PostToolUse"` entry:

```json
"PreCompact": [
  {
    "matcher": "auto",
    "hooks": [
      {
        "type": "command",
        "command": "/Users/lbhunt/Desktop/velorin-system/Claude.AI/hooks/pre-compact-team-save.sh",
        "timeout": 10
      }
    ]
  }
],
"PostCompact": [
  {
    "matcher": "auto",
    "hooks": [
      {
        "type": "command",
        "command": "/Users/lbhunt/Desktop/velorin-system/Claude.AI/hooks/post-compact-team-restore.sh",
        "timeout": 10
      }
    ]
  }
]
```

---

### Component 3: CLAUDE.md Addition

Add the following as the **first item** in the Boot Sequence section of `/Users/lbhunt/CLAUDE.md`, before all other boot steps:

```
**COMPACTION RECOVERY CHECK [CARDINAL — run before all other boot steps]:**
Before reading anything else: check whether `/Users/lbhunt/Desktop/velorin-system/TEAM_STATE.md` exists.
- If it does NOT exist: proceed with normal boot sequence.
- If it DOES exist: read it in full. It contains active Agent Team state saved before the last context compaction. Re-establish team context from the config inside it (identify your team, your role, your teammates' inbox paths). Do not call TeamCreate — a team already exists. Resume coordination. Then continue with normal boot sequence below.
```

---

## RULE REQUIREMENTS (for Level 4 General Rules or agent-specific rules)

The following rule must be added to prevent agents from creating ghost teams after compaction recovery. Recommend adding to `Level4.General.Rules.md`:

```
**COMPACTION RECOVERY — Team Existence Check [CARDINAL]**
After any context compaction event, before calling TeamCreate:
1. Check for TEAM_STATE.md at `/Users/lbhunt/Desktop/velorin-system/TEAM_STATE.md`
2. Check `~/.claude/teams/` for existing team configs
3. If either exists with recent activity (< 2 hours): DO NOT call TeamCreate. Adopt the existing team context and resume.
4. Only call TeamCreate if BOTH checks confirm no active team exists.
Calling TeamCreate when a team already exists creates orphaned routing that cannot be recovered without manual cleanup of `~/.claude/teams/`.
```

---

## WHAT THIS DOES NOT FIX

This workaround handles compaction events only. It does NOT fix:
- Hard session restarts where the lead session ID has changed (use the detect-and-rejoin pattern from Level 4 rules)
- The unreachable code path bug in the `resume` parameter for teammates (Anthropic code change required)
- The session-scoped transcript ID format mismatch (Anthropic code change required)

These are code-level bugs Anthropic has marked NOT_PLANNED. The architectural replacement (file-based async, no Agent Teams dependency) resolves all of them permanently. This fix is a bridge until the rebuild is complete.

---

## IMPLEMENTATION ORDER

1. Create `Claude.AI/hooks/` directory if it doesn't exist
2. Write `pre-compact-team-save.sh` — make executable (`chmod +x`)
3. Write `post-compact-team-restore.sh` — make executable (`chmod +x`)
4. Add PreCompact + PostCompact blocks to `settings.local.json`
5. Add COMPACTION RECOVERY CHECK to top of CLAUDE.md boot sequence
6. Add COMPACTION RECOVERY rule to `Level4.General.Rules.md`
7. Test: start a team session, manually trigger compaction (`/compact`), verify TEAM_STATE.md is written and team context is restored

---

*Jiang | Director of Strategic Intelligence | March 31, 2026*

[VELORIN.EOF]
