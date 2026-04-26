---
file: Trey.ResearchRequest.VerifierBenchmarkMethodology.md
purpose: Identify benchmark methodologies, evaluation frameworks, and existing tooling that production constrained-decoding systems use to evaluate verifier model selection. Velorin needs this for its ATV verifier model selection (1-3B parameter class — Qwen2.5-0.5B, SmolLM2-1.7B, fine-tuned Phi-2, etc.).
type: Trey functional research request (NOT novelty audit)
date: 2026-04-26
priority: MEDIUM — informs a Stage 1 build component (ATV verifier benchmark suite)
mode: Discovery — find what production systems use; assume the frame may miss tooling Velorin should adopt rather than reinvent
assigned-to: Trey 1 (general deep research)
confidence-threshold: 75% minimum (this is functional research; no math claims to validate)
filter-note: Consensus Filter applies — the goal is to find what the ecosystem does and adopt rather than reinvent. Q3 (does Velorin share the constraint) is straightforward here: yes, Velorin is building a constrained-decoding verifier deployment.
---

# Research Request — Verifier Model Benchmark Methodology for Constrained-Decoding Deployments

## Background

Velorin is building the Asymmetric Transport Verifier (ATV) as a Stage 1 architectural component (see `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.ATVMathProperties.md` and `Claude.AI/Bot.Trey/Research_Complete/Trey.Research.IESImplementationArchitecture.md`). The verifier is a small local LLM (1-3B parameter class) that runs FSM-constrained decoding on inter-agent analytical messages to enforce the IES (Independent Evaluation Standard) format.

Erdős's math (`Erdos.Solution.ATVMathProperties.md` Section 8) establishes that latency is dominated by the verifier model's tokens-per-second on Mac Studio M4 Max with MPS backend. Format compliance is mathematically guaranteed under any well-formed FSM grammar regardless of the underlying model. Practical model selection therefore depends on:
- Throughput (tokens per second on Mac Studio M4 Max)
- False-reject rate (verifier fails to produce valid IES on legitimate analytical content)
- Edge-case handling (long inputs, mixed content, stylistic variation)
- Memory footprint (must fit alongside other Mac Studio workloads)

Candidate models include Qwen2.5-0.5B, SmolLM2-1.7B, fine-tuned Phi-2, and any other small models the ecosystem has validated for this class of work.

Velorin's founding thesis (per locked memory): the benchmark is a program we build, not an AI judgment exercise. The program runs candidate models against a representative analytical-output suite, measures throughput / false-reject / edge-case behavior, and outputs a deterministic winner. The AI's job is to audit the benchmark's design and watch its outputs over time — not to manually score model outputs per-event.

This research informs the benchmark's design: what methodologies have production constrained-decoding systems used to evaluate verifier model selection? Velorin wants to adopt the patterns the ecosystem has validated rather than invent the benchmark from scratch.

## Specific Research Questions

1. **Existing benchmark frameworks for constrained-decoding evaluation.** What benchmark suites, evaluation harnesses, or open-source tools exist for measuring constrained-decoding verifier performance? Examples to investigate: Outlines (dottxt-ai/outlines), Guidance (microsoft/guidance), LMQL, JSONFormer, OpenAI JSON-mode evaluation methodologies, lm-evaluation-harness extensions for grammar compliance. For each: methodology summary, what it measures, what it doesn't.

2. **Benchmark composition for analytical-output verification.** How do production systems construct representative input suites for verifier evaluation? Specifically for verifiers that must handle long-form prose with structured-output requirements (not just JSON, not just code). What's the standard practice for ensuring suite coverage of edge cases (long inputs, mixed-language content, malformed input handling)?

3. **Throughput vs accuracy trade-off methodology.** When evaluating small models (1-3B parameter class) for constrained-decoding deployment, what's the standard methodology for quantifying the throughput vs accuracy trade-off? Are there established metrics (e.g., "valid outputs per second" vs "valid outputs per token") or operational frameworks (Pareto-frontier analysis, cost-per-correct-output) that production systems use?

4. **False-reject rate measurement.** False-reject rate (verifier rejects legitimate analytical content as malformed) is the operational metric Velorin cares most about. How do production systems measure this? What labeling protocols, ground-truth construction methods, or human-in-the-loop scoring patterns are standard?

5. **Hardware-specific benchmarking on consumer Apple Silicon.** Velorin runs on Mac Studio M4 Max with MPS backend. What benchmarking tools, model-quantization patterns, or deployment frameworks are validated for small-LLM inference on Apple Silicon specifically? llama.cpp Metal? MLX? PyTorch MPS? What does the ecosystem use for this hardware class?

6. **Operational monitoring patterns.** Once a verifier model is deployed, how do production systems monitor its ongoing performance for drift (model behavior changing as input distribution evolves)? What telemetry, sampling strategies, or alerting patterns are standard?

## What Would Constitute a Useful Finding

For each research question above, deliver:

1. The state of the art in production deployments (named tools, frameworks, methodologies)
2. A specific recommendation Velorin can adopt directly (don't recommend "build your own benchmark from scratch" if a viable framework exists)
3. Any caveats about the recommended tool/methodology (known limitations, version-stability concerns, license concerns)
4. The MINIMUM viable benchmark suite Velorin would need to construct on top of any adopted tool

Do NOT audit any of these tools for novelty — Velorin will adopt established patterns. The research is functional: what does the ecosystem use, and what should Velorin reuse?

## Output Standards

All math in plain-text LaTeX per `Trey.OutputStandards.md` §2.3. Never Equation Editor. Never image-math.

## Consensus Filter

Q1 (consensus): name what the production ecosystem has validated for each research question above.
Q2 (why): identify the operational constraints that drove the consensus.
Q3 (Velorin alignment): straightforward — Velorin is deploying a constrained-decoding verifier on Apple Silicon at a 1-3B parameter scale. Velorin shares the constraints. Adopt the consensus tooling unless a specific Velorin-only constraint requires deviation.

## File Naming on Delivery

`Trey.Research.VerifierBenchmarkMethodology.md`

Place in your Drive shipping folder.

[VELORIN.EOF]
