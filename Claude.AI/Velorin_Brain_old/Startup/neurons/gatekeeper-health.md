# Neuron: Gatekeeper Health Check

Verify Gatekeeper is running in the MCP server list.
Should appear as `node .../velorin-gatekeeper/server.js` in process list.
Starts automatically with Claude Desktop (configured in desktop config).
Also configured in Claude Code user config (`~/.claude.json`).

If not running: restart Claude Desktop. Check logs at:
`/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gatekeeper/logs/`

## Pointers
- [1] `../../MCP/neurons/gatekeeper-mcp.md` — server details
- [2] `./mcp-boot-check.md` — part of the overall MCP boot check
