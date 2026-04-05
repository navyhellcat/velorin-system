---
document: Vocabulary Bot — Design Specification
session: 021
date: 2026-04-05
status: DESIGN — not yet built
author: Jiang Session 021
purpose: Define how the vocabulary bot detects, writes, and maintains Velorin.Vocabulary.md
---

# Vocabulary Bot Design

## What It Does

The Vocabulary Bot monitors Velorin sessions for new terminology gaps and writes
clean, flashcard-ready definitions to `Claude.AI/Velorin.Vocabulary.md` in real time.

It does NOT wait for end of session. When a term is identified as a gap — either by
CT flagging it or by Jiang detecting that a concept was used without a formal definition
in the vocabulary file — the bot adds the entry immediately.

---

## Trigger Conditions

A vocabulary entry is created when ANY of these conditions are true:

**Explicit trigger (CT-initiated):**
CT says: "add that to vocabulary", "vocabulary entry", "define that for the file",
or uses any variant that clearly signals: this term needs to be in the vocabulary.

**Implicit trigger (Jiang-detected):**
- Jiang uses a technical term 3+ times in a session that does not exist in the vocabulary file
- Jiang introduces a concept by explaining it in 2+ sentences (the explanation IS the entry)
- A research finding introduces a term that Velorin's architecture depends on
- CT asks "what is X" in a way that suggests X should be a standing reference, not a one-time answer

**Research trigger (post-research):**
After a research session (Trey or Jiang agents), any term that appears in the Key Findings
summary that does not exist in the vocabulary file is a candidate for addition.

---

## Entry Format

Every entry follows this format exactly:

```
**[CODE] — [TERM NAME]** (also: [alternate names if any])
[Definition paragraph — 3-6 sentences. Written for CT to own the concept.
Explain what it is, why it matters, what makes it distinct from adjacent concepts,
and how it connects to Velorin's architecture. No jargon without explanation.
Written at CT's cognitive level — do not simplify, do not condescend.]
```

**Code format:** Letter prefix + number. Current series: A1-A6.
Letters are categories assigned later by bot. Numbers are sequential within series.
Do NOT renumber manually. A bot restructures categories when enough entries exist.

**Flashcard-ready:** Every entry must be self-contained. CT should be able to read
any single entry and fully own the concept without reading adjacent entries.

---

## What Makes a Good Entry

**Good:** Self-contained, explains the concept AND why it matters AND how it connects
to Velorin. Written to be read once and retained.

**Bad:**
- Too short: "PPR is a graph retrieval algorithm." (no context, no connection)
- Too long: a full essay (vocabulary is flashcard format, not documentation)
- Jargon without explanation: assumes CT knows the prerequisite terms
- No Velorin connection: explains the concept in the abstract without grounding it

**Target length:** 4-7 sentences. Enough to own the concept. Not enough to become
a document.

---

## The Running File

File location: `Claude.AI/Velorin.Vocabulary.md`

The file has one active section: Uncategorized (pending category assignment).
Entries are added at the bottom of the uncategorized section.
The `[END — next entry: AN]` line is updated after every addition.

The file grows continuously. When CT wants to categorize entries, a bot pass
restructures into lettered categories (B1-Bn = Memory Architecture, C1-Cn = Protocols, etc.)
but the original A-series numbers are preserved inside their categories.

---

## How the Bot Runs (Implementation Path)

**Current state (Session 021):** Manual. Jiang adds entries when triggers fire.

**Target state (when hooks are built):**
A SessionStart hook reads `Velorin.Vocabulary.md` into context at boot.
A PreCompact hook checks whether any terms used in the session need entries and
writes them before context is lost.

**The PreCompact hook is the critical one.** The risk is: a session generates new
concepts, compaction happens, the concepts are in the compressed summary but
the vocabulary was never updated. PreCompact hook fires → Jiang checks session
for vocabulary candidates → writes entries → then compaction proceeds.

**Implementation note:** This is Tier 1 infrastructure (deterministic program).
The hook fires. The agent checks. The agent writes if needed. No judgment required
about whether to run — the hook always runs. The agent's judgment is used only
for WHAT to write, not WHETHER to run.

---

## Pending Entries (Session 021 — Not Yet Written)

Terms used this session that may need vocabulary entries:

- **MCP (Model Context Protocol)** — used extensively, not in vocabulary
- **A2A (Agent-to-Agent Protocol)** — introduced this session
- **PPR (Personalized PageRank)** — referenced from earlier sessions
- **Graph RAG** — used in research, not formally defined in vocabulary
- **Browser Automation Bridge** — new architecture concept this session
- **ApiTap** — new finding this session
- **Jules** — Google's async coding agent, new this session
- **Tiered MCP Registry** — new design concept this session

CT decides which of these to formalize. Jiang writes on instruction.

---

[VELORIN.EOF]
