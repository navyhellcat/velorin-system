# 06 — Build Sequence
**Executable step-by-step. Stage 0 through Stage 5. — Updated April 26, 2026**

---

## ⚠️ DO THIS FIRST — Before Stage 0

**Before any build work begins, scroll to the bottom of this document and review the 5 ideas in the "DECISIONS TO BE MADE" section.** Use community consensus, Erdős math, and Trey research to decide whether each idea should be adopted, modified, or dropped. Lock the decisions, then start Stage 0. These ideas affect Stage 1 (Quick-Capture Layer, IES proxy field, two-pass classification) and later stages. If they're in, they need to be built alongside those stages from day one — not retrofitted later.

---

The build sequence follows the two-part architecture:
- **Part 1 (Stages 0-2):** Cowork-orchestrated multi-vendor system. Brain not required. Fully functional on Day 1 of Mac Studio.
- **Part 2 (Stages 3-5):** Brain insertion as local specialization layer. Brain-as-operator-guide is the Part 2 destination.

Every step is executable or clearly marked PENDING/BLOCKED. Each stage depends on the previous.

---

## Build Philosophy

Programs do operational work. AI watches. Before writing any AI-agent behavior, ask: is this a program to build with AI as watcher?

Every calibration parameter has a measurement program, specific data points captured, threshold, verification path, multi-point distribution across build phases, cadence, test specification, logged deliverable, and a hard date or target. Full Calibration Deliverables Discipline (elements a-k) governs every measurement. See `Velorin.CheckIns.md`.

---

## Check-Ins Schedule Reference

The full vitality-important Check-Ins list is in `Velorin.CheckIns.md`. Build sequence stages reference Check-Ins entries by name where they belong in the progression.

---

## PRE-STAGE 0 — Edge Ontology Unification (BUILD BEFORE ANY PIPELINE)

Must complete before Brain ingestion pipeline or Skills dependency graph is built. Building both with divergent schemas creates retrofit cost the Standing Principle prevents.

**Unified edge ontology — Brain 9-class labels ↔ GoS 4-type categories:**

| Brain Relation Type | GoS Category |
|---|---|
| `instance-of`, `derived-from` | dependency (structural hierarchy/prerequisite) |
| `causes`, `activates`, `precedes`, `implements`, `depends-on` | workflow (operational sequences) |
| `supports`, `contradicts` | semantic (evidential, bidirectional) |
| `supersedes`, `same_as` | Brain-specific knowledge lifecycle (no GoS analog) |
| (none) | alternative (skills-specific: mutually exclusive execution paths) |

**`contradicts` dual function:** serves as both a semantic label AND a belief_state trigger (post-commit hook fires on this pointer type). The pointer carries both meanings — no sub-attribute needed; the behavior is deterministic from the label.

---

## PART 1 — Multi-Vendor Cowork System (Brain Not Required)

---

## Stage 0 — Mac Studio Environment (Day 0)

**Goal:** Mac Studio configured. Cowork integration substrate ready. All specialist systems reachable.

### Step 1 — GDrive Service Account Migration (FW-003 — DO FIRST)

OAuth tokens expire every 7 days, has already broken twice. Fix before anything else.

```bash
# In Google Cloud Console:
# 1. Create service account under Velorin project
# 2. Share Claude.AI folder with service account email
# 3. Download JSON key → ~/.velorin-gdrive-key.json (never commit)
# 4. Update velorin-gdrive-mcp/auth.js to use GoogleAuth with keyFile
# 5. Test: verify gdrive_list_folder works without tokens.json
```

Apply to both Mac Studio and MacBook simultaneously at Mac Studio port.

### Step 2 — System Dependencies

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git node python3 jq gh
npm install -g @anthropic-ai/claude-code
claude login
git config --global user.name "Christian Taylor"
git config --global credential.helper osxkeychain
gh auth login
```

### Step 3 — Clone Repo

```bash
git clone https://github.com/navyhellcat/velorin-system.git /Users/lbhunt/Desktop/velorin-system
cd /Users/lbhunt/Desktop/velorin-system
```

### Step 4 — GPS Navigation Layer + Folder Structure

**Design the GPS Navigation Layer BEFORE creating folders.** The full spec is in `01_RepoAndEnvironment.md` Step 5. The folder structure must implement the three GPS properties: discoverable by convention, layered progressive disclosure (Layer 0 universal → Layer 1 agent home → Layer 2 agent workspace), and portable without editing. Open naming decisions (platform-grouped vs flat agents, dot vs bare names, Layer 0 doc set, research organization) are resolved here. Commission Trey research on multi-agent repo navigation patterns if needed — apply Consensus Filter before adopting any pattern.

Create the folder structure only after the naming conventions are locked.

```bash
mkdir -p Velorin.Welcome
mkdir -p brain/{Operations/{Architecture,Startup,Tools},Connectivity/{MCP,Auth},Agents/{Roster,Protocols},Principles/{RewardAlignment,CoreDrives},Company,Intelligence}
mkdir -p skills
mkdir -p agents/claude/{jiang/{handoffs,research-needed,research-complete,working-docs,protocols},alexander/{handoffs}}
mkdir -p agents/gemini/{trey/{Gems,Bootloader,handoffs,research-needed,research-complete},erdos/{research-needed,research-complete,Archived_Research_Requests}}
mkdir -p tools-and-research/{architecture,math/{locked,future-theory},research-complete,brainstorming}
mkdir -p infrastructure/{hooks,mcp,mailboxes/{Shipping,Receiving},queues/{atv-review,atv-overflow,contradiction-review}}
mkdir -p sessions/{handoffs,daily-logs}
find . -type d -empty -exec touch {}/.gitkeep \;
```

### Step 5 — settings.local.json

```json
{
  "model": "claude-sonnet-4-6[1m]",
  "CLAUDE_CODE_SUBAGENT_MODEL": "claude-sonnet-4-6[1m]",
  "ENABLE_TOOL_SEARCH": "true",
  "permissions": {
    "allow": ["Bash(*)", "Read", "Write", "Edit", "Glob", "Grep"],
    "deny": ["Bash(rm)", "Bash(rmdir)", "Bash(sudo)", "Bash(trash)"]
  },
  "hooks": {
    "SessionStart": [{"matcher": "startup", "hooks": [{"type": "command",
      "command": "cd /Users/lbhunt/Desktop/velorin-system && git pull origin main --quiet 2>&1 | tail -1",
      "timeout": 15}]}]
  }
}
```

### Step 6 — MCP Servers

Wire GitHub MCP, Filesystem MCP in Claude Desktop config. Add Qdrant MCP after Step 8.

*→ Forward note: Qdrant MCP added at Stage 1 (after Qdrant is running); ATV MCP added at Stage 1 (after ATV build).*

### Step 7 — Research Library Transition to Brain

**The current `Velorin.ResearchLibrary.v2.md` is transitional infrastructure, NOT the destination.** It is a 1,500-line flat markdown file serving as a manual approximation of what the Brain's ingestion pipeline will do automatically at Stage 3. Half its entries are one-line stubs that provide a filename and nothing else — functionally useless as compressed knowledge.

**What must happen in the early build stages:**
- **Stage 1:** The library's full-card content becomes seed neurons ingested into Qdrant via the ingestion pipeline. Each card's topic_id becomes the neuron's `id` field. The Key Findings become the neuron body. The source pointer becomes `source_coords`. The library file itself becomes a historical artifact once the Brain holds the content.
- **Stage 2:** The library_lookup pattern (query by topic_id → get compressed knowledge) transitions from "grep a markdown file" to "PPR walk over the Brain." The flat file is replaced by actual retrieval.
- **The 30 roster stubs must be properly written as full cards OR ingested directly from their source files BEFORE this transition.** Stub entries that say nothing cannot become neurons that know nothing. The ingestion pipeline needs actual content to work with.

**Standing note:** Do not invest further sessions in perfecting the flat-file library. It serves its purpose as a bridge. Investment goes into the ingestion pipeline that replaces it.

### Step 8 — Pre-Stage 0 Edge Ontology Unification

Execute the edge ontology mapping above. Confirm `skill_dependencies.yaml` will use 4-type edge schema from day 1 of Stage 1 Skills build.

✅ **Stage 0 complete when:** Claude Code boots, GitHub connected, folder structure exists, GDrive service account works without OAuth prompts.

*→ Forward note (Stage 1): the infrastructure/queues/ folders built here will be read by ATV (contradiction-review, atv-review, atv-overflow) and the conflict resolution mechanism.*

---

## PRE-STAGE 1 — Library Audit Resolution (BUILD/DECIDE BEFORE STAGE 1 BEGINS)

The Research Library v2 build (Sessions 038-039) was followed by a top-to-bottom audit documenting what got built, what's outstanding, and what should be addressed before Stage 1 infrastructure work begins. **Read the audit doc in full and resolve every item in the tables below before starting Stage 1 Step 1.**

**Audit reference (mandatory pre-read):** `Claude.AI/New Build/Library.Built.Research.Tools.OutsideTools.Explanation.Audit.md`

Each row below maps to a section in the audit. Each row must reach one of three terminal states before Stage 1 Step 1 fires:

- **BUILT** — implementation committed, verified, operational
- **DECIDED** — explicit "skip / defer / drop" with documented rationale on the row
- **FORMALLY DEFERRED** — Standing Principle deferral discipline applied (legitimate technical advantage AND specified architectural seam, both required)

If a row is in none of those three states, Stage 1 does not begin.

### A. Outstanding items from audit §10

| # | Item | Audit § | Action | State |
|---|---|---|---|---|
| A.1 | IdentityVerification research request file | §10.1, §11.4 | Create file in `Bot.Jiang/Research_Needed/`. ~10 min. Path-3 blocker per `agent-orchestration` (88%) and `agent-ecosystem-reality` (92%). | OPEN |
| A.2 | May 2026 ecosystem reconciliation | §10.2 | RESOLVED — Trey FullStackPressureTest + Erdős UnifiedSynthesis adjudicated. Symlink contradiction resolved: Functorial Registry (`AGENTS.md`) achieves Monoswarm logical routing without breaking the Poset (physical symlinks permanently banned). Ecosystem data (GPT-5.5, AAIF, DeepSeek V4) absorbed into substrate-lock integration. Older `agent-orchestration` framework recommendations superseded by Cowork-orchestrated sub-agent-activation pattern (Principle 8). | DECIDED — Functorial Registry resolution locked in substrate |
| A.3 | Erdős corpus read + math supplement merge | §10.3 | RESOLVED — Erdős FullStackAudit + JiangVerificationResponse + NoveltyMathDerivations + FinalSubstrateLock all delivered, ported, and integrated into MathStream in substrate-lock pass (commit `760e2dc`). C.3 Grassmannian retracted by Erdős. MathStream now contains 12 new sections from this corpus. Turboquant-and-mempalace card merge remains a minor TODO (low priority). | BUILT — corpus integrated into MathStream |
| A.4 | Three Trey delivered requests | §10.4 | RESOLVED — archived to `Velorin.v1.Archive/Archived_Research_Requests/Trey/` in commit `5f7ed8b`. | BUILT |
| A.5 | IntakeTestDesign authorization | §10.5 | RESOLVED — OQ-9 repositioned to Phase 4 last item per CT decision 2026-04-26; request archived to `Velorin.v1.Archive/Archived_Research_Requests/Jiang/` in commit `5f7ed8b`. | BUILT |
| A.6 | Exhaustive fidelity audit on v2 cards | §10.6 | Multi-session pass (~300K tokens). Trigger only on demand or specific consumer-experience fidelity miss. | FORMALLY DEFERRED — seam: re-audit can run against any subset of cards using same read+verify pattern |
| A.7 | Working.Docs lifecycle review | §10.7 | Single focused session. Triage operational artifacts (prompts, plans, FW registry, confirmations). Not urgent. | FORMALLY DEFERRED — seam: applies same archive pattern as Session-039 research move |
| A.8 | ArchiveRecommendations Section 7 confirmation | §10.8 | RESOLVED — implicitly confirmed by Session 040 building on the unified-silo pattern (10 additional research requests archived to same destination structure). | BUILT |
| A.9 | Pre-existing local mods in commit `06a5730` | §10.9 | REVIEWED — `git show 06a5730 --stat` confirms all contents are legitimate session work artifacts: Jiang2 ShippedDocs analysis, ecosystem synthesis card, GPS navigation layer update to 01_RepoAndEnvironment, PRE-STAGE 1 section addition to 06_BuildSequence. The `06_uiux_pro_max.md` edit (Turing Vault Phase 2 removal) was from a prior session. All intentional. | DECIDED — contents reviewed, all intentional |

### B. Build-out items from audit §11 (PRE-STAGE 1 prerequisites)

| # | Item | Audit § | Action | Stage assignment |
|---|---|---|---|---|
| B.1 | Boot/close/handoff skill+hook pair | §11.3 | "Single most important Velorin recommendation" per `claude-code-skills-full-landscape` research card. Components: `/close-session` skill (`disable-model-invocation: true`) writing structured handoff to known path; `SessionEnd` hook commits + notifies; `SessionStart` (matcher: "startup") hook reads last handoff + injects to context; `SessionStart` (matcher: "compact") hook re-injects after compaction. Eliminates manual session coordination; every bot wakes up with full context. 1-2 sessions. | PRE-STAGE 1 |
| B.2 | GPS lookup MCP tool | §11.1 | `library_lookup(topic_id) → card` MCP server (or Python script + Bash wrapper). Bots stop reading the 1,529-line library file and start querying by topic_id at point-of-need. Boot-token savings + lower context pressure. Few hours. Already implicit in `05_InfrastructureAndTools.md` MCP stack vision. | PRE-STAGE 1 |
| B.3 | Library consumer instruction snippet | §11.8 | ~30-line block in each agent ReadMe / boot sequence: "To find research conclusions, retrieve by `topic_id` from `Velorin.ResearchLibrary.v2.md`. Read the card; follow `source` pointer only if insufficient." Plus example invocations. Without this, agents default to grep-for-keyword instead of GPS retrieval. ~30 min. | PRE-STAGE 1 |
| B.4 | `fidelity:` field in card schema | §11.9 | Three values: `direct-read` (source read in full at card authoring) / `secondhand-vetted` (CT-vetted prior summary brought forward) / `inherited` (taken from upstream library without re-verification). Schema change + one-time backfill. Makes §9.1 limitation explicit per-card. | PRE-STAGE 1 |
| B.5 | `decay-rate:` field in card schema | §11.10 | Four values: `slow` / `medium` / `fast` / `none`. Distinguishes durable Velorin-architecture cards from rapidly-aging-ecosystem cards. Same `date:` field, very different consumer trust. Schema change + one-time backfill. | PRE-STAGE 1 |
| B.6 | Promote roster entries to full cards | §11.6 | Per-card ~20-30 min (read source + write card + update roster). | ON DEMAND — no PRE-STAGE 1 action |
| B.7 | Convert each card to its own file (YAML frontmatter, one file per topic_id) | §11.2 | Per `brain-activation-architecture` Option D — would give Obsidian native backlinks + machine-parseable indexing. Medium effort. | FORMALLY DEFERRED — seam: B.2 GPS lookup tool first; conversion mechanical after that. Defer until GPS lookup proves the access pattern. |
| B.8 | Quarterly fresh-signal check on May-2026 ecosystem card | §11.5 | Trey assignment, every 90 days. AI ecosystem moves fast. | RECURRING — first cycle starts after Stage 1 |
| B.9 | Working.Docs audit | §11.7 | See A.7 above. | FORMALLY DEFERRED |
| B.10 | Boot-verify skill/hook | NEW (logged 2026-04-29 by Jiang1 + CT) | Machine-checkable boot compliance. Reads canonical boot list from `Velorin.QuickReference.md` Section 1; for each file asserts last non-blank line = `[VELORIN.EOF]` (with the named ResearchLibrary preamble exception); emits `BOOT-VERIFY: N/N files, all EOF-compliant` or names the failures. Closes the Cardinal Document Writing Rule loophole — no agent claims boot complete without proof. Implementation: Claude Code skill OR SessionStart hook that runs after the boot reads and writes to a session log artifact. ~1 session. | OPEN |

### Pre-Stage 1 Completion Gate

**Ledger Verification Status (Jiang2, 2026-04-28 substrate-lock session):**

| State | A-rows | B-rows |
|---|---|---|
| BUILT | A.3, A.4, A.5, A.8 (4) | — |
| DECIDED | A.2, A.9 (2) | — |
| FORMALLY DEFERRED | A.6, A.7 (2) | B.7, B.9 (2) |
| ON DEMAND / RECURRING | — | B.6, B.8 (2) |
| OPEN | **A.1** (1) | **B.1, B.2, B.3, B.4, B.5, B.10** (6) |

Stage 1 Step 1 (Python Stack) does not begin until:
- All A-rows are in BUILT / DECIDED / FORMALLY DEFERRED state — **1 OPEN remaining (A.1 IdentityVerification)**
- All B-rows in PRE-STAGE 1 state are BUILT (B.1 through B.5, B.10 — **6 OPEN, must all reach BUILT**)
- All B-rows in DEFERRED / ON DEMAND / RECURRING state have explicit Standing Principle entries (currently satisfied)

**A.1 blocker:** IdentityVerification research request file does not exist. No file in `Bot.Jiang/Research_Needed/` — only `.gitkeep`. Path-3 blocker per `agent-orchestration` (88%) and `agent-ecosystem-reality` (92%). Must be created or formally deferred with Standing Principle triple before gate closes.

**Standing Principle reminder:** every deferral requires three artifacts — FW registry entry, Check-Ins entry, build-space placeholder. Apply when promoting any deferral above to a future-work item.

---

## Stage 1 — Core Cowork Infrastructure + First Brain Endpoint (Week 1)

**Goal:** All specialist systems reachable from Cowork-Claude. ATV enforcing IES. Tool-routing program operational. First Brain PPR query working. Part 1 functional.

### Step 1 — Python Stack

```bash
pip3 install requests pyyaml qdrant-client opendataloader-pdf hypothesis jsonschema
pip3 install surya-ocr   # fallback OCR; run with PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0
```

### Step 2 — Docker and Qdrant

```bash
# Install Docker Desktop; then:
docker pull qdrant/qdrant
docker run -d --name qdrant --restart unless-stopped \
  -p 6333:6333 \
  -v /Users/lbhunt/Desktop/velorin-system/qdrant_storage:/qdrant/storage \
  qdrant/qdrant
```

### Step 3 — Ollama and Models

```bash
curl -fsSL https://ollama.com/install.sh | sh
ollama pull nomic-embed-text-v2-moe   # required: embedding model
ollama pull qwen2.5-vl:7b             # required: vision extraction
ollama pull qwen3.5:35b-a3b-q4_K_M   # required: fast agentic loops + LLM-judge
# ATV verifier model: after benchmark (Step 7 below)
```

### Step 4 — vllm-mlx (ATV serving backend)

```bash
uv tool install git+https://github.com/waybarrios/vllm-mlx.git
```

### Step 5 — OpenDataLoader Fork

```bash
git clone https://github.com/opendataloader-project/opendataloader-pdf.git \
  /Users/lbhunt/Desktop/velorin-system/tools-and-research/opendataloader
cd /Users/lbhunt/Desktop/velorin-system/tools-and-research/opendataloader
pip3 install -e .
# Customize: pipe JSON bbox outputs → neuron source_coords YAML field
```

### Step 6 — Specialist System Integrations

Wire per-tool invocation surfaces:
- Gemini: Google API key + API library (google-generativeai)
- Codex: OpenAI API key + CLI (`pip install openai`; test `codex --help`)
- GPT 5.5: OpenAI Responses API client (stateless — Velorin Brain is the memory; disable native GPT memory via API config)
- Google visual tools: Google API key + appropriate library
- GitHub skill repos: standard git clone patterns

*→ FW-015: multi-vendor cost economics — model before heavy use, especially GPT 5.5's 272K input-token cost cliff.*
*→ FW-016: Mac Studio multi-vendor security model — OAuth 2.1 constraints for remote MCP from local Mac Studio.*

### Step 7 — ATV Verifier Benchmark + Model Selection

```bash
# Run JSONSchemaBench against candidates (Qwen2.5-0.5B, SmolLM2-1.7B)
# Primary metric: VTPS = (N_total × C) / T_total
# Select winner; pull: ollama pull [winner]
```

Check-Ins entry: ATV verifier re-benchmark every 90 days or when model update available. See `Velorin.CheckIns.md`.

### Step 8 — ARC-2 Tool-Routing Program

Build at `infrastructure/tool_router.py` (or as MCP server `infrastructure/mcp/tool_router/`):
- Column-normalized capability matrix V (initial values from domain knowledge)
- Task intent vector ω_task estimation from task content
- VEGP gate with configurable ε_gap
- Fallback (Ξ=0): ensemble activation of top 2-3 tools; Cowork-Claude integrates
- Per-routing-decision log to `infrastructure/logs/routing/`

### Step 9 — ARC-1 Virtual Contradiction Graph

Build at `infrastructure/contradiction_detector.py`:
- Asymmetric NLI surrogate for detecting cross-tool output conflicts
- Virtual neuron encoding (vendor claim → virtual neuron with source metadata)
- Layer 1 composite score tiebreaker
- Broker activation pattern (Layer 2 deadlock → high-authority orthogonal tool)
- Chairman escalation queue at `infrastructure/queues/contradiction-review/`

### Step 10 — ATV Build (MCP Server)

Build `infrastructure/atv/server.js`:
- Agent wrapper (inspects content blocks; tags analytical_reasoning)
- FSM verifier using XGrammar + vllm-mlx
- Per-message log artifact
- Queue management (bounded queue N=5; overflow → atv-overflow/)
- Schema Registry (git-backed, hash-addressed, SQLite lookup)

### Step 11 — Post-Commit Edge Handler

`infrastructure/hooks/post-commit-edge-handler.sh`:
- Reads `supersedes` and `contradicts` edges in newly committed neurons
- Updates belief_state on target neurons
- Validates skill dependency graph consistency
Install: `cp post-commit-edge-handler.sh .git/hooks/post-commit && chmod +x .git/hooks/post-commit`

### Step 12 — First Brain Endpoint

Write `infrastructure/embed_neuron.py` and `infrastructure/ppr_retrieve.py` (with Φ_causal gate). Create first c-memory seed neuron. Embed. Query. Verify.

### Step 13 — Skills Registry Initialization

Create `skills/skill_dependencies.yaml` with 4-type edge schema. Create first 2-3 pilot skills with typed artifact schemas and prerequisite edges.

### Step 14 — Lamport Timestamp in Neuron YAML (Substrate Lock prerequisite)

Every neuron written from Stage 1 onward MUST include `lamport_ts: 0` in its YAML frontmatter. At Stage 1, this is a simple incrementing integer (write counter). At Stage 3+, the concurrent scheduler uses it for sheaf restriction maps. Installing now prevents prohibitively expensive Stage 3 retrofit.

### Step 15 — Bourgain Bootstrap Rule (Ingestion Pipeline Constraint)

Zero-shot taxonomic pointer generation MUST use LLM logical classification (AST parsing, ontology lookup). Strictly avoid Euclidean cosine-similarity retrieval for hierarchical edges. Bourgain's Embedding Theorem guarantees exponential distortion when embedding hyperbolic hierarchies into flat Euclidean space — the nearest neighbors in Euclidean space systematically misrepresent deep taxonomic ancestry.

### Step 16 — Persistent Homology Spanning-Forest Telemetry

Deploy $\beta\_1$ (Betti-1) computation via spanning-forest filtration at $\mathcal{O}(V+E)$. Persistence threshold $\Delta w \ge 4$ pointer ratings = load-bearing semantic cycle → Layer 3 escalation. Combined with $\Phi\_{causal} > 1.0$: spectral instability warning + topological void isolation. Stage 2 telemetry — does not require the full Brain to be populated.

✅ **Stage 1 complete when:** Cowork-Claude can activate each specialist system and get work back; ATV enforcing IES on tagged analytical outputs; tool-routing program logging decisions; first Brain PPR query returning correct neurons; post-commit hook firing correctly; Lamport timestamps in all neurons; Bourgain bootstrap rule enforced in ingestion.

**"Brain not required to function at this point."** Part 1 is fully operational.

---

## Stage 2 — Agent Configuration (Week 1-2)

**Goal:** All named agents configured and operational. All specialist systems fully integrated.

### Step 1 — Trey Bootloader Audit (BEFORE creating Gems)

```bash
grep -ri "human-curated" Claude.AI/Bot.Trey/Bootloader/
grep -ri "Gatekeeper" Claude.AI/Bot.Trey/Bootloader/
grep -ri "Level [1-4]" Claude.AI/Bot.Trey/Bootloader/
```
Update MathInventory to include Sessions 033-036 Erdős solutions. Confirm AgentRoster reflects Alexander as "Company State Historian," not "CEO Orchestrator."

### Step 2 — Create Trey Gems

Trey1 (general deep research) and Trey2 (Velorin-build-specific). See `04_AgentEcosystem.md`.

### Step 3 — Erdős Gem Verification

Verify [BOOT] sentinel triggers Research_Complete pre-load. Verify CARDINAL math output rule (LaTeX only, no Equation Editor).

### Step 4 — Alexander Configuration

Configure Alexander in Mac Studio Claude Desktop Cowork Sessions as Company State Historian. Update Alexander.ReadMe.First.md to reflect narrowed role.

### Step 5 — Purchase Audio Tools (CT authorization required)

Voibe ($99 lifetime) + MacWhisper Pro (~€59 lifetime).

✅ **Stage 2 complete when:** Each agent can boot and know their role. All specialist systems reachable from Cowork-Claude. Part 1 is fully operational and tested.

---

## PART 2 — Brain Insertion (Local Specialization Layer)

---

## Stage 3 — Brain Population (Month 1 — ongoing)

**Goal:** Brain begins accumulating CT-specific knowledge. Ingestion pipeline handles text documents automatically.

**"Brain not required to function at this point" marker ends here.** Part 2 begins.

### Step 1 — Priority c-memory Seeds (Write by Hand)

Required neurons (c-memory, confidence=1.0, read_only=true):
- `second-law-of-epistemodynamics` (already written in Stage 1)
- `causal-action-potential` (Φ_causal = π_v/α)
- `ppr-density-floor` (ρ*=0.78, 7-pointer cap)
- `independent-row-normalization`
- `window-gravity-definition`
- `velorin-founding-thesis`
- `consensus-filter`
- `jsd-compression-algorithm`
- `build-vs-adopt-rule`
- `five-boxes-framework`
- `four-layer-architecture`
- CT profile neurons: cognitive profile, five boxes stakes, Camfil runway, cardiac event 2004

H_E neurons (grief events): do NOT write yet. H_E passive-inference measurement program must be operational first. See Stage 4.

### Step 2 — Text Ingestion Pipeline v1

Full sequence: OpenDataLoader parse → RDoLT decomposition → NPMI + LLM-judge (forced distribution, 9-class required) → belief_state + authority_tier + source_coords + contradiction_class YAML → post-commit hook fires → Qdrant upsert.

**9-class relation labels REQUIRED** from day 1. Binary routing (P_tax vs P_them) derived from the 9-class label. Not optional.

**Conflict routing config** (`Claude.AI/conflict_routing.yaml`) created alongside ingestion pipeline.

Check-Ins entries (see `Velorin.CheckIns.md`):
- Source multiplier calibration (after 50 resolved Layer 1 contradictions)
- ε threshold calibration (after 50 Layer 2 activations)
- Round-cap review (after 25 Layer 3 escalations)
- contradiction_class routing accuracy per path (after 50 contested cases per path)

### Step 3 — Skills Registry Population

Create pilot skills, wire dependency edges, test reverse-PPR skill injection via Φ_causal gate.

Check-Ins: tool capability matrix recalibration (after 90 days operational or significant tool capability change). See `Velorin.CheckIns.md`.

✅ **Stage 3 complete when:** Brain can answer CT-specific queries from PPR traversal; ingestion pipeline runs automatically on text documents.

*→ Build-space Stage 3 (trigger: N skills in registry, N defined at Stage 3 design): GoS sparse validation mode swap. Seam: `validate_skill_edges(..., validation_mode="dense")`. One-param config change.*
*→ Build-space Stage 3 (trigger: Canary when Cowork routing real production traffic across multiple vendors): Canary grammar rollout. Load balancer config only.*

---

## Stage 4 — Compression Event Detector + H_E Measurement (Month 1+)

**Goal:** Commutator norm monitoring operational. H_E passive inference wired. Brockett flow → JSD compression pipeline functional.

### Step 1 — Commutator-Norm Region Monitor

`infrastructure/commutator_monitor.py`:
- Computes ‖[P_tax|U, P_them|U]‖_F per Brain region
- Tracks Persona Manifold change (symmetric difference over time)
- Triggers LoRa retraining when μ(P(t_now) △ P(t_prev)) > ε_LoRa (Erdős Solution 3 — genuinely new math)
- Suppresses LoRa training on in-flux regions (high commutator spike = CT's transient confusion state)

*→ Build-space Stage 5: RoMem Semantic Speed Gate (trigger: Layer 0 LoRa operational). Seam: `compute_edge_transition_weight(..., mode="ebbinghaus_sde", mode_config={})`. State handover at mode swap: A_base YAML values carry forward; per-session Ã cache discarded.*

### Step 2 — H_E Passive Inference Program

**Option B locked (CT decision).** Never prompts CT directly. Infers from observable signals.

Observable signals (from Trey.Research.EmotionalMemorySalience.Measurement.md):
- Query frequency to neuron relative to its information density
- Dwell time and post-retrieval action sequences
- Involuntary retrieval patterns (neuron surface rate in unrelated queries)
- Cross-domain reference frequency (high-H_E neurons appear across context boundaries)
- Neuron creation cadence for related memories

H_E NOT added to neuron YAML schema yet. H_E is computed on-demand from observable signals; stored in a separate H_E computation log, not in the neuron itself, until the measurement procedure is validated.

Check-Ins design — multi-point distribution across Build Guide phases (full elements a-k, see `Velorin.CheckIns.md`):
- Checkpoint at 100 c-memory neurons
- Checkpoint at 500 neurons
- Full re-evaluation at 1,000 neurons
- Quarterly thereafter

### Step 3 — JSD Compression (κ empirical calibration)

κ analytic formula ($κ = 2C(1-\alpha)/(\alpha\delta)$) is a structural prior only — operationally too loose (Davis-Kahan looseness, spectral-gap volatility). Empirical calibration required.

κ measurement program:
- Runs test compressions on Brain region COPIES (never live Brain)
- Triggers when Brockett flow β < 0.15 in a region
- Tracks Φ_causal degradation on 50-neuron ground truth set
- Alert at >10% mean Φ_causal reduction → halt compression in that region, flag for Jiang review
- Fortnight cadence

Check-Ins: κ calibration review after first 10 test compression events. See `Velorin.CheckIns.md`.

✅ **Stage 4 complete when:** Compression event detector monitors commutator norms; H_E passive inference collecting signal; JSD algorithm firing on region copies.

---

## Stage 5 — Local AI Model + LoRa (After Brain Operational)

**Goal:** Local AI model integrated. LoRa training pipeline operational. Brain-as-operator-guide activation — the Part 2 destination.

**Deliberately deferred.** Cannot choose the right model until Brain is operational with real workloads.

**Hard requirement from Erdős VEGPStressTest Proof 2 (non-negotiable for model selection):**
The chosen model MUST use Softmax-style global attention aggregation. Pure RNN architectures with tanh saturation cannot be used — vanishing gradients prevent IES gate from firing.

*→ Forward note (Stage 5): `base_model_config: {type: "personal", id: "ct-v1"}` governs LoRa training pipeline. Training weights according to Persona Manifold (Commutator Persona result — genuinely new, Erdős Solution 3). Quasi-abelian regions get higher training weight; in-flux regions (high commutator spike) are excluded until commutator stabilizes.*

*→ Build-space Stage 5: FW-004 Layer 3 operator architecture (trigger: OQ-3 design opens). Operator/Reviewer/Authorizer role split for future Mac-Studio local operator.*

**Hardware reality:**
- Qwen 3.6-35B-A3B MoE: for fast agentic loops (3B active params compute per token)
- Gemma 4-31B: for long-context reasoning with TurboQuant (KV cache 3.8-4.9× compression, viable on 36GB)
- 70B+ models: RTX 4090 Windows build (blocked on ARM64 Claude Code bug #12160 — buy RAM now)

✅ **Stage 5 complete when:** Local model hosts LoRa; Brain-as-operator-guide influences Cowork routing (Part 2 destination reached).

---

## Phase 4 — Intake Test (LAST ITEM BEFORE BUILD COMPLETE)

The structured decision-scenario experience that reveals CT's reasoning patterns and generates the first structured batch of cross-domain Brain neurons. Originally scoped as Part 1 trigger; CT decision (2026-04-26): placed as Phase 4 final step.

By the time this fires, c-memory neurons have accumulated organically through normal CT-Brain interaction during Phases 1-3. The formalized intake test is a final-stage validation/tidying step, not the boot mechanism.

See `07_OpenQuestions.md` for formal OQ-9 status.

---

---

## DECISIONS LOCKED (Jiang2 Novel Ideas — Resolved 2026-04-28, Substrate Lock)

All five ideas reviewed via Erdős FullStackAudit + Trey FullStackPressureTest + Erdős FinalSubstrateLock. Verdicts below.

**IDEA 1 — Quick-Capture Layer: ADOPTED with quarantine gate + Abelian Buffer Invariant.**
Three async intake channels (voice watcher, URL bookmarklet, email forward) feed into a Quarantine/ directory. A scheduled parser converts raw input to the 15-line neuron format. Manual approval before Layer 3 entry. The Abelian Buffer Invariant (concurrent async channels must be orthogonalized via Gram-Schmidt before synchronous integration) prevents density violations. Build alongside Stage 1 ingestion pipeline.

**IDEA 2 — IES Fire Rate as Commutator-Norm Proxy: ADOPTED with bias caveat.**
Add `topic_domain: string` to ATV per-message log at Stage 1. The proxy $\hat{\beta} = c\sqrt{f\_{IES}}$ is negatively biased (Jensen's inequality) but asymptotically consistent at $\mathcal{O}(N^{-1/2})$. Usable when the structural commutator signal dominates noise: $\alpha\beta^2 \gg \text{Var}(\sigma^2)$. Seeds Stage 3 Persona Manifold estimation before formal commutator computation is feasible.

**IDEA 3 — Two-Pass Relation Classification: ADOPTED.**
Crossover condition proven: two-pass dominates when $p\_2 > p\_{single}/p\_1$. Because the binary tax/them margin is highly separable, $p\_1 \to 1$, and the conditional 6-way entropy is lower than flat 9-way. Additionally, the CIB Lagrangian mandates that both passes use counterfactual ablations (Pearl do-calculus) rather than observational associations for pruning decisions. **Bourgain bootstrap rule:** zero-shot taxonomic pointer generation must use LLM logical classification (AST/ontology), strictly avoiding Euclidean cosine-similarity for hierarchical edges.

**IDEA 4 — Gauge Fiber as belief\_state geometry: ADOPTED — dual-verified.**
The mapping $\phi(b) = b \cdot \mathbf{e}\_8$ preserves PPR invariance ($\mathbf{e}\_8 \perp \mathcal{M}\_{sem}$, so the projection commutes with the graph Laplacian). Belief-state filtering becomes $\mathcal{O}(1)$ per walk step via dot product. Precondition: $H\_E$ must map to the zero-section. Proven independently by Erdős (FullStackAudit A.4) and validated by Trey (FullStackPressureTest §2.4).

**IDEA 5 — Persona-Maker from Brain Statistics: ADOPTED — Dirichlet prior dominance proven.**
Graph invariant statistics (boundary density, traversal weights) map to a Dirichlet prior $\pi\_G(\theta)$ on the Persona Manifold. Statistically derived prior dominates hand-authored heuristics when the empirical Fisher Information of the subgraph exceeds the precision matrix of human-authored guides: $\text{Tr}(\mathcal{I}(G)) > \text{Tr}(\text{Var}(\pi\_{hand})^{-1})$. Activates at FW-009 composite trigger (500 c-memory neurons + CT initiation).

[VELORIN.EOF]

