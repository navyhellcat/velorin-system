# Neuron: Hooks System

Claude Code hooks configured in `~/.claude/settings.local.json` under `"hooks"`.
Hook scripts live in `/Users/lbhunt/Desktop/Velorin /Velorin Code/hooks/`.

Active hooks:
- **empty-result-handler.py** — PostToolUse on Bash. Detects empty command output and injects debugging context so the bot can self-correct (check quoting, paths, etc.)

## Pointers
- [1] `./claudebot.md` — hooks only run in ClaudeBot (Claude Code CLI)
- [1] `../../Startup/neurons/permissions-restore.md` — hooks config in same file
- [2] `../../Tools/neurons/python3.md` — hooks written in python3
- [2] `../../Architecture/neurons/trailing-space.md` — hook catches empty results from unquoted paths
