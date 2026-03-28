# BOT.ClaudeBot — Startup Process

**Run this checklist every time Claude Code starts a new conversation.**
This is the living startup sequence. We add to it as the system grows.

---

## 1. Caffeinate
```bash
caffeinate -d &
```
Prevents display sleep. Must be restarted manually after any terminal close or reboot.

## 2. Verify MCP Servers
All 4 MCP servers are configured in Claude Desktop and should auto-start with the app.
```bash
ps aux | grep -E "(node.*server\.js|mcp-shell|claude.*mcp)" | grep -v grep
```

Expected running processes:
- **velorin-gdrive** — `node .../velorin-gdrive-mcp/server.js`
- **claude-code** — `claude mcp serve`
- **github** — starts on-demand via npx (may not show until first use)
- **bash** — starts on-demand via npx (may not show until first use)

If velorin-gdrive or claude-code are missing, reopen Claude Desktop app.

## 3. Check Google Drive Token Health
```bash
jq '{expiry: (.expiry_date / 1000 | todate), has_refresh: (.refresh_token != null)}' "/Users/lbhunt/Desktop/Velorin /Velorin Code/velorin-gdrive-mcp/tokens.json"
```
Token auto-refreshes. If refresh token is missing, re-run auth:
```bash
cd "/Users/lbhunt/Desktop/Velorin /Velorin Code/velorin-gdrive-mcp" && npm run auth
```

## 4. Check Claude Code Version
```bash
claude --version
```
If update needed: `sudo npm update -g @anthropic-ai/claude-code`

## 5. Read Memory
Check `/Users/lbhunt/.claude/projects/-Users-lbhunt/memory/MEMORY.md` for prior context.

---

## Critical Path Reminders
- The "Velorin " folder has a **trailing space** — always double-quote paths
- Config: `/Users/lbhunt/Library/Application Support/Claude/claude_desktop_config.json`
- Hooks: `/Users/lbhunt/Desktop/Velorin /Velorin Code/hooks/`
- Architecture repo: `/Users/lbhunt/Desktop/velorin-system/`
- MCP code repo: `/Users/lbhunt/Desktop/Velorin /Velorin Code/velorin-gdrive-mcp/`

---

*Last updated: 2026-03-28*
*This file is additive — add new startup steps as the system grows.*
