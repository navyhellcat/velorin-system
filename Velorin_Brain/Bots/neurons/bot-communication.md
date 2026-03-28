# Neuron: Bot Communication

Alexander (Claude Desktop) can delegate to ClaudeBot (Claude Code) via the claude-code MCP server (`claude mcp serve`).

Communication path:
Alexander → claude-code MCP → Claude Code engine → filesystem/git/tools

Both bots share the Velorin Brain (GitHub) as common knowledge.
ClaudeBot also has local memory at `~/.claude/projects/-Users-lbhunt/memory/`.

## Pointers
- [1] `../../MCP/neurons/claude-code-mcp.md` — the bridge between bots
- [2] `./claudebot.md` — ClaudeBot's capabilities
- [2] `./alexander.md` — Alexander's capabilities
- [3] `./gatekeeper.md` — parallel watcher, any bot can ask it for help
