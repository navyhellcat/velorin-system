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
