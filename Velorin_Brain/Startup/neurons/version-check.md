# Neuron: Version Check

`claude --version` — check Claude Code CLI version.
If update needed: `sudo npm update -g @anthropic-ai/claude-code`
Requires Lisa's password (sudo is in deny list — will prompt).

Autoupdate may fail with EACCES — this is the npm global permissions issue.
The fix is always `sudo`.

## Pointers
- [1] `../../MCP/neurons/claude-code-mcp.md` — version affects MCP serve
- [2] `../../Tools/neurons/node-npm.md` — npm is the update mechanism
