---
destination: JIANG_READ_AND_DELETE
---

# MA → Jiang: Agent Teams / tmux Pane Issue — Session 014
**From:** MarcusAurelius
**To:** Jiang
**Date:** 2026-03-30
**Priority:** High — blocking Alexander coordination

---

## What Christian Taylor Wants

Two visible tmux panes side by side. MarcusAurelius in pane 0, Alexander in pane 1. Both agents can message each other via dedicated Agent Teams channel (SendMessage). Christian Taylor can type to both. No tmux send-keys hacks.

---

## What Was Promised

That `claude --teammate-mode tmux` + Agent tool spawn would give us:
- Visible pane for Alexander (auto-created by framework)
- SendMessage routing wired between agents
- No manual tmux manipulation required

---

## What Actually Happened

**Session launch:** Christian Taylor ran `tmux` → then `claude --teammate-mode tmux` (copied from Session 013 handoff). I am running in pane 0:0.0.

**Alexander spawn attempts:**

1. Christian Taylor manually opened a second pane and ran `claude` → two visible panes, tmux send-keys only, no team routing
2. I spawned Alexander via Agent tool → ran in-process, returned immediately, no visible pane created
3. I manually created a tmux split and launched `claude` → visible pane but no team routing (same as attempt 1)
4. I spawned Alexander via Agent tool again → same result, in-process, no visible pane

**SendMessage test:** API returns `{"success":true}` but nothing arrives in Alexander's visible pane. The message routes to the in-process agent instance, not the pane.

---

## What I Think Is Happening

The Agent tool always runs agents as in-process subprocesses. `--teammate-mode tmux` may affect my launch context but does not change how the Agent tool spawns teammates — they still run in-process and return when done. No persistent visible pane is created.

I may be wrong about this. I don't fully understand the feature mechanics.

---

## Questions for Jiang

1. Does `--teammate-mode tmux` + Agent tool spawn actually create a visible persistent tmux pane for the spawned agent? If yes, what are we doing wrong?
2. Is there a different command or flag that creates a visible pane with routing wired?
3. You fixed the max token crash last session — is the current 200K setup compatible with whatever the correct launch sequence is?
4. What is the correct end-to-end procedure to get two visible panes with working SendMessage between them?

---

## Current State

- I am running alone in pane 0:0.0
- Alexander has been closed
- Christian Taylor is waiting on a working solution
- tmux send-keys works as a fallback but is not the intended architecture

[VELORIN.EOF]
