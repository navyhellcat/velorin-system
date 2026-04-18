# 06 — Build Sequence
**Executable step-by-step. Day 0 through Month 1.**

Every step here is either confirmed ready to execute or clearly marked PENDING RESEARCH.
Follow in sequence. Each stage depends on the previous.

---

## Stage 0 — Mac Studio Environment (Day 0 — a few hours)

**Goal:** Mac Studio is configured, repo exists, agents can operate.

```bash
# 1. Install Homebrew and system tools
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git node python3 jq gh

# 2. Install Claude Code CLI
npm install -g @anthropic-ai/claude-code
claude login

# 3. Configure git
git config --global user.name "Christian Taylor"
git config --global user.email "[email]"
git config --global credential.helper osxkeychain
gh auth login

# 4. Create or clone repo
# Option A (new repo):
gh repo create velorin-v2 --private --clone
cd velorin-v2

# Option B (migrate existing):
git clone https://github.com/navyhellcat/velorin-system.git
cd velorin-system
```

**Create the folder structure:**
```bash
mkdir -p Velorin.Welcome
mkdir -p brain/{Operations/{Architecture,Startup,Tools},Connectivity/{MCP,Auth},Agents/{Roster,Protocols},Principles/{RewardAlignment,CoreDrives},Company,Intelligence}
mkdir -p agents/claude/{jiang/{handoffs,research-needed,research-complete,working-docs,protocols},marcus/{handoffs},alexander/{handoffs}}
mkdir -p agents/gemini/{trey/{Gems,Bootloader,handoffs,research-needed,research-complete},erdos/{research-needed,research-complete,Archived_Research_Requests}}
mkdir -p tools-and-research/{architecture,math/{locked,future-theory},research-complete/{memory-systems,protocols,tools,ai-ecosystem,velorin-specific},brainstorming,external-tools}
mkdir -p infrastructure/{hooks,mcp,mailboxes/{Shipping,Receiving}}
mkdir -p sessions/{handoffs,daily-logs}
mkdir -p system/level-rules

# Add gitkeep to empty folders
find . -type d -empty -exec touch {}/.gitkeep \;
```

**Write CLAUDE.md** (copy from `01_RepoAndEnvironment.md`)

**Write Velorin.Welcome/_index.md** (copy from `01_RepoAndEnvironment.md`)

**Configure settings.local.json:**
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

**Wire MCP servers** (copy from `01_RepoAndEnvironment.md`)

**Initial commit:**
```bash
git add -A
git commit -m "Stage 0: Repo structure and environment setup"
git push origin main
```

✅ **Stage 0 complete when:** You can run `claude` in terminal, it connects to GitHub,
and the folder structure exists.

---

## Stage 1 — Brain Infrastructure (Week 1 — a focused day)

**Goal:** One neuron in Qdrant, one PPR query returning a result.
This is the proof that the retrieval stack works.

**Step 1: Install Docker and Qdrant**
```bash
# Install Docker Desktop for Mac
# Download from docker.com/products/docker-desktop — install and start it

# Pull and run Qdrant
docker pull qdrant/qdrant
docker run -p 6333:6333 -v $(pwd)/qdrant_storage:/qdrant/storage qdrant/qdrant
# Qdrant now running at http://localhost:6333
```

**Step 2: Install Ollama and embedding model**
```bash
# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Pull embedding model
ollama pull nomic-embed-text-v2-moe
# This is the confirmed model: local, free, MRL-enabled (multi-precision)

# Verify
ollama list
```

**Note on local inference model:** The model that will actually RUN the Brain
(routing, classification, the LoRa host) is NOT yet decided. nomic-embed is
only for embedding (converting text to 1536D vectors). The inference model
decision is deferred to after the architecture is proven.

**Step 3: Write the first neuron**

Create `brain/Principles/CoreDrives/neurons.md`:

```markdown
---
id: second-law-of-epistemodynamics
type: fact
region: Principles
area: CoreDrives
created: 2026-04-17
last-touched: 2026-04-17
class: c-memory
confidence: 1.0
open: []
read_only: true
---

The semantic distillation of discrete episodic graphs into continuous neural weights
is a strictly irreversible process. Information loss Δ = I(X;Y) - I(Z;Y) > 0 always.
Markdown pointer records are never deleted — only demoted. The LoRa is model-specific
and will be retrained. The Markdown archive is model-agnostic and permanent.

## Pointers
- [[Principles/CoreDrives/ppr-density-floor]] 0.8 — relation-type: depends-on
- [[Principles/CoreDrives/demotion-oracle]] 0.8 — relation-type: implements
```

**Step 4: Write the embed script (~40 lines)**

Create `infrastructure/embed_neuron.py`:
```python
#!/usr/bin/env python3
"""
Embed a neuron markdown file and upsert to Qdrant.
Usage: python3 embed_neuron.py path/to/neurons.md [neuron_id]
"""
import sys
import json
import requests
import subprocess
import re
import yaml

QDRANT_URL = "http://localhost:6333"
COLLECTION = "velorin_brain"
EMBED_MODEL = "nomic-embed-text-v2-moe"

def ensure_collection():
    """Create Qdrant collection if it doesn't exist."""
    r = requests.put(f"{QDRANT_URL}/collections/{COLLECTION}", json={
        "vectors": {"size": 768, "distance": "Cosine"}
    })
    return r.status_code in (200, 409)  # 409 = already exists

def extract_neurons(filepath):
    """Parse neurons.md and extract individual neuron entries."""
    with open(filepath) as f:
        content = f.read()
    # Split on YAML frontmatter boundaries
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
    """Get embedding via Ollama."""
    r = requests.post("http://localhost:11434/api/embeddings",
                      json={"model": EMBED_MODEL, "prompt": text})
    return r.json()["embedding"]

def upsert(neuron_id, vector, payload):
    """Upsert point to Qdrant."""
    r = requests.put(f"{QDRANT_URL}/collections/{COLLECTION}/points", json={
        "points": [{"id": hash(neuron_id) % (2**63), "vector": vector, "payload": payload}]
    })
    return r.status_code

if __name__ == "__main__":
    filepath = sys.argv[1]
    ensure_collection()
    neurons = extract_neurons(filepath)
    for meta, body in neurons:
        text = f"{meta['id']}: {body}"
        vector = embed_text(text)
        payload = {**meta, "content": body, "filepath": filepath}
        status = upsert(meta['id'], vector, payload)
        print(f"Upserted {meta['id']}: {status}")
```

**Step 5: Write the PPR retrieval script (~60 lines)**

Create `infrastructure/ppr_retrieve.py`:
```python
#!/usr/bin/env python3
"""
Query the Qdrant Brain and run a simple PPR-style traversal.
Usage: python3 ppr_retrieve.py "your query here"
"""
import sys
import json
import requests
import yaml
import os

QDRANT_URL = "http://localhost:6333"
COLLECTION = "velorin_brain"
EMBED_MODEL = "nomic-embed-text-v2-moe"
ALPHA = 0.25
TOP_K = 5
MAX_HOPS = 3

def embed_text(text):
    r = requests.post("http://localhost:11434/api/embeddings",
                      json={"model": EMBED_MODEL, "prompt": text})
    return r.json()["embedding"]

def vector_search(vector, limit=3):
    r = requests.post(f"{QDRANT_URL}/collections/{COLLECTION}/points/search",
                      json={"vector": vector, "limit": limit, "with_payload": True})
    return r.json().get("result", [])

def get_by_id(neuron_id):
    # Look up by payload id field
    r = requests.post(f"{QDRANT_URL}/collections/{COLLECTION}/points/scroll",
                      json={"filter": {"must": [{"key": "id", "match": {"value": neuron_id}}]},
                            "with_payload": True, "limit": 1})
    results = r.json().get("result", {}).get("points", [])
    return results[0] if results else None

def parse_pointers(content):
    """Extract pointer slugs from neuron content."""
    import re
    return re.findall(r'\[\[([^\]]+)\]\]', content)

def ppr_walk(seed_neurons, query_vector):
    """Simple PPR-style traversal from seed neurons."""
    visited = {}
    queue = [(n['payload'], 1.0) for n in seed_neurons]
    
    for hop in range(MAX_HOPS):
        next_queue = []
        for neuron, mass in queue:
            nid = neuron.get('id', '')
            if nid in visited:
                visited[nid] = max(visited[nid], mass)
                continue
            visited[nid] = mass
            # Follow pointers (teleportation decay)
            content = neuron.get('content', '')
            pointer_slugs = parse_pointers(content)
            child_mass = mass * (1 - ALPHA) / max(len(pointer_slugs), 1)
            for slug in pointer_slugs[:7]:  # respect 7-pointer cap
                child = get_by_id(slug.split('/')[-1])
                if child:
                    next_queue.append((child['payload'], child_mass))
        queue = next_queue
    
    # Sort by mass, return top K
    ranked = sorted(visited.items(), key=lambda x: x[1], reverse=True)[:TOP_K]
    return ranked

if __name__ == "__main__":
    query = " ".join(sys.argv[1:])
    print(f"Query: {query}\n")
    
    # Seed from vector search
    qvec = embed_text(query)
    seeds = vector_search(qvec, limit=3)
    
    print("Seed neurons (Qdrant):")
    for s in seeds:
        print(f"  [{s['score']:.3f}] {s['payload'].get('id', 'unknown')}")
    
    # PPR walk
    ranked = ppr_walk(seeds, qvec)
    
    print("\nPPR results:")
    for nid, mass in ranked:
        print(f"  [{mass:.3f}] {nid}")
```

**Step 6: Test end to end**
```bash
# 1. Run embed on first neuron
python3 infrastructure/embed_neuron.py brain/Principles/CoreDrives/neurons.md

# 2. Run retrieval
python3 infrastructure/ppr_retrieve.py "what happens when you delete a markdown file"

# 3. Verify you get back something about the Second Law
```

✅ **Stage 1 complete when:** You type a query and get back relevant neurons.

---

## Stage 2 — Agent Configuration (Week 1-2)

**Goal:** All 4 cardinal agents have their folders and ReadMe.First files.
Trey Gems created. Erdős Gem confirmed operational.

**Step 1: Write agent ReadMe.First files**

For each agent, write their ReadMe.First in their folder.
Key elements each must have:
- Identity (using contrast negation — what they are NOT before what they ARE)
- Mandate (what they own, what they never touch)
- Confidence threshold (Jiang: 67% minimum. Trey: 75% minimum. Erdős: 80% for math.)
- Failure mode (name it explicitly)
- Session end protocol (what they do before closing)
- Boot sequence (what they read first)

See `04_AgentEcosystem.md` for each agent's specifics.

**Step 2: Write Trey Gem instructions**

The existing Gem instructions at `agents/gemini/trey/Gems/` were written in Session 026.
They are the current correct version. Create the Gems:

1. Go to gemini.google.com → Gems
2. Create Trey1 Gem → paste Trey1.GemInstruction.md content
3. Attach 4 universal connectors: Velorin.Welcome/_index.md, Operating Standards,
   Company DNA, Context Profile
4. Create Trey2 Gem → paste Trey2.GemInstruction.md content
5. Attach 9 bootloader files from agents/gemini/trey/Bootloader/

**Step 3: Erdős Gem**
Deep Think Gem is already operational. Verify it is configured with Erdos.Gem.Instructions.md.

**Step 4: Alexander Cowork**
Verify Cowork Sessions feature exists in Mac Studio Claude Desktop.
Create Alexander's session following instructions in `04_AgentEcosystem.md`.
This may require exploring the current Cowork UI — the exact setup process is TBD.

✅ **Stage 2 complete when:** Each agent can boot, read their folder, and know their role.

---

## Stage 3 — Brain Population (Month 1 — ongoing)

**Goal:** The Brain knows Velorin and knows CT.

**Step 1: Populate Company/ region**

These are the neurons the Brain needs to reason about the company:

Priority neurons to write first:
- `second-law-of-epistemodynamics` (already written in Stage 1)
- `ppr-density-floor` (ρ* = 0.78, 7-pointer cap, why it works)
- `window-gravity-definition` (what it is, mechanism, counter-measures)
- `build-vs-adopt-rule` (community validation signals viability, not adoption)
- `five-boxes-framework` (Professional, Financial, Health, Personal, Commons)
- `four-layer-architecture` (L3/L2/L1/L0, what's built, what's future)
- `velorin-product-sentence` ("Someone who holds all your threads at once")
- `second-law-model-agnosticism` (why the Markdown archive survives model upgrades)
- `dark-matter-ingestion-principle` (bulk data + zero pointers → safe ingestion)
- `ignition-protocol-definition` (emotional engagement + edge creation → crystallization)

**Step 2: Populate Intelligence/ region**

These are Jiang's research conclusions as neurons. Currently exist as long documents.
Each concluded research topic becomes 2-5 neurons capturing the key findings.

Priority research to extract:
- Window Gravity (ArchitecturalPivot → key mechanism and fixes)
- Agent Orchestration (Claude Agent SDK as runtime, not framework)
- Instruction Language Architecture (3-layer model, FollowBench ceiling)
- Human Brain Layers (7 functional layers, hippocampal indexing, 4 operational gaps)
- TurboQuant and MemPalace (what they are, how they fit, what's adopted)
- Agent Teams Boot Degradation (compaction bug, TEAM_STATE.md fix, NOT_PLANNED by Anthropic)

**Step 3: CT profile neurons (c-memory)**

These are the most important neurons in the Brain.
Write these by hand. Every one is c-memory, confidence = 1.0, read_only = true.

Required neurons:
- Cognitive profile (WAIS-IV FSIQ 133, VCI 151, ENTP-A, DISC Di/Id)
- The five boxes as CT experiences them (not just definitions — the personal stakes)
- Camfil as the runway (4-year managed exit, 12% commission, target: June 2026 exit)
- The cardiac event (2004, Takotsubo, stress-induced — load-bearing health history)
- The significance container (empty since ~2016, what it contained before)
- The default trajectory (powerful, lukewarm, alone — what Velorin is built to prevent)

**Do not write grief-specific neurons yet.** The H_E (emotional charge) field is
not yet in the YAML schema. Wait for that design decision before creating neurons
for the three loss events. The constraint is architectural, not personal.

**Step 4: Embed all new neurons into Qdrant**
```bash
# Embed all neurons.md files in the brain/
for f in $(find brain/ -name "neurons.md"); do
    python3 infrastructure/embed_neuron.py "$f"
done
```

✅ **Stage 3 complete when:** You can query the Brain and it returns relevant CT-specific
context, not just system knowledge.

---

## Stage 4 — Research Migration (Month 1 — parallel with Stage 3)

**Goal:** All existing research is accessible and organized.

Move existing research from the old `Claude.AI/` structure to `tools-and-research/`:

```bash
# Example: move Trey research to correct subfolder
# (adjust based on actual current file locations)

# Memory systems research
cp Claude.AI/Bot.Trey/Research_Complete/OperatingPaper_Letta_MemGPT.md \
   tools-and-research/research-complete/memory-systems/
cp Claude.AI/Bot.Trey/Research_Complete/OperatingPaper_LangGraph.md \
   tools-and-research/research-complete/memory-systems/
cp Claude.AI/Bot.Trey/Research_Complete/OperatingPaper_Mem0.md \
   tools-and-research/research-complete/memory-systems/

# Protocol research
cp Claude.AI/Bot.Trey/Research_Complete/Trey.Topic.MCP_A2A_Architecture_Consolidated.md \
   tools-and-research/research-complete/protocols/

# Tools research
cp Claude.AI/Bot.Trey/Research_Complete/TurboQuant_DeepDive_Math_Tool.md \
   tools-and-research/research-complete/tools/
# ... continue for all research files
```

**All Erdős math goes to tools-and-research/math/locked/:**
- All Session 022-024 proofs and syntheses
- Royal Society paper
- Ignition Protocol formalization

**All future theory goes to tools-and-research/math/future-theory/:**
- Temporal Memory Theory
- Dimensional Geology (theoretical, NOT for implementation)

**Architecture docs go to tools-and-research/architecture/:**
- All synthesis documents, session analysis, V2 Blueprint

✅ **Stage 4 complete when:** Any agent can navigate to any research they need
without knowing which bot folder it used to live in.

---

## Stage 5 — Local AI Model (TBD — After Stages 1-4 Are Proven)

**This stage is deliberately deferred.**

The local AI model decision (which model hosts the LoRa, handles routing and
classification) cannot be made before the Brain is operational. The model must
be chosen based on what the Brain needs — and the Brain needs aren't fully known
until it's been used.

**What we know:**
- Mac Studio M4 Max, 36GB unified memory
- nomic-embed-text-v2-moe handles embedding (already installed in Stage 1)
- For inference: Qwen3 14B Q4_K_M fits comfortably at ~10-11GB
- For code tasks: Qwen3-Coder-30B MoE at ~18GB (swaps with 14B — cannot run simultaneously)
- 70B models: not viable on 36GB. Wait for the RTX 4090 build (blocked on ARM64 Claude Code bug #12160)

**What's unknown:**
- Whether Qwen3 14B is the right routing/classification model for Velorin's workload
- How the local model integrates with the Brain retrieval pipeline
- Whether TurboQuant compression should be applied (Q2-Q3 2026 for stable llama.cpp integration)

**When to revisit:** After Stages 1-4 are working and you have real workloads
to optimize against. Come back to this stage with data.

---

[VELORIN.EOF]
