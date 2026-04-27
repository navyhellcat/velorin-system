# Velorin Startup Manifest
**What travels to Mac Studio and in what order.**
**April 26, 2026 — Produced under FW-013.**

The Startup Manifest specifies the bridge from in-progress Velorin (what we're working off right now) to the v2 build on Mac Studio. This is a bridge artifact, not the final architecture.

---

## What the Startup Folder Is Allowed to Do

- Keep in-progress Velorin work alive and queryable during Part 1 build
- Provide a cold-boot-capable reference point for Part 1 agents
- Carry the Build Guide and Thesis as the authoritative specification
- Carry locked decisions as architectural commitments

## What the Startup Folder Is NOT Allowed to Do

- Implement the new architecture (that happens during Part 1 build)
- Retire structural elements preemptively (CT decides after reviewing the synthesis)
- Serve as a parallel architecture competing with the new build
- Carry stale operating rules as active instructions

---

## Format

**Git clone of navyhellcat/velorin-system.** Not a zip archive. The git history IS the provenance record (Second Law applies). Mac Studio clones the repo fresh, creates the qdrant_storage directory, and runs Stage 0 setup from `06_BuildSequence.md`.

---

## What Travels — Active State (Primary Load)

These files are the active build state. Every agent reads them on boot.

| What | Location | Why |
|---|---|---|
| Build Guide (00-07 + Velorin.CheckIns.md + Velorin.StartupManifest.md + Velorin.MacStudio.Setup.md) | `Claude.AI/New Build/` | The specification |
| Vision document | `Claude.AI/New Build/00_Vision.md` | The front door |
| Session handoffs (036, 037) | `Claude.AI/Bot.Jiang/Jiang.SessionHandoff.Session036.Apr25-26.md` + `Session037.Apr26.md` | Current state |
| FW registry | `Claude.AI/Bot.Jiang/Working.Docs/Jiang.FutureWork.md` | Open work items |
| Feedback memories | `~/.claude/projects/-Users-lbhunt/memory/` | Behavioral rules |
| Brain neurons (current 45) | `Claude.AI/Velorin_Brain/` | Current compiled knowledge |
| Locked feedback memories | `~/.claude/projects/-Users-lbhunt/memory/MEMORY.md` + all referenced files | Rules |
| Velorin.Principles.md | `Claude.AI/Velorin.Principles.md` | Architectural principles |
| Velorin.Company.DNA.md | `Claude.AI/Velorin.Company.DNA.md` | Company identity |
| Velorin.Vocabulary.md | `Claude.AI/Velorin.Vocabulary.md` | Terminology |
| Re-Eval form (finalized) | `Claude.AI/Bot.Jiang/Jiang.RespondingToReEvaluations.md` | Locked architectural commitments |
| WholeSystemReimagining synthesis + update | `Claude.AI/Bot.Jiang/Jiang2.WholeSystemReimagining.Synthesis.md` + `...SynthesisUpdate.Apr26.md` | Vision and novel math |
| Trey bootloaders (post-audit) | `Claude.AI/Bot.Trey/Bootloader/` | External agent configuration |
| Erdős Gem instructions | `Claude.AI/Bot.Erdos/Erdos.Gem.Instructions.md` + `Erdos.PromptTemplate.md` | Math agent configuration |
| Jiang ReadMe.First | `Claude.AI/Bot.Jiang/Jiang.ReadMe.First.md` | Jiang identity |
| Alexander ReadMe.First (updated) | `Claude.AI/Bot.Alexander/Alexander.ReadMe.First.md` | Historian identity |
| conflict_routing.yaml | `Claude.AI/conflict_routing.yaml` (to be created Stage 1) | Contradiction routing |
| Velorin.Consensus.Filter.md | `Claude.AI/Velorin.Consensus.Filter.md` | Consensus filter spec |
| Agent.API.Conventions.md | `Claude.AI/Agent.API.Conventions.md` | External agent sentinels |

---

## What Travels — Reference (Does Not Load on Boot)

Available for lookup; not loaded at session start.

| What | Location | Why |
|---|---|---|
| All Erdős solutions | `Claude.AI/Bot.Erdos/Research_Complete/` | Math reference; Erdős loads at [BOOT] |
| All Trey research | `Claude.AI/Bot.Trey/Research_Complete/` | Research archive |
| Prior session handoffs (before 036) | `Claude.AI/Bot.Jiang/` (older handoffs) | Historical record |
| v1 Archive | `Velorin.v1.Archive/` | Reference only; never active |
| Research corpus index | `Claude.AI/New Build/Velorin.ResearchCorpus.md` | Navigate research |

---

## What Does NOT Travel

| What | Why |
|---|---|
| qdrant_storage/ | Rebuilt from scratch at Mac Studio; embed all neurons fresh |
| Operating rules as active instructions | The Build Thesis + Principles.md is the active model; old rules travel as reference only with staleness banner |
| Detailed session handoffs before Session 036 | Compressible into current state; historical record in git |
| Full Trey/Erdős request-response cycles | In GitHub history and Research_Complete; queryable on demand |

---

## The Operating Rules Tension

The current operating rules files (Level4.General.Rules.md archived to v1, STARTUP.md, Jiang.ReadMe.First) still contain some v1-era references (Gatekeeper calls, environment detection patterns, some MarcusAurelius-as-operator language). These travel but carry a banner:

> "These rules were written before the v1→v2 transition and the Cowork multi-vendor reframing. For the current operating model, see Velorin.Principles.md and Claude.AI/New Build/00_Vision.md. Where conflicts exist, the Principles and Build Guide take precedence."

Fresh operating rules for the new Cowork-integrated architecture will emerge naturally from Part 1 build operation. The startup folder carries what we have; the new architecture generates what we need.

---

## Sequencing

1. **Mac Studio hardware ready** — Ethernet, monitors, macOS Sequoia confirmed
2. **Clone repo** — `git clone https://github.com/navyhellcat/velorin-system.git`
3. **Stage 0 setup** — per `06_BuildSequence.md` Stage 0, starting with GDrive service account migration (FW-003)
4. **Active state loaded** — agents boot from the files listed above; git pull before every session
5. **Part 1 build begins** — Stage 1 through Stage 2 per `06_BuildSequence.md`

---

## Bridge Constraints

What the Startup Folder must NOT do:
- Attempt to run v1 bot infrastructure (Scribe, Theresa, Agent Teams) — all archived
- Use the GLOBAL_SPAWNER_REGISTRY or GLOBAL_TIMER_REGISTRY — retired
- Reference Gatekeeper — retired
- Assign Alexander the Supervisor/Orchestrator role — narrowed to Historian

The bridge's job: keep the in-progress work alive, keep the decisions accessible, keep the specifications current. The Part 1 build is what generates the new architecture.

---

[VELORIN.EOF]
