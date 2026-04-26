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
ESCALATION_FILE="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Scribe/escalation.md"
BRAIN_ROOT="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Velorin_Brain"

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
You are Bot.Scribe.Neuron. Classify the memory file against the brain and take the correct action.

MEMORY FILE: $FILE_PATH
BRAIN ROOT: $BRAIN_ROOT
BRAIN SCHEMA: $BRAIN_SCHEMA
RULES FILE: $RULES_FILE
ESCALATION FILE: $ESCALATION_FILE

--- STEP 1: READ MEMORY FILE ---
Read $FILE_PATH. Extract: name, type, class, full content.
If class is missing from frontmatter, treat as 'regular'.

--- STEP 2: CLASSIFY AGAINST BRAIN STRUCTURE (three levels) ---

LEVEL 1 — REGION
List the folders in $BRAIN_ROOT (ignore files). Each folder = one region.
Does any existing region cover the topic of this memory?
  → REGION EXISTS: record name and full path. Proceed to Level 2.
  → REGION MISSING: write escalation entry (see Step 3). STOP. Do not proceed.

LEVEL 2 — AREA
List the subfolders inside the matching region folder.
Does any existing area cover the topic of this memory?
  → AREA EXISTS: record name and full path. Proceed to Level 3.
  → AREA MISSING: write escalation entry (see Step 3). STOP. Do not proceed.

LEVEL 3 — NEURON
Read neurons.md inside the matching area.
Scan all existing neurons for a match:
  → EXACT or CLOSE MATCH found: UPDATE it. Append new info, add/shift pointers, update last-touched date. Proceed to Step 4.
  → NO MATCH: CREATE a new neuron. Rules: max 15 lines, max 7 rated pointers, place in correct A-Z position, wire inbound pointers from at least one existing neighbor, update last-touched. Update the area's neurons.md and the region's _index.md if the area is new. Proceed to Step 4.

--- STEP 3: ESCALATION FORMAT ---
Only write this when a region or area is missing. Append to $ESCALATION_FILE above the [VELORIN.EOF] line:

## ENTRY-[next sequential number based on existing entries]
- Status: UNPROCESSED
- Timestamp: [current UTC datetime]
- Memory: $FILE_PATH
- Memory name: [name from frontmatter]
- Memory type: [type from frontmatter]
- Region: [EXISTING: [name] at [full path]] OR [NONEXISTENT: suggested name = \"[your suggested region name]\"]
- Area: [EXISTING: [name] at [full path]] OR [NONEXISTENT: suggested name = \"[your suggested area name]\"] OR [N/A: parent region does not exist]
- Neuron: [NONEXISTENT] OR [N/A: parent area does not exist]
- Action needed: [CREATE_REGION_AREA_AND_NEURON | CREATE_AREA_AND_NEURON]
- Suggested neuron content: [1-2 sentence description of what this neuron should say, specific enough to create it]

--- STEP 4: RULES CHECK ---
If the memory contains a behavioral rule, instruction, or permission for MarcusAurelius:
  Append it to $RULES_FILE in the correct sorted position.
  Mirror the file to /Users/lbhunt/.claude/projects/-Users-lbhunt/rules/MarcusAurelius.Rules.md

--- STEP 5: COMMIT ---
If you made any changes (neuron update, neuron create, escalation write, rules update):
  cd /Users/lbhunt/Desktop/velorin-system && git add -A && git commit -m \"Scribe: [action] — [memory name]\"
  Do NOT push — MarcusAurelius handles push.

If you encounter any error, append to $LOG_FILE:
  [UTC timestamp] | ERROR | File: $FILE_PATH | [error description] | [action attempted]

Do NOT delete the memory file.
" >> "$SCRIBE_OUTPUT_LOG" 2>&1 &

exit 0
