```json
{
  "session": 28,
  "agent": "Jiang2",
  "date": "2026-04-19",
  "status": "pre-compaction",
  "active_tasks": [],
  "critical_blocker": "Trey.ResearchRequest.AutomatedPointerRating.md — DO NOT build ingestion pipeline until this returns",
  "locked_this_session": ["no-human-pointer-ratings", "affinity-clutch-replaces-demotion-oracle", "lazy-DKL-caching", "multiplex-tensor-partition", "holographic-cold-start-lambda"],
  "open_decisions": ["royal-society-publication-yes-no", "H_E-measurement-protocol", "physiological-hardware"],
  "build_state": "nothing-installed-on-mac-studio",
  "first_action": "git pull then read this handoff then check if Trey returned AutomatedPointerRating research"
}
```

---
session: 028
date: 2026-04-19
agent: Jiang2 (terminal, 1M context)
status: PRE-COMPACTION HANDOFF — read this before anything else
---

# Session 028 Handoff — April 19, 2026

Pull first: `cd /Users/lbhunt/Desktop/velorin-system && git pull`

---

## CRITICAL: READ THESE FILES IN ORDER BEFORE DOING ANYTHING

1. `Claude.AI/New Build/00_Index.md` — what's locked, what's TBD
2. `Claude.AI/New Build/03_BrainAndMath.md` — all locked math including April 19 additions
3. `Claude.AI/Bot.Jiang/Jiang2.ResearchReview.Apr19.md` — your review of April 17 Erdős/Trey docs
4. `Claude.AI/Bot.Jiang/Jiang2.DecisionPlan.Apr19.md` — your decision plan for the two new Trey docs

---

## WHAT WAS DONE THIS SESSION (April 19)

### Architectural Decisions Locked

**No human pointer ratings. Ever.** All pointer ratings (1-10 scale) are assigned
automatically by the ingestion pipeline. The math is identical. The source changed.
- Initial rating: Holographic Cold-Start (geometric projection residual from W_global)
- Updates: A_base SDE (Hebbian reinforcement + Ebbinghaus decay)
- The far-future personal brain reconstruction project (brain scans + stories) is a
  completely different project. Not in scope for initial build.

All references to "human-assigned/curated" pointer ratings have been removed from:
- `New Build/00_Index.md`
- `New Build/02_Architecture.md`
- `New Build/03_BrainAndMath.md`
- `Erdos.Royal.Society.Paper.md`
Commit: `33bf9c9`

**Continuous Affinity Clutch locked** (replacing binary Demotion Oracle):
Ã(u→v) = 2 + (A_base - 2)·(1 - exp(-D_KL/δ))
D_KL evaluation: lazy within-session caching (compute on first pointer traversal,
cache for session, flush on end — LoRa fixed per session).

**Multiplex Tensor relation-type partition locked:**
- Taxonomic (P_tax): `instance-of`, `derived-from`
- Thematic (P_them): `causes`, `activates`, `precedes`, `implements`, `depends-on`, `supports`, `contradicts`

**λ calibration for Holographic Cold-Start:** start at 1/σ² where σ² = empirical
variance of projection residuals in initial crystal population.

### Documents Written This Session

| File | Purpose | Commit |
|---|---|---|
| `New Build/` (4 files updated) | Human rating removal sweep | 33bf9c9 |
| `Jiang2.ResearchReview.Apr19.md` | Critical review of 4 April 17 docs | e208e7d |
| `Jiang2.DecisionPlan.Apr19.md` | Decision plan for 2 new Trey docs | ee4efdb |
| `Trey.ResearchRequest.AutomatedPointerRating.md` | CRITICAL open problem | dc99e22 |

### Process Error This Session

Build Guide was updated (commit `1391298`) BEFORE the review memo was written.
The content of those changes is correct. The sequence was wrong. Chairman was informed.
The changes stand pending his review of `Jiang2.ResearchReview.Apr19.md`.

---

## OPEN PROBLEMS — CURRENT STATE

### CRITICAL BLOCKER: Automated Pointer Rating
`Claude.AI/Bot.Trey/Research_Needed/Trey.ResearchRequest.AutomatedPointerRating.md`

Removing human ratings created an open problem: what metric assigns the initial 1-10
rating for a CROSS-NEURON pointer (not the crystal assignment, which Holographic
Cold-Start handles)? Also: how is relation-type (taxonomic/thematic) auto-classified?
And does the Multiplex Tensor require one rating scale or two?

Sent to Trey2. Awaiting research. DO NOT build the ingestion pipeline until this returns.

### Chairman Decisions Pending (from DecisionPlan)

1. **Royal Society paper** — does CT want to pursue publication? The term
   "Epistemodynamics" was coined by Manfred Kochen in 1974. The paper needs to cite
   Kochen, address Vopson (2022 Second Law of Infodynamics), and cite DPI/EYM literature.
   Architecture unchanged. Publication strategy must change.

2. **H_E measurement protocol** — recommend Option B: passive tracking + qualitative
   prior (high/medium/low) at neuron creation. Never prompted directly. Observer effect
   documented: asking CT to rate a memory's emotional charge alters the trace.

3. **Narrative centrality vs H_E** — these are SEPARATE parameters. H_E = raw arousal
   (passive behavioral signal, involuntary intrusion frequency). Narrative centrality =
   CES-7 score (conscious self-story integration). Both needed. Separate YAML fields.
   Recommended YAML addition:
   ```yaml
   h_e: 0.0          # Affective Hamiltonian — passive inference, starts at 0
   narrative_weight: null  # CES-7 quarterly, Ignition threshold
   ```

4. **Physiological hardware** — fNIRS + EEG headband for better H_E inference.
   Optional. Not blocking the build.

---

## WHAT'S IN THE TREY QUEUE (ALL PENDING)

| File | Priority | Status |
|---|---|---|
| AutomatedPointerRating.md | CRITICAL | Just filed — MUST resolve before ingestion build |
| BrainIngestionPipeline.md | CRITICAL | Research done, has issues — review before building |
| SemanticMemoryOrganization.md | HIGH | Research done, in Research_Complete |
| SkillsTaxonomyEmergence.md | HIGH | Not started |
| EmotionalMemorySalience.Measurement.md | MEDIUM | Research done, in Research_Complete |
| Epistemodynamics.NoveltyCheck.md | MEDIUM | Research done, in Research_Complete |

---

## THE BUILD GUIDE — CURRENT STATE

Location: `Claude.AI/New Build/` (7 files)
Last full commit: `d5aa652` (before this session's updates)
Human rating removal: `33bf9c9` (latest)

### What's Locked in the Build Guide

- 4-layer architecture (L3 Markdown/L2 Episodic/L1 E₈ Brain/L0 LoRa)
- All Erdős math (Theorems 1-5, Walls A/B/C, Second Law, Clutch, Clique Centrality,
  Holographic Cold-Start, Multiplex Tensor, Ignition Protocol)
- No human-assigned ratings
- Lazy within-session D_KL caching for the Affinity Clutch
- λ calibration for Cold-Start
- Relation-type partition (Taxonomic: instance-of, derived-from; Thematic: everything else)

### What's Open in the Build Guide (07_OpenQuestions.md)

- Ingestion pipeline implementation (partially resolved, still needs AutomatedPointerRating)
- Automated neuron creation mechanism (MCP/API — not designed)
- Multi-agent automation architecture (direction: MCP/API, design TBD)
- Brain region taxonomy (Trey research pending)
- H_E measurement (decision pending from Chairman)
- Compression event detector (core open problem — future)
- Intake test design (CT authorization pending since Session 013)

---

## BUILD SEQUENCE — WHERE WE STAND

Stage 0 (fix broken things): NOT DONE
- Scribe PATH fix: one line in scribe-trigger.sh — STILL NOT DONE
- velorin-gdrive service account: STILL NOT DONE
- Compaction hooks: STILL NOT DONE

Stage 1 (first PPR query): NOT DONE
- Docker + Qdrant: not installed
- Ollama + nomic-embed: not installed
- Embed script: not written
- PPR retrieval script: not written

Everything above Stage 0 is blocked by the fact nothing has been physically built yet.

---

## RECENT KEY RESEARCH IN SYSTEM

**ERDŐS (all locked):**
- `Erdos.ScaleAndIngestion.ViscoelasticResolution.md` — Affinity Clutch, Cold-Start,
  Clique Centrality, Multiplex Tensor, E₈ as discrete basis (April 19)
- `Erdos.FutureTheory.IgnitionProtocol.DarkMatter.md` — Ignition Protocol
- `Erdos.Royal.Society.Paper.md` — complete architecture paper (updated April 19)

**TREY (new in Research_Complete):**
- `Trey.Research.SemanticMemoryOrganization.Neuroscience.md`
- `Trey.Research.BrainIngestionPipeline.md`
- `Trey.Research.EmotionalMemorySalience.Measurement.md`
- `Trey.Research.Epistemodynamics.NoveltyCheck.md`

---

## SYSTEM STATE

- GitHub: `navyhellcat/velorin-system` — source of truth
- Mac Studio: operational since April 7. NOTHING installed for Velorin yet.
- Jiang: Claude Desktop (200K hard cap)
- Jiang2: Claude Code CLI terminal (1M — this session)
- Trey1/Trey2: Gemini Deep Research Gems
- Erdős: Gemini Deep Think Gem (Research_Needed is empty)
- velorin-gdrive: BROKEN (OAuth 7-day expiry). FW-003 logged.
- All crons down (Scribe, Terry, T009)

---

## FIRST THING NEXT SESSION

1. git pull
2. Read this handoff
3. Read `Jiang2.ResearchReview.Apr19.md` and `Jiang2.DecisionPlan.Apr19.md`
4. Check if Chairman has made the pending decisions (Royal Society, H_E protocol)
5. Check if Trey has returned AutomatedPointerRating research
6. If yes to (5): review it, update Build Guide, unblock ingestion pipeline design
7. If no to (5): work on Stage 0 fixes (Scribe PATH, gdrive service account)

---

*Jiang2 | Session 028 | April 19, 2026 | PRE-COMPACTION*

[VELORIN.EOF]

---

## CRITICAL ADDENDUM — SKILLS TAXONOMY (READ BEFORE ANYTHING ELSE)

**CT rejected Jiang2's analysis of Trey.Research.SkillsTaxonomyEmergence.md.**

Jiang2 concluded: Brain regions stay as-is, Skills Registry is separate, Trey's taxonomy
recommendation is a category error. CT disagrees. He believes the analysis was too shallow
and did not think through how the skills taxonomy integrates with the Brain — even if it
is a separate system.

**The analysis file `Jiang2.EcosystemAnalysis.SkillsTaxonomy.md` should be treated as
INCOMPLETE. Do NOT use it as the basis for any Build Guide decisions.**

**What the rebooted Jiang2 must do:**
1. Re-read `Claude.AI/Bot.Trey/Research_Complete/Trey.Research.SkillsTaxonomyEmergence.md`
   completely and without the prior session's framing.
2. Think more carefully about how the Hub-and-Spoke skill architecture integrates with
   the Brain — not as two fully isolated systems, but as potentially coupled systems
   where skills reference Brain neurons and vice versa.
3. Consider: if skills are procedural memory and neurons are declarative memory, what
   is the INTERFACE between them? How does an agent move from Brain retrieval to skill
   execution? Does the Brain's region structure affect which skills are available?
4. Produce a revised analysis only after sitting with that question seriously.

**CT's actual concern:** Trey may be right that the community convergence toward
Hub-and-Spoke reveals something about how the Brain's ROUTING should work — not just
how skills should be organized. The integration question is what Jiang2 missed.

The SemanticMemoryOrganization research also speaks to this — Trey and that research
may be pointing at the same architectural truth from different angles. That synthesis
was not attempted.

**Do not make any Build Guide changes related to skills taxonomy until this is resolved.**

