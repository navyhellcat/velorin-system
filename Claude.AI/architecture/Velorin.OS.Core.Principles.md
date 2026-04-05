---
document: Velorin OS Core Principles
version: 1.0
date: 2026-04-05
session: 021
status: ACTIVE — these govern all build decisions
author: CT + Jiang Session 021
---

# Velorin OS Core Principles

These principles are load-bearing. Every build decision in Velorin should be
checked against them. A decision that violates a principle here requires explicit
CT authorization and a documented reason — not just a workaround.

---

## Principle 1: GPS Over Map

**Statement:** Navigation uses stable pointers, not hard-coded destinations.

**What this means:**
- Layer 0 points to Bot.[Name]. Not to a specific file path.
- Hooks files point to behavior. Not to specific session files.
- Neurons point to other neurons and skills. Not to specific file versions.
- The thing being pointed AT can change. The pointer mechanism does not.

**How to check:** If renaming a file requires editing more than ONE pointer,
the system is using a map, not GPS. Find the redundant hard-coding and remove it.

**What MA got wrong:** CLAUDE.md with explicit paths is a map.
Every path change requires CLAUDE.md surgery. That is the opposite of GPS.

---

## Principle 2: The Brain Is Separate

**Statement:** The GPS system navigates. The Brain thinks. These are distinct systems
connected by exactly one pointer file per agent.

**What this means:**
- Boot and navigation do not require Brain access.
- The Brain is not loaded on every session. It is accessed on demand.
- The connection is `Brain.Access.md` in Layer 1 — one file, one pointer, no content.
- An agent that is fully booted and navigated is NOT yet in the Brain.
  It enters the Brain when it needs to think deeply about a problem.

**Why this matters:**
Collapsing GPS and Brain means every boot loads the entire knowledge graph.
That is expensive, noisy, and fragile. Separation means boot is fast and clean.
The Brain activates only when needed and only the relevant region fires.

---

## Principle 3: Tier Separation With Controlled Growth

**Statement:** Three tiers exist. Agents operate within their tier.
Higher tiers can build downward using established patterns.
No tier can modify the layer it is currently operating in.

**The tiers:**
```
Tier 1 — Programs
  Deterministic code. Health monitors. Registry systems. Replacement logic.
  8-hour check scripts. Ingestion pipelines.
  No AI in the execution loop. Runs the same way every time.

Tier 2 — Program Managers (Elevated AI)
  Reads and writes Tier 1. Skills Manager. System architects.
  Has NO operational role. Never uses the programs it manages.
  Never operates alongside Tier 3 agents in a live context.

Tier 3 — Operational AI
  Jiang, Trey, Alexander, MA, all named agents.
  Uses programs. Fires flags. Reads registry. Navigates GPS.
  Cannot touch Tier 1 directly. Cannot modify its own infrastructure.
```

**The growth mechanism:**
A Tier 2 agent CAN build new Tier 1 programs using established Velorin patterns.
A Tier 3 agent CAN propose new programs to Tier 2 for building.
Growth happens upward-initiated but downward-built. Always using the OS patterns.

**What "established patterns" means:**
Any new program built must follow GPS over Map, Brain separation, and tier separation.
It cannot invent a new navigation mechanism. It uses the existing substrate.

---

## Principle 4: The Self-Extending Vision

**Statement:** Velorin builds new subsystems using its own OS.
The substrate must be correct because everything inherits its shape.

**What this looks like:**
Velorin one day identifies anti-aging research as valuable.
It builds:
- A new Brain region (Anti-Aging)
- New areas and neurons under that region
- New Bot.[AgentType] folder with Layer 0/1 GPS structure
- New skills discovered from registry
- New Tier 1 programs specific to that domain
- New hooks for that subsystem's needs

All of it uses the same GPS, same Brain, same skill registry, same patterns.
It looks like Velorin because it IS Velorin. It just grew.

**The authorization requirement:**
Self-extension is the goal. But "it doesn't ask CT" is NOT yet the operating model.
Until the substrate is proven stable and the extension patterns are validated,
every new subsystem requires:
- A proposal (what, why, how it fits the existing patterns)
- CT authorization (can be lightweight — "yes, go")
- A Steel Man pass before build starts

The constraint is not permanent. It loosens as trust in the substrate builds.

---

## Principle 5: Computer Programming Discipline

**Statement:** AI systems that rely on AI judgment for infrastructure decisions
are fragile. Deterministic programs are the foundation. AI rides on top.

**What this means:**
- The health monitor is a Python script. Not a prompt.
- The 8-hour recheck is a cron job. Not an agent deciding when to check.
- The registry is a structured file with a schema. Not a neuron.
- The replacement sequence (flag → find → pass → replace) is code. Not a conversation.

**Why AI fails at this naturally:**
AI can read, run, and rewrite code in the same context. Nothing stops it.
So without explicit separation, it does — and you get an agent that modifies
its own tools mid-operation. Unpredictable. Undebuggable.

Computer science solved this 60 years ago: users don't write the OS.
Applications don't patch themselves. The runtime is separate from the compiler.
Velorin enforces this same separation explicitly.

---

## Principle 6: GitHub Is the Universal Mirror

**Statement:** GitHub is the source of truth AND the universal access point.

**What this means:**
- Claude Code reads from local disk (which mirrors GitHub)
- Gemini reads from GitHub directly (full access)
- ChatGPT reads from GitHub (limited but functional)
- Any future platform: GitHub is always accessible

**The implication for GPS Layer 0:**
Layer 0 lives on GitHub. Any agent from any platform can reach it.
The "cross-platform problem" is solved by this mirror.
We do not need separate Layer 0 versions for different platforms.

**The rule:** Everything important must be on GitHub.
Local-only files are caches, not sources of truth.
Push before every session close. Pull before every session start.

---

## Principle 7: The Five Boxes Frame All Decisions

**Statement:** Velorin is CT. It serves all Five Boxes. The OS is the orchestration
layer across them — not a separate project.

**The Five Boxes:**
- Box 1 — Professional/Income: Camfil + AI tools toward independence
- Box 2 — Financial: Freedom from leverage. Turing, algorithms, revenue.
- Box 3 — Health: Physical and mental baseline. Non-negotiable prerequisite.
- Box 4 — Personal/Relationships: The significance container.
- Box 5 — The Commons: Botted professional services eliminating friction.

**What this means for build priorities:**
Box 2 (Financial) can build and ship independently of the OS.
Box 1 uses the OS but doesn't wait for it to be complete.
Alexander as master orchestrator is the end state — he needs the OS to function.
Building the OS is building Alexander's capability, not an abstract infrastructure project.

---

## Steel Man Standing Issues (From Session 021)

These are unresolved problems identified by Steel Man. They must be addressed
before the relevant subsystem is built:

1. **GPS cross-platform:** Partially resolved by GitHub mirror.
   Remaining gap: Gemini has no write access to local disk.
   Any GPS element requiring local writes needs a GitHub-only alternative.

2. **Skills Manager health check contradiction:**
   Testing a skill means running it. Running it means using it.
   Sandboxed testing environment not yet designed.

3. **Self-extending authorization layer:**
   The lightweight "CT says go" mechanism is not yet formally designed.
   What does the proposal look like? Where does CT review it?

4. **Research-to-build ratio:**
   Acknowledged. World-building phase is intentional.
   Forcing function for ending it: neuron schema locked + first retrieval working.
   Mac Studio Monday is the build start date.

[VELORIN.EOF]
