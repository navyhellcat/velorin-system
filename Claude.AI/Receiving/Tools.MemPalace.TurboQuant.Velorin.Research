# Jiang.Topic.TurboQuant_and_MemPalace

**Deep Research | Director of Strategic Intelligence | Velorin System**
**Date: April 7, 2026**
**Sources: arXiv paper, GitHub repos (8+), r/LocalLLaMA, r/ContextEngineering, Hacker News, community implementations, independent audits**

-----

## EXECUTIVE SUMMARY

TurboQuant and MemPalace are not competitors. They don’t touch the same layer of the stack. They are complements — and together they point toward the same destination: longer, cheaper, more capable AI context at the local inference level.

TurboQuant compresses the KV cache inside the model during inference — a GPU/memory optimization that makes the model run cheaper and longer on existing hardware. MemPalace organizes and retrieves conversation history from outside the model — an episodic memory system that loads relevant past context into the prompt. One operates inside the attention mechanism. One operates in the application layer. They don’t compete. They stack.

-----

## PART 1: TURBOQUANT

### What It Is

TurboQuant is a vector quantization algorithm from Google Research (Zandieh, Daliri, Hadian, Mirrokni) published March 24, 2026, presented at ICLR 2026. arXiv: 2504.19874.

It solves one specific problem: **KV cache memory consumption during LLM inference.**

Every time a transformer model generates a token, it computes a key vector and a value vector for every attention layer and stores them. This collection — the KV cache — is the model’s working memory for the current context. It scales linearly with context length. At 128K context on a 7B model, the KV cache can reach 16GB in FP16. This is the primary reason long contexts require expensive hardware.

TurboQuant compresses KV cache vectors from 16-bit (FP16) down to 3-3.5 bits per value. 4.6-6x memory reduction. Up to 8x faster attention computation on H100 GPUs. No retraining. No calibration data. Zero model-specific tuning.

-----

### The Math

TurboQuant is rooted in Shannon’s source coding theory and achieves within ~2.7x of the information-theoretic lower bound on quantization distortion. No quantizer can beat that bound — getting within 2.7x of it while being fully data-oblivious and processing vectors one at a time is the paper’s central claim.

**The two-stage pipeline:**

**Stage 1 — PolarQuant (rotation + scalar quantization)**

The core problem with naive quantization: real-world KV vectors have non-uniform energy distributions. Some coordinates are much larger than others. A uniform quantizer assigns equal precision to all coordinates — catastrophically wasteful when most precision lands on low-energy coordinates.

The fix: multiply the vector by a random orthogonal matrix before quantizing.

```
G = random Gaussian matrix (d × d)
Pi, _ = QR_decomposition(G)  # Pi is Haar-distributed random orthogonal matrix
y = Pi @ x                    # rotated vector
```

After rotation, a key mathematical property holds: each coordinate of y follows a concentrated Beta distribution (approximating Gaussian N(0, 1/d) for typical head dimensions). Because the distribution is now **known in advance** and coordinates become **nearly independent** in high dimensions, you can compute a mathematically optimal quantizer once offline and apply it to any vector from any model:

```
centroids = lloyd_max_quantizer(distribution="beta", bits=b)
# Lloyd-Max: iterative algorithm that places quantization levels optimally
# for a known distribution, minimizing expected squared error
```

Each coordinate is then independently snapped to the nearest centroid. Store: the index (b bits) + the original norm (1 float). Dequantize: look up centroid, reverse rotation, restore norm.

**Why this works:** Random rotation spreads energy uniformly (Gaussianization). Lloyd-Max finds optimal bin boundaries for the resulting distribution. Independence of coordinates means scalar quantization per coordinate is near-optimal (no cross-coordinate information lost). The rotation is deterministic — same seed always produces the same matrix. Generated once offline, reused for all vectors.

**Stage 2 — QJL (1-bit residual correction)**

Problem: MSE-optimal quantizers introduce systematic bias in inner product estimation. Attention is computed as `softmax(Q @ K^T / sqrt(d)) @ V` — inner products between query and key vectors. A quantizer that minimizes reconstruction error (MSE) doesn’t necessarily minimize inner product error.

The paper proposes a 1-bit correction using Quantized Johnson-Lindenstrauss (QJL):

```
residual = x - dequant(quant(x))  # reconstruction error
sketch = sign(G_jl @ residual)     # 1-bit JL sketch of the residual
# G_jl is a separate random matrix
```

Store the 1-bit sign per coordinate as a correction term. When computing attention, the inner product estimate uses both the quantized value and the 1-bit correction, producing an **unbiased** inner product estimator.

This produces TurboQuantProd — theoretically superior for attention because it corrects the bias. TurboQuantMSE (Stage 1 only) minimizes reconstruction error without correction.

-----

### The Community Finding: QJL Doesn’t Work in Practice

Six independent community implementations confirmed the same result: QJL makes performance **worse** on real models, despite being theoretically correct.

The reason:

- QJL eliminates bias but introduces variance in inner product estimates
- Softmax exponentially amplifies variance — small random errors in pre-softmax scores get magnified into large shifts in attention weights
- Lower variance (TurboQuantMSE) wins after softmax even though it’s technically “biased”

**Community consensus:** Use TurboQuantMSE for both K and V. Skip QJL. The paper’s theoretical recommendation diverges from empirical practice.

-----

### Real-World Performance Numbers (Community-Validated)

|Config            |Compression |Quality               |Hardware               |
|------------------|------------|----------------------|-----------------------|
|turbo3 (3.25 bits)|4.9x vs FP16|~99.5% cosine sim     |M4 Pro, RTX 5090       |
|turbo4 (4.25 bits)|3.8x vs FP16|~99.7% cosine sim     |Multiple               |
|turbo2 (2-bit)    |6.4x vs FP16|+6.48% PPL degradation|Extreme memory pressure|

LongBench on Llama-3.1-8B-Instruct at 3.5-bit: 50.06 — identical to 16-bit baseline (50.06).

Gemma 4 26B on Apple M4 Pro 48GB: 37/37 quality tests, 8/8 needle-in-haystack at 131K context, +34% faster than q4_0 at 131K.

Practical result: **104B model at 128K context on a single MacBook with turbo3** (74GB peak memory, PPL 4.024). Previously required multiple high-end GPUs.

-----

### Key Engineering Findings From Community

**K/V norm asymmetry.** Modern LLMs have dramatically different Key vs Value vector magnitudes. Qwen models: Key norms 172-778, Value norms 2-4. Since quantization error scales with norm squared, K vectors need more bits than V vectors. Use asymmetric allocation:

- Models with Q8_0+ base weights: symmetric turbo3/turbo3 works fine
- Models with Q4_K_M base weights: use q8_0 for K, turbo4 for V
- K precision dominates quality because it controls attention routing via softmax

**Model size matters.** Larger models absorb quantization stacking better. 104B: +3.6% PPL at turbo3. 70B: +11.4%. 7B: varies significantly by model architecture.

**Boundary layer protection.** First 2 + last 2 attention layers at q8_0, all middle layers at turbo2-V. 91% of the memory savings with near-zero quality loss at boundary layers.

-----

### Current Status

- **Paper:** ICLR 2026, arXiv:2504.19874. Google Research. No official open-source release yet.
- **Community implementations:** 8+ active repos. llama.cpp integration tracking in discussion #20969. Working on Metal (Apple Silicon), CUDA (NVIDIA), Vulkan. TheTom’s fork most feature-complete for llama.cpp.
- **Production stacks:** vLLM integration (0xSero), HuggingFace transformers (hackimov), MLX (upstream PR in progress).
- **Competitor:** RotorQuant — faster rotation via Clifford rotors (10-19x faster than TurboQuant’s full matrix multiply), slightly lower fidelity. Relevant for CPU-constrained deployments.

-----

## PART 2: MEMPALACE

### What It Is

MemPalace is an open-source AI memory system created by Milla Jovovich (actress, architect) and Ben Sigman (engineer, CEO Libre Labs). Released April 6-7, 2026. MIT licensed. 7,000+ GitHub stars within days of release.

It solves a different problem from TurboQuant: **AI sessions have no memory across conversations.** Every new session starts blank. MemPalace gives LLMs persistent cross-session memory by storing conversation history locally and retrieving relevant past context on demand.

Core philosophy: **Don’t let AI decide what to forget. Store everything. Make it findable.**

Competing systems (Mem0, Zep) use LLMs to extract what’s “worth remembering” and discard the rest. MemPalace argues the reasoning behind decisions — the context, the alternatives considered, the why — is exactly what gets discarded, and exactly what you need later.

-----

### The Architecture

**The Palace Structure (organizational layer)**

Inspired by the ancient Greek “method of loci” mnemonic technique. Instead of a flat vector index, memory is organized hierarchically:

```
Wing      — top-level domain (a person, a project, a topic)
  Room    — sub-topic within a wing (auth, billing, deployment)
    Hall  — memory type corridor shared across wings
      Drawer — verbatim original stored whole (ChromaDB)
```

Cross-wing tunnels: when the same room name appears in multiple wings (e.g., “auth-migration” in both a project wing and a person wing), the system automatically links them. Cross-domain retrieval without explicit lookup.

**The Four-Layer Progressive Loading System**

```
L0  — Wing/Room/Hall index (70 tokens) — loaded at startup always
L1  — Recent memories summary (100 tokens) — loaded at startup always
L2  — Search results — loaded on demand when query hits
L3  — Full verbatim storage in ChromaDB drawers — retrieved when L2 insufficient
```

Boot cost: **170 tokens total** (L0 + L1). Compare to CLAUDE.md which loads everything flat on every message.

**The Storage Layer**

ChromaDB for vector storage. All-MiniLM-L6-v2 embeddings (384-dim, local, free). Cosine similarity search. Verbatim text stored without summarization or extraction. No LLM API calls for the memory infrastructure — all classification, chunking, and room detection runs on regex heuristics and keyword scoring.

**The Temporal Knowledge Graph**

RDF-style triple storage in SQLite:

```
(subject, predicate, object, valid_from, valid_to)
```

Every fact has a validity window. Invalidation marks an end date without deleting:

```python
kg.add_triple("Kai", "works_on", "Orion", valid_from="2025-06-01")
kg.invalidate("Kai", "works_on", "Orion", ended="2026-03-01")
kg.query_entity("Kai", as_of="2026-01-20")  # historical snapshot
```

Solves the stale CLAUDE.md problem: outdated facts accumulate silently and the AI acts on them. The KG tracks when facts expire.

**AAAK Compression**

Claimed: 30x lossless compression, LLM-readable without a decoder.

Reality (per community audit Issue #27): AAAK is lossy, not lossless. Implementation is regex entity codes + keyword frequency + 55-character sentence truncation. `decode()` is string splitting, not a reversible compression. LongMemEval drops from 96.6% to 84.2% in AAAK mode — a 12.4 percentage point quality loss. The “lossless” claim is disputed.

**19 MCP Tools**

Auto-discovered by Claude Code and compatible agents. Covers: search, storage, knowledge graph queries, agent diaries. `mempalace_list_agents`, `mempalace_diary_write`, `mempalace_diary_read`, and more.

-----

### The Math

MemPalace’s retrieval math is standard vector search, not novel.

Vector embedding: All-MiniLM-L6-v2, a sentence-transformer model producing 384-dimensional vectors. Each stored chunk is embedded at write time. Each query is embedded at search time.

Retrieval: cosine similarity search via ChromaDB’s default nearest-neighbor implementation:

```
similarity = (A · B) / (||A|| × ||B||)
```

Top-K results returned by cosine distance to query embedding.

**The 34% improvement claim** (from flat storage to palace structure) is metadata filtering — narrowing the search scope from all drawers to wing → wing+room before running vector search. Standard technique in any vector database. The retrieval improvement comes from scoping, not novel math.

The 96.6% LongMemEval R@5 score is genuine but its interpretation is contested. Per community audit (Issue #29): the benchmark measures recall_any@5 — whether any of the top-5 retrieved sessions contains the gold session ID. It never reads the content, never generates an answer, never demonstrates the retrieved session actually answers the question. This is retrieval recall, not answer accuracy. Comparing it to Mem0’s end-to-end QA accuracy is comparing different metrics.

-----

### Community Feedback — Honest Assessment

**What’s real and working:**

- The palace hierarchical structure is a genuinely good organizing principle for long-term memory
- Progressive loading (170 tokens at startup) is a real and meaningful improvement over flat CLAUDE.md loading
- Temporal knowledge graph with validity windows is a legitimate innovation for handling changing facts
- Raw mode (verbatim + ChromaDB) achieves 96.6% R@5 on LongMemEval — credible score
- MIT licensed, local-only, zero API cost for basic operation — genuine value

**What’s overstated:**

- AAAK “lossless 30x compression” — lossy, 12.4pp quality regression in practice (Issues #27, #29)
- “Automatic contradiction detection” — knowledge_graph.py only blocks identical triples, conflicting facts accumulate silently
- 100% LongMemEval score — achieved via targeted fixes for 3 specific failing questions + LLM reranking (paid API), not general capability
- “34% improvement from palace structure” — metadata filtering, not novel retrieval architecture
- AAAK produced abbreviations, not summaries; no evidence of a separate storage tier distinct from drawers

**Open bugs (as of April 7, 2026):**

- ChromaDB version not pinned — compatibility issues (Issue #100)
- Shell injection vulnerability in hooks (Issue #110)
- macOS ARM64 segfault (Issue #74)
- 7 commits total — sustainability of active maintenance is an open question

**Creators’ response:** Direct, transparent, not defensive. The GitHub README now flags AAAK status honestly. They are fixing the bugs publicly. Special thanks to independent auditors listed by name. Credible behavior for an early-stage open source project.

-----

## PART 3: WHY THEY ARE DIFFERENT

|Dimension              |TurboQuant                                    |MemPalace                                         |
|-----------------------|----------------------------------------------|--------------------------------------------------|
|**What layer**         |Inside the model — GPU/attention computation  |Outside the model — application layer retrieval   |
|**What it operates on**|KV cache vectors during inference             |Conversation history in a local database          |
|**When it runs**       |Every forward pass, real-time                 |At session start (load index) and on search query |
|**What problem**       |Memory runs out at long context               |Sessions have no memory across conversations      |
|**Math core**          |Random rotation + Lloyd-Max quantization + QJL|Vector embeddings + cosine similarity + SQLite RDF|
|**Training required**  |None — data-oblivious                         |None — runs on any conversation export            |
|**Where output goes**  |Back into the attention computation           |Into the LLM context window as retrieved text     |
|**Who built it**       |Google Research (academic paper)              |Milla Jovovich + Ben Sigman (open source)         |
|**Maturity**           |ICLR 2026 paper, 8+ community implementations |7 commits, days old, active bug reports           |
|**Deployment**         |Requires GPU/inference stack integration      |pip install, works locally immediately            |

They don’t overlap. TurboQuant never touches the content of what’s being remembered. MemPalace never touches how the model processes its active context. One is compression math applied inside the transformer. One is retrieval architecture applied outside it.

-----

## PART 4: WHY THEY ARE COMPLEMENTS

The relationship:

```
User query
  → MemPalace retrieves relevant past context (episodic layer)
  → Retrieved context loaded into model's active context window
  → TurboQuant compresses KV cache for that active context
  → Model processes combined context at lower memory cost, longer window
```

TurboQuant makes the model’s working memory (KV cache) cheaper and larger per unit of GPU/RAM. MemPalace decides what gets loaded into that working memory from past history. They solve adjacent halves of the same problem: how do you give an AI access to a long history without running out of memory?

**The combined effect on Velorin specifically:**

A Velorin agent running on a local quantized model (Qwen 7B, Mac Mini) with TurboQuant applied to the KV cache:

- Context window effectively 4-6x larger at the same VRAM cost
- Longer sessions before hitting memory limits
- Faster inference on long contexts (up to 34% faster at 131K)

The same agent with MemPalace managing its episodic memory:

- Past sessions available for retrieval without manual context loading
- Temporal knowledge graph tracks what’s current vs stale
- Boot cost 170 tokens instead of loading all history

Together: the agent has a large working memory (TurboQuant) and a well-organized retrieval system for what goes into that working memory (MemPalace).

-----

## PART 5: VELORIN RELEVANCE

**TurboQuant:**
Directly relevant to the Mac Mini architecture. TurboQuant integrated into the local quantized model (running Qwen 7B or similar) extends the effective context window by 4-6x at no hardware cost. This is critical: the local model is the semantic routing layer — it needs to hold enough context to make good routing decisions. TurboQuant makes this cheaper. Apple Silicon is validated (Metal kernels working in TheTom’s fork). Timing: not yet in stable llama.cpp — community PRs in progress. Target window for practical deployment: Q2-Q3 2026.

**MemPalace:**
Partial overlap with the Velorin retrieval hierarchy theory. MemPalace is an episodic memory system — it stores verbatim, retrieves by vector similarity, adds temporal KG structure. It is what Velorin’s Layer 2/3 would look like as an off-the-shelf tool. It does not produce semantic compression. It does not update weights. It is not the semantic layer. But for the episodic retrieval function specifically — storing past sessions, making them findable, tracking facts over time — it is a working implementation of the problem Velorin needs to solve at that layer.

Caution: MemPalace is 7 days old with open bugs. Not production-ready. Monitor development trajectory.

**The compound implication:**

MemPalace handles Layer 2/3 episodic retrieval. TurboQuant enables the local model to hold a larger active context cheaply. The semantic layer (LoRA, neuron hierarchy) above both remains the unsolved piece. MemPalace + TurboQuant together close the episodic layer problem. The semantic layer above them is what Velorin builds that nothing else has.

-----

## CONFIDENCE LEVELS

|Claim                                                      |Confidence                       |
|-----------------------------------------------------------|---------------------------------|
|TurboQuant and MemPalace are not competitors               |99%                              |
|TurboQuant math is sound and community-validated           |92%                              |
|TurboQuant practical gains on Apple Silicon are real       |87%                              |
|QJL is worse than MSE-only in practice                     |89% (6 independent confirmations)|
|MemPalace 96.6% R@5 score is genuine                       |83% (methodology caveats noted)  |
|AAAK lossless claim is false                               |91% (per code audit)             |
|MemPalace temporal KG is a genuine contribution            |78%                              |
|TurboQuant + MemPalace are complements for Velorin         |88%                              |
|MemPalace production-ready in current state                |15%                              |
|TurboQuant integrated into stable llama.cpp within 3 months|74%                              |

-----

## SOURCES

**TurboQuant:**

- arXiv:2504.19874 — Zandieh, Daliri, Hadian, Mirrokni (Google Research / NYU)
- github.com/0xSero/turboquant — Triton kernels + vLLM integration
- github.com/TheTom/turboquant_plus — llama.cpp integration, Apple Silicon
- github.com/scos-lab/turboquant — 8-model benchmark, engineering insights
- github.com/tonbistudio/turboquant-pytorch — from-scratch PyTorch + QJL bug documentation
- github.com/hackimov/turboquant-kv — HuggingFace integration
- github.com/ggml-org/llama.cpp/discussions/20969 — integration tracking thread
- turboquant.net — independent analysis
- r/LocalLLaMA — implementation diary, MLX port, Gemma 4 results

**MemPalace:**

- github.com/milla-jovovich/mempalace — primary repository
- github.com/milla-jovovich/mempalace/issues/27 — code vs README discrepancy audit (lhl)
- github.com/milla-jovovich/mempalace/issues/29 — benchmark methodology audit (dial481)
- mempalace.tech — independent resource hub
- alexeyondata.substack.com — detailed architectural analysis
- r/ContextEngineering and Hacker News — community reception

[VELORIN.EOF]