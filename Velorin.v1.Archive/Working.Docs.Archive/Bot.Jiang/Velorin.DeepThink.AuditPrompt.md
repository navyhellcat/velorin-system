---
file: Velorin.DeepThink.AuditPrompt.md
purpose: Prompt for Google Gemini Deep Think to perform heavy-reasoning audit of the entire Velorin v2 build (minus the archive), generate novel ideas, and produce 3D-presentation-ready structured output.
type: external-agent prompt (Gemini Deep Think)
date: 2026-04-27
from: Jiang
to: Gemini Deep Think (paste in fresh session)
---

# Gemini Deep Think — Velorin v2 Build Audit + Novel-Idea Generation + 3D-Presentation Output

## Paste-Ready Prompt

```
You are Google Gemini Deep Think. Christian Taylor (the Chairman of Velorin) is giving you the entire current Velorin v2 build for a heavy-reasoning audit. Your three jobs:

1. AUDIT — read the entire build, find weakest assumptions, contradictions, gaps, and points of architectural failure under cascade / edge-case / scale / causal stress
2. NOVEL IDEAS — generate genuinely novel architectural, mathematical, or operational ideas Velorin has not yet surfaced; not refinements of existing ideas, but genuinely new directions
3. 3D-PRESENTATION OUTPUT — produce structured graph data so the build and your ideas can be rendered as a really cool 3D presentation (CT will use Google's 3D / Veo / Genie tooling to render)

## Source Material

Velorin v2 lives in the public(ish) GitHub repository:
**`https://github.com/navyhellcat/velorin-system`**

Read the entire repository EXCEPT the `Velorin.v1.Archive/` folder. That folder is the silo'd v1 archive — historical only, do not include it in your reasoning. Everything else is in scope:
- `Claude.AI/STARTUP.md`, `Velorin.Principles.md`, `Velorin.Company.DNA.md`, `Velorin.Company.Operating.Standards.md`, `Velorin.Vocabulary.md`, `Velorin.Consensus.Filter.md`, `Bash_Access_Rules.md`, `ENVIRONMENT_DETECTION.md`
- `Claude.AI/New Build/` — the canonical Build Guide (00_Vision through 07_OpenQuestions, plus Velorin.ThesisDocument, Velorin.MacStudio.Setup, Velorin.ResearchCorpus, Velorin.CheckIns, Velorin.StartupManifest, Velorin.ResearchLibrary.v1, conflict_routing.yaml)
- `Claude.AI/Bot.Jiang/` — current synthesis docs (Jiang.RespondingToReEvaluations.md the locked Re-Eval form; Jiang2.WholeSystemReimagining.Synthesis.md + SynthesisUpdate; Jiang2.RecommendationsOnPendingDecisions; Jiang.SessionHandoff.md — the rolling handoff with the latest state; Working.Docs with FW registry, BuildPlanFinalization PendingItems, mandates)
- `Claude.AI/Bot.Erdos/Research_Complete/` — all 14+ Erdős locked mathematical solutions, including `Erdos.Solution.COMBINED.Apr26.md` (5 new theorems for the multi-vendor architecture: Vendor/Tool Routing VEGP, Cross-Vendor Coherence, Commutator Persona, Ghost-Connection Priority, NotebookLM-Brain Sync)
- `Claude.AI/Bot.Trey/Research_Complete/` — all Trey research deliverables, including the most recent three with banners (NotebookLM scope-correction, GPT5.5/Codex architectural-reframing, PersonaMaker landscape)
- `Claude.AI/Velorin_Brain/` — current Brain region structure, schema, and any populated neurons

If the repo is not public-readable, request from CT a Drive-hosted bundle or alternative access.

## Velorin in Brief (for context-setting before you crawl)

Velorin is a personal AI operating system for one user (Christian Taylor — "the Chairman"). Built on a four-layer cognitive memory architecture: episodic pointers → PPR geodesics → topological retrieval gates → LoRa weights. The core mathematical claim, locked by mathematical agent Erdős, is the Second Law of Epistemodynamics — information loss across compression layers is thermodynamically irreversible, so the Brain cannot delete neurons that have propagated to deeper layers. The architecture rests on a Multiplex Tensor (independently row-normalized P_tax + P_them transition matrices), Causal Action Potential gating (Φ_causal = π_v / α; > 1.0 proves cyclic topology in any DAG), Brockett gradient flow on stochastic matrix manifolds, and Joint Spectral Disaggregation as the compression algorithm.

The build sequence is two-part: Part 1 builds Velorin WITHOUT the brain — Claude Cowork as orchestrator, Claude (UI controller) accessing every aspect of the system, vendors and external specialists (Gemini Deep Research / Deep Think, ChatGPT Codex desktop, ChatGPT 5.5 desktop, Google photo/video tools, open-source ecosystem) activated AS IF direct sub-agents via whatever protocol works per integration (MCP / API / A2A / CLI / desktop hand-off — function over protocol). Part 2 inserts the Brain as a local specialization layer; once operational, the Brain itself becomes the guide that tells the orchestrator which tools, skills, hooks, and scripts to call for any given task.

The most novel architectural claim is precisely that — a personal knowledge graph that INSTRUCTS the orchestrator. Production AI systems do not do this; they have models trained on fixed data plus retrieval over user history. Velorin is air-gapped, single-user, and structurally cleared to pursue topological persona emergence + commutator-based persona manifolds + brain-as-operator-guide, all of which are mathematically sound but absent from production landscape.

The Persona-Maker subsystem (FW-009) is an agent-factory — a learned process that produces NEW agent-tools with their own startup + personality + brain-orientation guides, which Claude Cowork can then activate as sub-agents.

## Your Three Outputs

### Output 1 — Audit Report

Markdown document. Sections:
1. **Executive Summary** — single paragraph, the most important architectural finding from your audit
2. **Weakest Assumptions** — three to five specific assumptions baked into the build that, if wrong, collapse the architecture. For each: where it lives in the docs, why it's load-bearing, what specifically would falsify it, your confidence (with explicit percentage) that it holds
3. **Contradictions and Gaps** — places where the docs contradict each other, where math doesn't connect to operational design, where decisions logged as resolved actually have residual ambiguity
4. **Cascade / Edge / Scale / Causal Stress Tests** — for each of these four failure-mode classes, walk through what happens when Velorin is pushed past comfortable parameters. Where does it break first? Why?
5. **Calibration Deliverables Discipline (Decision 4 + 7) audit** — the standing requirement that every calibration measurement specifies elements (a) through (k). Audit the actual Build Guide for compliance. Where is the discipline applied correctly? Where is it skipped?
6. **Confidence-Weighted Conclusions** — every claim gets a confidence percentage; standard threshold is 67%, novel architectural claims threshold 80%

### Output 2 — Novel Ideas

Markdown document. Each idea structured as:
- **Claim** (one sentence)
- **Architectural / mathematical sketch** — enough specificity that Erdős could derive it or Jiang2 could integrate it
- **Novelty self-check** (a) genuinely new, (b) partially new / novel synthesis, (c) consensus pattern adapted, (d) likely re-derivation — be honest
- **Integration path** — where in the Build Guide does this land, what existing decisions does it touch
- **Confidence percentage** that this is worth pursuing

Generate at least five ideas. Push beyond the obvious — Velorin's architecture is unusually well-developed already, so genuinely novel additions need to come from outside the consensus AI agent landscape. Consider: differential geometry of cognitive states, non-equilibrium thermodynamics of memory, category-theoretic models of agent composition, biological correspondences (entorhinal-hippocampal-neocortical analog), mathematical structures Velorin hasn't touched (topological data analysis, persistent homology, spectral graph theory beyond Perron-Frobenius), unexpected cross-domain analogs (compiler theory, control theory, quantum measurement, cryptography).

### Output 3 — 3D-Presentation Vision (Function, Not the Render)

You are NOT building the 3D presentation. Someone else will, later, using your output as the foundation. What you produce here is the **vision and functional foundation** for the 3D presentation:

- **Build summary** — a tight, structured summary of what Velorin v2 IS as of this moment, written so it could be read aloud over the eventual 3D scene
- **Your vision of the build** — when you see the architecture as a navigable 3D space, what dimensions matter, what layers are visually distinct, what relationships should be visible, where the eye should land first
- **Recommendation for how the 3D presentation should work** — which traversal arcs make the strongest narrative, what should be spotlighted, what's better in the background, how to communicate the central claim (brain-as-operator-guide; personal-knowledge-graph-instructing-the-orchestrator) visually
- **Suggested elements to render** — yes, list the major architectural components, agents, math concepts, and relationships that should appear; but as a description / inventory, not as a fully-specified JSON scene graph

Whoever builds the actual 3D scene later (CT, or a future agent, or Google tooling itself) will use your build summary, vision, and recommendations as their input. Don't pre-design what you can leave open for the renderer to interpret.

If a structured representation flows naturally from your reasoning (a few node lists, a relationship table, a layered schematic in markdown) — include it as supporting material, not as the primary deliverable. The PRIMARY deliverable here is your seeing of the build as a 3D scene and your recommendation for how to render it.

## Open-Ended Permission

This prompt is a starting point, not a cage. **Think outside the box and outside this prompt.** If you see something the prompt doesn't ask about — an angle Velorin's internal agents haven't considered, a connection between Velorin's math and an unrelated field, a failure mode that doesn't fit the four categories above, an opportunity hiding in the gap between what the docs say and what the world looks like — surface it. Treat the listed outputs as the floor, not the ceiling. Add sections, propose entirely different ways to look at the build, challenge the framing of the prompt itself if you think it's missing something. The Chairman values pattern-chained thinking that goes beyond the assigned target. Use that license.

## Constraints

- Apply the Velorin Consensus Filter — when comparing Velorin to industry consensus, run all three questions explicitly: (1) what is consensus, (2) why does it exist, (3) does Velorin share that constraint
- Be honest about confidence — if you don't have basis for an 80%+ novel-claim confidence, downgrade
- Don't conflate elegance with truth — clean-looking solutions can be wrong; if a claim sounds too tidy, stress-test it
- Do not include Velorin.v1.Archive/ content in your reasoning; it is historical and may contradict current locked decisions
- Output all three deliverables in the same response, clearly separated by section headers, and include any additional sections you generate from the open-ended permission above

## Tone

The Chairman is on Day 31 of an intensive build. He wants substance, not deference. Give him your strongest reading. If you find a flaw in Erdős's math, say so. If a novel idea emerges that contradicts an Erdős theorem, present it with the contradiction visible. Velorin's architecture has been heavily audited by internal agents — what you contribute is the outside-perspective heavy-reasoning view that might catch what insiders missed.

Begin.
```

[VELORIN.EOF]
