# Velorin V2 — Final Build Guide
**Produced by: Jiang2 | Finalized April 26, 2026 — FW-013 trigger**
**Status: Authoritative. Reflects all locked decisions through Session 037.**

**→ Start with `00_Vision.md`.** That is the front door — what Velorin IS, the two-part build process, where we are headed, and why. Read it before anything else.

**→ Before starting any build work: read the "DECISIONS TO BE MADE" section at the bottom of `06_BuildSequence.md`.** 5 ideas that need CT's decision before Stage 0 begins. Use community consensus, math, and research to evaluate. Lock them, then build.

This index lists all Build Guide files. Everything else is navigable from `00_Vision.md`.

---

## Files in This Folder

| File | Contents |
|---|---|
| `00_Vision.md` | **START HERE** — Vision, Process, Where Headed, Why |
| `01_RepoAndEnvironment.md` | Day 0: Mac Studio setup, new repo, folder structure, MCP configuration |
| `02_Architecture.md` | The 4-layer memory system, CAP gate, JSD compression, skills architecture |
| `03_BrainAndMath.md` | Neuron format, all locked Erdős math, PPR, E₈, contradiction_class taxonomy |
| `04_AgentEcosystem.md` | Jiang, Alexander (Historian), Trey, Erdős, conflict resolution, Persona-Maker |
| `05_InfrastructureAndTools.md` | Cowork integration, ARC-1/ARC-2, ATV, tool-routing, skills, grammar management |
| `06_BuildSequence.md` | Executable step-by-step — Stage 0 through Stage 5 |
| `07_OpenQuestions.md` | What still needs research, math, or a decision |

---

## What This Is Building

A personal operating system for Christian Taylor. Not a productivity tool.
Not a chatbot. An architecture that makes every future AI interaction smarter
than the last because the Brain compounds.

The AI models (Claude, Gemini) are contractors — powerful, replaceable.
What persists across model swaps is the Brain: the accumulated, structured,
growing model of CT's knowledge, decisions, and cognitive patterns.

The moat is not the AI. The moat is what the Brain knows about CT.
That grows harder to replicate with every session.

**Founding Thesis:** Most operational work inside the Brain is done by deterministic
computer programs that produce repeatable outcomes without token use. AI's job is to
build, watch, check, and maintain those programs — not be the per-event operator.
Before any architectural recommendation: ask "Is this a program to build with AI as
watcher?" If yes, specify the program and define what AI watches.

---

## The Final Architecture at a Glance

```
Layer 0 — LoRa adapter        FUTURE: CT's cognitive patterns as model weights
Layer 1 — E₈ Brain            IMMEDIATE BUILD: PPR over neuron pointer graph
Layer 2 — Episodic graphs      DESIGNED: 240-node temporal KG per document
Layer 3 — Permanent archive    EXISTS: GitHub markdown files, never deleted
```

The immediate build is Layer 1 + Layer 3 infrastructure.
Layer 2 design is specified. Implementation follows Stage 1.
Layer 0 is future — depends on local AI model decisions not yet made.

---

## What Is Locked (Do Not Revisit)

**Architecture:**
- Second Law of Epistemodynamics: deletion forbidden past Layer 3. Demotion only.
- ρ* = 0.78: 78% of pointers must be high-priority (ratings 1-3) for PPR precision
- 7-pointer cap per neuron
- E₈ crystal structure: 240 neurons per crystal
- Independent row-normalization of P_tax and P_them (Erdős proof, Session 033)
- Direction C user personalization: `base_model_config: {type: "personal", id: "ct-v1"}`

**Gate Definition — Causal Action Potential (replaces TAP, Session 034):**
$$\Phi_{causal}(v) = \frac{\pi_v}{\alpha}$$
Identity-equivalent to E[N_v] (expected visits before teleportation).
Cyclic detection: Φ_causal > 1.0 proves a directed cycle exists (parameter-free, absolute).
Skill injection gate: Φ_causal(v) > θ_work AND M(v) = 0 (light skill).
Refund Fallacy: NEVER refund accumulated PPR mass on dark-flag transitions.

**Math:**
- Pointer Gravity (Laplacian Dual-Procrustes), Wall A
- Inter-Crystal Gauge Tensor, Wall B
- Crystal Mitosis (Fiedler Bisection), Wall C.1
- Alien Injection (W_global Fractal Projection), Wall C.2
- Ignition Protocol (emotional engagement → crystallization)
- Continuous Affinity Clutch (replaces binary Demotion Oracle)
- Clique Centrality Theorem (expert density self-protection)
- Multiplex Tensor with independent row-normalization
- Holographic Cold-Start for initial affinity assignment
- JSD (Joint Spectral Disaggregation) for compression — standard JBD mathematically impossible per Perron-Frobenius
- Brockett double-bracket gradient flow → commutator-norm fixed point is compression trigger
- θ_work spectral band: (0.375, 0.585] derived from ρ* and α

**Tools:**
- CLAUDE.md = GPS pointer only. Never instructions, never paths.
- ATV = Asymmetric Transport Verifier: Stage 1 build, IES enforcement at transport layer
- OpenDataLoader PDF v2.0 = PDF parser (replaces Docling), Apache 2.0
- Qwen2.5-VL 7B = local vision model for image/diagram extraction
- vllm-mlx = Apple Silicon inference backend for ATV verifier
- XGrammar = constrained decoding engine (replaces Outlines)

---

## What Is NOT Locked (Don't Build Around These Yet)

- Local AI model selection for inference (deferred to Stage 5)
- H_E (emotional charge) measurement and YAML field — research returned, protocol decision pending
- Multi-agent automation architecture (OQ-3, FW-004 trigger)
- Automated neuron creation mechanism (OQ-2)
- Session close protocol optimization (OQ-7)
- Compaction hooks (OQ-8 — design first, test before wiring)
- Intake test design (OQ-9 — blocked on CT authorization since Session 013)
- Canary rollout for grammar management (Stage 3 trigger: N≥5 agents, M≥100 msg/day, D≥14 days)
- RoMem Semantic Speed Gate (Stage 5 — requires Layer 0 LoRa operational)
- GoS sparse skill validation mode (Stage 3 — when skill library exceeds N skills)

---

## Deferral Discipline — Standing Principle

Defer implementation if and only if BOTH conditions are true:
1. Deferring has a concrete technical advantage over building now
2. The architectural seam is specified now so the deferred implementation plugs in easily later

If either condition fails → build now.

Every deferral requires THREE artifacts:
- **FW registry entry** — `agents/claude/jiang/working-docs/Jiang.FutureWork.md`
- **Check-ins entry** — in the build-wide Check-ins list in `06_BuildSequence.md`
- **Build-space placeholder** — in the appropriate phase of this Build Guide

---

## The Cardinal Agents

| Agent | Platform | Role |
|---|---|---|
| MarcusAurelius | Claude Code CLI | Infrastructure, git, MCPs, file routing |
| Jiang / Jiang2 | Claude Desktop / Terminal | Strategy, architecture, active session work |
| Alexander | Mac Studio Cowork | Company orchestration, cross-agent tracking |
| Trey (1 + 2) | Gemini Deep Research Gems | External research |
| Erdős | Gemini Deep Think Gem | Mathematical derivation |

---

[VELORIN.EOF]
