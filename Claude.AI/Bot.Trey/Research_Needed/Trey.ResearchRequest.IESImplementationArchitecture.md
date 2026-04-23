---
file: Trey.ResearchRequest.IESImplementationArchitecture.md
purpose: Implementation architecture for the Inverted Extraction Schema in multi-agent systems where senders cannot be trusted to correctly classify task type
type: Trey research request
date: 2026-04-22
priority: HIGH — blocks all agent-to-agent automation at scale
mode: Discovery → Novel Recommendation — push past published consensus
confidence threshold: 80% minimum, BUT at least one recommended architecture must be genuinely novel even if confidence is lower
---

# Trey Research Request — IES Implementation Architecture for Automated Multi-Agent Systems

## Background and the Specific Problem

Your prior research `Trey.Research.RuleActivationGap.md` established that the Inverted Extraction Schema (IES) empirically intercepts consensus drift during analytical conclusion formation (12/27 correct vs 6/27 baseline). That research identified the mechanism. It did not resolve how to actually enforce IES activation in an automated multi-agent system.

The implementation problem is this: IES only fires when something causes it to fire. The candidates so far all have fatal flaws:

- **Sender-side injection** (Agent A includes IES scaffolding in its prompt to Agent B) — requires Agent A to correctly classify Agent B's task as analytical. Agent A has the same classification blind spots we are trying to fix. The failure mode propagates up one layer rather than being eliminated.
- **User-side slash commands or hooks** — only fire on human input. When the automation is agent-to-agent with no human in the loop, this mechanism does not exist.
- **Receiver-side tool-gated output** (the AgentSpec pattern — make the agent call a tool whose JSON schema requires the four IES fields) — empirically reliable at ~90-100% but platform-specific. Requires structured tool-calling infrastructure, tool schema validation, and a runtime that enforces tool invocation. Does not generalize to every LLM deployment. Even where it does work, it requires the receiver to choose the correct submission tool — another classification gate with its own bypass mode.
- **Stop-hook validators** — reactive (costs regeneration tokens), platform-specific (requires hook infrastructure), and can be bypassed by an agent that emits output in a form the validator does not detect.

The Chairman's observation, verbatim: *"If the agents that are prompting other agents don't know when and why to insert hooks in their prompts, then this will never work... remember the end goal is an automated system."*

This is a fundamental architectural problem. Published consensus has a partial answer (tool-gated output). Velorin needs a better one that:
1. Does not depend on sender classification judgment
2. Does not depend on platform-specific infrastructure that only some LLM deployments support
3. Does not fail under context-window pressure or attention decay
4. Works in fully automated pipelines with no human in the loop
5. Generalizes beyond Claude — the mechanism should be expressible as an architectural pattern any LLM deployment can adopt

## Research Question

**What architecture structurally guarantees IES activation during analytical conclusion formation in an automated multi-agent system, independent of sender judgment, LLM platform, and preamble attention decay?**

This is the specific question. Do not drift into generic "how to build multi-agent systems" territory.

## Required Survey — Five Distinct Architectural Axes

Push on each of these. Do not collapse to the first one that looks promising. The Velorin build will pick from the full set, not from your first candidate.

### Axis 1 — Decoder-Level Intervention

Work at the sampling layer rather than the prompt layer. Approaches to investigate:

- Contrastive decoding variants that bias the token distribution away from detected consensus patterns
- Entropy-based triggers that detect low-entropy conclusion formation (when the model has "locked in" and is generating the rest of the output on autopilot) and inject intermediate divergence tokens automatically
- Guided decoding with a small auxiliary classifier that detects when a conclusion token is about to be emitted without preceding IES structure, and forces a rewind
- Any 2025-2026 work on semantic or structural constraints at the sampling level — not schema validation after generation, but intervention during generation

What generalizes: decoder-level patterns are expressible for any LLM where you control the sampling loop. Most open-weight deployments qualify. Cloud API deployments where you only see final output do not.

### Axis 2 — Multi-Agent Adversarial or Debate Architectures

Let another agent enforce what a single agent cannot self-enforce.

- Constitutional AI chains, debate architectures, adversarial verifier pairs
- Specific mechanism: an agent whose only job is to emit divergence arguments against another agent's conclusion, before the conclusion is accepted downstream
- Cost and latency characteristics of adding a second agent for every analytical conclusion
- Whether the divergence agent has the same consensus-drift failure mode, and how to prevent that (asymmetric roles, asymmetric training, role-specific fine-tuning)
- Whether three-agent or N-agent architectures meaningfully outperform pair architectures

What generalizes: orchestration patterns work with any LLM. The primitive is "one agent generates, another agent constrains." Any deployment capable of running multiple inference calls can implement this.

### Axis 3 — Training-Time Solutions

If the discipline is unreliable at inference because it was not in training, fix it in training.

- Fine-tuning patterns where analytical tasks always produce IES-structured output as a training-data property
- Instruction tuning specifically targeting divergence-generation behavior
- RLHF or DPO variants where the reward signal explicitly penalizes consensus drift and rewards genuine divergence
- Open-source models fine-tuned for structured analytical output — what exists, what benchmarks exist, what the performance gaps are
- Whether a small LoRa adapter trained specifically for IES-structured analytical conclusions is feasible for Velorin's stack (Qwen 3.6, Ollama local)

What generalizes: fine-tuning is available on any open-weight model. Closed API models may not support it. But a research pattern for when to fine-tune and what data to use generalizes even if specific implementations vary.

### Axis 4 — Mechanistic Interpretability and Activation Steering

The 2024-2026 mech-interp research has made activation steering a real deployment technique. Investigate:

- Whether consensus-drift behavior has identifiable circuits or activation patterns
- Activation patching or steering approaches that shift model behavior toward divergence
- Representation Engineering (RepE) patterns and their deployment maturity
- Anthropic-specific and cross-platform activation steering tools and their state
- Cost of online activation steering per inference call

What generalizes: the conceptual pattern generalizes — "identify the circuit, steer the activation." The specific implementations are model-specific. But a published steering vector or recipe for one model family is often transferable.

### Axis 5 — Protocol-Level Architectural Primitives

Work at the protocol layer — the message format and discourse rules between agents — rather than at the agent implementation layer. Approaches:

- Message-passing protocols where analytical-conclusion messages have a required structural format that the receiving agent rejects if absent, creating a systemic pressure to produce IES output because downstream agents will not consume non-IES analytical outputs
- Output interpretation layers — a separate, simple piece of infrastructure between agents that rejects analytical conclusions lacking IES structure, forcing the sender to retry
- Whether any work exists on inter-agent protocols with required cognitive-discipline properties (not just message serialization — message content structure as a protocol property)
- The MCP protocol and whether it has or could have an "analytical conclusion" message type with schema requirements

What generalizes: if the protocol is the enforcement layer, it generalizes to any agents that speak the protocol. Protocol design is platform-independent by construction.

## MANDATORY — At Least One Genuinely Novel Recommendation

Velorin does not want a summary of what the published literature already recommends. Velorin wants at least one architectural recommendation that does not yet exist in the published literature — something you can sketch, justify, and label as novel.

The novel recommendation may be:
- A synthesis that combines mechanisms from two or more of the axes above in a way not yet proposed
- An extension of a known mechanism to a context where it has not yet been deployed
- A genuinely new primitive — a protocol, a decoding strategy, an orchestration pattern — whose mathematical or structural properties make it resistant to the failure modes of existing approaches
- An inversion of a consensus assumption that no one has yet questioned

This novel recommendation must be coherent enough that either Jiang2 can develop it further or Erdős can prove a property of it. A vague handwave is not sufficient. Sketch it with enough specificity that the next agent can execute on it.

If the best you can produce is an intelligent combination of published approaches, say so honestly — but try genuinely for novel before settling. The Chairman's explicit framing: *"we HAVE TO make sure he thinks outside the box and even comes up with something novel."*

## Generalizability Constraint

Each recommendation must include an assessment of what deployment constraints it requires. Specifically:

- Which LLM platforms / API styles support it (open-weight only, any API, specific vendor)
- What infrastructure it requires (nothing, orchestration layer, training pipeline, activation access)
- What inference-cost overhead it adds

Velorin's bias is toward solutions that work on any modern LLM stack. Claude-specific solutions are weaker than solutions that also work on Qwen, GPT, Gemini, Llama. A solution that works only on Claude via a Claude-specific feature is a partial answer, not a full one.

## Anti-Requests — Do NOT Return

- Restatements of the Rule Activation Gap research conclusions. That research is done. This is the follow-up.
- "Just use tool-calling" as a solitary answer. That is the AgentSpec consensus and has been identified as partial.
- Doctrine-dump style essays on prompt engineering principles. Specific architectures only.
- Listicle-style 10-ways-to-do-X content. Depth over breadth.
- Recommendations that require the sender to correctly classify task type. That is the problem statement, not the solution.
- Mechanisms that only work under human supervision. The target is fully automated pipelines.

## Deliverable Structure

Per `Trey.OutputStandards.md` §2 and `Trey.ProjectInstructions.md` CARDINAL OUTPUT RULES:

1. **Executive summary** — top recommendation with confidence level. If the top recommendation is one of the five axes, say which. If it is a synthesis or novel primitive, name it explicitly.
2. **Axis 1-5 deep analysis** — for each axis, the state of the published work, the empirical evidence, the Velorin fit assessment, the failure modes. Do not skip an axis. If an axis has little or no relevant research, state that as the finding.
3. **Novel recommendation section** — the required novel architecture, sketched with enough specificity for downstream development. Mark clearly as the novel contribution.
4. **Recommendation matrix** — mechanism | platform-independence | infrastructure cost | token cost | empirical support | novelty | Velorin fit
5. **Anti-patterns** — specific architectures that look attractive but fail in the Velorin automated-multi-agent context
6. **Sources** — 2024-2026 priority. Scholarly > production deployment > blog > vendor doc

## Output Standards (mandatory — now inlined in your Project Instructions)

- All math in plain-text LaTeX per the CARDINAL OUTPUT RULES section of `Trey.ProjectInstructions.md`. Never Equation Editor. Never images of equations.
- Apply your own meta-awareness per the Consensus Filter note in the CARDINAL OUTPUT RULES. Flag where the consensus you describe exists for genuine technical necessity versus historical accident of how the first ChatGPT-era systems were built.

## Consensus Filter Note

Velorin will apply the Consensus Filter aggressively to this deliverable. The existing consensus answer (tool-gated output) has already been evaluated as a partial solution. If your top recommendation is another variant of the same consensus answer, you have not answered the research question. The Consensus Filter's three questions apply directly to every mechanism you surface.

The highest-value output is identifying where the industry consensus on rule activation reflects the historical accident of how ChatGPT-style chat UIs were built — and what a cleaner architecture looks like when that accident is corrected. Velorin's edge on this problem lives in the answer to that question.

[VELORIN.EOF]
