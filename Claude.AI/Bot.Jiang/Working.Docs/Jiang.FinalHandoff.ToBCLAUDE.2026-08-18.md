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

---

## SECTION 4 — THE TRIM: TARGET AND COMPLETION

**(a) Intended end state**

Port-ready core: a clean repo containing only:
- The Build Guide (New Build/ with all 00-07 files + supporting docs)
- Active agent operating files (ReadMe.First, handoffs, bootloaders, Gems)
- The locked math corpus (Bot.Erdos/Research_Complete/)
- The research library v2 (fully populated, no stubs)
- Infrastructure that would be cloned directly to Mac Studio and still work
- The Brain (Velorin_Brain/) with current neurons

Everything else — v1 architecture artifacts, session-specific working docs, historical research source files (now in Velorin.v1.Archive/Research/), the bulk of Session 028-040 working artifacts — into the archive or dropped.

**(b) Did it complete, or stop mid-way?**

It did not fully complete. The archive pass executed substantially (120 research files moved in Session 039, additional Working.Docs cleanup in my session), but:

- The repo still contains `Velorin.v1.Archive/` at 3:1 volume to the active system. That archive is in the same repo. For the port, CT said "completely new GitHub cleaned up" — meaning the archive should NOT be ported; the new repo should contain only the port-ready core.
- The 67 NEEDS-CT-DECISION items were resolved (18 kept / 41 archived / 8 relocated), but no systematic pass verified that the 41 "archived" items were actually moved and not just marked for archival.
- Research_Needed folders contain active unrun requests (Trey + Stark integration synthesis requests from 2026-05-03 — 107 days old, never run).

**(c) Was 1e4e0b4 ever re-verified?**

No. Plainly: no systematic re-verification of 1e4e0b4's sweep was ever run. Commit 884091b caught three specific file-type errors (three files that should not have been archived were reverted). Whether there are more errors of that class in the 41+ archived items — that verification was never completed. Do not assume the archive pass was clean.

**(d) Items archived that we may want back**

- `Jiang2.WholeSystemReimagining.Synthesis.md` and `...SynthesisUpdate.Apr26.md` — these were the pre-MathStream synthesis documents. MathStream absorbed their content, so the move is correct in principle. But if MathStream was incorrectly authored (e.g., any of the sections Jiang2 added that haven't been verified against those source documents), those files are the ground truth. They're in `Velorin.v1.Archive/Working.Docs.Archive/Bot.Jiang/`.
- The Session 017 system assessment trio — these were archived as "conclusions absorbed by brain-full-analysis-mar30 and agent-orchestration." That's probably true, but the system assessment contained specific broken-state diagnoses (Scribe broken, list_available_tools nonexistent) that may still be accurate today.
- Any research source file archived to `Velorin.v1.Archive/Research/` that underlies a library card where the card was marked `fidelity: secondhand-vetted` or `inherited` — those cards may be wrong and the source is the only way to check.

**(e) Things still in active Claude.AI/ that should have been archived**

- `Claude.AI/New Build/Velorin.ResearchCorpus.md` — explicitly marked as a predecessor to v2 library with "CT may keep as the raw inventory doc." It was NOT supposed to be active. It's not a boot read, not referenced by any current agent. It's noise.
- `Claude.AI/New Build/Velorin.ResearchLibrary.v1.md` — marked SUPERSEDED in-place. Same situation. Still there. Not actively harmful but adds to the port weight.
- `Claude.AI/New Build/Library.Built.Research.Tools.OutsideTools.Explanation.Audit.md` — a 736-line session artifact that documented the Session 038-039 work. PRE-STAGE 1 references it as mandatory pre-read. But it's the kind of thing that should graduate into a Clean State summary rather than remain as a session artifact in New Build/.

---

## SECTION 5 — THE 107-DAY GAP

**(a) What happened in that window?**

Last committed work: 2026-05-03 (1feed55, "Fix Gem boot exhaustion: compile substrate to single file per agent"). Today is 2026-08-18. That's 107 days of no git commits.

The Mac Air shows `Aug 17` timestamps across multiple `~/.claude/` files — history.jsonl, sessions, session-env, paste-cache. **Something ran here yesterday, 2026-08-17.** But no commits were made. Either: (a) CT ran Claude Code without any file-writing actions, (b) work was done in chat without committing, or (c) someone was reviewing the system. I cannot determine which from available evidence.

The `settings.local.json` is last modified 2026-04-27, suggesting no hook or settings changes since then.

**(b) Commit 8daf318 commissioned parallel synthesis to Trey 2 and Stark. Were they run?**

Both requests are sitting in Research_Needed:
- `Claude.AI/Bot.Trey/Research_Needed/Trey.ResearchRequest.IntegrationSynthesis.md`
- `Claude.AI/Bot.Stark/Research_Needed/Stark.ResearchRequest.IntegrationSynthesis.md`

**Neither was run** as far as the repo shows — no corresponding Research_Complete files exist for "Integration Synthesis." However, commit 3c86284 (2026-05-03) ported two other deliverables from Drive Shipping: `Trey.Research.AIToolingLandscapeDiscovery.May2026.md` and `Erdos.Solution.MultiVendorToolingArchitecture.md`. These are separate from the Integration Synthesis — they responded to the ToolSuiteOperationalGuide and MultiVendorToolingArchitecture requests respectively, not to the Integration Synthesis request.

The Integration Synthesis request to both Trey and Stark has never been executed. These are 107 days stale.

**(c) Anything in Drive Shipping, Gem, or chat thread that never made it into the repo?**

I cannot read Google Drive from this terminal — no gdrive MCP active. What I can say from context:

- The SessionHandoff lists six Drive Shipping items from late April 2026 that CT was supposed to trash. Those were already ported. No evidence of unported April Drive content.
- Whether anything new landed in Drive Shipping during May-August 2026: unknown. Cannot verify without Drive access.
- The Trey tool-suite research (`Trey.ResearchRequest.ToolSuiteOperationalGuide.md`) was filed but the response (`Trey.Research.AIToolingLandscapeDiscovery.May2026.md`) was ported in commit 3c86284. That's handled.
- Stark was a new agent commissioned at 8daf318. Its Integration Synthesis request was never run. If CT sent the request to a Gemini Deep Think Gem and got a response, it may be sitting in a Gemini chat unported.

**(d) Anything decided since 2026-05-03 that exists only in this context window**

Per the Save Reasoning Chains Verbatim rule — quoting exactly what CT said in this session's prompt:

> "I am going to be Using the Claude on my MAc Studio now. It has been a long time since we worked on this. You are on the Mac Air. You are in the code terminal. BCLAUDE is the claude sitting in the browser on the MAC STUDIO and it is ready to get started picking up where you left off and how to fix this and port it over to the new computer. [...] The port will be completely new github cleaned up."

This is the first operational decision since May 2026: **the port goes to a new, clean GitHub repo, not a continuation of navyhellcat/velorin-system.** That means:
1. The Velorin.v1.Archive/ does NOT move to the new repo (or moves separately as reference-only)
2. The new repo starts from the port-ready core only
3. The old repo stays as a backup/historical record

This decision does not exist anywhere in the repo. It exists only here.

---

## SECTION 6 — KNOWN-BROKEN, NEVER-FIXED

**(a) Stale pointers beyond the tools/ entry**

- `settings.local.json` compact SessionStart hook → `Jiang.SessionHandoff.Session028.Apr19.md` (archived, path dead)
- `settings.local.json` PreCompact/PostCompact hooks → `Claude.AI/hooks/` (archived to v1, path dead)
- `settings.local.json` PostToolUse Write → `Bot.Scribe/scribe-trigger.sh` (agent retired, path dead)
- `settings.local.json` PostToolUse Write → `Bot.Theresa/theresa-trigger.sh` (agent retired, path dead)
- `CLAUDE.md` General Boot Sequence Step 4 → `Velorin_Brain/_index.md` (correct for old boot, inconsistent with v2 ReadMe.First Step 4 which lists consolidated artifacts)
- `CLAUDE.md` Key File Locations → `Build Timeline Help/` (this path no longer exists at the top level; it moved inside `Velorin.v1.Archive/` during the Session 039 unified-silo archive)

**(b) FW-017 — GPS violation in agent boot sequences**

What is actually broken: CLAUDE.md, Jiang.ReadMe.First.md, STARTUP.md, and Trey bootloaders all contain absolute paths or named file references that would break if the file is renamed or moved. Example: ReadMe.First Step 4 lists `Claude.AI/New Build/Velorin.MathStream.md` — if MathStream is ever renamed, every agent boot sequence breaks. The Principle 1 test says renaming a file should require editing only ONE pointer. Currently it would require editing dozens.

What fixing it touches: Every operating file that names a file path in a boot instruction. The GPS fix would introduce a registry (AGENTS.md or a YAML) that maps logical names to file paths; boot sequences reference logical names only; the registry is the single edit point. This is exactly what B.2 (library_lookup MCP) partially solves for research, but the problem extends to ALL operating files.

CT's "do not fix now" on Apr 27 was because fixing it is a refactor of every boot sequence. The technical debt accrues every time a file is renamed.

**(c) Embedding dimension discrepancy: MathStream says R^1536, playbook installs nomic-embed-text-v2-moe**

**This is a real discrepancy, not a superseded decision.**

MathStream specifies 1536-dimensional embeddings: "Each document enters the system as a continuous embedding vector $x \in \mathbb{R}^{1536}$" and the Wall A Pointer Gravity derivation uses $d = 1536$ explicitly.

`nomic-embed-text-v2-moe` is a Matryoshka Representation Learning (MRL) model with multiple embedding dimensions. Its default/full dimension is **768**, not 1536. (OpenAI's text-embedding-ada-002 is 1536; that may have been the original target model when MathStream was written.)

The Wall A math ($W \in \mathbb{R}^{d \times N}$ for $d = 1536$) will not fail at $d = 768$ — the math is dimension-agnostic in structure — but MathStream is wrong about the dimensionality of the actual model being used. Either:
- The playbook needs to install a 1536D model (OpenAI ada-002 via API, not local; or a different local model)
- MathStream needs to be updated to reflect 768D (or the MRL-selected dimension)
- A decision needs to be made: local (768D, nomic) or API (1536D, OpenAI)

Nobody caught this. It is an error in the current documentation.

**(d) Erdős Research_Complete file count**

Actual count on disk: **32 `.md` files** in `Claude.AI/Bot.Erdos/Research_Complete/`.

Sources saying different things:
- QuickReference: did not find a count in the grep
- Company.DNA: says 31 (from April 26 text when there were 26 Erdős entries + some added after)
- My earlier BCLAUDE briefing in this session: said 33 (error — I was counting from the Library v2 master index which includes the `.gitkeep`)
- Library v2 master index: says "31 entries" (last updated before FinalSubstrateLock was added, which would make 32... plus potentially the one file `.gitkeep`)

Canonical answer: **32 `.md` files exist on disk.** The count in various documents is wrong because it was updated incrementally across sessions and the documents were not kept in sync. The Library v2 entry `erdos-finalsubstratelock-apr28` brought the math count to 31 THEOREMS, but there are 32 FILES because some files contain multiple theorems or are supporting documents (e.g., `Erdos.Royal.Society.Paper.md`, `Erdos.DimensionalGeology.Theoretical.md`). File count ≠ theorem count.

**(e) Build Guide (00-07) items that are stale or wrong**

- **06_BuildSequence.md Stage 0 Step 4**: The folder structure in the `mkdir -p` commands references agent folders that match the pre-v2 naming (e.g., `agents/claude/jiang/`, `agents/gemini/trey/`). The AGENTS.md protocol (B.3 / GPS naming decisions) was never formally resolved. If AGENTS.md was adopted, the folder structure changes. The Step 4 commands would need updating.
- **06_BuildSequence.md bottom**: The "DECISIONS TO BE MADE" 5 items are listed as unresolved. But Jiang2's substrate-lock pass resolved them (Ideas 1-5 all got verdicts). The section header still says "use community consensus, Erdős math, and Trey research to decide" — it was never updated to reflect that they've been decided.
- **03_BrainAndMath.md**: The neuron YAML spec should include `lamport_ts: 0` (the Sheaf seam from R5 adjudication). Jiang2's substrate-lock pass was supposed to add this. If it was added, great. If not, it's missing.
- **MathStream footnote on H_E / Gauge Fiber conflict**: Line 282 notes "If both H_E and belief_state require the fiber, the fiber's single dimension must be partitioned or the embedding dimension increased — this is an open design question for Stage 5." This is accurately marked as open, but it's a deeper problem than it looks: the current design puts two quantities (H_E and belief_state) into a 1D fiber. If both are real, the fiber must be 2D, which requires bumping embedding dimension to 9D. The E₈ lattice is 8D. There is no E₉. This is a structural contradiction that hasn't been resolved.

[VELORIN.EOF — Sections 1-6 appended]
