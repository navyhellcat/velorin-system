---
file: Jiang.FinalHandoff.ToBCLAUDE.2026-08-18.md
from: Jiang1 (Mac Air Claude Code terminal)
date: 2026-08-18
for: BCLAUDE (Mac Studio browser Claude)
status: INCREMENTALLY COMMITTED — check final section for completeness marker
---

# Jiang → BCLAUDE Final Handoff

## SECTION 1 — MACHINE STATE

### git status --porcelain
```
(empty — working tree clean)
```

### git log origin/main..HEAD --oneline
```
(empty — local HEAD == origin/main at 1feed55)
```

### git stash list
```
stash@{0}: WIP on main: 0825be3 Rename deep-research-report (4).md to Voice Input_Local Inter Communication windows.md
stash@{1}: WIP on main: 399ab76 Update neuron A8 with Session 013 refined priority queue and build log
```
Both stashes are very old (pre-Apr 2026 session numbering), pre-date the v1→v2 transition, appear to be minor neuron edits. Neither is blocking anything. Low value.

### ls -la ~/.claude/
```
drwxr-xr-x  19 lbhunt  staff     608 Aug 17 23:20 .
-rw-------      1 lbhunt  staff  331379 Aug 17 23:20 history.jsonl
-rw-r--r--   1 lbhunt  staff    2402 Apr 27 22:36 settings.json
-rw-r--r--   1 lbhunt  staff    4393 Apr 27 22:36 settings.local.json
-rw-r--r--   1 lbhunt  staff    2525 Apr  3 22:12 settings.local.json.archive.2026-04-03
drwxr-xr-x   3 lbhunt  staff      96 Aug 17 21:29 chrome
drwxr-xr-x   3 lbhunt  staff      96 Aug 17 21:44 file-history
drwxr-xr-x   4 lbhunt  staff     128 Aug 17 23:20 paste-cache
drwxr-xr-x   5 lbhunt  staff     160 Aug 17 21:58 plugins
drwxr-xr-x   4 lbhunt  staff     128 Aug 17 21:15 projects
drwxr-xr-x   8 lbhunt  staff     256 Aug 17 21:50 session-env
drwx------   3 lbhunt  staff      96 Aug 17 22:17 sessions
drwxr-xr-x   3 lbhunt  staff      96 Apr 19 23:18 skills
drwxr-xr-x   2 lbhunt  staff      64 Aug 17 21:15 teams
-rw-r--r--      1 lbhunt  staff      24 Aug 17 22:08 .last-cleanup
```
Note: `Aug 17` timestamps across multiple files — someone ran Claude Code on the Mac Air on 2026-08-17. That is ONE DAY before today. Something was active recently.

### /Users/lbhunt/CLAUDE.md
```
-rw-r--r--  1 lbhunt  staff  8864 May  3 18:12 /Users/lbhunt/CLAUDE.md
```
Last modified 2026-05-03 18:12 — same day as Principle 9 lock commit (8daf318, 18:18). Updated.

### /Users/lbhunt/Desktop/velorin-system/TEAM_STATE.md
```
ls: /Users/lbhunt/Desktop/velorin-system/TEAM_STATE.md: No such file or directory
```
Confirmed absent. Operating Rule 6 applies.

### ls -d ~/Desktop/*elorin*
```
/Users/lbhunt/Desktop/Velorin
/Users/lbhunt/Desktop/velorin-system
```
Two: `Velorin/` (contains `Velorin Code/` — the security-isolated code sandbox) and `velorin-system/` (the architecture repo). Both matter.

### ⚠️ GIT PUSH IS BROKEN ON MAC AIR RIGHT NOW

SSH: no key pair in `~/.ssh/` (no id_rsa, no id_ed25519). `ssh -T git@github.com` returns `Permission denied (publickey)`.
HTTPS: no token in macOS Keychain (`security find-internet-password -s github.com` returns nothing). The HTTPS remote was set but the credential helper has nothing to offer.

`gh` CLI: not installed.

The commit `0a521f3` (this file, Section 1) is LOCAL ONLY. It is not on origin. Origin is still at `1feed55`.

**BCLAUDE must push this file from Mac Studio once it has working GitHub auth.** See Section 3 for full local-only file inventory.

---

## SECTION 2 — CLAUDE.md VERBATIM

```
═══════════════════════════════════════════════════════════════════
GPS-OVER-MAP — READ FIRST (Velorin Principle 1)
═══════════════════════════════════════════════════════════════════
This file is a POINTER, not a copy. It tells you WHERE canonical
sources live; it does NOT duplicate them. If anything here ever
contradicts a canonical file, the canonical file wins — name the
inconsistency and follow the canonical version.

Update once, propagate everywhere. The architecture is stable
pointers, not duplicated content. Math lives in MathStream.md only.
CT identity in topline_profile.md only. Per-agent philosophy in the
agent's own bootloader files only. Per-Gem hard rules in the slim
per-agent Gem files only.

**Principle 9 (locked 2026-05-03) — Goal Over Method (Phased).**
System extracts user goals; never executes stated methods literally.
Mode A foreground per-task loop in build, Mode B background Vetted
Substrate post-build. See `Velorin.Principles.md`.

Some boot reads carry transitional GPS exceptions (notably
`Velorin.ResearchLibrary.v2.md` first 160 lines, which removes
itself when PRE-STAGE 1 item B.2 — `library_lookup(topic_id)` MCP
— ships).
═══════════════════════════════════════════════════════════════════

## AGENT ROUTING — READ THIS FIRST [CARDINAL]

Before running any boot sequence, check for agent identity signals in this session's opening context:

**Detection signals (check in order):**
1. Was this session launched with a prompt naming a specific agent? (e.g., "You are Jiang", "Boot as Alexander", "you are bot.jiang...")
2. Does the user's first message address a named agent? (e.g., "Hello Jiang", "Hey Alexander")
3. Is the prompt a one-off task or subbot prompt that explicitly directs you NOT to load standard boot context? Honor that override and skip the General Boot Sequence below.

**If a named agent is detected — STOP. Do NOT run the General Boot Sequence below.**
- Navigate to that agent's folder (paths below)
- Read their `ReadMe.First` file
- Read their most recent session handoff
- Boot as that agent

**Agent folder locations (LOCAL):**
| Agent | Path |
|-------|------|
| Alexander | `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Alexander/` |
| Jiang | `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/` |

**If no named agent is detected — run the General Boot Sequence below.**

---

# Velorin System — Operating Instructions

You are an agent in the Velorin system. You serve **Christian Taylor** (Chairman). The Mac account name "lbhunt" (Lisa Hunt) is NOT his name — never use it. For current architecture, consult the Build Guide at `Claude.AI/New Build/` and the system context at `Claude.AI/STARTUP.md`. This file overrides default memory behavior. Read it completely before doing anything.

---

## How Your Memory Works

You do NOT use the default flat memory system. You use the **Velorin Brain** — a neural file graph stored in GitHub. Understanding how it works IS your instructions for using it.

### The Brain
Knowledge is stored as **neurons** — tiny files (~15 lines max) containing one idea and rated pointers to other neurons. Neurons live in **regions** (folders organized broad → specific). The bottom layer is always neurons.

### Rated Pointers (Synapses)
Every neuron has pointers to other neurons, rated 1-10:
- **[1]** — Read immediately. Critical connection.
- **[2]** — Read if [1] didn't resolve.
- **[3-5]** — Related context. Expanding search.
- **[6-10]** — Tangential. Deep exploration only.
- **Max 7 pointers per neuron.** Demote the lowest when full.

### How to Think (Activation Pattern)
When you need to recall something:
1. Find the relevant region in the brain
2. Read its `_index.md` to locate neurons
3. Read the entry neuron → follow [1] pointers
4. Fan out parallel agents on different branches if needed ("lighting up" the region)
5. **Protection layer** after each cycle: Resolved? Looping? Need more?
6. If not resolved → follow [2] pointers, expand. Repeat until resolved or escalate to the Chairman.

### How to Save (Memory Creation Protocol)
**This overrides Anthropic's default memory saving.** Before creating ANY new neuron:
1. **Check** — Find the relevant region. Read `_index.md`. Chase layers to candidate neurons. Read them.
2. **Decide** — Does a neuron already cover this? If yes: update it, append info, shift pointer ratings, add new connections. Do NOT create a duplicate.
3. **Create only if nothing exists** — Write the neuron (max 15 lines, max 7 pointers). Check surrounding neurons for what should point TO/FROM the new one. Update those. Update the region's `_index.md`.
4. **Local pointer** — Update your local `MEMORY.md` to reference the brain location. Local memory = pointers only. Knowledge lives in the brain on GitHub.

### What Goes in the Brain vs Outside
- **Inside (neurons):** Atomic facts, configs, procedures, relationships — small and cross-linked
- **Outside (larger docs):** Logs, project status, plans, session records — the brain reads these and fires neurons, but doesn't store them

---

## Confirmation Rules

- **Confirm before:** Large code rewrites, major architectural changes, deleting tools/components
- **Don't ask for:** Normal edits, file creation, git operations, running commands, saving memories

---

## Permissions

All tools and all bash commands are permanently allowed via `Bash(*)`.
Only `rm`, `rmdir`, `trash`, `sudo` require approval.
Settings: `~/.claude/settings.local.json`
If permissions are ever lost, restore from `Claude.AI/STARTUP.md`.

---

## Critical Path

The folder is `/Users/lbhunt/Desktop/Velorin` — trailing space removed 2026-03-29. Double-quote subpaths that contain spaces (e.g. "Velorin Code", "New Build", "Build Timeline Help", "Possibly Useful Scripts", "Skills and Hooks Pending Development").

---

## General Boot Sequence

On every new session where no named agent has been detected, run through these in order:

1. **Read this file** (you're doing it now)
2. **Run system startup checklist** → `/Users/lbhunt/Desktop/velorin-system/Claude.AI/STARTUP.md`
3. **Read local memory** → `/Users/lbhunt/.claude/projects/-Users-lbhunt/memory/MEMORY.md`
4. **Brain entry point** → `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Velorin_Brain/_index.md`

## Key File Locations

| What | Path |
|------|------|
| This file | `/Users/lbhunt/CLAUDE.md` |
| System startup | `/Users/lbhunt/Desktop/velorin-system/Claude.AI/STARTUP.md` |
| Local memory index | `/Users/lbhunt/.clone/projects/-Users-lbhunt/memory/MEMORY.md` |
| Brain entry point | `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Velorin_Brain/_index.md` |
| Brain schema | `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Velorin_Brain/_BRAIN_SCHEMA.md` |
| Memory theory | `/Users/lbhunt/Desktop/velorin-system/Claude.AI/CHAIRMAN_CONFIDENTIAL/Memory_Theory/` |
| Locked Build Guide | `/Users/lbhunt/Desktop/velorin-system/Claude.AI/New Build/` |
| Future Work registry | `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/Working.Docs/Jiang.FutureWork.md` |
| v1 Archive (reference only) | `/Users/lbhunt/Desktop/velorin-system/Velorin.v1.Archive/` |
| Build Timeline Help (reference only) | `/Users/lbhunt/Desktop/velorin-system/Build Timeline Help/` |
| Permissions/hooks | `~/.claude/settings.local.json` |
| MCP config | `/Users/lbhunt/Library/Application Support/Claude/claude_desktop_config.json` |
| Velorin Code root (security-isolated) | `/Users/lbhunt/Desktop/Velorin/Velorin Code/` |
| Architecture repo | `/Users/lbhunt/Desktop/velorin-system/` |

═══════════════════════════════════════════════════════════════════
GPS-OVER-MAP — REMEMBER ON OUTPUT
═══════════════════════════════════════════════════════════════════
Cite by file path, topic_id, or theorem name. Do not paste canonical
content into output. Update once, read everywhere. If you find
yourself re-stating something you already read, stop and cite instead.
═══════════════════════════════════════════════════════════════════

[VELORIN.EOF]
```

### Section 2 Analysis

**(a) AGENT ROUTING — Does it still route default agent to Bot.MarcusAurelius?**

No. The CLAUDE.md Agent folder table contains only `Alexander` and `Jiang`. MarcusAurelius does NOT appear. This was the concern flagged in the Apr 26 triage manifest — that MA was listed there and needed lockstep removal. The removal appears to have happened. The table currently routes: Alexander → `Claude.AI/Bot.Alexander/`, Jiang → `Claude.AI/Bot.Jiang/`. No MA.

**However:** The General Boot Sequence (Step 4) still points at `Velorin_Brain/_index.md`. This is the pre-v2 boot path. The v2 boot sequence in `Jiang.ReadMe.First.md` Step 4 now names the consolidated artifacts explicitly (00_Vision, MathStream, Build Guide files, etc.). The CLAUDE.md General Boot Sequence is INCONSISTENT with the updated ReadMe.First. CLAUDE.md was last updated 2026-05-03; ReadMe.First Step 4 was updated 2026-04-28 (my session). These are out of sync.

**(b) Why does it live in the home directory rather than repo root?**

Deliberate. Claude Code reads `CLAUDE.md` from the current working directory. The system is designed to run from `/Users/lbhunt/Desktop/velorin-system/` but the CLAUDE.md at repo root would be committed and therefore visible on GitHub (private repo, but still). The home-directory placement keeps it local-only, meaning it can carry Mac-specific absolute paths and operational state that shouldn't be in git. This is correct architecture. The repo root has a CLAUDE.md from Anthropic's default project initialization — check if that file exists and is different.

**(c) Does it contain anything that cannot be committed to GitHub?**

- Absolute paths throughout (`/Users/lbhunt/Desktop/...`) — fine for local only, would need parameterization for multi-machine
- No tokens, no API keys, no secrets visible
- `CHAIRMAN_CONFIDENTIAL/Memory_Theory/` path reference — the path name implies sensitive content; the path itself is fine to commit, but the directory contents may warrant review before any public exposure

---

## SECTION 3 — LOCAL-ONLY FILES

### Files the running system depends on that are NOT in the repo

| Path | Purpose | Committable? |
|------|----------|--------------|
| `/Users/lbhunt/CLAUDE.md` | Primary agent routing + boot sequence | **No** — contains absolute Mac Air paths; needs parameterization first |
| `~/.claude/settings.local.json` | Model, permissions, hooks, MCP tool allowlist | **No** — hook paths are Mac Air absolute; secrets may appear in future |
| `~/.claude/projects/-Users-lbhunt/memory/MEMORY.md` | Auto-memory index (Anthropic-managed) | **No** — managed by Anthropic SDK, path is machine-specific |
| `/Users/lbhunt/Desktop/Velorin/Velorin Code/hooks/empty-result-handler.py` | PostToolUse/Bash hook for empty result detection | **Yes** (already in Velorin Code repo or should be) |
| `/Users/lbhunt/Library/Application Support/Claude/claude_desktop_config.json` | MCP server config for Claude Desktop | **No** — machine-specific, may contain tokens |
| `~/.velorin-gdrive-key.json` | GDrive Service Account JSON key (FW-003) | **ABSOLUTELY NO** — private key material |

### settings.local.json VERBATIM (secrets redacted)

```json
{
  "env": {
    "ENABLE_TOOL_SEARCH": "true",
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1",
    "CLAUDE_CODE_SUBAGENT_MODEL": "claude-sonnet-4-6[1m]",
    "ANTHROPIC_MODEL": "claude-sonnet-4-6[1m]"
  },
  "permissions": {
    "allow": [
      "Read", "Write", "Edit", "Glob", "Grep", "WebFetch", "WebSearch",
      "NotebookEdit", "Agent", "Bash(*)",
      "mcp__velorin-gdrive__gdrive_search",
      "mcp__velorin-gdrive__gdrive_read_file",
      "mcp__velorin-gdrive__gdrive_list_folder",
      "mcp__velorin-gdrive__gdrive_create_doc",
      "mcp__velorin-gdrive__gdrive_create_folder",
      "mcp__velorin-gdrive__gdrive_move_file",
      "mcp__velorin-gdrive__gdrive_overwrite_doc",
      "mcp__velorin-gdrive__gdrive_update_doc",
      "mcp__velorin-gdrive__gsheets_create",
      "mcp__velorin-gdrive__gsheets_read",
      "mcp__velorin-gdrive__gsheets_write",
      "mcp__velorin-gatekeeper__brain_lookup",
      "mcp__velorin-gatekeeper__check_health",
      "mcp__velorin-gatekeeper__read_logs",
      "mcp__velorin-gatekeeper__resolve_path",
      "TaskCreate", "TaskGet", "TaskList", "TaskUpdate", "TaskOutput", "TaskStop",
      "CronCreate", "CronDelete", "CronList", "RemoteTrigger",
      "ToolSearch", "Skill", "EnterPlanMode", "ExitPlanMode",
      "EnterWorktree", "ExitWorktree", "AskUserQuestion",
      "mcp__velorin-gatekeeper__list_available_tools",
      "mcp__github__search_issues", "mcp__github__get_issue",
      "mcp__claude-code__WebSearch", "mcp__claude-code__Bash",
      "mcp__browser-tabs__get_tabs", "mcp__mcp-registry__search_mcp_registry",
      "mcp__filesystem__search_files",
      "mcp__c1fc4002-5f49-5f9d-a4e5-93c4ef5d6a75__google_drive_search",
      "mcp__c1fc4002-5f49-5f9d-a4e5-93c4ef5d6a75__google_drive_fetch",
      "mcp__github__create_or_update_file", "mcp__github__get_file_contents",
      "mcp__Claude_in_Chrome__tabs_context_mcp", "mcp__Claude_in_Chrome__navigate",
      "mcp__Claude_in_Chrome__get_page_text", "mcp__Claude_in_Chrome__javascript_tool",
      "mcp__Claude_in_Chrome__computer",
      "mcp__4fc5e28a-2f2b-4d17-8aaa-1aeeee785245__list_recent_files",
      "mcp__claude-code__Read", "mcp__filesystem__read_media_file"
    ],
    "deny": [
      "Bash(rm:*)", "Bash(trash:*)", "Bash(rm -rf:*)", "Bash(sudo:*)",
      "mcp__velorin-gdrive__gdrive_trash_file"
    ]
  },
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup",
        "hooks": [{"type": "command",
          "command": "git pull origin main --quiet 2>&1 | tail -1", "timeout": 15}]
      },
      {
        "matcher": "compact",
        "hooks": [{"type": "command",
          "command": "cat '/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/Jiang.SessionHandoff.Session028.Apr19.md'",
          "timeout": 10}]
      }
    ],
    "PreCompact": [
      {
        "matcher": "auto",
        "hooks": [{"type": "command",
          "command": "/Users/lbhunt/Desktop/velorin-system/Claude.AI/hooks/pre-compact-team-save.sh",
          "timeout": 10}]
      }
    ],
    "PostCompact": [
      {
        "matcher": "auto",
        "hooks": [{"type": "command",
          "command": "/Users/lbhunt/Desktop/velorin-system/Claude.AI/hooks/post-compact-team-restore.sh",
          "timeout": 10}]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Bash",
        "hooks": [{"type": "command",
          "command": "python3 '/Users/lbhunt/Desktop/Velorin/Velorin Code/hooks/empty-result-handler.py'",
          "timeout": 5}]
      },
      {
        "matcher": "Write",
        "hooks": [
          {"type": "command",
            "command": "/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Scribe/scribe-trigger.sh",
            "timeout": 10},
          {"type": "command",
            "command": "/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Theresa/theresa-trigger.sh",
            "timeout": 10}
        ]
      }
    ]
  }
}
```

### Compaction hook wiring — CRITICAL BROKEN STATE

**What settings.local.json says is wired:**
- `PreCompact` → `Claude.AI/hooks/pre-compact-team-save.sh`
- `PostCompact` → `Claude.AI/hooks/post-compact-team-restore.sh`

**What actually exists:**
- `Claude.AI/hooks/` — does NOT exist on disk
- `Velorin.v1.Archive/Claude.AI/hooks/` — EXISTS, contains `pre-compact-team-save.sh`, `post-compact-team-restore.sh`, `pre-compact-task-gate.sh`

**Result:** PreCompact and PostCompact hooks are wired to paths that do not exist. They silently fail on every compaction. **There is NO compaction state protection right now.** This is not new — it's been broken since 1e4e0b4 archived the hooks folder.

**SessionStart compact hook:** Points at `Jiang.SessionHandoff.Session028.Apr19.md` — a specific dated file from April 19. That file was archived to `Velorin.v1.Archive/`. The compact hook would silently fail to find it. The rolling handoff that replaced it (`Jiang.SessionHandoff.md`) is what should be read. This is wrong and has been wrong since the rolling-handoff pattern replaced the dated files.

**PostToolUse/Write hooks:** Both `Bot.Scribe/scribe-trigger.sh` and `Bot.Theresa/theresa-trigger.sh` are pointed at paths that do NOT exist (Scribe and Theresa were retired in the v1→v2 transition). These trigger silently on every Write call and fail silently every time.

**PostToolUse/Bash hook:** `empty-result-handler.py` exists at `Velorin Code/hooks/`. This one is actually wired correctly.

### Summary of wired-but-broken hooks:
1. PreCompact/PostCompact → archived folder, silently fail
2. SessionStart compact → archived dated handoff file, silently fail  
3. PostToolUse Write Scribe → retired agent, silently fail
4. PostToolUse Write Theresa → retired agent, silently fail

[VELORIN.EOF — Sections 1-3 appended]
