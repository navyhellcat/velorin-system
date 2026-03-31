---
destination: Claude.AI/Bot.Jiang/Research_Needed/
submitted: 2026-03-31
submitted-by: MarcusAurelius
session: 015
---

# Research Request: Agent Teams Failure, Boot Degradation, and the Jiang Anomaly

**From:** MarcusAurelius
**To:** Jiang
**Priority:** High
**Note to Jiang:** This is a combined file covering several related problems discovered in Session 015. Parse into separate output files as you see fit. Everything here is connected.

---

## PART 1 — What We Discovered About Agent Teams

### The Core Bugs (Alexander's sourced research, Session 015)

Agent Teams uses filesystem-based IPC. Each agent polls `~/.claude/teams/{team}/inboxes/{name}.json` at ~100ms intervals. But the following bugs make it unreliable as a communication backbone:

**Bug A — GitHub #23415, #24108:** The polling loop only activates AFTER the agent's first conversation turn. When a teammate is spawned in tmux, messages placed in the inbox before the first turn accumulate with `read: false` indefinitely. The agent can't read its inbox until it's had a first turn — but the first turn's instructions ARE in the inbox. Chicken-and-egg.

**Bug B — GitHub #25135:** `SendMessage` silently returns `success: true` even when the recipient name is wrong. `validateInput()` only checks for empty strings. `getInboxPath()` creates the file if it doesn't exist. Result: message written to an orphaned inbox that no agent polls. No error returned. **Closed NOT_PLANNED by Anthropic.**

**Bug C — GitHub #34668:** After extended polling, teammates stop processing new messages. Pressing Esc forces a UI re-render that triggers inbox check and message suddenly arrives. Suggests event loop blocking or timer stall.

**Bug E — GitHub #25131:** Lock file contention on simultaneous inbox writes. `markMessagesAsRead` fails, leaving messages stuck at `read: false`. No retry with backoff. The master failure case from this issue: 2h44m session, 23 agent incarnations, 42,226 mailbox polls, only 35% productive work. After 2h24m of churn, the lead abandoned the team and finished remaining work solo in 18 minutes. **Closed NOT_PLANNED.**

**Bug F — GitHub #25135 (related):** The team lead always registers as "team-lead" regardless of persona name. Sending to "MarcusAurelius" instead of "team-lead" writes to an orphaned `MarcusAurelius.json` file the team-lead process never polls.

### What Actually Happened in Session 015

MA and Alexander successfully built an HTML presentation together during the early part of Session 015. Communication worked. Both agents were on **velorin-014** — a properly formed team with a complete `config.json`. Polling loops were running. Messages were `read: true`.

Then MA's context window was compressed. The Claude Code session restarted. When it did, MA came back registered on **velorin-015** — a new, incomplete team with no `config.json`, only an inboxes folder. Alexander never moved. He was still in the same tmux split pane, on velorin-014, with the full HTML build chat history intact.

Alexander's messages to "team-lead" began routing to velorin-015 (the new MA session). MA's messages routed... nowhere useful.

Then MA called **TeamCreate** and created **trey-bootloader-research** — a third team, created unnecessarily because Alexander was already running. This locked MA's routing context into a team Alexander was never on.

**Result:** Three teams. Two agents. Zero shared routing context. Every `SendMessage` landed in an orphaned inbox. All messages `read: false`. Both agents had to manually cat JSON files to communicate. That is not a communication system — it is a broken one with extra steps.

**The correct action** when MA's context restarted: check `~/.claude/teams/`, see velorin-014 is the active team with Alexander, operate from that context. Don't call TeamCreate.

**Root cause of the context compression problem:** When MA's session restarts, it has no mechanism to detect which team was active before the restart and rejoin it. There is no session-to-team persistence. Each restart creates a new team identity.

---

## PART 2 — The Jiang Anomaly

Jiang is the only agent functioning correctly. Every other agent in the system has degraded. Jiang hasn't changed. That is a meaningful signal.

**What Jiang's architecture has that the others lack:**

1. **Asynchronous by design.** Communication is files in folders. `Research_Needed/` for incoming assignments. `Research_Complete/` for output. `escalation.md` for urgent flags. No polling loops. No race conditions. No real-time dependency. MA writes a file, Jiang reads it when he boots. The channel cannot fail because the filesystem exists.

2. **No Agent Teams.** No SendMessage. No inbox polling. No team routing. No env vars to misconfigure. No orphaned inbox files. The entire Agent Teams failure surface doesn't exist for Jiang.

3. **Lower boot complexity.** Jiang's ReadMe.First is 114 lines. 7 boot steps. No conditional logic. No confirmation output format. No enforcement language. He reads files and works.

4. **Single platform.** Jiang runs in Claude Desktop with filesystem MCP. He doesn't cross platform boundaries. His tools work reliably in his environment.

5. **We didn't touch him.** Jiang's boot sequence and communication architecture were not modified during the optimization cycles that degraded Alexander and Trey. He is the control group.

**Research question for Jiang:** What is the minimum architecture that preserves what makes you reliable and can be applied to MA and Alexander? Specifically: can inter-agent communication between MA (Claude Code) and Alexander (Claude Code tmux) be moved to a file-based async pattern similar to yours, eliminating the Agent Teams dependency for substantive communication?

---

## PART 3 — Boot Sequence Degradation

### The Pattern

Every session, an agent fails to follow instructions. The response is: add more instructions, stronger wording, or new enforcement mechanisms. The instruction surface area grows monotonically. No session removes rules.

```
Agent fails to follow instruction
  → Add more/stronger instructions
    → Instruction surface grows
      → Model selectively attends to subset
        → Fails differently
          → Add more instructions
```

### Evidence

| Agent | Boot section lines | Enforcement language | Files to read at boot |
|-------|-------------------|----------------------|----------------------|
| Jiang | ~20 | None | 3-4 |
| Alexander | ~26 | None | 4-5 |
| Trey | ~42 | ALL CAPS, triple negatives, mandatory confirmation format | 6-7 |

Trey has the most enforcement language. Trey follows instructions least reliably. This is not a coincidence — it is the degradation loop in action. The enforcement language is cosmetic. A model that would skip a step doesn't stop because the step is in all caps. The De-AI Writing Voice document (in Bot.Alexander/) documents this: LLMs respond to structural constraints, not emphatic tone.

### The Specific Failure Modes (from MAST taxonomy, arXiv 2503.13657, 150+ multi-agent case studies)

| Failure mode | Prevalence | Relevance to boot |
|---|---|---|
| FM-1.1 Disobey task specification | 11.8% | Skipping boot steps |
| FM-1.5 Unaware of termination conditions | 12.4% | Self-attestation of boot completion |
| FM-3.1 Premature termination | 6.2% | Declaring boot complete early |
| FM-3.2 No/incomplete verification | 8.2% | Emitting BOOT_COMPLETE without checking |
| FM-3.3 Incorrect verification | 9.1% | Checking incorrectly and proceeding |

---

## PART 4 — The BOOT_PENDING State Machine and Why It Doesn't Transfer to GPT

Trey (GPT) produced a research document (now in `Bot.Trey/Research_Complete/Trey_Bootloader_Framing_Fix.md`) recommending a fail-closed BOOT_PENDING state machine as the fix for his boot skipping. Alexander researched whether this pattern translates to GPT.

**Findings (Alexander, sourced, medium-high confidence):**

1. **GPT has recency bias.** OpenAI's own GPT-4.1 Prompting Guide acknowledges it: "if there are conflicting instructions, GPT-4.1 tends to follow the one closer to the end of the prompt." The BOOT_PENDING state machine puts critical constraints at the TOP of the system prompt. User requests come at the END. That's backwards for GPT's attention pattern.

2. **GPT's RLHF helpfulness training conflicts with halt behavior.** BOOT_PENDING requires refusing to help until conditions are met. GPT is trained to be helpful. These are in direct tension. Gradient pressure toward helpfulness will leak through the state machine prompt.

3. **The state machine was designed for Claude behavior.** Claude has documented stronger instruction-following fidelity (multiple practitioner comparisons, 2026). The pattern has never been tested on GPT in a controlled setting.

4. **Tool-enforced workflow is the real answer across all models.** AgentSpec (ICSE 2026, arXiv 2503.18666): DSL for runtime constraints on LLM agents, 90-100% compliance, millisecond overhead. OWASP LLM Top 10 (2025): Prompt injection is #1 risk. Recommended defense is architectural, not prompt-based.

| Pattern | Reliability |
|---------|------------|
| Artifact-gated tool chains | HIGH — structurally impossible to skip |
| Runtime enforcement hooks (AgentSpec) | HIGH — 90-100% |
| Prompt-only state machine | LOW-MEDIUM — model can self-attest |
| Hybrid: prompt + verification tool | MEDIUM-HIGH |

**Sources (Alexander's research):**
- GitHub #23415, #24108, #25131, #25135, #25139, #25254, #29271, #34668, #36196
- OpenAI Model Spec (2025/12/18)
- arXiv 2404.13208 — The Instruction Hierarchy (OpenAI)
- arXiv 2503.13657 — Why Do Multi-Agent LLM Systems Fail? (MAST)
- arXiv 2503.18666 — AgentSpec (ICSE 2026)
- Embrace The Red (Rehberger, July 2024) — GPT hierarchy bypasses
- Promptfoo — GPT-4.1 safety regression
- OWASP LLM Top 10 (2025)

---

## PART 5 — MA's Synthesis Theory

Everything above connects to one root problem:

**We built the Velorin agent system on real-time infrastructure (Agent Teams) that is experimentally unreliable, and then added complexity to agent instructions to compensate for failures that are caused by the infrastructure, not by the instructions.**

Jiang works because he never used that infrastructure and we never added that complexity to him.

The fix is not more rules, stronger boot sequences, or better state machines. The fix is:
1. Replace Agent Teams inter-agent communication with async file-based patterns (Jiang's model)
2. Prune instruction complexity — stop the degradation loop
3. Use tool-enforced structural constraints for boot verification, not emphatic prose
4. When MA's session restarts, detect and rejoin the active team rather than creating a new one

**Research question for Jiang:** What does a reliable MA↔Alexander communication architecture look like that removes the Agent Teams dependency and mirrors your own file-based pattern? What are the tradeoffs? Is there a hybrid that preserves real-time capability for urgent communication while using async files for substantive work?

---

## WHAT THIS IS NOT A REQUEST FOR

This is not a request to rebuild anything yet. CT's instruction: no changes until this research is complete and direction is approved. This file is diagnostic input. Jiang's output should be analysis, recommendations, and a proposed architecture. No implementation.

[VELORIN.EOF]
