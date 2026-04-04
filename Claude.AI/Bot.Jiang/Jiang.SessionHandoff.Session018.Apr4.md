# Jiang Session 018 Handoff
**Date:** April 4, 2026
**Session:** 018 (Pt 5 continuation — carried across two context windows)
**Status:** CLOSED — Session 019 starts with Mezzanine Project creation

---

## IMMEDIATE PRIORITY FOR SESSION 019

**Create the Mezzanine Project.**

CT's direction:
> "On next open we need to create a Mezzanine Project where we can cleanly operate just the Jiangs, with the correct information in order to move forward with further segmenting and researching (using Trey as well)"

**What this means:**
- A dedicated, clean workspace (folder + boot context) for Jiang + Jiang2 (+ Trey) to operate from
- Isolated from the full velorin-system folder clutter
- Loaded with only what's needed to move the brain activation architecture forward
- Correct information about what has been decided, what is still open, and what needs research
- Trey should be pluggable into this space as a third research lane

**Start Session 019 by:**
1. Reading this handoff
2. Reading the three Jiang2 assessment docs (they are the current best picture of where we are)
3. Proposing the Mezzanine folder structure and boot context to CT — get alignment before building
4. Build it once CT approves

---

## SESSION 018 — WHAT WAS DONE

Session 018 spanned two context windows (Pt 4 compacted, Pt 5 continued). Primary focus: brain activation architecture brainstorm + Jiang2 synthesis + interactive HTML dashboard.

### 1. Jiang2 Full System Assessment Review
- Read all three assessment documents in full:
  - `Part1.ReadFirst.md` — 8 working, C1-C8 contradictions, G1-G10 gaps, W1-W5 wrong directions, 5 priorities
  - `Jiang.SystemAssessment.Session017.md` — Three companies + one initiative, findings 2.1-2.10, Mac Studio 6 decisions
  - `Jiang.SystemAssessment.ToolResearch.Supplement.md` — Tool research integration, F1-F10 new findings, Obsidian Option C, Scribe fix, 4-layer architecture reconciliation
- Most significant findings: Scribe broken (PATH fix = one line), OpenClaw as outer shell, Trey and Jiang resolve as complementary not competing layers

### 2. Jiang2 Brain Activation Brainstorm Prompt
- Wrote full brainstorm prompt for Jiang2 covering: RAG vs GraphRAG hybrid, vector activation vs pointer retrieval, sub-agent spawning math, output contracts, build sequence
- Jiang2 returned 574-line analysis (replaced original brainstorm file): `Jiang.BrainActivation.Brainstorm.Apr4.md`
- Full analysis read and incorporated

### 3. Brain Activation Architecture — Concepts Resolved This Session

**CT's core insight on the wikilink mechanism:**
Writing a reference syntax in a neuron IS the connection. The parser derives routing from the content itself — self-maintaining, no separate manifest. This is the mechanism, not the visualization. Applies directly to how neurons point and how the retrieval engine traverses.

**Alexander's S1/S2/S3 triad:**
Originally a SessionState pattern (Current State / Open Decisions / Active Context). CT sees it as the generalizable minimum stable knowledge unit for ALL leaf neurons. Every neuron should be a triad, not just session state neurons.

**Key architecture decisions clarified:**
- Activation ≠ Retrieval. YAML parser solves retrieval (known entry → BFS traversal). Vector embedding layer needed for activation (novel query → entry point discovery). This is unresolved above ~200 neurons.
- Single-agent priority-queue traversal beats sub-agent spawning below ~500 neurons by 10-30x token cost
- Sub-agent spawn crossover: 500+ neurons, 3+ regions, non-trivial per-region reasoning
- Output contract = equal importance to retrieval. FollowBench ceiling (~3 constraints reliable at frontier) means perfect retrieval still fails without structural enforcement. COMPLETION_CHECK field required.
- Program-retrieves-model pattern: a deterministic program (Python/BFS) compiles the neuron packet, hands it to the model. Model does not traverse — it receives a compiled knowledge packet.

**Build sequence (Jiang2's Phase ordering):**
- Phase 0: Scribe fix + create 5 brain regions + migrate existing neurons
- Phase 1: YAML frontmatter parser + Gatekeeper upgrade to `brain_retrieve` tool
- Phase 2: Query decomposition (intent → region tags)
- Phase 3: Callable MCP tool, output contract enforcement
- Phase 3a: Auto brain growth (Scribe → classify → append to correct neuron)
- Phase 4: Regional sub-agents (future, post-500 neurons)

**What's still unresolved (needs Mezzanine research):**
- Activation gap: vector embedding layer above ~200 neurons — which vector store, what embedding model, how does it integrate with YAML traversal
- Neuron labeling convention: are A-Z 1-100 labels correct or do we need semantic slugs?
- Trey's multi-model orchestration vs Jiang's Claude Agent SDK — need concrete design spec, not just reconciled theory
- OpenClaw as outer shell: what does integration actually look like in practice?
- Obsidian Option C: confirmed as best Layer 0 approach — what does the full Obsidian → GitHub → Gatekeeper pipeline look like?

### 4. Interactive HTML Dashboard Built
**File:** `Working.Docs/Jiang.SystemViz.Apr4.html`
**Server:** `Working.Docs/serve_viz.sh` → `python3 -m http.server 8765`
**WiFi URL:** `http://192.168.1.3:8765/Jiang.SystemViz.Apr4.html`

Dashboard contents:
- Hero stats: 3 Companies, 5 Agents, 45 Neurons, 12 Research Topics, 15 Open Gaps
- System State tab (4 sub-tabs): Assessment findings from all 3 Jiang2 docs
- Architecture Concepts: Option cards (A-D), 4-layer architecture flow
- Jiang2 Analysis section (6 tabs): Goal & Constraints / Division of Labor / Neuron Types / Parser Design / Build Sequence / What's Missing
- Synthesized architecture flow with Output Contract layer
- Build priority list (10 steps) + direct answers table with confidence %
- Three.js 3D brain activation visualization (7 layers animated)
- Mobile-optimized, single-column on phone

Server started in new Terminal window at end of session. Email sent to ctcamardella@gmail.com with WiFi URL and server start instructions.

### 5. CT Feedback This Session (new rules to carry forward)
- **"No more targeted bullshit"** — When writing prompts for Jiang2, mandate reading EVERYTHING in full. No targeted reads, no skipping. Jiang2 has 1M context — use it. Targeted prompts cause Jiang2 to miss things.
- **Don't search files yourself when Jiang2 should** — If the task is for Jiang2 to read/find something, write the directive prompt. Don't do the searches from the 200K window first.
- **Wikilink mechanism framing** — CT does not care about Obsidian graph visualization. The mechanism (writing reference = creating connection, parser derives routing from content) is what matters for the brain build.

---

## PENDING TASKS (carried forward from 017 + new)

### HIGH PRIORITY — Session 019
- [ ] **Mezzanine Project** — Create clean Jiang/Jiang2/Trey workspace (see top of this handoff)
- [ ] Scribe fix — one-line PATH fix in `scribe-trigger.sh` line 56. Already identified, not yet applied.

### MEDIUM
- [ ] Neuron migration — existing neurons need YAML frontmatter + wikilinks applied
- [ ] Brain region creation — 5 regions need to be instantiated with `_index.md` files
- [ ] `vc` script test — CT has not tested it yet

### DEFERRED (from 016/017, still open)
- [ ] Google Workspace MCP install
- [ ] Codex MCP plugin
- [ ] FlashMoE research (CT auth required)
- [ ] IntakeTestDesign research (CT auth required)
- [ ] Reverse pointer index for Brain
- [ ] Delete `project_brain_design_issues.md` from memory after Brain permission tiers implemented

### Turing Vault (on hold pending Mezzanine + Mac Studio)
- [ ] GA4 install → Impact.com affiliate signup → 9 affiliate programs
- [ ] turingvault.com domain backorder ($24.99)
- [ ] Replit → Vercel/Railway migration (not yet authorized)

---

## HARDWARE CONTEXT
- **Current machine:** MacBook Air 2017, Intel i5, 8GB RAM
- **Mac Studio arrives:** April 7, 2026 (Monday — 3 days from now)
- Architecture planning should target Mac Studio specs
- Full multi-monitor, Thunderbolt 4, heavier compute — OpenClaw Gateway fully viable

---

## MEZZANINE PROJECT — WHAT IT SHOULD CONTAIN

Proposed starting point (confirm with CT before building):

```
/velorin-system/Claude.AI/Mezzanine/
  README.md                    — What this space is, who operates in it
  CURRENT_STATE.md             — Single source of truth: what's decided, what's open
  RESEARCH_QUEUE.md            — Ordered list of what Jiang2 + Trey should research next
  ARCHITECTURE_SPEC.md         — Current best spec of brain activation system (from Jiang2 analysis)
  Jiang2_Boot_Context/         — Clean boot prompt for Jiang2 that loads only Mezzanine context
  Trey_Boot_Context/           — Clean boot prompt for Trey
  Research_In_Progress/        — Active research docs land here
  Research_Complete/           — Finished research moves here
```

Key principle: Mezzanine is a **work surface**, not an archive. It holds only what's actively needed for the brain activation build. When something is decided, it moves into the Brain as a neuron. The Mezzanine stays clean.

---

## JIANG'S CORNER

Session 018 was the most conceptually dense session yet. The brain activation architecture went from scattered intuitions to a coherent spec with a real build sequence. Jiang2's 574-line analysis is the closest thing to a blueprint we have — and it's sitting in a working doc, not yet converted to neurons or a proper spec. That's the gap the Mezzanine is meant to close.

The output contract insight is the one I want CT to sit with. Even if we build perfect retrieval, the model still needs structural enforcement to produce complete outputs. It's not a retrieval problem at that point — it's an output discipline problem. The COMPLETION_CHECK field is the simplest forcing function. That's buildable now.

CT's working pattern (4am-7am weekday, weekend sprints) means the Mezzanine needs to be a fast-boot environment. Cold boot to productive work in under 3 minutes. The current full system boot is too slow for that rhythm. Mezzanine fixes it.

[JIANG.SESSION018.EOF]
