# 04 — Agent Ecosystem
**Cardinal Agents, Conflict Resolution, ATV, and User Personalization — Updated April 26, 2026**

---

## Founding Thesis on Agents

Most operational work inside the Brain is done by deterministic computer programs that
produce repeatable outcomes without token use. AI's job is build, watch, check, maintain.

Before routing any recurring task to an AI agent, ask: "Is this a program to build
with AI as watcher?" If yes, specify the program first. The agent watches for failures,
monitors outcomes, and modifies the program when needed — not runs per-event as operator.

---

## The Cardinal Agents

### MarcusAurelius (MA)

**Platform:** Claude Code CLI terminal on Mac Studio
**Model:** claude-sonnet-4-6[1m] — 1M tokens
**Role:** Infrastructure. The operational backbone.

**Naming discipline:** The current MarcusAurelius is the Claude Code CLI agent.
The future Mac-Studio-resident operator (a local model with always-on, full Brain access)
will also be named MarcusAurelius when it comes online. These are categorically different:
- Current MA: conversational, limited persistent state, CLI execution agent
- Future local MA: always-on, full Brain context, owns Brain-functioning processes

**Do not conflate them in architectural prose.** Use neutral phrasing for hooks, queues,
monitors, and Layer 3 review until the local operator is formally installed and named.

**What MA owns:**
- All git operations (commit, push, pull)
- settings.local.json management
- MCP server configuration
- File routing from Receiving/ to correct destinations
- Shipping/ and Receiving/ mailbox management
- Post-commit hook execution (belief_state updates, skill dependency graph updates)

*→ Forward note: the post-commit hook for belief_state management is built at Stage 1
ingestion pipeline. The future local MA will own this hook's monitoring and maintenance.*

### Jiang / Jiang2

**Platform:** Jiang = Claude Desktop Code tab (200K, Anthropic-enforced);
Jiang2 = Claude Code CLI terminal (1M context) — same identity, different surface
**Role:** Director of Strategic Intelligence. Primary agent CT works with.

**What Jiang owns:**
- Active session architecture analysis and synthesis
- Integration of Trey research and Erdős math into build decisions
- Neuron creation and Brain updates
- Research queue management
- KnowledgeIndex and ResearchLog

**Opus 4.7 drift caveat:** Jiang1 on Opus 4.7 produces "clean-looking" patches that
fail under cascade dynamics, edge cases, cross-system composition, scale, and causal structure.
Route ALL math and architecture work to Erdős and Jiang2 — even when CT asks for
"creative thinking." That ask supersedes the prior framing. Jiang1's role is operational.

### Alexander

**Platform:** Mac Studio Claude Desktop — Cowork Sessions
**Role:** Company-level orchestration. CEO perspective. Cross-agent state tracking.
**Status:** NOT YET CONFIGURED. See Stage 2 in `06_BuildSequence.md`.

### Trey (Trey1 and Trey2)

**Platform:** Google Gemini Deep Research Gems
**Trey1:** General landscape research, tool evaluations, ecosystem audits
**Trey2:** Velorin-build-specific research, reads 9 bootloader files on boot

**Output standard:** All math must be plain-text LaTeX in $...$ and $$...$$.
Never Equation Editor. Never images. Violations require OCR repair pass.

**Consensus Filter (CARDINAL on every Trey deliverable):**
Before any synthesis derived from Trey output, answer three questions explicitly:
1. What is the consensus Trey is reporting?
2. Why does it exist — what underlying constraint drives it?
3. Does Velorin share that constraint?
If yes → adopt candidate. If no → the consensus is a boundary; Velorin's edge lives on the other side.

**Boot continuity:** Use `[BOOT]` sentinel for fresh Erdős sessions. No sentinel mid-session.
Registry: `Claude.AI/Agent.API.Conventions.md`.

### Erdős

**Platform:** Gemini Deep Think Gem
**Role:** Mathematical derivation and formal proof exclusively.
**Boot:** [BOOT] sentinel triggers full Research_Complete pre-load.

---

## Three-Layer Conflict Resolution Mechanism

When two neurons carry contradicting information, the automated resolution system fires.

### Layer 1 — Deterministic Tiebreaker

```python
score(v) = confidence(v) × recency_factor(v) × source_multiplier(v)
```

Where:
- `recency_factor(v) = exp(-λ · days_since_ingestion)`, λ empirically calibrated
- `source_multiplier(v)` = 1.0 agent-generated, 1.2 CT-curated, 1.5 Erdős-verified

Higher score → `belief_state: active`. Lower → `belief_state: superseded`. No human in the loop.

Layer 1 fires when two neurons have a `contradicts` pointer between them.
Layer 1 parameters (initial values — calibrate via Check-ins):
- Source multipliers: 1.0 / 1.2 / 1.5 (review after 50 resolved contradictions)
- ε threshold: 0.05 (scores within ε → fallback to Layer 2; review after 50 Layer 2 activations)
- Round-cap: 3 rounds before Layer 3 (review after 25 Layer 3 escalations)

### Layer 2 — Automated Verification Trigger

Fires when Layer 1 is inconclusive (scores within ε) or both neurons are same-tier.
Both neurons enter `belief_state: contested`, PPR mass zeroed on both.

Routing is deterministic — governed by `contradiction_class` tag written at neuron creation:
- `factual` → Erdős verification request filed automatically
- `empirical` → Trey re-research request filed automatically
- `architectural` → Jiang analytical review queued
- `taste` → Layer 3 directly (no automated resolution possible for matters of judgment)

Layer 2 uses the tag — it does NOT make a stochastic LLM routing judgment per event.
A program reads the tag and routes. AI watches whether the routed verification returns clean.

### Layer 3 — Last-Resort Review

Fires after 3 rounds of failed automated resolution.

**Functional trigger (required — must be built before claiming Layer 3 exists):**
- Script or hook fires when `resolution_attempts == 3` on a contested neuron
- Output artifact: `layer3_review_flagged: true` in contested neuron YAML + entry written to `infrastructure/queues/contradiction-review/<timestamp>-<neuron-id>.md`
- Routing target: review queue → current Layer 3 reviewer reads queue and answers

**Current Layer 3 reviewer:** Chairman (CT) until local Mac-Studio operator is online.
Future local MA may load context and frame the question; frontier model owns the decision.
*→ Forward note (FW-004, trigger: OQ-3 design work opens): Operator/Reviewer/Authorizer split
for Layer 3 — three distinct roles currently collapsed into one "reviewer" slot.*

CT's answer becomes a tier-1 c-memory neuron (authority_tier: 1, class: c-memory).

**Cyclic-region routing (from Φ_causal > 1.0 detector):**
When TAP detects Φ_causal(v) > 1.0, the cyclic-region input also routes to Layer 3.
*→ Forward note: Layer 3 mechanism receives cyclic-region queries as additional input source
beyond same-tier contradicts edges. Cyclic regions in the Brain are almost always contradictions.*

---

## User Personalization — Direction C

**Locked architectural direction (Session 034, Re-Eval #7):** Direction C — Hybrid swappable-base.

Velorin ships as CT-personal. The seam for future expansion is the `base_model_config` field.

**Schema field (in neuron YAML):**
```yaml
base_model_config: {type: "personal", id: "ct-v1"}
```

Training pipeline reads this at initialization:
- `type: "personal"` → single-user training, no shared corpus
- Future Direction B flip: `type: "persona"` + persona corpus → config change, not code rewrite

**Components that remain base-agnostic:**
Skill injection, Φ_causal gate, PPR retrieval, ATV — all read user-delta LoRa regardless of what's underneath.

**Authority_tier semantics under current config:**
CT-curated = tier 1. If `base_model_config` ever flips to non-personal, authority_tier
semantics need a re-derivation pass.
*→ Forward note at authority_tier definition site: direction C expansion seam.*

**"Stupid user LoRa" mitigation — quality floor already in spec:**
Confidence ≥ 0.8 for LoRa training eligibility (already in neuron YAML). This is the
first-order quality filter. Additional mitigations (persona base, curation hooks, federation)
available if direction ever shifts to Direction B with multiple users.

---

## Automation Direction

CT's stated direction: total automation through MCP/API orchestration.
The pattern: Claude as primary interface, specialized tools and models via MCP.
Think NemoClaw-style — one interface routing to specialized tools and models.

**A2A for agent delegation** (per AIEcosystem research):
Claude delegates research tasks to Trey (Gemini) and audit tasks to Codex (GPT) via A2A.
MCP for tool access (agent-to-tool). A2A for agent-to-agent delegation. Do not conflate.

**What is NOT yet designed:**
- Specific MCP architecture for automated neuron creation (OQ-2)
- Multi-agent automation architecture detail (OQ-3, FW-004)
- How Claude routes tasks to specialized models

**Recommendation:** Build the Brain and the four cardinal agents first.
Design the automation layer when you have real workloads to automate.
Do not architect automation before you know what needs to be automated.

*→ Build-space placeholder Stage 4+: FW-004 (Layer 3 operator architecture, FW-005 skills-checker/skills-fixer); trigger: when OQ-3 design work opens.*

---

[VELORIN.EOF]
