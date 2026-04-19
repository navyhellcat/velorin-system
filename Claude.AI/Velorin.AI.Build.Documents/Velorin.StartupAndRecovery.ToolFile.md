# Velorin — Startup, Compaction Recovery, and Token Optimization
**Tool Reference | Updated: April 19, 2026 | Session 028**
**What was changed, why it was changed, and what still needs to happen**

---

## CHANGES MADE — ALL IMPLEMENTED

### 1. SessionStart Compact Hook (NEW — Session 028)
**File:** `~/.claude/settings.local.json`
**What:** Added `"matcher": "compact"` to SessionStart hooks. After compaction fires,
the next session automatically cats the current handoff file into context before the
first message. Deterministic — cannot be forgotten or overridden by LLM behavior.
**Why:** Advisory reads (CLAUDE.md, MEMORY.md) erode under gradient pressure. Hooks
are deterministic. Research finding from Session 015: "hooks > CLAUDE.md > skills"
in the enforcement hierarchy. A hook cannot be ignored.
**Hook:** `cat '/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/Jiang.SessionHandoff.Session028.Apr19.md'`
**Limit:** 10,000 char injection cap. Current handoff is ~9,100 chars — safe.
**Action needed:** Update the handoff path in this hook at the start of each new session.

### 2. SessionStart Startup Hook (NEW — Session 028)
**File:** `~/.claude/settings.local.json`
**What:** Added `"matcher": "startup"` to SessionStart hooks. On every fresh session
start, automatically runs `git pull origin main --quiet` before any work.
**Why:** "GitHub is source of truth — always pull before any read that matters."
Advisory instructions to pull are frequently skipped under gradient pressure. Hook
makes it automatic. Research origin: feedback_github_source_of_truth memory entry.
**Confirmed working:** yes.

### 3. PreCompact + PostCompact Hooks (ALREADY WIRED — pre-session 028)
**File:** `~/.claude/settings.local.json`
**What:** PreCompact saves TEAM_STATE.md + pre-compact-team-save.sh.
PostCompact restores via post-compact-team-restore.sh.
**Why:** Agent Teams config is stripped on compaction (GitHub bug #23415, NOT_PLANNED
by Anthropic). TEAM_STATE.md with 2-hour recency window is the correct mitigation.
Research from Session 015 AgentTeamsBootDegradation research.
**Status:** Wired. Scripts exist at `Claude.AI/hooks/`.

### 4. ENABLE_TOOL_SEARCH: true (ALREADY SET)
**File:** `~/.claude/settings.local.json`
**What:** Defers MCP tool schema loading until a tool is actually needed.
**Why:** Without this, all MCP schemas load at session start — ~40K tokens overhead.
With this: ~2K tokens. Confirmed in Session 016. Savings: ~38K tokens per session.
**Status:** Active.

### 5. model: claude-sonnet-4-6[1m] (ALREADY SET)
**File:** `~/.claude/settings.local.json`
**What:** Forces 1M context window in terminal sessions.
**Why:** Desktop app hard-caps at 200K (Anthropic-enforced). Terminal respects the [1m]
flag. Confirmed in Session 022.
**Status:** Active.

### 6. JSON Block in Session Handoffs (NEW — Session 028)
**What:** Machine-readable JSON at the top of every handoff file with key state:
session number, active tasks, critical blockers, locked decisions, first action.
**Why:** The compact hook cats the handoff. If the hook fires and context is tight,
the JSON block is the first thing read — highest-density state in the fewest tokens.
The prose narrative follows for human reading.
**Format:**
```json
{
  "session": N,
  "agent": "Jiang2",
  "critical_blocker": "...",
  "locked_this_session": [...],
  "open_decisions": [...],
  "build_state": "...",
  "first_action": "..."
}
```

### 7. MEMORY.md Top-of-File Pointer (MAINTAINED)
**File:** `~/.claude/projects/-Users-lbhunt/memory/MEMORY.md`
**What:** The `>>> ... <<<` marker at the top of MEMORY.md points to the current
session handoff. MEMORY.md loads on every session boot.
**Why:** MEMORY.md is always in context. The first line pointing to the current handoff
ensures every session starts with a pointer to the most recent state, even before any
agent reads any file.
**Status:** Updated to Session 028 handoff this session.

### 8. Contrast Negation in Agent Identity (IMPLEMENTED IN BOOTLOADERS)
**Files:** `Claude.AI/Bot.Trey/Gems/Trey1.GemInstruction.md`, `Trey2.GemInstruction.md`
**What:** Agent ReadMe.First files use contrast negation — state what the agent is NOT
before what it IS.
**Why:** AI training weights generic positive descriptions into generic patterns.
Negation eliminates the generic set and forces specificity. Research from Trey1/Trey2
bootloader design, Session 026.

### 9. AI Verbiage Prohibition (LOCKED IN OPERATING STANDARDS)
**File:** `Claude.AI/Velorin.Company.Operating.Standards.md` (updated Session 026)
**What:** Banned phrases: cutting-edge, robust, leverage (verb), utilize, delve,
innovative, transformative, best practices (without specifics), it's worth noting.
**Why:** These phrases signal generic AI output and erode trust in agent outputs.
The Chairman identified this as a quality standard in Session 026.

### 10. Query Mode Declaration (IN TREY BOOTLOADERS)
**Files:** Trey1/Trey2 Gem instructions
**What:** TIGHT MODE (confirm known, fill gaps) vs DISCOVERY MODE (assume frame is
incomplete, find what isn't named). Caller declares, never agent self-selects.
**Why:** Agents default to Tight (appears efficient). Tight at wrong moment causes
systems to calcify. Discovery Mode was formalized after CT corrected both Jiang and
Trey for enumerating known products in a research prompt (Session 021).

### 11. Declarative Language Standard (IN OPERATING STANDARDS)
**File:** `Claude.AI/Velorin.Company.Operating.Standards.md`
**What:** Use must/do not/never/always. Never may/might/consider.
**Why:** Instructions are not suggestions. "May consider" means optional. Nothing
in Velorin agent instructions is optional.

---

## WHAT IS NOT YET IMPLEMENTED (DO THESE)

### A. autoCompactWindow Setting — NOT SET
**What:** `"autoCompactWindow": 900000` in settings.local.json would push the
auto-compaction trigger threshold to 90% of 1M context instead of the default 70%.
Gives more runway per session.
**Why not done:** Uncertain of exact interaction with existing thresholds. Test before
wiring. Set it in a test session and confirm behavior.
**Research source:** Session 022 — "autoCompactEnabled and autoCompactWindow are real
settings. autoCompactWindow: min 100K, max 1M."

### B. Pre-Compact Task Gate — NOT WIRED
**File:** `Claude.AI/hooks/pre-compact-task-gate.sh` (exists, was written, then deleted)
**What:** Blocks compaction when TASK_ACTIVE.lock exists. Exit code 2 = block.
If no active task (no lock file) → exit 0 → allow compaction normally.
**Why not done:** CT said too risky without testing. The script is sound. Test it in
a session where you're willing to risk a failed compaction block.
**How to test:** Create TASK_ACTIVE.lock manually, trigger compaction, verify it blocks.
Then delete lock file, trigger again, verify it allows.

### C. Scribe PATH Fix — NOT DONE
**File:** `Claude.AI/Bot.Scribe/scribe-trigger.sh` line 56
**What:** Replace bare `claude` call with full binary path from `which claude`.
**Why:** Hook execution environment doesn't have Claude Code CLI in PATH. All automated
neuron creation is blocked until this is fixed.
**This is a one-line fix. Do it first thing next session.**

### D. Compact Hook Path Update Protocol
**What:** The compact SessionStart hook is hardcoded to Session 028 handoff path.
At the start of each new session, update the path to the current handoff file.
**This is a manual step until we build a script that dynamically finds the latest handoff.**
**Dynamic version:** `ls -t /Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/Jiang.SessionHandoff.*.md | head -1`

### E. Cozempic Agent Teams Protection — NOT INSTALLED
**What:** `pip install cozempic` — 5-layer compaction protection for Agent Teams sessions.
**Why not done:** Not in Agent Teams mode currently. Lower priority.
**Research source:** Session 015 AgentTeamsBootDegradation research. 79% confidence fix.

### F. Boot Neuron — NOT BUILT
**What:** A stable c-memory neuron in the Brain (`Operations/Startup/boot-state.A1`)
that the SessionStart hook reads to inject current architecture state.
**Why it matters:** The hook currently cats a prose file. A Brain neuron with 7 pointers
to key architecture facts would be more efficient — machine-traversable, not linear prose.
**Status:** The Brain has ~45 neurons, none structured as a boot neuron yet.

---

## HOOK HIERARCHY (RESEARCH FINDING — SESSION 015/021)

```
Hooks     → DETERMINISTIC. Always run. Cannot be bypassed.
CLAUDE.md → Advisory. LLM reads and may follow. Erodes under gradient.
Skills    → On-demand. Probabilistic trigger. Lowest enforcement.
```

Any behavior that MUST happen goes in a hook. Not CLAUDE.md. Not a ReadMe.First.

---

## TOKEN BUDGET PER SESSION (APPROXIMATE)

| Item | Tokens | Status |
|---|---|---|
| System prompt | 6,100 | Fixed |
| System tools | 9,400 | Fixed |
| Memory files (MEMORY.md + CLAUDE.md) | 3,700 | Fixed |
| MCP schemas (deferred by ENABLE_TOOL_SEARCH) | ~2,000 | Was ~40K — fixed |
| Skills | 623 | Fixed |
| **Total overhead** | **~22K** | **Was ~58K** |
| Available for messages | ~978K of 1M | |

The ENABLE_TOOL_SEARCH change alone recovered ~38K tokens every session.

---

## THE COMPACTION RECOVERY STACK (WHAT FIRES AND IN WHAT ORDER)

```
Context hits threshold
  → PreCompact hook fires (pre-compact-team-save.sh saves TEAM_STATE.md)
  → Compaction executes
  → New session starts
  → SessionStart "startup" hook fires (git pull)
  → SessionStart "compact" hook fires (cats handoff into context)
  → MEMORY.md loads (contains pointer to handoff)
  → CLAUDE.md loads (GPS pointer)
  → Agent reads context, sees handoff injected, oriented immediately
```

Result: after compaction, the rebooted agent has:
1. Fresh git pull (current state)
2. Handoff injected deterministically into context (JSON block + full narrative)
3. MEMORY.md pointer confirming where the handoff is
4. CLAUDE.md GPS for navigation

This is what the research called for. The prose handoff alone was insufficient.

---

*Velorin.StartupAndRecovery.ToolFile | Session 028 | April 19, 2026*
*Update this file whenever a new hook, setting, or startup change is made.*

[VELORIN.EOF]
