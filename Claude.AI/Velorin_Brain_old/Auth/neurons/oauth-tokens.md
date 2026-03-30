# Neuron: OAuth Tokens

GDrive OAuth tokens stored at:
`/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gdrive-mcp/tokens.json`

Contains access_token, refresh_token, expiry_date. Auto-refreshes.
Check health: `jq '{expiry: (.expiry_date / 1000 | todate)}' "path/to/tokens.json"`
If refresh token missing, re-auth: `cd "...velorin-gdrive-mcp" && npm run auth`

## Pointers
- [1] `./oauth-keys-file.md` — client credentials needed for refresh
- [1] `../../MCP/neurons/gdrive-server.md` — server that uses these tokens
- [2] `../../Startup/neurons/token-health-check.md` — startup verification step
- [2] `../../Architecture/neurons/trailing-space.md` — path must be quoted
