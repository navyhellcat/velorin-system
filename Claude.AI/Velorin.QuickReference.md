---
file: Velorin.QuickReference.md
purpose: On-demand routing table for post-substrate-lock Velorin agents
created: 2026-04-28
note: NOT a boot substitute. Jiang.ReadMe.First names the boot files. This is what agents consult AFTER boot when they need something outside the boot list.
---

# Velorin Quick Reference

---

## 1. Boot Read List (load order)

### Identity bracket
| Order | File |
|---|---|
| 1 | `Bot.Jiang/Jiang.ReadMe.First.md` |
| 2 | `Claude.AI/STARTUP.md` |
| 3 | `Claude.AI/Velorin.Principles.md` |
| 4 | `Claude.AI/Velorin.Consensus.Filter.md` |

### Chairman context
| Order | File |
|---|---|
| 5 | `Claude.AI/topline_profile.md` |
| 6 | `Claude.AI/Claude_Context_Profile_v1.2.md` |
| 7 | `Claude.AI/Velorin.Company.DNA.md` |
| 8 | `Claude.AI/Velorin.Vocabulary.md` |

### Canonical consolidations (substrate-locked)
| Order | File |
|---|---|
| 9 | `Claude.AI/New Build/00_Vision.md` |
| 10 | `Claude.AI/New Build/Velorin.MathStream.md` |
| 11 | `Claude.AI/New Build/00_Index.md` |
| 12 | `Claude.AI/New Build/01_RepoAndEnvironment.md` |
| 13 | `Claude.AI/New Build/02_Architecture.md` |
| 14 | `Claude.AI/New Build/03_BrainAndMath.md` |
| 15 | `Claude.AI/New Build/04_AgentEcosystem.md` |
| 16 | `Claude.AI/New Build/05_InfrastructureAndTools.md` |
| 17 | `Claude.AI/New Build/06_BuildSequence.md` |
| 18 | `Claude.AI/New Build/07_OpenQuestions.md` |
| 19 | `Claude.AI/New Build/Velorin.CheckIns.md` |
| 20 | `Claude.AI/New Build/Velorin.StartupManifest.md` |
| 21 | `Claude.AI/New Build/Velorin.MacStudio.Setup.md` |

### Library (preamble + Master Index ONLY at boot)
| Order | File | Boot scope |
|---|---|---|
| 22 | `Claude.AI/New Build/Velorin.ResearchLibrary.v2.md` | First ~150 lines (preamble + Master Index). Individual cards on demand by `topic_id`. **GPS EXCEPTION (transitional):** this boot read is duplicated pointer logic that should be an MCP tool query. Removes itself when PRE-STAGE 1 item B.2 (`library_lookup(topic_id)`) ships — agents will then query by topic_id and skip the file read. |

### State
| Order | File |
|---|---|
| 23 | `Bot.Jiang/Jiang.SessionHandoff.md` |
| 24 | `Bot.Jiang/Working.Docs/*` (active items only) |
| 25 | `~/.claude/projects/-Users-lbhunt/memory/MEMORY.md` (auto via CLAUDE.md) |

---

## 2. On-Demand by Topic (NEVER bulk-read)

Lookup pattern: Library card by `topic_id` → if card insufficient → follow `source:` pointer to specific doc.

| Corpus | Location | Entry count |
|---|---|---|
| Erdős math | `Bot.Erdos/Research_Complete/*.md` | 31 |
| Trey research | `Bot.Trey/Research_Complete/*.md` | ~35 |
| External papers | `Claude.AI/External/*.md` | 1 (Tafazoli 2025) |
| Tools docs | `Claude.AI/tools/*.md` | GDrive Port, URL Port, Math OCR, KaTeX rules |
| Skills/Hooks pending | `Claude.AI/Skills and Hooks Pending Development/*.md` | Read when implementing |

---

## 3. Active Work Pointers

| What | Location | Status |
|---|---|---|
| Jiang Working Docs | `Bot.Jiang/Working.Docs/` | Active items only post-cleanup. Boot-read in full. |
| Jiang Research_Needed | `Bot.Jiang/Research_Needed/` | `.gitkeep` only post substrate-lock |
| Erdős Research_Needed | `Bot.Erdos/Research_Needed/` | `.gitkeep` only post substrate-lock |
| Trey Research_Needed | `Bot.Trey/Research_Needed/` | `.gitkeep` only post substrate-lock |
| PRE-STAGE 1 ledger | `06_BuildSequence.md` PRE-STAGE 1 section | Gates Stage 0. Row states: BUILT / DECIDED / FORMALLY DEFERRED / OPEN. |
| FW registry | `Bot.Jiang/Working.Docs/Jiang.FutureWork.md` | FW-001 through FW-017. Review at session start. |
| Brain entry | `Claude.AI/Velorin_Brain/_index.md` | On-demand access only (Principle 2). NOT loaded at boot. |

---

## 4. NEVER Read on Boot

| What | Location | Why |
|---|---|---|
| v1 Archive | `Velorin.v1.Archive/*` | Retired v1 architecture. Reading contaminates v2 reasoning. |
| Archived Research Requests | `Velorin.v1.Archive/Archived_Research_Requests/*` | Historical context only. Not boot. |
| Archived Working Docs | `Velorin.v1.Archive/Working.Docs.Archive/*` | Executed/historical. |
| Archived Research Sources | `Velorin.v1.Archive/Research/*` | Library v2 cards are the canonical entry. |

Retired systems (do not reference as active): MarcusAurelius, Bot.Scribe, Bot.Theresa, Gatekeeper, Level 1-5 hierarchy, Agent Teams/tmux, AppsScript Bus, GLOBAL_SPAWNER_REGISTRY, GLOBAL_TIMER_REGISTRY.

---

## 5. Discipline Notes

- **Substrate is locked.** Architectural deep work is not the default mode post-lock. Default mode = operational: FW registry items, Stage 0 / PRE-STAGE 1 close, day-to-day support.
- **Library retrieval by `topic_id`.** Agents consult cards, not raw research files, unless the card is insufficient.
- **Boot is fast.** Identity + chairman + consolidations + state. Brain access is on demand only (Principle 2).
- **Architectural changes require CT lock.** MathStream / Build Guide / Library updates go through plan mode, not unilateral edits.
- **GPS over Map (Principle 1).** Navigation uses stable pointers, not hard-coded destinations. If renaming a file requires editing more than one pointer, the system is using a map.
- **Programs do work, AI watches (Principle 5).** Before any architectural recommendation: "is this a program to build with AI as watcher?"
- **Consensus Filter on every Trey deliverable.** Q1 what is the consensus / Q2 why / Q3 does Velorin share that constraint. Q3=no → novelty lives on the other side.

[VELORIN.EOF]
