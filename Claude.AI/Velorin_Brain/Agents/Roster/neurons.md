# neurons.agents.roster

## A. Active Bots

### A1. Alexander
Claude Desktop app bot. GUI-based. Manages MCP servers (start/stop with app). Accesses filesystem via bash/claude-code MCP, GitHub via github MCP, Google Drive via velorin-gdrive MCP.
last-touched: 2026-03-28
Pointers: [1] neurons.agents.protocols.A4 | [1] A2 | [1] neurons.agents.protocols.A1 | [2] neurons.connectivity.mcp.A6 | [2] neurons.agents.protocols.A2 | [2] neurons.connectivity.mcp.A4

### A2. MarcusAurelius
Claude Code CLI bot. Runs in terminal. Master instructions: `/Users/lbhunt/CLAUDE.md`. Local memory: `~/.claude/projects/-Users-lbhunt/memory/MEMORY.md`. Startup doc: `Claude.AI/Bot.MarcusAurelius/STARTUP.md`. Permissions: `Bash(*)` wildcard. MCP: velorin-gdrive, velorin-gatekeeper, github.
last-touched: 2026-03-28
Pointers: [1] A4 | [1] neurons.agents.protocols.A4 | [1] A1 | [1] neurons.agents.protocols.A1 | [2] neurons.agents.protocols.A3 | [2] neurons.agents.protocols.A2 | [2] neurons.operations.startup.A5

### A3. Gatekeeper
Parallel watcher bot. Runs as MCP server 24/7. Not a blocker — watches, corrects paths, checks health, searches brain, reads logs.
last-touched: 2026-03-28
Pointers: [1] neurons.connectivity.mcp.A3 | [2] neurons.agents.protocols.A1 | [2] A2

### A5. Jiang
Claude Desktop app bot (default as of 2026-03-30). Previously browser-based. Read/write capable. Manages long-context research tasks. Future: mobile agent planned (minimal boot, low token load — not yet built).
last-touched: 2026-03-30
Pointers: [1] A1 | [1] neurons.agents.protocols.A4 | [2] A2 | [2] neurons.agents.protocols.A1

### A4. Chairman Identity
The system serves one human — the Chairman. All bots reference this identity. The Chairman's name, cognitive profile, and behavioral patterns are loaded from their profile hard memory on boot. Never use machine account names. Current Chairman: Christian Taylor. Mac account "lbhunt" is NOT his name.
last-touched: 2026-03-28
Pointers: [1] A2 | [1] A1 | [2] neurons.agents.protocols.A2 | [3] neurons.principles.coredrives.A1
