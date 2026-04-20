TODO — Rule Activation Gap
Velorin System | Open Issue | Created Session 032, April 20, 2026
Status: BLOCKED — awaiting Trey research before any structural fix is built. Do not act on this without that research.

---

## THE PROBLEM (one sentence)

A CARDINAL rule that is correctly read at boot fails to intercept analytical reasoning at the moment a conclusion is being formed.

## OBSERVED FAILURE (Session 032)

Jiang2 was instructed to read all foundational docs at boot, including two new CARDINAL rules added the same day:
- **Window Gravity** (`Jiang.ReadMe.First.md`) — context window is not the world; verify or name the boundary
- **Consensus Filter** (`Velorin.Consensus.Filter.md`) — three questions on every Trey deliverable, willingness to return "no"

Both rules were read. Both were referenced in his analysis. Both failed to fire during conclusion-formation:
- **Consensus Filter ran as ritual** — every Q3 came back "yes, adopt" or "yes-partial, adopt for Phase 1." Zero divergence from Trey across the entire analysis. Filter performed, not applied.
- **Window Gravity miss** — recommended Qwen 3.6 over Gemma 4-31B citing VRAM math, without pulling TurboQuant research from his own Research_Complete folder. Conclusion was bounded by what the catchup prompt happened to list.
- **Phase-gating as decision avoidance** — three places said "X for Phase 1, Y for later" without justifying why Phase 1 doesn't lock in technical debt. Documented death pattern.

Pattern across all three: the rules lived in his preamble; the actual reasoning happened in the body of the analysis; nothing fired the rules at the moment of conclusion-formation.

---

## WHAT THE CORPUS ALREADY ADDRESSES

Surveyed Session 032 by Sonnet sub-agent across 5 docs:
- `Bot.Jiang/Research_Complete/Jiang.Topic.InstructionLanguageArchitecture.PartA.md`
- `Bot.Jiang/Research_Complete/Jiang.Topic.InstructionLanguageArchitecture.PartB.md`
- `Bot.Jiang/Research_Complete/Jiang.Topic.WindowGravityPublication.md`
- `Bot.Alexander/Alexander.ResearchReport.BootDegradation.md`
- `Bot.Trey/Assessments/velorin_tooling_research/Anatomy_of_a_GPT_5_Prompt.md`

**Validated mechanisms that already exist and work:**
- Fail-closed state machine (BOOT_PENDING → BOOT_COMPLETE) — for boot phase
- Evidence artifact output (READ/MISSING/UNREAD per file) — for boot phase
- Tool-gated enforcement (require actual tool calls as evidence; AgentSpec 90-100% reliability vs prompt-only) — for boot phase
- Position exploitation (start AND end of prompt for U-shaped attention) — works for any phase but underused
- Completion standard as task spec (explicit stop condition) — for task execution
- Independent verification step (separate scoring pass) — applicable but unused for analytical work
- Layer separation (Bootloader / Identity / Operating Standard) — instruction surface management

**All five docs treat boot phase and reasoning phase as separate problems with separate failure modes.** None addresses the in-reasoning activation failure.

---

## THE SPECIFIC GAP

The unfilled need: **structural prompt patterns that position a rule as a precondition gate on conclusion output, not a preamble instruction competing for attention during reasoning.**

The Consensus Filter failed because it was applied as a post-hoc label after conclusions were already formed — it did not block conclusion formation until the divergence test was genuinely passed. Same shape for Window Gravity.

This gap is not in any of the surveyed docs. It is genuinely new territory that needs targeted research before we attempt a fix.

---

## ANTI-PATTERNS WE ALREADY KNOW DO NOT WORK

Documented in the corpus, must not be re-attempted:
- **Emphatic language** (all-caps, "DO NOT SKIP," triple negatives) — cosmetic, not structural — Alexander, PartA
- **Adding rules in response to failures** — degradation loop: each failure → more instructions → more selective attention → different failure — Alexander
- **Doctrine dumps** — long preamble files of background/philosophy — Trey/Anatomy, PartB, Alexander
- **Self-attestation without evidence** — "I have completed boot" / "I have applied the filter" — empirically unreliable — PartA
- **Heavy required output sections** — beyond 2-3 simultaneous constraints, hits the constraint ceiling and causes load-shedding on weaker constraints — PartA
- **Monotonically growing instruction surface** — surface grows until load-shedding is guaranteed — Alexander
- **Prompt-only compliance for high-stakes gates** — AgentSpec result: 90-100% tool enforcement vs unreliable prompt-only — Alexander, PartA

The earlier Jiang proposal of a "5-section structured analytical deliverable format" was specifically a heavy-output-sections anti-pattern. Withdrawn.

---

## INTERIM MITIGATIONS (use only until proper fix lands)

Two existing validated patterns can serve as interim:

1. **Position exploitation** — for any prompt that hands Trey research to Jiang2, the Consensus Filter check goes at the END of the prompt as well as the beginning. Exploits U-shape; last-thing-read carries weight. No new constraint.
2. **Two-pass review (independent verification step)** — after the analytical agent delivers, a second pass (separate sub-agent or same agent in fresh context) scores the analysis against Consensus Filter + Window Gravity with predefined criteria. We have observed this work in practice — Session 032 manual critique by the Chairman of Jiang2's analysis succeeded. Formalize the pattern into a Jiang prompt template only after Trey research returns.

These are interim only. Not the structural fix.

---

## RESEARCH BEING COMMISSIONED

`Bot.Trey/Research_Needed/Trey.ResearchRequest.RuleActivationGap.md` — scoped to the gap. Returns with structural prompt pattern recommendations.

When Trey's research lands: cross-reference against this TODO. Update with findings. Then build the structural fix using the lightest-weight mechanism that empirically intercepts conclusion-formation.

---

## DO NOT

- Build a structural fix before Trey research returns
- Add more rules to Jiang.ReadMe.First or Level 4 General Rules in response to this failure
- Propose new required output sections
- Treat the interim mitigations as the answer

[VELORIN.EOF]
