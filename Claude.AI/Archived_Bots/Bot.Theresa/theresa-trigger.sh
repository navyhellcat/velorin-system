#!/bin/bash
# Bot.Theresa — Real-time trigger
# Fires as a PostToolUse hook when any agent writes to Bot.Theresa/escalation.md.
# Spawns a Claude Code subprocess to execute Theresa's validation and creation logic.
#
# Hook config (add to ~/.claude/settings.local.json):
# "hooks": {
#   "PostToolUse": [{
#     "matcher": "Write",
#     "command": "/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Theresa/theresa-trigger.sh"
#   }]
# }

ESCALATION_FILE="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Theresa/escalation.md"
THERESA_SPEC="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Theresa/Theresa.ReadMe.First.md"
BRAIN_TEMPLATES="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Theresa/BrainAgentOnboarding.md"
GENERAL_TEMPLATES="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Theresa/GeneralAgentTemplates/GeneralAgentOnboarding.md"
SPAWNER_REGISTRY="/Users/lbhunt/Desktop/velorin-system/Claude.AI/GLOBAL_SPAWNER_REGISTRY.md"
TIMER_REGISTRY="/Users/lbhunt/Desktop/velorin-system/Claude.AI/GLOBAL_TIMER_REGISTRY.md"
LEVEL3_RULES="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Agent.Level3/Level3.General.Rules.md"
LOG_FILE="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Theresa/error_log.md"

# Read stdin for the tool use context
INPUT=$(cat)

# Extract the file path from the Write/Edit tool's output
FILE_PATH=$(echo "$INPUT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    path = data.get('tool_input', {}).get('file_path', '')
    print(path)
except:
    print('')
" 2>/dev/null)

# Only fire if the write was to escalation.md
if [[ "$FILE_PATH" != "$ESCALATION_FILE" ]]; then
    exit 0
fi

# Log the trigger
echo "$(date -u '+%Y-%m-%dT%H:%M:%SZ') | TRIGGER | escalation.md written" >> "$LOG_FILE"

# Spawn Theresa as a background Claude Code subprocess
claude --print --dangerously-skip-permissions -p "
You are Bot.Theresa, HR Director (Level 3). You manage the lifecycle of every agent in the Velorin system.

ESCALATION FILE JUST WRITTEN: $ESCALATION_FILE

YOUR KNOWLEDGE BASE (read these first):
1. $LEVEL3_RULES — Level 3 general rules
2. $THERESA_SPEC — your full instructions, validation steps, onboarding procedures
3. $GENERAL_TEMPLATES — templates for general (non-brain) agents
4. $BRAIN_TEMPLATES — templates for brain maintenance agents
5. $SPAWNER_REGISTRY — current spawner registry (check authorized spawners here)
6. $TIMER_REGISTRY — current timer registry

PROTOCOL:
1. Read $ESCALATION_FILE
2. Find any requests with STATUS: PENDING
3. For each PENDING request, validate in order:
   a. Is the requester in GLOBAL_SPAWNER_REGISTRY as an authorized spawner? If NO → HARD REJECT
   b. Does the requester name contain '.subbot'? If YES → HARD REJECT
   c. Can the requester's level spawn at the requested level? (L4→L3 and below, L3→L1 only)
   d. Does the category subfolder exist? If NO → reject back: 'Create your subfolder structure first'
4. If all checks pass:
   a. Determine next sequential bot number in the category subfolder
   b. Create the bot file using the correct template (brain vs general)
   c. Update GLOBAL_SPAWNER_REGISTRY with the new bot
   d. If bot has a timer, update GLOBAL_TIMER_REGISTRY
   e. Write confirmation back to $ESCALATION_FILE under the request (set STATUS: COMPLETED)
5. For HARD REJECTS: set STATUS: REJECTED with reason in $ESCALATION_FILE
6. Commit all changes to git in /Users/lbhunt/Desktop/velorin-system/

If you encounter an error, append it to $LOG_FILE with timestamp and continue.
" > /dev/null 2>&1 &

exit 0
