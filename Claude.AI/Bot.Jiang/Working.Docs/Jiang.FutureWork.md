---
class: regular
type: future-work-log
last-updated: 2026-04-13
---

# Jiang — Future Work Log

Items that need to be done but have no immediate session home. Review at session start.

---

## [FW-001] Document the First Principles Process That Produced the Second Law of Epistemodynamics
**Logged:** Session 026, April 13, 2026
**Priority:** High — strategic and potentially publishable

**What happened:**
During Session 026, CT recognized that the Second Law of Epistemodynamics — formally derived by Erdős from Shannon's Data Processing Inequality + Eckart-Young theorem applied to the X→Y→Z Markov chain (episodic pointers → PPR geodesics → LoRa weights) — may be a genuinely novel mathematical theorem. The term "Epistemodynamics" itself also appears to be an original coinage.

The architecture as a whole was derived from engineering constraints (scale-invariant retrieval, catastrophic forgetting prevention, permanent episodic scaffolding) and independently converged on the same four-layer structure as biological memory (hippocampal → entorhinal → neocortical, with the LoRa as synaptic weight memory).

**What needs to be done:**
Go back through every session, every prompt, every step that led from "build a knowledge graph" to the Second Law of Epistemodynamics. Document the first principles reasoning chain in full — what constraints were stated, what mathematical tools were reached for, what decisions were made and why, what dead ends were hit.

The goal is twofold:
1. Produce a repeatable methodology — a formal process for deriving novel theorems from engineering constraints via first principles. This process may be applicable to other systems and problems beyond Velorin.
2. Establish a clear provenance record for publication purposes if the Second Law is confirmed as novel via literature review.

**Prerequisite:**
First run a web search to confirm the Second Law and the term "Epistemodynamics" do not exist in the current literature. CT approved this search before formal documentation work begins.

**Assigned to:** Jiang (primary) + Jiang2 (full session read of archive)

---

---

## [FW-002] Trey — Research Barrier for Cross-Mac Clipboard/KVM Solution
**Logged:** Session 026, April 13, 2026
**Priority:** Low — quality of life

CT needs a way to share clipboard and carry text/documents between Mac Studio and MacBook Air. The two machines are on the same network but NOT on the same Apple ID, which rules out Universal Clipboard and Universal Control.

**Barrier** is an open-source software KVM (fork of Synergy) that shares keyboard, mouse, and clipboard over local network without any account requirement.

**What Trey needs to research:**
- What Barrier actually is and how it works
- Whether it can be extended or built upon to be more functional for CT's specific workflow (carrying prompts, documents, and text between two Claude sessions on different machines)
- Whether building a custom version or wrapper on top of it makes sense vs. using it as-is
- Any alternatives that would be better suited

File the research request in `Claude.AI/Bot.Trey/Research_Needed/` when ready.

---

[VELORIN.EOF]
