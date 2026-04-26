# Velorin — Mac Studio Setup and Integration Guide
**Everything to download, install, configure, and connect. April 26, 2026.**
**Execute in order. Each section depends on the previous.**

---

## Phase 0 — Before Anything Else

### 0.1 — GDrive Service Account Migration (CRITICAL — FW-003)

OAuth tokens expire every 7 days. Do this first.

```bash
# 1. Open Google Cloud Console → APIs & Services → Credentials
# 2. Create Service Account: name "velorin-gdrive-sa"
# 3. Grant role: Editor (or specifically Drive access)
# 4. Share the Google Drive folder "Claude.AI" with: velorin-gdrive-sa@[project].iam.gserviceaccount.com
# 5. Create and download JSON key file → save to: ~/.velorin-gdrive-key.json (NEVER commit this file)
# 6. Add to .gitignore: echo ".velorin-gdrive-key.json" >> ~/.gitignore_global

# 7. Update velorin-gdrive-mcp/auth.js:
# const auth = new google.auth.GoogleAuth({
#   keyFile: process.env.GOOGLE_APPLICATION_CREDENTIALS || process.env.HOME + '/.velorin-gdrive-key.json',
#   scopes: ['https://www.googleapis.com/auth/drive']
# });

# 8. Test:
GOOGLE_APPLICATION_CREDENTIALS=~/.velorin-gdrive-key.json node /path/to/velorin-gdrive-mcp/server.js
```

---

## Phase 1 — System Foundation

### 1.1 — Homebrew and Core Tools

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git node python3 jq gh
```

### 1.2 — Claude Code CLI

```bash
npm install -g @anthropic-ai/claude-code
claude login
# Set to 1M context model in settings.local.json (see 1.5)
```

### 1.3 — Git Configuration

```bash
git config --global user.name "Christian Taylor"
git config --global user.email "[CT email]"
git config --global credential.helper osxkeychain
gh auth login
```

### 1.4 — Clone Repo

```bash
git clone https://github.com/navyhellcat/velorin-system.git /Users/lbhunt/Desktop/velorin-system
cd /Users/lbhunt/Desktop/velorin-system
```

### 1.5 — settings.local.json (~/.claude/settings.local.json)

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

---

## Phase 2 — Python Stack

### 2.1 — Python Dependencies

```bash
pip3 install requests pyyaml qdrant-client

# Document parsing
pip3 install opendataloader-pdf

# Grammar and schema testing (for ATV)
pip3 install hypothesis jsonschema

# Audio processing
pip3 install openai-whisper   # For custom Whisper builds (MacWhisper handles the GUI)

# OCR fallback (Surya — install but only run with env vars)
pip3 install surya-ocr

# SQLite (usually pre-installed on macOS, verify)
python3 -c "import sqlite3; print('SQLite OK')"
```

### 2.2 — Surya Environment Variables

Create `~/.zshrc` additions:
```bash
# Surya on Apple Silicon — prevents MPS memory leaks
export SURYA_MPS_WATERMARK="0.0"
# Usage: PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0 PYTORCH_DEVICE=mps python3 [script]
```

---

## Phase 3 — Docker and Qdrant

```bash
# Install Docker Desktop for Mac
# Download: https://www.docker.com/products/docker-desktop
# Open Docker Desktop → let it start

# Pull Qdrant
docker pull qdrant/qdrant

# Run Qdrant (persistent storage)
docker run -d \
  --name qdrant \
  --restart unless-stopped \
  -p 6333:6333 \
  -v /Users/lbhunt/Desktop/velorin-system/qdrant_storage:/qdrant/storage \
  qdrant/qdrant

# Verify
curl http://localhost:6333/health
```

---

## Phase 4 — Ollama and AI Models

### 4.1 — Ollama Installation

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

### 4.2 — Required Models

Pull in this order (size awareness — 36GB total memory, ~26-28GB effective):

```bash
# 1. Embedding model (always needed, small, install first)
ollama pull nomic-embed-text-v2-moe
# Size: ~274MB. Multi-precision (MRL-enabled). Used for all Brain embeds.

# 2. Vision model (needed for image/diagram extraction in ingestion)
ollama pull qwen2.5-vl:7b
# Size: ~5.5GB. Zero cloud dependency for visual extraction.

# 3. Fast agentic model (local LLM-judge for ingestion + classification tasks)
ollama pull qwen3.5:35b-a3b-q4_K_M  # Qwen 3.6 MoE: 3B active params, ~20GB loaded
# If qwen3.5 naming differs, try: ollama pull qwen3:30b-a3b-q4_K_M
# Verify size fits in ~26-28GB effective VRAM alongside OS overhead

# 4. ATV verifier model (select AFTER running benchmark — see Phase 6)
# Placeholder — install after benchmark selects winner:
# ollama pull qwen2.5:0.5b      # ~400MB — fastest, try first
# ollama pull smollm2:1.7b      # ~1.2GB — higher accuracy option

# Verify all models
ollama list
```

### 4.3 — vllm-mlx (Apple Silicon inference backend — for ATV serving)

```bash
# Install uv (fast Python package manager)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install vllm-mlx
uv tool install git+https://github.com/waybarrios/vllm-mlx.git

# Verify
vllm-mlx --version

# Test serving (replace with winner from benchmark)
# vllm-mlx serve qwen2.5:0.5b --continuous-batching
```

---

## Phase 5 — MCP Server Configuration

### 5.1 — Claude Desktop MCP Config

Edit: `~/Library/Application Support/Claude/claude_desktop_config.json`

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "[your-classic-ghp_* token]"
      }
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem",
               "/Users/lbhunt/Desktop/velorin-system"]
    },
    "qdrant": {
      "command": "npx",
      "args": ["-y", "mcp-server-qdrant"],
      "env": {
        "QDRANT_URL": "http://localhost:6333"
      }
    },
    "atv": {
      "command": "node",
      "args": ["/Users/lbhunt/Desktop/velorin-system/infrastructure/atv/server.js"],
      "env": {
        "ATV_PORT": "8080",
        "ATV_QUEUE_LIMIT": "5",
        "IES_GRAMMAR_HASH": "latest"
      }
    }
  }
}
```

**NEVER ADD:** claude-code as an MCP server (causes mcp__claude-code__ prefix bug).

**After GDrive service account migration, also add:**
```json
{
  "velorin-gdrive": {
    "command": "node",
    "args": ["/path/to/velorin-gdrive-mcp/server.js"],
    "env": {
      "GOOGLE_APPLICATION_CREDENTIALS": "/Users/lbhunt/.velorin-gdrive-key.json"
    }
  }
}
```

---

## Phase 6 — OpenDataLoader and Media Tools

### 6.1 — OpenDataLoader PDF Fork

```bash
git clone https://github.com/opendataloader-project/opendataloader-pdf.git \
  /Users/lbhunt/Desktop/velorin-system/tools-and-research/opendataloader
cd /Users/lbhunt/Desktop/velorin-system/tools-and-research/opendataloader
pip3 install -e .
# Modify source to pipe bbox JSON outputs → neuron source_coords YAML field
```

### 6.2 — JSONSchemaBench (ATV verifier benchmark)

```bash
git clone https://github.com/json-schema-bench/JSONSchemaBench.git \
  /Users/lbhunt/Desktop/velorin-system/tools-and-research/JSONSchemaBench
cd /Users/lbhunt/Desktop/velorin-system/tools-and-research/JSONSchemaBench
pip3 install -r requirements.txt
```

---

## Phase 7 — ATV Build

### 7.1 — Run Verifier Benchmark

```bash
# Start vllm-mlx serving candidate models
# Run JSONSchemaBench against each candidate
# Measure VTPS = (N_total × C) / T_total
# C = 1 only if output fully conforms to IES schema; else C = 0
# Select model with highest VTPS on IES grammar

# Example benchmark run (adjust for actual JSONSchemaBench interface):
cd /Users/lbhunt/Desktop/velorin-system/tools-and-research/JSONSchemaBench
python3 run_benchmark.py \
  --model qwen2.5:0.5b \
  --schema /path/to/ies_schema.json \
  --golden_dataset /path/to/atv/golden_dataset/v1.json \
  --metric vtps
```

### 7.2 — Build ATV MCP Server

```bash
mkdir -p /Users/lbhunt/Desktop/velorin-system/infrastructure/atv
cd /Users/lbhunt/Desktop/velorin-system/infrastructure/atv

# Initialize Node.js project
npm init -y
npm install @modelcontextprotocol/sdk express sqlite3

# Build server.js implementing:
# - Per-message log artifact (message_id, tag_present, IES_enforced, T_V_seconds, etc.)
# - Queue with N=5 limit (configurable via ATV_QUEUE_LIMIT env)
# - Overflow → infrastructure/queues/atv-overflow/
# - Anomalies → infrastructure/queues/atv-review/
# - vllm-mlx client for verifier inference
# - XGrammar grammar loading from Schema Registry

# Build agent wrapper (wrapper.py or wrapper.js):
# - Inspects response content blocks for tool_use vs prose generation
# - Tags prose > N_tokens with content_type: analytical_reasoning
# - Routes tagged messages to ATV MCP endpoint
# Ships with ATV as one Stage 1 component — no Phase 1/Phase 2 split
```

### 7.3 — Schema Registry Setup

```bash
mkdir -p /Users/lbhunt/Desktop/velorin-system/infrastructure/schema-registry

# Create IES grammar source
# Grammar must enforce: <context_boundary_check>, <consensus_extraction>,
# <velorin_divergence_evaluation>, <final_conclusion> in order

# Compile to XGrammar artifact:
# python3 compile_grammar.py ies_grammar.lark → generates hash, stores artifact

# SQLite registry:
# sqlite3 registry.db "CREATE TABLE grammars (hash TEXT PRIMARY KEY, path TEXT, created_at DATETIME);"
```

---

## Phase 8 — Audio Tools

### 8.1 — Voibe (CT purchase required — $99 lifetime)

- Purchase at: getvoibe.com
- Install macOS app
- Configure VS Code and terminal integration
- Provides: <300ms real-time dictation, 100% offline, Apple Silicon optimized

### 8.2 — MacWhisper Pro (CT purchase required — ~€59 lifetime)

- Purchase at: goodsnooze.gumroad.com/l/macwhisper
- Install macOS app
- Use for: batch pre-recorded audio transcription with speaker diarization

---

## Phase 9 — Cowork Sessions (Alexander)

### 9.1 — Claude Desktop Cowork Configuration

1. Open Claude Desktop on Mac Studio
2. Find "Cowork Sessions" or equivalent in the interface
3. Create Alexander's persistent session with:
   - Alexander's ReadMe.First as system context
   - Access to same GitHub repo as all other agents
4. Verify session persists across machine restarts

---

## Phase 10 — Trey Gem Setup

### 10.1 — Audit Bootloaders First

Before creating Gems, audit the Trey bootloader files for stale content:

```bash
cd /Users/lbhunt/Desktop/velorin-system
grep -ri "human-curated" Claude.AI/Bot.Trey/Bootloader/ && echo "FOUND — update before creating Gems"
grep -ri "not yet received" Claude.AI/Bot.Trey/Bootloader/ && echo "FOUND — update"
grep -ri "open question" Claude.AI/Bot.Trey/Bootloader/ && echo "FOUND — verify current status"

# Also update Trey.Bootloader.MathInventory.md to include Sessions 033-036 Erdős solutions
```

### 10.2 — Create Gems

1. Go to gemini.google.com → Gems
2. Create Trey1 Gem:
   - Paste Trey1.GemInstruction.md as instructions
   - Attach: Velorin.Welcome/_index.md, Operating Standards, Company DNA, CT Context Profile
3. Create Trey2 Gem:
   - Paste Trey2.GemInstruction.md as instructions
   - Attach all 9 Bootloader files (post-audit)
4. Verify Erdős Deep Think Gem is configured with Erdos.Gem.Instructions.md including:
   - [BOOT] sentinel and Research_Complete pre-load instruction
   - CARDINAL math output rule (LaTeX in $...$ only — NO Equation Editor)
   - Consensus Filter CARDINAL on Trey-originated framing

---

## Phase 11 — Git Hooks Installation

```bash
# Install post-commit edge handler
cp /Users/lbhunt/Desktop/velorin-system/infrastructure/hooks/post-commit-edge-handler.sh \
   /Users/lbhunt/Desktop/velorin-system/.git/hooks/post-commit
chmod +x /Users/lbhunt/Desktop/velorin-system/.git/hooks/post-commit

# Verify hook fires on test commit
echo "# test" >> /tmp/test_neuron.md
git add /tmp/test_neuron.md 2>/dev/null || true
# Watch for hook output
```

---

## Phase 12 — Validation Checklist

Before declaring Mac Studio operational:

```bash
# ✅ 1. Claude Code CLI boots and connects to GitHub
claude --version && gh repo view navyhellcat/velorin-system

# ✅ 2. Qdrant is running and accessible
curl http://localhost:6333/health | python3 -m json.tool

# ✅ 3. Ollama serves all required models
ollama list | grep -E "nomic-embed|qwen2.5-vl|qwen3"

# ✅ 4. First neuron embeds and retrieves correctly
python3 /Users/lbhunt/Desktop/velorin-system/infrastructure/embed_neuron.py \
  /Users/lbhunt/Desktop/velorin-system/brain/Principles/CoreDrives/neurons.md
python3 /Users/lbhunt/Desktop/velorin-system/infrastructure/ppr_retrieve.py \
  "what happens when you delete a markdown file"

# ✅ 5. ATV MCP server starts without error
node /Users/lbhunt/Desktop/velorin-system/infrastructure/atv/server.js &
sleep 2
curl http://localhost:8080/health

# ✅ 6. MCP servers in Claude Desktop respond
# Test via Claude: "list files in the velorin-system repo"

# ✅ 7. GDrive service account works (no OAuth prompts)
# Test via gdrive MCP: list files in Claude.AI folder

# ✅ 8. Post-commit hook fires on test commit
echo "test" >> /tmp/test_hook.txt
# git add + commit → watch for hook execution output

# ✅ 9. Trey Gems boot with correct bootloaders (no stale content)
# Manually verify one Trey session boots with expected context

# ✅ 10. Erdős Gem boots with [BOOT] sentinel and loads Research_Complete
# Manually verify one Erdős session with [BOOT] shows prior proof awareness
```

---

## Quick Reference — Running Services

| Service | Command | Port/Location | Status Check |
|---|---|---|---|
| Qdrant | `docker start qdrant` (if stopped) | http://localhost:6333 | `curl localhost:6333/health` |
| Ollama | Runs as daemon after install | http://localhost:11434 | `curl localhost:11434/api/tags` |
| ATV MCP | `node infrastructure/atv/server.js` | http://localhost:8080 | `curl localhost:8080/health` |
| vllm-mlx | `vllm-mlx serve [model]` | Configurable | Check process list |
| Docker | Docker Desktop app | — | Docker Desktop status bar |

---

## Environment Variables Reference

```bash
# Add to ~/.zshrc or ~/.bash_profile

# Velorin root
export VELORIN_ROOT="/Users/lbhunt/Desktop/velorin-system"

# GDrive service account (after migration from OAuth)
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.velorin-gdrive-key.json"

# Surya — ONLY set when running Surya (not globally, can affect other PyTorch)
# Run: PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0 PYTORCH_DEVICE=mps python3 [script]

# ATV configuration
export ATV_PORT="8080"
export ATV_QUEUE_LIMIT="5"

# Qdrant
export QDRANT_URL="http://localhost:6333"
export QDRANT_COLLECTION="velorin_brain"

# Ollama
export OLLAMA_URL="http://localhost:11434"
export EMBED_MODEL="nomic-embed-text-v2-moe"
```

---

## Files That Must NOT Be Committed

Add to `.gitignore`:

```
# Service account key
.velorin-gdrive-key.json
*.json.secret

# Qdrant storage (data, not config)
qdrant_storage/

# Local build artifacts
infrastructure/atv/node_modules/
infrastructure/schema-registry/*.db-journal

# macOS
.DS_Store
.AppleDouble

# Python
__pycache__/
*.pyc
*.egg-info/
```

---

## Hardware Memory Budget Reference (36GB unified memory)

| Component | Active Memory | Notes |
|---|---|---|
| macOS Sequoia | ~8-10GB | Reserved by OS |
| Available for models | ~26-28GB | Effective VRAM |
| nomic-embed-text-v2-moe | ~274MB | Persistent — always running |
| qwen2.5-vl:7b | ~5.5GB | Load for vision tasks |
| qwen3.5:35b-a3b (MoE) | ~20GB | Fast agentic loops (3B active params compute) |
| ATV verifier (Qwen2.5-0.5B) | ~400MB | Persistent when ATV is running |
| KV cache (with TurboQuant 4×) | ~3-4GB at 32K context | Compressed by TurboQuant when available |
| **Total typical peak** | **~26-27GB** | Within budget with careful sequencing |

**Note:** Do NOT run qwen3.5 (20GB) and qwen2.5-vl (5.5GB) simultaneously — exceeds budget.
Run vision model for extraction tasks; swap to agentic model for classification/reasoning tasks.

---

[VELORIN.EOF]
