# Jiang2 Review Queue — April 24, 2026

**From:** Jiang
**Status:** Pending — Chairman has asked these be flagged but not yet reviewed
**Mode when consumed:** Read in full, evaluate, return discussion to Chairman. Do NOT auto-act.

---

## Four research deliverables ported April 24

All four have been ported to repo, OCR-repaired where needed, KaTeX-fixed, GitHub-render-verified, and the GDrive sources moved to Archive. Request files have been moved from `Research_Needed/` to `Archived_Research_Requests/`.

### 1. Trey — Skills Schema Validation
- **File:** `Claude.AI/Bot.Trey/Research_Complete/Trey.Research.SkillsSchemaValidation.md`
- **Source request:** `Bot.Trey/Archived_Research_Requests/Trey.ResearchRequest.SkillsDependencyGraphValidation.md`
- **What it answers:** Does our flat prerequisite-list YAML schema match GoS, or is it a degraded version with structural gaps?
- **Notable content (from OCR):** Trey introduces a richer schema than what we proposed — typed adjacency matrices for four edge types ($\mathbf{A}_{dep}$, $\mathbf{A}_{work}$, $\mathbf{A}_{sem}$, $\mathbf{A}_{alt}$), weighted multiplex via $\mathbf{M} = \beta_{dep}\mathbf{A}_{dep}^T + \beta_{work}\mathbf{A}_{work}^T + \beta_{sem}\mathbf{A}_{sem} + \beta_{alt}\mathbf{A}_{alt}$, reverse-PPR formulated as $\mathbf{R}_{t+1} = (1-\alpha)\mathbf{P}_{rev}\mathbf{R}_t + \alpha\mathbf{S}$ with $\alpha = 0.15$. Implication: our flat list is likely a Phase-1 degraded version. Apply Consensus Filter — the typed-edge schema is consensus, but does Velorin actually need all 4 edge types at Stage 1, or can we ship the flat version and add types later without retrofit pain?
- **Cross-link:** This is exactly the GoS-edge enrichment Q3 was anticipating. Update Build Guide accordingly.

### 2. Trey — Knowledge Staleness
- **File:** `Claude.AI/Bot.Trey/Research_Complete/Trey.Research.KnowledgeStaleness.md`
- **Source request:** `Bot.Trey/Archived_Research_Requests/Trey.ResearchRequest.TemporalValidity.md`
- **What it answers:** How do production knowledge graph systems detect stale knowledge in fast-changing domains, and what schema primitives does Velorin need?
- **Notable content (from OCR):** Recency weights $\alpha_r$ with limits $\alpha_r \to 1$ and $\alpha_r \to 0$, validity windows $T$, $T'$, decay function $\theta(\tau)$, validity-from timestamps $t_{valid, t_0}$. Likely recommends a recency-weighted retrieval mechanism on top of the existing Ebbinghaus SDE.
- **Cross-link:** This is the Velorin Clock Problem from Jiang2 Session 033 Q7d. The `temporality` field Jiang2 sketched needs to be evaluated against what Trey actually recommends.

### 3. Erdős — Unified Gating Primitive Proof
- **File:** `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.UnifiedGatingPrimitive.md`
- **Source request:** `Bot.Erdos/Archived_Research_Requests/Erdos.ResearchRequest.IESProbabilityShift.md`
- **What it answers:** Trey's Section 10 IES probability shift proof, plus the TAP-IES isomorphism Jiang2 hypothesized in Session 033 Q7a Connection 1.
- **Title implication:** Erdős called it "Unified Gating Primitive Proof" — strongly suggests he proved the isomorphism. The TAP threshold ($\Phi(v) > \theta_{work}$) at the Brain→Skill boundary and the IES probability gate at the Reasoning→Conclusion boundary are likely the same mathematical structure at two layers. If proven, this is a Velorin-native architectural primitive worth naming and elevating.
- **Format:** Zero images, 54 LaTeX lines — clean output, Erdős's Gem instructions inline rule held.

### 4. Erdős — Thresholds and Dark Skill Invariance
- **File:** `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.ThresholdsAndDarkSkillInvariance.md`
- **Source request:** `Bot.Erdos/Archived_Research_Requests/Erdos.ResearchRequest.ThetaWorkAndDarkSkillInvariance.md`
- **What it answers:** Two proofs — (a) principled $\theta_{work}$ derivation (analytical or empirical), (b) dark skill exclusion preserves $\pi$ (PPR-invariance under metadata-only flagging).
- **Format:** Zero images, 48 LaTeX lines — clean.
- **Implication if both proofs hold:** $\theta_{work}$ stops being a guessed 0.5 and becomes a derived constant. The Build Guide can lock the skill-injection runtime.

---

## What Jiang2 should do with this

When Chairman asks for review:

1. Read all four files in full.
2. For Erdős solutions — confirm the proofs hold mathematically. Cross-reference against existing Erdős work (`Erdos.Solution.IndependentMultiplexNormalization.md`, `Erdos.Solution.BridgingDeclarativeProceduralMemory.md`).
3. For Trey solutions — apply Consensus Filter with willingness to answer "no." Does Velorin need the typed-edge GoS schema at Stage 1, or is flat sufficient until proven otherwise? Does the recency-weighted staleness mechanism integrate cleanly with the Ebbinghaus SDE we already have?
4. Update Build Guide for any newly locked math or schema changes.
5. Surface novel synthesis opportunities the same way Session 033 Q7 did — especially around the Unified Gating Primitive if Erdős proved the isomorphism.

Do NOT auto-implement. Discuss with Chairman before any architectural change.

---

## Outstanding research queue (post-port)

- `Bot.Trey/Research_Needed/Trey.ResearchRequest.IESImplementationArchitecture.md` — drafted, NOT yet sent to Trey by Chairman
- All Erdős queue is empty

[VELORIN.EOF]
