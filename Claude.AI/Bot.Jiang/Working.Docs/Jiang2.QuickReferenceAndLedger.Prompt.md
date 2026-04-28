---
file: Jiang2.QuickReferenceAndLedger.Prompt.md
from: Christian Taylor (Chairman) via Jiang1
date: 2026-04-28
target: Jiang2 (continuing same session post substrate-lock execution)
priority: HIGH — closes the next-Jiang boot infrastructure + the deferred ledger gate
output-protocol: real edits, real commits, ONE pass
---

# Jiang2 — QuickReference + Deferred Ledger Verification

═══════════════════════════════════════════════════════════════════════════════════════

Jiang2.

Substrate-lock pass committed. Two follow-on tasks for this session, in order, while you still have ~100K tokens. If context runs short, complete Task A and stop; Task B can move to a separate session.

Pull `main` first.

═══════════════════════════════════════════════════════════════════════════════════════

## TASK A — Create `Claude.AI/Velorin.QuickReference.md`

Purpose: an **on-demand routing table** for the next Jiang (and any other agent that boots into Velorin post-substrate-lock). It does NOT substitute for boot reads — Jiang's ReadMe.First will still name the boot files explicitly. QuickReference is what Jiang consults when he needs something *outside* the boot read list.

Target ~120 lines, single page, scannable. Tone: terse reference, not prose.

### Content

**Section 1 — Boot read list (explicit named files, in load order).** Mirror exactly what `Bot.Jiang/Jiang.ReadMe.First.md` Step 4 will name (Jiang1 is updating ReadMe.First in parallel; coordinate via this list):

  - Identity bracket: `Bot.Jiang/Jiang.ReadMe.First.md`, `Claude.AI/STARTUP.md`, `Claude.AI/Velorin.Principles.md`, `Claude.AI/Velorin.Consensus.Filter.md`
  - Chairman context: `Claude.AI/topline_profile.md`, `Claude.AI/Claude_Context_Profile_v1.2.md`, `Claude.AI/Velorin.Company.DNA.md`, `Claude.AI/Velorin.Vocabulary.md`
  - Canonical consolidations (substrate-locked synthesis): `Claude.AI/New Build/00_Vision.md`, `Velorin.MathStream.md`, `00_Index.md`, `01_RepoAndEnvironment.md`, `02_Architecture.md`, `03_BrainAndMath.md`, `04_AgentEcosystem.md`, `05_InfrastructureAndTools.md`, `06_BuildSequence.md`, `07_OpenQuestions.md`, `Velorin.CheckIns.md`, `Velorin.StartupManifest.md`, `Velorin.MacStudio.Setup.md`
  - Library: `Claude.AI/New Build/Velorin.ResearchLibrary.v2.md` — **preamble + Master Index ONLY at boot** (~first 150 lines); individual cards on demand by `topic_id`
  - State: `Bot.Jiang/Jiang.SessionHandoff.md`, `Bot.Jiang/Working.Docs/*` (cleaned to active items only), `~/.claude/projects/-Users-lbhunt/memory/MEMORY.md` (auto via CLAUDE.md)

**Section 2 — On-demand by topic (NEVER bulk-read; consult Library card first).**

  - Erdős corpus: `Bot.Erdos/Research_Complete/*` (31 entries). Lookup pattern: Library card by `topic_id` → if card insufficient, follow `source` pointer to specific Erdős doc.
  - Trey corpus: `Bot.Trey/Research_Complete/*`. Same pattern.
  - External papers: `Claude.AI/External/*` (Tafazoli 2025 Nature paper currently). Reference via Library card.
  - Tools: `Claude.AI/tools/*` (GDrive Port, URL Port, Math OCR, KaTeX rules, etc). Read on demand when porting.
  - Skills/Hooks pending: `Claude.AI/Skills and Hooks Pending Development/*`. Read when implementing.

**Section 3 — Active work pointers.**

  - `Bot.Jiang/Working.Docs/` — only active items live here post-cleanup. Boot-read in full.
  - `Bot.Jiang/Research_Needed/` — `.gitkeep` only post substrate-lock.
  - `Bot.Erdos/Research_Needed/` — `.gitkeep` only post substrate-lock.
  - `Bot.Trey/Research_Needed/` — `.gitkeep` only post substrate-lock.
  - PRE-STAGE 1 ledger in `06_BuildSequence.md` — gates Stage 0; row-by-row verification status (mark BUILT/DECIDED/FORMALLY DEFERRED/OPEN per Task B below if Task B fires this session).

**Section 4 — NEVER read on boot.**

  - `Velorin.v1.Archive/*` — retired v1 architecture (MarcusAurelius, Bot.Scribe, Bot.Theresa, Gatekeeper, Level 1-5 hierarchy, Agent Teams, AppsScript Bus, GLOBAL_SPAWNER, GLOBAL_TIMER). Reading contaminates v2 reasoning.
  - `Velorin.v1.Archive/Archived_Research_Requests/*` — accessible for historical context only when needed; not boot.
  - `Velorin.v1.Archive/Working.Docs.Archive/*` — same, executed/historical.
  - `Velorin.v1.Archive/Research/*` — same, archived research sources (cards in Library v2 are the canonical entry).

**Section 5 — Discipline notes.**

  - **Substrate is locked.** Architectural deep work is not the default mode post-lock. Default mode is operational: Future Work registry items, Stage 0 / PRE-STAGE 1 close, day-to-day support.
  - **Library retrieval by `topic_id`** — agents consult cards, not raw research files, unless the card is insufficient.
  - **Boot is fast** — identity + chairman + consolidations + state. Brain region access is on demand only (Velorin Principle 2).
  - **Architectural changes require CT lock** — MathStream / Build Guide / Library updates go through plan mode, not unilateral edits.

End the doc with `[VELORIN.EOF]`. No prose intro, no closing flourish — terse reference table format throughout.

### Output

Write to `Claude.AI/Velorin.QuickReference.md`. Single commit, push.

═══════════════════════════════════════════════════════════════════════════════════════

## TASK B — PRE-STAGE 1 Ledger Row-by-Row Verification (IF context allows)

Deferred from your substrate-lock pass per CT direction. Re-attempt now if Task A leaves you ≥ 50K tokens.

`Claude.AI/New Build/06_BuildSequence.md` — the **PRE-STAGE 1 — Library Audit Resolution** section has two tables (Table A: §10 outstanding, Table B: §11 build-out). Each row carries one of: BUILT / DECIDED / FORMALLY DEFERRED / OPEN.

Walk every row. For each, verify the marked state is honest given current repo state. Specifically:

- A.1 IdentityVerification — was a request file ever filed? `ls Bot.Jiang/Research_Needed/` should show `.gitkeep` only post-lock. If no IdentityVerification request exists and the architectural need still stands, the row is OPEN, not BUILT — flag it.
- A.2-A.5, A.8 — already marked BUILT by today's work. Verify the deliveries actually landed in `Bot.Erdos/Research_Complete/` or `Bot.Trey/Research_Complete/`.
- A.3 — Erdős corpus + math supplement merge. The Erdős corpus is read; the supplement merge into `turboquant-and-mempalace` card may or may not be done. If still incomplete, downgrade to OPEN with explicit note.
- A.6, A.7 — DEFERRED. Verify the FW registry has corresponding entries OR add them.
- A.9 — pre-existing local mods in commit `06a5730`. Run `git show 06a5730 --stat` and either confirm intentional or flag for CT review.
- B.1 (boot/close/handoff skill+hook), B.2 (GPS lookup MCP tool), B.3 (library consumer instruction snippet), B.4 (`fidelity:` field), B.5 (`decay-rate:` field) — each was OPEN. Have any been built by your substrate-lock pass? B.3 may have been folded into the Library / agent ReadMes — check. B.4 + B.5 are schema additions to library cards — check.
- B.6, B.8 — ON DEMAND / RECURRING — no row-state action.
- B.7, B.9 — FORMALLY DEFERRED — verify Standing Principle artifact triple is in place (FW entry + Check-Ins entry + build-space placeholder).

For each row whose state changes, edit `06_BuildSequence.md` inline with the corrected state + a one-line justification. End the verification with a status summary block at the bottom of the PRE-STAGE 1 section: count of BUILT / DECIDED / FORMALLY DEFERRED / OPEN; gate condition (Stage 1 begins when zero OPEN).

If Task B does not complete this session due to context, leave the existing ledger as-is and note in your final commit message that B is deferred to a separate session.

═══════════════════════════════════════════════════════════════════════════════════════

## What you do NOT do

- No edits to MathStream, 00_Vision, or any Build Guide file outside `06_BuildSequence.md` PRE-STAGE 1 ledger section.
- No new research requests, no new external prompts.
- No changes to `Jiang.ReadMe.First.md` or `Jiang.SessionHandoff.md` — Jiang1 is updating those in parallel; you write QuickReference, he wires the boot sequence to it.
- No plan mode. Real edits, real commits.

## Commit discipline

- Task A → one commit ("Add Velorin.QuickReference.md — on-demand routing table for post-lock boot")
- Task B (if executed) → second commit ("PRE-STAGE 1 ledger row-by-row verification — N rows updated")
- Push after each commit so Jiang1's parallel work can pull cleanly.

[VELORIN.EOF]
