---
file: Velorin.v2.BuildPlanFinalization.PendingItems.md
purpose: Items deferred from the v1 archive execution pass that must be addressed before the final v2 Build Plan is locked. These BLOCK final Build Plan lock.
type: pending-items registry
date: 2026-04-26
from: Jiang
status: ACTIVE — these block v2 Build Plan finalization
---

# Velorin v2 Build Plan — Pending Finalization Items

These items were surfaced during the v1 archive execution pass but require careful review against the v2 Build Plan before disposition. They block the final Build Plan lock.

When the v2 Build Plan finalization pass runs (Jiang2 + Deep Think audit, per FW-013), each item below must be walked and resolved.

---

## Pending Item 1 — GPS.Layer.System.Design.md

**Current location:** `Claude.AI/architecture/GPS.Layer.System.Design.md`

**What it is:** Design doc for a "Global Positioning System" layer — likely a coordination/state-tracking layer that knows where each agent is in workflow and what state each task is in.

**What needs to happen:** Read the doc in full, compare against the current Build Guide files (`Claude.AI/New Build/`). Determine whether the GPS concept's substantive ideas are absorbed in the Build Guide (state tracking via `belief_state`, `authority_tier`, `contradiction_class`, FW registry, session handoffs). If absorbed: archive after extraction. If novel ideas remain (a coordination/orchestration layer not addressed elsewhere), flag for Jiang2 + Deep Think before final Build Plan lock. Don't let architectural novelty get archived by default — that's how systems lose ideas they later have to re-derive at higher cost.

**Why deferred:** The v1 archive execution pass did not have authority to modify Build Guide files (FROZEN per Jiang2's WholeSystemReimagining mandate Hard Constraint 1). Comparison + decision must happen during the v2 finalization pass when Build Guide edits are authorized.

---

## Pending Item 2 — Skill.Registry.Design.md

**Current location:** `Claude.AI/architecture/Skill.Registry.Design.md`

**What it is:** Earlier design for skill catalog, indexing, invocation. Predates the current `skill_dependencies.yaml` 4-type GoS edge schema in the Build Guide.

**What needs to happen:** Read in full, compare against the current Build Guide skills section (in `New Build/05_InfrastructureAndTools.md` and related). Extract anything not in current Build Guide (likely small — most patterns absorbed). Archive original after extraction. The current skills architecture is more mathematically grounded; the older design's main contribution was probably the concept of "skills are first-class" — likely already absorbed.

**Why deferred:** Same as Item 1 — Build Guide is FROZEN; extraction-and-port requires authorized Build Guide edit cycle.

---

## Pending Item 3 — desktop-verification.md

**Current location:** `Claude.AI/tools/desktop-verification.md`

**What it is:** Diagnostic checklist for verifying Claude Desktop / Code Tab environment is working (MCP health, filesystem access, specific tool availability).

**What needs to happen:** Parse the file. Extract foundational environment-confirmation steps into `Claude.AI/STARTUP.md` (which already has an Environment section that can absorb), or into `Claude.AI/ENVIRONMENT_DETECTION.md` if more appropriate. Extract diagnostic-specific steps into either `Claude.AI/STARTUP.md` Troubleshooting section OR a new `Claude.AI/Troubleshooting.md` if substantial enough. Archive original after extraction.

**Why deferred:** STARTUP.md has been edited multiple times in this session; further structural changes risk introducing inconsistency without a focused review pass. Also, the diagnostic content may need updating against the current MCP topology before extraction.

---

## Pending Item 4 — GDrive.Port.Tool.md

**Current location:** `Claude.AI/tools/GDrive.Port.Tool.md`

**What it is:** Documentation of the GDrive porting process — the inbound channel for all external research deliverables from Trey/Erdős. Critical operational reference paired with the velorin-gdrive MCP.

**What needs to happen:** Read in full, confirm currency against the actual MCP API (the trash-permission failure during this session suggests something needs attention). Consider promoting from documentation to executable: a Python port script in `Possibly Useful Scripts/` that wraps the gdrive MCP calls into a single `gdrive-port [filename]` operation, with the .md as reference. Currently every port is a manual sequence of MCP calls; could be one script call with safe defaults.

**Why deferred:** Substantial review work + script-build decision belongs in the v2 finalization pass, not the v1 archive cleanup. Pairs with the MCP trash-permission issue surfaced today.

---

## Pending Item 5 — Research Library Index (BUILD)

**What it is:** Doesn't exist yet. To be built. Single consolidated index for all research docs across `Bot.Erdos/Research_Complete/`, `Bot.Trey/Research_Complete/`, `Bot.Trey/Assessments/`, plus topic and synthesis docs. Per dispositions: navigation table + per-entry metadata (tags, related docs, key findings, status: active / superseded / theoretical).

**What needs to happen:** Three options to evaluate:
- (a) **Static .md file manually maintained** — drifts immediately, minimum viable, ships fastest
- (b) **Auto-generated from per-doc YAML frontmatter** — more reliable, requires standardizing frontmatter across all research docs (most don't have it currently)
- (c) **NotebookLM-backed query layer** — aligns with the stated NotebookLM-as-context-of-record direction; largest build

Pragmatic path: ship (a) as v1 (manual but immediate value) → standardize frontmatter as new research docs arrive → upgrade to (c) when NotebookLM is wired. The .md is the bridge.

**Why deferred:** Substantial build with structural decisions (which option, frontmatter schema, NotebookLM integration timing) that should be made alongside the v2 Build Plan's NotebookLM context layer architecture, not in isolation. Cross-references FW-010 (Deep Think corpus folder) — both depend on a curated-vs-canonical separation.

---

## Pending Item 6 — Gatekeeper Build Guide Update

**What it is:** Per dispositions Action 15, after Gatekeeper retirement, the Build Guide must be updated to reflect Gatekeeper is retired and note what (if anything) replaces its function. (Nothing replaces — the function never produced value the alternatives didn't already provide.)

**What needs to happen:** During the v2 Build Plan finalization pass, find Build Guide references to Gatekeeper (`Claude.AI/New Build/05_InfrastructureAndTools.md` is the likely location — verify) and update them: replace with a note that Gatekeeper was evaluated and retired in the v1→v2 transition; multi-vendor cowork makes per-vendor MCP topology cleaner than a unified pre-MCP registry.

**Why deferred:** Build Guide files are FROZEN per Jiang2's mandate. This edit happens in the authorized v2 finalization pass, not now.

**Operational follow-up (separate from Build Guide):** The `velorin-gatekeeper` MCP server itself lives in `Velorin Code/velorin-gatekeeper/` and needs uninstalling. That falls under FW-011 (Velorin Code/ separate triage pass).

---

## Sequencing Recommendation

Items 1, 2, 6 are Build-Guide-coupled — handle together in the v2 finalization pass.

Item 3 is STARTUP.md-coupled — handle when STARTUP.md gets its next focused review.

Item 4 is operational tool — handle when GDrive workflow needs maintenance OR when the MCP API change forces it.

Item 5 is the largest individual build — depends on NotebookLM integration timing and is best sequenced with that work.

[VELORIN.EOF]
