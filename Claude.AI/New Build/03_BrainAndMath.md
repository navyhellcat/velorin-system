# 03 — Brain and Math
**Neuron format, PPR, E₈ crystals, all locked Erdős results — Updated April 26, 2026**

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
source_coords: {file: "path/to/source.pdf", page: N, bbox: [x1, y1, x2, y2]}
belief_state: active
authority_tier: 4
resolution_attempts: 0
contradiction_class: factual
skill_ref: null
base_model_config: {type: "personal", id: "ct-v1"}
---

[One atomic self-contained claim. 10–15 lines max.]

## Pointers
- [[region/area/neuron-slug]] 0.9 — supersedes: prior-claim-slug
- [[region/area/neuron-slug]] 0.8 — depends-on: reason
- [[region/area/neuron-slug]] 0.4 — contradicts: competing-claim-slug
```

### Field Definitions

**id:** Semantic slug. Lowercase, hyphens only. Globally unique.

**type:** What kind of knowledge this neuron contains.
- `entity`: A person, system, organization, or concrete thing
- `concept`: An idea, principle, or pattern
- `fact`: An established datum
- `goal`: Something the system is working toward
- `procedure`: A process or sequence of steps (may carry skill_ref)

**class:**
- `c-memory`: Permanent. Never modified by any automated process. Never deleted. Set by CT only.
- `regular`: Subject to demotion when LoRa learns the connection.

**confidence:** The LoRa training gate.
- 1.0: CT explicitly set this. Certain.
- 0.9: CT reviewed and validated.
- 0.8: Cross-corroborated. LoRa-eligible.
- 0.7: Behaviorally confirmed.
- 0.5: Auto-generated initial. Not LoRa-eligible until validated.

**source_coords:** Required for all auto-ingested neurons. OpenDataLoader provides
[x1, y1, x2, y2] bounding box per extracted element — enables citation-level provenance
back to the exact page and paragraph in the source document.

**belief_state:** Managed by post-commit hook — never by per-event LLM.
- `active`: Current, well-evidenced, PPR-accessible
- `contested`: Contradiction detected; PPR mass zeroed; Layer 1 tiebreaker or Layer 2 verification in progress
- `resolved`: Contradiction addressed; prior versions preserved in version chain
- `superseded`: A newer neuron replaces this one; excluded from PPR mass routing
- `stale`: Currency has decayed; identified as outdated

**authority_tier:** Used by Layer 1 tiebreaker for same-tier contradiction resolution.
- 1: CT-curated (c-memory tier)
- 2: Erdős-verified mathematical fact
- 3: Cross-corroborated by multiple independent sources
- 4: Agent-generated, reviewed and validated
- 5: LLM-generated initial (not yet validated)

**resolution_attempts:** Counter for contested neurons. After 3 failed rounds → Layer 3.

**contradiction_class:** Written at ingestion time by LLM-judge. Deterministic routing in Layer 2.

Schema: `contradiction_class: <primary>.<sub_category>` (primary required; sub_category optional initially).

Five primary values (CT-locked 2026-04-26):
- `factual` — empirical truth-value dispute (e.g., `factual.mathematical`, `factual.scientific`)
- `empirical` — ecosystem/research finding dispute (e.g., `empirical.tooling`, `empirical.literature`)
- `architectural` — system design decision dispute (e.g., `architectural.schema`, `architectural.protocol`)
- `taste` — judgment/aesthetic/preference dispute; routes to Layer 3 directly
- `operational` — runbook/deployment/config/process dispute (e.g., `operational.deployment`)

Routing destinations live in `Claude.AI/conflict_routing.yaml` (separate from schema). Adding new sub-categories requires only a routing config update, never a schema change.

**skill_ref:** Path to a SKILL.md file. Only populated for `type: procedure` neurons that serve
as Brain-to-Skills gateway nodes. NULL for all other neurons. PPR-invariant — does not appear
in the linear system that determines π.

**base_model_config:** Deployment configuration. Training pipeline reads this at initialization.
Direction C (Session 034 lock): `{type: "personal", id: "ct-v1"}`. Future expansion is a
config flip plus new training pass, not a rewrite. Downstream components (skill injection,
Φ_causal gate, PPR, ATV) remain agnostic to base identity.

### Pointer Notation

Pointers follow this format:
```
- [[region/area/neuron-slug]] weight — relation-type: description
```

Weight is a float 0.0-1.0 derived from the automatically-assigned rating:
`weight = (11 - rating) / 10`

**9-class relation types — REQUIRED for all auto-ingested neurons:**

Binary routing (which transition matrix) is DERIVED from the 9-class label:
- Taxonomic (P_tax): `instance-of`, `derived-from`
- Thematic (P_them): `causes`, `activates`, `precedes`, `implements`, `depends-on`, `supports`, `contradicts`

**Additional temporal/conflict labels (not part of PPR routing; handled by post-commit hook):**
- `supersedes` — triggers belief_state: superseded on target
- `contradicts` — triggers belief_state: contested on both parties; Layer 1 tiebreaker fires
- `same_as` — staged merge proposal requiring CT confirmation

---

## The Affinity Mapping

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

The transition matrix $P_{ij} = \mathcal{A}(i,j) / \sum_k \mathcal{A}(i,k)$ where $\mathcal{A}(i,j) = 11 - W(i,j)$.
5 of 7 pointers must be ratings 1-3 (affinities 8-10) to maintain ρ* = 0.78.

---

## All Locked Erdős Results

These are proven. Do not revisit. Do not debate them.

### Theorems 1-4 (Synaptic Pruning Session, April 5)

**Theorem 1 — Scale Invariance**
ρ*(n) = O(1). With d_max = 7 and teleportation α, the required high-priority edge density
is completely independent of graph size n.

**Theorem 2 — The Density Floor**

$$\rho^* \approx 0.78 \text{ at } \alpha = 0.25$$

$$\rho^* = \frac{K_\alpha \cdot A_L}{A_H(1-K_\alpha) + K_\alpha \cdot A_L}$$

where $K_\alpha = (1 - 4\alpha/3)/(1-\alpha)$, $A_H = 9$, $A_L = 4$.

**Theorem 3 — Monster Node as Semantic Mirror**
Fisher Information penalty $f(I(v)) = \max(1, \kappa \cdot I(v))$ applied to transition matrix.
Sub-stochastic rows trigger forced teleportation back to query seed S.
Rank-order of non-Monster neighbors is provably preserved.

**Theorem 4 — Masked GNNDelete**
Binary mask M (M_w = 0 for c-memory, 1 for regular) severs gradient flow at c-memory boundary.
GNNDelete proceeds safely on regular neurons only.

**Intersection Theorem**
Two-phase pruning: calculate local density ρ_local in k-hop neighborhood;
apply Monster Node penalty ONLY if ρ_local > ρ*.

### Walls A, B, C (Sessions 022-024)

**Wall A — Pointer Gravity (Laplacian Dual-Procrustes)**

$$\mathcal{L}(W) = \|WX - Y_M\|^2_F + \gamma \cdot \text{Tr}(WXLX^T W^T) + \lambda\|W\|^2_F$$

Closed-form: $W = Y_M(K + \gamma KL + \lambda I)^{-1}X^T$ where $K = X^TX$.
γ = Pointer Gravity Constant (human override dial: γ→0 = pure LLM geometry, γ→∞ = pure human topology).

**Wall B — Inter-Crystal Gauge Tensor**

$$T_{A \to B} = (1-\lambda)T_{semantic} + \lambda T_{human}$$

$T_{semantic} = (W_A^+)^T \cdot W_B^T$
$T_{human} = (Y_A Y_A^T + \varepsilon I)^{-1} \cdot Y_A \cdot E_{A \to B} \cdot Y_B^T \cdot (Y_B Y_B^T + \varepsilon I)^{-1}$

64 floats per crystal boundary.

**Wall C.1 — Crystal Mitosis (Weighted Fiedler Bisection)**
Weighted Cheeger inequality guarantees minimum semantic damage cut.
Severing rating-1 pointer costs 5× more than rating-9.

**Wall C.2 — Alien Injection (W_global Fractal Projection)**

$$W_{global} = Y_{macro}(C^TC + \gamma C^T C L_{macro} + \lambda I_K)^{-1}C^T$$

Query projection: $q_{8D} = W_{global} \cdot q$ in O(K) softmax over K centroids.
Mitosis → W_global updates via Schur Complement in O(K²).

### Second Law and Affinity System (Session 024)

**Second Law of Epistemodynamics**
Markov chain: X (Markdown) → Y (PPR geodesics) → Z (LoRa weights)
By DPI: I(X;Y) ≥ I(Z;Y); by Eckart-Young: Δ = I(X;Y) - I(Z;Y) > 0 strictly.
Consequence: deletion of Markdown records is permanently forbidden.

**Continuous Affinity Clutch** (replaces binary Demotion Oracle)

$$\tilde{\mathcal{A}}(u \to v) = 2 + (\mathcal{A}_{base}(u \to v) - 2) \cdot \left(1 - \exp\left(-\frac{D_{KL}(P_{MD} \| P_{LoRa})}{\delta(u \to v)}\right)\right)$$

**A_base SDE:**

$$d\mathcal{A}_{base} = \eta \cdot \mathbf{1}[e \in \text{Success Path}]\, dt - \frac{\mathcal{A}_{base}}{\tau_0 \cdot \max(\varepsilon, H_E + \gamma \pi_u)}\, dt$$

**D_KL evaluation — lazy within-session caching:**
Compute Ã(u→v) on first pointer traversal per session; cache; flush on session end.
Cost: 7 dot products with W_LoRa per pointer, amortized to zero after first traversal.

**δ(u→v) — Atomic Weight of a Pointer:**

$$\delta(u \to v) = -\pi_u \cdot \log(1 - \mathcal{A}(u \to v) \cdot R_{eff}(u \to v))$$

### Ignition Protocol (Session 027)

**Temporal Bypass:** ∂x*/∂t = 0 → λ_velorin = 0. Embeddings never decay. Ignition can fire on any age data.

**Edge-Creation Formula:**

$$f(x^* \to u) = \pi^{(q)}_u \cdot \exp(x^{*T} W_{LoRa} x_u / \tau)$$

$$\mathcal{A}(x^* \to u_i) = \min(10, \lceil H_E \cdot f(x^* \to u_i) \rceil) \geq 8$$

All Ignition edges forced high-affinity (≥ 8). Proven density-preserving in all cases.

### Theorem of Clique Centrality

As local density ρ → 1, betweenness centrality β(v) → 1/N_local → 0.
Expert domains are immune to the Monster Node penalty.
Dense expert clusters self-protect; ρ* = 0.78 remains a global floor only.

### Multiplex Tensor — Independent Row-Normalization (Session 033, Erdős proof)

$$P_{active}(q) = \omega_{tax}(q) \cdot P_{tax} + \omega_{them}(q) \cdot P_{them}$$

**CRITICAL:** $P_{tax}$ and $P_{them}$ must be independently row-normalized:

$$\sum_j P_{tax,ij} = 1 \quad \forall i \qquad \sum_j P_{them,ij} = 1 \quad \forall i$$

Joint normalization causes stochastic leakage. Proof (Erdős IndependentMultiplexNormalization):
Joint normalization with asymmetric edge distributions produces sub-stochastic rows, forcing
artificial teleportation that violently violates the ρ* boundary condition.

The density constraint is preserved under independent normalization:

$$\sum_{j \in \Omega_i} P_{active,ij}(q) = \rho^*(\omega_{tax}(q) + \omega_{them}(q)) = \rho^* \quad \blacksquare$$

The Laplacian factors perfectly: $\mathcal{L}_{active}(q) = \omega_{tax}(q)\mathcal{L}_{tax} + \omega_{them}(q)\mathcal{L}_{them}$
Inter-layer interference strictly governed by query weights — not by raw degree distributions.

### Causal Action Potential — Derivation (Session 034, Erdős DarkSkillsTriggerlessGate)

Original infinity-norm gate introduced acausal backward-coupling: downstream sinks could
mathematically suppress upstream gate values through the global denominator.

$$\Phi_{causal}(v) = \frac{\pi_v}{\alpha} = E[N_v]$$

**Spectral band for θ_work:**
- Signal ceiling: $\Phi_{supremum} \leq (1-\alpha) \cdot \rho^* = 0.75 \times 0.78 = 0.585$
- Uniqueness bound: $\theta_{work} > (1-\alpha)/2 = 0.375$
- Valid band: $\theta_{work} \in (0.375, 0.585]$
- Provisional value: 0.5 (analytically sound; exact optimum requires 738 labeled queries — PAC bound)

**Multiple simultaneous activation:** If Φ_causal(v) > θ_work for multiple procedure neurons,
inject ALL of them. Multiple clearances require orthogonal intent or massive convergent consensus.

**Cyclic detection:** In any DAG, $E[N_v] \leq 1$. Therefore $\Phi_{causal}(v) > 1.0$ is
mathematically absolute proof of a directed cycle — no graph-theoretic precomputation needed.

### JSD Compression Algorithm (Session 035, Erdős ObliqueJointBlockDiagonalization)

Standard JBD impossible: Perron-Frobenius gives λ=1 multiplicity 1 for any irreducible stochastic
matrix. k stochastic blocks would force multiplicity k — contradiction. GL(N) collapses to S_N.

**Joint Spectral Disaggregation (JSD):**
1. $M_{joint} = (P_{tax} + P_{them})/2$ — symmetric mix
2. Top k right eigenvectors near λ=1
3. Row-normalize within clusters; k-means → permutation matrix Π
4. Prune off-diagonal residual via row-normalization
5. Complexity: O(k²|U|)

### Non-Abelian Brain Dynamics (Session 035)

**Theorem 2 — Non-Abelian Compression Criterion:**
The commutator $[P_{tax}, P_{them}]_F$ serves as the structural friction operator.
Commutator-vanishing is the Theorem 2 criterion (the Brockett fixed point).
Standard lumpability requires commuting matrices; Velorin's matrices do not commute → use JSD.

**Revised Theorem 3 — Cognitive Langevin Dynamics:**

$$dP_{tax} = \Pi_T([[P_{tax}, P_{them}]^T, P_{them}])\, dt + \sigma\, dW_t$$

Brockett double-bracket gradient flow on the row-stochastic manifold.
O(N) gauge symmetry broken to S_N by the non-negative orthant — Brain is fundamentally dissipative.
U is a Lyapunov function on the stochastic matrix manifold.

**κ operational tightness (Erdős KappaOperationalTightness Answer C):**
Analytic formula $\kappa = 2C(1-\alpha)/(\alpha\delta)$ is correct as a strict worst-case bound
but operationally too loose (Davis-Kahan looseness, spectral-gap volatility, redistribution masking).
Use as structural prior for geometric scaling when α changes. Empirical Check-ins calibration required.

### IES Gate — Probability Shift (Session 035, Erdős UnifiedGatingPrimitive)

The Inverted Extraction Schema (IES) inserts extraction block E into the reasoning sequence:
X' = (I, R, E, C). This shifts:

$$\Delta z_{new} \approx -(1 - \alpha_E)\beta + \alpha_E \Delta$$

where $\beta$ is pre-trained consensus gravity, $\Delta$ is the semantic divergence signal of E.

**Two sufficient conditions for E to shift P(c_reject) > P(c_consensus):**
1. **Positional immediacy:** E must immediately precede C (α_E decay if buried)
2. **Semantic alignment:** E must explicitly encode the architectural conflict (Δ > 0)

**TAP↔IES isomorphism (VEGP — Velorin Epistemic Gating Primitive):**

$$\Xi(x, \mu, \mu_{base}, \theta) = H\left(\frac{\mu(x)}{\mu_{base}} - \theta\right)$$

Instantiations:
1. Brain→Skill: $\Xi(v, \pi, \|\pi\|\_\infty^{RETIRED}, \theta\_{work})$ — NOW: $\Phi\_{causal}(v) = \pi\_v/\alpha$
2. Reasoning→Conclusion: $\Xi(c\_{reject}, P(\cdot|X), P(c\_{consensus}), 1.0)$ — IES gate

**Note on novelty:** The cross-manifold PPR ↔ transformer-attention isomorphism was
independently discovered (Millidge 2025, arXiv 2512.24722). VEGP as unified cross-architecture-layer
gate for AI operating system orchestration is novel as applied architecture. The gate primitive
itself (Wald SPRT 1947, Ratcliff DDM 1978) is established. Citation required in any peer-reviewed work.

### ATV Mathematical Properties (Session 033-034, Erdős ATVMathProperties)

**Proof 1 (Determinism):** FSM-constrained decoding under a well-formed DFA grammar guarantees
P(z ∈ L_IES) = 1. Base model stochastic preferences only dictate which valid path is chosen —
they cannot escape the grammar. Requires: (a) DFA pre-compiled over BPE token graph to avoid
vocabulary deadlock, (b) L_max exceeds valid path length.

**Proof 2 (Self-similarity shattered):** With header-tag classification, P(C|C_header) = 1
(deterministic software routing) and P(M|y, C_header) = 1 (Proof 1). Self-similarity failure
is eliminated, not relocated — the classification step is moved to a structural property of the
message header, not inferred by the verifier model.

**Proof 3 (Latency):** DFA masking is O(1) per token. Fixed structural skeleton tokens are
fast-forwarded (no neural forward pass when only one valid token exists).
At Mac Studio M4 Max with 1-3B verifier at S ≈ 200-400 tok/s, T_V ≈ 2-4 seconds per message.
System enters M/D/1 queueing failure when λ ≥ 0.25-0.5 messages/second (1-3B model class).

### ATV Consumer Policy (Session 035, Decision 1 — LOCKED)

**Adaptive Rate-Limit Policy:**

$$\rho^* = \lambda \cdot \frac{\max(0, A_{min} - \tau)}{1 - \tau}$$

Where τ = real-time ATV uptime fraction, A_min = minimum acceptable availability.
Above SLA: ρ* = 0, behaves as P_reject (zero drift).
Below SLA: opens valve to strict mathematical minimum drift required to keep system alive.

**Cliff edges:**
- τ = A_min: drift activates discontinuously from zero
- λ > μ_esc for Escalate policy: M/D/1 catastrophe, queue diverges to infinity

A_min is calibrated iteratively through build + test, not specified upfront.

### Dark Skills Scale Analysis (Session 034, Erdős DarkSkillsScale)

**Concurrent mutation:** Live M_{t+Δ} evaluation (not snapshot). Metadata flag M(v) never
enters the linear system; toggling M(v) has zero effect on any other node's Φ_causal.

**Refund Fallacy:** HARD ARCHITECTURAL NO. Never refund accumulated PPR mass when M(v) transitions.
Refunding destroys the Markov property.

**Dark chains:** Length-k chain consumes $1 - (1-\alpha)^k$ of traversing mass via teleportation.
At α=0.15 and k=4: ~48% mass consumed. Convergence rate unchanged (spectral gap is global).

**Dark leaf nodes:** Cannot be true absorbing states (α > 0 prevents). In-degree bound for dark
leaves: $k < (C - \alpha s_v)/((1-\alpha) \bar{w} \bar{\pi}_{in})$ — enforced at write time.

---

## Novel Architecture Extensions (Not for Immediate Build)

**Kron Reduction (Semantic Wormhole):** Stale neurons → reduced matrix $\tilde{P}$.
Implement after ingestion pipeline is running and stale neurons accumulate.

**Bipartite Teleportation (Axiomatic Grounding):** Split between query S and c-memory M.
Implement when enough c-memory neurons exist.

**TAG — Topology-Augmented Generation:** Hamiltonian Context Tour using Edmonds' Algorithm.
Implement in retrieval output layer — lowest-risk, highest-impact extension.

---

[VELORIN.EOF]
