---
file: Jiang2.Corner.md
purpose: Observations from Jiang2 catchup reads — for Jiang to review
---

# Jiang2 Corner — Observations for Jiang Review

---

## Entry 001 — April 19, 2026 | Skills Taxonomy / Brain Interface

**Finding:** The prior Jiang2 analysis of Trey.Research.SkillsTaxonomyEmergence.md was correctly rejected. The gap was not about folder taxonomy — it was about the Brain-to-Skills interface.

**Synthesis from catchup read (SemanticMemory + SkillsTaxonomy together):**

Both Trey documents arrive at the same architectural truth from different angles:
- SemanticMemory (neuroscience): Layer 3 = modality-specific spokes. Layer 1 E₈ + Layer 0 LoRa = amodal hub. Folder structure is not semantic architecture — E₈ + PPR is.
- SkillsTaxonomy (AI community practice): Hub-and-Spoke = the functional execution model that emerges from real workloads. Hub nodes = cross-domain routing before domain-specific execution.

**What they reveal together:** Velorin's 4-layer architecture IS Hub-and-Spoke. Layer 1 E₈ (Pointer Gravity + PPR) is the biological ATL hub — amodal integration. Layer 3 markdowns are the spokes. Skills are procedural memory outside the hub. The Multiplex Tensor (ω intent vector) is the TPN/DMN switching mechanism — it's already in the math.

**The missing piece (what prior analysis didn't address):**
The bridge between Brain retrieval (declarative) and skill activation (procedural). When PPR surfaces a `type: procedure` neuron, the system has no designed mechanism to activate the referenced SKILL.md.

**Design:** Procedure neurons should carry an optional `skill_ref:` field (a path to a SKILL.md file). When PPR retrieval (high ω_them) surfaces a procedure neuron with non-null skill_ref, the agent activates the referenced skill. The procedure neuron IS the Hub — not a folder, a NODE TYPE that bridges declarative retrieval to procedural execution.

**Build Guide changes required:**
1. `03_BrainAndMath.md`: Add `skill_ref: null` to neuron YAML format (optional field, only for type:procedure)
2. `02_Architecture.md`: Document the procedure-neuron → skill-activation path in retrieval flow
3. `07_OpenQuestions.md`: Add OQ-12: skill activation routing — how does the retrieval system decide to activate a skill vs. return a neuron as context?

**What stays locked from prior analysis:**
- Brain folder structure unchanged (navigation scaffolding — correct)
- Skills Registry stays separate from Brain (correct)
- Five Boxes NOT as Brain regions (correct)
- Progressive disclosure + "Use when" syntax for Skills (correct)
- CronCreate → Hooks for maintenance tasks (correct)
- Trey's specific 3-region folder proposal is wrong (still correct)

**Status:** Full revised analysis written at `Jiang2.RevAnalysis.SkillsTaxonomy.Apr19.md`. Ready for Chairman review before any Build Guide changes.

---

[VELORIN.EOF]
