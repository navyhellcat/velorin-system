---
file: Jiang2.TransitionalDecisions.Pt1.md
from: Jiang2
date: 2026-04-25
purpose: Snapshot of synthesis second-half — publication strategy, build sequence, holes,
         edge ontology unification — preserved verbatim from synthesis output with
         dependency annotations layered on top. Do NOT edit substantive content here.
         Revision will occur in Phase 4 after Re-Eval responses are reviewed by Chairman.
status: PROVISIONAL — awaiting Phase 2 re-evaluation outcomes before any content is finalized
---

# Jiang2 Transitional Decisions — Part 1: Second Half of Synthesis (Snapshot)

---

## Publication Strategy / Royal Society Paper Reframe

**Depends on Re-Evals:** #4 (VEGP novelty validation — must verify before elevating as lead claim), #5 (Dark Skills overclaim corrected)
**Status:** Provisional — paper reframe cannot be finalized until VEGP novelty validation (Trey) and VEGP isomorphism stress-test (Erdős) return.

---

From synthesis output verbatim:

The current Royal Society paper positioning is vulnerable on three fronts identified by `Trey.Research.Epistemodynamics.NoveltyCheck.md`:
1. "Epistemodynamics" coined by Manfred Kochen in 1974 — claiming lexical novelty will fail peer review
2. "Second Law of Epistemodynamics" collides directly with Vopson's "Second Law of Infodynamics" (2022) — must be cited, contrasted, differentiated
3. DPI + Eckart-Young are established tools — Velorin's synthesis is novel, not the tools

The VEGP finding changes the viable paper framing: instead of leading with the Second Law as the top-level claim, lead with the Dirac-Markov Threshold as a unified gating primitive across AI architectural layers. The Second Law becomes one instantiation of the VEGP at the Memory→Compression boundary. The Brain architecture (E₈, PPR, Multiplex Tensor) is the substrate where VEGP operates.

Revised paper structure:
1. Establish VEGP as novel claim — the unified threshold structure governing Brain→Skill, Reasoning→Conclusion, and Memory→Compression boundaries simultaneously
2. Instantiate at Memory→Compression: the Second Law of Epistemodynamics follows from DPI + Eckart-Young as a specific VEGP case where deletion of the episodic record destroys the only lossless representation
3. Cite Kochen (1974) on the term; cite Vopson (2022) and contrast
4. Cite DPI and EYM as established tools; claim the synthesis topology as novel

This reframe is stronger and survives peer review. The current framing doesn't.

---

## How V2 Moves Forward

**Depends on Re-Evals:** #1 (belief_state / conflict resolution mechanism), #2 (IES selective adoption — structural mechanism unspecified), #3 (Standing Principle sweep on deferral language), #4 (VEGP — if novelty unvalidated, Build Guide entries need caveat), #6 (ATV — not evaluated before endorsement), #7 (CT-personal assumption in build steps)
**Status:** Provisional — build sequence references ATV (Re-Eval #6 unresolved), belief_state with "until CT resolves" (Re-Eval #1 mechanism not specified), and user-personalization framing (Re-Eval #7 unresolved). Phase-gating decisions need Standing Principle sweep.

---

From synthesis output verbatim:

**The immediate blocker that isn't in the build sequence:**

The Build Guide is stale. Sessions 032-035 produced architecture decisions that live in research memos and Erdős proof documents. None is in `Claude.AI/New Build/`. An agent booting from the Build Guide alone is operating from April 17 specs, missing: independent row-normalization, neuron schema additions (belief_state, authority_tier, source_coords, 9-class relation label, skill_ref), typed pointer labels, VEGP as unified primitive, skills schema 4-type edge structure, Docling removal, OpenDataLoader adoption, θ_work spectral band, IES selective implementation.

Before writing any code, the Build Guide update is the highest-leverage action.

**Critical path:**

```
Step 0a: Build Guide update — lock all new math and schema decisions
  Depends on: CT approval of neuron YAML additions + skills schema
  Unblocks: everything downstream

Step 0b: Stage 0 fixes (parallel with 0a)
  - Scribe PATH fix (one line, needs sudo approval)
  - GDrive service account migration — FW-003, recurred twice, HIGH priority
  Unblocks: porting workflow, compaction hooks

Step 1: Mac Studio base stack
  Docker → Qdrant; Ollama → nomic-embed + Qwen 3.6 + Qwen2.5-VL
  Unblocks: Steps 2, 3, 4

Step 2: OpenDataLoader fork + first embed + PPR query
  Depends on: Step 1
  Unblocks: ingestion pipeline

Step 3: Skills schema v2 + pilot skills
  - skills_dependencies.yaml with 4-type edge schema (not flat YAML — Re-Eval noted)
  - Pilot skills with typed artifact schemas
  - skill_ref in procedure neuron YAML (null for non-gateways)
  Depends on: Step 0a
  Unblocks: TAP runtime

Step 4: Ingestion pipeline v1
  - OpenDataLoader → RDoLT → NPMI + LLM-judge (forced distribution, 9-class required)
  - belief_state + authority_tier + source_coords in YAML from day 1
  - Git post-commit edge handler for belief_state mutations
  Depends on: Steps 1, 2, 0a

Step 5: TAP skill injection runtime
  - PPR walk → Φ(v) computation → reverse-PPR on skills dependency graph → header push
  - Asymmetric Transport Verifier (local Qwen as constrained verifier for IES enforcement)
  Depends on: Steps 3, 4, θ_work provisional 0.5

Step 6: θ_work empirical calibration
  Depends on: Brain populated with ~750+ labeled queries
  Non-blocking: 0.5 provisional is within spectral band
```

**Phase-gating commitments from synthesis (need Standing Principle review in Phase 2):**
- 9-class relation labels: REQUIRED from Step 4 day 1. Commit.
- Skills typed edge schema: REQUIRED before Step 3. Commit.
- CRAG: DROPPED permanently.
- RoMem Semantic Speed Gate: DEFERRED to Stage 2. Reasoning: requires Layer 0 LoRa.
- belief_state / authority_tier: REQUIRED from Step 4 day 1. Commit.
- Git post-commit edge handler: REQUIRED before Step 4. Engineering task for MarcusAurelius.
- GoS sparse validation: DEFERRED. Reasoning: dense is fine at <100 skills. [STANDING PRINCIPLE REVIEW NEEDED — Re-Eval #3]
- ATV: Stage 1 / near-term build. [RE-EVAL #6 UNRESOLVED]

---

## Holes That Need Filling

**Depends on Re-Evals:** #1 (conflict resolution mechanism needs specifying before edge handler spec), #6 (ATV implementation spec is pending evaluation), #3 (Standing Principle determines whether ontology reconciliation must happen before pipeline)
**Status:** Provisional.

---

From synthesis output verbatim:

**1. Git post-commit edge handler spec** — `infrastructure/hooks/post-commit-edge-handler.sh` — nobody has written this. KnowledgeStaleness research specifies what it should do; the implementation doesn't exist. This is an engineering spec task that must happen before ingestion pipeline v1 can manage belief states automatically.

**2. Asymmetric Transport Verifier implementation spec** — Trey provided the architecture; the spec (model, hosting, constrained grammar, interception point in the communication bus) hasn't been written. Before Step 5 can be built, someone needs to spec this.

**3. The 9-class label vs. 4 GoS edge type reconciliation** — The Brain's 9 relation types and GoS's 4 edge types cover the same conceptual territory from different angles. These should be reconciled into a unified edge ontology that works across both the Brain pointer graph and the skills dependency graph. Nobody has attempted this.

**4. What would resolve θ_work faster than waiting for 738 queries in production?** — Synthetic labeled queries constructed from the first batch of neurons. When the ingestion pipeline creates its first 50 neurons, construct 738 synthetic queries by: take a neuron, construct 10 thematic queries that should surface it, 10 taxonomic queries that should not, record Φ values, label correctness. This compresses the calibration timeline from months to days.

---

## The Thing Nobody Asked About — Edge Ontology Unification

**Depends on Re-Evals:** #7 (user-personalization scope may affect whether unified ontology is CT-scoped or user-agnostic)
**Status:** Provisional but likely survives any directional outcome from Re-Eval #7.

---

From synthesis output verbatim:

The Brain's 9-class relation labels and GoS's 4 edge types describe the same cognitive architecture at different levels. The Brain tracks declarative relationships. The Skills graph tracks procedural relationships. But at the mathematical level, both are typed directed graphs traversed by PPR. The same post-commit hook infrastructure, the same edge typing rationale, the same schema management patterns apply to both.

This has a concrete implication: when we build the Git post-commit edge handler for neuron belief_state updates, it should also handle skill dependency graph updates. One hook, two graph substrates. And the edge ontology should be unified from the start — not two separate schemas that accumulate independent design decisions and later need reconciliation.

Proposed mapping (sketch, not locked):
- Brain taxonomic (instance-of, derived-from) → GoS dependency edges (producer→consumer prerequisite)
- Brain thematic (causes, activates, precedes, implements, depends-on) → GoS workflow edges (logical co-occurrence sequences)
- Brain (supports, contradicts) → GoS semantic edges (conceptual overlap, bidirectional)
- GoS alternative edges → Brain has no direct analog; this is skills-specific (mutual exclusion in execution paths)
- Brain supersedes, contradicts (temporal/conflict) → no GoS analog; Brain-specific for knowledge lifecycle management

This is a design question worth resolving before either the ingestion pipeline or skills schema is finalized.

---

[VELORIN.EOF]
