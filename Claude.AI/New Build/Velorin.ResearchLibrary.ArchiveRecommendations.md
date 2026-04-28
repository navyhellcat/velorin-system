# Velorin Research Library — Archive & Disposition Recommendations
**Last updated: 2026-04-28 (Session 039 archive-pass executed)**
**Cataloger: Jiang1, Director of Strategic Intelligence**
**Companion to: `Velorin.ResearchLibrary.v2.md`**

> **STATUS UPDATE 2026-04-28 (Session 039):** Sections 2, 4, and 6 have been RESOLVED by the Session-039 archive-pass mission. All in-scope research source files (Jiang + Trey, excluding Erdős and Research_Needed/) have been `git mv`'d into `Velorin.v1.Archive/Research/<subfolder>/` per the mission spec. v2 + this doc's source pointers were batch-rewritten to match. The destinations CT was going to approve via the prior recommendations are now superseded by the cleaner Session-039 unified-silo destinations. See Section 7 (added at end) for the actual mapping.

Format per row:
- **topic_id** — the v2 logical key
- **source path** — current file location
- **recommendation** — exact disposition action
- **justification** — one sentence on why

---

## 2. SUPERSEDED

| topic_id | source path | recommendation | justification |
|---|---|---|---|
| trey-synaptic-pruning-v2 | `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/Trey.Research.SynapticPruning.v2.md` | Move to `Velorin.v1.Archive/Bot.Trey/Research_Complete/`; add header pointer to `Erdos.Solution.SynapticPruning.md` (Appendix B `erdos-synaptic-pruning`) | Initiated the Erdős math pipeline; subsequent Erdős proofs supersede the underlying research; keep for historical chain. |
| (none other found in this scope) | | | |

> Note: the v1 Research Library (`Velorin.ResearchLibrary.v1.md`) was marked SUPERSEDED in-place 2026-04-27 by appending a header pointer to v2. v1 stays in the same folder as historical reference. No move action required.

---

## 3. COMBINE — proposed merged cards

These are already **virtually combined** in the v2 library via `status: COMBINE` cards that bundle multiple sources. The recommendation is to leave the source files in place but treat the combined card as the canonical entry point. No file moves required.

| combined topic_id | sources | recommendation | justification |
|---|---|---|---|
| claude-code-tools-roundup-mar29 | `Tools_For_Velorin_Research/05_awesome_claude_code.md`, `06_uiux_pro_max.md`, `07_obsidian_skills.md` | Keep files in place; route consumers to the combined card | Each is a sub-1-page tool pointer; bundling reduces fragmentation without losing detail. |
| trey-operating-papers-q1-2026 | `Bot.Trey/Research_Complete/OperatingPaper_LangGraph.md`, `OperatingPaper_Letta_MemGPT.md`, `OperatingPaper_Mem0.md` | Keep files in place; route consumers to the combined card | Three papers were authored as one Session-021 background pass; consolidated entry point preserves reading order. |
| trey-vendor-comparison-roundup-q1-2026 | `Bot.Trey/Research_Complete/{ChatGPT_vs_Gemini_Full_Ecosystem_Comparison, Codex_vs_Jules_GitHub_Write_Access, Claude_GPT_API_MCP_RESEARCH, Cursor_Claude_GPT_Team}.md` | Keep files in place; route consumers to the combined card | Four short Q1-2026 vendor comparisons; many specifics are stale relative to Q2-2026; combined card flags the staleness once. |
| trey-mirofish-stack-deep-research-roundup | 14 files in `Bot.Trey/Assessments/mirofish_stack_deep_research/` | Keep folder structure; combined card is the index | Folder is already well-organized; no file moves needed. |
| trey-velorin-tooling-research-roundup | 10 files in `Bot.Trey/Assessments/velorin_tooling_research/` | Keep folder structure; combined card is the index | Same rationale as mirofish folder. |
| trey-research-complete-roundup | 30+ files in `Bot.Trey/Research_Complete/` (per roster table in v2 §3.12) | Keep files in place; the roster IS the combined card | Folder is already operational; promoting individual files to full cards on demand. |

---

## 4. ARCHIVE — recommend move to `Velorin.v1.Archive/`

> **RESOLVED by Session 039 archive-pass (2026-04-28).** All files below have moved into `Velorin.v1.Archive/Research/<subfolder>/`, NOT to the destinations originally proposed in this section. The Session-039 unified-silo structure supersedes the per-bot-mirror structure originally proposed. Pointers in v2 and this doc have been updated to the actual current paths. Below table preserved for historical reference; ignore the "proposed destination" column.

| topic_id | current path | proposed destination | justification |
|---|---|---|---|
| tools-research-session-summary-mar29 | `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/Tools_For_Velorin_Research/00_Session_Summary_Mar29_2026.md` | `Velorin.v1.Archive/Build Timeline Help/Sessions.HistoricalArchive/00_Session_Summary_Mar29_2026.md` | Session-summary doc; load-bearing content is now individually carded under per-zone topic_ids + `ecosystem-intelligence-report` + `velorin-adoption-memo`. |
| system-assessment-session017-part1 | `Velorin.v1.Archive/Research/Bot.Jiang.Working.Docs.Assessments/Jiang.SystemAssessment.Session017.Part1.ReadFirst.md` | `Velorin.v1.Archive/Bot.Jiang/Working.Docs/SystemAssessments/Jiang.SystemAssessment.Session017.Part1.ReadFirst.md` | Session-017 first-pass system assessment; conclusions absorbed into `brain-full-analysis-mar30`, `agent-orchestration`, `agent-ecosystem-reality`. |
| system-assessment-session017-main | `Velorin.v1.Archive/Research/Bot.Jiang.Working.Docs.Assessments/Jiang.SystemAssessment.Session017.md` | `Velorin.v1.Archive/Bot.Jiang/Working.Docs/SystemAssessments/Jiang.SystemAssessment.Session017.md` | Same rationale; key new findings (Scribe broken at the time, list_available_tools nonexistent) are time-bound operational state. |
| system-assessment-tool-research-supplement | `Velorin.v1.Archive/Research/Bot.Jiang.Working.Docs.Assessments/Jiang.SystemAssessment.ToolResearch.Supplement.md` | `Velorin.v1.Archive/Bot.Jiang/Working.Docs/SystemAssessments/Jiang.SystemAssessment.ToolResearch.Supplement.md` | Synthesis is captured in `agent-orchestration` related field + `openclaw-deep-dive`/`openclaw-nemoclaw-architecture`; the unified architecture proposal should be lifted into the Build Guide directly. |
| architecture-clarity-session016 | `Velorin.v1.Archive/Research/Bot.Jiang.Working.Docs.Assessments/Jiang.WorkingDoc.ArchitectureClarity.Session016.md` | `Velorin.v1.Archive/Bot.Jiang/Working.Docs/Jiang.WorkingDoc.ArchitectureClarity.Session016.md` | Session-016 layered-stack working doc; superseded by SystemAssessment.ToolResearch.Supplement and `obsidian-as-knowledge-infra`. |
| jiang2-handoff-items-from-v1-archive | `Velorin.v1.Archive/Research/Bot.Jiang.Working.Docs.Assessments/Jiang2.HandoffItems.From.v1.ArchivePass.md` | `Velorin.v1.Archive/Bot.Jiang/Working.Docs/Jiang2.HandoffItems.From.v1.ArchivePass.md` | Operational handoff to Jiang2, not research; items 1-2 are tracked in Jiang2's working docs. |

---

## 5. ARCHIVE — flagged but NOT moved

Items here are ARCHIVE candidates whose move CT may want to defer:

- **`Velorin.ResearchLibrary.v1.md`** — left in place at `Claude.AI/New Build/`. v1 header now points to v2. CT may opt to leave indefinitely; deletion not recommended (historical reference).
- **`Velorin.ResearchCorpus.md`** — left in place at `Claude.AI/New Build/`. Predecessor of v2 with corpus-wide metadata. CT may keep as the "raw inventory" doc, complementary to v2's logical-key library.

---

## 6. NEEDS CT REVIEW

Items the cataloger could not classify cleanly:

- **`turboquant-mempalace-math-supplement`** now at `Velorin.v1.Archive/Research/Bot.Jiang.Working.Docs.Assessments/Jiang.TurboQuant.MemPalace.MathSupplement.md` (moved by Session 039). INCOMPLETE; flagged in source as "awaiting Bot.Erdos research read." When the Bot.Erdos read completes (likely a Jiang2 or future-Jiang task — `Erdos.Velorinv2.AuditAndNovelIdeas.md` is now the closest available resource), merge into `turboquant-and-mempalace` card. The file is already at the canonical archive destination, so no further move action.
- **Open-research adjacency** — three Trey ResearchRequest files (`open-trey-gpt55-codex-integration-surface`, `open-trey-notebooklm-api-surface`, `open-trey-personamaker-landscape`) appear to have already been DELIVERED (corresponding `trey-gpt55-codex-integration` / `trey-notebooklm-api-surface` / `trey-persona-maker-landscape` exist in archived Research_Complete). CT to confirm and either ARCHIVE the request files or update Research_Needed.

---

## 7. SESSION 039 ARCHIVE PASS — ACTUAL MOVES (2026-04-28)

The mission spec for Session 039 dictated a unified `Velorin.v1.Archive/Research/<subfolder>/` structure. Below is the actual mapping; this supersedes the per-bot-mirror destinations originally proposed in Sections 4 and 6 of this document.

| original folder | archive destination | files moved |
|---|---|---|
| `Claude.AI/Bot.Jiang/Research_Complete/` | `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/` | 11 |
| `Claude.AI/Bot.Jiang/Jiang.Topic.{AgentEcosystemReality,AgentOrchestration,WindowGravity}.md` | `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/` | 3 |
| `Claude.AI/Bot.Jiang/Research_Results/` (root + Tools_For_Velorin_Research/) | `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/` (preserves Tools subfolder) | 16 |
| `Claude.AI/Bot.Jiang/Research.BrainAnalysis.Mar30/` | `Velorin.v1.Archive/Research/Bot.Jiang.Research.BrainAnalysis.Mar30/` | 2 |
| `Claude.AI/Bot.Jiang/Working.Docs/` (in-scope assessments only — 7 files) | `Velorin.v1.Archive/Research/Bot.Jiang.Working.Docs.Assessments/` | 7 |
| `Claude.AI/Bot.Trey/Research_Complete/` | `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/` | 52 |
| `Claude.AI/Bot.Trey/Trey.Topic.OpenAIEcosystem.md` | `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/` | 1 |
| `Claude.AI/Bot.Trey/Assessments/` (root + mirofish_stack_deep_research/ + velorin_tooling_research/) | `Velorin.v1.Archive/Research/Bot.Trey.Assessments/` (preserves both subfolders) | 28 |
| **Total moved** | | **120** |

**Excluded from move (per mission spec):**
- `Claude.AI/Bot.Erdos/Research_Complete/*` (26 files) — Erdős math handled separately by Jiang2; new file `Erdos.Velorinv2.AuditAndNovelIdeas.md` added to v2 Appendix B as INDEX-ONLY pointer.
- All `Research_Needed/` files across Erdős/Jiang/Trey (10 files total) — open requests stay active.
- All Working.Docs files NOT in the in-scope assessment set (operational prompts, plans, FW registry, decision records, confirmations).
- Everything under `Claude.AI/New Build/`, `Claude.AI/Velorin_Brain/`, `Claude.AI/Bot.Erdos/Bootloader/`, etc. — out of scope per original mission.

**Pointer rewrites:**
- `Velorin.ResearchLibrary.v2.md` — all `source:`, `Source:`, roster-table-cell, and pointer-section paths rewritten via Python script.
- `Velorin.ResearchLibrary.ArchiveRecommendations.md` — same rewrite applied; Sections 4 and 6 marked RESOLVED inline.

**Verification:** post-rewrite scan found 0 stale active-path pointers in either document.

---

[VELORIN.EOF]
