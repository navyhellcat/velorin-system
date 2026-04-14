---
PRIORITY: IMMEDIATE — run this before context compresses
assigned-to: Jiang2
created: April 13, 2026
status: QUEUED
---

# Jiang2 Task — Core File Update + Archive Pass

Run this now. Do not defer.

```
You are Jiang2. This is a standalone task — pull from GitHub first, then execute.

cd /Users/lbhunt/Desktop/velorin-system && git pull

---

TASK: Two things. Do them in order.

---

PART 1 — UPDATE THE FOUR CORE CONTEXT FILES

These files are read by every agent on every boot and uploaded as connectors into Trey's Gems.
They are significantly out of date. Rewrite them to reflect where we actually are.

FILES TO UPDATE:
- Claude.AI/topline_profile.md
- Claude.AI/Claude_Context_Profile_v1.2.md
- Claude.AI/Velorin.Company.DNA.md
- Claude.AI/Velorin.Company.Operating.Standards.md

READ THESE FIRST to understand current state before touching anything:

1. Claude.AI/Bot.Trey/Gems/Trey1.GemInstruction.md
   → Contains the current research philosophy in final form: Window Gravity, Contrast
     Negation, Query Modes, Build vs. Adopt, AI verbiage avoidance, Discovery Mode,
     Tight Mode, prompt writing rules. This is the authoritative current state of how
     we think about prompting and research.

2. Claude.AI/Bot.Trey/Gems/Trey2.GemInstruction.md
   → Same philosophy applied to build-specific context. Read both.

3. Claude.AI/Bot.Trey/Bootloader/Trey.Bootloader.VelorinBrain.md
   → Current architecture: 4-layer system, PPR retrieval, failure modes, what is and
     isn't built. This is the ground truth on where the build is.

4. Claude.AI/Bot.Trey/Bootloader/Trey.Bootloader.MathInventory.md
   → What Erdős has proven (locked), what is Future Theory (pending validation),
     what is open. Includes the Second Law of Epistemodynamics.

5. Claude.AI/Bot.Trey/Bootloader/Trey.Bootloader.AgentRoster.md
   → Full current agent roster: Alexander, Jiang, Jiang2, MarcusAurelius, Erdős,
     Trey1, Trey2. Who owns what. How work routes.

6. Claude.AI/Bot.Trey/Bootloader/Trey.Bootloader.BuildPhilosophy.md
   → First principles build mandate, what is NOT settled, what tools are NOT locked in.

7. Claude.AI/Bot.Jiang/Jiang.SessionHandoff.Session024.Apr12.md
   → Most recent session handoff. Current build state and decisions.

WHAT NEEDS TO CHANGE IN EACH FILE:

topline_profile.md:
- Add the Velorin system context (he's building a 4-layer AI-powered personal OS)
- Add current agent ecosystem (he now has 7 agents across Claude and Gemini)
- Update AI interaction notes: Window Gravity, context compaction awareness, prompt
  length — shorter focused prompts outperform long ones, compaction happens and session
  handoffs are critical architecture
- The cognitive and personal profile data is accurate — do not change it

Claude_Context_Profile_v1.2.md:
- Add context compaction guidance: sessions compact, handoffs are how state is preserved,
  never assume prior session context is available, read handoff files on boot
- Add prompt length guidance: short focused prompts over long ones, one clear instruction
  per message outperforms compound requests
- Add Window Gravity warning: AI defaults to context window as complete picture — explicitly
  fight this, check external state via git/files before concluding anything about system state
- Add agent coordination section: CT now runs a multi-agent system. Claude instances do
  not coordinate directly — all routing goes through CT.
- Add co-located agent note: Jiang and Jiang2 run on the same MacBook Air, same filesystem,
  same local git repo. If Jiang has pulled, Jiang2 already has the files. Do not instruct
  Jiang2 to git pull when Jiang has already pulled in the same session.

Velorin.Company.DNA.md:
- Update the agent section to reflect current roster (Trey1/Trey2 split, Erdős, full team)
- Add the Second Law of Epistemodynamics as a locked architectural principle: deletion is
  mathematically forbidden once information propagates past Layer 3. The Brain archives
  and demotes — it does not delete.
- Add first principles build mandate in the DNA: nothing currently in use is assumed to
  be the permanent architecture. Community proof-of-concept is signal; Velorin builds its
  own version derived from first principles.
- The company vision and Five Boxes are accurate — do not change them

Velorin.Company.Operating.Standards.md:
- Add compaction standards: every session must produce a handoff document before closing.
  Handoffs are not optional — they are load-bearing architecture. Session state that is
  not written to a handoff file is considered lost.
- Add prompt standards: prompts to agents should be short and focused. One task per prompt
  where possible. Compound prompts produce compound errors. If a task requires a long
  prompt, break it into sequential steps.
- Add Window Gravity as a standard violation: concluding "X does not exist" or "X cannot
  be done" without checking the repo, external files, or community layer is a standards
  failure.
- Add AI verbiage prohibition: cutting-edge, robust, leverage (verb), utilize, it's worth
  noting, delve, innovative, transformative, best practices (without specifics) are banned
  across all agent outputs.
- Add the Trey1/Trey2 delivery protocol to the research standards section.
- Keep all existing formatting and output standards — add to them, don't replace them.

STYLE FOR ALL FOUR FILES:
- Declarative language: must, do not. Not may, might, consider.
- No padding. No filler.
- Each file ends with [VELORIN.EOF]
- Keep what is still accurate. Update what is stale. Add what is missing.
- Do not rewrite for the sake of rewriting.

---

PART 2 — ARCHIVE PASS ON BOT FOLDERS

After Part 1 is committed and pushed, do this:

Create: Claude.AI/Archived_Bots/

Move into Archived_Bots/ every bot folder and subbot EXCEPT the active agents:
- Bot.Agent.Level2
- Bot.Agent.Level3
- Bot.Agent.Level4
- Bot.Coordinator
- Bot.Custodian
- Bot.Editor
- Bot.Gatekeeper
- Bot.Mobility
- Bot.Oversight
- Bot.Replit
- Bot.Scribe
- Bot.Theresa
- Bot.Visualizer
- Bot.MarcusAurelius.Subbots
- Bot.Registry.md (file — move to Archived_Bots/)
- Level1_SubAgent_Baseline.md (move to Archived_Bots/)
- GLOBAL_SPAWNER_REGISTRY.md (move to Archived_Bots/)
- GLOBAL_TIMER_REGISTRY.md (move to Archived_Bots/)
- BOT.README.FIRST.BOOTUP.md (move to Archived_Bots/)
- ENVIRONMENT_DETECTION.md (move to Archived_Bots/)

Leave in place (active):
- Bot.Alexander
- Bot.Jiang
- Bot.MarcusAurelius
- Bot.Erdos
- Bot.Trey
- All company files (Velorin.Company.*, topline_profile.md, Claude_Context_Profile*, etc.)
- All working folders (Brainstorming Sessions, CHAIRMAN_CONFIDENTIAL, architecture, tools,
  sessions, hooks, Jiang.Corner.md, etc.)

Before moving anything: read Bot.MarcusAurelius/STARTUP.md to check whether any of the
files being moved are referenced in the startup sequence. If they are, update STARTUP.md
to remove or redirect those references before moving the files.

Commit message for Part 1: "Update four core context files — current architecture, agent roster, compaction and prompt standards"
Commit message for Part 2: "Archive stale bots and subbots — active agents remain in place"

Push both commits separately.

When done, report:
- Which files were updated and the key changes made to each
- Which files/folders were archived
- Any STARTUP.md references you found and how you handled them
- Anything that looked wrong or that you made a judgment call on
```

[VELORIN.EOF]
