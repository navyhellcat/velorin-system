# neurons.operations.tools

## A. Installed Software

### A1. Homebrew
macOS 12 = Tier 3 (unsupported but functional). Installed: m4, autoconf, automake, libtool, oniguruma, jq. Compiles from source — budget 5-10 min/package. Do NOT assume any package is installed — verify with `which` first.
last-touched: 2026-03-28
Pointers: [1] A3 | [2] neurons.operations.architecture.A4

### A2. Git
System git at `/usr/bin/git`. Credential helper: osxkeychain (global). Pull strategy: `--rebase` to avoid merge commits.
last-touched: 2026-03-28
Pointers: [1] neurons.connectivity.auth.A1 | [1] neurons.operations.architecture.A5

### A3. jq
JSON processor at `/usr/local/bin/jq` (v1.8.1). Installed via brew. Used for token health checks and JSON parsing in hooks. Prefer jq for simple JSON, python3 for complex logic.
last-touched: 2026-03-28
Pointers: [1] neurons.operations.startup.A4 | [2] A1

### A4. Node and NPM
Node.js at `/usr/local/bin/node` (LTS, v24.14.1). npm and npx bundled. Used for MCP servers, package management, running scripts.
last-touched: 2026-03-28
Pointers: [1] neurons.connectivity.mcp.A4 | [2] neurons.operations.startup.A7 | [3] neurons.operations.architecture.A4

### A5. Python3
System Python at `/usr/bin/python3` (v3.9). Used for hooks and automation scripts. Prefer jq for simple JSON, python3 for complex logic.
last-touched: 2026-03-28
Pointers: [1] neurons.agents.protocols.A3 | [2] A3

### A6. Claude Code Agent Teams (tool reference)
Hard memory file at `Claude.AI/tools/Claude Code/Claude_Teams.md`. Covers: setup, display modes (in-process vs tmux), spawning, communication, task coordination, limitations, Velorin integration. tmux 3.6a INSTALLED. Launch: `claude --teammate-mode tmux`.
last-touched: 2026-03-29
Pointers: [1] neurons.agents.protocols.A5 | [2] neurons.agents.roster.A2 | [3] A4 | [4] A7

### A7. Claude Code Context Window
Default: **200K tokens**. To enable 1M: use `sonnet[1m]` alias — `/model sonnet[1m]` in-session, `claude --model sonnet[1m]` at launch, or `"model": "sonnet[1m]"` in settings.local.json for permanent. Availability: Opus 1M included on Max/Team/Enterprise. Sonnet 1M requires "extra usage" on Max/Team/Pro, or full API access on pay-as-you-go. Session monitor T009 confirmed 200K default at ~90K tokens / 45%.
T009 session monitor: fires every 5 min, displays status box showing duration, context % usage, token counts, and last output size. Reads current session JSONL directly for real token counts. Plan session handoffs when context approaches 75%.
last-touched: 2026-03-30
Pointers: [1] neurons.operations.startup.A4 | [2] A6 | [3] neurons.agents.protocols.A5

### A8. GDrive File Port Method
Never route large file content through Write tool parameters. Correct pattern: `gdrive_read_file` → Python write to disk → `git commit`. Zero content through context window.
Rule: any file >2KB fetched from GDrive must be written via Python, not the Write tool.
For large results (>~10KB): tool result auto-saves to JSON at `~/.claude/projects/-Users-lbhunt/<session-id>/tool-results/<tool-id>.json` — extract with `python3 -c "import json; data=json.load(open('path')); open('out.md','w').write(data[0]['text'])"`.
Incident: Session 027 burned 13 min / 16K tokens on a 5-file copy job using Write tool instead.
last-touched: 2026-04-17
Pointers: [1] A5 | [1] A2 | [2] neurons.connectivity.mcp | [3] A7

### A9. Context Discipline — Task Execution Hard Rules
Context waste is a terminate-worthy offense. Chairman will end the session for preventable fumbling. Session 028: ~2 context windows burned on a 40-line Python fix.
Hard rules: (1) Diagnose ONCE then fix — no test-fix-push loops. (2) WebFetch fails on private repos (navyhellcat/*) — use Chrome MCP or local reads. (3) Load full toolset in one ToolSearch call at task start. (4) Batch identical fixes: N files → 1 script, 1 commit, 1 verify. (5) DOM queries beat screenshots for verification. (6) No redundant reads — if read earlier in session, skip unless content changed.
The tell: 3rd commit on same bug without root cause = guessing. STOP. Diagnose from scratch.
last-touched: 2026-04-17
Pointers: [1] A7 | [1] A8 | [2] neurons.operations.startup.A4 | [3] neurons.connectivity.mcp | [4] neurons.principles.rewardalignment.A5
