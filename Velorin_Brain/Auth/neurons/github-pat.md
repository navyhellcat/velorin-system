# Neuron: GitHub PAT

Personal access token for navyhellcat GitHub account.
Stored in Claude Desktop config under github MCP server env:
`/Users/lbhunt/Library/Application Support/Claude/claude_desktop_config.json`

Used by: GitHub MCP server, git push (via osxkeychain or temp URL embed).
If expired: generate new one at GitHub > Settings > Developer settings > PATs.

## Pointers
- [1] `../../MCP/neurons/github-mcp.md` — MCP server that uses this PAT
- [1] `./git-credentials.md` — how PAT is used for git push
- [1] `./github-visibility-rule.md` — CRITICAL: visibility change constraints
- [2] `../../MCP/neurons/mcp-config-location.md` — file where PAT lives
- [3] `../../Architecture/neurons/github-repos.md` — repos that need this PAT
