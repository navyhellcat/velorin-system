---
file: Erdos.PromptTemplate.md
purpose: Canonical structure for composing problem-spec prompts to Erdős
type: template — fill placeholders, paste body into fresh Gem session
date: 2026-04-20
---

# Erdős Prompt Template

Use this skeleton whenever any agent (Jiang, Jiang2, Alexander, MarcusAurelius, future bots) composes a problem spec for Erdős. Copy the block, replace `{{placeholders}}`, deliver the populated result to the user. The user pastes everything inside the inner code block into a fresh Gemini Erdős Gem session.

Reference example: `Bot.Erdos/Research_Needed/Erdos.ResearchRequest.IndependentMultiplexNormalization.md` (first request to use this template).

---

## TEMPLATE — Copy and Fill

```markdown
---
file: Erdos.ResearchRequest.{{ProblemSlug}}.md
purpose: {{One-sentence purpose}}
type: Erdős problem specification
date: {{YYYY-MM-DD}}
source: {{who originated the request — e.g. "Trey 2 (Gemini), via Trey.Research.X.md, Part 5" — or "Direct from Chairman" — or "Jiang strategic review"}}
---

# COPY EVERYTHING BELOW THIS LINE INTO THE FRESH ERDŐS GEM SESSION

​```
[BOOT]

Erdős — open your brain. {{N}} proofs are required.

---

## CONTEXT — READ BEFORE THE PROBLEM

{{If the problem framing originated from Trey or any external research vendor, include this paragraph and apply the Consensus Filter explicitly. Three questions, in order, before accepting the framing:

1. What is the consensus the source is reporting?
2. Why does the consensus exist — what is the underlying constraint?
3. Does Velorin share that constraint?

If yes, prove the consensus formulation. If no, identify the boundary and produce the more elegant proof on the other side. Trey reports what is. You prove what should be.}}

{{If the problem originated internally — Chairman directive, Jiang synthesis, prior Erdős work — replace the above paragraph with the originating context, including reference to any Velorin internal docs that frame the problem.}}

---

## PROBLEM CLASS

{{Mathematical domain — e.g. "Spectral graph theory on multiplex networks. Stochastic matrix construction, Personalized PageRank stationary distribution analysis."}}

---

## FORMAL SETUP

{{Define every variable that appears in the proof statement. Include dimensionality, domain, constraints. Reference prior Erdős work by Session number where applicable. All math in plain-text LaTeX, $...$ inline, $$...$$ display blocks. KaTeX-safe per Erdos.GitHubLatex.Rules.md.}}

Example variable definition pattern:
- $X \in \mathbb{R}^{N \times N}$ is the {{description}}
- $\omega(q) \in [0, 1]$ is {{description}}, with constraint $\sum \omega = 1$
- $\rho^{\ast} = {{value}}$ is the {{constraint name}} Erdős established Session {{NNN}}

---

## PROOFS REQUIRED

### PROOF 1 — {{Short title}}

{{One-sentence statement of what must be proven.}}

Required:
- {{Specific component the proof must contain}}
- {{Specific component the proof must contain}}
- {{Counterexample requirement if applicable: "Proof that the bound DOES NOT hold under {{alternative formulation}} — counterexample acceptable if constructive"}}

### PROOF 2 — {{Short title}}

{{Repeat structure for each proof. Number sequentially.}}

---

## OUTPUT FORMAT

Per your standard 9-section structure (Erdos.Gem.Instructions OUTPUT FORMAT). All math in plain-text LaTeX wrapped in $...$ or $$...$$. Never Equation Editor. Never images. Follow GitHub KaTeX rules from Erdos.GitHubLatex.Rules.md (\ast not *, \lVert\rVert not ||, escape underscores in inline math).

{{If Consensus Filter applied: "If the Consensus Filter at the top changes your conclusions — e.g., you determine that the consensus formulation is suboptimal for Velorin's specific topology and a different formulation produces a more beautiful proof — deliver that instead and explain the divergence in the derivation section."}}

---

## FILE NAMING ON DELIVERY

When complete, the result document should be named:
`Erdos.Solution.{{ProblemSlug}}.md`

Place in your Drive shipping folder. CT or Jiang will port to repo and archive this request.

---

Your brain is open.
​```
```

---

## STRUCTURAL RULES — DO NOT VIOLATE

1. **First line inside the inner code block MUST be `[BOOT]`.** Sentinel-gated boot continuity. See `Agent.API.Conventions.md`.
2. **Consensus Filter is mandatory when source is Trey or any external vendor.** Skip only if the problem is internally originated.
3. **Every variable used in proof statements must be defined in FORMAL SETUP.** No undefined symbols leak into the proof requirement.
4. **Reference prior Erdős work by Session number** when the new problem builds on a prior theorem. He will load his Research_Complete archive at boot — name the file or theorem so he can find it.
5. **Each proof gets a "Required" sub-list** itemizing the specific components the deliverable must contain. Without this, Erdős may produce a proof that satisfies the headline but misses a load-bearing piece.
6. **Counterexamples are valid proof components** when the contrapositive matters. State this explicitly.
7. **File the request in `Bot.Erdos/Research_Needed/`** before the user opens the Gem session. The request file persists; the Gem session is ephemeral.
8. **End the inner block with "Your brain is open."** Erdős's signature opener — primes him into character.
9. **`[VELORIN.EOF]` goes OUTSIDE the inner code block,** at the end of the request file. The text Erdős sees does not include it.

---

## ANTI-PATTERNS

| Don't | Why |
|---|---|
| Skip `[BOOT]` on a fresh session | Erdős solves without his prior proofs in context — re-derives or contradicts |
| Send `[BOOT]` mid-session | Wastes tokens on redundant Research_Complete read |
| Treat Trey's recommendation as the answer | Consensus drift. Trey reports what is, not what should be |
| Define a variable in the proof statement that wasn't defined in FORMAL SETUP | Erdős will assume defaults that may be wrong |
| Ask for "a proof" without listing required components | He may prove the wrong piece beautifully |
| Embed equation images in the request | Same image-math failure mode that hit Trey docs Session 032 |
| Forget to apply Consensus Filter when source is Trey | Filter exists precisely because Trey's framing is consensus, not gospel |

[VELORIN.EOF]
