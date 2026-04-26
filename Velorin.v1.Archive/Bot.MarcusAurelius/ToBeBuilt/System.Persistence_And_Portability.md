# System.Persistence_And_Portability — The Giant Hole
**ToBeBuilt | Priority: CRITICAL | Flagged: 2026-03-30 Session 014**

---

## The Problem

The entire Velorin agent ecosystem is built on ephemeral, machine-local infrastructure. Nothing persists across session closes. Nothing can be shipped. This is a fundamental architectural gap.

---

## What Dies When a Session Closes

| Component | Type | Dies on close? | Notes |
|-----------|------|----------------|-------|
| Terry (T007) | CronCreate | YES | Was dead for all of sessions 013–014 |
| Session Monitor T009 | CronCreate | YES | Recreated in STARTUP.md — workaround only |
| Scribe escalation check | CronCreate | YES | Recreated in STARTUP.md — workaround only |
| Any future agent timer | CronCreate | YES | Every single one |
| Scribe trigger | PostToolUse hook | NO | Lives in settings.local.json — survives |
| GDrive token refresh T005 | MCP server process | NO | Lives in server.js |
| Resend monitor T006 | Replit backend | NO | External — survives |

**Bottom line:** Every CronCreate timer in the system is dead on startup unless manually recreated. STARTUP.md is a band-aid, not a fix. If the boot sequence is skipped or partially run, agents silently don't exist.

---

## What Can't Be Shipped

Every file in this system assumes:
- macOS, `/Users/lbhunt/Desktop/...` hardcoded everywhere
- `~/.claude/settings.local.json` written manually on this one machine
- Claude Code running as a local interactive session
- CronCreate available (requires active Claude Code session)
- Local git repos at specific paths

You cannot hand this to another person without manual surgery on every path in every file.

---

## The Full Scope of the Problem

### 1. Timer Persistence
CronCreate is session-only with a 7-day hard ceiling. There is no way to make it permanent within Claude Code's current architecture. The `durable: true` flag was confirmed non-functional.

**What actually works for persistent timers:**
- `launchd` (macOS plist) — survives reboots, runs without a session
- `crontab` (system cron) — same
- A small always-running daemon (Python, Node) — can be daemonized with launchd

### 2. Agent Resurrection on Boot
Current state: if STARTUP.md is not fully executed at session open, the following agents do not exist:
- Terry (T007)
- Session Monitor (T009)
- Scribe escalation check
- Any future agent added to STARTUP.md

There is no automatic agent resurrection. No watchdog. No self-healing.

**What's needed:** A boot script that runs once at session open and creates all CronCreate timers, verified by checking CronList before creating (avoid duplicates).

### 3. Portability / Shipping
The system cannot be installed on another machine without:
- Path abstraction (replace `/Users/lbhunt/` with `$VELORIN_ROOT` or similar)
- A bootstrapper that writes hooks into the target's settings.local.json
- A setup script that clones repos, sets variables, creates required folders
- Replacing CronCreate with real persistent timers (launchd/crontab)
- Documentation for every hardcoded assumption

---

## Proposed Solutions

### Short Term (this system, this machine)

1. **Boot script** — single Python or bash script that creates all CronCreate timers at session open. Checks CronList first (idempotent). STARTUP.md calls it with one line instead of listing each timer separately.
   - Location: `Velorin Code/hooks/boot_timers.sh`
   - Timers it creates: T007 (Terry 15m), T009 (session monitor 5m), Scribe escalation check (5m)

2. **Watchdog** — a CronCreate that fires every 30 min, calls CronList, and recreates any missing timers. Self-healing within a session.

3. **Timer health in STARTUP.md** — after boot script runs, verify all expected timer IDs are in CronList. Fail loudly if any are missing.

### Medium Term (make it real)

4. **Migrate persistent timers to launchd** — Terry, Scribe escalation check should be launchd plists. They have no session dependency — they just need to run a script. Session monitor is the only one that genuinely needs an active session (it reads the session JSONL).

5. **Path abstraction** — introduce `$VELORIN_ROOT` and `$VELORIN_CODE` environment variables. Replace all hardcoded paths. Store in `~/.zshenv` or a sourced config file.

### Long Term (shipping)

6. **Installer** — shell script or Python installer that:
   - Prompts for install path
   - Clones repos
   - Writes env vars
   - Writes Claude Code hooks to settings.local.json
   - Creates launchd plists for persistent timers
   - Runs self-test

7. **Containerization** — Docker or similar removes the macOS-only constraint entirely. Claude Code runs in container, hooks are mounted, timers are cron inside the container.

---

## Known Dead Agents (confirmed gaps as of 2026-03-30)

- **Terry T007** — dead every session until Session 014 fix. Now in STARTUP.md but still dies on close.
- **T001 Neuron Boss** — DESIGNED, never deployed
- **T002 Custodian** — DESIGNED, never deployed
- **T003 Mobility** — DESIGNED, never deployed
- **T004 Scribe daily clean** — DESIGNED, hook wired, never restarted after last session

---

## Priority Order

1. Boot script (`boot_timers.sh`) — eliminates per-timer STARTUP.md entries, one call creates all
2. Migrate Terry + Scribe escalation to launchd — no more session dependency for those two
3. Path abstraction (`$VELORIN_ROOT`) — prerequisite for shipping
4. Installer — shipping requirement
5. Watchdog — nice to have once boot script exists

---

*Created: 2026-03-30 | Session 014 | Flag: architectural debt*

[VELORIN.EOF]
