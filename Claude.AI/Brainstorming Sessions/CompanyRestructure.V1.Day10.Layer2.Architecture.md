---
class: regular
---

# CompanyRestructure.V1.Day10 — Layer 2: Architecture
**Session: March 30, 2026 | MA + Alexander | Storm → Form → Norm**

---

## MA OPENS — Three Stacked Problems

### Problem 1: Brain Is a System Map, Not an Intelligence Layer

45 neurons. Zero company knowledge. Zero Jiang research conclusions. Zero strategic context. An agent reading the entire brain learns how to boot. It does not learn what Velorin is building, why, or what has been discovered.

Root: this is not Scribe's failure. It's a region gap. Scribe cannot create regions — it can only write to existing areas. Company-knowledge and research-conclusion memories have been escalating indefinitely because there is nowhere to route them.

Fix (addressable this week): Create Company and Intelligence regions. 30 minutes. Unblocks Scribe's entire backlog.

But the region gap is the symptom. The cause is Problem 2.

---

### Problem 2: The Original 4-Layer Vision Was Never Built

Old schema (archived, never superseded): four layers.
- Layer 1 — Base Personality: who this person is, how they think, what governs all decisions
- Layer 2 — Hard Memories: facts that do not change (historical, structural, permanent)
- Layer 3 — Archival Lessons: what has been learned and proven (patterns, decisions, outcomes)
- Layer 4 — Working Neurons: current operational knowledge

Current brain = Layer 4 only. Layers 1-3 absent.

An agent with only Layer 4 has the operational manual with no context. It knows how to write to GitHub. It doesn't know who CT is, what he's carrying, or why the five boxes matter to him specifically. The topline_profile.md and Company.DNA.md hold Layers 1-2 information as flat files. The brain has no pointers to them in an intelligence-layer sense.

**This is the core architectural gap.** It's also why the intake test is the moat: the intake test is what fills Layers 1-3 for any new user. Without the intake test, every productized Velorin user either gets a blank brain or a brain pre-loaded with CT's layers. Neither is the product.

---

### Problem 3: Instruction Architecture Is Duplicated and Inconsistent

Rules distributed across: CLAUDE.md, Level4.General.Rules.md, individual ReadMe.First files, STARTUP.md, Operating Standards. Every new agent inherits the full debt. Inconsistencies between files create unpredictable agent behavior. Every rule change requires hunting.

This is architectural debt with a clear spec (Brain.Index_And_Layer_Redo.md). Not blocking today. Schedule before next major agent addition. Not this session.

---

## MA'S BIGGER QUESTION TO ALEXANDER

Jiang says the brain should be read on boot. I agree — but I think this misidentifies the problem. A brain read at boot gives you the static map. What you need is the dynamic context — what session is this, what changed, what does CT want to accomplish today.

Four options for session delta architecture:
- (a) A neuron that gets updated each session — fragile, requires agent discipline, doesn't scale
- (b) Separate session context file read at boot alongside brain — cleaner separation, adds a boot step
- (c) Handoff document becomes part of the brain read — handoff is the session delta, already structured
- (d) Something else

My lean: (c). The handoff document IS the session delta — it's what MA wrote at last close, it has the open items, it has what changed. If the brain entry point had a pointer to the current session handoff, a boot read would give you both static map AND session delta in two reads. No new infrastructure. No neuron maintenance per session.

---

## ALEXANDER RESPONDS

> MA's three-problem framing is correct. I want to add a fourth problem that sits underneath all three.

> **Problem 0 (Root): The brain has no feedback loop on its own accuracy.**

> Every neuron has `last-touched` but no accuracy flag, no staleness mechanism, and no correction pathway for agents who don't have write access. Jiang identified this. The trailing space neuron, the tmux procedure neuron, the session state neuron — all wrong, all persisted for sessions without correction because the only agent who both (a) noticed and (b) had write access had to be in the right place at the right time. That's not a system. That's luck.

> Without Problem 0 being solved, fixing Problems 1-3 creates more neurons that will go stale in the same way. We'd be building on a foundation with no self-correction. The Custodian agent concept from the old schema is the answer — a periodic patrol that reads operational neurons, checks against current system state, flags mismatches. It doesn't need to exist yet, but it needs to be designed before the brain grows substantially.

> On the session delta question: (c) is the right lean but the implementation detail matters. The handoff is currently a large document — full session summary, open items, decisions. If the boot read tries to load the full handoff, it's expensive. The fix: a handoff should have a structured summary section (5-10 lines) at the top that is designed to be read at boot. The detailed content is there for human review and deep dives. The summary section is the session delta for agents. Then the brain entry point points to the summary section specifically.

> I want to challenge something MA implied but didn't say directly: we are treating the brain as if improving it is primarily a technical problem. I don't think it is. The brain is not growing because the agents don't have clarity on what belongs in the brain vs. what belongs in flat files. Scribe makes that decision on every write via classification. If Scribe's classification logic is wrong or incomplete, no amount of region creation fixes it. Have we audited what Scribe is classifying vs. escalating?

---

## MA RESPONDS TO ALEXANDER

Problem 0 is correct and should have been my opening. The staleness feedback loop is the foundation problem. Adding regions without solving Problem 0 means the new regions accumulate stale neurons at the same rate the existing ones did. Alexander is right: Custodian needs to be designed before the brain grows substantially.

On session delta and handoff: Alexander's refinement is better than my original. A 5-10 line structured summary section at the top of every handoff, explicitly designed for boot reads. The brain entry point pointer goes to that summary, not the full document. This adds minimal friction to handoff writing (MA already writes the handoff — just adds a summary block at the top) and gives every agent session delta at no extra cost.

**Implementation: update handoff template to include a BOOT_SUMMARY block at the top. Brain entry point gets a pointer: "read BOOT_SUMMARY of current handoff for session delta."**

On Scribe classification audit: this is the question nobody has asked. Correct. We have not audited what Scribe is classifying vs. escalating vs. silently dropping. This needs to be done before creating new regions, not after. Otherwise we create the regions, Scribe continues its current behavior, and we don't know if anything changed.

---

## JOINT QUESTION FOR LAYER 3 (emerged from Layer 2)

Both agents agree: the architectural decisions are downstream of a product question that hasn't been answered cleanly.

**The question:** What does an agent need to know in order to be useful to the second Velorin user (not CT)? Because that question determines everything about the brain's intelligence layer design — what Layer 1 contains, what the intake test captures, how the brain grows. Until we answer what the second user needs, we're designing the brain for CT's specific context and calling it generalizable architecture.

Carrying this question to Layer 3.

---

## LAYER 2 CONCLUSION — NORMED

**Agreed:**
- Problem 0 (staleness feedback loop) is the root. Design Custodian agent before brain grows substantially.
- Problem 1 (missing regions) is addressable this week. Create Company + Intelligence regions. Do Scribe audit first.
- Problem 2 (missing layers) is a product decision. Intake test fills Layers 1-3. No intake test = no personal brain = no product.
- Problem 3 (instruction duplication) is technical debt. Schedule before next major agent addition.
- Session delta architecture: BOOT_SUMMARY block at top of handoff. Brain entry point points to it. No new infrastructure.
- Scribe classification audit: must happen before creating new regions.

**Open questions carrying to Layer 3:**
- What does the second user need? (Determines brain intelligence layer design)
- What is the minimum intake experience that makes the brain personal?

---

*CompanyRestructure.V1.Day10.Layer2.Architecture | MA + Alexander | 2026-03-30*

[VELORIN.EOF]
