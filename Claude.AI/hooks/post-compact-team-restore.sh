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
