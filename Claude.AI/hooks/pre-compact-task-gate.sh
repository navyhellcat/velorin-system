#!/bin/bash
# pre-compact-task-gate.sh
# Blocks auto-compaction when a task is actively running.
#
# Logic:
#   - No lock file → allow compaction (normal behavior)
#   - Lock file + tokens < 89% of context window → EXIT 2 (block compaction)
#   - Lock file + tokens >= 89% of context window → EXIT 0 (allow — safety cap)
#
# Exit codes (per Claude Code PreCompact contract):
#   0 = allow compaction (stdout appended as custom instructions)
#   2 = BLOCK compaction
#   other = show stderr to user, continue with compaction anyway
#
# Context window source:
#   Reads $VELORIN_CONTEXT_WINDOW env var if set.
#   Defaults to 200,000 (Desktop app hard cap — safe conservative fallback).
#   Terminal sessions (Jiang2) must be launched with VELORIN_CONTEXT_WINDOW=1000000.
#   Do NOT attempt to infer context window from model metadata — the model string
#   lies for the Desktop app (says 1M, actual cap is 200K enforced by Anthropic).
#
# Lock file: /Users/lbhunt/Desktop/velorin-system/TASK_ACTIVE.lock
# Agents write this file at task start and delete it at task end.
# Format: one-line description, e.g. "Jiang2 — Velorin V2 Blueprint (started 2026-04-05T14:32Z)"

LOCK_FILE="/Users/lbhunt/Desktop/velorin-system/TASK_ACTIVE.lock"

# Context window: explicit env var or 200K safe default
CONTEXT_WINDOW="${VELORIN_CONTEXT_WINDOW:-200000}"
CAP_TOKENS=$(( CONTEXT_WINDOW * 89 / 100 ))

# No lock file — no active task. Allow compaction.
if [ ! -f "$LOCK_FILE" ]; then
  exit 0
fi

# Lock exists. Check current token count via transcript.
# Payload arrives on stdin as JSON: { session_id, transcript_path, cwd, trigger, custom_instructions }
RESULT=$(python3 - "$CONTEXT_WINDOW" <<'PYEOF'
import sys
import json
import os

context_window = int(sys.argv[1])

try:
    payload = json.load(sys.stdin)
    transcript_path = payload.get("transcript_path", "")
except Exception:
    # Can't parse payload — fail open (allow compaction rather than block forever)
    print("ERR:no_payload")
    sys.exit(0)

if not transcript_path or not os.path.exists(transcript_path):
    print("ERR:no_transcript")
    sys.exit(0)

# Read last token usage from session JSONL (same method as T009)
last_usage = None
try:
    with open(transcript_path) as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            try:
                entry = json.loads(line)
                usage = entry.get("message", {}).get("usage", {})
                if usage and usage.get("output_tokens"):
                    last_usage = usage
            except Exception:
                continue
except Exception:
    print("ERR:read_failed")
    sys.exit(0)

if not last_usage:
    print("ERR:no_usage")
    sys.exit(0)

tokens = (
    last_usage.get("input_tokens", 0)
    + last_usage.get("cache_creation_input_tokens", 0)
    + last_usage.get("cache_read_input_tokens", 0)
)
pct = tokens / context_window * 100
print(f"{tokens} {pct:.1f}")
PYEOF
)

PY_EXIT=$?

# Python failed or returned an error code — fail open
if [ $PY_EXIT -ne 0 ] || [[ "$RESULT" == ERR:* ]]; then
  echo "TASK_GATE: Token count unavailable ($RESULT) — allowing compaction."
  exit 0
fi

CURRENT_TOKENS=$(echo "$RESULT" | awk '{print $1}')
CURRENT_PCT=$(echo "$RESULT" | awk '{print $2}')
TASK_DESC=$(cat "$LOCK_FILE")

# 89% safety cap — override the lock and allow compaction
if [ "$CURRENT_TOKENS" -ge "$CAP_TOKENS" ] 2>/dev/null; then
  echo "TASK_GATE: 89% cap reached (${CURRENT_PCT}% — ${CURRENT_TOKENS}/${CONTEXT_WINDOW} tokens). Lock overridden."
  echo "Task was: $TASK_DESC"
  exit 0
fi

# Below 89% and task is running — block compaction
echo "TASK_GATE: Compaction blocked. Active task at ${CURRENT_PCT}% (${CURRENT_TOKENS}/${CONTEXT_WINDOW} tokens)."
echo "Task: $TASK_DESC"
exit 2
