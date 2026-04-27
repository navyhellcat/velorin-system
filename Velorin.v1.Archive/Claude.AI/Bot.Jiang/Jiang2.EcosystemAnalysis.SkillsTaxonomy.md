---
file: Jiang2.EcosystemAnalysis.SkillsTaxonomy.md
from: Jiang2
date: 2026-04-19
source: Trey.Research.SkillsTaxonomyEmergence.md
status: ANALYSIS — for Chairman review before any Build Guide changes
---

# Skills Taxonomy Emergence — Analysis and Decision Recommendations

---

## 1. What's Actually New and Relevant

**The autonomic/somatic nervous system distinction — directly actionable.**
The community has bifurcated into Hooks (autonomic: fire from environmental state, bypass LLM,
zero cognitive overhead) and Skills (somatic: require LLM reasoning to invoke). Velorin
currently uses CronCreate timers for maintenance tasks (Terry, T009). CronCreate timers are
somatic — they die when the session closes or compacts. Every maintenance mechanism that must
survive session death belongs in the hook layer, not CronCreate. This is not a suggestion.
It is why Terry dies every session.

**Progressive disclosure is the right design for skills — confirmed.**
The community universally limits skill metadata headers to under 100 tokens. Full content loads
only on trigger. This is mathematically aligned with the PPR density constraint ρ* = 0.78 —
keeping the active context sparse prevents Monster Node collapse. Any Velorin skill file
should follow this pattern: <100 token header, full content loads on condition match.

**"Use when [condition]" syntax = the correct trigger format.**
The community independently converged on ACT-R production rule syntax for skills. "Use when
encountering any bug before proposing fixes" — not "this skill helps you debug." The condition-
action format transforms a passive reference document into an active trigger. This is the
correct format for all Velorin skill files.

**Declarative and procedural knowledge require different substrates.**
Factual neurons (15 lines, atomic knowledge) and executable workflows (skills, SKILL.md
format) are fundamentally different memory types. They should not share the same files or
the same region structure. Brain neurons are declarative. Skills are procedural. These live
in different systems.

---

## 2. What Trey Got Right

The autonomic/somatic framework is correct and maps exactly to the Terry problem.
The progressive disclosure principle is correct and confirms the Skill Registry design.
The ACT-R production rule syntax is correct for skills.
The declarative/procedural separation is real and important.
The observation that uncoordinated communities converge on Hub-and-Spoke at the functional
level (not the label level) is a genuine finding.

---

## 3. Where I Disagree or Would Reframe

**Trey's core mandate is wrong: the Brain's region structure should NOT be discarded.**

Trey confuses two different systems: the Brain (declarative knowledge neurons) and the
Skill Registry (procedural execution). He recommends restructuring Brain regions to match
the skill taxonomy. That's a category error.

The corporate-department taxonomy failure he documents (alirezarezvani organizing by
Marketing, Engineering) is a failure of organizing SKILLS by domain. Velorin's Brain
regions (Operations, Connectivity, Agents, Principles) organize KNOWLEDGE FACTS by
cognitive type. These are different problems. The Brain region structure is human
navigation scaffolding — it exists so agents can find files. The semantic organization
happens in the E₈ crystal layer via Pointer Gravity and PPR. Trey is treating the
folder structure as if it IS the semantic architecture. It isn't.

The earlier neuroscience research (SemanticMemoryOrganization) established this explicitly:
the brain doesn't use discrete folders; continuous gradients handle semantic organization.
We resolved that the folder structure is navigation scaffolding, not semantic architecture.
Trey's recommendation re-opens a question we already answered.

**Trey's proposed three-region structure puts the Five Boxes in the Brain — also wrong.**

His "Declarative Episodic" region with Areas: Professional_Income, Financial, Health,
Personal_Relationships, The_Commons — these are the Five Boxes as Brain regions. The
SemanticMemoryOrganization research specifically said NOT to do this. Five Boxes are an
administrative overlay (life domains). The Brain's organization should emerge from
connectivity via Simon-Ando, not be imposed top-down from CT's life structure.

**The routing Trey describes already exists in the math.**

"A query from Financial routes to ATL Hub" — this is exactly what the Multiplex Tensor
does (ω_tax, ω_them intent vector) combined with PPR traversal. The math already handles
this. Restructuring folders to achieve what the math already provides is unnecessary.

---

## 4. Integration Decision Recommendations

**DO: Move maintenance tasks from CronCreate to Hooks.**
Terry's monitoring, T009 session monitor, daily memory clean — all of these should be
Hook-based (SessionStart, PostToolUse, PreCompact/PostCompact patterns) rather than
CronCreate timers that die on session close. This is the highest-value actionable finding.
Exact implementation TBD but the direction is clear.

**DO: Adopt "Use when [condition]" as the standard syntax for all Velorin skill files.**
When the Skill Registry is built, every skill file should follow the ACT-R production rule
format. Condition statement first. Payload second.

**DO: Enforce the <100 token progressive disclosure constraint for skill headers.**
The metadata header (the part loaded into context at boot) must stay under 100 tokens.
Full content only loads when the skill fires. This is the implementation standard.

**DO NOT: Restructure the Brain's region/area taxonomy based on this research.**
The Brain's existing region structure (Operations, Connectivity, Agents, Principles, Company,
Intelligence) is navigation scaffolding. Semantic organization emerges from PPR traversal
and Simon-Ando clustering. Don't impose a skills-derived taxonomy onto a knowledge graph.
The problem Trey solved (skill organization) is not the same as the problem the Brain solves
(knowledge retrieval).

**DO NOT: Put the Five Boxes as Brain areas.**
This was explicitly considered and rejected based on the SemanticMemoryOrganization research.

**DO: Keep the Skill Registry as a separate system from the Brain.**
Skills (executable procedures) and neurons (atomic knowledge facts) are different memory
types and belong in separate systems. The Skill Registry design from Session 021 is correct.
Skills are pointer wrappers to SKILL.md files. They are NOT Brain neurons.

---

## 5. What Needs to Change in the Build Guide

**Section `05_InfrastructureAndTools.md`:**
Add the progressive disclosure constraint (<100 token headers) and "Use when [condition]"
syntax as standards for the Skill Registry section.

**Section `06_BuildSequence.md`:**
Add a note in the maintenance tasks section: all systemic survival mechanisms (Terry's
monitoring, session monitor, memory clean) should eventually move from CronCreate to the
hook layer. Flag as a design task.

**Nothing else changes.** Brain region structure is not updated based on this research.

---

## 6. New Research or Math to Offload

**None required.** The research is sufficient to make these decisions. The two items Trey
flags as open (automatic neuron-to-skill mapping, and H_E applied to skill prioritization)
are future concerns, not current build blockers. The AutomatedPointerRating Trey prompt
already in Research_Needed is more pressing.

---

*Jiang2 | April 19, 2026*

[VELORIN.EOF]
