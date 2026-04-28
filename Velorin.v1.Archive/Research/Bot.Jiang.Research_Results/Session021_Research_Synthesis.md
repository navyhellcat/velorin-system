---
session: 021
date: 2026-04-05
type: synthesis
status: BRAINSTORM ONLY — no concrete changes made
sources:
  - Hooks + CLAUDE.md + Skills deep dive (background agent)
  - Memory landscape research (background agent)
  - OperatingPaper_LangGraph.md
  - OperatingPaper_Mem0.md
  - OperatingPaper_Letta_MemGPT.md
---

# Session 021 Research Synthesis — Velorin Architecture Brainstorm

## CARDINAL CONSTRAINT
This document is a brainstorm. No changes have been made to Velorin. CT must review
and authorize before any implementation. The purpose is to get all session findings
into one place and propose how they might connect to the existing system.

---

## PART 1 — WHAT THE RESEARCH FOUND

### 1A. The Most Important Single Finding (Letta/MemGPT)

GPT-4o-mini + plain text files + standard filesystem tools (search, grep, open/close)
scored **74% accuracy** on a real memory benchmark — beating Mem0's graph memory (68.5%).

Implication: **retrieval infrastructure is not the bottleneck**. Agent behavior loop is.
Our neurons are already markdown files. Our agents already use Read/Grep/Glob.
We are 80% of the way to 74% accuracy without building anything new.

The full PPR architecture adds precision on top. But basic retrieval already works.

### 1B. The 97.8% Junk Finding (Mem0)

Mem0's own production audit (GitHub issue #4573): uncurated automatic extraction produces
97.8% noise. LLM-generated memories are overwhelmingly useless without strong filtering.

Implication: **human-curated neurons are not just a philosophical preference — they are
technically superior to automated extraction**. Our approach of manually writing neurons
is validated by the failure mode of the alternative.

### 1C. Architecture Validation

No existing managed service replicates what Velorin Brain is building:
- No system uses human-readable, git-versionable markdown as the primary knowledge substrate
- No system has pointer-rated traversal (our [1]-[10] activation priority)
- No system is designed for cross-agent shared memory with navigational taxonomy
- HippoRAG (NeurIPS 2024) and GAAMA (arxiv 2026) independently converged on PPR-over-graph
  as the correct retrieval mechanism — same design we arrived at

The architecture is right. The issue has been execution pace.

### 1D. Hooks — We've Been Doing Boot Wrong

Our current boot: CLAUDE.md tells Claude to read 5 files. That's advisory.
The correct mechanism: `SessionStart` hook with `startup` matcher. Shell script runs
automatically before any conversation, output injected deterministically. Cannot fail
through LLM non-compliance.

Same for compaction recovery: `SessionStart` with `compact` matcher replaces the
MEMORY.md-pointing approach. PreCompact saves state, compact-matcher reinjects it.

Hook enforcement hierarchy (critical mental model):
```
Hooks     = deterministic, always run, cannot be bypassed
CLAUDE.md = advisory, LLM reads and may follow
Skills    = on-demand, probabilistic trigger
```

Critical rules currently in CLAUDE.md (mcp__ naming, incremental write) should be
hooks, not instructions. Hooks cannot be forgotten or overridden.

### 1E. Skills Taxonomy Validates Brain Structure

Public skill directory (97 validated skills, 12 categories) maps directly to our
regions/areas/neurons taxonomy:
- Broad domain → Region
- Functional area → Area
- Specific workflow → Neuron

This is independent convergence. The taxonomy is correct.

### 1F. What to Borrow From Each System

**From LangGraph:**
- Checkpointing pattern: structured JSON state on session close, read on boot
  (not the library — the concept; formalizes our handoff files)
- BaseStore interface (5 methods: put/get/search/delete/batch) as the VelorinStore
  contract over Qdrant
- Namespace convention (region, area, neuron) tuple in Qdrant storage

**From Letta/MemGPT:**
- Context pressure warnings: 70% threshold trigger for archiving/handoff
- rebuild_system_prompt() pattern: neuron updates propagate to active context
- Agent-to-agent messaging infrastructure (beyond tmux panes, long-term)

**From Mem0:**
- Two-phase extraction pipeline design (~300-400 lines, build from scratch)
- ADD/UPDATE/DELETE/REJECT decision pattern (adding REJECT as 5th action)
- Namespace model: agent_id per agent, user_id for CT, run_id per session
- Do NOT use graph memory (Mem0g) — Brain is the graph layer, and it's better

**From Hooks research:**
- 27 hook events (we knew ~8)
- TeammateIdle hook for agent team coordination
- TaskCreated/TaskCompleted for team protocol enforcement
- InstructionsLoaded for debugging what files loaded and when
- 10,000 char cap on hook output injection — must be selective

---

## PART 2 — CT'S CORE INSIGHT (FROM THIS SESSION)

CT articulated something important about the current boot/routing approach:

> "I think guiding named bots to a particular place in the files where they read X
> is a good idea because it allows for constant change. Not everything is concrete,
> in a particular place that may be changed later, or one particular file that may
> be renamed."

This is the key architectural principle: **indirection over hard-coding**.

Instead of hooks or CLAUDE.md pointing to specific file paths (brittle — file renames
break everything), the system should point to **stable pointers** that themselves point
to current locations. The Brain neurons are those stable pointers.

Example of what NOT to do:
```bash
# SessionStart hook — BRITTLE
cat /Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/Jiang.SessionHandoff.Session021.md
```

Example of what TO do:
```bash
# SessionStart hook — STABLE
# Read the index neuron, which points to the current handoff
# The index neuron is stable; the handoff file path changes each session
```

The hooks are the automation layer. The neurons are the routing layer. The files are
the content layer. These three layers should be distinct so any one can change without
breaking the others.

---

## PART 3 — HOW THIS MIGHT CONNECT TO VELORIN (BRAINSTORM)

### Concept: The Boot Neuron

Instead of CLAUDE.md containing boot instructions that may become stale, there is a
"boot neuron" in the Brain — a stable, named neuron (`agents.boot.A1` or similar)
that contains:
- Pointer to current session handoff (updated each session close)
- Pointer to current MEMORY.md location
- Pointer to current agent roster
- Pointer to current active architecture neuron

The SessionStart hook reads this one neuron. The neuron handles all the routing.
When file paths change, update the neuron — not the hook. Hook never changes.

### Concept: The Close Protocol as a Hook Chain

Current close: manual. Jiang writes handoff, updates MEMORY.md, pushes.
Proposed: a `SessionEnd` hook that:
1. Triggers a close script
2. Extracts key session decisions into structured JSON
3. Updates the boot neuron's pointer to the new handoff
4. Pushes to GitHub
5. Injects confirmation back to Claude

CT could just say "close" and the entire protocol runs.

### Concept: Two-Tier Memory

Tier 1 (session-level, automated): Mem0-style extraction pipeline over conversations
→ Qdrant. Captures tactical facts from each session. Noisy but fast.

Tier 2 (architectural, curated): Brain neurons. Human-curated. High signal. Version-
controlled. The ground truth.

Agents query Tier 1 for recent session context, Tier 2 for architectural knowledge.
The two don't conflict because they serve different retrieval latencies and precision
requirements.

### Concept: Context Pressure Warning

Borrow from Letta: when token count hits 70% of context window, an automated signal
fires. Options: summarize and continue, or initiate orderly close protocol. Currently
we just run until compaction hits us unexpectedly.

A simple SessionStart loop or context-monitoring hook could track this.

### Concept: Skills as Neuron-Linked Automation

CT's insight about constant change applies here. Instead of skills hard-coding what
they do, skills could reference neurons:
- `/jiang-boot` skill reads the boot neuron, follows its pointers
- `/close-session` skill reads the close protocol neuron, executes each step
- The skill is stable; the neuron content evolves

This means as Velorin grows and protocols change, you update a neuron — not a skill
file, not a hook script, not CLAUDE.md. One place, one update, propagates everywhere
that references that neuron.

### Concept: Agent Identity via Neuron, Not File Path

Currently CLAUDE.md has hard-coded agent folder paths. If folders rename, CLAUDE.md
breaks. Alternative: CLAUDE.md points to a single stable agent roster neuron
(`agents.roster._index`). That neuron contains current paths. Folder renames require
one neuron update, not a CLAUDE.md edit.

---

## PART 4 — THE BUILD/PIVOT QUESTION

CT asked directly: is building this from scratch worth it, or pivot to managed APIs
and ship products?

**The honest answer from all research combined:**

Building from scratch IS worth it — but the order has been wrong.

The mistake: treating the infrastructure build as a prerequisite to everything else.
The Letta finding shows the infrastructure is NOT the prerequisite. You can ship agents
with meaningful memory TODAY using files + grep. The PPR/Qdrant stack makes it better,
not possible.

**Proposed approach:**

Stage 1 (now, this week): Agents with file-based memory. Plain neurons + grep.
No Qdrant. No PPR. Already at ~74% accuracy by Letta benchmark. Ship something.

Stage 2 (Mac Studio, after Monday): Add Qdrant + nomic-embed. Neurons embedded.
Vector search replaces grep. Accuracy improves. Still no PPR needed yet.

Stage 3 (Mac Studio + stability): Add PPR traversal. Full architecture live.
The [1]-[10] pointer ratings become meaningful navigation signals.

Stage 4 (ongoing): Add Mem0-style session extraction pipeline. Two-tier memory.
Sessions feed Tier 1 automatically. Curated neurons remain Tier 2.

This is not a pivot. It's a sequencing correction.

---

## PART 5 — GOOGLE AI ULTRA (NEW DEVELOPMENT)

CT purchased Google AI Ultra ($129/3 months promotional). Trey moves from ChatGPT
to Gemini.

Implications:
- Jules (Gemini coding agent, B+ GitHub reliability) is now available
- Deep Think (IMO gold model, 10 uses/day) for frontier math
- $100/month API credits = effective cost $29/month net at promotional pricing
- NotebookLM Plus (500 notebooks, 300 sources each)
- Gemini CLI + Jules Tools CLI for GitHub write access

Boot protocol for Trey-on-Gemini needs to be established (separate session).
Current Trey research request (skills) should be redirected to Gemini interface.

---

## PART 6 — WHAT REMAINS TO DO (THIS SESSION)

1. Commit the 3 operating papers to GitHub (in progress)
2. Decide: implement hook changes this session or document for Session 022?
3. Build the first neuron (still the session directive)
4. Gemini boot protocol design for Trey

CT direction required on: which of the brainstorm concepts above to prioritize.
No concrete changes have been made. This is the full picture. CT decides what's next.

[VELORIN.EOF]
