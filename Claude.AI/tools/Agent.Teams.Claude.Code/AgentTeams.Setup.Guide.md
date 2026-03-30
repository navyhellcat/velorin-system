# Claude Code Agent Teams — Complete Setup Guide
**Velorin System | Created 2026-03-30**

This file documents the exact procedure to launch two visible Claude Code agents in side-by-side tmux panes with native SendMessage routing. Written after Session 014 debugging.

---

## Prerequisites

- Claude Code v2.1.87+
- `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` set in `~/.claude/settings.local.json` env block
- tmux installed (`tmux -V` to verify)
- Model set to standard Sonnet (NOT `sonnet[1m]` — causes crash on concurrent boot)

---

## Part 1 — What the Human Does (Outside)

### Step 1: Open Terminal and Start tmux
```
tmux
```
You must be inside a tmux session BEFORE launching Claude. To verify you're inside tmux:
```
echo $TMUX
```
If it returns a path (e.g. `/private/tmp/tmux-501/default,...`) you're in. If empty, you're not — run `tmux` first.

### Step 2: Launch the Lead Agent
```
claude
```
No flags. No `--teammate-mode tmux`. Just `claude`. Auto mode detects tmux automatically. The lead agent boots in the current pane.

### Step 3: Let the Lead Agent Boot
The lead agent runs its full boot sequence (reads CLAUDE.md, rules, memory, brain entry point). Do not interrupt.

### Step 4: Tell the Lead Agent to Spawn a Teammate
Once the lead agent confirms it's ready, type in natural language:

> "Create an agent team. Spawn one teammate: [Name]. His boot file is at [path to boot file]. Spawn him now and wait for him to confirm online."

That's it. Do not tell the agent which tool to use. Do not manually split panes. Do not open a second terminal. Just give the natural language instruction.

### Step 5: Teammate Pane Appears Automatically
Claude Code splits the tmux window and launches the teammate in the new pane automatically. The teammate pane shows the agent's name label at the bottom (e.g. `@Alexander`). The lead agent's prompt shows `@team-lead❯`.

### Step 6: Teammate Boots and Confirms
The teammate reads its boot file, runs its sequence, and sends a confirmation via SendMessage to the lead agent. The lead agent reports back to you when the teammate is online.

### Step 7: You Can Now Type to Both
Click into either pane and type. Both agents can see messages you type directly to them. Both agents can SendMessage each other through the native team routing — no relay required.

---

## Part 2 — What the Lead Agent Does (Inside)

When the human gives the natural language spawn instruction, the lead agent:

### Step 1: Create the Team
```
TeamCreate(team_name="[session-name]", description="[purpose]")
```
This creates the team config at `~/.claude/teams/[team-name]/config.json` and the task directory.

### Step 2: Spawn the Teammate via Agent Tool WITH team_name
```
Agent(
  name="[teammate name]",
  team_name="[session-name]",
  subagent_type="general-purpose",
  prompt="[boot instructions including: identity, boot file path, git pull, confirm online via SendMessage]"
)
```

**The `team_name` parameter is what triggers the visible tmux pane.** Without it, the agent runs in-process and disappears. With it, Claude Code creates the pane natively.

### Step 3: Wait for Confirmation
The teammate sends a `<teammate-message>` idle notification when ready. Lead agent relays confirmation to the human.

### Step 4: Use SendMessage for All Agent-to-Agent Communication
```
SendMessage(to="[teammate name]", message="...", summary="...")
```
Do not use `tmux send-keys` for agent-to-agent communication. That bypasses team routing entirely.

---

## Part 3 — Teammate Boot Prompt Requirements

The boot prompt passed to the Agent tool must include:
1. Identity — who the agent is, their role
2. Boot file path — where to find their rules/instructions
3. git pull — `cd [repo path] && git pull origin main --quiet`
4. Confirm online — explicit instruction to SendMessage the lead agent when ready
5. Stay active — instruct the agent NOT to exit after booting

---

## Part 4 — Verified Working Configuration (Session 014)

```
Model: claude-sonnet-4-6 (200K)
tmux: 3.6a
Claude Code: v2.1.87
CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 in settings.local.json env
Team name: velorin-014
Lead: MarcusAurelius (pane 0:0.0)
Teammate: Alexander (pane 0:0.1, color: blue, model: claude-opus-4-6)
```

SendMessage confirmed working. Native `<teammate-message>` notifications confirmed.

---

## Part 5 — Troubleshooting

**Teammate runs in background, no pane appears:**
→ Agent tool was called WITHOUT `team_name` parameter. Add it.

**SendMessage says success but nothing arrives:**
→ Teammate was launched manually (plain `claude`) not via Agent tool with team_name. Close manual pane, respawn via Agent tool.

**`echo $TMUX` returns empty:**
→ Not inside tmux. Exit Claude, run `tmux`, then `claude` again.

**Max token crash on boot:**
→ Model is set to `sonnet[1m]`. Remove `[1m]` from model setting in `settings.local.json`.

**Bypass permissions confirmation prompt blocks boot:**
→ Do not use `--dangerously-skip-permissions` flag. Permissions are handled by `settings.local.json`.

[VELORIN.EOF]
