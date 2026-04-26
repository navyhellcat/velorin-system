# Velorin.v1 Archive — Final Dispositions
# Compiled by: Sonnet 4.6 archival triage subbot under Jiang
# Started: 2026-04-26
# Last updated: 2026-04-26

## Status
- Manifest NEEDS-CT-DECISION queue size: 67
- Archival Decision Lobby queue size: 6
- Resolved as ARCHIVE: 35
- Resolved as KEEP: 33
- Resolved as KEEP-AS-LIVE (lobby items only — with destination): 3
- Escalated to Jiang: 16
- Pending (deferred): 0

---

## ARCHIVE — Clean Decisions (move to Velorin.v1.Archive/)
- Claude.AI/Bot.MarcusAurelius/: entire folder
- Claude.AI/Bot.Scribe/: entire folder
- Claude.AI/tools/Agent.Teams.Claude.Code/: entire folder
- Claude.AI/tools/Claude Code/Claude_Teams.md
- Claude.AI/tools/architecture-map.html
- Claude.AI/tools/command-bus.md: unneeded entirely
- Claude.AI/architecture/ArchitecturalPivot_Mar27.md: archived, not needed
- ALL tool_discovery_*.md files across entire velorin-system/ (Receiving/, Bot.MarcusAurelius/notifications/, and anywhere else): archived immediately. Every single one, no exceptions.
- Claude.AI/Archived_Bots/Bot.Registry.md: archived
- Claude.AI/Archived_Bots/BOT.README.FIRST.BOOTUP.md: archived
- Claude.AI/Archived_Bots/Level1_SubAgent_Baseline.md: archived
- Claude.AI/Bot.Agent.Level1/ (entire folder, if exists): archived
- Claude.AI/Bot.Agent.Level2/ + Level2.General.Rules.md: archived — CT override of HIGH-CONFIDENCE KEEP
- Claude.AI/Bot.Agent.Level3/ + Level3.General.Rules.md: archived — CT override of HIGH-CONFIDENCE KEEP
- Claude.AI/Bot.Agent.Level4/ (folder): archived — but see KEEP WITH NOTES below for Level4.General.Rules.md specifically
- Any other sub-bot level hierarchy docs, folders, or files across the system: archived
  [NOTE — CT DIRECTION] The entire "Level 1/2/3/4 agent" framework is retired. System was confusing and is being left behind. All of it can be recreated better in the new build. Do not port any level-hierarchy operating rules forward.
  [ACTION FOR JIANG] Audit the entire velorin-system/ for any remaining level-agent references (bootloaders, ReadMe.First files, CLAUDE.md, operating rules) and strip them out. The new build starts clean on this.
- ALL Archived_Research_Requests across entire velorin-system/ (bulk — all bots):
  Erdos.ResearchRequest.GroundbreakingNovelty.md, Erdos.ResearchRequest.IESProbabilityShift.md, Erdos.ResearchRequest.ThetaWorkAndDarkSkillInvariance.md, Trey.ResearchRequest.SynapticPruning.md, Trey.ResearchRequest.TemporalMemoryValidation.md, Trey.ResearchRequest.TemporalValidity.md, Trey.ResearchRequest.SkillsDependencyGraphValidation.md, Trey.ResearchRequest.ClaudeCode.Skills.md, Trey.ResearchRequest.SemanticMemoryOrganization.md, plus all other archived request stubs across all bot Archived_Research_Requests/ folders.
  [ACTION FOR JIANG] Sweep ALL Archived_Research_Requests/ folders across every bot in the system. Consolidate every request stub into one single archive location — outside the active velorin-system/ tree (e.g., Velorin.v1.Archive/Archived_Research_Requests/). This archive must NOT be in any path that active bots traverse during normal boot or system sweeps. The goal: bots reading the live system never touch this folder, saving context. Human-accessible only, reference if needed.

---

## KEEP — Clean Decisions (no change to current location)
- Claude.AI/architecture/Mac_Sleep_Prevention.md: keep as a tool file

---

## KEEP-AS-LIVE (lobby items — restore to a live location)

---

## Pending (Chairman said "come back to this")

---

## ARCHIVE — With Notes
- Claude.AI/Bot.MarcusAurelius/:
  [ACTION FOR JIANG] CLAUDE.md boot sequence references Bot.MarcusAurelius/STARTUP.md and rules/MarcusAurelius.Rules.md — both paths break after archive. CT wants a new, clean STARTUP.md written as part of the new build. Update CLAUDE.md boot steps 3 and 4 to point to the new file. New STARTUP.md should not live in a bot-specific folder.

- Claude.AI/Bot.Scribe/:
  [NOTE] Scribe never functioned operationally. Generated an unknown number of orphan files scattered across the system that were never located or cleaned up. Before or during the new build: (1) run a sweep for Scribe-generated artifacts (look for scribe_run_log, escalation.md patterns, Scribe trigger signatures); (2) design a replacement for the Scribe use case (automated session logging / signal capture) from scratch during the new build — do not port from this implementation.

- Claude.AI/tools/Agent.Teams.Claude.Code/ + Claude.AI/tools/Claude Code/Claude_Teams.md:
  [ACTION FOR JIANG] Remove Agent Teams / tmux references from any active bootloaders or operating rules during new build setup. Cowork replaces this pattern entirely.

- Claude.AI/tools/architecture-map.html:
  [ACTION FOR NEW BUILD] Build a new visual architecture map — ideally a website or interactive HTML. CT flagged two one-shot options: (1) Google (Gemini/NotebookLM), (2) Claude + Codex. Revisit once new architecture is locked post-Mac Studio transition.

---

## KEEP — With Notes
- Claude.AI/skills/ (contains only Velorin.Skill.MathOCRRepair.md): keep folder, keep file.
  [ACTION FOR JIANG] Evaluate Velorin.Skill.MathOCRRepair.md alongside Math.OCR.Tool.md and GitHub.KaTeX.Rules.md as a group. All three cover the same functional area. Consolidate, simplify, and move the result into the "Skills/Hooks Pending Development" folder. Determine whether skills/ remains the canonical home or gets restructured in the new build.

- Claude.AI/tools/GitHub.KaTeX.Rules.md: keep — confirmed.
  [ACTION FOR JIANG] Evaluate alongside Math.OCR.Tool.md during the skills/hooks development pass. Determine if the two can be merged, simplified, or consolidated into a single canonical reference before building out the skill. Both are candidates for the "skills/hooks pending development" folder.

- Claude.AI/tools/claude-code-poller.sh: keep — move to new folder.
  [ACTION FOR JIANG] Create a folder called "Possibly Useful Scripts" (location TBD in new build structure). Move claude-code-poller.sh there. Evaluate all scripts in that folder before Mac Studio transition to determine what gets ported, rebuilt, or discarded.

- Claude.AI/Bot.Agent.Level4/Level4.General.Rules.md: keep — Jiang review required before retiring.
  [ACTION FOR JIANG] Read Level4.General.Rules.md in full. Extract anything worth preserving into the new build (operating principles, rules, constraints). Then archive the file. Do not carry it forward as a "level" doc — if content is worth keeping, it gets absorbed into the new system cleanly.

- Claude.AI/tools/ThirdCycleProblemProtocol.md: keep — future build item.
  [ACTION FOR NEW BUILD] This protocol needs to be implemented as an actual hook, automation, or formal protocol — not left as a passive .md. CT direction: build it into the system, not just document it. Candidate for the "skills/hooks pending development" folder flagged under Math.OCR.Tool.md above.

- Claude.AI/tools/Math.OCR.Tool.md: canonical reference, keep.
  [ACTION FOR JIANG] Review for completeness and currency. This is a skill/hook that needs to be formally developed — not just a reference doc. Notate it as a planned skill build. CT also flagged: consider whether a dedicated folder should exist for "tools that are actually skills/hooks pending development" so these don't get lost as loose .md files. Math.OCR.Tool.md would be the first candidate for that folder.

- Claude.AI/Bot.Alexander/:
  [ACTION FOR JIANG2] Full top-to-bottom review required. Jiang2 to determine what stays, what gets edited, what moves, and what archives. CT flagged significant important content inside. Do not touch during v1 archive pass — Jiang2 owns the disposition.

---

## Escalated to Jiang
- ALL Research_Complete files — Erdős and Trey (items 17–39 in queue, bulk decision):
  ALL individual Research_Complete files across Bot.Erdos/Research_Complete/ and Bot.Trey/Research_Complete/ are KEPT as-is. No individual files are archived from these folders.

  [STANDING RULE — CT LOCKED] Jiang to build ONE consolidated Research Library index file covering ALL research docs across all bots (Erdős, Trey, and any future researchers). The index must include:
  - A navigation table at the top (bot, document name, topic, date, one-line summary)
  - Detailed metadata per entry (tags, related docs, key findings, status: active/superseded/theoretical)
  - The goal: future bots navigate the index, not the raw files. No bot should need to read an entire research doc to know what's in it.
  This index is a priority build item. Individual research files stay where they are; the index lives alongside them or at a root reference location TBD by Jiang.

  [NOTE] This same indexing standard applies to ALL research files going forward — any new research deliverable from any bot gets a metadata entry in the index at time of creation.

  [STANDING RULE EXTENSION] Any research-adjacent doc that is not clearly a duplicate or superseded gets the same treatment: KEEP, add to index. This includes topic docs, synthesis docs, bootloader fix docs, and validation docs that live in Research_Complete folders. Applied to Trey_Bootloader_Framing_Fix.md below and any future similar items.

  Specific files covered by this bulk decision (all KEEP):
  - Erdos.FutureTheory.IgnitionProtocol.DarkMatter.md
  - Erdos.Thermodynamics.Epistemological.Time.Future.Consideration.md (note: typo in filename — "Emistemological")
  - Erdos.DimensionalGeology.Theoretical.md
  - Erdos.Stage2.Problem.Solving.md
  - Erdos.Unification.Stage3.md
  - Erdos.Initial.Synthesis.Stage1.md
  - Erdos.Novelties.BrainArchitecture.md
  - Erdos_Layer_Math_v1_FULL_With_Hypothetical.md
  - Erdos.Solution.NonAbelianBrainDynamics.md
  - Erdos.Solution.SynapticPruning.md
  - Erdos.Solution.ThresholdsAndDarkSkillInvariance.md
  - Erdos.Solution.UnifiedGatingPrimitive.md
  - Erdos.Solution.BridgingDeclarativeProceduralMemory.md
  - Erdos/Research_Complete/images/ (keep with RC)
  - Trey.Research.CrossPlatformAppMesh.md
  - Trey.Research.KnowledgeStaleness.md
  - Trey.Research.SMBvsTCP.EventPropagation.md
  - Trey.Research.SemanticMemoryOrganization.Neuroscience.md
  - Trey.Research.SkillsSchemaValidation.md
  - Trey.Research.SynapticPruning.v2.md
  - Trey.Research.ViscoelasticBrainArchitecture.md
  - Trey/Research_Complete/images/ (keep with RC)
  - Trey_Bootloader_Framing_Fix.md (keep — same rule; add to Research Library index)
  - Bot.Trey/Trey.Topic.OpenAIEcosystem.md: KEEP. Same rule — add to Research Library index with metadata. Move to Research and Tools folder.
  - [STANDING RULE EXTENSION] Any remaining research topic, synthesis, or ecosystem doc in the queue gets the same treatment automatically: KEEP, index, Research and Tools folder. CT confirmed this applies to all similar items.
  - Bot.Trey/Assessments/ — entire folder (Trey_Market_Research.md, Velorin_Deep_Research_Report.md, MiroFish memo, mirofish_stack_deep_research/, velorin_tooling_research/): KEEP. Move entire folder into a "Research and Tools" folder. Add all contents to the Research Library index with metadata. These are early-stage tool and market research docs — not deleted, catalogued for future reference.

- Claude.AI/sessions/ — all 8 files (Jiang2.FullSystemRead.Report.Session024.Apr12, Alexander handoffs Sessions 0007-0008, MA handoffs Sessions 0009/0011/0012/0013, Session_015_Handoff_Mar31):
  Jiang to:
  (1) Compile all session files from the sessions/ folder into one single archive file with consistent metadata tags per session (date, bot name, session number, brief topic).
  (2) Add compiled file to "Build Timeline Help/" folder. This folder carries over to Mac Studio but is marked as ARCHIVE — bots do not read it on boot or regularly. It is reference-only, human-accessible.
  (3) After compilation, the sessions/ folder itself is archived/removed.

  [STANDING RULE — CT LOCKED] Going forward: every named bot gets exactly ONE session handoff file. It is a rolling file. When a new session closes, the new handoff text REPLACES the content of that one file — the old content is moved to the bot's entry in the Build Timeline archive first, then overwritten. New session handoff files must never be created for a bot that already has one. One file per bot, always current, always lightweight. This rule applies to Jiang, Jiang2, Alexander, MarcusAurelius, and any future named bot.

- Claude.AI/Bot.Jiang/Jiang2.Corner.md + ALL Jiang Corner files across the entire velorin-system/ — PRIORITY / DO ASAP:
  Jiang to:
  (1) Find every Jiang Corner file across the entire velorin-system/ repo (Jiang.Corner.md, Jiang2.Corner.md, any others).
  (2) Compile all historical Corner content into one single archive file. Place it in a new folder: "Build Timeline Help/". Label and metalabel the archive file for easy script insertion (e.g., date headers, session markers, consistent tagging).
  (3) After compilation, archive that Build Timeline Help/ folder as a historical record.
  (4) Locate every place in the system where Jiang Corner writing instructions exist (ReadMe.First, operating rules, bootloaders, etc.). Update ALL of them to enforce the new rule: Jiang Corner is ONE rolling file, holds only 7 days of entries. When a new day is added, the oldest day is automatically moved out to the Build Timeline archive sheet — not deleted, moved. The rolling file stays lean; the archive grows.
  (5) This is flagged as ASAP — do before the next major session.

- Claude.AI/Bot.Jiang/Working.Docs/Velorin.v1.ArchiveTriage.Manifest.md — Jiang to: walk CT through what this file is and what it contains before any disposition decision. Context: it was auto-generated by a triage agent at the start of this session and lists all 258 items in Claude.AI/ with recommended archive/keep classifications. CT has not read it directly. Jiang reviews it with CT, then they decide together whether to keep it as a reference, fold it into the Build Timeline Help folder, or archive it.
- /Users/lbhunt/Desktop/Velorin/Velorin Code/ — Jiang to: run a full separate triage pass on this directory. CT direction: this folder must remain outside the main velorin-system/ tree permanently — its physical separation from the agent-readable system is intentional security architecture, protecting against adversarial access. Do not merge or symlink into velorin-system/. Triage pass should determine what inside needs indexing, archiving, or updating — but the folder stays where it is.
- Claude.AI/Archived_Bots/GLOBAL_SPAWNER_REGISTRY.md: move to "Possibly Useful Scripts" folder. Jiang to review with CT one by one before any disposition decision.
- Claude.AI/Archived_Bots/GLOBAL_TIMER_REGISTRY.md: same — move to "Possibly Useful Scripts" folder. Jiang reviews with CT.
- Claude.AI/Archived_Bots/ENVIRONMENT_DETECTION.md: same — move to "Possibly Useful Scripts" folder. Jiang reviews with CT.
- Claude.AI/architecture/Bash_Access_Rules.md — PRIORITY / IMMEDIATE. Jiang to: review now. Confirm the rules are current, complete, and match the actual settings.local.json permissions. Update or correct as needed. This is a security-adjacent file — stale rules here are a live risk.
- Claude.AI/architecture/AppsScript_Communication_Bus.md — Jiang to: review and decide — delete entirely, or build it into an actual script, cron, or hook. It should not remain a passive design doc. If the concept is worth building, build it. If not, archive it. No middle ground.
- Claude.AI/architecture/Velorin.OS.Core.Principles.md — Jiang to: find all similar "core principles / OS principles / operating standards" docs across the system. Combine, consolidate, re-evaluate against current Velorin.Company.DNA.md and Company.Operating.Standards.md. Whatever is already covered gets absorbed — whatever isn't gets added cleanly. Then archive the originals. Likely everything in this category ends up archived after extraction. Apply same treatment to any other doc of this type found during the sweep.
- Claude.AI/architecture/GPS.Layer.System.Design.md — Jiang to: review and compare against the current Build Guide. Determine if GPS layer design is already captured in the new build thinking. If not, flag for Jiang2 to review before the final Jiang2 + Deep Think pass of the Build Guide. Do not let this fall through the cracks before that pass.
- Claude.AI/architecture/Skill.Registry.Design.md — Jiang to: review fully. Determine what's still valid for the new skills build, what's outdated, and whether this doc gets ported forward, merged into the Build Guide, or archived after extraction.
- Claude.AI/Bot.Gatekeeper/GATEKEEPER.md — Jiang to: evaluate the Gatekeeper MCP fully and remove it from the system. CT direction: Gatekeeper is not optimal or useful for future builds. After removal, update the Build Guide to reflect that Gatekeeper is retired and note what (if anything) replaces its function. Archive GATEKEEPER.md after the removal work is done.
- Claude.AI/tools/desktop-verification.md — Jiang to: read the file, parse out what's useful, redistribute the content more simply to appropriate locations (operating rules, bootloaders, or architecture docs), then archive the original file. Do not keep as-is.
- Claude.AI/tools/GDrive.Port.Tool.md — Jiang to review: confirm whether this is the canonical GDrive port reference and whether any updates are needed before the new build.

[VELORIN.EOF]
