# 05 — Infrastructure and Tools
**Cowork Integration, ATV, Tool-Routing, Skills, Grammar Management — Updated April 26, 2026**

---

## The Cowork Integration Layer

Claude Cowork is the orchestrator. The integration layer wires every specialist system so Cowork-Claude can activate them as sub-agents.

**Principle:** function over protocol. For each specialist system, use whatever invocation surface works — MCP if the tool supports it, API if that's cleaner, CLI for Codex, desktop hand-off for ChatGPT 5.5 visual work, browser automation if needed. Do not pick one protocol and force every tool into it. Build the invocation per tool when you reach it.

### MCP Stack (Required Day 0)

**GitHub MCP** — navyhellcat/velorin-system read/write
```json
{
  "github": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-github"],
    "env": {"GITHUB_PERSONAL_ACCESS_TOKEN": "[classic ghp_* token]"}
  }
}
```

**Filesystem MCP** — local file access scoped to repo
```json
{
  "filesystem": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-filesystem",
             "/Users/lbhunt/Desktop/velorin-system"]
  }
}
```

**After Qdrant is running:**
```json
{
  "qdrant": {
    "command": "npx",
    "args": ["-y", "mcp-server-qdrant"],
    "env": {"QDRANT_URL": "http://localhost:6333"}
  }
}
```

**ATV MCP (Stage 1 build):**
```json
{
  "atv": {
    "command": "node",
    "args": ["/Users/lbhunt/Desktop/velorin-system/infrastructure/atv/server.js"],
    "env": {"ATV_PORT": "8080", "ATV_QUEUE_LIMIT": "5"}
  }
}
```

**NEVER add:** claude-code as MCP server (causes `mcp__claude-code__` prefix bug, kills agents).

**Gatekeeper — evaluated and retired in v1→v2 transition.** Gatekeeper was a pre-MCP routing intermediary that never delivered unique value the per-vendor MCP topology didn't already provide more cleanly. The multi-vendor Cowork integration renders it entirely unnecessary. Per-vendor MCP servers are the correct topology.

**GDrive MCP (FW-003 — fix before Mac Studio transition):**
Current OAuth tokens expire every 7 days. Fix: migrate to Google Service Account JSON credentials. Trigger: Mac Studio port; apply to both machines simultaneously.

### Specialist System Invocation Surfaces

| System | Primary Surface | Protocol | Notes |
|---|---|---|---|
| Gemini Deep Research | Gemini API | A2A or API | async; waits for research to complete |
| Gemini Deep Think | Gemini API | A2A or API | synchronous heavy reasoning |
| Codex | CLI + desktop | CLI subprocess | Code sandbox; use `reasoning.effort: none` for routing classification |
| ChatGPT 5.5 | Desktop + Responses API | API (Responses API mandatory for agentic use) | 272K cost cliff — don't load large Brain context into GPT 5.5 |
| Google visual tools | API | Google API | Image/video generation, visual reasoning |
| Open-source tools | Local + pip | Subprocess / Python import | OpenDataLoader, Gemma 4 VLM, 3D tools, GitHub skill repos |

**NotebookLM is NOT a Velorin component.** It is a human-facing project-context-feeder CT uses with Deep Think for outside-perspective audit passes on individual projects. Velorin agents do not invoke it. It is CT's tool, not the system's tool.

*→ FW-015 (open — Stage 1 build discussion): multi-vendor cost economics. GPT 5.5's 272K input-token cost cliff, Gemini Deep Research billing, Codex sandbox pricing. Flag in Budget considerations when building the tool-routing program.*
*→ FW-016 (open — Stage 1 build discussion): Mac Studio multi-vendor security model. OAuth 2.1 + DCR barriers for remote MCP from local Mac Studio (per Trey GPT55 research). Local execution preferred where possible.*

---

## ARC-2 — Tool-Routing Program (Stage 1 — Part 1)

**Mathematical foundation:** Erdős Solution 1 in `Erdos.Solution.COMBINED.Apr26.md`. Optimal tool routing is a strict, finite instance of the VEGP. The routing matrix is an affine bipartite projection, NOT a Markov endomorphism (the Multiplex Tensor isomorphism was definitively refuted).

**The VEGP gate for routing:**
$$\Xi(v_{(1)}, \mu, \mu_{base}, \theta) = H\left(\frac{\mu(v_{(1)})}{\mu(v_{(2)})} - (1 + \epsilon_{gap})\right)$$

Where $\mu(v_i) = (V \cdot \vec{\omega}_{task})_i$ (task alignment score for tool $v_i$) and $\mu_{base} = \mu(v_{(2)})$ (runner-up score). When Ξ = 0 (capability gap ambiguous), fallback logic activates.

**Capability matrix V — column-normalized, NOT row-normalized:**
$V \in \mathbb{R}^{m \times n}$ where $m$ = tools, $n$ = cognitive task types. Column-normalize each task-type column so scores are relative within a task type. Row-normalizing would enforce a zero-sum capability budget (good at coding = penalized in writing) — structurally wrong. (Erdős Proof 1A, `Erdos.Solution.COMBINED.Apr26.md`.)

**Program specification:**
1. Column-normalize V at initialization; recalibrate as tool capabilities evolve (Check-Ins entry — see `Velorin.CheckIns.md`)
2. On each task: compute $\mu = V \cdot \vec{\omega}_{task}$; apply VEGP with configured ε_gap
3. If Ξ = 1: activate top tool $v_{(1)}$ — route task via tool's invocation surface
4. If Ξ = 0: activate ensemble (top 2-3 tools in parallel); Cowork-Claude integrates results
5. Log every routing decision for AI oversight

**Build as MCP endpoint:** `toolrouter.route(task_content, omega_task) → tool_invocation`. Call sites don't change if the routing logic is improved.

*→ Build-space (Stage 1): tool capability matrix V initial values. Start conservative (use domain knowledge; calibrate empirically from routing outcomes). Check-Ins entry — see `Velorin.CheckIns.md`.*

*→ Forward note (Stage 3 Part 2): Brain PPR walks will begin producing task-intent signal ($\vec{\omega}_{task}$ estimated from query) that can improve routing specificity over time.*

---

## ARC-1 — Virtual Contradiction Graph (Stage 1 — Part 1)

**Mathematical foundation:** Erdős Solution 2. Cross-tool context conflict is formally equivalent to Brain neuron contradiction under a bipartite source-graph transformation.

**The pattern:** When Cowork-Claude receives conflicting outputs from multiple specialist systems on the same factual claim (e.g., Claude says "the deadline is Thursday," Gemini says "the deadline is Friday"), this is treated as a contradiction.

**Encoding:**
- Each vendor claim → virtual neuron with `source_metadata = {vendor: "Claude", session: ..., timestamp: ...}`
- Logical inconsistency → bidirectional `contradicts` pointer between virtual neurons
- `authority_tier` ordering applies: higher-capability system for the task type gets higher tier

**Detection:** Asymmetric NLI surrogate. Feed both outputs to a local NLI model; check for mutual exclusion on the disputed claim. If detected, generate the virtual contradiction edge.

**Resolution (same Layer 1-2-3 mechanism):**
1. Layer 1: composite score tiebreaker; higher-scoring claim wins
2. Layer 2: if scores within ε, route by `contradiction_class` tag — factual disputes go to Erdős (or Gemini Deep Think), empirical disputes go to Trey
3. **Broker pattern (Layer 2 deadlock):** when Layer 2 composite score yields Ξ=0, Cowork-Claude activates an orthogonal high-authority specialist as Broker (e.g., if Claude and Gemini conflict, activate Codex for adversarial review). Broker selection: highest `authority_tier` tool NOT already involved in the conflict.
4. Layer 3: if Broker also deadlocks → Chairman escalation queue

**Propagation:** winning claim propagates as `belief_state: active`; losing vendor's context receives a system prompt injection marking the disputed claim as `superseded`.

**Build note:** the virtual contradiction graph doesn't require the Brain. It operates entirely within the Cowork layer using virtual neurons. This is a Part 1 primitive.

*→ Forward note (Stage 3 Part 2): when Brain neurons are populated, the same Layer 1-2-3 mechanism handles BOTH virtual cross-tool contradictions AND real Brain neuron contradictions, using the same code path.*

---

## Asymmetric Transport Verifier (ATV) — Stage 1 Build Component

**Purpose:** Structural enforcement of the Inverted Extraction Schema (IES) at the transport layer. Ensures analytical outputs from Cowork agents have explicit divergence evaluation before conclusions form.

**IES structure (FSM grammar enforces this):**
```xml
<context_boundary_check>
  1. Define limits of current context on this topic.
  2. List adjacent research/files NOT queried that might alter analysis.
  3. State whether concluding now violates Window Gravity. If YES: stop and query.
</context_boundary_check>
<consensus_extraction>
  1. State the prevailing consensus on the topic.
  2. Identify whether consensus exists for technical necessity or historical accident.
</consensus_extraction>
<velorin_divergence_evaluation>
  1. Apply Consensus Filter: does this consensus serve Velorin's architecture?
  2. If adopted: specify which Velorin principle or capability it degrades.
</velorin_divergence_evaluation>
<final_conclusion>
[permitted only after above sections complete]
</final_conclusion>
```

**Architecture:**
- Agent wrapper: inspects agent output content blocks; tags prose > N tokens as `content_type: analytical_reasoning` (runtime-set, not producer-declared; this IS the ATV build, ships together)
- ATV MCP endpoint: reads tag, maps raw text to IES structure via XGrammar FSM
- Default on missing tag at ATV endpoint: fail-secure (apply IES enforcement)
- Tag-missing events → `infrastructure/queues/atv-review/` as anomalies
- Queue overflow (>5 pending) → `infrastructure/queues/atv-overflow/`

**IES threshold:** θ = 0.7 (anti-drift bias; false-rejection bounded by FSM structure; drift-through-enforcement is the unbounded failure mode).

**Verifier model:** 1-3B parameter (Qwen2.5-0.5B, SmolLM2-1.7B — selected by benchmark). vllm-mlx backend (Apple Silicon, continuous batching, prefix caching for IES system prompt). NOT Qwen 3.6 14B.

**Consumer policy when ATV is down (Decision 1 — locked):**
$$\rho^* = \lambda \cdot \frac{\max(0, A_{min} - \tau)}{1 - \tau}$$
A_min calibrated iteratively through build + test.

**Scope:** inter-tool analytical conclusions only. NOT skill execution output, Brain ingestion output, Erdős solutions, short structured messages.

---

## Schema Registry and FSM Grammar Management (Stage 1)

IES grammar is compiled infrastructure — agents reference by cryptographic hash, not text.

**Minimum viable workflow:**
1. IES grammar source in Git
2. Post-commit hook compiles to XGrammar artifact + generates SHA-256 hash
3. Local SQLite maps hash → binary artifact path
4. ATV reads grammar hash from message envelope; retrieves compiled artifact via O(1) lookup

**Property-Based Testing (Hypothesis library):** generates synthetic valid IES messages from grammar; verifies json.loads() passes. Runs on every grammar commit.

**Compiler-in-the-Loop AI review:** AI proposes grammar changes → XGrammar compilation feedback drives revision → AI iterates until clean compile. AI does not judge FSM syntax directly.

*→ Build-space Stage 2 (trigger: Cowork begins routing real production traffic across multiple vendors): Differential Equivalence + Shadow Mode. Seam: `apply_grammar(message, grammar_hash, shadow_hash=None)` interface built at Stage 1, shadow_hash=None always until Stage 2.*

*→ Build-space Stage 3 (trigger: Canary activates when Cowork begins routing real production traffic across multiple specialist vendors — this is a qualitative transition point, not a message-volume threshold): Canary rollout. Load balancer config only, no application code change.*

---

## Skills Registry

**Location:** `skills/skill_dependencies.yaml`

**4-type GoS edge schema:**
```yaml
skills:
  skill-name:
    path: skills/skill-name/SKILL.md
    edges:
      dependency: [skill-b]      # hard prerequisite; typed I/O schema match required
      workflow: [skill-c]        # logical co-occurrence; no artifact passing
      semantic: [skill-d]        # conceptual overlap; bidirectional
      alternative: [skill-e]     # mutually exclusive execution paths
    artifact_schema_in:
      field_name: type
    artifact_schema_out:
      field_name: type
    mode_config: {}              # extensibility dict
    dark: false                  # if true: not injectable via Φ_causal; CT-direct only
```

Dependency induction is deterministic (I/O schema matching, not LLM guessing). Cycles permitted — α=0.15 teleportation ensures PPR convergence.

**External skill pointers (from Skill.Registry.Design.md Session 021):**
Velorin also maintains a registry of pointers to external community skills (GitHub skill repositories). These are thin pointer wrappers that fetch content at invocation time — not ported copies. External community maintains the content; Velorin maintains the pointer.

*→ Build-space Stage 3 (trigger: N skills in library, N defined at Stage 3 design): GoS sparse validation mode swap from dense. Seam: `validate_skill_edges(..., validation_mode="dense", mode_config={})`. One-param config change at swap time. State handover: no persistent state; output schema identical.*

---

## Media Extraction Tools

**OpenDataLoader PDF v2.0** — primary PDF parser (replaces Docling — 1GB footprint, times out on >1MB files)
- Apache 2.0; `pip install opendataloader-pdf`; fork and customize for source_coords piping
- XY-Cut++ reading order, Formula Extraction AI (LaTeX inline), JSON bbox per element
- 0.907 accuracy across 200 scientific papers

**Surya** — equation OCR fallback
- `pip install surya-ocr`; PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0 required on M4 Max

**Qwen2.5-VL 7B** — image/diagram/table extraction (Ollama local)

**Voibe** ($99 lifetime) — live dictation, <300ms, 100% offline, Apple Silicon

**MacWhisper Pro** (~€59 lifetime) — batch audio transcription, speaker diarization

---

## GPS Layer and Navigation

**CLAUDE.md:** GPS pointer only. Never contains file paths, tool names, agent instructions. Points to Velorin.Welcome/_index.md.

**Velorin.Welcome/_index.md:** universal entry point, agent roster, universal operating principles. Never contains platform-specific instructions.

**Navigation rule:** agent name → folder convention → ReadMe.First → handoff → Brain (on demand only). Boot is fast. Brain is not loaded on boot.

---

## Hook System

**Currently wired:** SessionStart git pull hook (confirmed working).

**Post-commit edge handler (Stage 1 build):** `infrastructure/hooks/post-commit-edge-handler.sh` — reads `supersedes` and `contradicts` edges in newly committed neurons; updates belief_state on target neurons; validates skill dependency graph consistency.

*→ Forward note: the post-commit hook handles both Brain belief_state updates AND skill dependency graph validation — one hook, two graph substrates.*

**Compaction hooks (OQ-8 — not yet built):** PreCompact/PostCompact. Write and test standalone before wiring.

---

## Prompting Principles

**Window Gravity (CARDINAL):** Context window is not the world. Continuous question: "Am I confident because I verified, or because the window felt full?" Match verification cost to stakes.

**Consensus Filter (CARDINAL on every Trey deliverable):** Q1 what is the consensus / Q2 why does it exist / Q3 does Velorin share that constraint. Q3=no → consensus is a boundary, novelty lives on the other side.

**IES / Rule Activation Gap:** Preamble checklists fail during mid-reasoning due to attention decay. IES enforced at transport layer via ATV — the structural fix.

**Query modes:** TIGHT (default, assume frame correct) vs DISCOVERY (assume frame incomplete). Caller declares the mode.

---

[VELORIN.EOF]
