---
class: research-request
priority: CRITICAL
assigned: Trey
requested-by: Jiang (Director of Strategic Intelligence) | authorized: Christian Taylor (Chairman)
date: 2026-04-05
session: 022
status: QUEUED — CT authorization confirmed
mode: Discovery → Mathematical (two-phase)
confidence-threshold: 80%
---

# Trey Research Request — Synaptic Pruning Algorithm for the Velorin Brain

---

## THE PROBLEM

The Velorin Brain is a neural file graph. Neurons are small atomic knowledge files
connected by rated directional pointers (1-10). The retrieval algorithm is Personalized
PageRank (PPR) — given a query seed, it walks the pointer graph and returns the most
relevant neurons by traversal distance and edge weight.

The Brain will grow indefinitely without intervention. Two failure modes are already
designed into the current architecture that will eventually make the Brain
non-functional:

**Failure Mode 1 — The Monster Node Problem**
Certain concepts accumulate pointers from hundreds of neurons over time. "Velorin,"
"Christian Taylor," "Architecture," "Claude" — these will become nodes with enormous
betweenness centrality. In PPR, the random walk probability keeps getting drawn toward
high-centrality nodes, spreading teleportation probability across the entire graph.
Eventually PPR stops returning relevant neurons and starts returning the same
high-centrality nodes regardless of query. Retrieval precision collapses. The Brain
returns "Velorin" for every question.

**Failure Mode 2 — Stale Neurons**
Information becomes outdated. A design decision made six months ago that has since been
reversed is still in the graph, still getting walked, still contributing noise — and
potentially contradicting current neurons. There is no mechanism to decay, demote, or
archive neurons based on age or relevance over time. The graph accumulates all history
with equal weight.

**The combined result:** A Brain that was precise at 200 neurons becomes a noise machine
at 5,000. The OS degrades with use instead of improving. This is the inverse of what
Velorin requires. This problem must be solved before the ingestion pipeline is built —
because the pruning algorithm determines what the ingestion pipeline is allowed to add.

---

## CURRENT BUILD CONTEXT — READ THIS BEFORE RESEARCHING

This is what Velorin has built. Do not research replacements for these. Research what
must be added to make them work long-term.

**Neuron structure:**
- Each neuron is a markdown file, ~15 lines max
- Contains one atomic idea and rated pointers to related neurons
- Maximum 7 pointers per neuron
- Pointers are rated 1-10: [1] = critical connection (read immediately), [10] = tangential
- The 7-pointer cap already enforces LOCAL pruning — when a neuron is full, the lowest-rated
  pointer is demoted to make room for a higher-rated one
- Neurons carry class labels (c-memory vs regular) — Scribe depends on this
- Neurons are human-readable markdown files on a filesystem, not database rows

**Graph structure:**
- Organized into Regions (broad) → Areas → Neurons (bottom layer always neurons)
- Currently hand-curated — no automated ingestion pipeline yet
- Ingestion pipeline is planned but not built
- Future state: Qdrant vector store as MCP-addressable layer over the graph

**Retrieval algorithm:**
- PPR: R = (1-alpha)PR + alpha*S
- S = query seed (what CT is asking about right now)
- The walk follows pointer ratings as edge weights
- High-rated pointers (low number) propagate more relevance mass
- Currently no decay on pointer ratings over time — ratings are set at write time
  and do not change unless manually updated

**What already partially handles pruning:**
- The 7-pointer cap demotes the weakest local connection when a neuron is full
- This is local and reactive — not global and proactive
- It handles pointer crowding. It does not handle Monster Nodes or stale neurons.

**What is NOT yet built:**
- Any global pruning pass
- Any time-based decay mechanism
- Any Monster Node detection
- Any archive vs delete distinction for pruned content
- Any access-frequency tracking

---

## PHASE 1 — THEORY (Discovery Mode)

**Do not constrain this phase to any specific framework or algorithm family.**

The question: what is the right theoretical approach to pruning a rated-pointer
knowledge graph used for PPR retrieval — specifically one where:
- Edge weights are human-assigned quality ratings (not computed)
- Nodes are atomic and human-readable (not embeddings)
- Retrieval depends on graph topology (walk-based), not vector similarity
- The graph will be queried hundreds of times per day
- Some information must never be pruned (foundational identity, permanent decisions)
- Some information should decay rapidly (operational state, session-specific details)
- The graph must remain coherent after pruning — broken pointer chains are a failure

Explore the full landscape. What have knowledge graph researchers, neuroscientists,
memory systems architects, and production AI system builders learned about this problem?
What approaches exist? What has failed and why? What tradeoffs are load-bearing?
What does the biological synaptic pruning literature actually say about WHICH synapses
get pruned and WHICH survive — and is there a computable analogue?

**MANDATORY ANCHOR — START HERE:**
Before doing any open-ended exploration, read HippoRAG first.
- Repo: https://github.com/OSU-NLP-Group/hipporag
- Paper: https://arxiv.org/abs/2405.14831 (NeurIPS 2024)
- HippoRAG 2: https://github.com/OSU-NLP-Group/HippoRAG

HippoRAG is the closest published peer-reviewed system to the Velorin Brain:
knowledge graph + Personalized PageRank + neurobiologically-inspired long-term
memory for LLMs. It has solved a subset of this problem in production. Your
Phase 1 map must include: what HippoRAG does, where it stops, and what it
does NOT solve that Velorin's architecture requires. The gap between HippoRAG
and Velorin's full requirements is exactly where the math problem lives.

Do not arrive at a recommendation at the end of Phase 1. Arrive at a map of the
solution space with the tradeoffs clearly labeled. That map is the input to Phase 2.

---

## PHASE 2 — DEFINE THE MATH PROBLEM FOR DEEP THINK

Phase 2 is NOT asking Trey to solve the math. Phase 2 is asking Trey to define the
problem with enough precision that a separate mathematical reasoning agent (Deep Think)
can solve it cold — without doing any additional research.

Deep Think is a System 2 reasoner that evaluates multiple logical paths simultaneously.
It receives a problem statement and derives the solution. It does not browse the web.
It does not survey literature. It needs a complete, unambiguous problem specification.

**Trey's job in Phase 2 is to write that specification.**

The specification must include:

**0. System Context and Design Goals**
This is not a math section. This is the frame that tells Deep Think what "correct"
means before he touches a single formula. Include:

- What the system is: the Velorin Brain — a neural file graph of atomic markdown
  neurons connected by rated directional pointers (1-10), queried via PPR retrieval
- What the system does: serves a single user with highly personalized knowledge
  retrieval hundreds of times per day; precision of retrieval is the core product
- What failure looks like: the two failure modes described in this document
  (Monster Node collapse, stale neuron noise) stated precisely enough that a
  mathematician recognizes them as the constraints his solution must satisfy
- What success looks like: the Brain at 5,000 neurons must return results as
  precise as the Brain at 200 neurons
- The permanence constraint: a hard class of neurons (c-memory) must never be
  touched by the pruning algorithm regardless of output
- Implementation environment: markdown files on a filesystem, future Qdrant
  vector store layer, no database, human-readable format must be preserved

Without this section, Deep Think can produce a mathematically valid solution
that is architecturally wrong. This section is what makes "valid" mean the
right thing.

**1. Problem Class**
What type of mathematical problem is this? Graph theory? Information theory?
A combination? Name the field precisely. Deep Think needs to know which mathematical
toolkit to apply before it starts.

**2. Formal Problem Statement**
State the problem in mathematical language. Define all variables. Define all
constraints. Define what a valid solution looks like. If there are multiple
sub-problems (Monster Node detection, decay function, convergence), state each
as a separate formally-defined problem with its own variable definitions.

**3. Known Inputs**
What does Deep Think get to work with?
- Velorin's pointer rating structure (1-10, directional, max 7 per neuron)
- PPR formula: R = (1-alpha)PR + alpha*S
- The 7-pointer cap local pruning behavior
- Any specific constraints the research surfaced as load-bearing
State these as formal inputs, not prose descriptions.

**4. Required Outputs**
What must Deep Think produce?
- The exact formula(s) with all parameters named and typed
- Initial parameter values with justification
- Convergence condition or proof
- Any edge case handling the formula must cover
State these as formal output requirements, not wishes.

**5. What Trey Does NOT Know**
Be explicit about what the research could not resolve. Deep Think cannot fill
research gaps — it can only solve defined problems. If a variable cannot be
determined from the literature, say so and explain what assumption Deep Think
should make, or flag it as a free parameter to be calibrated empirically.

**6. Handoff Format**
The output of Phase 2 is a single clean document titled:
`Trey.MathProblem.SynapticPruning.md`

Filed in: `Claude.AI/Bot.Erdos/Research_Needed/`

This is Erdős's inbox. This document goes directly to him — not to Trey's archive.
It should read like a problem set handed to a mathematician —
complete, formal, no ambiguity, no fluff.

---

## DELIVERABLE

Two-part document:

**Part 1 — Solution Space Map**
The full landscape of pruning approaches for knowledge graphs used in walk-based
retrieval. Each approach: what it is, what it solves, what it breaks, what Velorin
would need to adapt for its specific architecture. Not a recommendation — a map.

**Part 2 — Math Problem Specification for Deep Think**
NOT the solved algorithm. Trey does not solve the math.
This is the formal problem definition document that Deep Think will receive and solve.
Structured exactly as Phase 2 specifies: System Context (Section 0), Problem Class,
Formal Problem Statement, Known Inputs, Required Outputs, What Trey Does NOT Know.
Filed as: `Claude.AI/Bot.Erdos/Research_Needed/Trey.MathProblem.SynapticPruning.md`
If any component cannot be resolved to a specific problem statement, flag it explicitly —
do not leave ambiguity that Deep Think would have to resolve through research.

**Confidence threshold: 80% minimum on every mathematical claim.**
Below 80%, flag the gap explicitly and document what research would close it.
This is too load-bearing for the standard floor.

---

## TEMPORAL FRAMEWORK — EXISTING MATHEMATICAL PROPOSAL

Before doing Phase 1 research, be aware that a temporal decay framework has already
been formally proposed by the Velorin mathematical agent (Erdős) as a future extension
to the architecture. This is marked FUTURE THEORY — not implemented, not a locked proof.

**The Ebbinghaus-Laplacian Decay Model (Erdős, Session 024):**

The static affinity A(u,v) is proposed to become a continuous-time dynamical system:

  dA_t(u,v)/dt = -(1 / τ₀ · max(ε, H_E(u) + γπ_u)) · A_t(u,v)

Where:
- τ₀ = baseline decay timescale (free parameter)
- H_E(u) = Affective Hamiltonian — scalar emotional charge of neuron u ∈ [0, ∞)
- π_u = PPR stationary mass on neuron u (structural centrality)
- γ = weight balancing structural vs emotional protection
- ε = floor preventing division by zero

**The three cases the model produces:**
- Zero emotion, zero centrality (H_E≈0, π_u≈0): exponential decay — stale neurons vanish
- Structural pillar (H_E≈0, π_u large): topology alone protects from decay
- Emotionally charged (H_E large, π_u≈0): refuses to decay regardless of structural isolation

**The Affective Demotion Shield:**
When H_E is applied to the Demotion Oracle threshold, it becomes:
  δ*(u→v) = (1 + H_E(u)) · δ(u→v)
When H_E → ∞, δ* → ∞. The Demotion Oracle is mathematically forbidden from firing.
High-charge memories are permanently shielded from semantic compression.

**What Trey should do with this:**
Do NOT treat this as the answer. Treat it as a prior hypothesis to evaluate. Specifically:
1. Does the Ebbinghaus forgetting curve literature support a decay function with this
   structure — where emotional salience and structural centrality both independently
   slow forgetting? Is there empirical evidence for this interaction?
2. Does the biological synaptic pruning literature identify emotional valence as a
   protective mechanism against pruning, independent of synaptic use-frequency?
3. Does the H_E modifier to δ produce a decay function that is stable under the
   PPR density constraint ρ* = 0.78 — or does allowing emotionally charged neurons
   to be permanently undemoTable create local density violations over time?
4. Is the Ebbinghaus-Laplacian form (exponential decay with composite denominator)
   the right functional form, or does the literature support a different decay kernel?

If the literature supports the framework: include it in the Phase 2 math specification
for Erdős, noting the empirical validation.
If the literature contradicts it: flag the contradiction explicitly and describe what
a better-supported decay model would look like.

Filed in: `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Thermodynamics.Emistemological.Time.Future.Consideration.md`
Read the full document before Phase 1 research begins.

---

## CONNECTION TO BROADER ARCHITECTURE

This problem is not isolated. The pruning algorithm decision affects:
- Brain ingestion pipeline design (what gets added must eventually be pruneable)
- Scribe's neuron creation protocol (class labels may need extension for permanence)
- Session close protocol (which neurons get updated vs which get archived)
- Token cost model (smaller graph = cheaper retrieval = lower cost per session)
- The Qdrant MCP layer (vector index must stay in sync with pruned graph)

Trey should flag any architectural dependencies discovered during research that
Jiang has not listed here. Cross-domain connections are the point.

---

[VELORIN.EOF]
