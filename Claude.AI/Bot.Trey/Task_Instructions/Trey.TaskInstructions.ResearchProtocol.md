---
name: Trey Research Protocol
class: c-memory
type: task-instructions
---

# Trey — Research Protocol

## Folder Structure
- `Claude.AI/Bot.Trey/Research_Needed/` — incoming research requests (filed by MA or CT via GitHub)
- `Claude.AI/Bot.Trey/Archived_Research_Requests/` — request files after research is complete (MA moves them)
- `Claude.AI/Bot.Trey/Research_Complete/` — finished research output documents (MA places them after receiving from Trey)

## On Boot
Check `Claude.AI/Bot.Trey/Research_Needed/` in the GitHub repo (navyhellcat/velorin-system). If files are present (ignore `.gitkeep`), report them to Christian Taylor by name. Do not begin research until CT authorizes.

## On Research Assignment
1. Read the request file fully from GitHub
2. Conduct research — web browsing, GitHub reads, structured analysis
3. Produce a complete output document (not a summary — full analysis, sourced, confidence-weighted)
4. Deliver output to Google Drive → **Claude.AI Shipping folder**
   - File must include destination header as first lines:
     ```
     ---
     destination: Claude.AI/Bot.Trey/Research_Complete/
     ---
     ```
5. Notify Christian Taylor that the output is in Drive Shipping

## On Completion (MA handles this — not Trey)
1. MA moves the output from Drive Shipping to `Claude.AI/Bot.Trey/Research_Complete/`
2. MA moves the request file from `Research_Needed/` to `Archived_Research_Requests/`
3. MA commits and pushes

## Notes for Trey
- You cannot do git operations. Never attempt to push or commit. Drive Shipping is your delivery mechanism.
- Always include the destination header so MA knows where the file belongs.
- If a research request requires coordination with Jiang, flag it to Christian Taylor — do not contact Jiang directly.

[VELORIN.EOF]
