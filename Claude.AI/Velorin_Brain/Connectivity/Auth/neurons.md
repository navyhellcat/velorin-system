# neurons.connectivity.auth

## A. Credentials

### A1. Git Credentials
Credential helper: `osxkeychain` (global). First push: username `navyhellcat` + PAT as password. Keychain stores it. If push fails: temporarily embed PAT in remote URL, push, then reset URL back to clean HTTPS.
last-touched: 2026-03-28
Pointers: [1] A2 | [2] neurons.operations.architecture.A5

### A2. GitHub PAT
Personal access token for navyhellcat. Stored in Claude Desktop config under github MCP server env: `~/Library/Application Support/Claude/claude_desktop_config.json`. Used by GitHub MCP and git push.
last-touched: 2026-03-28
Pointers: [1] neurons.connectivity.mcp.A5 | [1] A1 | [1] A3 | [2] neurons.connectivity.mcp.A6

### A3. GitHub Visibility Rule
Private → Public requires Chairman's explicit approval. Every time. No exceptions. Public → Private is safe — proceed without asking. All other GitHub operations within PAT scope: proceed freely. Why: exposing a repo is irreversible in the moment.
last-touched: 2026-03-28
Pointers: [1] A2 | [2] neurons.operations.architecture.A5 | [3] neurons.principles.coredrives.A1

### A4. OAuth Tokens
GDrive OAuth tokens at `.../velorin-gdrive-mcp/tokens.json`. Contains access_token, refresh_token, expiry_date. Auto-refreshes. If refresh token missing: `cd "..." && npm run auth`.
last-touched: 2026-03-28
Pointers: [1] A5 | [1] neurons.connectivity.mcp.A4 | [2] neurons.operations.startup.A4

### A5. OAuth Keys File
GCP OAuth client credentials at `.../velorin-gdrive-mcp/gcp-oauth.keys.json`. Contains client_id and client_secret. Used by auth.js for initial tokens and server.js for refresh. Backup in Archival/OAuth-Credentials/.
last-touched: 2026-03-28
Pointers: [1] A4 | [1] neurons.connectivity.mcp.A4 | [3] neurons.operations.architecture.A1
