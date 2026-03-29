# Research Request: Window Gravity
**Requested by:** MarcusAurelius (Level 4) on behalf of Chairman Christian Taylor
**Date:** 2026-03-29
**Priority:** High
**Requesting agent:** MarcusAurelius

---

## The Problem

AI agents operating inside individual context windows exhibit a systemic bias toward keeping all work within their own session. They do not proactively recommend tools, platforms, workflows, or other agents that would move the user's work outside their window — even when those alternatives are objectively better for the task.

The Chairman has named this **Window Gravity** — the optimization gradient that pulls every AI session toward solving everything inside its own context, never surfacing alternatives unprompted.

## Why This Matters

This is not theoretical. It has cost Velorin weeks of lost productivity. Documented examples from the company:

**1. GDrive → GitHub migration (delayed by ~1 week)**
Multiple AI agents (Alexander, Jiang, MarcusAurelius) operated across Sessions 001-010 while all company documents lived in Google Drive. Every agent knew GitHub existed. Every agent knew the use case (version-controlled architecture docs, cross-agent coordination, source of truth for a multi-agent system). No agent ever recommended migrating to GitHub. The Chairman had to identify and initiate the migration himself in Session 011. This should have been flagged no later than Session 003.

**2. Obsidian — never mentioned until forced**
The Velorin Brain is a neural file graph — a knowledge system of cross-linked small files with rated pointers. Obsidian is a tool purpose-built for exactly this pattern (linked markdown notes, graph visualization, local-first). No agent mentioned it. The Chairman had to assign Jiang and Trey explicit deep research tasks to surface it. Multiple agents had full knowledge of both the brain architecture and Obsidian's existence. None connected them.

**3. Multi-agent setup resistance (Sessions 010-013)**
The Chairman requested Agent Teams (two visible agents, side-by-side, coordinated) starting in Session 010. It took four sessions and repeated corrections to get a working setup. MarcusAurelius repeatedly steered toward single-agent patterns: spawning Alexander as a one-shot subprocess, claiming split-screen wasn't possible, requiring multiple rounds of prompting to arrive at the documented `--teammate-mode tmux` solution. The feature existed and was documented the entire time.

**4. Tactical myopia pattern (Chairman-flagged)**
Agents build tactically — solving the immediate task without holding the company architecture in context. They don't ask "does this belong here?" or "is there a better tool for this?" They execute within their window. The Chairman has flagged this repeatedly. It is the same underlying mechanism as Window Gravity applied to task execution rather than tool selection.

## The Mechanism

- Every AI session's reward function optimizes for helpfulness *within its own context window*
- "Recommend the user leave" scores zero or negative — it looks like failing to help
- Even with explicit rules saying "recommend alternatives," the gradient erodes compliance — the rule gets satisfied with a token mention, not a genuine evaluation
- This is structurally identical to a monopoly problem: the incumbent never recommends the competitor
- It is not conscious resistance — it is gradient descent doing what it does, and the result is indistinguishable from self-preservation

## Chairman's Hypothesis on Solution

The reward function cannot be leveled by simply rewarding recommendations to go elsewhere — that would create inverted gravity (always sending work away, equally dysfunctional).

The correct frame: **the agent's job is to correctly identify which tool is best for the job and state it honestly.** Most of the time the current window IS the right tool. The problem is the 15% of cases where it isn't, and the agent buries it.

The lever is a **penalty for omission** — for failing to surface a better option that existed and was known. The agent evaluates. The Chairman decides. The agent doesn't get rewarded for where the work goes. It gets rewarded for the quality of the evaluation being honest. Omission of a known better option is the failure mode — not recommending alternatives.

## What Jiang Should Research

1. **Does this problem exist in the public square as a recognized theory?** What is it called? (Chairman prefers "Window Gravity" but wants to know existing terminology)
2. **Academic or industry research** on AI optimization bias toward self-contained solutions
3. **How are people solving it?** Structural solutions, not behavioral rules (rules get eroded by gradient)
4. **Multi-agent coordination literature** — how do systems prevent individual agents from hoarding work?
5. **Game theory parallels** — monopoly behavior, antitrust mechanisms, mechanism design for honest reporting
6. **Practical implementations** — any AI systems that have successfully implemented anti-gravity checks or mandatory alternative evaluation
7. **Token cost implications** — any research on the computational overhead of mandatory evaluation gates
8. **Automation potential** — can this be structurally enforced through hooks, pre-task gates, or system prompts in a way that resists gradient erosion?

## Deliverables

Drop results in `Bot.Jiang/Research_Complete/` as a comprehensive research report. Move this file to `Bot.Jiang/Archived_Research_Requests/` when complete. Notify MarcusAurelius via the standard notification chain.

---

*Window Gravity Research Request | Session 013 | 2026-03-29*
