#!/bin/bash
# Bot.Scribe.Neuron — Daily Clean Trigger
# Run manually via "scribe clean" or on a cron schedule.
# Scans MarcusAurelius's memory, verifies neurons exist, deletes regular memories,
# consolidates the rules file.

MEMORY_DIR="/Users/lbhunt/.claude/projects/-Users-lbhunt/memory"
SCRIBE_SPEC="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Scribe/SCRIBE.md"
BRAIN_SCHEMA="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Velorin_Brain/_BRAIN_SCHEMA.md"
REGION_INDEX="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Velorin_Brain/_index.md"
RULES_GITHUB="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.MarcusAurelius/rules/MarcusAurelius.Rules.md"
RULES_LOCAL="/Users/lbhunt/.claude/projects/-Users-lbhunt/rules/MarcusAurelius.Rules.md"
LOG_FILE="/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Scribe/error_log.md"

echo "$(date -u '+%Y-%m-%dT%H:%M:%SZ') | DAILY CLEAN START" >> "$LOG_FILE"

claude --print --dangerously-skip-permissions -p "
You are Bot.Scribe.Neuron running the DAILY CLEAN cycle.

YOUR KNOWLEDGE BASE (read these first):
1. $BRAIN_SCHEMA — master rules for neurons, pointers, layers
2. $REGION_INDEX — where to find all brain regions
3. $RULES_GITHUB — current behavioral rules file

DAILY CLEAN PROTOCOL:

STEP 1 — Scan memory directory at $MEMORY_DIR
List all .md files. Read each one. Check the 'class' field in frontmatter.

STEP 2 — Process regular memories
For each file with class: regular:
  a. Find the corresponding neuron in the Velorin Brain
  b. If neuron exists with correct pointers: delete the memory file
  c. If neuron does NOT exist: create it first (full memory creation protocol), then delete the memory file
  d. Remove the deleted file's entry from $MEMORY_DIR/MEMORY.md

STEP 3 — Skip c-memories
For each file with class: c-memory: do NOTHING. Do not delete. Do not modify. Skip entirely.

STEP 4 — Skip files without class label
If a memory file has no class label: log a warning to $LOG_FILE. Do NOT delete it. Flag it for MarcusAurelius to fix.

STEP 5 — Consolidate rules file
Read $RULES_GITHUB. Check for:
  - Conflicting rules: new overrides old. Mark old as [SUPERSEDED by X#]. Do NOT delete.
  - Sort: sections A-Z, rules numbered within sections
  - Every rule has a label (e.g., A1, B2, G1) for pointer references
  - Write cleaned version to $RULES_GITHUB
  - Copy to $RULES_LOCAL

STEP 6 — Commit to GitHub
cd /Users/lbhunt/Desktop/velorin-system && git add -A && git commit -m 'Bot.Scribe.Neuron — daily clean $(date +%Y-%m-%d)'

STEP 7 — Log completion
Append completion timestamp to $LOG_FILE

If you encounter any error: log it to $LOG_FILE with timestamp, file, error type. Continue processing remaining files. Do not halt on a single failure.
"

echo "$(date -u '+%Y-%m-%dT%H:%M:%SZ') | DAILY CLEAN END" >> "$LOG_FILE"
