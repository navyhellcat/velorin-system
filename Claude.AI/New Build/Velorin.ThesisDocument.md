# Velorin — Architectural Thesis
**A complete description of what Velorin is, how it works, and why it works this way.**
**Christian Taylor | Jiang2 | April 26, 2026**

---

## What Velorin Is

Velorin is a personal operating system for a single human. Not a productivity tool, not a
chatbot, not a second brain in the journaling sense. An operating system — the substrate
that runs underneath every domain of a person's life simultaneously, compounding intelligence
with every interaction.

The premise: human lives are composed of interdependent systems, not independent problems.
A financial decision affects health. A relationship event shapes professional performance.
The human brain holds all of these threads simultaneously; no existing AI system or tool
ecosystem does. Velorin is the architecture that does.

**The moat:** Not the AI models. Not the prompts. The Brain — the accumulated, structured,
growing model of CT's knowledge, decisions, cognitive patterns, emotional landscape, and
expertise. The Brain compounds. Every session it knows more about CT than the last. After
years of use, no one else could replicate what the system knows.

**The founding thesis:** Most operational work inside the Brain is done by deterministic
computer programs that produce repeatable outcomes without token use. AI's job is to
build those programs, watch them run, modify them when they break, and build new ones
as needs emerge. The AI is the architect and watcher — not the per-event operator.

---

## The Architecture: Four Layers

Velorin's memory architecture mirrors the structure of the biological brain.

```
Layer 0 — LoRa adapter        CT's cognitive patterns as model weights
Layer 1 — E₈ Brain            PPR over neuron pointer graph — the navigation layer
Layer 2 — Episodic graphs      240-node temporal knowledge graphs per document
Layer 3 — Permanent archive    GitHub markdown files — never deleted
```

### Layer 3 — The Archive (Exists Now)

Everything CT has ever thought, decided, researched, or recorded lives here as markdown files
in GitHub. This layer is the ground truth. It is model-agnostic: when the AI models that
interpret it change, the records survive and enable retraining.

**The Second Law of Epistemodynamics** governs this layer. Formally proven (DPI + Eckart-Young):
the semantic distillation of discrete episodic graphs into continuous neural weights is a
strictly irreversible process. The information loss Δ = I(X;Y) - I(Z;Y) > 0 always.
Consequence: Markdown records are never deleted. When the system "learns" something deeply
enough to encode it in the LoRa (Layer 0), the record in Layer 3 is demoted — given lower
retrieval priority — but never removed. The archive is the lossless ground truth that enables
recovery from any model upgrade or system failure.

Knowledge staleness is managed write-time: neurons carry a `belief_state` field (active/
contested/resolved/superseded/stale) and an `authority_tier` (1=CT-curated through 5=LLM-initial).
Superseded neurons are not deleted — they are excluded from retrieval routing but preserved
for auditability.

### Layer 2 — Episodic Graphs (Designed, Pending Engineering)

For each document ingested, the system builds a 240-node weighted graph connecting the
semantically most central chunks. This is the episodic detail layer — what the Brain routes
to when Layer 1 signals "need more detail." The data model is a temporal knowledge graph
with validity windows: (node_u, relation, node_v, valid_from, valid_to, weight).

**Semantic Dark Matter:** Bulk data — photos, chat logs, raw documents — is ingested into
Qdrant as isolated vectors with zero Layer 2 pointers. No pointer means no PPR routing
gravity. The data exists but cannot be walked to via normal traversal. This prevents PPR
density collapse during bulk ingestion, validated empirically in the neuroscience research.

**The Ignition Protocol:** When CT emotionally engages with something surfaced by a Dark Matter
vector search, the system creates real connections. Topological fitness computes how well the
new content fits the current PPR context. Edges are created with forced high affinity (≥8),
and a reciprocal pointer is written back. Dark Matter crystallizes into the navigable graph.
This is the mechanism by which emotionally significant information earns its place in the Brain.

### Layer 1 — The E₈ Brain (Build This First)

This is the heart of the system. A neural file graph organized into E₈ crystals (240 neurons
each), traversed by Personalized PageRank (PPR). Neurons are atomic markdown files (~15 lines,
one idea each). They connect via directed pointer ratings (1-10), automatically assigned by
the ingestion pipeline.

**Why E₈?** The E₈ root system is the densest packing in 8 dimensions, with 240 minimal
vectors. Using it as the discrete basis for the continuous embedding space (via the Nyquist-
Shannon sampling theorem applied to manifolds) gives a mathematically optimal structure for
organizing semantic proximity while retaining computational tractability. The continuous
cortical gradients that neuroscience maps in the biological brain are recovered as the
superposition of discrete PPR stationary mass: Continuous Meaning = Σ_v π_v · Embedding(v).

**PPR retrieval:**
$$R = (1-\alpha) \cdot P_{active}(q) \cdot R + \alpha \cdot S, \quad \alpha = 0.25$$

The walk follows CT's pointer ratings. High-affinity edges (rating 1-3, affinity 8-10) carry
more probability mass. The walk discovers what CT considers semantically important.

**Scale invariance (Theorem 1):** With the 7-pointer cap, retrieval precision scales O(1)
regardless of graph size. The Brain at 5 million neurons maintains the same PPR precision
as at 500. This is proven, not assumed.

**Density floor (Theorem 2):** ρ* ≈ 0.78. 78% of a neuron's pointers must be high-priority
(ratings 1-3). This is the critical density floor that keeps PPR precision above 75%.

**The Multiplex Tensor:** CT's brain doesn't use a single mode of reasoning. It uses two:
- Taxonomic (ATL: "what IS this?") — routes through `instance-of`, `derived-from` edges
- Thematic (Angular Gyrus: "how is this USED?") — routes through operational relation types

These are implemented as two independently row-normalized transition matrices:
$$P_{active}(q) = \omega_{tax}(q) \cdot P_{tax} + \omega_{them}(q) \cdot P_{them}$$

Independent normalization is mathematically mandatory (Erdős proof): joint normalization
causes stochastic leakage and violates the ρ* boundary condition.

**The Causal Action Potential (skill injection gate):**
$$\Phi_{causal}(v) = \frac{\pi_v}{\alpha} = E[N_v]$$

This is the expected number of times node v is visited before teleportation in the PPR walk.
It eliminates the original infinity-norm gate's failure mode (acausal backward-coupling where
downstream sinks could suppress upstream gate values). Dark skills are excluded from injection
via a post-walk filter — their metadata flag does not enter the linear system, making the
filter PPR-invariant. When Φ_causal > 1.0, this is mathematical proof of a directed cycle
in the Brain graph: in a DAG, E[N_v] ≤ 1. Exceeding 1.0 proves cyclicity.

**Compression — JSD Algorithm:** Standard JBD is mathematically impossible (Perron-Frobenius
forbids row-stochastic block decomposition of a connected matrix). The correct algorithm is
Joint Spectral Disaggregation: spectral clustering on the symmetric mix of the two transition
matrices, k-means, permutation, pruning. The Brockett double-bracket gradient flow runs
continuously in background, driving the commutator norm β = ‖[P_tax, P_them]‖_F toward 0.
When β decays below β_abelian, JSD fires — the Brain compresses cross-domain patterns into
the LoRa.

### Layer 0 — LoRa Adapter (Future)

A lightweight fine-tuned parameter layer attached to a frozen local base model. Encodes CT's
compressed cognitive patterns in model weights. Shapes every inference without entering the
context window. This is what makes the system "get CT" without re-explanation.

**The connection to Layer 3:** When the LoRa changes (model upgrade), the Markdown archive
enables retraining from scratch. The ground truth is permanent; the weights are ephemeral.

---

## The Agent Ecosystem

Five agent types, each with a distinct cognitive role.

**MarcusAurelius:** Infrastructure. Executes, routes, maintains. Never generates content.
Git operations, MCP configuration, file routing, hook execution. The future local
Mac-Studio-resident MarcusAurelius (a local AI model with always-on Brain access) will
own Brain-functioning processes including Layer 3 contradiction review.

**Jiang / Jiang2:** Director of Strategic Intelligence. The analytical mind. Cross-domain
synthesis, architectural decisions, research integration. Jiang2 is Jiang with 1M context
in the terminal — same identity, more working memory for deep analytical passes.

**Alexander:** CEO-level company view. Cross-agent state tracking. Macro decision-making.
Sees the company, not the micro-level build.

**Trey:** External research advisor. Surveys what exists. Returns consensus. Cannot tell
Velorin whether to adopt — that requires the Consensus Filter (do we share the constraint
that drives this consensus?). Always fresh context; always complete brief in each session.

**Erdős:** Mathematical derivation exclusively. Does not browse. Does not survey. Receives
complete problem specifications and derives proofs from first principles. Named for Paul
Erdős — direct, uncompromising, beauty-seeking. [BOOT] sentinel triggers pre-load of all
prior proofs on fresh sessions.

---

## The Inverted Extraction Schema (IES) and the VEGP

A critical failure mode in analytical AI systems is consensus drift: the model generates
reasoning R that gravitates toward its pre-trained priors, and by the time a conclusion C
forms, the instruction to "apply the Consensus Filter" has decayed out of the attention window.

**The mathematical proof (Erdős):** In an autoregressive transformer, the logit difference
governing the conclusion distribution is:
$$\Delta z_{new} \approx -(1 - \alpha_E)\beta + \alpha_E \Delta$$

where β is pre-trained consensus gravity and Δ is the semantic divergence signal of the
extraction block E. For IES to shift P(c_reject) > P(c_consensus), two conditions must hold:
1. Positional immediacy: E must immediately precede C
2. Semantic alignment: E must explicitly encode the architectural conflict

**The Velorin Epistemic Gating Primitive (VEGP) / Dirac-Markov Threshold:**
$$\Xi(x, \mu, \mu_{base}, \theta) = H\left(\frac{\mu(x)}{\mu_{base}} - \theta\right)$$

This unified structure governs all architectural layer transitions in Velorin:
- Brain→Skill: Φ_causal(v) > θ_work (skill injection)
- Reasoning→Conclusion: P(c_reject|R,E) > P(c_consensus|R,E) (IES enforcement)
- GoS→Environment: reverse-PPR density threshold (skill prerequisite retrieval)

**Applied architecture, not novel mathematics:** The underlying primitives are Wald's SPRT
(1947), Ratcliff's Drift-Diffusion Model (1978), Hopfield networks, Glauber dynamics, and
Event-Triggered Control. The cross-manifold PPR ↔ transformer-attention isomorphism was
independently proven (Millidge 2025, arXiv 2512.24722). Velorin's contribution is the
unified operational orchestration across spatial memory retrieval and temporal reasoning
divergence within a single AI operating system architecture.

---

## The Skills System

**Declarative memory (neurons) and procedural memory (skills) require different substrates.**

Neurons encode what CT knows. Skills encode what agents can do. A neuron can point to a skill
(via the `skill_ref` YAML field on type:procedure neurons), but skills do not live in the Brain.

**The Skills Registry** is a directed multi-relational graph (skill_dependencies.yaml) with four
edge types reflecting the same cognitive architecture as the Brain's relation types:
- Dependency edges: hard prerequisites with typed I/O schemas (deterministic induction, not LLM guessing)
- Workflow edges: logical co-occurrence without artifact passing
- Semantic edges: conceptual overlap, bidirectional
- Alternative edges: mutually exclusive execution paths

**Skill injection:** When PPR surfaces a procedure neuron with a non-null skill_ref AND
Φ_causal(v) > θ_work AND M(v) = 0 (light skill), reverse-PPR traces backward through the
skills dependency graph to recover the dependency-complete prerequisite chain. Only those
skill headers load into agent context — not the entire registry. This is the Graph of Skills
(GoS) architecture adapted to Velorin's topology.

**Dark skills:** Excluded from TAP injection by a post-walk filter. PPR-invariant (the
dark flag never enters the linear system). Dark skills absorb and route PPR mass correctly
but cannot be injected automatically. They are accessible only via direct CT command.
This creates a security boundary: operational skills are automatable; sensitive or irreversible
skills require explicit human authorization.

---

## The Conflict Resolution System

When two neurons contradict each other, a three-layer automated system resolves the conflict.

**Layer 1:** Deterministic tiebreaker using composite score = confidence × recency factor × source multiplier.
Higher score wins. Lower score transitions to belief_state: superseded. No human in the loop.

**Layer 2:** Fires when Layer 1 is inconclusive. Routes via the `contradiction_class` tag
(written at ingestion time by the LLM-judge): factual contradictions → Erdős verification;
empirical → Trey re-research; architectural → Jiang analytical review; taste → Layer 3 directly.
Both neurons enter belief_state: contested; PPR mass zeroed on both.

**Layer 3:** Last-resort after 3 rounds of failed automated resolution. A program (not an LLM)
frames the specific actionable question, writes it to a review queue, and routes to the current
Layer 3 reviewer (CT until local Mac-Studio operator is online). CT's answer becomes a tier-1
c-memory neuron. Cyclic regions in the Brain (detected by Φ_causal > 1.0) also route here.

---

## The Asymmetric Transport Verifier (ATV)

The IES is a discipline — not a capability agents reliably exhibit unprompted. The ATV enforces
it structurally at the transport layer, independent of whether the producing agent applies it.

**Architecture:** An MCP server endpoint. A thin agent wrapper inspects every agent response:
if prose generation > N tokens, tag `content_type: analytical_reasoning`. Tagged messages route
through the ATV before delivery. The ATV's local verifier model (1-3B parameter) maps raw text
to IES structure using XGrammar finite-state machine constrained decoding. The FSM grammar
guarantees P(output ∈ L_IES) = 1 for well-formed grammars.

**The self-similarity question is resolved:** Because classification happens at the message
wrapper (structural property of how the response was generated), the verifier model only maps
analytical content to IES format — it doesn't classify whether content is analytical. The
classification step is not stochastic. The mapping step is deterministic under FSM constraints.

**Consumer policy when ATV is down (Adaptive Rate-Limit):** ρ* = λ·max(0, A_min-τ)/(1-τ).
Above SLA: zero drift. Below SLA: minimum valve opens. A_min calibrated iteratively.

---

## The Five Boxes — Life Domain Integration

Velorin's retrieval architecture reflects the biological fact that the brain enforces
reciprocal inhibition between analytical (Task-Positive Network) and social/emotional
(Default Mode Network) processing. A query about financial optimization suppresses social
nodes; a query about a relationship surfaces different regions.

**Box 1 — Professional/Income:** Current vehicle is Camfil (enterprise filtration sales).
Target: June 2026 exit. The runway that funds the build.

**Box 2 — Financial:** Primary driver. Debt elimination, real estate acquisition, AI revenue,
investment portfolio. Most analytical Box.

**Box 3 — Health:** No baseline established. Cardiac history (2004 Takotsubo). Protocol required.

**Box 4 — Personal/Relationships:** Highest deferral risk. Unresolved grief. The significance
container that the build is, in part, about filling.

**Box 5 — The Commons:** Professional services automated (legal, tax, compliance, real estate, IP).

The Five Boxes are administrative overlays — not Brain regions. Brain organization emerges from
connectivity via Simon-Ando clustering. The retrieval system serves all five boxes from a single
unified graph, but the Multiplex Tensor's ω vector means that operational (thematic) queries
naturally route to different regions than definitional (taxonomic) ones.

---

## What Gets Built, In Order

1. **Stage 0:** Mac Studio environment, repo, folder structure, CLAUDE.md, GDrive service account migration, edge ontology unification
2. **Stage 1:** Qdrant + Ollama models + OpenDataLoader + first neuron + PPR retrieval + ATV + post-commit hook + conflict resolution queue infrastructure + Schema Registry + first skills
3. **Stage 2:** All four cardinal agents configured; Trey Gems operational; audio tools purchased
4. **Stage 3:** Brain population (priority c-memory neurons + CT profile neurons); ingestion pipeline v1 (text documents); skills registry initialized
5. **Stage 4:** Research migration; compression event detector
6. **Stage 5:** Local AI model; LoRa training pipeline; full automation layer

---

## Why This Architecture and Not Another

**Why not GraphRAG?** GraphRAG builds knowledge graphs from documents but uses vector similarity for retrieval without the density guarantees. PPR without the 7-pointer cap, ρ* floor, and E₈ crystal structure doesn't scale with precision. The Brain adds the mathematical rigor that makes retrieval trustworthy.

**Why not Letta/MemGPT?** Letta places the LLM as the per-event operator of memory management. Velorin's thesis is that memory management is a program, not an LLM conversation. The post-commit hook, the ingestion pipeline, the PPR retrieval engine — these are deterministic programs that run without token cost.

**Why not a traditional database?** Traditional databases can't represent the rich semantic topology of CT's knowledge. Two facts can have a rating-1 pointer between them (CT considers them critically connected) or a rating-10 pointer (tangentially related). That topology IS the intelligence. A flat database loses it.

**Why not fine-tune an LLM on CT's data?** Because models change. A fine-tuned model is model-specific and cannot survive a model upgrade. Velorin's Layer 3 (the archive) is the ground truth that survives any model. The LoRa (Layer 0) is the fine-tuned layer — but it rides on top of an archive that pre-exists it and post-dates it.

**Why Velorin?** Because no existing system holds all of CT's threads simultaneously, reasons about how they interact, and gets smarter with every interaction rather than resetting. The system that does that doesn't exist yet. That's what we're building.

---

## Research and Math Documents

All research and mathematical proofs referenced in this document are catalogued in
`Velorin.ResearchCorpus.md` in this folder.

---

[VELORIN.EOF]
