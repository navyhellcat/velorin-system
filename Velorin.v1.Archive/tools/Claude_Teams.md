# Claude Code Agent Teams — Reference
**Hard memory file | Layer 0 | tools/Claude Code/**
**Last updated: 2026-03-29 | Session 013**

---

## What It Is

Native Claude Code feature for running multiple agents as a coordinated team within a single session. One lead agent + independent teammates, each with their own context window. Teammates communicate via shared task lists and direct messaging.

## Requirements

- Claude Code v2.1.32+ (current: v2.1.87)
- Env var: `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` in `~/.claude/settings.local.json`
- Env var must be set BEFORE session starts — already configured in Velorin settings

## How It Works

- Teams run inside a single Claude Code process — not separate terminal windows
- Lead agent (MarcusAurelius) spawns teammates using the Agent tool with `name` parameter
- Each teammate gets independent context, full tool access, all MCP servers, CLAUDE.md
- Coordination through: TaskCreate/TaskUpdate (shared task list) + SendMessage (direct messaging)
- Team config stored at `~/.claude/teams/{team-name}/config.json`
- Task list stored at `~/.claude/tasks/{team-name}/`

## Display Modes

### In-Process (Default)
- All teammates in same terminal
- Teammate output appears when they report back to lead
- No extra dependencies

### tmux Split Panes (requires tmux)
- Each teammate gets its own visible terminal pane
- Side-by-side view — watch both agents think in real time
- Install: `brew install tmux`
- Config in settings: `"teammates": { "displayMode": "tmux" }`
- **tmux is NOT currently installed on this machine**

## Spawning a Teammate

```
Agent tool with:
  name: "Alexander"
  prompt: [boot instructions + file reads]
  run_in_background: true  (for async work)
```

Teammate reads CLAUDE.md, inherits all permissions and MCP servers. Provide boot sequence files in the prompt for role-specific context.

## Communication

- **Lead → Teammate:** SendMessage tool with `to: "Alexander"`
- **Teammate → Lead:** SendMessage tool with `to: "MarcusAurelius"` (or team lead name)
- **Teammate → Teammate:** SendMessage with peer name
- Messages delivered automatically — no polling needed
- Idle notifications are normal — teammate waiting for input, not crashed

## Task Coordination

- TaskCreate: add work items to shared list
- TaskUpdate: claim tasks (set owner), mark complete, set dependencies
- TaskList: see all tasks and their status
- Any teammate can read/write the task list

## Limitations

1. **No session resumption** — if session ends, teammates must be re-spawned
2. **One team per session** — close team before creating another
3. **No live context view without tmux** — default mode shows output on completion only
4. **Token cost scales linearly** — each teammate burns its own context window
5. **Shutdown is async** — teammates finish current request before stopping (~30s)
6. **Teammates cannot resume across sessions** — they start fresh each time

## Velorin Integration

- MarcusAurelius = lead (Claude Code CLI)
- Alexander = teammate (spawned via Agent tool)
- Both follow Level 4 General Rules
- Both use Velorin Brain for knowledge
- Both have GitHub source-of-truth protocol (pull before read, push after write)
- Alexander's boot: Level 4 rules → Alexander.ReadMe.First → Brain entry → latest session handoff

## tmux — INSTALLED

tmux 3.6a installed at `/usr/local/bin/tmux` (2026-03-29, Session 013).

To launch with split panes:
```bash
claude --teammate-mode tmux
```

MarcusAurelius boots as lead, spawns Alexander in his own pane. Chairman can click into either pane and interact directly.

---

*Claude Code Agent Teams | tools/Claude Code/ | Layer 0 | Session 013*

[VELORIN.EOF]
