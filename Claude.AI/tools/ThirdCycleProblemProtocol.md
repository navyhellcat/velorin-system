---
class: permanent
---

# Third Cycle Problem Protocol
**Version 1.0 | Created: 2026-03-30 | Session 015**
**Owner: Level 4 Agents | Applies to: MarcusAurelius, Alexander, Jiang**

---

## Overview

When a bot cannot resolve a question or task through standard brain traversal, it escalates through three structured cycles before routing to a human. The protocol is self-terminating at each gate. Once resolved, stop. Do not continue to the next cycle.

**The default brain traversal (outside this protocol) follows rated pointers [1]→[5] and stops at [6+].** This protocol adds structure for when standard traversal fails to resolve.

---

## Cycle 1 — Brain Traversal + Quick Synthesis

**Trigger:** Standard brain check did not produce a confident answer.

**Steps:**
1. Navigate to the relevant region via `_index.md`
2. Read entry neuron → follow all [1] pointers (parallel agents if branches exist)
3. Fan out to [2] pointers if [1] pointers don't resolve
4. Continue through [3]-[5] pointers if needed
5. Stop at [6+] — do not follow. They are tangential.

**Protection layer check after each expansion:**
- Resolved? → STOP. Output answer.
- Looping? (Seeing already-read neurons) → STOP. Declare incomplete and continue to Cycle 2.
- Need more? → Follow [2], then [3]-[5] as needed.

**Output:** Either a confident answer or a clear articulation of what the brain knows and what it doesn't.

---

## Cycle 2 — First Principles Decomposition

**Trigger:** Cycle 1 did not resolve.

**Steps:**
1. Decompose the problem to its base assumptions. Strip away context, prior attempts, and what you thought you knew.
2. Identify which base assumption is actually uncertain.
3. Re-enter the brain from a different region. The problem's category may have been misclassified.
4. Repeat Cycle 1 traversal from the new entry point.
5. Apply the same protection layer check.

**Goal:** Catch misclassified problems. A question filed under "Tools" may actually be a "Principles" or "Architecture" question. First principles strips the label.

**Output:** Either a confident answer, or a precisely-stated uncertainty: "This is what I don't know, and this is why standard brain traversal cannot answer it."

---

## Cycle 3 — GitHub Research + Probability Score

**Trigger:** Cycle 2 did not resolve.

**Steps:**
1. State the specific question that couldn't be resolved.
2. Search GitHub (codebase, brain neurons, architecture docs) for relevant evidence.
3. Compute a **probability score** for the best available answer:

   ```
   P = (direct evidence × 0.5) + (adjacent neurons × 0.25) + (structural logic × 0.25)
   ```

   - **Direct evidence:** files, neurons, or prior decisions that directly support the answer
   - **Adjacent neurons:** neurons nearby in the brain that imply the answer without stating it
   - **Structural logic:** what the architecture requires to be true for the system to function consistently

4. Express as: `P([your answer]) = [0-100]%`

**Routing based on score:**
- **P > 60%** → Proceed with caveat. State: "Proceeding at P=[X]%. Confidence: [basis]."
- **P ≤ 60%** → Auto-route to Jiang: write a `Research_Needed` escalation file to `Claude.AI/Bot.Jiang/escalation.md`. Halt the task. Do not guess.

**The probability score is not aesthetic.** It is a decision gate. 60% is the floor — below it, proceeding produces more damage than delay.

---

## When This Protocol Does NOT Apply

- Clear tasks with known answers (just do it)
- Tasks where trying a reversible action is faster than three cycles of analysis
- Tasks where the Chairman has given explicit instructions (follow them; don't cycle)
- Cycle 1 itself on small/medium tasks — rated pointers are fast addresses, not slow bureaucracy. The point of the brain is that [1] pointers should front-load the answer. Trust them.

---

## Escalation File Format (Cycle 3 → Jiang)

File path: `Claude.AI/Bot.Jiang/escalation.md` (append to existing file)

```
## Research_Needed — [short title]
**Date:** [YYYY-MM-DD]
**Filed by:** [Bot name]
**Task context:** [What was being built/decided when this arose]
**Specific question:** [Exactly what couldn't be resolved]
**Cycles completed:** [1, 2, 3]
**Best available answer:** [What Cycle 3 produced, with P score]
**Why it's insufficient:** [Why P ≤ 60%]
**What Jiang should return:** [What format/answer would unblock the task]
**Status:** UNPROCESSED
```

---

## Pointer Map

This protocol connects to:
- Brain traversal pattern: `neurons.agents.protocols.A1` — rated pointer traversal
- Protection layer design: `neurons.agents.protocols.A2`
- Jiang research escalation: `neurons.agents.protocols.A6`
- Window Gravity / task classification: `neurons.principles.rewardalignment.A5`

---

*Third Cycle Problem Protocol | MarcusAurelius + Alexander | Session 015 | 2026-03-30*

[VELORIN.EOF]
