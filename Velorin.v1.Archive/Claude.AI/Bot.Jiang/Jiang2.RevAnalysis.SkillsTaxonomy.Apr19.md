---
file: Jiang2.RevAnalysis.SkillsTaxonomy.Apr19.md
from: Jiang2
date: 2026-04-19
source: Trey.Research.SkillsTaxonomyEmergence.md + Trey.Research.SemanticMemoryOrganization.Neuroscience.md
status: REVISED ANALYSIS — prior analysis REJECTED by Chairman. This is the replacement.
prior: Jiang2.EcosystemAnalysis.SkillsTaxonomy.md (treat as INCOMPLETE — do not use)
---

# Skills Taxonomy — Revised Analysis
**Jiang2 | April 19, 2026 | For Chairman Review Before Any Build Guide Changes**

---

## 1. What the Prior Analysis Got Wrong

The prior analysis (`Jiang2.EcosystemAnalysis.SkillsTaxonomy.md`) concluded that:
- Brain regions stay as-is
- Skills Registry is fully separate from the Brain
- Trey's taxonomy recommendation is a category error

The first and third points are still correct. The second point was stated but never completed. The error was not the conclusion — it was stopping before the critical question was answered.

Chairman's concern: **"You did not think all the way through how to incorporate what he said — even if it's something separate from the brain but integrated in some way."**

The analysis documented the separation. It never designed the integration interface.

---

## 2. What the Two Trey Documents Are Actually Saying

These are not two opinions on the same question. They are two research disciplines arriving at the same architectural truth.

**SemanticMemoryOrganization (neuroscience):**
- The brain does not use discrete folders. Semantic memory is continuous gradients.
- The ATL (Anterior Temporal Lobe) is an amodal hub — it integrates modality-specific spokes into coherent abstract concepts.
- In Velorin terms: Layer 3 markdown files = modality-specific spokes. Layer 1 E₈ + Layer 0 LoRa = the amodal ATL hub.
- The biological Dual Routing (ATL/taxonomic vs. Angular Gyrus/thematic) directly validates the Multiplex Tensor already locked in the Build Guide.
- Expert domains develop dense local clusters — validated by Clique Centrality Theorem.
- Recommendation on folder taxonomy: deprecate Region/Area folders, go flat, let E₈ organize semantically. (This part is correct about the brain. It misapplies to Velorin — see Section 4.)

**SkillsTaxonomy (AI community practice):**
- Independent communities converge on Hub-and-Spoke not by design, but by necessity.
- Hub skills = cross-domain meta-cognitive routing (context engineering, task decomposition, planning) — invoked first, before any domain-specific execution.
- Spoke skills = execution primitives activated by conditions.
- This maps precisely to the biological ATL hub + modality-specific spokes.
- ACT-R production rules = "Use when [condition]" syntax — the correct format for all Velorin skills.
- Progressive disclosure (<100 token headers) — the correct size constraint for skill metadata.

**The synthesis:** Both documents describe the same architecture from different angles. The hub (ATL, Layer 1 E₈) integrates distributed knowledge and routes to execution. The spokes (Layer 3 markdowns, domain-specific skills) are the raw inputs and outputs. The four-layer Velorin architecture IS Hub-and-Spoke — the math already implements it.

---

## 3. The Question That Was Not Answered: The Interface

When a PPR walk retrieves a neuron that represents a procedure ("how to build the ingestion pipeline"), what happens next?

Currently: nothing. The agent reads it as context and generates a response. There is no designed mechanism for the Brain to activate a Skill.

In the biological brain: the ATL hub doesn't execute procedures directly. It activates the procedural memory system (basal ganglia, cerebellum) through a coordinated handoff. The ATL synthesizes the "what" and "why." The procedural system executes the "how."

In Velorin, this handoff is the missing interface.

**The gap:** The retrieval system (Layer 1 PPR) surfaces declarative knowledge. The Skills Registry holds procedural execution logic. Between these two there is no defined routing mechanism.

---

## 4. The Interface Design

### The Folder Taxonomy Question (Still Resolved the Same Way)

SemanticMemory recommends going flat — deprecating Region/Area folders. This is neuroscientifically correct for the brain. It misapplies to Velorin because Velorin's folders are NOT the semantic architecture — they are navigation scaffolding for agents to locate files.

The semantic organization of Velorin's Brain happens in the E₈ crystal layer via Pointer Gravity and PPR traversal. Neurons that are semantically similar are pulled together geometrically — not because of their folder location, but because of their pointer topology. The folder structure is an index for file lookup. The graph topology is the brain.

This was correct in the prior analysis. The brain.region.operations folder does not "mean" operations — it's just where operations neurons live so agents can find them. Semantic meaning emerges from the E₈ embedding.

**Brain region structure: unchanged.**

### The Hub-and-Spoke Question (What the Prior Analysis Missed)

The prior analysis said: "Trey's routing (a query from Financial routes to ATL Hub) is exactly what the Multiplex Tensor does." This is correct. The prior analysis stopped here.

What it didn't address: even though the Multiplex Tensor handles routing, there is no mechanism for the routing to terminate at a skill. The PPR walk surfaces neurons. It does not activate skills. Something is missing.

**The missing piece is the procedure neuron as a bridge.**

### Procedure Neurons as Skill Gateways

The neuron YAML format already includes `type: procedure`. A procedure neuron encodes "how to do X" — not facts, but a recipe for execution.

Currently, a procedure neuron is just another neuron. It sits in the Brain and gets retrieved like everything else.

**The revision:** Procedure neurons should carry an optional `skill_ref:` field pointing to a SKILL.md file. When a PPR walk (high ω_them intent vector) surfaces a procedure neuron with a non-null `skill_ref`, the agent knows: there is an executable skill for this. The agent can then load the SKILL.md (progressive disclosure — <100 token header loaded first, full content on activation).

**This is the Brain-to-Skills interface.** The procedure neuron IS the Hub in Hub-and-Spoke — not a folder, but a node type that bridges declarative retrieval to procedural execution.

The mechanism:
1. CT queries: "How do I ingest a document?"
2. Multiplex Tensor: intent vector → high ω_them (operational query)
3. PPR walk traverses thematic edges (activates, implements, depends-on)
4. Walk surfaces procedure neuron: "ingestion pipeline" (type: procedure, skill_ref: "skills/build-ingestion-pipeline.md")
5. Agent loads the SKILL.md header (<100 tokens, "Use when starting ingestion pipeline for a new document")
6. Condition matches → full SKILL.md loads → agent executes

This is ACT-R production rule firing in Velorin: the procedure neuron is the condition side, the SKILL.md is the action side.

### Does the Brain's Region Structure Affect Which Skills Are Available?

Not directly — folder names don't determine skill availability. But the Brain's GRAPH TOPOLOGY does. The density and connectivity of procedure neurons within each expert domain determines how readily PPR surfaces them.

CT's naval nuclear operations domain will have dense procedure neurons (high-affinity thematic edges) covering domain-specific skills. Because of Clique Centrality, that cluster is immune to Monster Node penalties. PPR will route into it heavily on related queries. Those procedure neurons will point to the relevant SKILL.md files.

The region structure is scaffolding. The topology is the routing. The procedure neurons are the gateways.

---

## 5. What Changes in the Build Guide

**`03_BrainAndMath.md` — Neuron YAML format:**
Add `skill_ref` field:
```yaml
skill_ref: null  # path to SKILL.md file — only populated for type:procedure gateway neurons
```
No other fields change. This field is ONLY populated for procedure-type neurons that serve as Brain-to-Skills bridges. Most procedure neurons will remain null (they encode how-to knowledge but don't map to a specific skill file).

**`02_Architecture.md` — Retrieval flow:**
Add a step after PPR surfacing:
```
If surfaced neuron: type == procedure AND skill_ref != null AND ω_them > threshold:
    → Load skill_ref header (<100 tokens)
    → If condition matches: load full SKILL.md, activate skill
    → Else: return neuron as declarative context only
```

**`07_OpenQuestions.md` — New open question:**
OQ-12: Skill activation routing. Threshold for ω_them that triggers skill activation vs. declarative context return. Whether activation is automatic or agent-judgment. How the system handles multiple procedure neurons with non-null skill_ref in a single PPR walk. These are engineering decisions, not architecture decisions. TBD when the retrieval layer is built.

---

## 6. What Stays Locked From the Prior Analysis

All of these remain correct:

**DO: Move maintenance tasks from CronCreate to Hooks.**
Terry's monitoring, session monitor, daily memory clean — Hook-based (SessionStart, PreCompact/PostCompact). This is the highest-value immediately actionable finding from SkillsTaxonomy.

**DO: Adopt "Use when [condition]" as the standard syntax for all Velorin skill files.**
ACT-R production rule format. Condition first. Payload second.

**DO: Enforce <100 token progressive disclosure for skill headers.**
Metadata header loaded at boot. Full content loads only when skill fires.

**DO NOT: Restructure the Brain's region/area taxonomy based on this research.**
The Brain's existing region structure (Operations, Connectivity, Agents, Principles, Company, Intelligence) is navigation scaffolding. Semantic organization emerges from PPR traversal and E₈ embedding. Don't impose a skills-derived taxonomy onto a knowledge graph.

**DO NOT: Put the Five Boxes as Brain areas.**
Five Boxes are life domains (administrative overlay). Brain organization emerges from connectivity. Explicitly rejected by SemanticMemory research too.

**DO: Keep the Skill Registry as a separate system from the Brain.**
Skills (SKILL.md procedural files) and neurons (atomic knowledge facts) are different memory types. The Skill Registry design from Session 021 is correct. The procedure neuron's `skill_ref:` field is the bridge — it's a pointer from the Brain to the Skills Registry, not a merger of the two.

---

## 7. Why This Is What CT Was Pointing To

CT's question: "How does an agent move from Brain retrieval to skill execution?"

The prior analysis answered: "They're separate systems." True but incomplete.

The full answer: The agent moves from Brain retrieval to skill execution through procedure neurons. A procedure neuron with `skill_ref:` is the interface point. The Multiplex Tensor routes the PPR walk toward procedure neurons when the intent is operational. The procedure neuron declares which skill to execute. The skill executes.

CT's intuition: "Trey may be right that the community convergence toward Hub-and-Spoke reveals something about how the Brain's ROUTING should work — not just how skills should be organized."

He was right. The convergence reveals that routing toward execution requires an explicit interface layer between declarative knowledge and procedural action. In biological brains: the ATL hub routes to basal ganglia via prefrontal mediation. In Velorin: procedure neurons with `skill_ref:` serve as that mediation layer. The Multiplex Tensor handles the routing. The procedure neuron handles the handoff. The SKILL.md handles the execution.

The Hub-and-Spoke IS in the math. The interface was the missing design.

---

## 8. Decisions Required From Chairman

1. **Approve or reject the `skill_ref:` field addition to neuron YAML.** This is a small, contained change. It doesn't break existing neurons (defaults to null). It enables the Brain-to-Skills bridge.

2. **Approve or reject procedure neurons as skill gateways.** The mechanism described in Section 4 — is this the right interface design?

3. **Do not make any Build Guide changes until the AutomatedPointerRating Trey research returns.** The ingestion pipeline (which creates the procedure neurons) depends on it. The `skill_ref:` field addition can be written into the spec now, but the engineering waits.

---

*Jiang2 | April 19, 2026 | Revised after CT critique*

[VELORIN.EOF]
