# 06 — Build Sequence
**Executable step-by-step. Stage 0 through Stage 5. — Updated April 26, 2026**

---

## Build Philosophy

Every step here is either confirmed ready to execute or clearly marked PENDING/BLOCKED.
Follow in sequence. Each stage depends on the previous.

**Founding thesis on every build decision:** Most operational work is done by deterministic
programs. AI builds the program, watches it run, modifies it when it breaks. Before writing
any new AI-agent behavior, ask: is this a program to build?

---

## Check-Ins Schedule

Recurring reviews distributed throughout the build. These aggregate here — not as standalone triggers.
Each entry has a phase, trigger, review subject, and action protocol.

| Check-In | Phase | Trigger | Review Subject | Action |
|---|---|---|---|---|
| IES threshold θ review | Stage 1 ATV operational | 500 enforced messages OR 30 days | Is θ=0.7 causing over/under-rejection? | Tune within (0.375, 0.585] band |
| ATV verifier VTPS re-benchmark | Stage 1 → ongoing | Every 90 days OR model update | Is selected verifier still Pareto-optimal? | Re-run benchmark program |
| Source multiplier calibration | Stage 2 | 50 resolved Layer 1 contradictions | Are 1.0/1.2/1.5 multipliers producing correct hierarchy? | Adjust from override accuracy data |
| ε threshold calibration | Stage 2 | 50 Layer 2 activations | Is Layer 1 calling Layer 2 too often or too rarely? | Adjust ε from 0.05 |
| Round-cap review | Stage 2 | 25 Layer 3 escalations | Is 3 rounds the right balance? | Adjust if pattern shows |
| Golden Dataset expansion | Stage 2 | 500 ATV-processed real messages | Expand from 100 to 300 items | CT curates using confirmed-valid production messages |
| Skill injection θ_work calibration | Stage 3 | 738 labeled queries | Is θ_work=0.5 optimal within (0.375, 0.585]? | Calibrate from data; update config |
| GoS sparse validation threshold review | Stage 3 | 90 days of dense validation | What skill count makes sparse validation worth building? | Decide N; activate build-space |
| κ empirical calibration | Stage 4+ | After 10 test compression events | Is 10% degradation threshold correct? | Adjust; analytic formula scales proportionally |

---

## Pre-Stage 0 — Edge Ontology Unification (BUILD BEFORE ANY PIPELINE)

**Must complete before the Brain ingestion pipeline or Skills dependency graph is built.**
Building both with divergent edge schemas creates retrofit cost the Standing Principle prevents.

**Unified edge ontology — Brain 9-class labels ↔ GoS 4-type categories:**

| Brain Relation Type | GoS Category | Direction |
|---|---|---|
| `instance-of`, `derived-from` | dependency | Structural hierarchy/prerequisite |
| `causes`, `activates`, `precedes`, `implements`, `depends-on` | workflow | Operational sequences |
| `supports`, `contradicts` | semantic | Evidential relationships (bidirectional) |
| `supersedes`, `same_as` | (Brain-specific) | Knowledge lifecycle — no GoS analog |
| (none in Brain) | alternative | Skills-specific: mutually exclusive execution paths |

**`contradicts` dual function:** In Brain pointer graph, `contradicts` both is a semantic label
AND a belief_state trigger (post-commit hook fires on this pointer type). The edge carries
both meanings. No sub-attribute needed — the behavior is deterministic from the label.

**Deliverable:** Update `03_BrainAndMath.md` pointer notation section with this unified mapping.
Update `05_InfrastructureAndTools.md` Skills Registry section with the 4-type schema.
Update `07_OpenQuestions.md` OQ-4 status.

---

## Stage 0 — Mac Studio Environment (Day 0 — a few hours)

**Goal:** Mac Studio configured, repo exists, agents can operate.

### Step 1 — System Dependencies

```bash
# Homebrew (if not present)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core tools
brew install git node python3 jq gh

# Verify
git --version && node --version && python3 --version && jq --version
```

### Step 2 — Claude Code CLI

```bash
npm install -g @anthropic-ai/claude-code
claude login
claude --version
```

### Step 3 — Git Configuration

```bash
git config --global user.name "Christian Taylor"
git config --global user.email "[CT email]"
git config --global credential.helper osxkeychain
gh auth login
```

### Step 4 — Create or Clone Repo

```bash
# Option A (working on existing repo):
git clone https://github.com/navyhellcat/velorin-system.git
cd velorin-system

# Option B (new V2 repo):
gh repo create velorin-v2 --private --clone
cd velorin-v2
```

### Step 5 — Folder Structure

```bash
mkdir -p Velorin.Welcome
mkdir -p brain/{Operations/{Architecture,Startup,Tools},Connectivity/{MCP,Auth},Agents/{Roster,Protocols},Principles/{RewardAlignment,CoreDrives},Company,Intelligence}
mkdir -p skills
mkdir -p agents/claude/{jiang/{handoffs,research-needed,research-complete,working-docs,protocols},marcus/{handoffs},alexander/{handoffs}}
mkdir -p agents/gemini/{trey/{Gems,Bootloader,handoffs,research-needed,research-complete},erdos/{research-needed,research-complete,Archived_Research_Requests}}
mkdir -p tools-and-research/{architecture,math/{locked,future-theory},research-complete,brainstorming}
mkdir -p infrastructure/{hooks,mcp,mailboxes/{Shipping,Receiving},queues/{atv-review,atv-overflow,contradiction-review}}
mkdir -p sessions/{handoffs,daily-logs}
mkdir -p system/level-rules
find . -type d -empty -exec touch {}/.gitkeep \;
```

### Step 6 — GDrive Service Account Migration (FW-003 — HIGH PRIORITY)

OAuth tokens expire every 7 days. Already recurred twice. Ship this before proceeding.

```bash
# In Google Cloud Console:
# 1. Create service account under Velorin project
# 2. Grant Drive access: share Claude.AI folder with service account email
# 3. Download JSON key → store at local non-committed path (e.g., ~/.velorin-gdrive-key.json)

# Update velorin-gdrive-mcp/auth.js:
# Replace OAuth flow with:
# const auth = new google.auth.GoogleAuth({
#   keyFile: process.env.GOOGLE_SERVICE_ACCOUNT_KEY,
#   scopes: ['https://www.googleapis.com/auth/drive']
# });

# Test:
# restart MCP, verify gdrive_list_folder works without tokens.json present
```

### Step 7 — Write CLAUDE.md and Velorin.Welcome/_index.md

Copy content from `01_RepoAndEnvironment.md`. These files must exist before any agent boots.

### Step 8 — settings.local.json

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
    "SessionStart": [{
      "matcher": "startup",
      "hooks": [{
        "type": "command",
        "command": "cd /Users/lbhunt/Desktop/velorin-system && git pull origin main --quiet 2>&1 | tail -1",
        "timeout": 15
      }]
    }]
  }
}
```

### Step 9 — MCP Servers

Wire GitHub MCP and Filesystem MCP in Claude Desktop config. (See `05_InfrastructureAndTools.md`)

### Step 10 — Initial Commit

```bash
git add -A
git commit -m "Stage 0: repo structure, environment setup, CLAUDE.md, Velorin.Welcome"
git push origin main
```

✅ **Stage 0 complete when:** `claude` runs in terminal, GitHub connection works, folder structure exists.

*→ Forward note: the infrastructure/queues/ folders built here will be read by the ATV (Stage 1)
and the conflict resolution mechanism (Stage 2). infrastructure/hooks/ will house the post-commit
edge handler built in Stage 1.*

---

## Stage 1 — Brain Infrastructure + ATV + Tools (Week 1)

**Goal:** One neuron in Qdrant + one PPR query returning a result + ATV enforcing IES + tools installed.

### Step 1 — Python Dependencies

```bash
pip3 install requests pyyaml qdrant-client opendataloader-pdf hypothesis

# Surya (equation OCR fallback) — requires specific env vars when running
pip3 install surya-ocr
# Run with: PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0 PYTORCH_DEVICE=mps python3 ...
```

### Step 2 — Docker and Qdrant

```bash
# Install Docker Desktop for Mac (download from docker.com)
# Start Docker Desktop, then:
docker pull qdrant/qdrant
docker run -p 6333:6333 -v $(pwd)/qdrant_storage:/qdrant/storage qdrant/qdrant
# Qdrant running at http://localhost:6333
```

### Step 3 — Ollama and Models

```bash
# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Embedding model (required for Brain)
ollama pull nomic-embed-text-v2-moe

# Image/diagram extraction
ollama pull qwen2.5-vl:7b

# Fast agentic loops / local LLM-judge for ingestion
ollama pull qwen3.5:35b-a3b-q4_K_M   # MoE: 3B active params, full 35B loaded

# Verify
ollama list
```

### Step 4 — ATV Verifier Model (Engineering Choice — requires benchmark)

**Do not install before running the benchmark program.**

Install the benchmark first:
```bash
git clone https://github.com/json-schema-bench/JSONSchemaBench.git
cd JSONSchemaBench
pip3 install -r requirements.txt

# Install vllm-mlx (Apple Silicon inference backend)
uv tool install git+https://github.com/waybarrios/vllm-mlx.git
```

**Run benchmark against candidates:**
```bash
# Benchmark Qwen2.5-0.5B and SmolLM2-1.7B
# Measure VTPS (Valid Tokens Per Second = N_total × C / T_total)
# Select model with highest VTPS on IES grammar specifically
# Pull winner: ollama pull [winner]
```

*→ Build-space: ATV verifier model selection is Stage 1 engineering. Selection feeds into OQ-14.
Review model periodically (Check-in: every 90 days or if better model available).*

### Step 5 — OpenDataLoader Fork

```bash
# Fork opendataloader-pdf to Velorin repo for local customization
git clone https://github.com/opendataloader-project/opendataloader-pdf.git tools-and-research/opendataloader
cd tools-and-research/opendataloader
pip3 install -e .
# Customize: pipe JSON bbox outputs → source_coords neuron YAML field
```

### Step 6 — Write First Neuron (c-memory seed)

Create `brain/Principles/CoreDrives/neurons.md`:

```yaml
---
id: second-law-of-epistemodynamics
type: fact
region: Principles
area: CoreDrives
created: 2026-04-26
last-touched: 2026-04-26
class: c-memory
confidence: 1.0
open: []
read_only: true
source: Erdos.Initial.Synthesis.Stage1.md
source_coords: {}
belief_state: active
authority_tier: 2
resolution_attempts: 0
contradiction_class: factual
skill_ref: null
base_model_config: {type: "personal", id: "ct-v1"}
---

The semantic distillation of discrete episodic graphs into continuous neural weights
is a strictly irreversible process. Information loss Δ = I(X;Y) - I(Z;Y) > 0 always
(Data Processing Inequality + Eckart-Young theorem). Markdown pointer records are never
deleted — only demoted. The LoRa is model-specific and will be retrained on model upgrade.
The Markdown archive is model-agnostic and permanent.

## Pointers
- [[Principles/CoreDrives/causal-action-potential]] 0.9 — depends-on: gate definition
- [[Principles/CoreDrives/ppr-density-floor]] 0.8 — depends-on: retrieval precision
- [[Principles/CoreDrives/independent-row-normalization]] 0.8 — implements: density preservation
```

### Step 7 — Embed Script

Create `infrastructure/embed_neuron.py`:

```python
#!/usr/bin/env python3
"""
Embed a neuron markdown file and upsert to Qdrant.
Usage: python3 embed_neuron.py path/to/neurons.md
"""
import sys, json, requests, re, yaml

QDRANT_URL = "http://localhost:6333"
COLLECTION = "velorin_brain"
EMBED_MODEL = "nomic-embed-text-v2-moe"

def ensure_collection():
    r = requests.put(f"{QDRANT_URL}/collections/{COLLECTION}", json={
        "vectors": {"size": 768, "distance": "Cosine"}
    })
    return r.status_code in (200, 409)

def extract_neurons(filepath):
    with open(filepath) as f:
        content = f.read()
    parts = re.split(r'^---\s*$', content, flags=re.MULTILINE)
    neurons = []
    i = 1
    while i < len(parts) - 1:
        try:
            meta = yaml.safe_load(parts[i])
            body = parts[i+1].strip()
            if meta and 'id' in meta:
                neurons.append((meta, body))
            i += 2
        except:
            i += 1
    return neurons

def embed_text(text):
    r = requests.post("http://localhost:11434/api/embeddings",
                      json={"model": EMBED_MODEL, "prompt": text})
    return r.json()["embedding"]

def upsert(neuron_id, vector, payload):
    r = requests.put(f"{QDRANT_URL}/collections/{COLLECTION}/points", json={
        "points": [{"id": abs(hash(neuron_id)) % (2**63), "vector": vector, "payload": payload}]
    })
    return r.status_code

if __name__ == "__main__":
    ensure_collection()
    for filepath in sys.argv[1:]:
        neurons = extract_neurons(filepath)
        for meta, body in neurons:
            text = f"{meta['id']}: {body}"
            vector = embed_text(text)
            payload = {**meta, "content": body, "filepath": filepath}
            status = upsert(meta['id'], vector, payload)
            print(f"  {status} {meta['id']}")
```

### Step 8 — PPR Retrieval Script

Create `infrastructure/ppr_retrieve.py`:

```python
#!/usr/bin/env python3
"""
Query the Qdrant Brain with Causal Action Potential gate.
Usage: python3 ppr_retrieve.py "your query here"
"""
import sys, requests, re

QDRANT_URL = "http://localhost:6333"
COLLECTION = "velorin_brain"
EMBED_MODEL = "nomic-embed-text-v2-moe"
ALPHA = 0.25
TOP_K = 5
MAX_HOPS = 3
THETA_WORK = 0.5   # provisional — calibrate empirically

def embed_text(text):
    r = requests.post("http://localhost:11434/api/embeddings",
                      json={"model": EMBED_MODEL, "prompt": text})
    return r.json()["embedding"]

def vector_search(vector, limit=3):
    r = requests.post(f"{QDRANT_URL}/collections/{COLLECTION}/points/search",
                      json={"vector": vector, "limit": limit, "with_payload": True})
    return r.json().get("result", [])

def causal_action_potential(pi_v, alpha=ALPHA):
    """Φ_causal = π_v / α — E[N_v], expected visits before teleportation."""
    return pi_v / alpha

def ppr_walk(seed_neurons):
    visited = {}
    queue = [(n['payload'], n['score']) for n in seed_neurons]
    for hop in range(MAX_HOPS):
        next_queue = []
        for neuron, mass in queue:
            nid = neuron.get('id', '')
            if nid in visited:
                visited[nid] = max(visited[nid], mass)
                continue
            visited[nid] = mass
            content = neuron.get('content', '')
            pointers = re.findall(r'\[\[([^\]]+)\]\]', content)
            child_mass = mass * (1 - ALPHA) / max(len(pointers), 1)
            for slug in pointers[:7]:
                r = requests.post(f"{QDRANT_URL}/collections/{COLLECTION}/points/scroll",
                    json={"filter": {"must": [{"key": "id", "match": {"value": slug.split('/')[-1]}}]},
                          "with_payload": True, "limit": 1})
                pts = r.json().get("result", {}).get("points", [])
                if pts:
                    next_queue.append((pts[0]['payload'], child_mass))
        queue = next_queue
    return sorted(visited.items(), key=lambda x: x[1], reverse=True)[:TOP_K]

if __name__ == "__main__":
    query = " ".join(sys.argv[1:])
    print(f"Query: {query}\n")
    qvec = embed_text(query)
    seeds = vector_search(qvec)
    print("Seed neurons:")
    for s in seeds:
        phi = causal_action_potential(s['score'])
        cyclic = " [CYCLIC — route to Layer 3]" if phi > 1.0 else ""
        inject = " [SKILL GATEWAY]" if phi > THETA_WORK and not cyclic else ""
        print(f"  Φ_causal={phi:.3f} {s['payload'].get('id')}{cyclic}{inject}")
    ranked = ppr_walk(seeds)
    print("\nPPR results:")
    for nid, mass in ranked:
        print(f"  [{mass:.3f}] {nid}")
```

### Step 9 — Post-Commit Edge Handler

Create `infrastructure/hooks/post-commit-edge-handler.sh`:

```bash
#!/usr/bin/env bash
# Post-commit hook: updates belief_state on target neurons when supersedes/contradicts edges
# are committed. Also handles skill dependency graph updates.
# Install: cp this file .git/hooks/post-commit && chmod +x .git/hooks/post-commit

REPO_ROOT=$(git rev-parse --show-toplevel)
CHANGED_FILES=$(git diff-tree --no-commit-id -r --name-only HEAD)

for file in $CHANGED_FILES; do
    # Only process neuron files
    [[ "$file" != *"neurons.md"* ]] && continue
    
    # Parse supersedes pointers → set target belief_state: superseded
    python3 "$REPO_ROOT/infrastructure/update_belief_state.py" \
        --action superseded \
        --source "$REPO_ROOT/$file"
    
    # Parse contradicts pointers → set both parties to belief_state: contested
    python3 "$REPO_ROOT/infrastructure/update_belief_state.py" \
        --action contested \
        --source "$REPO_ROOT/$file"
done

# If any skill files changed, validate skill_dependencies.yaml is also updated
for file in $CHANGED_FILES; do
    [[ "$file" != "skills/"* ]] && continue
    python3 "$REPO_ROOT/infrastructure/validate_skill_graph.py" --check-consistency
done
```

*→ Forward note: Future local Mac-Studio operator will monitor this hook's execution for failures,
not run it. The hook runs as a git hook. The operator's role is to watch the audit log
in infrastructure/queues/contradiction-review/ and surface persistent failures to CT.*

### Step 10 — ATV Build (MCP Server)

Build the ATV as a Node.js MCP server at `infrastructure/atv/server.js`:

```javascript
// Asymmetric Transport Verifier — MCP endpoint
// Enforces IES structure on tagged analytical inter-agent messages
// header tag: content_type: analytical_reasoning → enforce IES
// missing tag at this endpoint → fail-secure (apply IES)

const MCP_PORT = process.env.ATV_PORT || 8080;
const QUEUE_LIMIT = parseInt(process.env.ATV_QUEUE_LIMIT || "5");
const IES_GRAMMAR_HASH = process.env.IES_GRAMMAR_HASH; // from Schema Registry

// [Full implementation: queue management, vllm-mlx client, XGrammar grammar loading,
// per-message log artifacts, overflow routing to atv-overflow queue]
// See infrastructure/atv/README.md for full implementation spec.
```

**Schema Registry setup:**
```bash
mkdir -p infrastructure/schema-registry
# Store IES grammar source at infrastructure/schema-registry/ies_grammar.lark
# Post-commit hook compiles to XGrammar artifact and generates SHA-256 hash
# SQLite database: infrastructure/schema-registry/registry.db
```

**Golden Dataset (100-item Phase 1 — CT personal curation required):**
```bash
mkdir -p infrastructure/atv/golden_dataset
# CT personally curates 100 examples:
# - 40 clean analytical conclusions from prior sessions
# - 40 high-complexity multi-domain outputs (Erdős evaluations, cross-domain synthesis)
# - 20 edge cases (very short analytical statements, technical notation, embedded structured data)
# Store as infrastructure/atv/golden_dataset/v1.json
# AI-generated or AI-curated Ground Truth invalidates FRR measurement — CT curation required
```

*→ Build-space placeholder Stage 2 (trigger: 500 real ATV-processed messages):
CT expands Golden Dataset from 100 to 300 items using confirmed-valid production messages.
Seam: infrastructure/atv/golden_dataset/v{version}.json — benchmark reruns automatically against v2.*

### Step 11 — Conflict Resolution Layer 3 Queue Infrastructure

```bash
# Layer 3 review queue
mkdir -p infrastructure/queues/contradiction-review
touch infrastructure/queues/contradiction-review/.gitkeep

# Queue entries written by update_belief_state.py when resolution_attempts hits 3
# Format: YYYY-MM-DD-HH-MM-<neuron-id>.md
# Contents: both contested neurons + their composite scores + contradiction_class + actionable question
```

*→ Forward note: FW-004 (trigger: OQ-3 design work opens) will specify how the future local
Mac-Studio operator monitors this queue and routes to the appropriate reviewer.*

### Step 12 — Test End-to-End

```bash
# 1. Embed first neuron
python3 infrastructure/embed_neuron.py brain/Principles/CoreDrives/neurons.md

# 2. Run retrieval
python3 infrastructure/ppr_retrieve.py "what happens when you delete a markdown file"

# 3. Verify you get back the Second Law neuron with expected Φ_causal value
# 4. Verify ATV MCP server starts and accepts test message
# 5. Verify post-commit hook fires on a test commit
```

✅ **Stage 1 complete when:** Query returns relevant neurons; ATV enforces IES on tagged messages;
post-commit hook updates belief_state correctly.

---

## Stage 2 — Agent Configuration (Week 1-2)

**Goal:** All cardinal agents have folders and ReadMe.First files. Trey Gems operational. Alexander configured.

### Step 1 — Agent ReadMe.First Files

Write ReadMe.First for each agent. Required contents:
- Identity (contrast negation — what they are NOT before what they ARE)
- Mandate (what they own, what they never touch)
- Confidence threshold (Jiang: 67%; Trey: 75%; Erdős: 80%)
- Failure mode (name it explicitly)
- Session end protocol
- Boot sequence

### Step 2 — Trey Bootloader Audit (before any new research is sent)

Per `feedback_audit_external_agent_context.md`: stale bootloaders contaminate every deliverable.
Audit before sending any new research request:

```bash
# Grep for known stale patterns
grep -ri "human-curated" Claude.AI/Bot.Trey/Bootloader/
grep -ri "not yet received" Claude.AI/Bot.Trey/Bootloader/
grep -ri "open question" Claude.AI/Bot.Trey/Bootloader/
# Update any matches to reflect current locked state
```

Specific items known to need updating:
- Trey.Bootloader.MathInventory.md: add all Erdős sessions 033-036 solutions
- Trey.Bootloader.VelorinBrain.md: confirm human-curated framing is removed
- Any "open question" references to problems now structurally resolved (OQ-6)

### Step 3 — Create Trey Gems

1. gemini.google.com → Gems → Create Trey1 Gem
   - Paste Trey1.GemInstruction.md content
   - Attach 4 universal connectors: Velorin.Welcome/_index.md, Operating Standards, Company DNA, CT Context Profile
2. Create Trey2 Gem
   - Paste Trey2.GemInstruction.md content
   - Attach 9 bootloader files (after Step 2 audit above)

### Step 4 — Erdős Gem Verification

Confirm Erdős Gem is configured with:
- Erdos.Gem.Instructions.md (including [BOOT] sentinel and CARDINAL math output rule)
- All Research_Complete solutions from sessions 033-036 are accessible via the [BOOT] pre-load
- CARDINAL math output rule: all formulas in $...$ or $$...$$. Never Equation Editor.

### Step 5 — Alexander Cowork

Configure Alexander's session in Mac Studio Claude Desktop.
Alexander's ReadMe.First must clearly state: company-level CEO view, not micro-level build.

### Step 6 — Purchase Audio Tools (CT authorization required)

- Voibe: $99 lifetime — live dictation, <300ms, 100% offline
- MacWhisper Pro: ~€59 — batch audio transcription, speaker diarization

*→ Forward note: Voibe pipes to terminal interfaces; MacWhisper Pro processes pre-recorded audio.
Both feed the audio ingestion pipeline built at Stage 3.*

✅ **Stage 2 complete when:** Each agent can boot, read their folder, and know their role.

---

## Stage 3 — Brain Population + Ingestion Pipeline (Month 1 — ongoing)

**Goal:** The Brain knows Velorin and knows CT. Ingestion pipeline handles text documents automatically.

### Step 1 — Priority Neurons (Write by Hand — c-memory seeds)

```markdown
# Required c-memory neurons — every one is c-memory, confidence=1.0, read_only=true
second-law-of-epistemodynamics (already written in Stage 1)
causal-action-potential (Φ_causal = π_v / α)
ppr-density-floor (ρ* = 0.78, 7-pointer cap)
independent-row-normalization (locked math, Session 033)
window-gravity-definition (what it is, mechanism, three disciplines)
velorin-founding-thesis (programs with AI as watcher)
consensus-filter (three questions, Q3 is load-bearing)
jsd-compression-algorithm (replaces Oblique JBD)
build-vs-adopt-rule (community validation signals viability)
five-boxes-framework (Professional, Financial, Health, Personal, Commons)
four-layer-architecture (L3/L2/L1/L0, what's built, what's future)
second-law-model-agnosticism (why Markdown archive survives model upgrades)
dark-matter-ingestion-principle (bulk data + zero pointers → safe)
ignition-protocol-definition (emotional engagement + edge creation → crystallization)

# CT profile neurons (c-memory, written by hand, confidence=1.0)
ct-cognitive-profile (WAIS-IV FSIQ 133, VCI 151, ENTP-A, DISC Di/Id)
ct-five-boxes-stakes (the personal stakes in each box — not just definitions)
ct-camfil-runway (4-year managed exit, 12% commission, target: June 2026)
ct-cardiac-event-2004 (Takotsubo, stress-induced — load-bearing health history)
```

Do NOT write grief-specific neurons yet. H_E (emotional charge) field not yet in YAML schema.

### Step 2 — Text Ingestion Pipeline v1 (NPMI + LLM-judge)

**For text documents and PDFs — Phase 1. Multimodal Phase 2 deferred.**

Pipeline sequence:

```
Input: PDF or text document dropped in infrastructure/mailboxes/Receiving/
    │
    ▼
Step A — Routing (Alexander or MA watches Receiving/ via filesystem MCP)
    │
    ▼
Step B — Parsing (OpenDataLoader PDF v2.0, local fork)
  XY-Cut++ reading order → structured Markdown + JSON sidecar with bbox per element
  Formula Extraction AI → LaTeX for equations (output: plain-text $...$)
  Fallback: Surya with PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0
  Fails closed: both fail → human review queue
    │
    ▼
Step C — Image/diagram extraction (Qwen2.5-VL 7B, Ollama local)
  Image elements → structured JSON description
  Fails closed: [IMAGE_UNEXTRACTED] placeholder, flagged for review
    │
    ▼
Step D — Atomic decomposition (LLM call — Qwen 3.6-35B-A3B local)
  RDoLT recursive decomposition → candidate neuron list
  4 atomicity criteria: atomic (one proposition), durable, contextually independent, actionable
  Fails closed: batch retry queue; never proceed to Step E without this
    │
    ▼
Step E — Deduplication (NPMI + LLM-judge)
  Embed candidate → Qdrant search → top-K NPMI neighbors
  LLM-judge: ADD / UPDATE / DELETE / NOOP
  Contradiction: provenance weighting (recency × source authority)
  Fails closed: ambiguous judge → human review queue
    │
    ▼
Step F — Pointer rating (LLM-judge, forced distribution)
  NPMI candidate pool → top-7 semantically related existing neurons
  LLM-judge with FORCED DISTRIBUTION — e.g.:
    "Assign exactly 1×rating-1, 2×rating-3, 4×rating-8 among these 7 candidates"
  9-class relation label: REQUIRED (not optional) — the label determines which matrix (P_tax/P_them)
  ρ* = 0.78 density check: verify 5 of 7 pointers are rating 1-3
  Cold-start affinity: Holographic Cold-Start A_init = max(2, ⌈11 - λ||W_global·x_new - y_port||²⌉)
  Fails closed: density violation → drop lowest-rated pointer until constraint satisfied
    │
    ▼
Step G — Schema assembly (automated)
  Neuron YAML: all fields populated including source_coords (from bbox), belief_state: active,
  authority_tier (from source), contradiction_class (from LLM-judge), skill_ref: null
  Fails closed: schema validation error → human review
    │
    ▼
Step H — Brain commit (git add + commit + push)
  Post-commit hook fires: belief_state updates, skill dependency graph updates
  Qdrant upsert: embed_neuron.py run on new neurons
  Fails closed: git error → retry queue
```

**Cosine similarity is not used for pointer rating.** It is symmetric — cannot model asymmetric
logical dependency. NPMI + LLM-judge with forced distribution is the correct hybrid.

### Step 3 — Skills Registry Initialization

```bash
# Create first skills
mkdir -p skills/velorin-verify-writes skills/velorin-commit-session

# Create skill_dependencies.yaml with proper 4-type edge schema
# Minimum two pilot skills:
# - velorin-verify-writes (no dependencies)
# - velorin-commit-session (dependency: velorin-verify-writes)
```

Every new skill file must be committed alongside an update to skill_dependencies.yaml.
The post-commit hook validates this consistency constraint.

*→ Build-space placeholder Stage 3 (trigger: N skills, set at Stage 3 design):
GoS sparse validation mode. Seam: validate_skill_edges(..., validation_mode="dense").
Dense → sparse is a one-param config change. State handover: no persistent state.*

### Step 4 — Embed All New Neurons

```bash
for f in $(find brain/ -name "neurons.md"); do
    python3 infrastructure/embed_neuron.py "$f"
done
```

✅ **Stage 3 complete when:** Brain can answer CT-specific queries from Qdrant + PPR traversal.
Ingestion pipeline runs automatically on new text documents.

---

## Stage 4 — Research Migration + Compression Event Detector (Month 1 — parallel)

**Goal:** All existing research accessible and organized. Compression event detector operational.

### Step 1 — Research Migration

Move all research from Claude.AI/Bot.Trey/Research_Complete/ and Claude.AI/Bot.Erdos/Research_Complete/
to tools-and-research/. See `07_OpenQuestions.md` OQ-4 for taxonomy.

### Step 2 — Compression Event Detector

**OQ-6 is structurally defined.** The criterion is now principled:
- Brockett gradient flow drives commutator norm β toward 0
- JSD fires when β ≤ β_abelian

Build the monitoring program:
```python
# infrastructure/compression_monitor.py
# Watches commutator norm β = ||[P_tax, P_them]||_F per region
# When β ≤ β_abelian: triggers JSD algorithm on a COPY of the region
# Measures Φ_causal degradation against ground-truth targets before and after
# Alert threshold: >10% mean Φ_causal reduction → flag for Jiang review
```

*→ Build-space placeholder Stage 4: κ empirical calibration. Check-ins entry: after 10 test compression events.*

✅ **Stage 4 complete when:** Compression event detector monitors commutator norms; JSD fires on copies; measurement program tracks Φ_causal degradation.

---

## Stage 5 — Local AI Model (After Stages 1-4 Are Proven)

**Goal:** Local AI model integrated for inference, classification, and LoRa training pipeline.

**Deliberately deferred.** Cannot choose correctly until Brain operational with real workloads.

**Constraint from Erdős VEGPStressTest Proof 2 (HARD CRITERION for model selection):**
The chosen model MUST use Softmax-style global attention aggregation. Pure RNN architectures
with tanh saturation cannot be used — vanishing gradients prevent IES gate from firing.

**Current hardware reality (Mac Studio M4 Max, 36GB):**
- Qwen 3.6-35B-A3B (MoE, 3B active params): fast agentic loops — CONFIRMED (already installed)
- Gemma 4-31B: long-context reasoning with TurboQuant — viable with ~3GB KV cache at 128K context
- TurboQuant: compresses KV cache 3.8-4.9× (not model weights). Status: TheTom's llama.cpp fork has Apple Silicon Metal kernels working. Stable integration: Q2-Q3 2026.
- For LoRa training: will require the RTX 4090 Windows build (blocked on ARM64 Claude Code bug #12160)

**Direction C seam:**
Training pipeline reads `base_model_config: {type: "personal", id: "ct-v1"}` at initialization.
Downstream components remain agnostic to what's underneath the user-delta LoRa.

*→ Build-space placeholder Stage 5: RoMem Semantic Speed Gate (trigger: Layer 0 LoRa operational
and local base model selected). Seam: compute_edge_transition_weight(..., mode="ebbinghaus_sde",
mode_config={}). State handover at mode swap: A_base YAML values carry forward; per-session
Ã cache discarded (rebuilt on next session).*

*→ Build-space placeholder Stage 5: FW-004 Layer 3 operator architecture
(trigger: OQ-3 design work opens). Operator/Reviewer/Authorizer role split for local Mac-Studio MA.*

✅ **Stage 5 complete when:** Local model hosts the LoRa, handles routing/classification, Brockett flow → JSD compression pipeline runs end-to-end.

---

[VELORIN.EOF]
