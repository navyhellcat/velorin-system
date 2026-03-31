---
class: research-request
priority: MEDIUM
assigned: Jiang
requested-by: Christian Taylor (Chairman)
date: 2026-03-31
status: QUEUED — do not begin until CT authorizes
---

# Jiang.ResearchRequest.FlashMoE
## The Science Behind FlashMoE and Implications for Local Model Deployment on Apple Silicon

---

## CONTEXT

CT is purchasing an Apple Mac mini with 36GB unified memory (Apple Silicon). He was incorrectly told by an AI that local model deployment was not viable at this hardware tier. FlashMoE (arXiv 2601.17063) directly addresses the SSD I/O bottleneck that limits large model inference on memory-constrained hardware.

Level 1 research completed March 31, 2026 (this session). That surface pass confirmed the technology is real and relevant. This is the full research request.

---

## CORE QUESTION

What does FlashMoE actually do at the technical level, what are its real-world performance implications on Apple Silicon specifically, and what does it unlock for a 36GB unified memory Mac mini running local inference for Velorin workloads?

---

## RESEARCH THREADS

### Thread 1 — The Science of FlashMoE
- Full technical architecture: how the ML-based cache replacement policy works, what signals it uses, how it combines recency and frequency
- How it differs from prior approaches (Fiddler, DAOP, standard LRU/LFU offloading)
- What "expert" means in MoE inference and why caching them specifically is the right bottleneck to attack
- The 51% cache hit improvement and 2.6x speedup — what conditions produce these numbers, what degrades them
- Limitations: what workloads or model architectures FlashMoE does NOT help with
- Source: arXiv 2601.17063 full paper

### Thread 2 — Apple Silicon Unified Memory Architecture
- How Apple Silicon unified memory differs from discrete GPU VRAM for inference purposes
- Memory bandwidth figures by chip generation (M2 Pro, M3 Pro, M4 Pro) and what they mean for token throughput
- How MLX (Apple's ML framework) exploits the unified memory architecture vs. llama.cpp Metal backend
- What 36GB unified memory actually enables at current quantization levels — which models fit, which don't, at what quality cost
- NVMe SSD speed on current Mac mini hardware and how it interacts with FlashMoE's offloading strategy

### Thread 3 — What FlashMoE + 36GB Unlocks
- Which MoE models become viable at 36GB with SSD offloading that were not viable with RAM-only constraints
- Realistic token throughput expectations for DeepSeek-V3, Qwen3-235B, and similar MoE models on this hardware profile
- Quality vs. speed tradeoffs at different quantization levels with FlashMoE active
- Direct comparison: what tasks can be run locally at acceptable speed vs. what still requires API

### Thread 4 — Velorin Deployment Implications
- Which Velorin workloads are candidates for local inference: OASIS simulations, bulk research tasks, profile processing, intake test administration
- Cost model: API cost per session vs. local inference cost (electricity, depreciation) at Velorin's current task volume
- Data sovereignty implications: which data categories should never leave the device (clinical/psychological profile data, intake results)
- Build path: what infrastructure changes are needed to route certain workloads to local model vs. Anthropic API

---

## DELIVERABLE

Standard Jiang research output. Confidence-weighted conclusions. 75% minimum threshold. Practical recommendation on hardware configuration, model selection, and Velorin workload routing.

[VELORIN.EOF]
