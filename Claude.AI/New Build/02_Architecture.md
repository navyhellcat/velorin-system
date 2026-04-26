# 02 — Architecture
**The 4-Layer Memory System — Updated April 26, 2026**

---

## The Complete Stack

```
Layer 0 — LoRa Adapter          FUTURE: CT's cognitive patterns as model weights
                                  Semantic intuition, always-on, shapes inference
                                  Depends on: local model decision, JSD compression trigger

Layer 1 — E₈ Brain              IMMEDIATE BUILD
                                  PPR over neuron pointer graph in E₈ crystals
                                  Navigation and retrieval layer
                                  Qdrant as vector search entry point

Layer 2 — Episodic Graphs       DESIGNED — engineering phase after Layer 1
                                  240-node document graphs, temporal KG format
                                  Dark Matter: bulk data with zero pointers
                                  Ignition Protocol: emotional engagement crystallizes

Layer 3 — Permanent Archive     EXISTS (GitHub repo)
                                  All markdown files, sessions, research
                                  Never deleted — Second Law of Epistemodynamics
                                  Model-agnostic ground truth
```

---

## Layer 3 — The Archive (Exists Now)

GitHub is Layer 3. Everything committed is permanently preserved.

**The Second Law:** Once information enters Layer 3, it is never deleted.
When the LoRa (Layer 0) learns a pattern, the explicit Markdown record
is demoted — its pointer priority drops — but it is never removed.
Proven: DPI + Eckart-Young applied to X→Y→Z Markov chain.

**Knowledge staleness in Layer 3:** Stale neurons are NOT deleted. They are managed
via write-time structural routing:
- `belief_state: superseded` or `stale` → PPR mass zeroed for that node
- Node remains on disk with original content hash intact (Second Law preserved)
- Post-commit hook manages belief_state transitions on `supersedes` and `contradicts` edges
- Refund Fallacy: NEVER refund accumulated PPR mass when a node transitions to dark or superseded

*→ Forward note: The post-commit hook architecture is built at Stage 1 ingestion pipeline.
It must also handle skill dependency graph updates (Section 5 of this file).*

---

## Layer 1 — The Brain (Build This First)

**What it is:** A neural file graph. Neurons are atomic markdown files (~15 lines,
one idea each). Neurons connect via directed pointer ratings (1-10), automatically
assigned by the ingestion pipeline — never rated by hand.

**Retrieval algorithm:** Personalized PageRank (PPR)

$$R = (1-\alpha) \cdot P_{active}(q) \cdot R + \alpha \cdot S$$

Where $P_{active}(q)$ is the Multiplex Tensor, S is the query seed, $\alpha = 0.25$.

**Scale invariance (Theorem 1):** With the 7-pointer cap, retrieval precision ρ*(n)
scales as O(1) regardless of graph size.

**Density floor (Theorem 2):** ρ* ≈ 0.78. 78% of a neuron's pointers must be
high-priority (ratings 1-3). 5 of 7 pointers must be semantic signal.

**Independent row-normalization (Erdős proof, Session 033):**
P_tax and P_them are each row-normalized independently before any linear combination.
Joint normalization causes stochastic leakage and violates ρ* = 0.78.

**Multiplex Tensor:**

$$P_{active}(q) = \omega_{tax}(q) \cdot P_{tax} + \omega_{them}(q) \cdot P_{them}$$

$P_{tax}$ carries: `instance-of`, `derived-from`
$P_{them}$ carries: `causes`, `activates`, `precedes`, `implements`, `depends-on`, `supports`, `contradicts`

---

## The Causal Action Potential (Gate Definition — Session 034)

**Replaces** the original Topological Action Potential Φ(v) = π_v / ‖π‖_∞ everywhere.

$$\Phi_{causal}(v) = \frac{\pi_v}{\alpha}$$

Identity-equivalent to expected visits before teleportation: $E[N_v]$.

**Properties:**
- Eliminates Shadow Eclipse (dark mass never enters denominator, which is fixed α)
- Eliminates dark-leaf-hub hijacking (same reason)
- Eliminates Metadata Cascade (toggling M(v) has zero effect on any other node's Φ_causal)
- Cyclic detection: **Φ_causal(v) > 1.0 is mathematical proof of a directed cycle** in any DAG
  (in a DAG, E[N_v] ≤ 1; exceeding 1.0 proves cyclicity — parameter-free, absolute)
- PPR-invariance preserved (M(v) metadata flag does not enter the linear system)

**Skill injection gate:**

$$\text{Inject}(v) = (\Phi_{causal}(v) > \theta_{work}) \land (M(v) = 0)$$

**Cyclic-region routing:**
When $\Phi_{causal}(v) > 1.0$: route query to Layer 3 conflict resolution instead of skill injection.
*Forward note: → Layer 3 mechanism (04_AgentEcosystem.md) receives cyclic-region queries
as additional input beyond same-tier contradicts edges.*

**θ_work spectral band:**
Analytically bounded to (0.375, 0.585] by density constraints (ρ* = 0.78, α = 0.25).
Provisional value: 0.5. Empirical calibration: minimum 738 labeled queries.

*→ Forward note: Stage 5 local AI model selection must include "Softmax-style global
attention aggregation required for IES reasoning gate" as a hard criterion. Pure RNN
architectures with tanh saturation fail (Erdős VEGPStressTest Proof 2).*

---

## Crystal Structure

**Pointer Gravity (Wall A — Laplacian Dual-Procrustes):**

$$\mathcal{L}(W) = \|WX - Y_M\|^2_F + \gamma \cdot \text{Tr}(WXLX^T W^T) + \lambda\|W\|^2_F$$

Closed-form: $W = Y_M(K + \gamma KL + \lambda I)^{-1}X^T$ where K = X^TX (Gram matrix, ≤240×240).
260× compute reduction vs. direct inversion.

**Inter-Crystal Gauge Tensor (Wall B):**

$$T_{A \to B} = (1-\lambda)T_{semantic} + \lambda T_{human}$$

64 floats per crystal boundary. Simon-Ando Aggregation: O(K³) + active × O(240³).

**Crystal Mitosis (Wall C.1 — Weighted Fiedler Bisection):**
When crystal hits 240 neurons. Weighted Cheeger inequality guarantees minimum semantic damage cut.
Severing rating-1 pointer costs 5× more than rating-9.

**Alien Injection (Wall C.2 — W_global Fractal Projection):**
Novel query → O(K) softmax over K centroids → 8D coordinate.
W_global updates via Schur Complement in O(K²) when crystal undergoes mitosis.

---

## Affinity System

**Holographic Cold-Start (initial affinity):**

$$\mathcal{A}_{init}(x_{new} \to y_{port}) = \max\left(2, \left\lceil 11 - \lambda \cdot \|W_{global} x_{new} - y_{port}\|^2 \right\rceil\right)$$

λ calibration: start at 1/σ² where σ² = empirical variance of projection residuals.
No hub-centrality proxy — that generates Monster Nodes via Preferential Attachment (Barabási-Albert).

**Continuous Affinity Clutch (routing gravity):**

$$\tilde{\mathcal{A}}(u \to v) = 2 + (\mathcal{A}_{base}(u \to v) - 2) \cdot \left(1 - \exp\left(-\frac{D_{KL}(P_{MD} \| P_{LoRa})}{\delta(u \to v)}\right)\right)$$

A_base stored permanently. Model upgrade: D_KL → ∞, Ã snaps back to A_base simultaneously for all pointers.

**A_base SDE:**

$$d\mathcal{A}_{base} = \eta \cdot \mathbf{1}[e \in \text{Success Path}]\, dt - \frac{\mathcal{A}_{base}}{\tau_0 \cdot \max(\varepsilon, H_E + \gamma \pi_u)}\, dt$$

**δ(u→v) — atomic weight of a pointer:**

$$\delta(u \to v) = -\pi_u \cdot \log(1 - \mathcal{A}(u \to v) \cdot R_{eff}(u \to v))$$

Computable in O(1) due to exponential decay in 7-pointer bounded neighborhood.

---

## Compression — JSD Algorithm (Session 035)

Standard Oblique JBD is mathematically impossible — Perron-Frobenius forbids row-stochastic
block decomposition of any connected irreducible matrix (multiplicity of λ=1 would be k; contradiction).

**Joint Spectral Disaggregation (JSD) — the correct algorithm:**
1. Compute symmetric mix: $M_{joint} = (P_{tax} + P_{them})/2$
2. Spectral clustering on top k right eigenvectors near λ=1
3. Row-normalize within each cluster; k-means → permutation matrix Π
4. Prune off-diagonal residual via row-normalization
5. Complexity: O(k²|U|)

**JSD ↔ Brockett flow unified pipeline:**
- Brockett double-bracket gradient flow runs continuously: $dP_{tax} = \Pi_T([[P_{tax}, P_{them}]^T, P_{them}])dt + \sigma dW_t$
- Flow drives commutator norm β → 0
- **Compression event detector (OQ-6 structurally resolved):** JSD fires when β ≤ β_abelian
  where $\beta_{abelian} = \frac{\alpha \delta}{2C(1-\alpha)} \cdot \theta_{work} \cdot \|\pi\|_\infty$

**κ parameter:** Analytic formula $\kappa = 2C(1-\alpha)/(\alpha\delta)$ is a structural prior only —
operationally too loose for hard-threshold use (Davis-Kahan looseness, spectral-gap volatility in
sparse d_max=7 graphs). Empirical κ calibration required via Check-ins measurement program.
*→ Build-space placeholder: compression event detector phase (Stage 4+). Check-ins entry: after 10 test compression events.*

---

## Layer 2 — Episodic Graphs (Design Complete, Engineering Pending)

**Data model:** Temporal knowledge graph
```
(node_u, relation, node_v, valid_from=date, valid_to=NULL_or_date, weight=float)
```

**Semantic Dark Matter:** Bulk data in Qdrant with zero Layer 2 pointers.
No PPR routing gravity. Data exists but cannot be walked to. Prevents PPR density collapse.

**Ignition Protocol:** When CT emotionally engages with a vector query result:
1. Identify active PPR context V_active
2. Topological fitness: $f(x^* \to u) = \pi^{(q)}_u \cdot \exp(x^{*T} W_{LoRa} x_u / \tau)$
3. Assign top-k edges with affinity ≥ 8 (Ignition Valency Constraint)
4. Write reciprocal pointer from anchor node back to crystallized node
5. Density preserved or fortified — proven in Ignition Protocol Section 7

**Temporal Bypass:** Mathematical tag: ∂x*/∂t = 0 → λ_velorin = 0.
The embedding never decays. Ignition can fire on decades-old data.

---

## Layer 0 — LoRa Adapter (Future — Stage 5)

**What it is:** Lightweight fine-tuned parameter layer attached to a frozen local base model.
Encodes CT's compressed cognitive patterns. Shapes every inference without entering context window.

**Why the Second Law applies:** $\Delta = I(X;Y) - I(Z;Y) > 0$ strictly (DPI + Eckart-Young).
LoRa is lossy. Markdown is the lossless ground truth. Model upgrade → retrain LoRa from Markdown.

**Compression trigger:** Brockett flow drives commutator norm β → 0; JSD fires at β_abelian.
When CT consistently applies a framework across many unrelated contexts, the cross-domain
Φ_causal pattern signals compression event.

*→ Forward note: `base_model_config: {type: "personal", id: "ct-v1"}` field (Direction C) governs
the LoRa training pipeline — reads this config at initialization to determine whether to incorporate
a shared corpus. See neuron YAML in 03_BrainAndMath.md.*

**Do not build this yet.** Build the Brain first.

---

## The Retrieval Flow (End-to-End)

```
CT types a query
    │
    ▼
W_global projection → 8D via global projection matrix
    │
    ▼
O(K) softmax over K crystal centroids → identify entry crystals
    │
    ▼
PPR walk with P_active(q) = ω_tax·P_tax + ω_them·P_them
    │
    ▼
For each procedure neuron v surfaced:
  compute Φ_causal(v) = π_v / α
  if Φ_causal > 1.0 → route to Layer 3 (cyclic region)
  if Φ_causal > θ_work AND M(v)=0 → skill injection gateway
    │
    ▼
Inter-Crystal Gauge Tensor routing for cross-crystal paths
Simon-Ando Aggregation for efficient multi-crystal traversal
    │
    ▼
TAG (Topology-Augmented Generation): context returned in pointer-graph order
Response generated against structured context
```

---

## Skills Architecture

**Skills are separate from the Brain.** The Brain is declarative memory (neurons).
Skills are procedural memory (SKILL.md files). Different substrates.

**Brain-to-Skills interface via procedure neurons:**
- Procedure neurons (`type: procedure`) carry optional `skill_ref: path/to/SKILL.md`
- skill_ref is pure metadata — PPR-invariant (does not enter the linear system)
- Skill injection fires via Φ_causal gate (see above)

**Skills dependency graph:** Directed multi-relational graph at `skills/skill_dependencies.yaml`
Four edge types: dependency (hard prerequisites), workflow (logical co-occurrence), semantic (conceptual overlap), alternative (mutually exclusive paths)
Typed artifact schemas define I/O contracts (not string tokens).
Cycles permitted — PPR convergence handles them (α=0.15).

**Reverse-PPR on skills graph:** When Φ_causal > θ_work fires, reverse-PPR traces backward
along dependency edges to recover the dependency-complete prerequisite chain.

*→ Build-space placeholder Stage 3: GoS sparse validation mode (trigger: skill library exceeds N skills [N defined at Stage 3 design]). Seam: validate_skill_edges(..., validation_mode="dense"). mode_config dict extensible.*

---

## Knowledge Staleness Architecture

Stale knowledge is managed write-time, not query-time:

```yaml
belief_state: active | contested | resolved | superseded | stale
authority_tier: 1-5   # 1=CT-curated, 2=Erdős-verified, 3=multi-source, 4=validated agent, 5=LLM-initial
contradiction_class: factual | empirical | architectural | taste   # written at neuron creation
```

**Post-commit hook:** Reads `supersedes` and `contradicts` edges; updates belief_state automatically.
PPR read pass zeroes mass on nodes where belief_state ∈ {superseded, stale}.
Node remains on disk — Second Law preserved.

---

[VELORIN.EOF]
