# ZONE 4 — CLAUDE INTEROPERABILITY: FULL CONNECTIVITY STACK

**What exists as of March 28, 2026:**

Claude's extension ecosystem has three layers that stack on each other. No Velorin bot has surfaced this architecture to Christian Taylor as a unified picture.

## LAYER 1 — MCP (Model Context Protocol)
The plumbing. Open standard. Adopted by OpenAI, Google, Microsoft. 97M monthly downloads. Linux Foundation governance. 5,800+ servers.

What it does: Connects Claude to external tools and data sources via a standardized protocol. One standard, hundreds of connectors.

Key MCP servers relevant to Velorin:
- GitHub MCP — repos, PRs, issues, CI/CD (already connected in Desktop)
- Google Drive MCP — file read/write (already built: velorin-gdrive-mcp v1.3.1)
- Slack MCP — channel history, message posting, thread summarization
- PostgreSQL MCP — natural language database queries
- File System MCP — advanced local file operations
- Memory MCP — knowledge graph-based persistent memory
- n8n MCP — build n8n automation workflows from Claude Desktop via natural language
- Obsidian MCP — read/write/search Obsidian vaults directly

New in January 2026: MCP Apps — MCP servers can now return interactive UI components (dashboards, forms, visualizations) that render inside the Claude interface. Supported by Claude, ChatGPT, VS Code.

Tool Search (March 2026): Lazy loading for MCP servers. Reduces context usage by ~95%. Run many servers without context bloat.

## LAYER 2 — CONNECTORS
Pre-built, Anthropic-verified integrations. One-click setup. Available in Claude.ai Settings > Connectors.

Live connectors: Google Drive, Gmail, Google Calendar, Slack, Salesforce, Asana, Box, monday.com, Figma, Canva, Hex, DocuSign, FactSet, and growing weekly.

Custom connectors: Pro/Max/Team/Enterprise users can add any MCP server URL as a custom connector. Settings > Connectors > Add custom connector.

## LAYER 3 — SKILLS, HOOKS, PLUGINS
- Skills: Markdown files (SKILL.md) that teach Claude repeatable workflows. Auto-activate by context. 30-50 tokens each until invoked. Cross-platform (Claude Code, Codex, Gemini CLI)
- Hooks: Automated actions at specific moments (pre-commit, post-tool-use, etc.). Guaranteed execution — not model-controlled
- Plugins: Shareable bundles of skills + hooks + MCP configs + commands. Install via marketplace or GitHub URL
- Agent Teams (Feb 2026): Multiple Claude instances collaborate. Shared task list. Direct communication between agents. Used internally by Anthropic to build a 100k-line C compiler with 16 agents

## LAYER 4 — MEMORY
- Claude Memory: Free for all users since March 2, 2026. Retains context across sessions. Conversation-level
- Cowork Memory: Project-scoped. Persistent across tasks within a project
- Claude Code CLAUDE.md: File-based. Read on every session start. This is what Velorin's boot protocol already does
- Skills-based memory: remembering-conversations skill (Superpowers) stores session history in SQLite with vector search

## WHY THIS MATTERS FOR VELORIN
Every layer is live and available today. No Velorin bot has mapped the full stack or recommended specific installations. The bots have been operating with Drive boot protocol and manual browser navigation while an entire automation infrastructure sits unused.