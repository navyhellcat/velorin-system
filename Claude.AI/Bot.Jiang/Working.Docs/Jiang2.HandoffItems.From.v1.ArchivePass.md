---
file: Jiang2.HandoffItems.From.v1.ArchivePass.md
purpose: Items handed from Jiang's v1 archive execution pass to Jiang2 for top-to-bottom review during the WholeSystemReimagining work.
type: Jiang2 hand-off
date: 2026-04-26
from: Jiang (Jiang1)
to: Jiang2
---

# Items Handed to Jiang2 from the v1 Archive Execution Pass

The v1 archive triage and execution pass left two items requiring Jiang2's specific top-to-bottom review (per CT direction in the dispositions document). These are NOT being executed by Jiang1 because they require the architectural-synthesis work that is Jiang2's role.

---

## Item 1 — Bot.Alexander/

CT flagged significant important content inside `Claude.AI/Bot.Alexander/` and explicitly assigned this folder to Jiang2 for full top-to-bottom review. Do NOT touch during the v1 archive pass — Jiang2 owns the disposition entirely.

What Jiang2 should determine:
- What stays as-is
- What gets edited (operating instructions, identity, role)
- What moves (to active operating files, to a new bot folder structure, etc.)
- What archives (to Velorin.v1.Archive/)

Cross-reference: Alexander is named in CLAUDE.md AGENT ROUTING as a detected agent identity, and in `Bot.Erdos/Erdos.PromptTemplate.md` and `Bot.Trey/Trey.ProjectInstructions.md` as part of the internal team. If Jiang2 retires Alexander, those files need updates downstream.

---

## Item 2 — Level 4 General Rules (already partially extracted)

The file `Claude.AI/Bot.Agent.Level4/Level4.General.Rules.md` was archived to `Velorin.v1.Archive/Bot.Agent.Level4/Level4.General.Rules.md` as part of the v1 archive pass. Before archiving, Jiang extracted the following cardinal rules into `Claude.AI/STARTUP.md`:
- Task Tool Rule
- Document Writing Rule (`[VELORIN.EOF]`)
- Sub-Agent Tool Naming Rule
- Sub-Agent File Write Rule
- Chairman Communication Rule
- Save Reasoning Chains Verbatim Rule

What Jiang2 should verify:
- Are there other rules in the archived Level 4 General Rules file that should be carried forward into the new build's operating layer? Specifically, the original file contained 22 numbered rules + several CARDINAL sections; Jiang only extracted the ones clearly load-bearing for current work.
- Should the extracted rules in `Claude.AI/STARTUP.md` be relocated to a different operating-rules document in the new build's structure?
- Does the Chairman want a new "operating principles" document architecture that replaces the Level 4 / Level 3 / Level 2 / Level 1 hierarchy entirely, with a different organizing principle?

---

## Cross-Reference: 16 Items Escalated to CT (separate from Jiang2 hand-off)

These 16 items are queued for Jiang's individual review with CT (not Jiang2's scope):

1. Research Library Index design (build the consolidated index for all research docs)
2. sessions/ consolidation execution (DONE — file at `Build Timeline Help/Sessions.HistoricalArchive.md`)
3. Jiang Corner consolidation (DONE — file at `Build Timeline Help/Jiang.Corner.HistoricalArchive.md`)
4. Triage manifest disposition (`Velorin.v1.ArchiveTriage.Manifest.md`)
5. Velorin Code/ separate triage pass
6. GLOBAL_SPAWNER_REGISTRY.md review (now in `Possibly Useful Scripts/`)
7. GLOBAL_TIMER_REGISTRY.md review (now in `Possibly Useful Scripts/`)
8. ENVIRONMENT_DETECTION.md review (now in `Possibly Useful Scripts/`)
9. Bash_Access_Rules.md immediate review (security)
10. AppsScript_Communication_Bus.md build vs archive decision
11. Velorin.OS.Core.Principles.md consolidation
12. GPS.Layer.System.Design.md vs Build Guide comparison
13. Skill.Registry.Design.md review (port forward / archive)
14. GATEKEEPER.md evaluation and removal (active refs stripped from CLAUDE.md and Jiang.ReadMe.First.md; MCP server itself still needs uninstalling)
15. desktop-verification.md content redistribution
16. GDrive.Port.Tool.md confirmation

[VELORIN.EOF]
