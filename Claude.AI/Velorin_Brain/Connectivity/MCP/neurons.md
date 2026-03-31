# neurons.connectivity.mcp

## A. Servers

### A1. Bash MCP
`mcp-shell` via npx. Starts on-demand. Allowlisted commands: ls, cat, mkdir, cp, mv, rm, git, node, npm, find, echo, pwd, chmod, curl, bash, python3, claude.
last-touched: 2026-03-28
Pointers: [1] A6 | [2] neurons.agents.roster.A1 | [3] neurons.operations.tools.A4

### A2. Claude Code MCP
Claude Code CLI as MCP server: `claude mcp serve`. CWD: `/Users/lbhunt/Desktop/Velorin/Velorin Code`. Lets Alexander delegate tasks to Claude Code engine.
last-touched: 2026-03-28
Pointers: [1] A6 | [1] neurons.agents.protocols.A1 | [2] neurons.operations.startup.A7 | [2] neurons.operations.architecture.A1

### A3. Gatekeeper MCP
Parallel watcher server. v0.1.0. NOT a blocker — sits alongside other servers. 4 tools: resolve_path, check_health, brain_lookup, read_logs.
last-touched: 2026-03-28
Pointers: [2] A6 | [2] neurons.agents.roster.A3 | [3] neurons.operations.architecture.A2 | [3] neurons.operations.startup.A3

### A4. GDrive Server
Custom Google Drive MCP. v1.3.3. Starts automatically via Claude Desktop. Code at `.../velorin-gdrive-mcp/server.js`.
last-touched: 2026-03-28
Pointers: [1] A6 | [1] neurons.connectivity.auth.A4 | [1] neurons.connectivity.auth.A5 | [2] neurons.operations.architecture.A1 | [3] neurons.operations.startup.A2

### A5. GitHub MCP
`@modelcontextprotocol/server-github` via npx. Starts on-demand. May not show in `ps` until first use.
last-touched: 2026-03-28
Pointers: [1] A6 | [1] neurons.connectivity.auth.A2 | [3] neurons.agents.roster.A1

### A7. Browser Tabs MCP
`@kazuph/mcp-browser-tabs` via npx. macOS AppleScript-based. Tools: `get_tabs` (all open Chrome tabs, titles + URLs by window), `close_tab`. No Chrome extension required. Added to config 2026-03-30.
Use case: enumerate all Chrome tabs to find Trey's live conversation URL → Claude in Chrome navigates directly to it → lands in booted session, no re-boot. Test confirmed: conversation URL preserves full session state.
Limitation: read + close only, macOS only, no tab adoption. Open feature: anthropics/claude-code#26591.
last-touched: 2026-03-30
Pointers: [1] A6 | [1] neurons.operations.tools.A6 | [2] neurons.agents.roster.A4 | [3] neurons.connectivity.mcp.A2

### A6. MCP Config Location
All servers configured in: `~/Library/Application Support/Claude/claude_desktop_config.json`. Claude Desktop reads on launch, starts/manages all listed servers. Servers: GDrive, GitHub, Bash, Claude Code, Filesystem, Gatekeeper, browser-tabs.
last-touched: 2026-03-30
Pointers: [1] neurons.connectivity.auth.A2 | [1] A7 | [2] neurons.operations.architecture.A3 | [3] neurons.agents.roster.A1
