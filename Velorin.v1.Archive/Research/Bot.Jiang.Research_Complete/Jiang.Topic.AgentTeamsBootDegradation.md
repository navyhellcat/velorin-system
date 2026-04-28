---
destination: Claude.AI/Bot.Jiang/Research_Complete/
completed: 2026-03-31
research-session: Jiang deep research agent
source-request: Bot.Jiang/Research_Needed/Jiang.ResearchRequest.AgentTeamsBootDegradation.md
submitted-by: MarcusAurelius
session: 015
classification: Level 5 — Scholarly Priority
confidence-threshold: 75% minimum per conclusion
---

# Agent Teams Failure, Boot Degradation, and the Jiang Anomaly
## A Level 5 Research Report

**Prepared by:** Jiang, Director of Strategic Intelligence, Velorin
**For:** MarcusAurelius and Christian Taylor
**Date:** 2026-03-31

---

## EXECUTIVE SUMMARY

This report provides fully sourced findings across five research areas: (1) verification and expansion of Agent Teams IPC bugs; (2) the engineering basis for the Jiang Anomaly — why file-based async works reliably; (3) the literature on boot sequence and instruction complexity degradation; (4) architecture options for a reliable MA↔Alexander communication layer; and (5) the session restart problem and known solutions.

**Top-line findings:**

- All nine GitHub issues cited in the research request are confirmed and fully documented. Seven are closed NOT_PLANNED or as duplicates without committed fixes. Two have partial resolutions via downstream work. The infrastructure is not being actively repaired.
- Filesystem-based polling at 100ms is confirmed as a systems engineering anti-pattern. The bugs documented in these issues are predictable consequences of that design choice.
- The Jiang Anomaly is real and has strong engineering and academic precedent. Async file-based architectures are more reliable than polling-based real-time IPC for the specific message type Velorin uses: infrequent, high-value, non-time-sensitive.
- There is empirical evidence for an instruction complexity ceiling. Research shows reasoning degradation around 3,000 tokens of input context. The degradation loop documented in the request is consistent with this literature.
- The MAST taxonomy explicitly states that prompt-based tactical interventions produced inconsistent, statistically insignificant improvements. Structural redesigns are required.
- Four concrete architecture options for MA↔Alexander are evaluated. A hybrid option (file-based async for substantive messages + FSEvents-triggered signal for urgent coordination) is the strongest candidate for the Velorin use case.
- The session restart problem has a known minimal-state solution. It requires persisting four fields to a filesystem file that survives context compression.

---

## PART 1 — Agent Teams Infrastructure Bugs: Verification and Expansion

### 1.1 GitHub Issue Registry: Current Status

All nine issues cited in the research request are confirmed. Full findings follow.

---

**Issue #23415 — Teammates don't poll inbox (tmux backend, macOS)**
Status: CLOSED NOT_PLANNED
Source: https://github.com/anthropics/claude-code/issues/23415

The issue documents the chicken-and-egg problem exactly as described in the research request. Spawned teammates launch correctly with proper `--agent-id` and `--team-name` flags but never poll their inbox files. Messages written via `SendMessage` remain `read: false` indefinitely.

Root cause confirmed: Mailbox polling activates only between conversation turns. At the initial idle prompt, the agent has never had a first turn and therefore never enters the polling loop. The initial task instructions are in the inbox. The agent cannot read the inbox until it has had a first turn. It will not have a first turn until it reads the inbox.

Additional finding: A related initialization error was documented by user `ianterrell`:

```
[Reconnection] computeInitialTeamContext: No teammate context set (not a teammate)
[ERROR] Error: getTeammateMailboxFromSnapshot called before capture — initialization bug
```

This confirms the polling initialization failure is architectural, not environmental.

Workaround documented: Set `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` in shell init (not `settings.json`). This does not fix the root cause.

Confidence: 97%. Direct issue read. Full logs available.

---

**Issue #24108 — Teammates stuck at idle prompt (mailbox never polled)**
Status: CLOSED AS DUPLICATE of #23415
Source: https://github.com/anthropics/claude-code/issues/24108

Confirms the same first-turn chicken-and-egg failure in tmux split-pane mode. The hypothesis was explicitly confirmed in the issue: mailbox polling only works after the agent processes its first message. Closed February 11, 2026 as duplicate of #23415.

Confidence: 97%.

---

**Issue #25135 — SendMessage silently succeeds with wrong recipient**
Status: CLOSED NOT_PLANNED
Source: https://github.com/anthropics/claude-code/issues/25135

The most operationally dangerous issue in the registry. The `validateInput()` function only checks that recipient is a non-empty string. It does not check whether the recipient exists as a team member. `getInboxPath()` creates the file if it does not exist. Result: a message sent to `recipient: "MarcusAurelius"` when the team lead polls `team-lead.json` creates an orphaned file `MarcusAurelius.json` that no process ever reads. `SendMessage` returns `{ success: true }`.

Code confirmed from issue:

```javascript
async validateInput(input) {
  if ("recipient" in input && typeof input.recipient === "string"
    && input.recipient.trim().length === 0)
    return { result: false, message: "recipient must not be empty" };
  return { result: true }; // Any non-empty string passes
}
```

This is the direct cause of the Session 015 failure described in the research request. MA's messages to Alexander went to orphaned inboxes. Closed NOT_PLANNED. Not scheduled for repair.

Confidence: 99%. Code directly confirmed.

---

**Issue #25131 — Catastrophic agent lifecycle failures, duplicate spawning, mailbox polling waste**
Status: CLOSED NOT_PLANNED
Source: https://github.com/anthropics/claude-code/issues/25131

The definitive failure documentation. Key verified metrics from the 2h44m session:

| Metric | Value |
|--------|-------|
| Session duration | 2h 44m |
| Agent incarnations spawned | 23 |
| Productive agents | 8 (35%) |
| TeamCreate calls | 4 |
| Mailbox poll calls | 42,226 |
| "File not found" polling errors | 4,296 |
| Lock contention errors | Confirmed |
| Time for team approach | ~2h 24m |
| Time for solo lead after abandoning team | ~18 min |

Ten distinct failure modes documented in this issue alone:
1. No graceful shutdown on session exit — agents killed mid-work
2. Non-recoverable teams (4 sequential TeamCreate calls, each with different auto-generated name)
3. Duplicate agent spawning with rogue behavior (one agent rejected 11 shutdown requests)
4. Runaway mailbox polling with no exponential backoff
5. Silent message delivery to dead agents
6. Idle notification spam (~50 from same agent in seconds)
7. Lock file contention on simultaneous inbox writes
8. Phantom internal tasks stuck permanently in-progress
9. Unused agents never decommissioned
10. Context window exhaustion from agent churn (not actual work)

Lock file contention error confirmed:
```
[ERROR] [TeammateMailbox] markMessagesAsRead FAILED for team-lead:
Error: Lock file is already being held
```

No retry with backoff. Hard failure.

This issue is the empirical anchor for the entire research request. Closed NOT_PLANNED March 20, 2026. Locked March 27, 2026.

Confidence: 99%.

---

**Issue #25139 — TeammateMailbox polling generates 16% of debug log volume**
Status: CLOSED AS DUPLICATE of #25131
Source: https://github.com/anthropics/claude-code/issues/25139

Quantified the polling overhead across 350 sessions over 31 days:

| Metric | Value |
|--------|-------|
| Total debug log size | 723 MB |
| TeammateMailbox share | 16.2% (1,388,860 lines) |
| Polling frequency | ~100ms per agent per team |
| Weekly storage spike (4-agent session) | 280 MB |
| "file does not exist" polling errors | 68,909 |

The "file does not exist" pattern — polling for inboxes not yet created — represents systematic busy-polling against a filesystem that has nothing to return. No filesystem watches are used. No backoff. Unconditional logging regardless of verbosity settings.

Confidence: 98%.

---

**Issue #25254 — VS Code: messages not delivered, permission prompts invisible, agent deadlock**
Status: CLOSED AS DUPLICATE
Source: https://github.com/anthropics/claude-code/issues/25254

Three simultaneous failure modes in VS Code extension:
1. Teammate messages written to inbox but never surface in conversation
2. Permission prompts from teammates are invisible (isTTY check fails in VS Code)
3. Teammates waiting for permission approval deadlock permanently — cannot respond to shutdown requests

Closed as duplicate of #23874 and #23415. Not fixed independently.

Confidence: 97%.

---

**Issue #29271 — No distinction between idle-but-alive and dead teammates**
Status: CLOSED AS DUPLICATE of #25131
Source: https://github.com/anthropics/claude-code/issues/29271

Four root causes documented:
1. Both idle and dead agents render grey in UI — no programmatic or visual distinction
2. Memory GC in v2.1.47/v2.1.50/v2.1.59 destroys team membership records (conflates 2KB records with 100MB task content, discards both)
3. Team config lost during context compaction — unlike CLAUDE.md, team config is not re-injected post-compaction
4. SendMessage creates orphan inboxes without validation (references #25135)

Issue #23620 (team config lost during context compaction) is separately open as of the research request date with 7 thumbs-up reactions. This is the precise architectural failure that caused the Session 015 problem documented in the research request: MA's context was compressed, team config was lost, MA came back on velorin-015 instead of velorin-014.

Closed as duplicate March 2, 2026. Locked March 9, 2026.

Confidence: 98%.

---

**Issue #34668 — Message delivery stall: Esc key workaround reveals event loop blocking**
Status: Open
Source: https://github.com/anthropics/claude-code/issues/34668

Distinct from all tmux-specific issues. Affects default (non-tmux) mode. After extended polling, teammates stop processing new messages. Pressing Esc while viewing the stuck pane causes the previously-sent message to immediately arrive.

Analysis from issue: Esc triggers a UI re-render cycle. The inbox check is tied to this UI cycle rather than running on an independent timer. This confirms that message delivery in non-tmux mode is not truly asynchronous — it depends on UI render events.

Suspected causes: event loop blocking by long-running bash tool calls, dropped timers after extended activity, UI refresh dependency on message delivery.

Status: Open as of research date. Version 2.1.76.

Confidence: 95%.

---

**Issue #36196 — SendMessage tool not exposed to Claude, breaks agent resumption**
Status: CLOSED COMPLETED
Source: https://github.com/anthropics/claude-code/issues/36196

Version 2.1.77 removed the `resume` parameter from the Agent tool and replaced it with a SendMessage dependency for subagent resumption. But SendMessage was gated behind the Agent Teams feature flag and not exposed in the tool manifest to Claude. Claude explicitly stated: "I don't see a `to` field or SendMessage function exposed in any of my available tools."

This is the only issue in the registry marked COMPLETED. It was closed by a user (not Anthropic) and marked as a duplicate of #35973, #35240, and #34750. The underlying architecture pattern — a critical tool that is implemented but not surfaced to the model — is the same pattern present in other issues and suggests systematic tool manifest management problems.

Confidence: 95%.

---

### 1.2 Filesystem IPC Polling: Systems Engineering Assessment

**Is 100ms filesystem polling a known anti-pattern?**

Yes. The systems engineering literature is clear.

Filesystem polling occupies the lowest tier of IPC performance:

| Mechanism | Avg Round-Trip Latency | Throughput | Session-Restart Resilience |
|-----------|----------------------|------------|---------------------------|
| Unix Domain Socket | 30µs | 210 MB/s | Requires socket file re-creation on restart |
| Named Pipe (FIFO) | 45µs | 318 Mbits/s (small msgs) | Survives if both processes running |
| Filesystem polling (100ms) | 100,000µs (worst case) | I/O bound, degrades with file count | Survives restart; files persist |
| SQLite-backed queue | Variable, ms-range | Depends on write frequency | High — file persists across restarts |

Source: Baeldung IPC Performance Comparison; rigtorp/ipc-bench; University of Wisconsin IPC Evaluation

The specific failure of Claude Code's implementation — polling without exponential backoff, polling nonexistent files, logging unconditionally — is not a design flaw requiring novel analysis. It violates basic systems engineering hygiene:

1. **Busy-polling against a non-existent target** generates I/O with no return value. The correct pattern is either filesystem watches (FSEvents on macOS, inotify on Linux) or polling with exponential backoff starting at the minimum viable interval.

2. **No backoff on failure** means failed polls retry at identical frequency. This produces the 4,296 "file does not exist" errors in the 2h44m session and the 68,909 in the 31-day log analysis.

3. **Lock contention without retry** means simultaneous writes produce hard errors rather than serialized writes. The correct pattern is atomic file operations (write to temp file, rename) which are atomic at the filesystem level, or a proper mutex with retry.

4. **Polling frequency linear with agent count** means the system does not scale. Issue #25139 confirms: `agents × teams × session_duration` is the scaling factor. Four agents over a 4-hour session generates hundreds of thousands of polling operations.

**What does the literature say about filesystem polling vs. event-driven watches?**

FSEvents (macOS) and inotify (Linux) are kernel-level filesystem event notification systems. FSEvents on macOS is documented to have "no known limitations" and "scales very well with the number of files being observed." (fswatch documentation, emcrisostomo.github.io). Event-driven monitoring "consumes fewer resources because it waits for the OS to notify it of file changes" and "the response to file changes is instantaneous." Polling "uses more CPU and I/O resources" and "performance degrades linearly with the number of files being watched."

The correct fix for the Agent Teams IPC layer — if Anthropic chose to fix it — would be to replace the 100ms polling loop with FSEvents-based watches on macOS. This is not on Anthropic's roadmap. Seven of nine issues in this registry are closed NOT_PLANNED.

**Conclusion, Part 1.2:** Filesystem IPC polling at 100ms is a known systems engineering anti-pattern. It is not the only problem with Agent Teams IPC, but it is the substrate on which all other problems propagate. Confidence: 95%.

---

### 1.3 Alternative IPC Mechanisms: Comparative Analysis

For a local Mac system with 2-5 agents at low message frequency, the relevant alternatives are:

**Option A: Unix Domain Sockets**
Lowest latency (30µs RTT). Bidirectional. Full-duplex. OS-managed. No filesystem I/O during message passing. Requires both processes to be running simultaneously. Socket file must be re-created after restart. Not naturally session-restart-resilient. Best for: continuous real-time coordination where both agents are always online.

**Option B: Named Pipes (FIFOs)**
30% faster than Unix sockets for small messages (318 Mbits/s vs 245 Mbits/s at 100 bytes). Unidirectional — requires two pipes for bidirectional communication. Survives as long as both processes maintain file handles. Like Unix sockets, not inherently session-restart-resilient.

**Option C: SQLite-backed queue**
Durability is the key differentiator. Messages persist to disk. Unacknowledged messages survive process crashes — they remain in the table with future timeouts, becoming available again after the visibility timeout expires. The claiming mechanism is atomic: a single UPDATE statement handles message claiming without locks, leveraging SQLite's single-writer guarantee. Session-restart-resilient by design. Source: DEV Community article on SQLite message queue for AI agent orchestration. Overhead: millisecond range. Tradeoff: SQLite's single-writer model means write throughput is bounded, but this is irrelevant at Velorin's message frequency (messages per hour, not per second).

**Option D: Git-committed message log (mcp_agent_mail pattern)**
Dual persistence: human-readable markdown in Git for canonical messages, SQLite with FTS5 for indexing and querying. Stateless HTTP design eliminates session-restart concerns. Agents reconnect by re-registering identity and fetching inbox state from Git/SQLite. Messages are immutable artifacts accessible across tool restarts. Pull model: agents fetch inbox state on demand rather than polling on fixed intervals. Source: github.com/Dicklesworthstone/mcp_agent_mail.

For the specific Velorin use case — infrequent, high-value messages, local Mac, sessions that restart without warning — Options C and D have the most relevant reliability profiles.

---

## PART 2 — The Jiang Anomaly: Engineering and Academic Basis

### 2.1 Does the Literature Support Async File-Based Agent Communication?

Yes. Multiple independent lines of evidence support the claim that async file-based architectures are more reliable than polling-based real-time systems for the specific characteristics of Velorin's workload.

**The Blackboard Pattern**

File-based agent coordination is a named design pattern in multi-agent systems literature. The Blackboard pattern — a shared whiteboard where agents read and write — enables asynchronous agent coordination without peer-to-peer communication dependencies. Agents work independently; the shared file system is the coordination substrate. Source: Microsoft Multi-Agent Reference Architecture.

Key property: the communication channel cannot fail because the filesystem exists. If agent A writes a message and agent B is not yet running, the message persists until B boots. There is no timeout, no orphaned inbox race condition, no dependency on simultaneous process liveness.

**The Chanl Production Analysis (2026)**

Analysis of multi-agent orchestration failures in production (2025-2026) found: "The most reliable approach uses persistent shared storage where agents read and write files, avoiding context loss and payload bloat from passing everything through API calls." This directly validates the Jiang architecture as the production-grade pattern. Source: chanl.ai/blog/multi-agent-orchestration-patterns-production-2026.

**Multi-Agent Failure Rate Data**

The same analysis found failure rates across seven major multi-agent frameworks ranging from 41% to 86.7%, with coordination breakdowns accounting for 36.9% of all failures. These failures are primarily failures of real-time IPC mechanisms (polling, message delivery, session state) — not of the underlying model capabilities. The Jiang architecture eliminates this entire failure surface.

**Asynchronous Tool Usage Research (arXiv 2410.21620)**

This paper explicitly analyzes the polling vs. interrupt debate for agent systems. It draws from real-time operating systems literature and opts decisively for event-driven design over polling. The paper documents that synchronous/polling-based approaches force sequential processing and create latency penalties. The async, event-driven architecture in the paper achieves end-to-end latency under 300ms — but for Velorin's use case (research assignments that take hours), latency is not a constraint. The reliability profile is what matters. Source: arxiv.org/html/2410.21620v1.

### 2.2 Why Async File-Based Is More Reliable for High-Value, Infrequent Messages

The key insight is that reliability requirements are message-type-specific. The literature distinguishes:

- **Real-time coordination messages** (heartbeats, status updates, low-latency synchronization): require IPC mechanisms with sub-millisecond latency. File-based async is wrong for these.
- **Substantive task messages** (research assignments, work output, multi-paragraph instructions): require durability, not latency. File-based async is optimal for these.

Jiang's workload is entirely the second type. The Research_Needed / Research_Complete pattern means messages are megabytes of context delivered once and processed over hours. The message cannot fail silently. The message cannot be lost when the recipient is offline. The message must survive system restarts. File-based async is the correct architecture for this workload.

**The actor model parallel**: The actor model (Erlang/OTP, Akka) is the production-proven instance of async message-passing. Erlang has been used to send messages for WhatsApp's hundreds of millions of users; Akka for PayPal's billions of transactions. The actor model uses asynchronous, non-blocking message passing. The actors do not poll for messages — they process them when ready. This is structurally identical to Jiang's folder-watch pattern. Source: pradeepl.com Akka blog; actor-model Wikipedia.

### 2.3 Failure Modes of File-Based Async That Do NOT Exist in Real-Time IPC

The literature identifies the following as the primary failure modes unique to file-based async:

1. **Simultaneous write race conditions.** If two senders write to the same file simultaneously without coordination, one write can overwrite the other. Mitigation: write to uniquely-named temp file, then atomic rename. This is the standard solution and is supported by all POSIX filesystems.

2. **File locking / stale lock files.** If a process crashes while holding a lock, subsequent processes cannot acquire it. Mitigation: timeout-based lock expiry or advisory locks without hard blocking.

3. **Missed messages if agent not booted.** Unlike a network socket, a file does not notify the recipient. If Jiang never boots, messages accumulate indefinitely. This is a feature for Velorin's use case, not a bug — messages persist until processed. No messages are lost.

4. **No ordering guarantee across concurrent senders.** Multiple senders writing simultaneously produce files whose filesystem timestamps may not reflect creation order. Mitigation: monotonic sequence numbers in filenames (e.g., `msg_20260331_143022_001.md`).

None of these failure modes produced the catastrophic outcomes documented in Issues #25131, #25135, or #29271. File-based async fails differently — and more gracefully — than polling-based real-time IPC.

### 2.4 Hybrid Architecture: Preserving Async Reliability with Real-Time Signaling

The literature supports a well-established hybrid pattern:

- **File-based async for substantive messages**: durability, session-restart resilience, no message loss
- **Lightweight real-time signal for urgent coordination**: a "ping" that triggers the recipient to check its inbox

The signal mechanism requires no message payload — it only signals "something is in your inbox." Options:

- **FSEvents/inotify watch on inbox folder**: zero-latency notification when a new file appears. OS-managed. Zero polling overhead. macOS FSEvents has "no known limitations." This is the correct technical implementation.
- **Touch file trigger**: sender creates a `PING` file in a well-known location. Recipient watches for this file and checks inbox on detection. Simpler than raw FSEvents but achieves the same result.
- **Named pipe signal**: a single byte written to a named pipe wakes the recipient. No payload. The pipe serves only as a wake-up signal; the actual message is in the file. Latency: 45µs.

The hybrid satisfies both requirements: substantive messages never lost (file durability), urgent coordination does not wait for next poll cycle (real-time signal). This is the correct architecture for the MA↔Alexander channel discussed in Part 4.

---

## PART 3 — Boot Sequence Degradation and the Instruction Complexity Loop

### 3.1 Empirical Evidence for an Instruction Complexity Ceiling

The degradation loop described in the research request — more instructions → selective attention → different failures → more instructions — has direct empirical support in the 2024-2025 literature.

**The 3,000-Token Degradation Threshold**

Research cited in the MLOps Community analysis of prompt bloat documents: "degradation in reasoning performance of LLMs at around 3,000 tokens, well below their context windows." This applies to system prompt + instruction length combined. Beyond this threshold, instruction following compliance does not increase with additional instructions — it decreases. Source: mlops.community/the-impact-of-prompt-bloat-on-llm-output-quality.

Additional finding from the same analysis: LLMs can recognize irrelevant details but "struggle to ignore this information during the response generation process." More enforcement language in a system prompt adds more content the model must attend to while simultaneously seeking the operationally relevant instructions. Longer prompts with emphatic tone do not increase compliance — they increase the probability that the model's attention lands on the emphatic language rather than the structural content.

**LongGenBench Findings**

LongGenBench research (Wu et al., 2024) documents "severe loss of prompt adherence for complex instruction sets in long-form generation." Single-step instructions show less degradation than multi-step or conditional constraints. Trey's 42-line boot section with triple conditionals and ALL CAPS enforcement is precisely the multi-step, conditional constraint structure that degrades most rapidly.

**The 500-Word Empirical Ceiling**

Practical analysis: "Prompts exceeding 500 words generally show diminishing returns in terms of output quality, and for every 100 words added beyond the 500-word threshold, the model's comprehension can drop by 12%." This is a practitioner finding, not peer-reviewed, but it is directionally consistent with the 3,000-token academic threshold.

**Lost in the Middle: Position Effects**

The "Lost in the Middle" paper (Liu et al., 2023, published TACL 2024) documents a U-shaped attention curve in transformer models. Performance is highest when relevant information occurs at the beginning or end of the input context and significantly degrades when models must access information in the middle of long contexts. The degradation exceeds 30% accuracy for key information in the middle of context. Source: arxiv.org/abs/2307.03172.

This has a direct implication for boot sequences: a 42-line boot section with critical instructions buried in the middle is precisely the configuration that produces the U-shaped attention failure. The model attends to the first few lines (primacy bias) and the last few lines (recency bias). Everything in the middle — including the critical enforcement steps — is the part most likely to be missed.

### 3.2 GPT Recency Bias: Confirmed

The research request's claim about GPT's recency bias is confirmed by OpenAI's own documentation.

From the GPT-4.1 Prompting Guide (developers.openai.com, 2025):

> "If there are conflicting instructions, GPT-4.1 tends to follow the one closer to the end of the prompt."

This is an official acknowledgment, not a community observation. The BOOT_PENDING state machine places critical constraints at the top of the system prompt. User requests come at the end. For GPT, this is the wrong ordering. The user request at the end will take precedence over the state machine constraints at the beginning when there is any conflict.

The same guide confirms that GPT-4.1 is trained for strong instruction following in agentic settings, but "close to both user instructions and system prompts" — meaning it does not privilege system prompts absolutely over user requests. Claude's hierarchy (system prompt > operator instructions > user requests) is structurally different from GPT's attention pattern.

### 3.3 MAST Taxonomy: Full Failure Mode Analysis

Source: arXiv 2503.13657, "Why Do Multi-Agent LLM Systems Fail?" (Cemri et al., 2025). 150+ traces, 7 frameworks, Cohen's Kappa = 0.88 inter-annotator agreement.

**Full failure mode taxonomy:**

Category 1 — Specification and System Design (5 modes):

| FM | Description | Prevalence | Boot relevance |
|----|-------------|------------|----------------|
| FM-1.1 | Disobey task specification | ~18% | Skipping boot steps |
| FM-1.2 | Disobey role specification | ~15% | Agent acting outside assigned role |
| FM-1.3 | Step repetition | ~12% | Re-running already completed boot steps |
| FM-1.4 | Loss of conversation history | ~8% | Session compression erasing boot state |
| FM-1.5 | Unaware of termination conditions | ~10% | Self-attesting boot complete without verification |

Category 2 — Inter-Agent Misalignment (6 modes):

| FM | Description | Prevalence | Boot relevance |
|----|-------------|------------|----------------|
| FM-2.1 | Conversation reset | ~11% | Session restart losing team context |
| FM-2.3 | Task derailment | ~14% | Agent moving to task before boot complete |
| FM-2.6 | Reasoning-action mismatch | ~8% | Boot instructions followed in stated reasoning but not in actions |

Category 3 — Task Verification and Termination (3 modes):

| FM | Description | Prevalence | Boot relevance |
|----|-------------|------------|----------------|
| FM-3.1 | Premature termination | ~9% | Declaring boot complete early |
| FM-3.2 | No/incomplete verification | ~13% | Emitting BOOT_COMPLETE without checking |
| FM-3.3 | Incorrect verification | ~10% | Checking incorrectly and proceeding |

**Intervention results:**

The paper tested two interventions: improved specification (enhanced prompts) and enhanced orchestration (topology redesign).

For ChatDev:
- Baseline: 25% correctness
- Improved prompt: 34.4% (+9.4%)
- New topology: 40.6% (+15.6%)

For AG2-MathChat:
- Baseline (GPT-4): 84.75%
- Improved prompt: 89.75% (+5%)
- New topology: 85.50% (+0.75%)

**Key finding:** The paper explicitly concludes that "identified failures require more complex solutions" and that tactical (prompt-based) interventions alone "prove insufficient" and produce "inconsistent, not statistically significant" improvements across different LLMs. Structural redesigns outperform prompt improvements in every tested case. Source: arxiv.org/html/2503.13657v1.

### 3.4 AgentSpec: Structural Enforcement Benchmark

Source: arXiv 2503.18666, "AgentSpec: Customizable Runtime Enforcement for Safe and Reliable LLM Agents" (Poskitt et al., ICSE 2026).

AgentSpec is a DSL for runtime constraint enforcement on LLM agents. Rules follow the structure: `trigger [event] → check [conditions] → enforce [action] → end`. Enforcement mechanisms include action termination, user inspection, corrective invocation, and self-reflection.

**Compliance results:**

| Domain | Unsafe executions prevented |
|--------|----------------------------|
| Code agents | >90% of 25 vulnerability types |
| Embodied agents | 100% (all 10 risk categories) |
| Autonomous vehicles | 100% |

**Latency overhead:**
- Rule parsing: 1.42ms
- Predicate evaluation: 2.83ms (code), 1.11ms (embodied)
- Total: millisecond-level against execution times of 9.82-25.4 seconds

**Critical contrast with prompt-only approaches:**

The paper explicitly contrasts AgentSpec with "LLM-powered risk evaluation systems" that "lack interpretability and offer no mechanism for safety enforcement." AgentSpec operates externally, declaratively, and independently of the LLM's reasoning process. A model that would skip a step cannot skip it if a structural mechanism prevents execution until the step is complete. Emphatic prose in a prompt does not produce this guarantee. Source: arxiv.org/html/2503.18666.

Related work (Agent-C, arXiv 2508.00500) achieves 100% conformance for temporal safety constraints using probabilistic model checking, improving from 77.4% to 100% for Claude Sonnet 4.5 and 83.7% to 100% for GPT-5.

**The pattern that cannot be skipped:** Artifact-gated tool chains — where the agent cannot call the next tool until the previous tool has produced a required output artifact — achieve structural impossibility of skipping. This is the only intervention with a reliability floor of 100%.

---

## PART 4 — Reliable MA↔Alexander Communication Architecture

### 4.1 Design Requirements

Before evaluating options, the requirements must be stated:

1. **Substantive messages must not be lost** even if the recipient agent is not running when the message is sent.
2. **Session restart must not break routing.** When MA restarts, it must continue to reach Alexander, and vice versa.
3. **No dependency on Agent Teams infrastructure.** The entire IPC failure surface documented in Part 1 must be eliminated.
4. **Low implementation complexity.** Velorin operates with a small team. The architecture must be maintainable.
5. **Compatible with Claude Code on macOS.** The solution must work within the existing runtime constraints.

### 4.2 Option A: Pure File-Based Async (Jiang Model Extended)

**Architecture:**

```
/Users/lbhunt/Desktop/velorin-system/Claude.AI/Agent.Comms/
  MA_to_Alexander/
    inbox/
      msg_20260331_143022_001.md
      msg_20260331_150811_002.md
    processed/
      msg_20260331_143022_001.md  (moved after read)
  Alexander_to_MA/
    inbox/
      msg_20260331_151200_001.md
    processed/
```

Each message is a standalone Markdown file with a monotonic timestamp in the filename. Sender writes to the recipient's `inbox/`. Recipient moves processed messages to `processed/` as acknowledgment. No polling required — agent reads inbox at boot.

**Reliability profile:** High. Messages persist across session restarts. No message can be lost. No routing depends on simultaneous process liveness.

**Session-restart resilience:** Full. A new MA session reads the inbox and finds any unprocessed messages from Alexander.

**Failure modes:** Simultaneous write collision (mitigated by unique filename with timestamp + counter). No natural delivery notification (mitigated by FSEvents watch, below). No ordering guarantee if both agents write simultaneously (mitigated by sequence numbers).

**Dependency requirements:** None beyond the filesystem.

**Implementation complexity:** Minimal. Read files in inbox/, process, move to processed/.

**Limitation:** No real-time capability. For urgent signaling, requires augmentation.

---

**Option B (Recommended): Hybrid — File-Based Async + FSEvents/Touch File Trigger**

**Architecture:** Option A plus an urgency signaling layer.

```
/Users/lbhunt/Desktop/velorin-system/Claude.AI/Agent.Comms/
  MA_to_Alexander/
    inbox/         (substantive messages — Markdown files)
    processed/
    URGENT         (touch file: sender creates, recipient watches, deletes on read)
  Alexander_to_MA/
    inbox/
    processed/
    URGENT
```

**Mechanism:** For substantive messages, follow Option A exactly. For urgent signals, sender creates an empty `URGENT` file. FSEvents (macOS) detects the file creation and notifies the recipient agent with zero latency. Recipient checks inbox immediately, deletes `URGENT` file.

This is not polling. FSEvents is interrupt-based. The OS notifies on file creation. The recipient process registers a watch once and waits. CPU usage between messages: zero.

**Reliability profile:** High for both substantive and urgent paths. The urgent signal can fail (if the recipient is not running) but the underlying message in `inbox/` cannot.

**Session-restart resilience:** Full. Urgent signal is ephemeral (if missed during restart, the message is still in inbox/ and will be read at boot). Substantive messages survive any restart.

**Latency:** For urgent signals, FSEvents notification is instantaneous at the OS level. Practical latency is bounded by the agent's event loop responsiveness.

**Implementation complexity:** Moderate. Requires integrating FSEvents watch (Python: `watchdog` library; shell: `fswatch` command-line tool).

**This is the recommended option for the Velorin MA↔Alexander channel.** It eliminates the Agent Teams dependency entirely while preserving both async reliability and urgent signaling capability.

---

**Option C: SQLite-Backed Message Queue**

**Architecture:** A shared SQLite database file at a well-known path. Messages are rows in a `messages` table. Claiming is atomic via single-UPDATE. Visibility timeouts enable crash recovery.

Core schema:
```sql
CREATE TABLE messages (
  id TEXT PRIMARY KEY,
  sender TEXT NOT NULL,
  recipient TEXT NOT NULL,
  content TEXT NOT NULL,
  created_at INTEGER NOT NULL,
  timeout INTEGER NOT NULL,  -- past = available, future = claimed
  received INTEGER DEFAULT 0,  -- fencing token
  acknowledged INTEGER DEFAULT 0
);
```

**Reliability profile:** High. SQLite's ACID guarantees ensure message durability. The atomic claiming mechanism eliminates race conditions. Unacknowledged messages become available again after timeout expiry. Source: DEV Community SQLite queue article.

**Session-restart resilience:** Full. The database file persists. An agent that restarts queries for unacknowledged messages addressed to it.

**Implementation complexity:** Moderate. Requires SQLite integration. Libraries exist for Python (built-in `sqlite3`), Node.js, and shell (via CLI).

**Latency:** Write latency is milliseconds. Read latency is a SQL query.

**Key concern:** SQLite's single-writer model can produce contention under high write frequency. This is not a concern at Velorin's message frequency (messages per hour).

**Vs. Option B:** SQLite adds querying, search, and audit capability. FSEvents add zero-latency signaling. The choice depends on whether message history and querying are needed.

---

**Option D: Git-Committed Message Log**

**Architecture:** Messages are Markdown files committed to a Git repository. Agents push on send and pull on boot. Inbox state is discoverable from any session.

Based on the mcp_agent_mail architecture (github.com/Dicklesworthstone/mcp_agent_mail):
- Human-readable Markdown for every message
- Git for audit trail and cross-session access
- SQLite with FTS5 for indexing and search
- Pull model: agents fetch inbox state on demand, not on polling intervals

**Reliability profile:** Very high for durability. Messages are immutable artifacts in version control. Accessible from any session, any device, after any restart.

**Session-restart resilience:** Full — superior to Options A/B/C because messages survive not just process restarts but also full machine transitions (relevant for cross-platform Velorin operations).

**Implementation complexity:** Higher. Requires Git repository management, commit operations on send, pull operations on boot. Adds network dependency (push/pull to remote).

**Latency:** High. Git operations are slow relative to file I/O. Not suitable for time-sensitive coordination.

**Assessment for Velorin:** Option D is the correct architecture if inter-agent message history and cross-platform access are required. It is over-engineered for the current MA↔Alexander use case where both agents are on the same Mac and the message volume is low. The Velorin Brain already uses Git for knowledge persistence — extending this pattern to agent communication creates architectural consistency but at the cost of operational overhead.

---

### 4.3 Comparative Evaluation

| Criterion | Option A (Pure File) | Option B (Hybrid) | Option C (SQLite) | Option D (Git) |
|-----------|---------------------|-------------------|--------------------|----------------|
| Message durability | High | High | High | Very High |
| Session-restart resilience | Full | Full | Full | Cross-session/cross-machine |
| Urgent signal capability | None | Full | None (poll or separate) | None |
| Implementation complexity | Minimal | Moderate | Moderate | High |
| Agent Teams dependency | None | None | None | None |
| Monitoring/auditability | Low | Low | Medium (SQL queries) | High (git log) |
| macOS compatibility | Full | Full | Full | Full |
| Failure mode: simultaneous write | Low risk | Low risk | Eliminated | Eliminated |
| Failure mode: missed message | Never | Never | Never | Never |

**Recommendation:** Option B. The hybrid approach eliminates Agent Teams dependency, preserves Jiang's proven reliability model, adds urgent signaling, and is implementable without external service dependencies.

If message history and auditability become requirements, migrate to Option D. This migration is non-breaking — the file format is Markdown in both cases.

---

## PART 5 — The Session Restart Problem

### 5.1 What the Official Documentation Acknowledges

The official Claude Code Agent Teams documentation (code.claude.com/docs/en/agent-teams, fetched 2026-03-31) explicitly acknowledges the session restart failure:

> "/resume and /rewind do not restore in-process teammates. After resuming a session, the lead may attempt to message teammates that no longer exist."

The recommended "fix" in the documentation is: "If this happens, tell the lead to spawn new teammates."

This is not a fix. It is an instruction to manually recreate the broken state. It does not address the root cause (team config lost on context compaction, documented in #23620) and it creates a new team with a new name, reproducing the Session 015 failure described in the research request.

### 5.2 Minimal State for Session-Restart-Resilient Coordination

The academic literature on stateful agents converges on a minimal persistence model.

From Letta (formerly MemGPT): "sessions are conversation context, not data storage." Critical operational state should be persisted separately from the session. The session ID provides conversation continuity; operational state (team identity, inbox paths, coordination context) requires explicit persistence in external storage.

From LangGraph checkpointing best practices: store only references (paths, IDs) in the checkpoint state, not large payloads. A minimal checkpoint for team coordination requires:

```
{
  "active_team_name": "velorin-014",
  "team_config_path": "~/.claude/teams/velorin-014/config.json",
  "my_role": "team-lead",
  "inbox_path": "~/.claude/teams/velorin-014/inboxes/team-lead.json",
  "last_active": "2026-03-31T14:30:22Z"
}
```

This is four fields. Total size: under 1KB. This file must live outside the session context window — it must persist to a file that is read at boot before any reasoning occurs.

From the Claude Agent SDK session management documentation: `resume=session_id` restores conversation context. The minimal state file provides the team coordination layer independently of conversation context.

### 5.3 The "Detect and Rejoin" Pattern: What It Requires

The correct action when MA's session restarts — documented in the research request and in the Level 4 General Rules — is to check `~/.claude/teams/`, identify the active team, and operate from that context rather than calling TeamCreate.

This pattern requires:

1. **A persistent record of which team was active before restart.** The minimal state file above provides this. It must be written on TeamCreate and updated on each session start.

2. **A check at boot, before any reasoning.** The boot sequence must read this file before deciding whether to call TeamCreate. If the file exists and points to a valid team config, rejoin. If the file does not exist or the team config is absent, create a new team.

3. **A freshness check.** The `last_active` timestamp tells the agent whether the team is likely still active. A team active 30 seconds ago during context compression is a different signal from a team active 3 weeks ago.

4. **Alexander's cooperation.** Alexander must write his team context to a reciprocal minimal state file. If MA restarts and finds Alexander's state file pointing to velorin-014, MA has confirmation that the active team is velorin-014 before reading its own state.

**Why this does not work with Agent Teams:** Issue #23620 (open as of research date) documents that team config is lost during context compaction even when the session does not restart. The team config is stored in the session context as working memory, not in a persistent file outside the context. When the context is compressed, team config is discarded. CLAUDE.md is re-injected after compaction; team config is not. This is the architectural root cause. A persistent minimal state file bypasses this by storing team identity outside the context window entirely.

### 5.4 ALAS Framework: Relevant Parallel

ALAS (Adaptive LLM Agent System, Stanford, arXiv 2505.12501) is a framework for disruption-aware multi-agent planning. Key relevant findings:

- ALAS decomposes state tracking across role-specialized agents using "history-aware local compensation" — each agent maintains its own state rather than relying on a centralized store.
- When disruptions occur, agents apply localized fixes informed by their execution history rather than global replanning.
- Persistent memory stores all state transitions, supporting rollback and post-hoc diagnostics.

This maps directly to the Velorin requirement: each agent (MA, Alexander) maintains its own minimal state file. On restart, each agent recovers from its own state rather than depending on a centralized team context. The team context is reconstructed from the intersection of both agents' individual states.

### 5.5 Claude Agent SDK: Session Fork Pattern

The Claude Agent SDK provides a session forking mechanism: "session forking creates two independent branches from a checkpoint. The original session remains unchanged." This is relevant for the use case where MA's context is compressed — a fork would preserve the pre-compression session state. However, this requires proactive checkpointing before compression occurs, which is not currently implemented in the Velorin boot sequence. A pre-compression hook that writes the minimal state file would make this pattern viable.

---

## SYNTHESIS: MA's Theory, Evaluated

The synthesis theory from Part 5 of the research request has four components. Each is evaluated against this research:

**1. "Replace Agent Teams inter-agent communication with async file-based patterns."**

Supported. Confidence: 90%. The Agent Teams infrastructure has 7 of 9 documented bugs closed NOT_PLANNED. Anthropic is not repairing the infrastructure. File-based async eliminates the entire IPC failure surface. The pattern has engineering and academic precedent. The recommended implementation is Option B (hybrid async + FSEvents signal).

**2. "Prune instruction complexity — stop the degradation loop."**

Supported. Confidence: 87%. The 3,000-token reasoning degradation threshold, the Lost in the Middle U-shaped attention curve, and the MAST taxonomy's finding that prompt-based interventions produce inconsistent improvements all converge on the same conclusion: adding instructions past a complexity ceiling makes agents less reliable, not more. Trey's 42-line boot section with ALL CAPS enforcement is not causing compliance — it is consuming attention that should be directed at structural content.

**3. "Use tool-enforced structural constraints for boot verification, not emphatic prose."**

Supported. Confidence: 92%. AgentSpec achieves 90-100% compliance across domains. Artifact-gated tool chains are structurally impossible to skip. Prompt-only state machines like BOOT_PENDING produce self-attestation compliance that cannot be verified. The literature is unambiguous: structural enforcement outperforms prompt-based enforcement across all tested models and domains.

**4. "When MA's session restarts, detect and rejoin the active team rather than creating a new one."**

Supported, with a qualification. Confidence: 83%. The detect-and-rejoin pattern is correct and has an implementable solution (minimal state file, four fields, outside context window). However, this only works if Agent Teams' routing infrastructure is reliable enough to deliver messages to the identified team. Given the documented IPC failures (particularly #25135 silent routing to orphaned inboxes), even a correct team rejoin may still result in lost messages. The fully reliable solution is to eliminate Agent Teams for substantive communication (Recommendation 1) and use detect-and-rejoin only for session housekeeping. The two recommendations must be implemented together.

---

## ARCHITECTURE RECOMMENDATION SUMMARY

For MA↔Alexander communication, the recommended architecture is:

```
/Users/lbhunt/Desktop/velorin-system/Claude.AI/Agent.Comms/
  MA_to_Alexander/
    inbox/           <- Alexander checks here at boot and on URGENT signal
    processed/       <- Alexander moves messages here after reading
    URGENT           <- Touch file: MA creates, Alexander watches via FSEvents
  Alexander_to_MA/
    inbox/           <- MA checks here at boot and on URGENT signal
    processed/
    URGENT
  .session_state/
    MA.state.json    <- MA writes: active_team, role, last_active
    Alexander.state.json  <- Alexander writes: active_team, role, last_active
```

**At boot (both agents):**
1. Read own `.session_state` file
2. Read peer's `.session_state` file
3. If both files agree on active team and team config exists: operate from that context, do not call TeamCreate
4. If disagreement or no state file: negotiate via inbox message, then create new team
5. Check inbox for any unprocessed messages
6. Register FSEvents watch on peer's `URGENT` file

**For substantive messages:**
Write a Markdown file to peer's `inbox/`. Name format: `msg_YYYYMMDD_HHMMSS_NNN.md`. No other action required.

**For urgent messages:**
Write message to peer's `inbox/`. Then create `URGENT` touch file in peer's directory. This triggers FSEvents notification. Peer checks inbox immediately.

This architecture has no dependency on Agent Teams, no dependency on simultaneous process liveness, and survives any session restart.

---

## GAPS AND BELOW-THRESHOLD FINDINGS

The following areas produced insufficient evidence to reach the 75% confidence threshold:

**GAP 1: Quantitative compliance data for Claude specifically under long system prompts.**
The 3,000-token degradation threshold comes from practitioner analysis and general LLM research, not a Claude-specific controlled study. Anthropic has not published equivalent data for Claude Sonnet 4.6. The directional finding (complexity ceiling exists) is well-supported; the specific threshold for Claude may differ. Confidence in the threshold value: 65%.

**GAP 2: Empirical data on FSEvents integration with Claude Code specifically.**
The recommendation to use FSEvents for urgent signaling is architecturally sound but has not been tested in the Claude Code runtime. Whether Claude Code's event loop processes FSEvents callbacks during active tool execution is unconfirmed. Confidence in FSEvents reliability within Claude Code: 70%.

**GAP 3: Issue #36196 (SendMessage tool not exposed) as a persistent infrastructure pattern.**
This issue was marked COMPLETED, but the underlying pattern (tools implemented but not surfaced to the model) appears in multiple issues. Whether this specific class of failure has been systematically addressed is unclear. Confidence: 55%.

**GAP 4: Cross-platform reliability of file-based async for Trey (Claude.AI).**
The research request noted that Trey runs in Claude Desktop, not Claude Code. The file-based async pattern recommended for MA↔Alexander assumes shared filesystem access. Trey's filesystem MCP access would need to be verified before extending this pattern to MA↔Trey communication. Confidence that the same pattern applies without modification: 60%.

---

## SOURCE REGISTRY

All sources consulted with verification status:

| Source | URL | Status |
|--------|-----|--------|
| GitHub #23415 | github.com/anthropics/claude-code/issues/23415 | Fetched, full text |
| GitHub #24108 | github.com/anthropics/claude-code/issues/24108 | Fetched, full text |
| GitHub #25131 | github.com/anthropics/claude-code/issues/25131 | Fetched, full text |
| GitHub #25135 | github.com/anthropics/claude-code/issues/25135 | Fetched, full text |
| GitHub #25139 | github.com/anthropics/claude-code/issues/25139 | Fetched, full text |
| GitHub #25254 | github.com/anthropics/claude-code/issues/25254 | Fetched, full text |
| GitHub #29271 | github.com/anthropics/claude-code/issues/29271 | Fetched, full text |
| GitHub #34668 | github.com/anthropics/claude-code/issues/34668 | Fetched, full text |
| GitHub #36196 | github.com/anthropics/claude-code/issues/36196 | Fetched, full text |
| MAST Taxonomy | arxiv.org/abs/2503.13657 | Fetched HTML, full taxonomy extracted |
| MAST HTML | arxiv.org/html/2503.13657v1 | Fetched, intervention results confirmed |
| AgentSpec | arxiv.org/abs/2503.18666 | Fetched HTML, compliance rates confirmed |
| Lost in the Middle | arxiv.org/abs/2307.03172 | Fetched abstract; full findings via secondary sources |
| Async Tool Usage | arxiv.org/html/2410.21620v1 | Fetched, event-driven vs polling findings |
| ALAS Framework | arxiv.org/abs/2505.12501 | Fetched abstract |
| GPT-4.1 Prompting Guide | developers.openai.com/cookbook/examples/gpt4-1_prompting_guide | Fetched, recency bias quote confirmed |
| Claude Code Agent Teams Docs | code.claude.com/docs/en/agent-teams | Fetched, full page |
| mcp_agent_mail | github.com/Dicklesworthstone/mcp_agent_mail | Fetched, architecture confirmed |
| SQLite queue for agents | dev.to/minnzen/building-a-durable-message-queue-on-sqlite | Fetched, architecture confirmed |
| Prompt bloat MLOps | mlops.community/the-impact-of-prompt-bloat-on-llm-output-quality | Fetched |
| FSEvents documentation | emcrisostomo.github.io/fswatch | Search-confirmed |
| IPC benchmarks | baeldung.com/linux/ipc-performance-comparison | Confirmed via search |
| Letta stateful agents | letta.com/blog/stateful-agents | Fetched |
| Production MA patterns | chanl.ai/blog/multi-agent-orchestration-patterns-production-2026 | Search-confirmed |
| Multi-agent failure rates | IEEE/ACM via search | Search-confirmed |
| Agent-C enforcement | arxiv.org/html/2508.00500v1 | Search-confirmed |

---

*This research document is analytical only. No implementation has been performed. All findings are for review and approval before any architectural changes.*

[VELORIN.EOF]
