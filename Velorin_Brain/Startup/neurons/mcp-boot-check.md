# Neuron: MCP Boot Check

Verify MCP servers are running:
`ps aux | grep -E "(node.*server\.js|mcp-shell|claude.*mcp)" | grep -v grep`

Expected: velorin-gdrive (node server.js) and claude-code (claude mcp serve).
GitHub and bash MCP start on-demand — may not show until first use.
If missing: reopen Claude Desktop app.

## Pointers
- [1] `../../MCP/neurons/gdrive-server.md` — primary server to check
- [1] `../../MCP/neurons/claude-code-mcp.md` — second server to check
- [2] `./token-health-check.md` — next step after verifying servers
