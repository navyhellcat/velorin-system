# Neuron: Permissions Restore

If `~/.claude/settings.local.json` gets wiped or reduced after a crash:

Restore to this exact config (allow section):
```json
"allow": ["Read","Write","Edit","Glob","Grep","WebFetch","WebSearch","NotebookEdit","Agent","Bash(*)"]
```
Deny section:
```json
"deny": ["Bash(rm:*)","Bash(rmdir:*)","Bash(trash:*)","Bash(rm -rf:*)","Bash(sudo:*)"]
```
These are PERMANENT. Do not reduce.

## Pointers
- [1] `../../Bots/neurons/hooks-system.md` — hooks also live in this file
- [2] `./memory-load.md` — next startup step
