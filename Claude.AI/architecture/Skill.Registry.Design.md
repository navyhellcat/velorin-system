---
document: Skill Registry System Design
version: 1.0
date: 2026-04-05
session: 021
status: DESIGN — not yet built
author: CT + Jiang Session 021
---

# Velorin Skill Registry System Design

## The Core Principle

Skills are pointers, not content. We do not port 13,000 skills into Velorin.
We maintain a registry of trusted pointers to external skills. When an agent
needs a skill, the pointer wrapper fetches it. When the upstream changes, we
update the pointer. We never hold stale content — we hold stale pointers,
and stale pointers are caught by the health system.

---

## Why Not Port Skills Directly

- Porting 13,000 skills = 13,000 files to maintain
- Upstream skills update. Our copies become stale silently.
- We have no interest in maintaining other people's content.
- A pointer wrapper fetches fresh content on every invocation.
- We only maintain the registry. The community maintains the source.

---

## The Pointer Wrapper

A thin local SKILL.md that fetches external content at invocation time:

```yaml
---
name: code-review
registry-id: A0047
source: https://raw.githubusercontent.com/alirezarezvani/claude-skills/main/engineering/code-review.md
source-stars: 847
last-verified: 2026-04-05
version-pinned: commit/a3f9c2d
status: active
---

!`curl -s {{source}}`
```

The wrapper is the only local file. The content lives upstream.
The `version-pinned` field means we fetch a specific commit, not HEAD.
This gives us stability on demand — we choose when to update.

---

## The Source of Truth: awesome-claude-code

**Why awesome-claude-code over a static catalog:**

Anthropic's official skills repo is a catalog. Anthropic decides what's in it.
It reflects what one company thought developers would need.

`hesreallyhim/awesome-claude-code` is a community-run living signal.
The community decides what's worth pointing at. New repos get added as people
build them. Categories shift as usage patterns shift. It reflects real demand —
what people are actually building, not what was anticipated.

**The strategic advantage:**
When awesome-claude-code adds a new repo, our weekly discovery agent finds it.
When a repo falls out of favor (low commits, abandoned), our health system catches it.
The community does the curation work. We do the quality filtering.

---

## Quality Gates (Ingestion)

A skill is eligible for the registry if ALL of the following are true:

| Gate | Threshold | Rationale |
|------|-----------|-----------|
| Repo stars | ≥ X (TBD) | Community validation |
| Skill likes/stars | ≥ X (TBD) | Individual skill validation |
| Repo last commit | ≤ 6 months ago | Active maintenance |
| Skill file parseable | Must pass format check | Basic integrity |

**"Seen but rejected" log:**
Skills that fail gates are logged with reason. The weekly agent skips them
on future runs — no re-evaluation until a gate value changes.
This prevents the agent from re-processing the same rejected skills every week.

---

## The Weekly Discovery Agent

**Schedule:** Every week (Sunday morning, low-traffic)

**Process:**
1. Read awesome-claude-code from GitHub
2. For each linked repo: check stars against gate
3. For each passing repo: enumerate skills, check individual likes against gate
4. Check last commit date
5. For new skills passing all gates: create pointer wrapper, propose addition to registry
6. Log all findings — passed, rejected, already-in-registry
7. Alert CT or elevated agent to review proposals (does not auto-add)

**What it does NOT do:**
- Auto-add skills without review
- Read full skill content (index/README only for discovery)
- Touch the neuron system

---

## The Two-Lane Replacement System

### Passive Lane (Maintenance)

Every agent rechecks its skill pointers against the registry every 8 hours.

- Config value lives in agent's Layer 1 file (not global)
- Mission-critical agents: 2 hours
- Background agents: 24 hours
- On mismatch: pull update from registry

Worst case: 8-hour window with a stale skill.
Acceptable tradeoff for zero coordination complexity.

### Active Lane (Emergency)

Agent hits a broken skill mid-operation. Fires flag to Skills Manager.

**Exact sequence (order matters):**
```
1. Agent flags broken skill to Skills Manager
2. Skills Manager finds replacement in registry
3. Skills Manager passes replacement directly to agent ← agent unblocked here
4. Agent continues operation without restart
5. Skills Manager updates registry + neuron pointer ← housekeeping, secondary
```

Step 3 and Step 4 are sequential, not simultaneous.
The agent is unblocked BEFORE the registry write.
The agent's operation is never held hostage to a registry update.

**Why this sequence:**
"Pass before replace" means the active agent is prioritized over registry consistency.
Registry consistency follows as housekeeping. These are different concerns on different timelines.

---

## Skills Manager — Tier Placement

The Skills Manager is a **Tier 2 agent** (elevated AI, program manager role):
- Can read and write the skill registry
- Can test skills in a sandboxed environment
- Has NO operational role — never runs the skills it manages
- Never operates alongside the agents that use its managed skills

**The health check constraint:**
Testing a skill means running it. Running it means using it.
Resolution: health checks are structural + sandboxed, not operational.
- Structural: does the file exist? Does it parse? Does the pointer resolve?
- Sandboxed: test invocation in isolated environment, not in a live agent context

---

## Skills and Neurons — The Boundary

**Skills do NOT live in neurons.**

Neurons are persistent knowledge. Skills are executable interfaces.
Mixing them causes:
- Knowledge queries that accidentally load executable skill definitions into context
- Skill loading that drags in irrelevant knowledge
- Context pollution in both directions

**The correct relationship:**
A neuron in a relevant area CAN have a pointer to a skill.
The pointer is rated 1-10 like any other neuron pointer.
Only [1]-[2] rated skill pointers load during a normal activation.
The skill itself lives in the registry. The neuron holds the pointer only.

---

## Bottom-Up Taxonomy (Pending)

The Brain's Region/Area taxonomy for skills should be derived empirically,
not designed top-down.

**The Gemini Deep Research task (not yet run):**
- Input: Anthropic official skills + awesome-claude-code linked repos (index/README only)
- Process: cluster 500-2000 skill names by function
- Output: 40-80 Areas grouped into 8-15 Regions
- Use: this taxonomy becomes the skill registry's organizational structure
- Benefit: the weekly discovery agent slots new skills into the right area automatically

**Status:** Prompt designed in Session 021. CT to run in Gemini Deep Research.

---

## Open Questions (Not Resolved in Session 021)

1. **Star thresholds:** Exact numbers for repo stars and skill likes gates not set.
   Needs calibration against available data.

2. **Skill taxonomy:** Pending Gemini Deep Research run.

3. **Proposal review flow:** When weekly agent proposes new skills, exactly what
   does the review look like? Who sees it? What's the approval mechanism?

4. **Version pinning policy:** When do we update a pinned version?
   What triggers a version bump vs a full replacement?

[VELORIN.EOF]
