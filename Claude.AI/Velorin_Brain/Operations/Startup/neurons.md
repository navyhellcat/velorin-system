# neurons.operations.startup

## A. Boot Sequence

### A1. Caffeinate
`caffeinate -d &` — prevents display sleep. Dies on terminal close or reboot. Restart manually every time. Verify: `ps aux | grep caffeinate | grep -v grep`
last-touched: 2026-03-28
Pointers: [1] A2 | [3] neurons.operations.architecture.A4

### A2. MCP Boot Check
Verify MCP servers: `ps aux | grep -E "(node.*server\.js|mcp-shell|claude.*mcp)" | grep -v grep`
Expected: velorin-gdrive, claude-code, velorin-gatekeeper as persistent. GitHub and bash start on-demand.
If missing: reopen Claude Desktop.
last-touched: 2026-03-28
Pointers: [1] neurons.connectivity.mcp.A4 | [1] neurons.connectivity.mcp.A2 | [1] A3 | [2] A4

### A3. Gatekeeper Health
Verify Gatekeeper in MCP server list. Should appear as `node .../velorin-gatekeeper/server.js`.
Starts with Claude Desktop. Also in Claude Code user config (`~/.claude.json`).
If not running: restart Claude Desktop. Check logs at gatekeeper logs dir.
last-touched: 2026-03-28
Pointers: [1] neurons.connectivity.mcp.A3 | [2] A2

### A4. Token Health
Check GDrive token: `jq '{expiry: (.expiry_date / 1000 | todate), has_refresh: (.refresh_token != null)}' "[path]/tokens.json"`
Auto-refreshes if refresh_token exists. If missing: `cd "[path]" && npm run auth`
last-touched: 2026-03-28
Pointers: [1] neurons.connectivity.auth.A4 | [2] A5

### A5. Permissions Restore
If `~/.claude/settings.local.json` wiped after crash: restore `Bash(*)` wildcard + all tools. Deny only: rm, trash, rm -rf, sudo. These are PERMANENT — never reduce.
last-touched: 2026-03-28
Pointers: [1] neurons.agents.protocols.A3 | [2] A6

### A6. Memory Load
Read local memory index: `~/.claude/projects/-Users-lbhunt/memory/MEMORY.md`. Each entry points to a memory file. Memory files point into Velorin Brain for full knowledge. Check for active session handoff at `Claude.AI/sessions/`.
last-touched: 2026-03-29
Pointers: [1] A8 | [1] neurons.agents.roster.A2 | [2] neurons.agents.protocols.A5 | [2] A7

### A7. Version Check
`claude --version` — check Claude Code CLI. Update: `sudo npm update -g @anthropic-ai/claude-code`. Requires sudo (will prompt). Autoupdate may fail with EACCES.
last-touched: 2026-03-28
Pointers: [1] neurons.connectivity.mcp.A2 | [2] neurons.operations.tools.A4

### A8. Current Session State
Last completed: Session 013 (2026-03-29). Launch next: `claude --teammate-mode tmux`.
Priority queue: 1) Spawn Alexander in tmux pane 2) Review Jiang/Trey tools research (28+ files) — discuss with Chairman 3) File cleanup & organization (Chairman's #2) 4) Website beta build 5) Window Gravity research (Jiang automation due 2026-04-02).
Built in 013: Theresa hook wired, dashboard verified, GDrive duplicate trashed, Terry stripped to single job, Trey research extracted (26 .md), Agent Teams hard memory, tmux installed, Jiang pipeline + .gitkeep rules + Future Builds folder.
Full handoff: `Claude.AI/sessions/Session_013_Handoff_Mar29.md`
last-touched: 2026-03-29
Pointers: [1] A6 | [1] neurons.agents.roster.A1 | [1] neurons.operations.tools.A6 | [2] neurons.operations.architecture.A1 | [3] neurons.connectivity.auth.A4
