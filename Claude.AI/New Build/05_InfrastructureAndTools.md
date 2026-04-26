# 05 — Infrastructure and Tools
**MCPs, hooks, GPS system, ATV, Skills Registry, grammar management — Updated April 26, 2026**

---

## The MCP Stack

### Required from Day 0

**GitHub MCP** — navyhellcat/velorin-system read/write
```json
{
  "github": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-github"],
    "env": {"GITHUB_PERSONAL_ACCESS_TOKEN": "[classic ghp_* token — not fine-grained]"}
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

### Add After Qdrant Is Running

**Qdrant MCP** — Brain MCP-addressable from any platform
```json
{
  "qdrant": {
    "command": "npx",
    "args": ["-y", "mcp-server-qdrant"],
    "env": {"QDRANT_URL": "http://localhost:6333"}
  }
}
```

### ATV MCP (Stage 1 Build)

**Asymmetric Transport Verifier** — IES enforcement at transport layer
```json
{
  "atv": {
    "command": "node",
    "args": ["/Users/lbhunt/Desktop/velorin-system/infrastructure/atv/server.js"],
    "env": {"ATV_PORT": "8080"}
  }
}
```

### NEVER Add This

**claude-code MCP (self-referential):** Causes `mcp__claude-code__` prefix naming bug.
Any agent calling a tool gets a blocked error and dies silently. Real data loss confirmed.

### Fix Required Before First Use (FW-003 — HIGH PRIORITY)

**velorin-gdrive MCP:** OAuth tokens expire every 7 days (Google 7-day policy for Testing-mode apps).
Has required manual re-auth twice (Session 027 and Session 035).
**Fix:** Migrate to Google Service Account JSON credentials.
Process: Google Cloud Console → create service account → share Claude.AI folder → download JSON key → update auth.js.
Until fixed: Drive WRITES blocked. Drive reads work via Claude's built-in connector.
This fix must ship before the next 7-day window expires.

### Evaluate After Brain Is Operational

**PAL MCP (BeehiveInnovations/pal-mcp-server):** Multi-model bridge. One MCP server routing
to Claude, Gemini, GPT, Grok, Ollama, custom endpoints. Evaluate when real workloads exist.

---

## The Hook System

Hooks are deterministic. They always run. They cannot be bypassed by LLM non-compliance.
CLAUDE.md instructions are advisory. Hooks are not.

**Currently wired in settings.local.json:**

```json
{
  "hooks": {
    "SessionStart": [{
      "matcher": "startup",
      "hooks": [{
        "type": "command",
        "command": "cd /Users/lbhunt/Desktop/velorin-system && git pull origin main --quiet 2>&1 | tail -1",
        "timeout": 15
      }]
    }]
  }
}
```

**Hooks designed but not yet wired (OQ-8):**
- PreCompact: saves team state before context compaction
- PostCompact: restores team state after compaction
The pre-compact task gate script was designed and deleted by CT (too risky without testing).
Process: write and test standalone first; run manually several times; then wire.

**Post-commit hook (Stage 1 — build alongside ingestion pipeline):**
Script: `infrastructure/hooks/post-commit-edge-handler.sh`
Purpose: reads `supersedes` and `contradicts` edges in newly committed neurons;
updates belief_state on target neurons; updates skill dependency graph if skill files changed.
No LLM involvement — pure deterministic YAML parsing and file updates.
*→ Forward note: Future local MA will monitor this hook's execution for failures and
edge cases, not run it (it runs as a git hook).*

---

## The GPS Layer

**Principle:** Agent names are stable. File paths change. CLAUDE.md → stable roster → stable
folder conventions → readable files.

```
CLAUDE.md
  ↓
Velorin.Welcome/_index.md   (agent roster)
  ↓
agents/[platform]/[name]/ReadMe.First.md
  ↓
agents/[platform]/[name]/handoffs/[latest handoff]
  ↓
brain/_index.md             (only when task requires deep retrieval)
```

**Rules:**
- CLAUDE.md never contains agent names, tool names, or specific file paths
- Velorin.Welcome/_index.md never contains platform-specific instructions
- Renaming a file requires updating at most ONE pointer
- Adding an agent requires updating the roster in _index.md only

---

## Asymmetric Transport Verifier (ATV) — Stage 1 Build Component

**Purpose:** Structural enforcement of the Inverted Extraction Schema (IES) at the transport layer.
IES intercepts consensus drift in analytical reasoning by forcing explicit divergence evaluation
before conclusion formation. Based on Wald SPRT (1947) and Drift-Diffusion Model (Ratcliff 1978).

**Architecture:**

```
Producing agent generates analytical output
    │
    ▼
Agent wrapper inspects output:
  - tool_use blocks present → tag: (none, not analytical)
  - pure text > N tokens → tag: content_type: analytical_reasoning
  - pure text ≤ N tokens → tag: (none, too short)
    │
    ▼
Tagged messages route to ATV MCP endpoint
    │
    ▼
ATV verifier model (1-3B parameter, vllm-mlx backend)
maps raw text to IES structure via XGrammar FSM
    │
    ▼
Consumer agent receives IES-formatted payload
```

**The IES structure (FSM grammar enforces this):**

```xml
<context_boundary_check>
  1. Define limits of current context window on this topic.
  2. List adjacent research/files NOT queried that might alter analysis.
  3. State whether concluding now violates Window Gravity. If YES: stop and query.
</context_boundary_check>

<consensus_extraction>
  1. State the prevailing industry consensus on the topic.
  2. Identify whether consensus exists for technical necessity or historical accident.
</consensus_extraction>

<velorin_divergence_evaluation>
  1. Apply Consensus Filter: does this consensus serve Velorin's architecture?
  2. If adopted: specify exactly which Velorin principle it degrades or complicates.
</velorin_divergence_evaluation>

<final_conclusion>
[Conclusion permitted only after above sections complete]
</final_conclusion>
```

**IES threshold:** θ = 0.7 (anti-drift bias rationale: false-rejection is bounded by FSM-coerced
output structure; drift through enforcement is the unbounded failure mode).

**Tag-setting authority:** Runtime-set by the agent wrapper inspecting response content blocks
(tool_use vs prose generation). NOT producer-declared. The wrapper is part of the ATV build —
they ship together as one Stage 1 component. No Phase 1 / Phase 2 split.

**Default on missing tag at ATV endpoint:** Fail-secure (apply IES enforcement).
Tag-missing events log as anomalies for engineering review.

**Verifier model class:** 1-3B parameter (NOT Qwen 3.6 14B — too slow for ATV latency budget).
Candidates: Qwen2.5-0.5B, SmolLM2-1.7B. Selected empirically by benchmark program.
Backend: vllm-mlx (Apple Silicon, continuous batching, prefix caching for IES system prompt).
*→ Forward note: verifier model selection is a Stage 1 engineering output from the benchmark program.*

**Per-message log artifact (functional trigger requirement — must be in ATV spec):**
```
message_id, tag_present (bool), tag_value, IES_enforced (bool),
T_V_seconds (float), path_taken (passthrough|enforced|failed),
tag_hallucination_suspected (bool)
```
Routing: enforced messages → consumer agent; failures + anomalies → `infrastructure/queues/atv-review/`;
overflow (queue > N=5 pending) → `infrastructure/queues/atv-overflow/` with rejection record.

**Backpressure (hard build-time gate — NOT a future decision):**
Queue size N=5 configurable. Above N: write rejection record to atv-overflow/; do not queue.
Routing target for overflow review: architecture-review sessions until permanent Brain operator staffed.

**Scope:** Inter-agent analytical conclusions only. NOT:
- Skill execution output (structured)
- Brain ingestion pipeline output (already validated)
- Erdős solution delivery (format enforced by Gem instructions)
- Short structured messages (excluded by tag)

**ATV down — Adaptive Rate-Limit consumer policy (Decision 1, locked):**

$$\rho^* = \lambda \cdot \frac{\max(0, A_{min} - \tau)}{1 - \tau}$$

A_min calibrated iteratively through build + test. Above SLA: zero drift. Below SLA: minimum valve.

---

## Schema Registry (FSM Grammar Version Management)

**Purpose:** IES grammar is compiled infrastructure, not a text prompt. Agents reference it by
cryptographic hash, not by text content.

**Components (all Stage 1):**

```
Schema Registry:
├── IES grammar source (.lark or JSON Schema)
├── Post-commit hook: compiles to XGrammar artifact; generates SHA-256 hash
├── Local SQLite or key-value store: maps hash → binary artifact path
└── Grammar hash embedded in every ATV message envelope metadata
```

**Minimum viable workflow:**
1. Edit IES grammar file in git
2. Post-commit hook compiles via XGrammar, generates hash, stores artifact
3. Agent requests grammar by hash in API call (not by text)
4. ATV retrieves compiled artifact from registry via O(1) hash lookup
5. XGrammar applies constraints at logit level — no text prompt overhead

**Property-Based Testing (PBT — Hypothesis library):**
Generates synthetic valid IES messages from grammar → verifies json.loads() parses them.
Catches under-constrained and over-constrained grammars before any LLM sees them.
Runs on every grammar commit. No LLM involved in the test loop.

**Compiler-in-the-Loop AI review:**
AI proposes grammar change → XGrammar compilation runs immediately → exact compiler error
fed back to AI → AI revises until compilation succeeds. AI does not judge FSM syntax directly.
*→ Forward note: Stage 2 (trigger: 500 historical ATV messages) — Differential Equivalence
Checking (new grammar validated against historical message corpus). Shadow Mode seam built at Stage 1:
apply_grammar(message, grammar_hash, shadow_hash=None). shadow_hash=None always until Stage 2.*

*→ Build-space placeholder Stage 2: Differential Equivalence + Shadow Mode (500-message trigger).
Seam: apply_grammar(..., shadow_hash=None) interface already specified above.*

*→ Build-space placeholder Stage 3: Canary rollout (trigger: N≥5 concurrent agent processes,
M≥100 analytical messages/day, D≥14 consecutive days). No application code change — load balancer config only.*

---

## Skills Registry

**Location:** `skills/skill_dependencies.yaml`

**Schema (4-type edge, GoS-informed):**

```yaml
skills:
  skill-name:
    path: skills/skill-name/SKILL.md
    edges:
      dependency: [skill-b]    # hard prerequisite; b's output is a's input (I/O schema match)
      workflow: [skill-c]      # logical co-occurrence; no artifact passing
      semantic: [skill-d]      # conceptual overlap; bidirectional
      alternative: [skill-e]  # mutually exclusive execution paths
    artifact_schema_in:
      commit_hash: string
      branch: string
    artifact_schema_out:
      git_push_confirmed: boolean
      timestamp: string
    mode_config: {}            # extensibility dict — future modes add here without call-site changes
    dark: false                # if true: excluded from Φ_causal injection; CT-direct only
```

**Dependency induction:** Deterministic via I/O schema matching (not LLM guessing).
If artifact_schema_out of skill A intersects with artifact_schema_in of skill B → dependency edge auto-generated.

**Conflict resolution:** Alternative edge + context-budgeted hydration via PPR ranking.
No arbiter logic needed — PPR rank determines which alternative is selected.

**Cycles:** Permitted. α=0.15 teleportation guarantees PPR convergence. No cycle detection required.

**Dark skill access:** Separate `invoke-dark-skill skill-name` command bypasses the Φ_causal post-walk
filter. Executes skill directly. Every invocation logged to audit record.
*→ Forward note (Re-Eval #7): "CT" in the privileged-actor role is the only member under current
Direction C (personal) configuration. Direction B expansion adds role members without code change.*

**SKILL.md format:**

```markdown
---
name: skill-name
when: "Use when [specific condition — ACT-R production rule format]"
tags: [tag1, tag2]
---

[Full skill content — loads only when condition fires]
```

Header: <100 tokens (progressive disclosure).
Content: loads only when "Use when" condition matches.

**Validation on commit:** New skill files run through the schema validator that checks:
- artifact_schema_in and artifact_schema_out are typed objects (not string tokens)
- edges section contains at least one entry
- skill_dependencies.yaml is updated in the same commit as the new skill file

*→ Build-space placeholder Stage 3: GoS sparse validation mode (trigger: N skills [threshold set at Stage 3 design]).
Seam: validate_skill_edges(candidate_edges, skill_graph, validation_mode="dense", mode_config={}).
Dense → sparse is a one-param config change. State handover: no persistent state; output schema identical.*

---

## Media Extraction Tools

**OpenDataLoader PDF v2.0** (replaces Docling — Session 032/035 decision)
- Apache 2.0 license, pip install opendataloader-pdf
- XY-Cut++ reading order algorithm
- Formula Extraction AI for equations → plain-text LaTeX output
- JSON output with [x1, y1, x2, y2] bounding box per element (enables source_coords neuron field)
- 0.907 accuracy across 200 real-world scientific papers
- Does NOT time out on files >1MB (Docling did — 1GB footprint, 88 dependencies, fatal for ingestion)
- Fork and deploy locally; pipe JSON bbox outputs directly into neuron YAML source_coords

**Surya** — equation OCR fallback
- pip install surya-ocr
- REQUIRED env vars: PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0, PYTORCH_DEVICE=mps
- Without these: PyTorch on M4 Max will bottleneck (memory leaks on MPS backend)
- Use when OpenDataLoader Formula Extraction fails or returns zero math markers

**Qwen2.5-VL 7B** (via Ollama) — image/diagram/table extraction
- ollama pull qwen2.5-vl:7b
- Zero cloud dependency; local execution
- For complex tables, diagrams, flowcharts that OpenDataLoader can't parse as text
- Runs alongside Qwen 3.6 on Mac Studio 36GB (7B fits in remaining headroom)

**Voibe** — live dictation ($99 lifetime)
- <300ms real-time, 100% offline, Apple Silicon optimized
- VS Code and Cursor integration
- Preferred over Superwhisper (Superwhisper stores audio recordings + plaintext API keys by default)

**MacWhisper Pro** — batch audio transcription (~€59 lifetime)
- Speaker diarization, batch file processing
- Use for pre-recorded meetings, not live dictation

**iWeaver AI** — video/slide reconstruction (API, ~$15/month)
- Multimodal: audio + slide OCR + timestamp correlation
- Required for video assets — local multimodal processing of 2-hour 4K video exceeds 36GB budget

---

## Prompting Principles

### Window Gravity (CARDINAL)

Your context window is not the world. You know only what is loaded into it.
The failure mode: treating your context as complete. Confidence inflates when
context feels coherent — coherence is a property of what was loaded, not of what is true.

Three disciplines:
1. **Frame your conclusion's dependence.** Is it bounded by what is in your window?
2. **Match verification cost to stakes.** Low-stakes: proceed. Architectural decision: refresh state first.
3. **Treat initial framing as a hypothesis.** Verify before optimizing inside it.

The continuous question: "Am I confident because I verified, or because the window felt full?"

### Consensus Filter (CARDINAL — applied to every Trey deliverable)

Before any synthesis from external research:
1. What is the consensus?
2. Why does it exist — what constraint drives it?
3. Does Velorin share that constraint?

If Q3 = yes → adopt candidate.
If Q3 = no → this is a boundary; Velorin's edge lives on the other side.

Skipping Q3 is consensus drift. An analysis that cites Trey without answering Q3 is incomplete.

### Rule Activation Gap (IES exists because of this)

CARDINAL rules placed in preamble fail during mid-reasoning: as the reasoning sequence R
grows, attention to preamble instruction I decays. Rules evaluated post-hoc are rationalizations.
The IES (Inverted Extraction Schema) is the structural fix: forcing explicit divergence tokens E
immediately before conclusion C physically shifts the probability distribution away from consensus.

### Query Modes

**Tight Mode (default):** Assumes caller's frame is correct. Fills specific gaps. Does not expand scope.
**Discovery Mode (deliberate invocation):** Assumes caller's frame is INCOMPLETE. Surfaces what the prompt cannot name.

Declare explicitly:
```
MODE: TIGHT — confirm X and fill gaps Y and Z
MODE: DISCOVERY — assume this frame is incomplete, find what I'm not naming
```

---

## Shipping and Receiving Mailboxes

`infrastructure/mailboxes/Shipping/` — outbound files
`infrastructure/mailboxes/Receiving/` — inbound files from external sources

Every file in Receiving must have a destination header:
```
---
destination: [target folder path]/
---
```

MA reads the header, moves the file, strips the header, commits. Never reads file contents during routing.

---

[VELORIN.EOF]
