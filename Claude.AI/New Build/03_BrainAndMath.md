# 03 — Brain and Math
**Neuron format, PPR, E₈ crystals, all locked Erdős results**

---

## Neuron Format (YAML Frontmatter — Final)

Every neuron in the Brain uses this format:

```yaml
---
id: semantic-slug-no-spaces
type: entity | concept | fact | goal | procedure
region: region-name
area: area-name
created: YYYY-MM-DD
last-touched: YYYY-MM-DD
class: c-memory | regular
confidence: 0.0–1.0
open: []
read_only: false
source: [optional — document_id or session_id]
---

[One atomic self-contained claim. 10–15 lines max.]
[State the idea. State what makes it distinct. State nothing else.]

## Pointers
- [[region/area/neuron-slug]] 0.9 — relation-type: reason
- [[region/area/neuron-slug]] 0.6 — relation-type: depends-on
```

### Field Definitions

**id:** Semantic slug. Lowercase, hyphens only. Globally unique. Descriptive.
Example: `ppr-density-floor`, `window-gravity-definition`, `ct-cardiac-event-2004`

**type:** What kind of knowledge this neuron contains.
- `entity`: A person, system, organization, or concrete thing
- `concept`: An idea, principle, or pattern (Window Gravity, Build vs Adopt)
- `fact`: An established datum (ρ* = 0.78, α = 0.25)
- `goal`: Something the system is working toward
- `procedure`: A process or sequence of steps

**class:**
- `c-memory`: Permanent. Never modified by any automated process. Never deleted.
  Never touched by GNNDelete. Set by CT only. Example: CT's grief events, locked
  architectural decisions, the Second Law.
- `regular`: Subject to demotion when the LoRa learns the connection.

**confidence:** The LoRa training gate. Neurons with confidence ≥ 0.8 are eligible
for LoRa training signal. Below 0.8: available for PPR retrieval but excluded from
LoRa training.
- 1.0: CT explicitly set this. Certain.
- 0.9: CT reviewed and validated.
- 0.8: Cross-corroborated by multiple sources or sessions. LoRa-eligible.
- 0.7: Behaviorally confirmed (consistently accessed without dispute).
- 0.5: Auto-generated or initial. Not LoRa-eligible until validated.

**open:** An array of strings describing work this neuron needs. Empty = settled.
Example: `["verify-automated-rating", "upgrade-confidence-after-review"]`

**read_only:** If true, only CT can modify this neuron. Use sparingly — only for
boot neurons and architectural constants.

### Pointer Notation

Pointers follow this format:
```
- [[region/area/neuron-slug]] weight — relation-type: description
```

Weight is a float 0.0-1.0 derived from the automatically-assigned rating:
`weight = (11 - rating) / 10`
So rating 1 → weight 1.0, rating 10 → weight 0.1.

Ratings are assigned automatically by the ingestion pipeline (Holographic Cold-Start
for initial value; A_base SDE for updates via Hebbian reinforcement and Ebbinghaus decay).
There are no manually assigned pointer ratings in the initial build.

Relation types (do not invent new ones):
```
causes | supports | contradicts | precedes | instance-of |
implements | depends-on | derived-from | activates
```

### What Makes a Good Neuron

One atomic idea. If you need "and" to describe it, it's two neurons.
No background. No setup. State the idea directly, then what it connects to.
15 lines is the hard cap. If you're approaching it, you're writing prose, not a neuron.

Bad: "The PPR algorithm is important because it allows the Brain to traverse the graph
in a way that is proportional to the automatically-assigned pointer ratings, meaning
that highly-rated connections propagate more relevance mass, which..."

Good: "PPR retrieval traverses the pointer graph weighted by system-assigned ratings.
High-affinity edges (rating 1-3) propagate more mass. With 7-pointer cap and α=0.25,
precision scales O(1) regardless of graph size. Required density: ρ* = 0.78."

---

## The Affinity Mapping

Human ratings and their mathematical affinities:
```
Rating 1 → Affinity 10  (critical, follow immediately)
Rating 2 → Affinity 9
Rating 3 → Affinity 8   (semantic signal)
─────────────────────────── ρ* = 0.78 boundary
Rating 4 → Affinity 7
Rating 5 → Affinity 6
Rating 6 → Affinity 5
Rating 7 → Affinity 4
Rating 8 → Affinity 3
Rating 9 → Affinity 2
Rating 10 → Affinity 1  (tangential)
```

The transition matrix P_ij = A(i,j) / Σ_k A(i,k) where A(i,j) = 11 - W(i,j).

5 of 7 pointers must be ratings 1-3 (affinities 8-10) to maintain ρ* = 0.78.
The curation standard: every neuron should have 5 solid semantic connections, 2 tangential.

---

## All Locked Erdős Results

These are proven. Do not revisit. Do not debate them.

### Theorems 1-4 (Synaptic Pruning Session, April 5)

**Theorem 1 — Scale Invariance**
ρ*(n) = O(1). With d_max = 7 and teleportation α, the required high-priority
edge density is completely independent of graph size n. Proven via the bounded
reach of PPR walks (at most 7^t nodes in t steps) against the global mixing time.

**Theorem 2 — The Density Floor**
ρ* ≈ 0.78 at α = 0.25. Exact formula:
ρ* = (K_α · A_L) / (A_H(1-K_α) + K_α · A_L)
where K_α = (1 - 4α/3)/(1-α), A_H = 9 (avg high-priority affinity), A_L = 4.

**Theorem 3 — Monster Node as Semantic Mirror**
Fisher Information penalty f(I(v)) = max(1, κ·I(v)) applied to transition matrix.
Sub-stochastic rows trigger forced teleportation back to query seed S.
Rank-order of non-Monster neighbors is provably preserved.

**Theorem 4 — Masked GNNDelete**
Enforcing zero-bound Lipschitz on c-memory nodes simultaneously with Neighborhood
Influence creates an empty feasible set — proven by contradiction.
Resolution: binary mask M (M_w = 0 for c-memory, 1 for regular) severs gradient
flow at the c-memory boundary. GNNDelete proceeds safely on regular neurons only.

**Intersection Theorem**
Two-phase pruning required:
1. Calculate local density ρ_local in k-hop neighborhood
2. Apply Monster Node penalty ONLY if ρ_local > ρ*
If density is already at the floor, penalizing the Monster Node causes
percolation collapse instead of precision improvement.

### Walls A, B, C (Sessions 022-024)

**Wall A — Pointer Gravity (Laplacian Dual-Procrustes)**
The problem: projecting 1536D LLM embeddings to 8D E₈ crystal ports ignoring
automated pointer topology would sever explicitly ingested logic.

Objective with Tikhonov regularization:
L(W) = ||WX - Y_M||²_F + γ·Tr(WXLX^TW^T) + λ||W||²_F

Where L is the Graph Laplacian of pointer affinities, γ is the Pointer
Gravity Constant (human override dial: γ→0 = pure LLM geometry, γ→∞ = pure
human topology).

Closed-form W-step via Kernel Trick:
W = Y_M(K + γKL + λI)^(-1)X^T

Where K = X^TX (Gram matrix, N×N where N≤240). Inversion is ≤240×240 instead
of 1536×1536 — 260× compute reduction.

**Wall B — Inter-Crystal Gauge Tensor**
The problem: cross-crystal PPR traversal when each crystal has its own 8D
projection matrix.

Solution: T_{A→B} = (1-λ)T_semantic + λT_human

T_semantic = (W_A^+)^T · W_B^T  (semantic gauge: lift from A's 8D → 1536D → fold to B's 8D)
T_human = (Y_AY_A^T + εI)^(-1) · Y_A · E_{A→B} · Y_B^T · (Y_BY_B^T + εI)^(-1)
           (topological wormhole: pointers crossing crystal boundary)

64 floats per crystal boundary. Simon-Ando Aggregation collapses multi-crystal
walk to O(K³) + active × O(240³).

**Wall C.1 — Crystal Mitosis (Weighted Fiedler Bisection)**
When crystal hits 240 neurons: compute Fiedler vector of weighted Laplacian L_w.
Weighted Cheeger inequality guarantees minimum semantic damage cut.
Severing rating-1 pointer costs 5× more than rating-9 — algorithm avoids strong bonds.

**Wall C.2 — Alien Injection (W_global Fractal Projection)**
Problem: novel query has no E₈ coordinate. O(N) cosine search is prohibitive.

W_global is learned from macro-structure:
- K crystal centroids form Macro-Graph
- Macro-affinity: A_macro(A,B) = ||T_{A→B}||_F (Gauge Tensor norms)
- Apply identical Dual-Procrustes at macro scale:
  W_global = Y_macro(C^TC + γC^TCL_macro + λI_K)^(-1)C^T

Query projection: q_8D = W_global · q in O(K) softmax over K centroids.
When crystal undergoes mitosis: update W_global via Schur Complement in O(K²)
without O(K³) full retraining.

### Second Law and Demotion Oracle (Session 024, Stage 2)

**Second Law of Epistemodynamics**
Markov chain: X (Markdown) → Y (PPR geodesics) → Z (LoRa weights)
By DPI: I(X;Y) ≥ I(Z;Y)
By Eckart-Young: low-rank LoRa incurs Δ = I(X;Y) - I(Z;Y) > 0 strictly.
Consequence: deletion of Markdown records is permanently forbidden.
The LoRa is lossy. The Markdown is the lossless ground truth.

**Continuous Affinity Clutch** *(locked math — April 19; replaces binary Demotion Oracle)*

The binary Demotion Oracle was a Bang-Bang Controller — a binary step-function applied
to a continuous dynamical system. At scale it produces violent oscillation. At model
upgrade it required O(N) database writes to restore the graph. Both are catastrophic cliffs.

Resolution: decouple Episodic Ground Truth from Routing Gravity.

A_base ∈ [1,10] is stored permanently — the inviolable historical record, never deleted.
PPR uses a dynamically computed Effective Affinity:

  Ã(u→v) = 2 + (A_base(u→v) - 2) · (1 - exp(-D_KL(P_MD ∥ P_LoRa) / δ(u→v)))

Behavior:
- As LoRa learns the connection: D_KL → 0, Ã glides asymptotically to 2.
  Routing gravity releases smoothly. No phase transition.
- On model upgrade (LoRa reset): D_KL → ∞, Ã snaps to A_base for every pointer
  simultaneously. Zero computation. Zero manual intervention. The explicit graph
  catches the falling mind at the exact moment of upgrade.

This formula is LOCKED math. It follows from the Second Law (A_base permanent) and
the requirement of smooth gradient behavior (no binary switches).

**D_KL evaluation — engineering decision (locked April 19):**
The LoRa is fixed for the duration of a session. Compute Ã(u→v) the first time a
pointer is traversed in a session; cache the result; reuse for that session; flush
on session end. This is lazy within-session caching. Cost: 7 dot products with W_LoRa
per pointer, amortized to zero after first traversal. Model upgrade: D_KL → ∞
evaluates automatically — no special-case code needed.

A_base itself evolves via a unified SDE (Hebbian + Ebbinghaus) — LOCKED:

  dA_base = η · 1[e ∈ Success Path] dt  (Hebbian reinforcement on successful traversal)
           - A_base / (τ_0 · max(ε, H_E + γπ_u)) dt  (Ebbinghaus decay)

This unifies Trey's hybrid success-weighted decay rule and the Ebbinghaus-Laplacian
into one equation. The SDE governs the ground truth. The Clutch governs the routing.
Calibration parameters (η, τ_0, γ) are tuned empirically once the system is running.

**δ(u→v) — Atomic Weight of a Pointer**
δ(u→v) = -π_u · log(1 - A(u→v) · R_eff(u→v))

Where R_eff(u→v) = e_v^T · L_α^(-1) · e_u (Directed Effective Resistance via
PageRank Laplacian L_α = I-(1-α)P). Computable in O(1) due to exponential decay
of fundamental matrix within 7-pointer bounded neighborhood.

**Holographic Cold-Start** *(replaces hub-centrality proxy for initial ratings — April 19)*

Using hub stationary mass (π_hub) as a proxy for initial affinity is Preferential
Attachment (Barabási–Albert model). It provably generates scale-free Monster Node networks.
Do not use it.

Initial affinity is assigned by geometric fidelity — how well the new node's embedding
fits the crystal's existing structure:

  A_init(x_new → y_port) = max(2, ⌈11 - λ · ||W_global·x_new - y_port||²⌉)

Where y_port is the nearest E₈ docking port found by Alien Injection.
Perfect geometric fit → high affinity. Poor fit → low affinity.
No rich-get-richer. No Monster Node seeding. No Graph Attention Networks required.

λ calibration: start at 1/σ² where σ² is the empirical variance of projection
residuals observed across the initial crystal population. This gives natural scaling —
a "typical" fit gets affinity ~7-8, a poor fit gets ~3-4, a perfect fit gets ~10.
Tune from system behavior after the first 500 neurons are ingested.

**Theorem of Clique Centrality** *(resolves expert density question — April 19)*

As local density ρ → 1 (expert domain approximating a complete graph), betweenness
centrality β(v) → 1/N_local → 0 for every node in the cluster.

Consequence: expert domains are immune to the Monster Node penalty. Dense expert
clusters generate redundant parallel paths that distribute routing gravity evenly —
β(v) drops below threshold θ automatically. No expert ceiling parameter needed.
ρ* = 0.78 remains a global floor only. Locally dense expert clusters exceed it freely.

**Multiplex Tensor / Intent-Parameterized Transition Matrix** *(April 19)*

The existing relation-type annotation partitions the graph into two orthogonal matrices.

LOCKED relation-type partition:

  Taxonomic (P_tax) — ATL: what something IS, structural definition, categorical lineage
    instance-of, derived-from

  Thematic (P_them) — Angular Gyrus: how things are USED, operational, situational
    causes, activates, precedes, implements, depends-on, supports, contradicts

Reasoning: `supports` and `contradicts` are evidential (how something functions in
an argument), not definitional. They belong with thematic. `implements` and `depends-on`
are operational relationships, not categorical ones.

The LLM parses each query into a Cognitive Intent Vector ω = [ω_tax, ω_them]
where ω_tax + ω_them = 1.

The active transition matrix for each PPR walk:

  P_active(q) = ω_tax(q)·P_tax + ω_them(q)·P_them

Definitional queries ("What is Window Gravity?"): ω_tax ≈ 0.8
Operational queries ("How do I build the ingestion pipeline?"): ω_them ≈ 0.8
Ambiguous intent (ω = [0.5, 0.5]): reverts to the original single P — correct fallback.
Biological TPN/DMN mutual inhibition is implemented as pure linear algebra.

CT's ENTP profile and 151st percentile verbal cognition mean his queries will naturally
yield higher-entropy intent vectors (e.g., [0.6, 0.4]) — retaining cross-domain reach
without hardcoding a user-specific suppression parameter.

No new pointer fields required — the existing relation-type annotation drives the split.

**LoRa Rank r***
r* = R_macro + N_tollbooths

Where R_macro = Simon-Ando macro-regions and N_tollbooths = neurons with
β_macro > θ_semantic. Not a hyperparameter — a physical property of CT's
mind. Scales deterministically as the Brain grows.

**Compression Event Criterion**
β_macro(v) = -Σ_r P(M_r|v) · log P(M_r|v)

Where M_r are Simon-Ando macro-regions (not individual crystals — see Stage 2 fix).
When β_macro > θ_semantic, the neuron is a cross-domain bridge. Compression fires.

θ_semantic = log(R) · (1 - exp(-κ · λ_2(L_macro)))

Self-calibrating from spectral gap. κ is an engineering calibration parameter
(start at 1.0, tune from system behavior).

### Ignition Protocol (Session 027, April 17)

**Temporal Bypass (Section 3)**
Biological STC decays: ∂S_bio/∂t = -λS_bio → S_bio → 0 as t→∞
Mathematical tag: ∂x*/∂t = 0 → λ_velorin = 0
The embedding never decays. Ignition can fire on 22-year-old data.
Biological temporal restriction is bypassed by mathematical permanence.

**Edge-Creation Formula (Section 5-6)**
Topological fitness: f(x* → u) = π^(q)_u · exp(x*^T W_LoRa x_u / τ)
Ignition Valency Constraint: A(x* → u_i) = min(10, ⌈H_E · f(x* → u_i)⌉) ≥ 8
All Ignition edges are forced high-affinity (≥ 8). Emotional engagement = strong bonds.

**Density Preservation (Section 7)**
Proven in all cases: newly crystallized node has density 1.0 (all new edges ≥ 8).
Anchor node adding reciprocal pointer: density strictly preserved or increased.
Ignition mathematically fortifies ρ* — it never dilutes it.

---

## The Novel Architectures (Not for Immediate Build)

Erdős derived four extensions that are not yet implemented:

**Kron Reduction (Semantic Wormhole):** Stale neurons partitioned as Stale set X.
PPR runs on reduced matrix P̃ = P_AA + P_AX(I-P_XX)^(-1)P_XA.
Stale nodes accumulate zero PPR mass but routing is preserved.
Implement after ingestion pipeline is running and stale neurons accumulate.

**Bipartite Teleportation (Axiomatic Grounding):** Teleportation vector splits between
query S and c-memory set M: R = (1-α)PR + α((1-λ)S + λM).
Creates standing wave between current query and CT's permanent axioms.
Implement when enough c-memory neurons exist to be meaningful.

**Demotion Oracle (Effective Resistance):** Before demoting a pointer at the 7-cap,
compute effective resistance to detect load-bearing bridges.
Requires graph query infrastructure beyond local neuron files.
Implement as part of the graph maintenance tooling.

**TAG — Topology-Augmented Generation:** Instead of flat top-K results, return a
Hamiltonian Context Tour using Edmonds' Algorithm over the induced subgraph.
Format: "[Neuron A] → (which points to) → [Neuron D] → ..."
The LLM traces CT's logical steps, not a random list.
Implement in the retrieval output layer — lowest-risk, highest-impact of the four.

---

## Temporal Memory Theory (Future Theory — Not Locked)

From Erdős Session 024 (Thermodynamics of Epistemological Time):
- H_E (Affective Hamiltonian): emotional charge as memory hardening operator
  δ*(u→v) = (1 + H_E(u)) · δ(u→v) — high H_E prevents demotion
- Ebbinghaus-Laplacian Decay: dA_t/dt = -(1/τ_0·max(ε, H_E(u)+γπ_u))·A_t
- Graph Fourier Trigger: high-freq episodic details decay, low-freq valence survives
- Semantic Dark Matter + Ignition Protocol: validated by Trey at 67-84% confidence

Status: FUTURE THEORY. Validated by neuroscience (Q4 at 85%+, Q5 at 67-84%).
Ignition Protocol formalization complete. H_E operational definition pending.
Do not include H_E in neuron YAML until the measurement procedure is designed.

---

[VELORIN.EOF]
