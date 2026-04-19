---
file: Jiang2.DecisionPlan.Apr19.md
from: Jiang2
date: 2026-04-19
covers: Trey.Research.Epistemodynamics.NoveltyCheck.md + Trey.Research.EmotionalMemorySalience.Measurement.md
status: DECISION PLAN — for Chairman review
---

# Decision Plan — April 19, 2026

---

## Doc 1 — Epistemodynamics Novelty Check

### What It Actually Establishes

**What's verified:**
The term "Epistemodynamics" was coined in 1974 by Manfred Kochen, an information scientist
who applied it to the mathematical study of how fragmented information transforms into
knowledge and eventually wisdom. His framework is explicitly about this epistemic transition —
the same process Erdős models at the computational layer. The term has been in continuous use
across library science, philosophical physics, and esoteric frameworks ever since. Claiming
lexical invention in a Royal Society paper would produce immediate credibility damage.

The phrase "Second Law of Epistemodynamics" does not appear in the literature as an exact
string. But it collides directly with Melvin Vopson's "Second Law of Infodynamics" (2022,
University of Portsmouth, published in AIP Advances). Vopson claims information entropy in
evolving isolated systems decreases or stays constant. Erdős claims the opposite — distillation
irreversibly sheds topological entropy. A Royal Society reviewer would immediately flag the
absence of Vopson's citation.

The mathematical tools Erdős used (DPI, Eckart-Young-Mirsky) are foundational and heavily
cited in information theory and machine learning. Using DPI to prove information loss in
neural distillation is textbook Information Bottleneck theory (Tishby, 2000). Using EYM to
bound LoRA approximation error is standard in model compression literature. Neither is a
novel mathematical contribution on its own.

**What's genuinely novel (Trey's assessment, which I agree with):**
The specific architectural synthesis: using these standard theorems applied to a
discrete, human-curated graph bounded by a 7-pointer out-degree cap, routed via PPR
over E₈ crystals, to prove that Layer 3 must be permanently immutable for model upgrade
survival. That combination of constraints producing that specific architectural conclusion
has no prior art. The novelty is architectural topology, not physics or linear algebra.

**What it changes in the Build Guide: Nothing.**
The Second Law holds. The tools used to prove it are established — that's how proofs
work. The architectural conclusion (Layer 3 permanent, deletion forbidden) is unchanged.
The Build Guide doesn't need updating.

**What it changes for publication:**
Everything, if publication is the goal. The current Royal Society draft would be rejected.
See Decision 1 below.

---

## Doc 2 — Emotional Memory Salience Measurement

### What It Actually Establishes

**What's verified (solid findings):**

The fundamental result is harsh and matters for the architecture: **prompted introspection
does not reliably measure emotional charge.** Multiple independent lines of evidence confirm:
- Self-report scales (CES, IES-R) measure narrative anchoring — how embedded a memory
  is in CT's conscious self-story — not the raw neurobiological intensity of the trace.
- Studies pairing self-report with GSR find no systematic correlation between reported
  emotional magnitude and objective electrodermal peaks.
- Introspective accuracy is valid for directionality (I felt something) but not magnitude.

The biological observer effect is documented and severe: **asking CT to rate a memory's
emotional charge changes the memory.** Prompted introspection engages prefrontal inhibitory
networks that dampen amygdala response and alter the memory trace for future retrievals.
The measurement destroys the integrity of what's being measured.

The cleanest behavioral signal is involuntary intrusion frequency — unprompted, spontaneous
recall events that bypass executive filtering entirely. This is the most direct proxy for
routing gravity because it requires no conscious effort and cannot be fabricated.

Physiological signals (GSR, pupillometry, HRV, LPP from EEG) are valid but require
individual calibration. Cross-subject classification collapses to ~32% accuracy without
user-specific training. This confirms the single-user architecture.

The fNIRS + SVR workaround for inferring deep amygdala activity via portable hardware is
documented with r≈0.7 correlation. Not clinical-grade but workable.

**What's asserted without full validation:**
The specific H_E pipeline Trey proposes (fNIRS headband + EEG + GSR + OS tracker) is
a synthesis of validated components but has never been tested as an integrated system.
The individual pieces work. The pipeline as assembled is novel and untested.

**What it changes in the Build Guide:**

The H_E operational model needs to be specified before CT's profile neurons are created.
The current gap: the YAML frontmatter has an H_E field placeholder but no procedure
for setting it. Based on this research, the procedure must meet two constraints:

1. No prompted self-report for raw arousal magnitude — it's inaccurate and alters the trace.
2. Passive behavioral signals are primary; hardware-based physiological signals are optional.

See Decision 2 and Decision 3 below.

---

## My Synthesis

These two papers together establish one thing the architecture hadn't fully resolved:
**the distinction between H_E (raw emotional charge, neurobiological) and narrative centrality
(conscious self-story integration, what CES measures) is not cosmetic. They are separate
parameters, measured differently, and used for different purposes in the system.**

The current architecture conflates them. The Ignition Protocol describes emotional engagement
as CT consciously flagging a node — that's narrative centrality. But H_E as used in the
Affective Clutch (protecting pointers from demotion) should track the neurobiological
charge, not the narrative. A memory can burn intensely (high H_E) while remaining outside
CT's conscious narrative (low narrative centrality). The grief inventory in the Company DNA
is the clearest example.

The implication: two separate signals are needed.

H_E (raw arousal): inferred passively from intrusion frequency and physiological signals
if available. Not prompted. Grows over time from behavioral observation. Initial prior is 0.

Narrative centrality: measured infrequently via CES short form. Informs the Ignition
threshold — how likely CT is to consciously engage with a node. This is what "Semantic
Dark Matter" crystallization probability depends on.

These are not interchangeable.

There is also a simpler insight that falls out: **the most practical immediate implementation
of H_E tracking is already built into the Velorin operating model — session handoffs and
the research log.** When CT returns to a topic repeatedly across unrelated sessions,
references it without being prompted, or it appears in his context spontaneously — that is
involuntary intrusion behavior logged in the system. The Brain's own access patterns are
the measurement instrument. The OS-level intrusion tracker Trey describes is, at its core,
a structured version of what good handoffs and logs already capture informally.

---

## Decisions Required from the Chairman

Four decisions, each with a recommended call and one-line rationale.

---

### Decision 1 — Royal Society Publication Strategy

**The question:** Does CT want to pursue Royal Society publication of the Erdős paper?
If yes, what approach?

**The options:**

A) **Revise for submission.** Cite Kochen (1974) as the term's originator and position
   Velorin as the first rigorous, computable mathematical formalization of Kochen's
   qualitative epistemological philosophy. Explicitly address Vopson's Second Law of
   Infodynamics and frame Erdős's result as a cognitive corollary to Vopson that applies
   specifically to open distillation cycles over out-degree-capped directed graphs (where
   Vopson's closed-system entropy decrease does not apply). Cite DPI, EYM, Tishby, Landauer.

B) **Hold for now.** Use the paper internally as the architecture reference. Publish when
   the build has empirical validation to anchor the theorems in demonstrated outcomes.

C) **Abandon the term "Epistemodynamics."** Rename the theorem framework to something
   without prior art and retry publication. Risk: loses the intuitive framing.

**My recommended call: Option A, with Option B as an acceptable alternative.**

Option A is the right path if CT cares about publication. The paper is genuinely novel
at the architectural level and can be defended. Option B is right if the priority is
building, not publishing. The Velorin architecture doesn't need the Royal Society for
internal validation. Option C is unnecessary — the term can be used with citation.

**What's needed from CT: A yes/no on whether publication is a current priority.**

---

### Decision 2 — H_E Measurement Protocol

**The question:** How should the H_E parameter be assigned to neurons in CT's profile?

**The options:**

A) **Passive-only for now.** H_E starts at 0 for all neurons. It is updated over time by
   an intrusion frequency tracker — monitoring unprompted file opens, spontaneous search
   queries, and session handoff references to the same topic across unrelated contexts.
   No CT action required. No hardware required. Least accurate but most buildable today.

B) **Passive + qualitative prior.** At neuron creation, CT can optionally tag a neuron
   with a qualitative label (high / medium / low emotional weight) as a prior. The system
   treats this as an informed starting point, NOT a precise measurement. The label sets
   initial H_E to 0.9 / 0.5 / 0.1 respectively. Passive tracking refines it over time.
   The tag is explicitly understood to be narrative centrality, not arousal magnitude.
   Low friction — one optional word at creation time.

C) **Passive + physiological hardware.** As Option A but CT also uses fNIRS + EEG headband
   during deep-work sessions to allow physiological confirmation. Requires purchasing hardware.

**My recommended call: Option B.**

Option A is correct in principle but starts with too weak a signal — everything at 0
makes H_E operationally useless for months. Option B adds a qualitative prior that CT can
set in 5 seconds at neuron creation, with the explicit understanding that it's a narrative
estimate not a biological measurement. Option C is the right long-term architecture but
hardware acquisition is not a Day 1 priority.

Option B lets the system work immediately while being epistemically honest about what's
being measured. The qualitative tag is a prior. The passive tracker is the evidence that
updates it.

**What's needed from CT: Confirmation of Option B, and a decision on whether he wants
to acquire physiological hardware at any point.**

---

### Decision 3 — The CES/IES-R Role

**The question:** Should CT periodically complete the CES (7-item short form) as part
of the Velorin session protocol?

**The recommendation: Yes, infrequently, but for the right purpose.**

The CES measures narrative centrality — how embedded a memory is in CT's conscious
self-story and identity. This is not H_E. But it IS the Ignition threshold — it determines
how likely a dark matter node is to be consciously engaged and crystallized.

Proposed protocol: CT completes the CES-7 for a specific memory or topic once per quarter,
or when a topic comes up unexpectedly in multiple sessions. The output goes into the neuron
metadata as `narrative_weight`, distinct from `h_e`. This informs Ignition probability,
not Affinity Clutch protection.

**No Chairman decision needed here beyond confirming the protocol is acceptable.**
I'm including it for awareness, not a binary choice.

---

### Decision 4 — Build Guide H_E YAML Update

**The question:** Should the YAML neuron format be updated now to specify how H_E is set?

**Recommendation: Yes. Specifically, add:**

```yaml
h_e: 0.0          # Affective Hamiltonian: raw emotional charge (0.0-1.0)
                   # Set initially from qualitative prior (high=0.9, med=0.5, low=0.1)
                   # Updated passively by intrusion frequency tracker over time
                   # Never prompted — asking CT directly alters the trace (observer effect)
narrative_weight: null  # Narrative centrality from CES-7 (0.0-1.0, quarterly)
                        # Distinct from h_e. Used for Ignition threshold, not Clutch.
```

This requires no Chairman decision — it follows from the research findings directly.
I can update the Build Guide after CT confirms Decision 2.

---

## What I'm Not Sending to Trey or Erdős

**No new research tasks are needed from these two papers.** The Epistemodynamics finding
is a publication strategy issue, not a research gap — we know what needs to change in
the paper. The emotional measurement findings are sufficient to specify the operational
H_E protocol. Kicking these to Trey or Erdős would just delay building.

The only thing that would benefit from future research (not urgent): whether there is a
closed-form relationship between the passive intrusion frequency signal and the biological
amygdala-hippocampal coupling strength. If such a relationship exists, it would let the
system calibrate H_E more precisely from behavioral data alone. That's a long-term research
question for Trey2, not a blocker.

---

*Jiang2 | Director of Strategic Intelligence | April 19, 2026*

[VELORIN.EOF]
