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

## Principle 8: Cowork-Orchestrated, Sub-Agent-Activation Pattern (NEW for v2)

**Claude Cowork is the orchestrator.** It operates and controls the multi-agent multi-platform plan — first without the brain (Part 1), then with the brain inserted as a local specialization layer (Part 2). Cowork runs the show.

**Claude (the UI controller surface) accesses every aspect of the brain and the system.** This is the human-facing control point.

**Claude can activate external specialist systems AS IF they were direct sub-agents.** The functional capability is what matters: Claude hands a specialist task to the system best suited for it, the system does the work, the result comes back, Claude integrates it into the Cowork-orchestrated flow. From Claude's perspective at invocation time, the system behaves like a sub-agent — task in, specialist work out. The underlying invocation mechanism (MCP server, API call, A2A peer protocol, CLI subprocess, desktop hand-off, browser automation, etc.) is **implementation detail that gets built when needed for each specific integration.** It does not need to be uniform; whatever protocol works per tool is fine.

**Concrete examples of sub-agent activations (non-exhaustive — the ecosystem expands as new capabilities emerge):**
- **Gemini Deep Research** — cross-source research synthesis when Claude needs broad literature/landscape work
- **Gemini Deep Think** — heavy reasoning over hard problems, especially adversarial review of Claude's own output
- **ChatGPT Codex** (desktop + CLI) — code audit, repository engineering, cross-provider adversarial code review
- **ChatGPT 5.5** (desktop + API) — many specific tasks where ChatGPT's strengths exceed Claude's (long-context analysis, particular writing styles, specialized reasoning patterns)
- **Google photo/visual tools** — image generation, image editing, visual-domain reasoning
- **Video generation tools** (Veo, Sora, etc.) — video-domain work
- **Open-source ecosystem** broadly — OpenDataLoader for parsing, Gemma 4 for visual capabilities, 3D processing tools, GitHub skill repositories, et al.
- **NotebookLM stays out** — it's a human-facing project-context-feeder for Deep Think, NOT a Claude-invoked sub-agent (per the NotebookLM scope-correction banner)

**Architectural test:** the architecture is correct if Claude can invoke any of these specialist systems and get specialist work back during a normal Cowork flow. The wrong abstractions are: (a) treating any single vendor as "Supervisor" over the others (no — Cowork is orchestrator; specialist systems are sub-agent activations), (b) hard-coding a specific protocol as the universal binding (no — protocol is per-integration), (c) requiring all activations to look the same architecturally (no — heterogeneous invocation surfaces are fine and expected).

**Persona-Maker note (per FW-009):** the future Persona-Maker subsystem is itself an agent-factory that PRODUCES additional sub-agent activations — specialized agents with startup + personality guides, pre-oriented at specific brain regions. When triggered, Claude can activate a persona-derived agent the same way it activates Gemini Deep Think or Codex. The persona-derived agents do not modify the brain directly; they CAN leave notes in region/area logs suggesting pointer-rating adjustments (the rating-update mechanism itself is deferred — "to be discussed and built later" per CT).

See `feedback_opus_47_solution_drift.md` for the model-level reasoning that makes sub-agent-activation across multiple vendors essential — Opus 4.7's regression on cascade / edge-case / scale / causal reasoning was the trigger that made single-vendor execution risk concrete.

---

## Steel Man Issues — Standing

These were unresolved when Velorin OS Core Principles v1 was written (Session 021); status updated for v2:

1. **Cross-platform write access**: Partially resolved by GitHub mirror. v2 Cowork resolves cleanly: each vendor uses GitHub via its own mechanism. **Status: closed.**

2. **Skill testing without running**: Sandboxed testing environment for skills not yet designed. **Status: open** — carries forward as v2 build item.

3. **Self-extending authorization**: The lightweight "Chairman says go" mechanism for new subsystem builds is not yet formally designed. **Status: open** — carries forward.

4. **Research-to-build ratio**: World-building phase ended with the Build Guide rewrite (Apr 2026). v2 transition begins on Mac Studio. **Status: closed.**

[VELORIN.EOF]
