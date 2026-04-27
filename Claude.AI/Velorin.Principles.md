---
document: Velorin Principles (Architectural)
version: 2.0 (consolidated from Velorin.OS.Core.Principles.md v1.0 + cycle updates through Apr 2026)
date: 2026-04-26
status: ACTIVE — these govern all build decisions
companion-files:
  - Velorin.Company.DNA.md (identity)
  - Velorin.Company.Operating.Standards.md (process)
  - Velorin.Vocabulary.md (terminology)
---

# Velorin Principles

These principles are load-bearing. Every build decision in Velorin should be checked against them. A decision that violates a principle here requires explicit Chairman authorization and a documented reason — not just a workaround.

For company identity, see `Velorin.Company.DNA.md`. For operations, see `Velorin.Company.Operating.Standards.md`. For terminology, see `Velorin.Vocabulary.md`. This file is the architectural principles layer.

---

## Principle 1: GPS Over Map

Navigation uses stable pointers, not hard-coded destinations.

- Bot folders are referenced by name, not file paths
- Hooks point to behavior, not specific session files
- Neurons point to other neurons and skills, not specific file versions
- The thing being pointed AT can change. The pointer mechanism does not.

Test: if renaming a file requires editing more than ONE pointer, the system is using a map, not GPS. Find the redundant hard-coding and remove it.

---

## Principle 2: The Brain Is Separate

The navigation layer navigates. The Brain thinks. These are distinct systems connected by exactly one pointer per agent.

- Boot and navigation do not require Brain access
- The Brain is not loaded on every session — it is accessed on demand
- An agent that is fully booted and navigated is NOT yet in the Brain. It enters the Brain when it needs to think deeply.

Why: collapsing navigation and Brain means every boot loads the entire knowledge graph. Expensive, noisy, fragile. Separation means boot is fast and clean. The Brain activates only when needed and only the relevant region fires.

---

## Principle 3: Programs vs Program-Managers vs Operational AI

Three roles exist. Each operates within its own scope. Higher roles can build downward using established patterns. No role can modify the layer it is currently operating in.

- **Programs**: deterministic code. Health monitors. Registry systems. Replacement logic. Ingestion pipelines. No AI in the execution loop. Runs the same way every time.
- **Program-managers (elevated AI)**: read and write programs. System architects. NO operational role. Never use the programs they manage. Build new programs using established patterns.
- **Operational AI (named agents)**: Jiang, Jiang2, Alexander, future named agents. Use programs. Read registries. Navigate via GPS. Cannot modify their own infrastructure directly — propose changes upward to program-managers.

Note: the prior "Tier 1 / Tier 2 / Tier 3" naming and the MarcusAurelius role have been retired in the v1→v2 transition. The principle of separation between deterministic programs, AI-as-builder, and AI-as-operator persists under the new vocabulary.

---

## Principle 4: Self-Extending Vision

Velorin builds new subsystems using its own OS. The substrate must be correct because everything inherits its shape.

When Velorin one day identifies a new domain (e.g., anti-aging research), it builds:
- A new Brain region with areas and neurons
- A new agent folder with GPS structure if a dedicated agent is needed
- New skills discovered from the registry
- New programs specific to the domain
- New hooks for the subsystem's needs

All of it uses the same GPS, same Brain, same skill registry, same patterns. Self-extension is the goal. Until the substrate is proven stable, extensions require Chairman authorization (lightweight — "yes, go") and a Steel Man pass before build begins.

---

## Principle 5: Programs Are the Foundation, AI Rides on Top (Founding Thesis)

AI systems that rely on AI judgment for infrastructure decisions are fragile. Deterministic programs are the foundation. AI's job is build / watch / check / maintain — not be per-event operator.

- The health monitor is a script, not a prompt
- Recurring checks are cron jobs, not agents deciding when to check
- Registries are structured files with schemas, not neurons
- Resolution sequences (flag → find → pass → replace) are code, not conversation

Gating question before any architectural recommendation: *is this a program to build with AI as watcher?* Many monitor / decide-per-event recommendations collapse into program + AI-audit pattern.

---

## Principle 6: GitHub Is the Universal Mirror

GitHub is the source of truth AND the universal access point.

- Local disk mirrors GitHub (cache, not source)
- Multi-vendor cowork agents (Claude, GPT 5.5, Gemini, Codex) all reach GitHub directly
- The "cross-platform problem" is solved by this mirror — no separate per-platform versions

Rule: everything important must be on GitHub. Local-only files are caches, not sources of truth. Push before every session close. Pull before every session start.

---

## Principle 7: The Five Boxes Frame All Decisions

Velorin is the Chairman. It serves all Five Boxes. The OS is the orchestration layer across them — not a separate project.

- Box 1 — Professional/Income: Camfil + AI tools toward independence
- Box 2 — Financial: Freedom from leverage. Algorithms, revenue, real estate
- Box 3 — Health: Physical and mental baseline. Non-negotiable prerequisite
- Box 4 — Personal/Relationships: The significance container
- Box 5 — The Commons: Botted professional services eliminating friction

Build priorities flow from these. Box 2 can build and ship independently of the OS. Box 1 uses the OS but doesn't wait for it to be complete. Building the OS is building Velorin's coordination capability across all five boxes — not an abstract infrastructure project.

---

## Principle 8: Multi-Vendor Cowork at Frontier (NEW for v2)

Claude is the foundation. Claude is not the ceiling. The v2 system runs Claude + GPT 5.5 + Codex + Gemini + Google Suite + NotebookLM + open-source tools as integrated cowork on Mac Studio. The UI controller (probably Claude) accesses every aspect of the system; vendor selection per task is a routing decision, not a loyalty decision.

Architectural test: any recommendation that assumes a single-vendor execution model is now stale. The forward operating model is multi-vendor cowork at frontier. See `feedback_opus_47_solution_drift.md` for the model-level reasoning behind this principle (Opus 4.7 regression on cascade / edge-case / scale / causal reasoning made the single-vendor risk concrete).

---

## Steel Man Issues — Standing

These were unresolved when Velorin OS Core Principles v1 was written (Session 021); status updated for v2:

1. **Cross-platform write access**: Partially resolved by GitHub mirror. v2 Cowork resolves cleanly: each vendor uses GitHub via its own mechanism. **Status: closed.**

2. **Skill testing without running**: Sandboxed testing environment for skills not yet designed. **Status: open** — carries forward as v2 build item.

3. **Self-extending authorization**: The lightweight "Chairman says go" mechanism for new subsystem builds is not yet formally designed. **Status: open** — carries forward.

4. **Research-to-build ratio**: World-building phase ended with the Build Guide rewrite (Apr 2026). v2 transition begins on Mac Studio. **Status: closed.**

[VELORIN.EOF]
