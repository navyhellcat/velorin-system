# SECTION 10 — STORAGE ARCHITECTURE

**Purpose:** Define how files, memory, models, and data are organized across both machines, cloud, and GitHub. This is the persistent memory layer of the Velorin system.

---

## Overview: Three Storage Layers

| Layer | Location | What Lives Here |
|---|---|---|
| Cloud (Google Drive) | Drive — accessible from anywhere | Velorin system documents, agent configs, company records, session logs |
| Local Machine 2 | NVMe drives on the PC | Model weights, large datasets, code repos, archive files |
| GitHub | Remote repos | Versioned code, MCP server, orchestration scripts, agent configuration |

---

## Google Drive — Velorin Root Folder

**Already established and operational.** Structure documented in existing Velorin system documents.

**Current active layer:** Layer 0 (root) and Layer 1 (bot subfolders) are in use. Boot protocol reads from Drive on session start.

**Transition trigger:** When the number of active topic documents exceeds 50–80, Drive-based document memory becomes slow and should transition to a vector database. This is not an immediate concern — track document count and plan the transition proactively.

**Backup:** Google Drive provides redundancy natively. For additional protection, the Google Drive desktop sync on Machine 1 maintains a local copy automatically.

---

## Machine 2 Local Storage — Drive Layout

### Drive 1: Samsung 990 Pro 2TB (OS Drive)
**Path:** C:\ (Windows) / root partition (Ubuntu)

Contents:
- Windows 11 Pro installation
- Ubuntu 24.04 LTS (separate partition, ~100GB)
- Applications: Ollama, Python, Node.js, Git, CUDA toolkit, gaming clients
- Active project working files (currently in development)
- GitHub cloned repos (kept here for fast SSD access during development)

### Drive 2: WD Black SN850X 4TB (Model Storage)
**Path:** D:\ (Windows) / /data (Ubuntu)

Contents:
- Ollama model cache (set OLLAMA_MODELS to this path)
- All .gguf model weight files
- Large datasets used for fine-tuning
- Velorin file archive (local copy)
- Video/audio generation outputs

### Drive 3: 4–8TB HDD (Archive)
**Path:** E:\ (Windows) / /archive (Ubuntu)

Contents:
- Long-term backup of model weights (in case Drive 2 fails)
- Historical session data and logs
- Large media files
- Cold storage — not accessed frequently

---

## GitHub — Velorin Repos

**Already established as of Session 006.** GitHub repo mirrors Drive folder structure for code-related files.

**Current repos:**
- `navyhellcat/velorin-gdrive-mcp` — MCP server (operational)
- `velorin-system` — agent configuration and architecture (created Session 006)

**Workflow:** Agents write documents to Drive. Code and scripts go to GitHub. Configuration files go to GitHub with sensitive values stripped (API keys replaced with environment variable references).

---

## Vector Database (Future — Planned Transition)

**Current state:** Not yet implemented. Drive documents serve as memory.

**Trigger for implementation:** 50–80 topic documents in the Velorin knowledge system.

**Recommended tool when ready:** Chroma (local, open source, Python-native) or Weaviate (self-hosted, more scalable).

**Deployment:** Run as a Docker container on Machine 2. Machine 1 calls it over local network via REST API.

**What changes:** Instead of Claude reading full Drive documents on boot, a vector index is queried for relevant chunks. Boot time drops significantly. Context quality improves for large knowledge bases.

---

## File Naming and Organization Standards

From Velorin Operating Standards (already established):
- Dates: Month DD, YYYY
- File names: underscores, no spaces, no special characters
- No version numbers in file names — update in place
- Every intra-company document ends with `[VELORIN.EOF]`
