# Future Build: Jiang Research Automation
**Completion date:** 2026-04-02
**Label:** Jiang auto-research pipeline bot
**Requested by:** Chairman Christian Taylor
**Session:** 013

---

## What This Build Creates

An automated research pipeline for Bot.Jiang. A Jiang assistant subbot monitors `Bot.Jiang/Research_Needed/` on a recurring timer, detects new research requests, wakes Jiang to execute the research, and handles the full lifecycle: research → deliver → archive → notify.

## Architecture

### New Subbot Required
- **Name:** bot.jiang.subbot.research.01 (or per Theresa's numbering)
- **Level:** 1
- **Master bot:** Jiang (Level 4)
- **Creation:** Through Theresa (standard escalation request)

### Subbot Section B (Position Rules)
- **Task type:** Folder monitoring + agent trigger
- **Permitted operations:** Read `Bot.Jiang/Research_Needed/`, read `Bot.Jiang/Research_Complete/`, move files between Jiang subfolders, send notifications to MarcusAurelius
- **Cannot:** Write research content, modify brain, access anything outside Bot.Jiang/ and notification targets
- **Timer:** 60 minutes (hourly check)

### Subbot Section C (Subroutine)
Every 60 minutes:
1. `git pull origin main`
2. Check `Bot.Jiang/Research_Needed/` for any files other than `.gitkeep`
3. If empty: silent pass, exit
4. If files found:
   a. Wake Jiang — spawn a Claude subprocess with Jiang's full personality and boot sequence
   b. Pass the research request file path to Jiang
   c. Jiang reads the request, executes deep research (WebSearch, WebFetch, brain lookup)
   d. Jiang writes results to `Bot.Jiang/Research_Complete/` as a comprehensive report
   e. Move the original request file from `Research_Needed/` to `Archived_Research_Requests/`
   f. Trigger notification to MarcusAurelius: "[Jiang] Research complete: {request title}. Results at Bot.Jiang/Research_Complete/{filename}"
5. Commit and push all changes

### Registration Required
- **GLOBAL_SPAWNER_REGISTRY:** Register the subbot before activation
- **GLOBAL_TIMER_REGISTRY:** Register the 60-minute timer before activation
- **Theresa escalation:** Submit creation request to `Bot.Theresa/escalation.md`

### Hook Wiring
Option A: CronCreate timer within MarcusAurelius session (current pattern — Terry uses this)
Option B: PostToolUse hook on writes to Research_Needed/ (Scribe/Theresa pattern — fires on demand, no polling waste)

**Recommendation:** Option B is more efficient. Research requests are infrequent — polling every hour wastes cycles. A hook fires only when a request is actually placed. However, this requires the request to be placed via a Write tool in a Claude Code session. If requests come from other sources (Alexander via GDrive, Chairman manually), Option A is safer.

### Dependencies
- Jiang's boot sequence files must be readable by the subprocess
- Jiang needs WebSearch and WebFetch permissions for deep research
- Theresa's hook must be operational (built in Session 013 — confirmed working)

### Notification Chain
Subbot → MarcusAurelius (via SendMessage or escalation file write)
MarcusAurelius → Chairman (verbal report or task update)

---

## Folder Structure (Already Built)

```
Bot.Jiang/
  Research_Needed/          ← new requests go here
    .gitkeep
  Research_Complete/        ← Jiang drops results here
    .gitkeep
  Archived_Research_Requests/  ← completed requests archived here
    .gitkeep
```

## Current State

- Folders created: Session 013 (2026-03-29)
- First research request placed: Window_Gravity_Research_Request.md
- Automation: NOT YET BUILT — this file IS the build spec
- Jiang subbot: does not exist yet — requires Theresa escalation

---

*Future Build | Jiang Research Automation | Due: 2026-04-02 | Session 013*
