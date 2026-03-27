# SECTION 8 — LOCAL MODELS

**Purpose:** Identify which local models to run on Machine 2 for Velorin's hybrid architecture. Claude (via API) handles complex reasoning. Local models handle cheap, fast, private, or high-volume tasks.

---

## Architecture Reminder

Claude (Anthropic API) = orchestrator brain. Complex reasoning, strategic decisions, final output quality.

Local model (on Machine 2) = workhorse. Routing decisions, classification, summarization, document preprocessing, cheap repetitive tasks, privacy-sensitive operations, tasks where API cost would be prohibitive at volume.

The local model does not need to match Claude's quality. It needs to be fast, cheap to run, and capable enough to handle the tasks routed to it reliably.

---

## VRAM Budget on RTX 4090 (24GB)

| Model loaded | VRAM used | Remaining for context |
|---|---|---|
| 14B Q4_K_M | ~10–11GB | ~13GB — comfortable |
| 32B Q4_K_M | ~19–20GB | ~4GB — tight |
| 70B Q4_K_M | ~42GB | Does not fit single GPU |

**Target operating range: 14B–32B Q4 models.** This tier provides strong capability at fast speeds while fitting comfortably in 24GB VRAM.

---

## Primary Local Model — Routing and General Tasks

**Recommended:** Qwen 3 14B (Q4_K_M quantization)
**VRAM requirement:** ~10–11GB
**Performance on RTX 4090:** ~60–70 tok/s
**Capabilities:** Strong reasoning, coding assistance, multi-step task planning, document analysis
**Download via Ollama:** `ollama pull qwen3:14b`

**Why Qwen 3 14B:**
- Current consensus "sweet spot" model for single GPU inference
- Dramatically better quality than 7B/8B models
- Fits comfortably in 24GB VRAM with context headroom
- Fast enough for interactive use
- Strong at following structured instructions — important for routing tasks in an orchestration system

---

## Secondary Local Model — Code Tasks

**Recommended:** Qwen3-Coder-30B-A3B (Mixture of Experts, Q4 quantization)
**VRAM requirement:** ~18GB
**Performance on RTX 4090:** ~73–87 tok/s (MoE architecture is faster than dense models of equivalent size)
**Capabilities:** Coding, code review, script generation, debugging
**Download via Ollama:** `ollama pull qwen3-coder:30b-a3b` (verify exact tag on ollama.com at install time)

**Why this model:** It's a Mixture of Experts architecture — 30B total parameters but only ~3B active at inference time. It fits in 24GB and runs faster than a dense 14B model, while delivering quality approaching a 30B dense model. The coding benchmarks are strong (50.3% on SWE-Bench Verified). This is the correct model for Velorin's code generation tasks routed away from Claude to save API costs.

**Note:** Cannot run this model and Qwen 3 14B simultaneously on a single 24GB GPU — they each require most of the VRAM. Ollama handles model swapping automatically. For simultaneous multi-model operation, a second GPU with 24GB would be required.

---

## Model Storage Location

All model weight files live on Machine 2's Drive 2 (WD Black SN850X 4TB) in Ollama's model directory.

Default Ollama model directory:
- Windows: `C:\Users\[username]\.ollama\models`
- Ubuntu: `~/.ollama/models`

**Redirect this path to Drive 2** after install so model files don't fill Drive 1 (the OS SSD). Set via `OLLAMA_MODELS` environment variable.

---

## Models to Monitor (Future Additions)

These are not for initial build but worth tracking:

| Model | VRAM needed | Use case |
|---|---|---|
| Llama 3.3 70B Q4 | ~42GB (overflow to RAM) | Highest quality local reasoning — wait for second GPU |
| Mistral Small 3 24B | ~16GB | Efficient general purpose |
| DeepSeek-Coder-V2 | ~16GB Q4 | Alternative coding model |

---

## Fine-Tuning (Future Capability)

Machine 2's RTX 4090 supports fine-tuning smaller models (7B–14B) on proprietary data using tools like:
- **Unsloth** — memory-efficient fine-tuning
- **Axolotl** — flexible fine-tuning framework
- **LLaMA-Factory** — GUI-assisted fine-tuning

This is not a Day 1 capability but is architecturally supported by this build. Fine-tuning on Velorin documents and interaction history creates a model that understands your specific domain, terminology, and preferences better than any base model.

---

## Model Selection Protocol (For Future Purchases/Downloads)

When evaluating a new model:
1. Check VRAM requirement at Q4_K_M quantization — must fit in 24GB with context headroom
2. Check benchmark performance on the specific task type (coding, reasoning, summarization)
3. Download to Machine 2, test via Ollama terminal before integrating into orchestration
4. Validate against a set of standard Velorin routing tasks before promoting to production
