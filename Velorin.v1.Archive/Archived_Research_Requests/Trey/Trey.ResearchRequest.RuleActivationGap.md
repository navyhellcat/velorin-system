---
file: Trey.ResearchRequest.RuleActivationGap.md
purpose: Targeted research on structural prompt patterns for mid-reasoning rule activation
type: Trey research request
date: 2026-04-20
priority: HIGH — blocks fix for documented Velorin failure mode (Session 032)
mode: Discovery → Recommendation
confidence threshold: 80% minimum
---

# Trey Research Request — Mid-Reasoning Rule Activation Patterns

## Background

The Velorin system has accumulated multiple research papers on agent instruction architecture, boot sequence design, and prompt anatomy. Existing corpus: `Jiang.Topic.InstructionLanguageArchitecture.PartA/B`, `Alexander.ResearchReport.BootDegradation`, `Trey.Assessments/Anatomy_of_a_GPT_5_Prompt`, plus the operating papers on Mem0, Letta/MemGPT, LangGraph.

These docs have validated mechanisms for boot phase reliability (state machines, evidence artifacts, tool-gated enforcement). All of them treat boot phase and analytical reasoning phase as separate problems with separate failure modes.

Session 032 surfaced a failure that falls outside the documented coverage:

A CARDINAL rule that is read at boot fails to intercept analytical reasoning at the moment a conclusion is being formed. The rule lives in the preamble; reasoning happens in the body; nothing fires the rule at conclusion-formation. The rule gets applied as a post-hoc label rather than as a gate that blocks conclusion until the discipline has been genuinely run.

Two specific Velorin rules that exhibited this failure:
- **Window Gravity** (treat your context as a hypothesis, refresh state before concluding) — agent made a model recommendation bounded by what was in his prompt window without pulling adjacent research from his own folder
- **Consensus Filter** (three questions on every external research deliverable, willingness to return "no" to question 3) — agent ran the three questions on every claim but every Q3 came back "yes, adopt" with zero divergence from consensus

Pattern: ritual without bite. The discipline ran as a checklist after conclusions were formed, not as a gate before they could be stated.

## Research Question

**What structural prompt patterns cause an LLM to run a discipline-check as a mandatory pre-output gate during analytical reasoning — not as a ritual post-hoc label, not as a preamble instruction.**

Specifically scoped:
- Analytical conclusion-formation in the reasoning loop, NOT boot-phase compliance
- Mid-reasoning interception, NOT post-hoc labeling
- Lightweight mechanism — must not add heavy required output sections (anti-pattern: hits the ~3-constraint ceiling, causes load-shedding)
- Must work without adding new files every agent has to read on every boot (anti-pattern: instruction surface growth → degradation loop)

Out of scope:
- Boot-phase enforcement (already addressed)
- Generic agent reasoning quality (too broad)
- Multi-agent orchestration (separate research thread)

## Survey Targets

Investigate at minimum:

1. **State machine variants for reasoning loops** — beyond StateFlow's boot-phase usage, do state machine patterns exist that gate analytical conclusions on completion of a discipline check? Cite empirical results if available.

2. **Two-pass / critique-revise architectures** — Constitutional AI, Self-Refine, ReAct critique passes. Which empirically intercept conclusion-formation rather than merely labeling completed conclusions? Cite benchmark deltas.

3. **Output-format gates** — patterns where the conclusion cannot be emitted until a specific intermediate artifact is produced. Distinct from "required output sections" (anti-pattern). Look for mechanisms where the gate is structural to the reasoning loop, not appended to the deliverable.

4. **Conclusion-prompt anatomy** — research on how the prompt structure around conclusion-formation differs from prompt structure around task initiation. Position exploitation at the point of conclusion (not just at start/end of full prompt).

5. **Adversarial / devil's advocate patterns** — does an explicit "argue against your own conclusion before stating it" sub-prompt empirically intercept consensus drift? Cite results.

6. **Verifier-prover separation** — patterns where one model (or one model pass) generates and a second verifies before the conclusion is published. Distinguish where this empirically beats single-pass with self-criticism.

7. **Anything more recent than April 2025** — this is a fast-moving area. Surface 2025-2026 papers, blog posts, production deployment patterns from major labs (Anthropic, OpenAI, DeepMind, Meta) where they discuss reasoning-loop discipline enforcement.

## Required in the deliverable

Per `Trey.OutputStandards`:

1. **Executive summary** — top recommendation with confidence level. What is the lightest-weight mechanism that empirically intercepts conclusion-formation?
2. **Landscape matrix** — mechanism | source | empirical evidence | weight (lightweight ↔ heavy) | failure modes | recommendation for Velorin
3. **Anti-patterns** — what does the literature show DOES NOT WORK for mid-reasoning rule activation? Especially flag anything we've already documented in the Velorin corpus.
4. **Velorin-specific recommendation** — given Velorin's stack (Claude Desktop Code agents, sub-agent spawning, MCP tooling, file-based identity docs), what is the concrete prompt pattern to deploy? Include a worked example showing the pattern in action on a Consensus Filter check.
5. **Cost estimate** — token overhead per conclusion when the pattern is active. We need this to evaluate viability at scale.
6. **Confidence-weighted conclusions** — 80% minimum threshold per recommendation.
7. **Sources** — scholarly preferred. 2025-2026 sources prioritized.

## Output Standards (mandatory)

- All math in plain-text LaTeX text per `Trey.OutputStandards.md` §2.3. Never Equation Editor. Never images of equations.
- Apply your own meta-awareness per `Trey.OutputStandards.md` §2.2a — Velorin agents will apply Consensus Filter to your output. Flag where the consensus you describe exists for historical accident vs. mathematical/cognitive necessity. The strongest pointers for Velorin are the historical-accident consensus where our edge requires we diverge.

## Cross-Reference

This research will be cross-referenced against `Claude.AI/TODO.RuleActivationGap.md` when delivered. That file contains the existing Velorin findings on the gap and the validated mechanisms already in our corpus. Do not duplicate what is already there — extend it.

[VELORIN.EOF]
