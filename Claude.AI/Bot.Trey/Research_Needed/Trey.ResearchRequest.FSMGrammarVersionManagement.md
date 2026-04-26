---
file: Trey.ResearchRequest.FSMGrammarVersionManagement.md
purpose: Identify grammar version-management patterns, regression-suite practices, and existing tooling that production constrained-decoding systems use to evolve FSM grammars over time without breaking deployed inference. Velorin needs this to design the AI-watched grammar-maintenance workflow for the IES grammar.
type: Trey functional research request (NOT novelty audit)
date: 2026-04-26
priority: MEDIUM — informs Stage 1 build component (FSM grammar regression suite + AI-review workflow)
mode: Discovery — find what production systems use; assume tooling exists Velorin should adopt rather than reinvent
assigned-to: Trey 1 (general deep research)
confidence-threshold: 75% minimum
filter-note: Consensus Filter applies. Q3 alignment is direct: Velorin is deploying an evolving FSM grammar against a constrained-decoding verifier; the same lifecycle problems production systems face apply here.
---

# Research Request — FSM Grammar Version Management for Production Constrained-Decoding Systems

## Background

Velorin is building the Asymmetric Transport Verifier (ATV) as a Stage 1 architectural component. The ATV uses an FSM grammar (Finite State Machine grammar) compiled to a DFA over the BPE token graph to enforce the IES (Independent Evaluation Standard) format on inter-agent analytical messages.

Erdős's math (`Erdos.Solution.ATVMathProperties.md`) proves format compliance is mathematically guaranteed under any well-formed grammar. But the IES grammar will evolve as Velorin's analytical-output requirements evolve — new section types, new sub-structures, new tag conventions. Each grammar change must:
- Not break existing analytical outputs that already validate against the prior grammar
- Be testable against a regression suite before deployment
- Have a clear rollback path if production behavior diverges from intent
- Have an audit trail (who changed what, when, why)

Velorin's founding thesis (per locked memory): grammar maintenance is a program-driven workflow with AI as the reviewer, not an AI-judgment-per-change pattern. The workflow is: proposed grammar change → run regression suite → AI reviews test results → approve passing changes / flag failing ones → deploy. The AI doesn't author the grammar or manually score test outputs; the regression suite scores deterministically and the AI applies the deployment decision based on the suite's verdict.

This research informs the workflow's design: what version-management patterns have production constrained-decoding systems validated, and what tooling exists that Velorin should adopt rather than reinvent?

## Specific Research Questions

1. **Version-control patterns for FSM grammars.** How do production constrained-decoding systems (Outlines, Guidance, LMQL, JSONFormer, OpenAI structured-outputs, Anthropic tool-use specifications, Llama Guard, etc.) version their grammars? Is each grammar version a Git artifact? A schema-registry entry? An immutable hash-addressed object? What's the standard practice and why?

2. **Regression suite construction for grammar evolution.** When a grammar changes, what's the standard practice for ensuring the new grammar accepts everything the old grammar accepted (no regressions) and correctly rejects new patterns intended to be rejected (additive changes work as intended)? What test-construction frameworks, fixture-management patterns, or property-based testing strategies are used in production?

3. **Backward compatibility and migration.** When a grammar change is non-additive (a previously-accepted pattern is now rejected, or vice-versa), how do production systems handle the migration? Specifically: in-flight requests using the old grammar, downstream consumers expecting the old format, and rollback if the new grammar produces unexpected operational behavior.

4. **Grammar deployment patterns.** Are grammar changes deployed atomically (single-version-active), with shadow-mode (new grammar runs in parallel for observation before going live), or canary (small fraction of traffic uses new grammar)? Which is standard for which class of system?

5. **Audit and provenance.** How do production systems track who proposed grammar changes, what review process the change went through, what test results justified the change, and when the change went live? Are there established patterns (ADR-style change records, schema-registry audit logs, GitOps workflows)?

6. **AI-assisted grammar review.** Are there published patterns for AI-assisted review of grammar changes (where an AI reviews proposed changes against a regression suite and applies a deployment decision)? If yes, what frameworks or tooling exist? If no, why not — and is there an obvious reason Velorin's intended pattern wouldn't work?

7. **Failure mode catalog from production deployments.** What specific failure modes have production constrained-decoding systems experienced from grammar versioning gone wrong? Concrete examples preferred (vendor postmortems, blog posts, conference talks, GitHub issue threads). The goal is to build a regression suite that explicitly tests for known failure modes the ecosystem has already documented.

## What Would Constitute a Useful Finding

For each research question above, deliver:

1. The state of the art in production deployments (named tools, frameworks, patterns, postmortems)
2. A specific recommendation Velorin can adopt directly
3. Any caveats (license concerns, version-stability, scaling concerns)
4. The MINIMUM viable workflow Velorin would need to construct on top of any adopted tool

Do NOT audit any of these patterns for novelty — Velorin will adopt established patterns. The research is functional: what does the ecosystem use for this lifecycle problem, and what should Velorin reuse?

## Output Standards

All math in plain-text LaTeX per `Trey.OutputStandards.md` §2.3. Never Equation Editor. Never image-math.

## Consensus Filter

Q1 (consensus): name what production constrained-decoding deployments use for each research question.
Q2 (why): operational constraints that shaped each pattern.
Q3 (Velorin alignment): direct — Velorin has the same lifecycle problem (evolving FSM grammar against deployed verifier with downstream consumers depending on stable format). Adopt the consensus tooling unless a Velorin-specific constraint requires deviation.

## File Naming on Delivery

`Trey.Research.FSMGrammarVersionManagement.md`

Place in your Drive shipping folder.

[VELORIN.EOF]
