# Neuron: Token Health Check

Check GDrive token on startup:
`jq '{expiry: (.expiry_date / 1000 | todate), has_refresh: (.refresh_token != null)}' "/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gdrive-mcp/tokens.json"`

Token auto-refreshes if refresh_token exists. If missing:
`cd "/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gdrive-mcp" && npm run auth`

## Pointers
- [1] `../../Auth/neurons/oauth-tokens.md` — full token details
- [2] `./permissions-restore.md` — next startup step
