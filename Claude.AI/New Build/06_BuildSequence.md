# 06 — Build Sequence
**Executable step-by-step. Stage 0 through Stage 5. — Updated April 26, 2026**

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

### Step 4 — Folder Structure

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

### Step 7 — Pre-Stage 0 Edge Ontology Unification

Execute the mapping above. Confirm `skill_dependencies.yaml` will use 4-type edge schema from day 1 of Stage 1 Skills build.

✅ **Stage 0 complete when:** Claude Code boots, GitHub connected, folder structure exists, GDrive service account works without OAuth prompts.

*→ Forward note (Stage 1): the infrastructure/queues/ folders built here will be read by ATV (contradiction-review, atv-review, atv-overflow) and the conflict resolution mechanism.*

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

✅ **Stage 1 complete when:** Cowork-Claude can activate each specialist system and get work back; ATV enforcing IES on tagged analytical outputs; tool-routing program logging decisions; first Brain PPR query returning correct neurons; post-commit hook firing correctly.

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

[VELORIN.EOF]

---

## ⚠️ DECISIONS TO BE MADE (Jiang2 Novel Ideas — Not Yet Approved)

CT asked Jiang2 for further ideas. These were surfaced but NOT approved. Review and decide.

**IDEA 1 — Quick-Capture Layer (addresses Brain Dead Reckoning)**
Brain only updates during Claude sessions. Between sessions CT reads, thinks, experiences — Brain stays behind. Three simple programs (<50 lines each) would close the gap: (a) voice folder watcher → MacWhisper → ingestion pipeline (CT drops voice memo, Brain gets it); (b) URL bookmarklet → ingestion queue; (c) email forward alias → ingestion pipeline. All use the existing ingestion pipeline — they're just new async intake channels. Would add alongside Stage 1 ingestion build. **CT decision needed: build yes/no.**

**IDEA 2 — IES Fire Rate as Commutator-Norm Proxy (Stage 1→3 bridge)**
IES fire rate per topic domain is a passive signal for commutator norm magnitude. High IES firing on topic X = CT is still at the frontier of X (Frontier Manifold). Low firing = quasi-abelian for CT (Persona Manifold candidate). Adding `topic_domain: string` to the ATV per-message log turns Stage 1 ATV logs into early training data for Stage 3's Persona Manifold estimation — before the Brain has enough neurons for formal commutator computation. One field addition. **CT decision needed: add the field yes/no.**

**IDEA 3 — Two-Pass Relation Classification (ingestion pipeline improvement)**
Current 9-class classification asks the LLM to handle easy (taxonomic) and hard (thematic sub-types) in one call. Better: Pass 1 = binary tax/them (~95-97% accurate, satisfies Multiplex Tensor routing); Pass 2 = thematic sub-type from 6 options (~85-90% accurate with few-shot). Cascading difficulty improves accuracy. **CT decision needed: adopt two-pass yes/no.**

**IDEA 4 (THEORY) — Gauge Fiber as belief_state geometry**
Erdős proved d_max=7 in 8D creates a Gauge Fiber isolated from semantic topology (where H_E lives). Conjecture: belief_state could map to a scalar coordinate in this fiber (active=+1, contested=0, superseded=-1), making PPR routing filter O(1) per walk step vs O(disk I/O). At millions of neurons, significant. Erdős request filed at `Claude.AI/Bot.Erdos/Research_Needed/Erdos.ResearchRequest.GaugeFiberBeliefState.md`. **CT decision needed: keep the Erdős request in queue yes/no.**

**IDEA 5 (THEORY) — Persona-Maker personality guides from Brain statistics**
Instead of manually authoring personality guides for Persona-Maker sub-agents, derive them from the quasi-abelian sub-graph pointer statistics for the target domain. High-affinity neurons = key concepts to emphasize; most-traversed edges = reasoning sequences to favor; boundary neurons = frontier concepts to treat carefully. Mathematically grounds personality in CT's actual cognitive structure. Erdős request filed at `Claude.AI/Bot.Erdos/Research_Needed/Erdos.ResearchRequest.PersonaMakerFromBrainStatistics.md`. **CT decision needed: keep the Erdős request in queue yes/no.**

