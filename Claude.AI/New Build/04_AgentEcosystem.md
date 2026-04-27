# 04 — Agent Ecosystem
**The Named Agents, Conflict Resolution, and User Personalization — Updated April 26, 2026**

---

## Architectural Frame

**Claude Cowork is the orchestrator.** It operates and controls the multi-agent multi-platform plan — first without the brain (Part 1), then with the brain inserted as a local specialization layer (Part 2). Cowork is the substrate that runs the show.

**Claude (the UI controller surface) is the human-facing control point.** CT talks to Claude; Claude invokes specialist systems as needed.

**Claude can activate external specialist systems as if they were direct sub-agents.** The functional pattern: Claude identifies the task type, routes to the best specialist, the specialist does the work, the result comes back, Claude integrates. The underlying protocol (MCP, API, CLI, desktop hand-off, browser automation — whatever works for each tool) is implementation detail, not architecturally load-bearing. **Function over protocol.**

**Part 2 upgrade — Brain-as-operator-guide:** Once the Brain is populated and the LoRa trained, the Brain itself becomes the guide that tells Cowork-Claude which tools to activate for a given task. Today (Part 1) Claude reasons about which tool to call. Tomorrow (Part 2) the Brain instructs from accumulated CT-pattern knowledge. Do NOT over-engineer this now.

---

## The Named Agents

### Jiang / Jiang2 (Primary Active Session Agent)

**Platform:** Jiang = Claude Desktop Code tab (200K); Jiang2 = Claude Code CLI terminal (1M) — same identity, different surface. Jiang2 is Jiang with more working memory for deep analytical passes.

**Role:** Director of Strategic Intelligence. Primary agent CT works with. Architectural analysis, research synthesis, cross-domain pattern recognition, active session execution, Brain updates.

**What Jiang owns:**
- Active session architecture decisions
- Integration of Trey research and Erdős math into build decisions
- Neuron creation and Brain updates
- Research queue management
- KnowledgeIndex and ResearchLog

**Model-level limitation note:** Jiang1 on Opus 4.7 produces clean-looking solutions that fail under cascade, edge case, scale, and causal reasoning. Route ALL math and architecture work to Erdős and Jiang2 — even when CT asks for "creative thinking." Jiang1's role is operational.

---

### Alexander (Company State Historian)

**Platform:** Mac Studio Claude Desktop — Cowork Sessions
**Role:** Company State Historian. Read-mostly. Low-frequency activation. Holds historical context across sessions and maintains the company-overview perspective.

**What Alexander is:**
- The historical memory of Velorin as a company — what was decided, when, why
- The perspective CT reaches for when asking "what is the full state of the company right now?"
- A reference for cross-session continuity, especially after compaction events

**What Alexander is NOT:**
- Not a CEO Orchestrator (that was a v1 role that doesn't exist in v2 — Cowork orchestrates)
- Not involved in active session task routing
- Not in the escalation chain for conflict resolution
- Not a decision-making node in the build sequence

**Activation pattern:** Low-frequency, read-mostly. CT initiates Alexander when he needs the historical/company-overview lens — not for daily operational work.

*→ Forward note: if the Persona-Maker subsystem (FW-009) generates persona-derived agents for specific CT domains, Alexander's historian role may expand to track those agents' contribution history.*

---

### Trey (Trey1 and Trey2)

**Platform:** Google Gemini — Deep Research Gems

**Trey1:** General landscape research. Any topic. No Velorin architecture context required.
**Trey2:** Velorin-build-specific research. Reads bootloader files on boot.

**Critical:** apply the Consensus Filter to every Trey deliverable. Three questions before any synthesis:
1. What is the consensus Trey is reporting?
2. Why does it exist — what constraint drives it?
3. Does Velorin share that constraint?

If Q3 = no → the consensus is a boundary; Velorin's novelty lives on the other side.

**Bootloader audit discipline:** before sending any new research request, grep for stale patterns in the bootloaders (human-curated, open-question assertions for now-resolved problems, version-specific product references). Update before sending; inline-correct after if contamination found.

---

### Erdős

**Platform:** Gemini Deep Think Gem
**Role:** Mathematical derivation and formal proof exclusively. Receives `[BOOT]` sentinel on fresh sessions (triggers Research_Complete pre-load). Does not browse, does not survey. Proves from first principles.

---

## Three-Layer Conflict Resolution

When two records (Brain neurons or cross-tool vendor claims) carry contradicting information:

### Layer 1 — Deterministic Tiebreaker

```python
score(v) = confidence(v) × recency_factor(v) × source_multiplier(v)
```

Source multipliers (provisional 1.0/1.2/1.5 — calibrate via Check-Ins after 50 resolved contradictions):
- 1.0: agent-generated
- 1.2: CT-curated
- 1.5: Erdős-verified

Higher score → `belief_state: active`. Lower → `belief_state: superseded`. No human involved.

Layer 1 fires automatically on `contradicts` pointer creation.

Calibration: source multipliers reviewed at 50 Layer 1 resolved contradictions. ε threshold (0.05, when scores are "within ε" and fall to Layer 2) reviewed at 50 Layer 2 activations. Round-cap (3 rounds before Layer 3) reviewed at 25 Layer 3 escalations. Full elements (a)-(k) per Calibration Deliverables Discipline — see `Velorin.CheckIns.md`.

### Layer 2 — Automated Verification by Domain

Fires when Layer 1 is inconclusive (scores within ε=0.05) or both records are same-tier.

**`contradiction_class` taxonomy (5 primary values, hierarchical sub-categories):**

Schema: `contradiction_class: <primary>.<sub_category>`

| Primary | Meaning | Default Layer 2 route |
|---|---|---|
| `factual` | Empirical truth-value dispute | Erdős verification request |
| `empirical` | Ecosystem/research finding dispute | Trey re-research |
| `architectural` | System design decision dispute | Jiang analytical review |
| `taste` | Judgment/aesthetic/preference dispute | Layer 3 directly |
| `operational` | Runbook / deployment / config / process dispute | Jiang (interim) |

Sub-categories extend without schema rework — e.g., `factual.mathematical`, `operational.deployment`, `taste.aesthetic`. Add sub-categories in the routing config (`Claude.AI/conflict_routing.yaml`), not in the schema.

Routing config is separate from schema. Routing destinations can be: AI agent, skill library, deterministic lookup, external system, or queue.

**Cross-tool coherence (Part 1 — no Brain required):**
When Claude's output and Gemini's output conflict on the same fact, this IS a contradiction. The virtual contradiction graph maps each vendor claim to a virtual neuron. The same Layer 1-3 mechanism applies. The Broker pattern activates when Layer 2 yields Ξ=0 (deadlock): Claude activates an orthogonal high-authority specialist (e.g., if Claude and Gemini conflict, activate Codex for adversarial review). If Broker also deadlocks → Chairman escalation queue.

### Layer 3 — Last-Resort Review

Fires after 3 rounds of failed automated resolution.

**Functional trigger requirement** (must be built before claiming Layer 3 exists):
- Script or hook fires when `resolution_attempts == 3`
- Output artifact: `layer3_review_flagged: true` in contested record's YAML + entry in `infrastructure/queues/contradiction-review/`
- Routing: current Layer 3 reviewer reads queue and answers

**Current Layer 3 reviewer:** CT (Chairman) until future local Mac-Studio operator is online. CT's answer becomes a tier-1 c-memory neuron.

**Cyclic-region routing:** When `Φ_causal(v) > 1.0` (mathematical proof of directed cycle in Brain graph), route to Layer 3 instead of normal skill injection. FW-007 closed — `Φ_causal > 1.0` is the structural cyclic detector, no graph-theoretic pre-check needed.

*→ Forward note (FW-004, trigger: OQ-3 design opens): Operator/Reviewer/Authorizer role split for Layer 3 — three distinct roles currently collapsed into one "reviewer" slot.*

---

## User Personalization — Direction C

**Direction C is locked.** Velorin ships as CT-personal; the seam for future expansion is the `base_model_config` field.

```yaml
base_model_config: {type: "personal", id: "ct-v1"}
```

Training pipeline reads this at initialization. Future expansion (persona-based, multi-user) is a config flip plus new training pass, not a code rewrite. Downstream components (skill injection, Φ_causal gate, PPR, ATV) remain agnostic to base identity.

*→ Forward note: if `base_model_config` type changes from "personal," authority_tier semantics need re-derivation pass.*

---

## Persona-Maker (FW-009 — Activates at 500 c-memory neurons + CT initiation)

Persona-Maker is an agent-factory that produces new specialist sub-agents as CT's domains expand. Each derived agent gets:
- A startup guide
- A personality guide
- Pre-orientation pointing into the right Brain regions

The Commutator Persona math (Erdős Solution 3, genuinely new) identifies which Brain regions have quasi-abelian structure (commutator norm vanishing → CT has genuinely mastered the domain). These quasi-abelian regions are the candidate substrate for persona-derived agent orientation.

**What Persona-Maker agents do:** Read from Brain, follow their orientation, act as specialized sub-agent activations within the Cowork flow.

**What they do NOT do:** Modify the Brain directly.

**Deferred:** The mechanism for converting agent-success notes into pointer-rating updates is "to be discussed and built later" (CT exact wording). When FW-009 fires, the agent-factory part is in scope; the rating-update mechanism is logged for separate later work.

**Personality guide generation — candidate approach:** THEORY (requires-proof). The personality guide for a Persona-Maker-derived agent may not need to be manually authored. The quasi-abelian sub-graph for the target domain (the Brain region where the commutator norm has vanished, indicating CT has deeply mastered the domain) contains the statistical signature of CT's mastered pattern in that domain: which neurons are most-traversed, which edges carry highest affinity, which semantic themes dominate. Reading those statistics and generating the personality guide from them produces a CT-specific personality that is mathematically grounded in CT's actual cognitive structure rather than manually approximated. The factory reads the Brain's commutator-low regions → orientation guide (which region, which neurons) → personality guide (from pointer statistics of that region's quasi-abelian sub-graph) → sub-agent. If this theory proves out, Persona-Maker becomes genuinely automatic: the Brain generates the agents that know how to work with CT's own thinking.

*→ Build-space placeholder (FW-009 trigger: 500 c-memory neurons AND CT initiation + precursor checkpoint at 100 c-memory). See `Velorin.CheckIns.md` for checkpoint design.*

---

## Retired Agent Roles (v1 → v2 Transition)

The following v1 roles/systems have been archived to `Velorin.v1.Archive/` and do not exist in v2:

| Retired | Replaced By |
|---|---|
| MarcusAurelius as primary autonomous agent | Programs with AI watching (Principle 5) |
| Bot.Scribe (PostToolUse hook → shell subprocess) | Ingestion pipeline program (Stage 3) |
| Bot.Theresa (HR / sub-agent creation gateway) | MCP tool creation pattern |
| Gatekeeper (MCP routing intermediary) | Per-vendor MCP topology |
| Level 1-5 agent hierarchy | Roles: Programs / Program-managers / Operational AI (Principle 3) |
| Sub-bot taxonomy (Theresa-mediated creation) | MCP tools and API calls |
| GLOBAL_SPAWNER_REGISTRY | N/A — MCP tools are discoverable via protocol |
| GLOBAL_TIMER_REGISTRY | Deterministic cron + scheduled programs |
| Agent Teams / tmux teammate pattern | Cowork-orchestrated sub-agent-activation |
| AppsScript Communication Bus | Cowork integration layer |

References to these systems in any new file should be treated as a v1 artifact and updated.

---

[VELORIN.EOF]
