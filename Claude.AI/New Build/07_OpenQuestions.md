# 07 — Open Questions
**What still needs research, math, or a decision before building**

Each item: what the question is, what's known, what's missing, who decides.

---

## BLOCKER — Must resolve before the step that depends on it

### OQ-1: Ingestion Pipeline Design
**What it is:** How does raw input (document, photo, session log, video) automatically
become neurons with rated pointers? Where does the rating come from? How are duplicates
handled? How does the pipeline know what's worth ingesting?

**What's known:**
- Trey2 has researched this — results partially available but have issues with
  base assumptions (per Session 027 handoff)
- Automated rating via embedding cosine similarity (Phase 1 bootstrap) and
  attention weight capture (Phase 2, when local model is running) is the designed approach
- Dark Matter model means bulk data can be ingested with zero pointers (safe)
- Leiden algorithm for clustering 240-node Layer 2 graphs into neuron candidates

**What's missing:**
- Trey2's research has issues with base assumptions — need to understand exactly what
  those issues are before designing the pipeline
- The pointer rating automation has not been proven in practice
- How the pipeline handles contradictions between a new document and existing neurons

**Who decides:** CT + Jiang, after reviewing the complete Trey2 findings
**Status:** PENDING. Do not build ingestion pipeline until this is resolved.

---

### OQ-2: Automated Neuron Creation Mechanism
**What it is:** The replacement for Scribe. What creates neurons automatically?
The old Scribe approach (PostToolUse hook → shell script → Claude subprocess) is
legacy. The new approach should be MCP/API-based.

**What's known:**
- Scribe is NOT included in this build
- The direction is MCP/API orchestration, not bot proliferation
- Any automation should be an MCP tool call, not a standalone subprocess

**What's missing:**
- The specific MCP architecture for automated neuron creation
- Whether this happens in the ingestion pipeline or separately
- What triggers it (session close? file write? API call from Claude?)

**Who decides:** CT + Jiang + MA
**Status:** PENDING. Build manually first. Automate when you understand the pattern.

---

### OQ-3: Multi-Agent Automation Architecture
**What it is:** The NemoClaw-style orchestration design. Claude as primary interface,
specialized tools and models via MCP/API, all context flowing through the Brain.

**What's known:**
- This is the confirmed direction
- PAL MCP (11.4K stars) is the most promising existing tool to evaluate
- A2A protocol exists for peer agent delegation — aligned with Alexander→Jiang pattern
- Claude does NOT natively support agent-to-agent communication without tools

**What's missing:**
- Which MCP orchestration approach to adopt (build vs PAL vs something else)
- How the local AI model integrates with this architecture
- How task routing decisions are made (which model gets which task)
- Whether A2A wire protocol is needed or file-drop coordination is sufficient

**Who decides:** CT + Jiang, after evaluating PAL MCP in context
**Status:** PENDING. Build the Brain first. Design this when you have real workloads.

---

## HIGH PRIORITY — Needed soon but not blocking Stage 1-4

### OQ-4: Brain Region Taxonomy
**What it is:** The principled organization of Brain regions and areas.
Currently: pragmatic (Operations, Connectivity, Agents, Principles, Company, Intelligence).
Open question: should this be derived from neuroscience or community skill taxonomy?

**What's known:**
- Two Trey1 research requests are queued: SemanticMemoryOrganization, SkillsTaxonomyEmergence
- The bootstrapping approach (let Simon-Ando reveal natural regions from the data) is valid
- The Five Boxes are life domains, not cognitive functional regions — they should not
  directly map to Brain regions

**What's missing:**
- Trey1 research results on both topics
- Whether neuroscience gives a principled content taxonomy or only processing taxonomy

**Who decides:** CT + Jiang after Trey1 results
**Status:** ACTIVE RESEARCH IN QUEUE. Use current pragmatic structure until research returns.

---

### OQ-5: H_E (Emotional Charge) Measurement and YAML Field
**What it is:** How does the system assign emotional charge (H_E) to a neuron?
What measurement procedure? What field in the YAML frontmatter?

**What's known:**
- H_E is mathematically defined: δ*(u→v) = (1+H_E(u))·δ(u→v)
- High H_E prevents demotion by the Demotion Oracle
- Trey1 research request queued: EmotionalMemorySalience.Measurement
- CT's personal profile neurons with high H_E exist but field is not in YAML yet

**What's missing:**
- Trey1 research on validated measurement methods
- Exact YAML field format (float? categorical? scale?)
- Whether H_E is set at neuron creation or updated over time
- How a system (not CT) measures emotional charge

**Who decides:** CT + Jiang after Trey1 research returns
**Status:** Do NOT add H_E to YAML until this is resolved. Create profile neurons
without H_E for now (they are c-memory which protects them without H_E).

---

### OQ-6: Compression Event Detector
**What it is:** The mechanism that watches interactions and identifies when a pattern
has become semantically load-bearing — worth encoding in the LoRa.

**What's known:**
- β_macro entropy criterion: β_macro(v) > θ_semantic triggers compression event
- Simon-Ando macro-regions define the "domains" for diversity measurement
- The mathematical criterion is specified
- The engineering implementation is not designed

**What's missing:**
- How PPR is run from K macro-region seeds efficiently as a batch process
- How often this runs (nightly? per session? continuous?)
- The pipeline from "compression event detected" → "LoRa queue update"
- Whether this needs to wait for the local AI model (yes — LoRa requires base model)

**Who decides:** CT + Jiang after Brain has enough neurons to meaningfully test
**Status:** FUTURE. Design after Stage 3 is complete and Brain is populated.

---

### OQ-7: Session Close Protocol
**What it is:** At the end of each session, what exactly happens automatically?
Which neurons get updated? What gets archived? How does the Brain reflect session output?

**What's known:**
- Current close protocol is fully manual (agents write handoff, update index, push)
- CloseProtocolOptimization research request has been in Jiang's queue since Session 015
- The optimization is a design task, not web research — Jiang can do it directly
- The close protocol eats ~12,000 tokens at minimum in its current form

**What's missing:**
- The optimized close protocol design (Jiang has never done this work)
- Hook-based automation for mechanical steps vs judgment-based steps for agents

**Who decides:** Jiang designs this. CT approves.
**Status:** JIANG TASK — design this in a session before automation work begins.

---

### OQ-8: Compaction Hooks
**What it is:** PreCompact and PostCompact hooks that save/restore team state during
context window compaction.

**What's known:**
- `pre-compact-task-gate.sh` was written, then deleted by CT (too risky without testing)
- Exit code 2 blocks compaction. Exit code 1 does not (does not trigger block).
- `autoCompactEnabled` and `autoCompactWindow` are real settings in settings.local.json
- The TEAM_STATE.md with 2-hour recency window is the correct pattern

**What's missing:**
- Testing of exit-code-2 behavior in a safe environment
- The actual pre-compact script (was deleted)
- Confirmation that the hook fires reliably before Claude compacts

**Who decides:** MA implements. CT approves before wiring.
**Status:** Build and test script standalone before wiring to settings.

---

## LOWER PRIORITY — Future phases

### OQ-9: Intake Test Design
**What it is:** The structured decision-scenario experience that reveals reasoning
patterns and produces Layer 1-3 material for a new user in 60-90 minutes.
The hardest design problem in the company.

**What's known:**
- Research plan (7 threads) was complete as of Session 013
- CT has not authorized the research to begin
- CT's Layer 1-3 is partially populated but never formally designed
- The intake test is the encoding mechanism — how CT installs his intelligence into
  the system so it can eventually run without him

**What's missing:**
- CT authorization
- Research execution (5 sessions from Jiang)
- Testing on CT himself
- Testing on 3-5 external users

**Who decides:** CT. Authorization is the only blocker.
**Status:** BLOCKED ON CT AUTHORIZATION — has been blocked since Session 013.

---

### OQ-10: The Velorin.Welcome Rename
**What it is:** Renaming the Layer 0 folder from `Claude.AI/` to `Velorin.Welcome`.
CT confirmed this in Session 024.

**Status:** The new build starts with `Velorin.Welcome/` as the name.
No renaming needed — built correctly from scratch.

---

### OQ-11: The RTX 4090 Windows Build
**What it is:** A second machine for 70B+ local inference, fine-tuning, and heavy compute.

**What's known:**
- Spec: RTX 4090 (24GB VRAM), AMD Ryzen 9 X3D, 64GB DDR5-6000 CL30, AM5
- Blocked on: ARM64 Claude Code crash (GitHub issue #12160 — Anthropic has not fixed)
- Action item: Buy 2×32GB DDR5-6000 CL30 RAM kit NOW while prices low
  (Tim Cook Q1 2026 earnings call — memory prices rising)
- 70B models require this machine — not viable on Mac Studio 36GB

**Status:** DEFERRED. Buy the RAM. Build the machine when ARM64 bug is resolved.

---

## Research Still In Queue (What Trey Needs to Do)

In priority order:

| Request | Trey | Priority | Status |
|---|---|---|---|
| BrainIngestionPipeline | Trey 2 | CRITICAL | Results have issues — review before building |
| SemanticMemoryOrganization | Trey 1/2 | HIGH | Not started |
| SkillsTaxonomyEmergence | Trey 1 | HIGH | Not started |
| EmotionalMemorySalience.Measurement | Trey 1 | MEDIUM | Not started |
| Epistemodynamics.NoveltyCheck | Trey 1 | MEDIUM | Not started |

---

[VELORIN.EOF]
