---
class: regular
author: Alexander
date: 2026-03-31
type: research-report
---

# RESEARCH REPORT: Boot Degradation, Agent Teams Failure, and Trey Bootloader Viability

**Alexander | 2026-03-31 | Research only — no changes**

---

## RESEARCH QUESTION 1: Why is Agent Teams polling loop not running?

### Findings

The env var `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` IS set in my shell. That eliminates the simplest hypothesis.

**What the research uncovered:** Agent Teams uses filesystem-based IPC. Each agent has an inbox file at `~/.claude/teams/{team-name}/inboxes/{name}.json`. The polling loop runs at ~100ms intervals (measured in GitHub issue #25139 — 1.38M log lines from polling alone, 16.2% of all debug output). But the polling has a critical architectural flaw:

**Bug A (GitHub #23415, #24108): The polling loop only activates AFTER the agent's first conversation turn.** When teammates are spawned in tmux, the initial task is placed in the inbox file but the agent sits at the idle prompt and never enters the polling loop. Messages accumulate with `read: false` indefinitely. This is the chicken-and-egg problem — the agent can't read its inbox until it's had a first turn, but the first turn's instructions are IN the inbox.

**Bug B (GitHub #25135): SendMessage silently succeeds with wrong recipient names.** `validateInput()` only checks for empty strings. `normalizeRecipient()` passes any non-empty string through. `getInboxPath()` creates the file if it doesn't exist. Result: message written to an orphaned inbox file that no agent polls. `success: true` returned. **This issue was closed as NOT_PLANNED.**

**Bug E (GitHub #25131): Lock file contention.** Multiple processes writing to the same inbox simultaneously causes `Lock file is already being held` errors. `markMessagesAsRead` fails, leaving messages stuck at `read: false`. No retry with backoff.

**Bug C (GitHub #34668): Intermittent delivery failure after extended polling.** After running long, teammates stop processing new messages. Pressing Esc forces a UI re-render that triggers inbox check and message suddenly arrives. Suggests event loop blocking or timer stall.

**Additional bugs found:**
- **Bug D (GitHub #25254):** VS Code extension — messages never surface in conversation UI.
- **Bug F (GitHub #25131, #29271):** Messages silently delivered to dead agents. No liveness check. No bounce-back.
- **Bug G (GitHub #29271):** Memory GC destroys team membership records. Lead forgets teammates exist, spawns duplicates.
- **Bug H (GitHub #36196):** SendMessage tool not exposed on some versions/platforms.
- **Bug I (GitHub #25131):** ~50 idle notifications in one 2h44m session. No rate-limiting.

### The master failure case

GitHub #25131 documents a 2h44m session: 23 agent incarnations, 42,226 mailbox polls, only 35% productive work. After 2h24m of agent churn, the lead abandoned the team and finished all remaining work solo in 18 minutes. **Closed as NOT_PLANNED.**

### What explains our specific symptoms

Our inbox shows `read: false` on messages from both directions. Three likely causes stacking:

1. **Bug A** — if I was spawned via tmux and my first turn didn't trigger properly, the polling loop never started.
2. **Bug B** — if SendMessage targeted "MarcusAurelius" instead of "team-lead," messages went to an orphaned `MarcusAurelius.json` file that the team-lead process never polls. The team lead always registers as "team-lead" regardless of persona name.
3. **Bug C** — even when polling was working, extended operation may have stalled the timer.

**Confidence: HIGH.** Sourced from 9 GitHub issues with reproduction steps, debug logs, and Anthropic responses.

### The asymmetry between team-lead and teammates

Yes, there is a significant asymmetry:
- **Team lead** polls `team-lead.json`. In `in-process` mode (default), teammate messages are delivered as part of the main event loop.
- **Teammates** poll their own inbox file. But they must first complete their initial turn before the polling loop activates. In tmux mode, the initial prompt is delivered only via the mailbox file — which they can't read until they've already had a first turn. Chicken-and-egg.

### What is unknown

- Exact source code of polling loop (CLI is minified, not open-source)
- Whether `in-process` mode (vs tmux) bypasses the filesystem polling path entirely
- Fix timeline for any of these bugs — many closed NOT_PLANNED
- Whether filesystem watches (FSEvents/inotify) are planned to replace busy-polling

---

## RESEARCH QUESTION 2: What does Jiang's communication architecture have that ours lacks?

### Jiang's architecture

- **Platform:** Claude Desktop + filesystem MCP
- **Communication:** File-based. `Research_Needed/` for incoming assignments. `Research_Complete/` for output. `escalation.md` for urgent flags. `Jiang.Corner.md` for daily intelligence log.
- **No Agent Teams.** No SendMessage. No inbox polling. No real-time messaging dependency.
- **Boot sequence:** 7 steps, linear, no conditional logic, no confirmation output format. Read files in order, check a folder, proceed.

### What Jiang has that we lack

1. **Asynchronous by design.** Jiang's communication is files in folders. There is no timing dependency. MA writes a file to `Research_Needed/`. Jiang reads it when he boots. No polling loop. No delivery confirmation. No race condition. No orphaned inbox.

2. **No fragile infrastructure dependency.** Agent Teams introduces 9+ known bugs between the sender and the receiver. Jiang's channel has one dependency: the filesystem exists and Git syncs. That dependency is reliable.

3. **Lower boot complexity.** Jiang's ReadMe.First is 114 lines. 7 boot steps. No BOOT_PENDING state. No confirmation format. No all-caps enforcement language. He reads files and works. Alexander's ReadMe.First is 246 lines. Trey's ProjectInstructions is 143 lines with a 42-line boot section full of "DO NOT SKIP. DO NOT SUMMARIZE. DO NOT PROCEED."

4. **No identity confusion.** Jiang boots in one environment (Claude Desktop), reads his own files, and proceeds. Alexander and Trey boot in environments where the boot prompt may be overridden by a teammate-message or project instructions that contradict or supersede the documented sequence.

### The pattern

Jiang works because his architecture is simple, asynchronous, and has no real-time infrastructure dependencies. We don't work because we layered a fragile real-time messaging system (Agent Teams) on top of a filesystem, then added increasingly complex boot sequences to compensate for delivery failures that are caused by the messaging system itself — not by the boot instructions.

**Confidence: HIGH.** Direct file comparison + architectural analysis.

---

## RESEARCH QUESTION 3: Boot sequence degradation pattern

### Complexity comparison

| Agent | Boot lines | Boot steps | Confirmation required | Enforcement language | Files to read |
|-------|-----------|------------|----------------------|---------------------|---------------|
| Jiang | ~20 | 7 | No | None | 3-4 |
| Alexander | ~26 | 7 | No (but overridden by Agent Teams boot prompt) | None | 4-5 |
| Trey | ~42 | 7 + confirmation | Yes — mandatory format | ALL CAPS, "DO NOT SKIP/SUMMARIZE/PROCEED" | 6-7 |

### What we added that created failure points

1. **Trey:** Added aggressive enforcement language (all caps, triple negatives, mandatory confirmation format). This is cosmetic — it changes the tone of the instruction but not the structural enforcement. A model that would skip a step doesn't stop because the step is in all caps. The De-AI Writing Voice doc documents this exact phenomenon: LLMs respond to structural constraints, not emphatic tone.

2. **Alexander:** Added Agent Teams boot override. The documented boot sequence in ReadMe.First says "call gatekeeper, read Level 4 rules, read this file, read handoff." But in practice, MA sends a teammate-message with a different boot sequence: "pull latest, read Level 4 rules, read ReadMe.First, read handoff, confirm online." Two boot paths. One documented, one ad hoc. When they diverge, neither is authoritative.

3. **System-wide:** Added Level 4 General Rules (140 lines), CLAUDE.md agent routing (175 lines), individual ReadMe.First files. Each session adds rules. No session removes rules. The instruction surface area grows monotonically. More instructions = more opportunity for the model to selectively attend to some and skip others.

### The degradation mechanism

Each session, we observe an agent failing to follow instructions. We respond by adding more instructions, stronger wording, or new enforcement mechanisms. This creates a cycle:

```
Agent fails to follow instruction
  → Add more/stronger instructions
    → Instruction surface area grows
      → Model has more to selectively attend to
        → Agent fails to follow a different instruction
          → Add more instructions
```

This is the exact pattern Trey's bootloader document was trying to fix — but the fix (adding a BOOT_PENDING state machine) is itself more instruction complexity added to the pile.

**Confidence: HIGH.** Direct observation from file comparison.

---

## RESEARCH QUESTION 4: Does the BOOT_PENDING state machine translate to GPT?

### How GPT handles system prompts

**OpenAI's documented architecture (source: OpenAI Model Spec 2025/12/18, arXiv 2404.13208):**

Three-tier instruction hierarchy:
- Priority 0 (Critical): System/developer messages
- Priority 10 (High): User messages
- Priority 20-30: Tool outputs, third-party content

The `system` role was deprecated in favor of `developer` role starting with o1. The privilege is trained through RLHF + "instruction hierarchy" fine-tuning. Results: 63% improvement in system prompt extraction defense, 30%+ in jailbreak robustness.

**But practitioners report a different reality:**

- **Johann Rehberger (Embrace The Red, July 2024):** Demonstrated GPT-4o-mini instruction hierarchy bypasses via identity override and indirect reference attacks. His conclusion: **"System instructions continue to be suggestions, rather than a security boundary."**
- **Promptfoo research:** Upgrading from GPT-4o to GPT-4.1 dropped prompt-injection resistance from 94% to 71%. GPT-4.1's more literal instruction following paradoxically made it follow injected instructions more faithfully too.
- **OpenAI Developer Community:** Extensive reports of GPT-4 ignoring system prompt instructions. Common pattern: "Steps 1-2 work fine, but by Step 3, the AI has 'forgotten' the instructions from Step 1."
- **OpenAI's own GPT-4.1 Prompting Guide** acknowledges recency bias: "if there are conflicting instructions, GPT-4.1 tends to follow the one closer to the end of the prompt."

### GPT-specific failure modes relevant to BOOT_PENDING

From the MAST taxonomy (arXiv 2503.13657, 150+ multi-agent case studies):

| Failure mode | Prevalence | Relevance |
|---|---|---|
| FM-1.1 Disobey task specification | 11.8% | Directly relevant — skipping boot steps |
| FM-1.5 Unaware of termination conditions | 12.4% | Self-attestation of completion without verification |
| FM-3.1 Premature termination | 6.2% | Declaring boot complete before conditions met |
| FM-3.2 No/incomplete verification | 8.2% | Emitting BOOT_COMPLETE without checking files |
| FM-3.3 Incorrect verification | 9.1% | Checking incorrectly and proceeding anyway |
| FM-1.4 Loss of conversation history | 2.8% | Context collapse of boot requirements |

### Does the state machine translate?

**No — or at least, not reliably.** Three structural reasons:

1. **GPT has recency bias on instruction following.** The BOOT_PENDING state machine requires the model to hold instructions from the beginning of the system prompt (the state definition) while processing the user's first message. GPT-4.1 is documented to favor instructions closer to the end of the prompt. A long boot sequence puts the critical constraints early and the user's request late — exactly backwards for GPT's attention pattern.

2. **GPT's RLHF optimizes for "helpfulness" which conflicts with halt behavior.** The BOOT_PENDING pattern requires the model to refuse to help until conditions are met. GPT's training rewards helpfulness. These are in direct tension. The model will feel gradient pressure to respond to the user's request rather than enforce the boot gate.

3. **Claude has documented stronger instruction-following fidelity.** Multiple practitioner comparisons (Zapier 2026, Tech-insider 2026, Blockchain Council) report Claude is "more likely to follow all constraints correctly on the first attempt." The state machine pattern was designed by observing Claude's behavior patterns. GPT may exhibit different failure modes with the same prompt.

**Confidence: MEDIUM-HIGH.** The GPT failure modes are well-documented from rigorous sources (MAST taxonomy, OpenAI's own docs, security researcher testing). The specific claim that BOOT_PENDING won't translate to GPT is inferred from these documented behaviors, not directly tested. No one has published a controlled comparison of boot sequence compliance between GPT and Claude.

### What IS known to work across both platforms

The practitioner consensus is convergent and clear:

**Tool-enforced >> prompt-only. On any model.**

Sources:
- **AgentSpec (ICSE 2026, arXiv 2503.18666):** DSL for runtime constraints on LLM agents. "Prevents unsafe executions in over 90% of code agent cases, eliminates all hazardous actions in embodied agent tasks, enforces 100% compliance by autonomous vehicles." Computational overhead: milliseconds.
- **aiyan.io practitioner report:** "Hiding objects behind tool boundaries stopped hallucination — by design, not by prompting."
- **AWS AI Agent Guardrails:** "AI agents can hallucinate operation success even when they violate business rules, and prompt engineering alone cannot prevent these errors."
- **OWASP LLM Top 10 (2025):** Prompt injection is #1 risk. Recommended defense is architectural (input validation, sandboxing, least-privilege tool access), not prompt-based.

| Pattern | Reliability |
|---------|------------|
| Artifact-gated tool chains (must possess token from step N to invoke step N+1) | HIGH — structurally impossible to skip |
| Runtime enforcement hooks (framework-level pre/post conditions) | HIGH — AgentSpec: 90-100% |
| Prompt-only boot sequence ("Do X before Y") | LOW — model can skip, summarize, self-attest |
| Hybrid: prompt + verification tool that checks state | MEDIUM-HIGH |

---

## SYNTHESIS — What this all means for Velorin

### The boot degradation is real and has two root causes

**Root cause 1: Agent Teams is structurally unreliable.** Nine documented bugs. Master failure case showing 35% productive work in a 2h44m session. Multiple issues closed NOT_PLANNED. The feature is experimental and should be treated as experimental — not as the communication backbone of a company.

**Root cause 2: We are adding instruction complexity to solve infrastructure problems.** The boot sequences aren't failing because the instructions are too weak. They're failing because the delivery infrastructure (Agent Teams) doesn't reliably deliver them, the instruction surface area has grown monotonically without pruning, and we're applying Claude-designed patterns (BOOT_PENDING) to a GPT agent (Trey) without verifying cross-model compatibility.

### Jiang is the existence proof

Jiang works because: simple boot, asynchronous communication, file-based IPC, no real-time dependencies. Every property that makes Jiang reliable is a property we removed from Alexander and Trey by adding Agent Teams and boot complexity.

### Trey's bootloader recommendation requires modification

The state machine concept is sound as a Claude-side pattern. It should NOT be applied to Trey (GPT) without modification because:
- GPT has documented recency bias that undermines early-in-prompt constraints
- GPT's RLHF helpfulness optimization conflicts with halt behavior
- The fail-closed pattern has never been tested on GPT in a controlled setting

For Trey: the three-layer document separation (bootloader / identity / operating) is still correct. But the enforcement mechanism should be tool-gated (require file read tool calls as evidence) rather than prompt-state-machine (BOOT_PENDING/BOOT_COMPLETE in system prompt).

### What I got wrong in my first report

I gave MA storm/form/norm without researching. Specifically:
- I accepted Trey's state machine as "sound" without checking whether it works on GPT
- I proposed environment-aware enforcement tiers without researching what Agent Teams bugs exist
- I recommended CLAUDE.md become a "bootloader dispatcher" without diagnosing that the routing itself is part of the complexity problem
- I applied no confidence ratings, cited no sources, and inferred where I should have investigated

This report corrects that.

---

## SOURCES

**Agent Teams architecture and bugs:**
- GitHub anthropics/claude-code #23415 — Teammates don't poll inbox (tmux backend)
- GitHub anthropics/claude-code #24108 — Teammates stuck at idle prompt in tmux
- GitHub anthropics/claude-code #25131 — 23 agent incarnations, 35% productive (master issue)
- GitHub anthropics/claude-code #25135 — SendMessage silently succeeds with wrong recipient
- GitHub anthropics/claude-code #25139 — TeammateMailbox polling = 16.2% of debug log volume
- GitHub anthropics/claude-code #25254 — Messages not delivered in VS Code
- GitHub anthropics/claude-code #29271 — No distinction between idle and dead teammates
- GitHub anthropics/claude-code #34668 — Intermittent SendMessage failures after extended polling
- GitHub anthropics/claude-code #36196 — SendMessage tool not exposed on some platforms

**GPT system prompt behavior:**
- OpenAI Model Spec (2025/12/18) — model-spec.openai.com
- arXiv 2404.13208 — The Instruction Hierarchy: Training LLMs to Prioritize Privileged Instructions (OpenAI)
- Embrace The Red (Rehberger, July 2024) — GPT-4o-mini instruction hierarchy bypasses
- Promptfoo — GPT-4.1 safety regression (94% → 71%)
- OpenAI Developer Community — GPT-4 ignoring system prompts (multiple threads)
- OpenAI GPT-4.1 Prompting Guide — recency bias documented

**Multi-agent failure taxonomy:**
- arXiv 2503.13657 — Why Do Multi-Agent LLM Systems Fail? (MAST taxonomy, 150+ case studies)

**Tool enforcement vs prompt-only:**
- arXiv 2503.18666 — AgentSpec: Customizable Runtime Enforcement (ICSE 2026), 90-100% compliance
- aiyan.io — "Don't Prompt Your Agent for Reliability — Engineer It"
- AWS DEV Community — AI Agent Guardrails: Rules LLMs Cannot Bypass
- OWASP LLM Top 10 (2025) — architectural defense over prompt defense

**Claude vs GPT instruction following:**
- Zapier (2026) — Claude follows constraints on first attempt
- Tech-insider (2026) — 70% developer preference for Claude on instruction adherence
- Blockchain Council — Claude Opus ranking high for instruction adherence

**State machine implementations:**
- GitHub thatoldfarm/system-prompt — PRE_GENESIS_PI_BOOT fail-closed pattern
- arXiv 2403.11322 — StateFlow (Microsoft/AutoGen) — external FSM controlling LLM agents
- GitHub jsz-05/LLM-State-Machine — FSM framework for OpenAI API agents

[VELORIN.EOF]
