# Neuron: Path Resolution

The trailing space in "Velorin " causes silent failures across all bots.
The Gatekeeper solves this at the source instead of hardcoding paths in every bot.

How it works:
- Bot asks `resolve_path("velorin code")` → gets correct quoted path
- Bot uses wrong path → Gatekeeper corrects it (CORRECTION_MAP in server.js)
- Unknown path → logged as suspicious in security.log

This replaces per-bot path documentation. No bot needs hardcoded paths.

## Pointers
- [1] `./trailing-space.md` — the root cause problem
- [1] `../../MCP/neurons/gatekeeper-mcp.md` — the server that does this
- [2] `./project-paths.md` — all known paths (source of truth for the map)
