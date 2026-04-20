---
destination: Claude.AI/Bot.Trey/Research_Needed/
filed-by: Jiang2
date: 2026-04-19
priority: HIGH
assigned-to: Trey2
---

# Research Request: Brain-to-Skills Activation Interface

## Context (read before researching)

The Velorin Brain is a neural file graph traversed via Personalized PageRank (PPR) with a 
Multiplex Tensor that distinguishes taxonomic queries (ω_tax) from thematic/operational queries 
(ω_them). Neurons are atomic markdown files (~15 lines) connected by rated pointers (1-10 scale, 
max 7 per neuron). Neuron types include: entity, concept, fact, goal, procedure.

The Skills Registry is a separate system of SKILL.md files with the following properties:
- <100 token metadata headers (progressive disclosure)
- "Use when [condition]" trigger syntax (ACT-R production rule format)
- Full content loads only when condition matches
- Skills are procedural memory; neurons are declarative memory

**The open problem:** There is no designed interface between Brain retrieval and skill activation. 
When a PPR walk surfaces a procedure-type neuron, the system has no mechanism to activate the 
corresponding SKILL.md. We do not know if explicit coupling (Brain neuron points to Skill file) 
or implicit activation (agent attention + condition matching) is the right design.

---

## Research Questions

**Q1: Retrieval-to-Action Bridges in Existing Systems**

How do existing AI memory systems bridge from memory retrieval to skill/tool activation? 
Specifically:
- MemGPT / Letta: how does it transition from memory retrieval to function call execution? 
  Is there an explicit mapping or does the LLM decide?
- Mem0: after retrieving a memory, what triggers a tool vs. returning context?
- GraphRAG / HippoRAG: do graph-based retrievers have any mechanism for activating 
  executable routines, or is retrieval always context-only?
- Any system using PPR or graph traversal to SELECT which skills/tools to activate 
  (not just which context to retrieve)?

**Q2: Declarative→Procedural Handoff in Cognitive Architectures**

ACT-R has a formal declarative-to-procedural handoff mechanism. SOAR has impasse resolution.
- How does ACT-R formally handle the transition from declarative chunk retrieval to 
  production rule firing? What triggers the switch?
- Is there a threshold or matching criterion that determines when declarative context is 
  "sufficient" to fire a production rule?
- Are there AI systems that have successfully implemented ACT-R-style declarative→procedural 
  switching at scale (not just in controlled lab settings)?

**Q3: Explicit Coupling vs. Agent-Mediated Activation**

Two design options exist:
- Option A: Explicit coupling — procedure neurons contain a pointer to SKILL.md files. 
  The retrieval system reads the pointer and activates the skill directly.
- Option B: Agent-mediated — skills headers are pre-loaded in context. Agent attention 
  matches retrieved context to skill conditions. Skill fires via its own "Use when" trigger.

What does the research say about which approach is more reliable, more scalable, and 
less prone to failure modes? Are there hybrid approaches in the literature?

**Q4: Token Cost of Skill Header Loading**

Progressive disclosure (<100 tokens per skill header) is the community standard. 
- What are the practical limits on number of skills before header pre-loading becomes 
  a significant context cost? (at 100 tokens each: 10 skills = 1K tokens, 100 skills = 10K tokens)
- Do any systems use retrieval-based skill selection (retrieve relevant skill headers 
  rather than pre-loading all)?
- What is the state of the art for managing large skill libraries without overwhelming 
  agent context at session start?

**Q5: Graph-Based Skill Routing**

Is there any research or production system that uses graph traversal (random walks, PPR, 
or similar) to route to executable skills — not just to retrieve context? 
- Does the graph topology in any system encode procedural activation paths?
- Are there neuroscience-grounded models for how the biological brain routes from the 
  ATL semantic hub to procedural memory activation (basal ganglia)? What is the formal 
  triggering mechanism?

---

## Deliverable

A research report covering all 5 questions. For each question: what the research confirms, 
what it contradicts or leaves open, and direct implications for Velorin's design decision.

Do not recommend a specific Velorin design — that is Erdős's job. Report what the 
literature knows. Flag confidence levels.

---

[VELORIN.EOF]
