# SECTION 7 — SOFTWARE: MACHINE 2 (LOCAL AI SERVER / GAMING RIG)

**Purpose:** Everything needed to run local AI models, manage orchestration scripts, maintain the storage architecture, and run games.

---

## Operating System

**Recommended configuration:** Windows 11 Pro as primary OS + Ubuntu 24.04 LTS as dual-boot secondary

**Why dual boot instead of Windows-only:**
- Linux (Ubuntu) runs local LLM inference 10–20% faster than Windows 11 for the same hardware
- Linux is the native environment for serious AI development tooling (Python, CUDA, Docker)
- Windows is required for gaming — most games run on Windows only or perform significantly better on Windows
- Dual boot is the established consensus for hybrid gaming + AI builds

**Practical setup:** Boot into Windows for gaming sessions. Boot into Ubuntu for extended AI inference, training runs, or when maximum token throughput is needed. For daily orchestration work where the machine is just running Ollama as a server, Windows is fine — the 10–20% speed difference is noticeable but not critical for routing tasks.

**Windows 11 Pro:** ~$200 (retail key) or included with certain hardware purchases. Pro version required for Hyper-V (virtual machines) and Remote Desktop if needed.

**Ubuntu 24.04 LTS:** Free. Download from ubuntu.com. Install on a separate partition or secondary drive.

---

## NVIDIA Drivers and CUDA

**Install on both Windows and Ubuntu:**
- NVIDIA GeForce drivers (latest stable — download from nvidia.com)
- CUDA Toolkit (current version compatible with chosen models — check Ollama's requirements)

**Install order on Ubuntu:** Install NVIDIA drivers first via `ubuntu-drivers autoinstall`, then CUDA toolkit. Do not install CUDA before drivers.

**CUDA is the reason NVIDIA matters for local AI.** The entire local AI software stack (Ollama, llama.cpp, PyTorch) is built around CUDA. Without CUDA, the GPU does not accelerate inference.

---

## Ollama

**Source:** ollama.com
**Cost:** Free, open source
**Purpose:** Primary local model runtime. Runs as a background service. Exposes a REST API at `http://localhost:11434` (accessible over local network from Machine 1). Machine 1 sends inference requests to this endpoint.

**Why Ollama over alternatives:**
- API-first design — built to be called programmatically, not through a GUI
- Runs as a daemon (always-on background service)
- OpenAI-compatible API format — existing Claude API code can point here with minimal changes
- 10–20% faster inference than LM Studio due to lower overhead
- Native Docker support for containerized deployment

**Basic usage:**
```
ollama serve          # start the server
ollama pull qwen3:14b # download a model
ollama run qwen3:14b  # test in terminal
```

**Network access:** By default, Ollama only accepts connections from localhost. To allow Machine 1 to call it over the local network, set the environment variable `OLLAMA_HOST=0.0.0.0` before starting the server. Then Machine 1 calls `http://[Machine2-IP]:11434`.

---

## LM Studio

**Source:** lmstudio.ai
**Cost:** Free
**Purpose:** GUI-based model browser and testing interface. Use for discovering and downloading new models, testing prompts visually before coding them, and adjusting parameters interactively.

**Not the primary runtime** — Ollama handles that. LM Studio is the exploration and testing layer. Once a model is validated in LM Studio, pull it into Ollama for production use.

---

## Docker

**Source:** docker.com
**Cost:** Free (Docker Desktop requires license for commercial use over certain size — for personal/small business use, free)
**Purpose:** Container runtime for running isolated services. Some orchestration tools and vector databases run most cleanly in Docker containers.

---

## Python 3 LTS

**Source:** python.org
**Purpose:** Orchestration scripts, RAG pipelines, Google API integrations, fine-tuning tools.
**Install:** Latest Python 3.x LTS. On Ubuntu, use `apt`. On Windows, install from python.org directly.

---

## Node.js LTS

**Source:** nodejs.org
**Purpose:** MCP server code and Node-based orchestration scripts are portable — same scripts that run on Machine 1 can run on Machine 2 as needed.

---

## Git and GitHub CLI

**Source:** git-scm.com / cli.github.com
**Purpose:** Version control. All Velorin code lives in GitHub. The velorin-system repo (created Session 006) is the source of truth for agent configuration and architecture.

---

## CUDA Toolkit

**Source:** developer.nvidia.com/cuda-toolkit
**Purpose:** Required for GPU-accelerated inference. Ollama and llama.cpp automatically use CUDA when installed.
**Version:** Install the version recommended by Ollama's current documentation (check at install time — CUDA versions matter for compatibility).

---

## Software Install Order on First Setup

**Windows partition:**
1. Windows 11 Pro
2. NVIDIA GeForce drivers (latest stable)
3. Chrome
4. Git + GitHub CLI
5. Node.js LTS
6. Python 3 LTS
7. CUDA Toolkit
8. Ollama (Windows version)
9. LM Studio
10. Docker Desktop
11. Clone Velorin repos from GitHub
12. Gaming clients (Steam, Epic, etc.)

**Ubuntu partition:**
1. Ubuntu 24.04 LTS
2. `sudo ubuntu-drivers autoinstall` (NVIDIA drivers)
3. CUDA Toolkit
4. Git + GitHub CLI
5. Python 3 (likely pre-installed, update to latest LTS)
6. Node.js LTS
7. Docker (`apt install docker.io`)
8. Ollama (Linux version — install script from ollama.com)
9. Clone Velorin repos from GitHub

[VELORIN.EOF]
