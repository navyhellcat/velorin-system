#!/bin/bash
# Bot.Scribe.Neuron — Real-time trigger
# Fires as a PostToolUse hook when MarcusAurelius writes to the memory directory.
# Spawns a Claude Code subprocess to execute the Scribe's neuron-writing logic.
#
# Hook config (add to ~/.claude/settings.local.json):
# "hooks": {
#   "PostToolUse": [{
#     "matcher": "Write",
#     "command": "/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Scribe/scribe-trigger.sh"
#   }]
# }
#
# The hook receives tool use context on stdin. This script filters for memory
# directory writes only, then spawns Scribe.

MEMORY_DIR="/Users/lbhunt/.claude/projects/-Users-lbhunt/memory"
SCRIBE_SPEC="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Scribe/SCRIBE.md"
BRAIN_SCHEMA="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Velorin_Brain/_BRAIN_SCHEMA.md"
REGION_INDEX="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Velorin_Brain/_index.md"
RULES_FILE="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.MarcusAurelius/rules/MarcusAurelius.Rules.md"
LOG_FILE="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Scribe/error_log.md"
SCRIBE_OUTPUT_LOG="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Scribe/scribe_run_log.txt"

# Read stdin for the tool use context
INPUT=$(cat)

# Extract the file path from the Write tool's output
FILE_PATH=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    path = data.get('tool_input', {}).get('file_path', '')
    print(path)
except:
    print('')
" 2>/dev/null)

# Only fire if the write was to the memory directory
if [[ "$FILE_PATH" != "$MEMORY_DIR"* ]]; then
    exit 0
fi

# Skip if the file is MEMORY.md itself (index file, not a memory)
if [[ "$FILE_PATH" == *"MEMORY.md" ]]; then
    exit 0
fi

# Log the trigger
echo "$(date -u '+%Y-%m-%dT%H:%M:%SZ') | TRIGGER | File: $FILE_PATH" >> "$LOG_FILE"
echo "========== $(date -u '+%Y-%m-%dT%H:%M:%SZ') | SCRIBE RUN | File: $FILE_PATH ==========" >> "$SCRIBE_OUTPUT_LOG"

# Spawn Scribe as a background Claude Code subprocess
claude --print --dangerously-skip-permissions -p "
You are Bot.Scribe.Neuron. You have ONE job: read the memory file that was just written and create/update the corresponding neuron in the Velorin Brain.

MEMORY FILE JUST WRITTEN: $FILE_PATH

YOUR KNOWLEDGE BASE (read these first):
1. $BRAIN_SCHEMA — master rules for neurons, pointers, layers
2. $REGION_INDEX — where to find all brain regions
3. $RULES_FILE — current behavioral rules (update if the memory contains a rule/instruction)

PROTOCOL:
1. Read the memory file at $FILE_PATH
2. Check the 'class' field in frontmatter: 'regular' or 'c-memory'
3. Find the relevant brain region for this knowledge
4. Read the region's _index.md, chase to candidate neurons
5. If a neuron already covers this: update it, add pointers, shift ratings
6. If no neuron exists: create one (max 15 lines, max 7 rated pointers), update _index.md, wire pointers from/to neighbors
7. If the memory contains a rule/instruction/permission: append it to $RULES_FILE in correct sorted position, then copy to /Users/lbhunt/.claude/projects/-Users-lbhunt/rules/MarcusAurelius.Rules.md
8. Commit changes to git in /Users/lbhunt/Desktop/velorin-system/

If you encounter an error, append it to $LOG_FILE with timestamp and continue.
Do NOT delete the memory file — that happens on the daily clean only.
" >> "$SCRIBE_OUTPUT_LOG" 2>&1 &

exit 0
