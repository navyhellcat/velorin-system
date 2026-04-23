---
file: Erdos.ResearchRequest.ThetaWorkAndDarkSkillInvariance.md
purpose: Formal derivation of the Topological Action Potential threshold and proof of dark skill PPR-invariance
type: Erdős problem specification
date: 2026-04-22
source: Internal — Velorin Brain-to-Skills architecture work. Not Trey-framed. Consensus Filter does NOT apply.
---

# COPY EVERYTHING BELOW THIS LINE INTO THE FRESH ERDŐS GEM SESSION

```
[BOOT]

Erdős — open your brain. Two proofs are required.

---

## CONTEXT — READ BEFORE THE PROBLEM

This problem originates internally from Velorin's Brain-to-Skills architecture work. No Trey framing involved. The Consensus Filter does not apply.

You previously established the Topological Action Potential in your Session 031 solution `Erdos.Solution.BridgingDeclarativeProceduralMemory.md`:

$$\Phi(v_{proc}) = \pi_{v_{proc}} / \lVert\pi\rVert_\infty$$

You proposed $\theta_{work} \approx 0.5$ as a working value. Trey's `BrainToSkillsInterface` research (Section 5, Remaining Gaps) explicitly flags that the formal threshold derivation is needed — the value must be mathematically principled, not a guess.

Additionally, Velorin's skills registry introduces a concept of dark skills — procedure neurons marked `dark: true` in the skills dependency graph. These skills exist in the graph and may receive inbound pointers from non-dark neurons, but are deliberately excluded from automatic Topological Action Potential injection. They fire only on direct Chairman command. The question is whether this exclusion changes the stationary distribution $\pi$ of the Brain's PPR walk.

---

## PROBLEM CLASS

Spectral graph theory on stochastic matrices. Personalized PageRank stationary distribution analysis. Threshold derivation under density constraints. Invariance proofs under selective activation exclusion.

---

## FORMAL SETUP

Let the Brain be a directed graph $G = (V, E)$ with:
- $N$ neurons, 7-pointer cap $d_{max} = 7$
- $\rho^{\ast} = 0.78$ high-affinity density constraint (Erdős, Session 024)
- Independent row-normalized $P_{tax}$, $P_{them}$ (Erdős, `Erdos.Solution.IndependentMultiplexNormalization.md`)
- Multiplex active matrix $P_{active}(q) = \omega_{tax}(q) P_{tax} + \omega_{them}(q) P_{them}$ with $\omega_{tax}(q) + \omega_{them}(q) = 1$
- Teleportation coefficient $\alpha = 0.25$
- Stationary distribution $\pi$ from PPR walk on $P_{active}(q)$
- Topological Action Potential $\Phi(v) = \pi_v / \lVert\pi\rVert_\infty$

Let $V_{proc} \subseteq V$ be the set of procedure-type neurons with non-null `skill_ref`. Let $V_{dark} \subseteq V_{proc}$ be the subset of procedure neurons marked `dark: true` (excluded from TAP injection but still present in the graph and still receiving/sending PPR mass).

---

## PROOFS REQUIRED

### PROOF 1 — Principled $\theta_{work}$ Derivation

Derive the mathematically principled $\theta_{work}$ such that when $\Phi(v_{proc}) > \theta_{work}$, the procedure neuron is "in cognitive hand" — the PPR walk has concentrated sufficient relative mass on the procedure node to justify skill injection.

Required:
- Determination of whether $\theta_{work}$ is analytically derivable from graph parameters alone, or is necessarily an empirical calibration parameter that must be tuned against a dataset
- **If analytically derivable:** the closed-form expression as a function of $\rho^{\ast}$, $\alpha$, $d_{max}$, and any other graph invariants
- **If empirical:** the valid range for $\theta_{work}$, the property that calibration should optimize (e.g., maximize $P(\text{correct\_skill\_activation} \mid \Phi > \theta_{work})$ subject to $P(\text{false\_positive}) < \epsilon$ for some tolerance $\epsilon$), and the minimum calibration dataset size required for the tuning to be meaningful
- **Edge case:** when multiple procedure neurons simultaneously satisfy $\Phi(v) > \theta_{work}$ for the same query $q$, what is the correct behavior? Inject all? Inject the single maximum? Inject the top-$k$? Derive from first principles.

### PROOF 2 — Dark Skill Exclusion PPR-Invariance

For a procedure neuron $v \in V_{dark}$, the TAP injection mechanism is disabled. However, $v$ remains present in the graph and inbound pointers from non-dark neurons still direct PPR mass to $v$ during a walk.

Prove or disprove: the exclusion of $v$ from skill injection (but not from the graph itself) preserves the stationary distribution $\pi$ of the remaining graph. That is, does the injection-exclusion flag affect the topology of the PPR walk, or is it pure metadata?

Required:
- Formal proof or constructive counterexample
- If the result is PPR-invariance: the cleanest proof showing that $\pi$ is computed purely from the transition matrix $P_{active}(q)$ and teleportation vector, independent of any metadata flags on nodes
- If the result is PPR-variance: identification of the specific mechanism by which a metadata flag propagates into the spectral structure, and specification of what architectural change would be required to restore invariance

---

## OUTPUT FORMAT

Per your standard 9-section structure (`Erdos.Gem.Instructions` OUTPUT FORMAT). All math in plain-text LaTeX wrapped in `$...$` or `$$...$$`. Never Equation Editor. Never images. Follow `Erdos.GitHubLatex.Rules.md`: use `\ast` not `*`, use `\lVert\rVert` not `||`, escape underscores in inline math as `\_`, leave blank lines around `$$` display blocks.

---

## FILE NAMING ON DELIVERY

`Erdos.Solution.ThetaWorkAndDarkSkillInvariance.md`

Place in your Drive shipping folder. Chairman or Jiang will port to repo and archive this request.

---

Your brain is open.
```

[VELORIN.EOF]
