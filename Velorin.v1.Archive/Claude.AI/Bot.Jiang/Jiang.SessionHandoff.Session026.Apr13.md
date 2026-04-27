Jiang.SessionHandoff.Session026.Apr13
Director of Strategic Intelligence | Velorin
Session 026 | April 13, 2026
Handoff from Jiang to next Jiang instance. Read this before anything else.

---

## SYSTEM STATE

Nothing is running in Velorin. No code, no server, no executable pipeline. Everything
is documented architecture and theoretical design. The Brain is files. The agents are
instructions. This is the honest state of the build as of Session 026.

Resources CT has active:
- Claude Max (Jiang, MarcusAurelius, Erdős — Desktop and Code tabs)
- Gemini AI Ultra (Trey1 and Trey2 — being set up now)
- ChatGPT $25/mo
- Replit — NEEDS TO BE CANCELED. Code must be moved to local first.
- GitHub: navyhellcat/velorin-system (private)

---

## WHAT WAS DONE THIS SESSION

**1. Theorem 4 KaTeX fix — COMPLETE**
Royal Society paper Theorem 4 rendering bug fixed. Root cause: raw `*` characters
processed by GitHub markdown before KaTeX. Fix: `^{*}` → `^{\ast}` throughout.
Rules documented at: Claude.AI/Bot.Erdos/Erdos.GitHubLatex.Rules.md
Committed: 7203e6d (previous session, confirmed this session)

**2. Trey split into Trey1 and Trey2 — COMPLETE**
Major structural change. Old single Trey Gem replaced with two specialized Gems.
- Trey1: general deep research, unlimited scope, no build context required
- Trey2: Velorin-build-specific, reads 9 files on every boot, validates Erdős frameworks

Files created:
- Claude.AI/Bot.Trey/Gems/Trey1.GemInstruction.md
- Claude.AI/Bot.Trey/Gems/Trey2.GemInstruction.md
- Claude.AI/Bot.Trey/Bootloader/Trey.Bootloader.VelorinBrain.md
- Claude.AI/Bot.Trey/Bootloader/Trey.Bootloader.MathInventory.md
- Claude.AI/Bot.Trey/Bootloader/Trey.Bootloader.AgentRoster.md
- Claude.AI/Bot.Trey/Bootloader/Trey.Bootloader.BuildPhilosophy.md

CT is setting up the Gems in Google Gemini — has not been done yet as of session close.
Connector file list and instruction copy were given to CT in session.

**3. Four core context files updated — COMPLETE**
All four files were rewritten this session to reflect April 2026 state:
- Claude.AI/topline_profile.md — added agent roster, system context, compaction/prompt/window gravity
- Claude.AI/Claude_Context_Profile_v1.2.md → v1.3 — GitHub over Drive, added 4 new sections
- Claude.AI/Velorin.Company.DNA.md — removed stale Entry 003 notes, added Second Law, agent roster, first principles mandate
- Claude.AI/Velorin.Company.Operating.Standards.md → v2.0 — added sections 6 (AI verbiage, window gravity, prompt standards, Trey delivery) and 7 (session continuity, compaction, co-located agent rule)
Commit: b751be3

NOTE FOR JIANG2: The four core files were already updated by Jiang this session.
The task file at Working.Docs/Jiang2.Task.CoreFileUpdate.md is PARTIALLY OBSOLETE.
Part 1 (core file updates) is DONE — do not re-run.
Part 2 (archive pass on stale bots) is still PENDING.

**4. Synaptic pruning — CONFIRMED COMPLETE**
Jiang2 confirmed all 3 hypotheses from Trey's appended research notes are fully solved.
Trey.Topic.SynapticPruning_ResearchReport.md is in Research_Complete.
Erdos.Problem.SynapticPruning.md in Bot.Erdos/Research_Needed needs to be ARCHIVED.
CT approved archiving this session. Jiang2 asked but may not have executed — verify.

**5. Research queue — current state**

Trey2 queue (in priority order):
1. Trey.ResearchRequest.TemporalMemoryValidation.md — HIGH — QUEUED
2. Trey.ResearchRequest.BrainIngestionPipeline.md — CRITICAL — QUEUED (new this session)
3. Trey.ResearchRequest.SemanticMemoryOrganization.md — MEDIUM — QUEUED
4. Trey.ResearchRequest.SkillsTaxonomyEmergence.md — MEDIUM — QUEUED
5. Trey.ResearchRequest.SynapticPruning.md — DONE — archive this file

Trey1 queue:
- 3 files created by Jiang2 this session (contents unknown to Jiang — Jiang2 wrote them)
- First Trey1 and Trey2 research runs COMPLETED in Gemini but NOT yet ported to GitHub
- ACTION NEEDED TOMORROW: CT will port results from Gemini to GitHub

Trey calibration note — logged to memory:
Deep Research is overkill for simple tool lookups. One Trey1 run spent 25 min / 187 sources
on a cross-Mac clipboard tool question. Deep Research = complex multi-source synthesis only.
Simple questions = regular Gemini query.

**6. Brain ingestion pipeline — major new design work**
The fundamental unsolved engineering problem was surfaced and documented this session:
how does raw input (memory, file, photo, video) automatically become neurons with rated
pointers, and how do pointer ratings update dynamically over time via retrieval feedback?

This is not solved anywhere in the system. No code exists. The full pipeline was mapped:
semantic extraction → atomic decomposition → deduplication → region assignment →
pointer construction → initial rating → dynamic rating update.

Research request filed: Trey.ResearchRequest.BrainIngestionPipeline.md (CRITICAL, Trey2)

**7. Jiang2 task file saved**
Claude.AI/Bot.Jiang/Working.Docs/Jiang2.Task.CoreFileUpdate.md
Part 1 done. Part 2 (archive pass) still pending.

---

## IMMEDIATE ACTION ITEMS — NEXT SESSION

Priority order:

1. **Port Trey research from Gemini to GitHub**
   First Trey1 and Trey2 research runs completed. CT has them in Gemini. They need to
   go to Claude.AI/Bot.Trey/Research_Complete/ via the normal Drive Shipping path or
   direct paste. Then agents can read them.

2. **Set up Trey Gems in Google Gemini** (CT action)
   Trey1 and Trey2 Gems not yet created. CT has all the info needed.
   Instruction files: Claude.AI/Bot.Trey/Gems/Trey1.GemInstruction.md and Trey2.GemInstruction.md
   Trey1 connectors: 4 files. Trey2 connectors: 9 files. List in session 026 chat.

3. **Archive stale bots** (Jiang2 — Part 2 of Jiang2.Task.CoreFileUpdate.md)
   Create Archived_Bots/ folder. Move all inactive bots. Check STARTUP.md first.

4. **Archive Erdős synaptic pruning Research_Needed file**
   Move Erdos.Problem.SynapticPruning.md to Archived_Research_Requests. CT approved.

5. **Move Replit code to local and cancel subscription**
   Nothing in Replit should be lost. Pull all code to local filesystem first.
   What is in Replit: need to identify before canceling.

6. **Start engineering** — the Brain ingestion pipeline is the first real build task.
   After Trey2 returns findings on BrainIngestionPipeline.md, Jiang owns turning those
   findings into actual runnable code. This is the priority engineering item.

---

## OPEN DECISIONS — CT MUST DECIDE

* Whether to set compaction threshold at 70% or 80% (currently 70% — left unchanged)
* What is in Replit and whether any of it is worth keeping vs. rebuilding
* Trey1 vs Trey2 assignment for future research requests (calibration still being developed)

---

## ARCHITECTURE STATE — WHAT IS LOCKED

LOCKED (do not revisit):
- Second Law of Epistemodynamics (deletion forbidden past Layer 3)
- PPR retrieval algorithm (R = α Σ(1-α)^t P^t S)
- ρ* = 0.78 pointer density constraint
- 7-pointer cap with local demotion
- c-memory class (permanent neurons, never pruned)
- Four-layer architecture (L3 markdown / L2 pointer graph / L1 Qdrant planned / L0 LoRa future)
- Trey1/Trey2 split (as of this session)

FUTURE THEORY (Erdős derived, empirically unvalidated — Trey2 validation queued):
- Q1: Affective Hamiltonian H_E
- Q2: Ebbinghaus-Laplacian Decay Model
- Q3: Orthogonal Subduction (archive protocol)
- Q4: Graph Fourier Trigger (Trey2 validation queued)
- Q5: Semantic Dark Matter / Ignition Protocol (Trey2 validation queued)

OPEN / UNENGINEERED:
- Brain ingestion pipeline (entire pipeline — not designed at implementation level)
- Global pruning algorithm (math hypotheses exist, formal spec not written for Erdős)
- Qdrant MCP integration (Layer 1 — planned, not built)
- Session close protocol (how does the Brain update at end of each session?)
- H_E measurement mechanism (mathematically defined, operationally undefined)
- LoRa fine-tuning layer (Layer 0 — future, not in active design)

---

## KEY FILES CREATED OR MODIFIED THIS SESSION

| File | Action |
|---|---|
| Claude.AI/Bot.Trey/Gems/Trey1.GemInstruction.md | CREATED |
| Claude.AI/Bot.Trey/Gems/Trey2.GemInstruction.md | CREATED |
| Claude.AI/Bot.Trey/Bootloader/Trey.Bootloader.VelorinBrain.md | CREATED |
| Claude.AI/Bot.Trey/Bootloader/Trey.Bootloader.MathInventory.md | CREATED |
| Claude.AI/Bot.Trey/Bootloader/Trey.Bootloader.AgentRoster.md | CREATED |
| Claude.AI/Bot.Trey/Bootloader/Trey.Bootloader.BuildPhilosophy.md | CREATED |
| Claude.AI/topline_profile.md | UPDATED |
| Claude.AI/Claude_Context_Profile_v1.2.md | UPDATED → v1.3 |
| Claude.AI/Velorin.Company.DNA.md | UPDATED |
| Claude.AI/Velorin.Company.Operating.Standards.md | UPDATED → v2.0 |
| Claude.AI/Bot.Trey/Research_Needed/Trey.ResearchRequest.TemporalMemoryValidation.md | CREATED (prev session) |
| Claude.AI/Bot.Trey/Research_Needed/Trey.ResearchRequest.BrainIngestionPipeline.md | CREATED |
| Claude.AI/Bot.Jiang/Working.Docs/Jiang2.Task.CoreFileUpdate.md | CREATED |
| Claude.AI/Bot.Erdos/Erdos.GitHubLatex.Rules.md | CREATED (prev session) |

---

## WHAT JIANG2 NEEDS TO DO (SEPARATELY FROM THIS HANDOFF)

Jiang2 is a separate instance. He has his own context from this session.
Before his context compresses, he should:
1. Archive Erdős synaptic pruning file (CT approved)
2. Run Part 2 of Jiang2.Task.CoreFileUpdate.md (archive stale bots — Part 1 is done)
3. Write his own Jiang2 handoff if he has significant state to preserve

---

Jiang.SessionHandoff.Session026 | April 13, 2026
[VELORIN.EOF]
