# neurons.operations.architecture

## A. Paths and Structure

### A1. Trailing Space
The folder "Velorin " has a TRAILING SPACE. ALL paths must be double-quoted or they fail silently. Never use `~` expansion. Empty command output often = unquoted Velorin path.
last-touched: 2026-03-28
Pointers: [1] A2 | [1] A3 | [2] neurons.connectivity.mcp.A4 | [2] neurons.connectivity.auth.A4

### A2. Path Resolution
Gatekeeper solves the trailing space at the source. Bot asks `resolve_path("velorin code")` → gets correct quoted path. Wrong path → Gatekeeper corrects via CORRECTION_MAP. Unknown → logged as suspicious.
last-touched: 2026-03-28
Pointers: [1] A1 | [1] neurons.connectivity.mcp.A3 | [2] A3

### A3. Project Paths
| What | Path |
|------|------|
| Velorin Code root | `/Users/lbhunt/Desktop/Velorin/Velorin Code/` |
| MCP server code | `.../velorin-gdrive-mcp/` |
| Hooks scripts | `.../hooks/` |
| Architecture repo | `/Users/lbhunt/Desktop/velorin-system/` |
| Claude Desktop config | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| Claude Code settings | `~/.claude/settings.local.json` |
| MarcusAurelius memory | `~/.claude/projects/-Users-lbhunt/memory/` |
last-touched: 2026-03-28
Pointers: [1] A1 | [2] A4

### A4. Machine 1
MacBook Air. macOS 12.7.6 (Monterey). Primary dev machine. Constraints: Homebrew Tier 3, compiles from source (5-10 min/package), no Docker/Ollama (Machine 2). Must run caffeinate.
last-touched: 2026-03-28
Pointers: [1] neurons.operations.tools.A1 | [2] neurons.operations.startup.A1 | [3] A3

### A5. GitHub Repos
Account: **navyhellcat**. Two repos:
- `velorin-system` — architecture, docs, brain, bot configs. Local: `/Users/lbhunt/Desktop/velorin-system/`
- `velorin-gdrive-mcp` — Google Drive MCP server code. Local: `/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gdrive-mcp/`
Both on `main` branch.
last-touched: 2026-03-29
Pointers: [1] neurons.connectivity.auth.A1 | [1] neurons.connectivity.auth.A2 | [2] A3 | [2] A7

### A6. Velorin Brain Structure
Neural file graph at `Claude.AI/Velorin_Brain/` in velorin-system repo. Region → Area → neurons.md. Entry: `_index.md`. Rules: `_BRAIN_SCHEMA.md`. Regions: Operations, Connectivity, Agents, Principles. Neurons indexed A-Z with numbered entries and `last-touched` timestamps. Local memory = pointers only; deep knowledge lives here.
last-touched: 2026-03-28
Pointers: [1] A3 | [1] A5 | [2] neurons.operations.startup.A1 | [3] neurons.agents.roster.A1

### A7. GitHub Is Source of Truth
GitHub is the authority for all Velorin state. The local clone is a working copy — a cache on one machine. Velorin is accessed cross-platform, cross-device, cross-agent (Alexander on Desktop, Jiang in browser, Chairman on phone). Every operation that reads repo state MUST `git pull` first. Every write MUST `git push` immediately after. No exceptions. Reading local without pulling = reading stale data.
last-touched: 2026-03-29
Pointers: [1] A5 | [1] neurons.operations.startup.A6 | [2] A3 | [3] neurons.agents.protocols.A5
