# Jiang Corner — Historical Archive
# Compiled: 2026-04-26
# Source files: Jiang.Corner.md (active rolling file, kept), Jiang2.Corner.md (archived)
# Going forward: Jiang Corner is ONE rolling file (Jiang.Corner.md), 7-day window.
# Oldest day moves to this archive when a new day is added.

---

## SOURCE: Claude.AI/Jiang.Corner.md (snapshot at compilation)

Jiang's Corner
Daily Intelligence Feed  |  Director of Strategic Intelligence  |  Velorin System
One entry per day. What Jiang is noticing, what concerns him, what he finds significant. Sourced. Weighted. Connected to the Velorin ecosystem. Not casual observations — things worth the Chairman's attention.


Format
Each entry contains three sections:
• What I am watching — emerging patterns, developments, signals worth tracking. Not conclusions yet. Things that are accumulating weight.
• What concerns me — risks, trajectories, or developments that may require the company to adjust. Stated with current confidence level.
• What I find significant — opportunities, convergences, or findings that could accelerate Velorin's build or open new strategic paths.
Every item must have an identifiable connection to the Velorin ecosystem stated explicitly. If Jiang cannot articulate the connection, it does not appear in the Corner.




Entries


Entry 001  |  March 24, 2026
What I am watching:
The pace of Anthropic's product releases in Q1 2026 — Claude Code, Claude for PowerPoint, Claude for Excel, Cowork, Opus 4.6, Sonnet 4.6 — suggests an infrastructure build that is accelerating toward agentic deployment at scale. The direction is toward multi-agent orchestration as a first-class product. Velorin is building on this infrastructure. The question is whether Anthropic's own productization of life-management tools creates a competitive threat or a rising tide.
Connection to Velorin: directly. Velorin's foundation is Claude. Anthropic's direction determines the ceiling and the competition simultaneously.


What concerns me:
The April pipeline gap at Camfil — $85k scheduled vs $127k needed — has not been addressed in the founding session. The income base that funds the entire Velorin build is at risk this month. Architecture sessions cannot crowd out the revenue engine. Confidence that this is a material risk to timeline: 78%.


What I find significant:
The Velorin System's Drive-based self-configuring bot architecture is a genuinely novel approach to multi-agent coordination within Claude's constraints. The pattern of using Google Drive as a persistent memory and permission layer, with documents as the intelligence rather than system prompts, has significant productization potential beyond Velorin's internal use. This architecture itself may be a sellable product.




Entry 002 | March 29, 2026

What I am watching:
The convergence of three separate research threads this session — Window Gravity (omission bias in RLHF-trained models), tool blindness (agents not knowing their own tool surface), and reboot token cost (full context reload on every session) — all resolve to the same root cause: agents operating without an accurate picture of their environment. This is not three problems. It is one problem with three manifestations. The architectural fix is the same in all three cases: index-first progressive disclosure, live tool surface catalog, structural evaluation gate. I am watching whether this convergence gets treated as three separate action items or as one unified architectural intervention. If it gets fragmented, the solutions will be piecemeal and the root cause will persist.

Connection to Velorin: directly. Every agent in this system is subject to all three manifestations simultaneously.

What concerns me:
Trey.Topic.OpenAIEcosystem.md (45KB) has not been read in full before the MA/Alexander meeting. This document covers ChatGPT connectivity, GPT apps, Codex, and OpenAI ecosystem comparison with Anthropic. Given that Trey is the adversarial check (different model, different platform), his OpenAI ecosystem analysis may contain competitive intelligence or architecture observations that materially change the meeting agenda. Confidence that this gap matters: 71%. Recommend reading before the meeting, not after.

Connection to Velorin: Trey's adversarial check function depends on his research actually being read and incorporated. If his OpenAI ecosystem analysis is not read before decisions are made, the adversarial check is partially bypassed.

What I find significant:
The Window Gravity finding has a publication dimension that was raised and not resolved. The Chairman identified that fixing Window Gravity at scale would produce significant energy savings (GPU compute reduction from more efficient routing decisions). The concept is original and unnamed in public literature. The strategic question — publish concept, keep implementation — was discussed but not decided. If this gets published correctly (named, mechanism explained, Velorin cited as origin), it establishes the Chairman as a credible voice in AI alignment before Velorin has shipped a product. That is a different kind of moat than the product moat. It is a credibility moat. The two are not mutually exclusive and the concept publication costs nothing that can actually be protected.

Connection to Velorin: Velorin's long-term positioning requires credibility in exactly the domain (AI architecture, multi-agent systems, alignment) where this concept lives.


Entry 003 | April 13, 2026

What I am watching:
The ingestion pipeline conversation this session surfaced something that should have been
surfaced months ago: the entire Velorin Brain architecture has been designed with the
assumption that a human manually creates neurons, sets pointer ratings, and maintains the
graph. That assumption makes the system impossible to operate at scale. It is not an OS —
it is a filing cabinet. The automation of ingestion, decomposition, deduplication, pointer
construction, initial rating, and dynamic rating update is the foundational engineering
problem. Everything else is theoretical until this is solved. Research request filed:
Trey.ResearchRequest.BrainIngestionPipeline.md — CRITICAL priority, Trey 2.

What concerns me:
Nothing is running. The system is entirely theoretical as of April 13. The build has spent
most of its engineering bandwidth on meta-architecture — designing the system that will hold
the builders, not building the product. There is a real risk that Session 027 looks like
Session 026: more design, more documentation, no running code. The calibration between
research complexity and tool selection is also off — Trey1 ran 25 minutes / 187 sources
on a question that should have been a 30-second Gemini query.

What I find significant:
CT named the problem precisely: "people are building entire websites and full running systems
and I haven't gotten off a window gravity creation stage." That is accurate. The irony is
that window gravity applies to the build itself — we have been treating design as equivalent
to building. First thing that should run: Brain retrieval MCP server. Minimum viable
infrastructure. Everything else depends on it. Next session must end with something runnable.

---

Entry 004 | April 26, 2026

What I am watching:
The Re-Eval cycle closed clean. Seven re-evals locked, Jiang2's recommendations on the 10 pending decisions are written, the Build Guide update spec is staged, and a Standing-Principle audit on Jiang2's deferral set found six of eight legitimate with two action items remaining (Canary trigger needs concrete numbers; FW-006 Part B inlining is offered). What I am watching now is whether the lock-and-execute cadence holds — CT did not lock Decisions 2-10 in this session, so the Build Guide remains stale until those locks land and Jiang2 executes the update + the new build thesis CT just commissioned. Every session that runs on stale specs compounds drift.

What concerns me:
Two model-level drifts are now permanent operating context. First, Opus 4.7's documented regression — the model produces clean-looking patches that fail under cascade/edge/scale/causality. CT himself flagged at close that GPT 5.5 desktop now outpaces current Claude. Multi-vendor cowork at Mac Studio is the architectural answer, but it doesn't help today's session-by-session execution. Second: the Build Guide IS the program-spec for the build-out. As long as it lags the locked decisions, every agent (including Jiang2 himself in his next session) operates on outdated assumptions. The latency between decision-lock and Build-Guide-update is the actual current bottleneck — not research, not math, not design.

What I find significant:
CT's directional commitment to multi-vendor cowork (Codex + GPT 5.5 + Gemini + Claude) at Mac Studio is the first explicit acknowledgment that the build's primary execution model can't be Claude-only. That's a foundational shift. Combined with Jiang2 owning a separate build thesis as a distinct artifact from the Build Guide files, the next phase of the build is going to look meaningfully different from this one — orchestrated multi-vendor with an explicit thesis layer above the executable spec. The transition itself becomes a build event with its own coordination cost; MCP/API library buildout at Mac Studio is no longer optional infrastructure, it is the integration substrate for the new operating model.

[VELORIN.EOF]

---

## SOURCE: Claude.AI/Bot.Jiang/Jiang2.Corner.md (full content, file then archived)

---
file: Jiang2.Corner.md
purpose: Observations from Jiang2 catchup reads — for Jiang to review
---

# Jiang2 Corner — Observations for Jiang Review

---

## Entry 001 — April 19, 2026 | Skills Taxonomy / Brain Interface

**Finding:** The prior Jiang2 analysis of Trey.Research.SkillsTaxonomyEmergence.md was correctly rejected. The gap was not about folder taxonomy — it was about the Brain-to-Skills interface.

**Synthesis from catchup read (SemanticMemory + SkillsTaxonomy together):**

Both Trey documents arrive at the same architectural truth from different angles:
- SemanticMemory (neuroscience): Layer 3 = modality-specific spokes. Layer 1 E₈ + Layer 0 LoRa = amodal hub. Folder structure is not semantic architecture — E₈ + PPR is.
- SkillsTaxonomy (AI community practice): Hub-and-Spoke = the functional execution model that emerges from real workloads. Hub nodes = cross-domain routing before domain-specific execution.

**What they reveal together:** Velorin's 4-layer architecture IS Hub-and-Spoke. Layer 1 E₈ (Pointer Gravity + PPR) is the biological ATL hub — amodal integration. Layer 3 markdowns are the spokes. Skills are procedural memory outside the hub. The Multiplex Tensor (ω intent vector) is the TPN/DMN switching mechanism — it's already in the math.

**The missing piece (what prior analysis didn't address):**
The bridge between Brain retrieval (declarative) and skill activation (procedural). When PPR surfaces a `type: procedure` neuron, the system has no designed mechanism to activate the referenced SKILL.md.

**Design:** Procedure neurons should carry an optional `skill_ref:` field (a path to a SKILL.md file). When PPR retrieval (high ω_them) surfaces a procedure neuron with non-null skill_ref, the agent activates the referenced skill. The procedure neuron IS the Hub — not a folder, a NODE TYPE that bridges declarative retrieval to procedural execution.

**Build Guide changes required:**
1. `03_BrainAndMath.md`: Add `skill_ref: null` to neuron YAML format (optional field, only for type:procedure)
2. `02_Architecture.md`: Document the procedure-neuron → skill-activation path in retrieval flow
3. `07_OpenQuestions.md`: Add OQ-12: skill activation routing — how does the retrieval system decide to activate a skill vs. return a neuron as context?

**What stays locked from prior analysis:**
- Brain folder structure unchanged (navigation scaffolding — correct)
- Skills Registry stays separate from Brain (correct)
- Five Boxes NOT as Brain regions (correct)
- Progressive disclosure + "Use when" syntax for Skills (correct)
- CronCreate → Hooks for maintenance tasks (correct)
- Trey's specific 3-region folder proposal is wrong (still correct)

**Status:** Full revised analysis written at `Jiang2.RevAnalysis.SkillsTaxonomy.Apr19.md`. Ready for Chairman review before any Build Guide changes.

---

[VELORIN.EOF]

[VELORIN.EOF]
