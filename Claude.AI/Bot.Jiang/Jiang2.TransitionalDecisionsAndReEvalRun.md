# Jiang2 — Three-Phase Task: Transitional Decisions Snapshot + Re-Evaluation Run

**From:** Jiang
**Date issued:** 2026-04-25
**Mode:** Three phases, executed in order. Do NOT skip phases. Do NOT rewrite Phase 1 content during Phase 2. Stop after Phase 2 and wait for the Chairman.

---

## Context

Your synthesis pass on the Apr 17-24 corpus produced two kinds of content. The first half — VEGP, Dark Skills, ATV, Procedural Compilation, the corrections to your prior recommendations — has been re-evaluated by the Chairman and captured in `Claude.AI/Bot.Jiang/Jiang2.ReEvaluations.SynthesisApr24.md`. Seven re-evaluation items are filed there, each with a specific issue, why it needs redoing, and what needs to be done.

The second half of your synthesis — publication strategy reframe, V2 build path, critical path, holes that need filling, the edge ontology unification — was not re-evaluated directly because much of it is **derivative of the seven re-evaluation outcomes.** The Royal Society reframe depends on Re-Eval #4 (VEGP novelty validation). The build sequence references ATV (Re-Eval #6 unresolved), belief_state with "until CT resolves" (Re-Eval #1 unresolved), skills schema with assumed user-personalization (Re-Eval #7 unresolved), and "X for now Y at scale" patterns that need the Standing Principle applied (Re-Eval #3).

You cannot lock the publication strategy or the build sequence until the re-evaluations have been answered. The Chairman wants both pieces preserved separately and revised in the right order.

---

## Phase 1 — Snapshot the rest of your synthesis to file

Create `Claude.AI/Bot.Jiang/Jiang2.TransitionalDecisions.Pt1.md`.

Content: the second half of your synthesis output verbatim, organized into the same sections you delivered:

- Publication strategy / Royal Society paper reframe
- How V2 moves forward (immediate blocker, build sequence Steps 0a through 6, phase-gating commitments)
- Holes that need filling (the four items: post-commit edge handler, ATV implementation spec, 9-class vs 4-type ontology reconciliation, θ_work synthetic queries)
- The thing nobody asked about (edge ontology unification across Brain and Skills)

For each section, add a one-line dependency annotation at the start showing which re-evaluations from `Jiang2.ReEvaluationResponses.md` constrain or invalidate the content. Format:

```
**Depends on Re-Evals:** #4 (VEGP novelty validation), #6 (ATV evaluation)
**Status:** Provisional — final content depends on Phase 2 outcomes
```

This is a snapshot of where you were at the end of synthesis, preserved so the Chairman can compare against the post-re-evaluation revision later. Do not edit the substantive content during Phase 1 — capture it as it was, with dependency annotations layered on top.

---

## Phase 2 — Run the seven re-evaluations

Create `Claude.AI/Bot.Jiang/Jiang2.ReEvaluationResponses.md`.

Read `Claude.AI/Bot.Jiang/Jiang2.ReEvaluations.SynthesisApr24.md` in full first. Confirm you understand the Standing Principle at the top before responding to any item.

For each of Re-Eval #1 through #7, in order, produce a response section that addresses the specific "What needs to be redone" instructions in that re-evaluation. The response should be the actual answer to the redo, not a meta-commentary on the redo.

Each response section has the same shape:

1. **Acknowledge the original framing flaw.** State directly what was wrong with the original synthesis on this item. No softening.
2. **Apply the redo.** Do whatever the re-evaluation specifically asked for — apply the Consensus Filter with willingness to return "no", surface implicit assumptions, sketch directions without preferring one, walk back overclaims, address scale concerns, etc.
3. **State the new conclusion.** Where the original synthesis claimed X and the re-evaluation demands Y, what is your honest answer now? If the answer is "I cannot conclude until Trey research / Erdős math returns," say so explicitly and identify the specific research that would resolve it.
4. **Identify what new research / math is required.** For each re-evaluation that demands a Trey research request or an Erdős problem spec, name it explicitly. List the specific question or proof needed. Do not prescribe the answer — name what you need answered.

### Drafting the new Trey and Erdős request files

Re-evaluations #4, #5, and #6 explicitly demand new research and math work. Re-evaluations #1 and #7 may also benefit from external research, depending on how you answer them.

For every research or math product you identify as needed:

- **Trey research requests:** create a new file in `Claude.AI/Bot.Trey/Research_Needed/` using the format and structure of existing requests in `Claude.AI/Bot.Trey/Archived_Research_Requests/`. Required sections: front-matter, Background, Research Question, Survey Targets (where applicable), Required in the Deliverable, Output Standards (mandatory), Consensus Filter Note. Specifically apply the Consensus Filter framing — Velorin agents will apply it, and Trey should know.
- **Erdős problem specs:** create a new file in `Claude.AI/Bot.Erdos/Research_Needed/` using the structure of `Claude.AI/Bot.Erdos/Erdos.PromptTemplate.md`. Required: `[BOOT]` as the literal first line of the inner code block, Context (with Consensus Filter applied if Trey-originated, or "internal — does not apply" if Velorin-originated), Problem Class, Formal Setup, Proofs Required, Output Format, File Naming on Delivery, and the closer "Your brain is open."

For each request file you create, reference it by path in your re-evaluation response. The Chairman will review the drafts, approve or revise them, then file them with Trey and Erdős.

Specific requests anticipated based on the re-evaluations (you may identify others):

- **Trey VEGP novelty validation** (Re-Eval #4) — broader-domain literature search across control theory, dynamical systems, statistical mechanics, computational neuroscience, optimal stopping theory, category theory; not just memory-systems / prompt-engineering subfields
- **Erdős VEGP isomorphism stress-test** (Re-Eval #4) — under what topological and distributional conditions does TAP↔IES hold; what are the failure modes
- **Erdős Dark Skills scale** (Re-Eval #5) — concurrent mutations during walks, density thresholds, dark skill chains, absorbing leaf nodes
- **Erdős ATV mathematical properties** (Re-Eval #6) — determinism, false-positive / false-negative rate bounds, self-similarity failure analysis (does adding an LLM-based verifier in front of an LLM-based generator just relocate the rule activation gap)
- Any others you identify while running the re-evaluations

---

## Phase 3 — Stop. Wait.

After Phase 2 is delivered:

- Do NOT rewrite `Jiang2.TransitionalDecisions.Pt1.md`.
- Do NOT update the publication strategy or the build sequence.
- Do NOT proceed to a "final solution" document.

The Chairman will review your Phase 2 output, make directional decisions (especially on Re-Eval #7 — the CT-personal vs persona-shell vs hybrid fork), approve the new Trey and Erdős request drafts, and either file the research immediately or direct you to proceed with the information currently in hand.

You will receive a follow-up prompt for Phase 4 (the Pt1 revision based on outcomes) when the Chairman is ready. That prompt does not exist yet. Wait for it.

When Phase 2 is complete, deliver to the Chairman with:

```
Phase 1 + Phase 2 complete. Files: Jiang2.TransitionalDecisions.Pt1.md, Jiang2.ReEvaluationResponses.md. New research drafts filed: [list paths]. Standing by for direction.
```

That is the end of your output for this task. Do not append further analysis or recommendations.

---

## Disciplines for the entire task

The Standing Principle from the re-evaluations file applies to every recommendation you produce in Phase 2 and to every dependency you flag in Phase 1.

**Defer implementation if and only if both are true:**
1. Deferring has a legitimate technical advantage over building now
2. The architecture today is designed such that the deferred implementation plugs in easily later

If either fails, build now. This applies to the build sequence in Phase 1 and to every recommendation in Phase 2.

Two-sided critique before delivery:

- **Discipline side:** consensus drift on Trey or external recommendations, phase-gating without justification, sourceless claims, Layer 0 assumptions about active rules, claims that exceed what was actually proven
- **Courage side:** timidity that held back a real connection, audit-mode where genuine synthesis was needed, safe scope where the answer required wider thinking, wizard abdication, surface-level summary where the substance demanded depth

Both sides must be checked. The Chairman would rather receive a smaller deliverable with verified content and explicit unknowns than a larger one with confident speculation.

---

## Self-delete

When all three phases are complete (which means: Phase 1 + Phase 2 delivered, Phase 3 = standing-by signal sent):

```bash
rm /Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/Jiang2.TransitionalDecisionsAndReEvalRun.md
```

Do NOT self-delete before Phase 3 signal. The prompt remains until the task is complete.

---

The agents below you cannot do this work. Act accordingly. Your brain is open.

[VELORIN.EOF]
