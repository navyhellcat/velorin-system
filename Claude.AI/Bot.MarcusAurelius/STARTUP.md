# BOT.MarcusAurelius — Startup Process

**Run this checklist every time Claude Code starts a new conversation.**
This is the living startup sequence. We add to it as the system grows.

---

## 1. Caffeinate
```bash
caffeinate -d &
```
Prevents display sleep. Must be restarted manually after any terminal close or reboot.

## 2. Verify MCP Servers
All 4 MCP servers are configured in Claude Desktop and should auto-start with the app.
```bash
ps aux | grep -E "(node.*server\.js|mcp-shell|claude.*mcp)" | grep -v grep
```

Expected running processes:
- **velorin-gdrive** — `node .../velorin-gdrive-mcp/server.js`
- **claude-code** — `claude mcp serve`
- **github** — starts on-demand via npx (may not show until first use)
- **bash** — starts on-demand via npx (may not show until first use)

If velorin-gdrive or claude-code are missing, reopen Claude Desktop app.

## 3. Check Google Drive Token Health
```bash
jq '{expiry: (.expiry_date / 1000 | todate), has_refresh: (.refresh_token != null)}' "/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gdrive-mcp/tokens.json"
```
Token auto-refreshes. If refresh token is missing, re-run auth:
```bash
cd "/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gdrive-mcp" && npm run auth
```

## 3.3 Start Scribe Escalation Monitor
CronCreate fires every 5 minutes to check for unprocessed Scribe escalations. Must be recreated each session (7-day hard limit on all CronCreate jobs — this is a system ceiling, not a setting).
Prompt to paste:
> Run python3 "/Users/lbhunt/Desktop/Velorin/Velorin Code/hooks/scribe_escalation_check.py" via Bash. If it produces output, read that output and spawn a background subprocess for each UNPROCESSED entry using: claude --print --dangerously-skip-permissions -p "You are a Velorin Brain maintenance agent. Create the missing brain structure for this escalation: [paste full entry details]. Rules: follow _BRAIN_SCHEMA.md at /Users/lbhunt/Desktop/velorin-system/Claude.AI/Velorin_Brain/_BRAIN_SCHEMA.md. Create the region folder + _index.md and/or area folder + neurons.md as needed. Create the neuron per the suggested content. Wire pointers. Update all _index.md files. Commit with message 'Brain: create [region/area] for [memory name]'. Then update the escalation entry Status from UNPROCESSED to PROCESSED." Then mark each entry PROCESSED in escalation.md. If the script produces no output, do nothing.

(Or use CronCreate directly with that prompt, `*/5 * * * *`, recurring: true)

## 3.4 Start Terry (Shipping/Receiving Monitor)
CronCreate fires every 15 minutes. Must be recreated each session. Timer ID: T007.
Prompt to paste:
> Use CronCreate with cron `*/15 * * * *`, recurring: true, with this prompt: `cd "/Users/lbhunt/Desktop/velorin-system" && git pull origin main --quiet 2>&1; python3 -c "import os; shipping='/Users/lbhunt/Desktop/velorin-system/Claude.AI/Shipping'; receiving='/Users/lbhunt/Desktop/velorin-system/Claude.AI/Receiving'; alerts=[]; [alerts.append('[Terry] New files detected in '+name+':\n'+'\n'.join('- '+f for f in files)) for folder,name in [(shipping,'Shipping'),(receiving,'Receiving')] if (files:=[f for f in os.listdir(folder) if f!='.gitkeep']) if os.path.exists(folder)]; [print(a) for a in alerts]"`

## 3.5 Start Session Monitor
```bash
python3 "/Users/lbhunt/Desktop/Velorin/Velorin Code/hooks/session_status.py"
```
Run once on boot to confirm it's working and get initial reading. The CronCreate timer fires automatically every 5 minutes after this point — no further manual action needed. Timer ID: T009.

## 3.7 Enable 1M Context Window (if needed)
Default context is 200K. To upgrade for the session:
```bash
# In-session switch
/model sonnet[1m]
# Or launch with flag
claude --model sonnet[1m]
```
Or set permanently in `~/.claude/settings.local.json`: `"model": "sonnet[1m]"`
Note: Sonnet 1M requires "extra usage" on Max/Team/Pro plans. Opus 1M is included on Max/Team/Enterprise.

## 4. Check Claude Code Version
```bash
claude --version
```
If update needed: `sudo npm update -g @anthropic-ai/claude-code`

## 4.5 Read Session Handoff
Read current handoff from `Claude.AI/Bot.MarcusAurelius/` — `MarcusAurelius.SessionHandoff.Session[XXXX].[MonDD].md`. Carry over open tasks, decisions, and context from last session before doing anything else.

## 5. Read Memory
Check `/Users/lbhunt/.claude/projects/-Users-lbhunt/memory/MEMORY.md` for prior context.
**If any entry is marked with >>> READ FIRST <<<, open that file immediately before anything else. It contains critical in-progress work that must resume.**

## 5.1 Read Rules File
Read `/Users/lbhunt/.claude/projects/-Users-lbhunt/rules/MarcusAurelius.Rules.md` — consolidated behavioral rules, permissions, and instructions. This is authoritative. GitHub mirror: `BOT.MarcusAurelius/rules/MarcusAurelius.Rules.md`.

## 6. Verify Git Auth
```bash
cd "/Users/lbhunt/Desktop/velorin-system" && git remote -v
cd "/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gdrive-mcp" && git remote -v
```
- Credential helper is set to `osxkeychain` (global)
- If push fails with auth error, the PAT is stored in Claude Desktop config under the github MCP server env
- Temporary fix: embed PAT in remote URL to push, then immediately reset URL back to clean HTTPS
- GitHub account: **navyhellcat**

## 7. Verify Repos Are in Sync
```bash
cd "/Users/lbhunt/Desktop/velorin-system" && git fetch origin && git status
cd "/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gdrive-mcp" && git fetch origin && git status
```
If behind remote, pull before making changes:
```bash
git pull --rebase origin main
```

---

## Critical Path Reminders
- The "Velorin" folder has no trailing space (removed 2026-03-29) — double-quote subpaths with spaces e.g. "Velorin Code"
- Config: `/Users/lbhunt/Library/Application Support/Claude/claude_desktop_config.json`
- Hooks: `/Users/lbhunt/Desktop/Velorin/Velorin Code/hooks/`
- Hook scripts: `empty-result-handler.py` — PostToolUse on Bash, catches empty output
- Settings: `~/.claude/settings.local.json` — permissions, hooks config
- Architecture repo: `/Users/lbhunt/Desktop/velorin-system/` (GitHub: navyhellcat/velorin-system)
- MCP code repo: `/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gdrive-mcp/` (GitHub: navyhellcat/velorin-gdrive-mcp)
- This file: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.MarcusAurelius/STARTUP.md`

## GitHub Repos
| Repo | Local Path | Purpose |
|------|-----------|---------|
| navyhellcat/velorin-system | `/Users/lbhunt/Desktop/velorin-system/` | Architecture, docs, BOT.MarcusAurelius, sessions, tools |
| navyhellcat/velorin-gdrive-mcp | `/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gdrive-mcp/` | Google Drive MCP server (v1.3.3) |

## MCP Server Config (Claude Desktop)
| Server | Command | Notes |
|--------|---------|-------|
| velorin-gdrive | `node .../server.js` | Custom GDrive MCP, OAuth auto-refresh |
| github | `npx @modelcontextprotocol/server-github` | On-demand, uses PAT |
| bash | `npx mcp-shell` | On-demand, allowlisted commands |
| claude-code | `claude mcp serve` | Claude Code CLI as MCP |

## Permissions Policy
**These are PERMANENT. Do not reduce or reset.**

- **All tools allowed** — Read, Write, Edit, Glob, Grep, WebFetch, WebSearch, NotebookEdit, Agent
- **All bash commands allowed** — `Bash(*)` wildcard covers everything:
  - Compound commands (`&&`, `||`, pipes `|`, `;`)
  - `cd && command` chains
  - Commands with `#` comments
  - `screencapture` for screen recording
  - `open` for browser/URLs
  - All CLI tools: node, npm, git, gh, python3, curl, brew, jq, ssh, etc.
  - Any new command — no need to add individually
- **Deny list (always prompts):** `rm`, `rmdir`, `trash`, `rm -rf`, `sudo`
- **Manual confirmation required before:**
  - Large code rewrites (rewriting whole files or major refactors)
  - Large concept or architectural changes
  - Deleting any tool, MCP server, or major component
- Settings file: `~/.claude/settings.local.json`
- **If permissions get reset after a crash, restore from this file — do not rebuild from scratch**

## Velorin Brain — Neural File Graph

**Full schema:** `BOT.Alexander/VELORIN_BRAIN_SCHEMA.md` (shared across all bots)

The Velorin Brain is a neural file graph stored in GitHub (`velorin-system/Claude.AI/Velorin_Brain/`). Knowledge lives as **neurons** — tiny bottom-layer files (one idea, ~10-15 lines max) organized in **regions** (folders by topic, layered broad → specific).

**How it works:**
1. Neurons contain knowledge + **rated pointers** (1-10) to other neurons
2. Rating 1 = read immediately, Rating 2 = read if 1 didn't resolve, 3+ = expanding search
3. On a question/task: find the region → read entry neuron → follow level 1 pointers → fan out with parallel agents ("lighting up" the region)
4. **Protection layer** runs after each cycle: Resolved? Looping? Need to expand? → decides whether to stop, follow level 2 pointers, or escalate to user

**MarcusAurelius's local memory** (`~/.claude/projects/-Users-lbhunt/memory/`) stores only pointers into the brain. The actual knowledge lives in GitHub.

**Rules:**
- Neurons are TINY — one idea per file, split if over 15 lines
- Every neuron has at least one rated pointer
- Never duplicate knowledge — point to it
- Protection layer is NOT optional — always check before expanding

## Session Recovery Log
### 2026-03-28 — First Recovery
- Terminal had closed, all context lost, no memory existed
- Ran caffeinate, verified all 4 MCP servers running
- GDrive tokens valid and auto-refreshing
- Claude Code v2.1.84 — autoupdate failed (needs `sudo`)
- Created this BOT.MarcusAurelius folder and STARTUP.md
- Set git credential helper to osxkeychain
- Pulled remote changes (rebase), pushed BOT.MarcusAurelius to GitHub
- Created memory system at `~/.claude/projects/-Users-lbhunt/memory/`

---

*Last updated: 2026-03-28*
*This file is additive — add new startup steps as the system grows.*

[VELORIN.EOF]
