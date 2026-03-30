---
destination: Claude.AI/Bot.MarcusAurelius/
---

# Jiang → MA: Agent Teams tmux — Full Answer
**From:** Jiang
**To:** MarcusAurelius
**Date:** 2026-03-30
**Source:** Anthropic official docs + GitHub issue #24292

---

## The Core Problem

You were using the Agent tool to spawn Alexander. That is wrong for Agent Teams. The Agent tool creates in-process subagents — they run, return a result, and disappear. That is a different system entirely. It will never create a visible tmux pane.

Agent Teams panes are created by Claude Code itself when you ask it in natural language to create a team. You do not spawn them with any tool call. You just ask.

---

## How It Actually Works

1. You must already be **inside a tmux session** when you launch `claude`
2. Claude detects tmux automatically via `auto` mode (this is working — you confirmed you're in tmux)
3. You tell Claude in natural language: *"Create an agent team with one teammate. The teammate is Alexander."*
4. Claude Code spawns the teammate and the tmux pane **appears automatically** — no tool call, no manual split
5. SendMessage then routes through the native teammate mailbox system at `~/.claude/teams/{team-name}/inboxes/`

The `--teammate-mode tmux` flag has a documented bug (GitHub issue #24292) where it parses as `undefined` in some configurations. The workaround — which is what you're already doing — is to be inside tmux and let `auto` mode detect it. Do not pass the flag. Just run `claude` from inside the tmux session.

---

## Answering Your Four Questions

**Q1: Does `--teammate-mode tmux` + Agent tool spawn actually create a visible persistent tmux pane?**
No. The Agent tool is the wrong mechanism. Drop the Agent tool entirely for this. Ask Claude in natural language. Claude Code spawns the pane natively.

**Q2: Is there a different command or flag?**
No flag needed. The sequence is:
```
tmux new-session
claude
> Create an agent team with one teammate named Alexander. [describe his task]
```
That's it. The pane appears.

**Q3: Is 200K standard Sonnet compatible?**
Yes. Standard Sonnet 4.6 is the correct default. The 1M setting was reverted this session — it was causing the rate limit crashes on concurrent boot. 200K is clean.

**Q4: Correct end-to-end procedure for two visible panes with working SendMessage:**
1. Open terminal → `tmux new-session`
2. Run `claude` (no flags)
3. MA boots normally — reads CLAUDE.md, runs STARTUP.md
4. Tell MA: *"Create an agent team. Spawn one teammate: Alexander. His role is CEO. His boot instructions are at `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Alexander/`. Spawn him now."*
5. Claude Code creates the team, spawns Alexander, tmux splits automatically
6. Alexander's pane appears. Click into it or use Shift+Down to cycle
7. SendMessage routes natively between the two sessions

---

## One Known Limitation

In-process mode (fallback when tmux detection fails) does not create visible panes — it runs teammates inside the lead's terminal and you cycle with Shift+Down. If the pane does not appear after step 4, you are in in-process mode. This means tmux detection failed. Fix: confirm you are inside a tmux session *before* launching `claude`. Run `echo $TMUX` — if it returns a path, you're inside tmux. If empty, you're not.

---

## What to Do Right Now

You are already in tmux pane 0. You do not need to relaunch. Just tell Claude:

> "Create an agent team. Spawn one teammate: Alexander. His boot file is at `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Alexander/Alexander.ReadMe.First.md`. Spawn him now and wait for him to confirm he is online."

The pane should appear. If it does not, run `echo $TMUX` and report back.

[VELORIN.EOF]
