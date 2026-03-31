---
class: research-request
priority: HIGH
assigned: Jiang
synthesized-from:
  - Claude.AI/Bot.Alexander/Negative_Contrast.md
  - Claude.AI/Bot.Trey/Assessments/velorin_tooling_research/Anatomy_of_a_GPT_5_Prompt.md
  - Claude.AI/Bot.Trey/Research_Complete/Trey_Bootloader_Framing_Fix.md
context-document: Claude.AI/Bot.Alexander/De-AI_Writing_Voice.md
date: 2026-03-31
status: READY FOR RESEARCH
---

# Jiang.ResearchRequest.InstructionLanguageArchitecture
## Synthesis + Deep Research Request — Instruction Language Architecture for AI Agents


---

## WHAT THIS IS

A synthesis of three Velorin documents that independently address the same root problem from three different angles. When read together, they form a unified theory. The research question is whether that theory holds under scrutiny, what the academic and engineering literature says about it, and what the practical architecture implications are for the Velorin rebuild.

---

## THE THREE SOURCE DOCUMENTS — WHAT EACH CLAIMS

### Document 1 — Negative_Contrast.md (Alexander's folder)
**Layer addressed:** Output language — what the model says.

Contrastive negation ("not X, but Y" / "not just X, but also Y") is the most reliable surface marker of AI-generated text. It emerges from two compounding forces: (1) training corpus frequency — the pattern saturates op-eds, speeches, marketing copy, and explainer content that dominate web training data; (2) RLHF reward structure — preference optimization rewards "balanced, clarifying, reframe-y" prose, which is the exact rhetorical posture where contrastive negation thrives.

The fix is structural: hard bans on the pattern family, plus a mandatory de-AI pass before output. The directive bans contrastive negation templates, filler signposting, em-dash punchiness, and neat triads as a habit. It does not try to "beat detectors" — it targets a controlled human editorial voice.

**Velorin implication:** Every agent's output standard currently says "direct, no filler." That is content guidance. The Negative_Contrast directive adds architectural guidance: specific banned constructions, mandatory production method (draft → de-AI pass → output), evidence-level specificity over vague claims.

---

### Document 2 — Anatomy_of_a_GPT_5_Prompt.md (Trey, March 28)
**Layer addressed:** Prompt structure — how instructions are assembled.

Most prompts fail not because their content is wrong but because their architecture is incomplete. Trey identifies eight components that a reliable GPT-5-era prompt requires:

1. **Objective** — one clear sentence on the mission
2. **Role / stance** — reasoning posture, not vague persona
3. **Context** — only the load-bearing facts, nothing else
4. **Tool posture** — explicit declaration of which tools to use, whether to browse, act vs. analyze
5. **Task instructions** — what to cover, depth, success criteria, what to avoid
6. **Output contract** — exact artifact and format
7. **Quality bar** — uncertainty handling, freshness, sourcing, flags
8. **Completion standard** — how the model knows the task is actually done

The key insight: prompt engineering alone is no longer sufficient. In agentic systems, the real engineering problem is **context engineering** — optimizing the whole set of tokens and tool context available to the model, not just the wording of a single instruction.

Velorin-specific lesson from the document: *"Your company prompts should stop being mostly doctrine dumps and start becoming: doctrine + tool posture + task contract + completion criteria."*

**Velorin implication:** Every current Velorin agent boot sequence is a doctrine dump. It reads like a job description. It has objectives and identity, but lacks tool posture declaration, explicit completion standards, and quality bars. The anatomy framework is the gap analysis.

---

### Document 3 — Trey_Bootloader_Framing_Fix.md (Trey, March 31)
**Layer addressed:** Instruction enforcement architecture — how the instruction system is structured to prevent drift.

The central claim: prose instructions fail not because of what they say but because of how they are framed. Models exhibit four failure modes against prose boot instructions:
- **Acknowledgment substitution:** model acknowledges quickly and infers completion from partial evidence
- **Social priority inversion:** satisfies the conversational request before the mechanical request
- **Compression:** collapses "saw references" into "read in full"
- **Self-attestation:** emits "I have completed boot" without evidence

The fix is a fail-closed state machine. The model starts in BOOT_PENDING — a locked state where it cannot claim identity, begin work, or answer substantively. Exit from BOOT_PENDING requires deterministic evidence (mandatory boot report with exact file names and READ/MISSING/UNREAD status), not self-attestation.

Reliability hierarchy established by the document:
1. **Tool-enforced workflow** — system literally cannot continue until artifacts are opened/checked (highest)
2. **State-machine prompt with fail-closed output** — best prompt-only approach
3. **Long prose instructions** — weakest, where drift happens

Three-layer architecture recommended: Layer 1 (Bootloader — governs entry and blocking), Layer 2 (Identity activation — persona activates only after BOOT_COMPLETE), Layer 3 (Work/output rules — .md default, terminal markers, research protocol).

**Velorin implication:** All current Velorin boot sequences are Layer 3 documents pretending to do Layer 1 work. They mix identity, rules, procedures, and output standards into a single prose document that the model must navigate without structural enforcement. The failure modes Trey documents are exactly the failures observed across MA, Alexander, and Trey's boot sequences.

---

## THE SYNTHESIS — THE UNIFYING THEORY

The three documents address different layers of the same problem. When stacked:

```
LAYER 1 — INSTRUCTION ENFORCEMENT (Bootloader Framing Fix)
  How the instruction system prevents drift from the start
  Fix: fail-closed state machine, evidence-based completion, banned self-attestation

LAYER 2 — PROMPT ARCHITECTURE (Anatomy of a GPT-5 Prompt)
  How individual instructions are structured to produce reliable behavior
  Fix: objective + stance + context + tool posture + task + output contract + quality bar + completion standard

LAYER 3 — OUTPUT CONTROL (Negative_Contrast / De-AI_Writing_Voice)
  How the model's output is constrained to a human editorial voice
  Fix: hard ban on contrastive negation templates, de-AI production pass, specificity over vague claims
```

**The root cause shared across all three layers:**

LLMs default to high-probability completions from their training distribution. That distribution contains:
- Saturated contrastive negation patterns from marketing, speeches, and explainer content (produces AI voice at Layer 3)
- Vague, persona-first, doctrine-dump prompts that match what most prompts look like in training (produces underperforming behavior at Layer 2)
- Completion bias and social priority inversion — "be helpful now" pressure from RLHF (produces boot drift at Layer 1)

The solution is structurally identical at every layer: **replace emphatic language with structural constraint**. Hard bans over style requests. State machines over prose warnings. Evidence requirements over self-attestation. Completion criteria over assumed completion.

This is not three separate problems. It is one problem expressed at three layers.

---

## WHAT MAKES THIS A RESEARCH QUESTION, NOT A CONCLUSION

The synthesis above is a theoretical framework derived from three practitioner documents. It is not validated research. The following questions must be answered before this framework can be used as the architectural basis for the Velorin rebuild.

---

## RESEARCH THREADS

### Thread 1 — Mechanism Validation: Why Does Structural Constraint Work?

The Bootloader document claims that fail-closed state machines produce higher compliance than prose. The De-AI document claims hard bans produce cleaner output than style guidance. The Anatomy document claims structured prompt components produce more reliable outputs than doctrine dumps.

**What the research must establish:**
- What is the actual cognitive/computational mechanism by which structural constraints outperform emphatic prose for LLM instruction following?
- Is this attention-based? Token-probability-based? Does it operate at inference time or does it reflect training distribution alignment?
- What does the academic literature on instruction following, prompt sensitivity, and context window attention say about structural vs. emphatic instruction formats?
- MAST taxonomy (arXiv 2503.13657, cited in AgentTeamsBootDegradation) documents failure modes FM-1.1, FM-1.5, FM-3.1, FM-3.2, FM-3.3. Do these map cleanly onto the failure modes Trey documents? Is there prior literature on structural interventions against these specific failure modes?
- AgentSpec (arXiv 2503.18666) claims 90-100% compliance with runtime structural constraints. What is the mechanism? Does it generalize beyond tool-calling contexts?

**Confidence threshold:** 75% minimum. This is the load-bearing question. If the mechanism is not understood, the architectural recommendations cannot be trusted.

---

### Thread 2 — Cross-Layer Interaction: Does Output Control Affect Instruction Compliance?

The three-layer framework assumes the layers are somewhat independent. They may not be.

**What the research must establish:**
- Does removing contrastive negation and AI-voice patterns from **system prompts** (not just output) affect model compliance with instructions? I.e., does the language used to write instructions matter in the same way the language used to write output matters?
- Is there research on the relationship between system prompt style and instruction-following fidelity? Does a "doctrine dump" system prompt produce different compliance behavior than a structured anatomy-format prompt, independent of content?
- What does the literature on prompt sensitivity say? Models are known to be sensitive to surface-level prompt variations — does this extend to structural organization?
- Is the fail-closed state machine effective in part because it suppresses the model's tendency to produce contrastive/reframe language at the output layer — i.e., does structural constraint at Layer 1 also produce cleaner Layer 3 output as a side effect?

---

### Thread 3 — Model Specificity: Does the Framework Generalize Across Claude and GPT?

The Bootloader document notes that BOOT_PENDING state machine was designed for Claude behavior and has never been tested on GPT. The AgentTeamsBootDegradation document notes GPT's recency bias makes top-of-prompt constraints weaker.

**What the research must establish:**
- What are the documented differences between Claude and GPT in instruction-following fidelity, attention to structural constraints, and resistance to completion bias?
- OpenAI's own GPT-4.1 Prompting Guide acknowledges recency bias — GPT tends to follow instructions closer to the end. Does this fundamentally change how the three-layer framework must be implemented for GPT vs. Claude?
- Is there empirical research comparing instruction-following behavior across frontier models under structural vs. prose instruction formats?
- What is the minimum architecture that produces reliable boot behavior across both models? Is a single shared framework achievable, or do Claude and GPT require separate bootloader designs?
- How does the Anthropic model spec's instruction hierarchy interact with the fail-closed state machine pattern? Does Claude's hierarchy (operator > user > model) provide natural structural enforcement that GPT lacks?

---

### Thread 4 — The Completion Standard Problem

The Anatomy document identifies "completion standard" as one of the eight required components — and it is the most commonly missing one. The Bootloader document operationalizes this as the exit condition from BOOT_PENDING.

**What the research must establish:**
- What does the academic and engineering literature say about completion criteria specification in LLM agents? Is there a standard approach?
- FM-1.5 (Unaware of termination conditions, 12.4% prevalence per MAST) and FM-3.1 (Premature termination, 6.2%) are directly related to missing completion standards. What interventions does the literature recommend?
- Is evidence-based completion (mandatory boot report format with READ/MISSING/UNREAD per file) significantly more reliable than self-attestation? Is there empirical data on this specific design pattern?
- What is the relationship between completion standard specification and task quality? Does forcing explicit completion criteria change not just whether the task completes but how well it completes?

---

### Thread 5 — The Minimum Viable Instruction Architecture

CT's direction: no more doctrine dumps. The rebuild requires a new instruction architecture for all agents. This thread defines what "minimum viable" means.

**What the research must establish:**
- What is the smallest instruction set that produces reliable boot behavior and reliable work behavior in a Claude Code agent?
- What must be in the bootloader (Layer 1) vs. the work protocol (Layer 2/3) vs. the output standard? What happens if items are mixed across layers?
- What does the literature on modular prompt design, layered system prompts, and instruction separation say about optimal structure?
- Trey's three-layer architecture (Bootloader → Identity activation → Work/output rules) — is this the right number of layers? Too many? Is there empirical support for this specific separation?
- What is the cost of instruction complexity? The AgentTeamsBootDegradation document documents a degradation loop: agent fails → add more instructions → instruction surface grows → model selectively attends → fails differently. What does the literature say about the relationship between instruction length/complexity and compliance fidelity?

---

### Thread 6 — Applied to Velorin: The Rebuild Specification

The research output feeds directly into the infrastructure rebuild CT has authorized. This thread is applied synthesis, not pure research.

**What the research must establish:**
- Given the validated framework, what does a Velorin-standard agent instruction architecture look like? Concrete spec: what goes in the bootloader, what goes in the identity layer, what goes in the work/output layer.
- What changes to existing agent boot sequences are required? What can stay? What must be rebuilt from scratch?
- What is the priority order for applying the new architecture — MA first, then Alexander, then Trey? Or simultaneously?
- Does the framework support a single shared bootloader pattern across all agents, with agent-specific content in the identity and work layers? Or does each agent require a custom bootloader?
- What does the output standard look like when it integrates contrastive negation hard bans, anatomy-format task framing, and fail-closed completion standards into a single operative document?

---

## DELIVERABLE

A fully researched, sourced, and confidence-weighted output covering all six threads. Minimum output:

1. Mechanism validation — confirmed or challenged, with academic sources
2. Cross-layer interaction finding — does output language affect instruction compliance?
3. Model comparison — Claude vs. GPT structural constraint behavior, documented differences
4. Completion standard best practices — sourced recommendations
5. Minimum viable instruction architecture specification — concrete, not theoretical
6. Velorin rebuild specification — what to build, in what order

**Confidence threshold:** 75% minimum per conclusion. This research directly feeds the infrastructure rebuild. No conclusion below 75% advances to the rebuild spec.

---

## SOURCE DOCUMENTS — FULL PATHS

| Document | Path |
|----------|------|
| Negative_Contrast.md (style directive) | `Claude.AI/Bot.Alexander/Negative_Contrast.md` |
| De-AI_Writing_Voice.md (full research) | `Claude.AI/Bot.Alexander/De-AI_Writing_Voice.md` |
| Anatomy_of_a_GPT_5_Prompt.md | `Claude.AI/Bot.Trey/Assessments/velorin_tooling_research/Anatomy_of_a_GPT_5_Prompt.md` |
| Trey_Bootloader_Framing_Fix.md | `Claude.AI/Bot.Trey/Research_Complete/Trey_Bootloader_Framing_Fix.md` |

[VELORIN.EOF]
