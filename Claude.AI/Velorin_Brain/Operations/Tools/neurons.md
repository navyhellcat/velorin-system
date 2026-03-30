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
Claude Code on Sonnet 4.6 runs a **200K token context window** — NOT 1M. Session monitor T009 confirmed at 45% with ~90K tokens used. The 1M window is NOT the default; it may require enterprise API configuration or a specific flag (unresolved — investigate separately). Never assume 1M context when planning session capacity or token budgets.
last-touched: 2026-03-30
Pointers: [1] neurons.operations.startup.A4 | [2] A6 | [3] neurons.agents.protocols.A5
