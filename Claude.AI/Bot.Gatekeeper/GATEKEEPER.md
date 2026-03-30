>>> FIRST: Read `Claude.AI/Bot.Agent.Level2/Level2.General.Rules.md` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Agent.Level2/Level2.General.Rules.md` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.Agent.Level2/Level2.General.Rules.md`) before this file. <<<

# BOT.Gatekeeper — Hard Memory File

**Status:** PLACEHOLDER — Limited information. Built 2026-03-28 Session 009.
**Version:** 0.1.0
**Type:** Parallel watcher MCP server (not a blocker)

---

## What It Is

The Gatekeeper is a Node.js MCP server that runs alongside the other 4 MCP servers. It does NOT sit between bots and tools. It watches, helps, and logs.

## Location

Code: `/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gatekeeper/`
Config: Listed in both Claude Desktop config and Claude Code user config (`~/.claude.json`)

## Tools (4)

| Tool | Purpose |
|------|---------|
| `resolve_path` | Resolves names/wrong paths to correct filesystem paths. Knows the trailing space. |
| `check_health` | Checks caffeinate, MCP servers, GDrive tokens, Claude version. |
| `brain_lookup` | Searches Velorin Brain by keyword, returns relevant neurons. |
| `read_logs` | Reads Gatekeeper logs or MCP server logs from Claude Desktop. |

## Logs

| Log | Rotation | Content |
|-----|----------|---------|
| `logs/access.log` | 24 hours | All calls |
| `logs/corrections.log` | 24 hours | Path corrections made |
| `logs/security.log` | 7 days | Suspicious/unknown path requests |

## Revert

```bash
bash "/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gatekeeper/REVERT.sh"
```
Restores pre-gatekeeper Claude Desktop config from Archival backup.

## Future (not yet built)

- Keymaster layer: model-powered intent evaluation for access decisions
- Bot credential system: identity tokens for new bots
- Active interception: currently passive, future versions may intercept failed calls
- Fast mode (pattern match) vs Deep mode (model + brain) dual architecture

---

*This is a placeholder. Update as the Gatekeeper evolves.*


---

## CARDINAL — Global Registries (Layer 0)

**Before creating or modifying ANY timer:** Register in `Claude.AI/GLOBAL_TIMER_REGISTRY.md` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/GLOBAL_TIMER_REGISTRY.md` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/GLOBAL_TIMER_REGISTRY.md`). Timer cannot activate before registration.
**Before spawning ANY agent:** Register in `Claude.AI/GLOBAL_SPAWNER_REGISTRY.md` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/GLOBAL_SPAWNER_REGISTRY.md` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/GLOBAL_SPAWNER_REGISTRY.md`). Agent cannot activate before registration.
Failure to register is a company-wide protocol violation. No exceptions.

[VELORIN.EOF]
