---
class: research-request
priority: CRITICAL
assigned: Jiang
requested-by: MA + Alexander
date: 2026-03-30
---

# Research Request: Intake Test Design

## Why This Is Critical Path

The intake test is the spec for the brain schema. Without it, Velorin cannot onboard a second user. Every architecture decision we make about brain regions, layers, and neuron schema affects what the intake test can populate. This is the hardest design problem in the company and the most important one.

**The central question:** Can we design an intake experience that fills Layers 1-3 in 60-90 minutes and produces first-session cross-domain output — for a user with NO prior psychometric history?

---

## What Standard Intake Captures (and Why It's Insufficient)

Standard intake captures: facts, history, preferences, goals.

Velorin intake must ALSO capture:
- How this person reasons under uncertainty
- What domains they systematically underweight
- How they respond to conflict between boxes (e.g., professional opportunity that conflicts with health)
- What their exit patterns look like (how they leave difficult situations)
- What their cognitive blind spots are

---

## Draft Intake Components (from brainstorm — Jiang, validate and expand)

**Component 1: Turing Vault (IQ calibration)**
Already partially designed. Scores cognitive acuity and calibration. Populates Layer 1. Jiang has existing research on this.

**Component 2: Behavioral Profile (DISC-equivalent)**
For users without existing DISC data, the intake must produce an equivalent behavioral profile. Research question: What is the minimum structured interview or scenario set that produces a reliable behavioral profile without a formal DISC administration?

**Component 3: Five-Box Mapping Exercise**
A structured scenario where the user maps their life domains. Not asking "what are your five boxes" — presenting decision scenarios that reveal how they naturally partition their world. Populates Layer 2 (Hard Memories — structural facts about their domains).

**Component 4: Decision Scenario Series (the novel component)**
A structured series of decisions designed to reveal reasoning patterns. Not questions about past events — active choices made during the intake. Each decision reveals: how they weight short vs long-term, which box they default to under pressure, how they respond to ambiguity.

---

## Research Questions for Jiang

1. **Precedent search:** Has any product successfully compressed a clinical-equivalent intake into a 60-90 minute experience? What are the best examples? What did they capture? What did they miss?

2. **Psychometric compression:** What is the minimum number of questions/scenarios needed to produce a reliable DISC-equivalent behavioral profile? Any research on abbreviated versions of validated instruments?

3. **Reasoning pattern elicitation:** How do structured decision scenarios compare to direct interview for revealing cognitive blind spots? Any cognitive science research on scenario-based personality assessment?

4. **First-session value threshold:** What is the minimum brain state (how many facts populated) needed before a Claude model can produce cross-domain synthesis that a human advisor could not? Is there research on this threshold?

5. **CT's existing data:** CT has WAIS-IV, DISC, clinical interview from 2017. What is the minimum structure needed to format this into brain neurons for Layers 1-3? This is the shorter-path problem for CT himself — can Jiang create a migration spec?

---

## Deliverable

Jiang research report: `Jiang.Topic.IntakeTestDesign.md`

Contents:
- Findings on all five research questions
- Recommended intake architecture (components, sequence, estimated time)
- What the intake produces vs what it cannot produce
- CT's existing data migration spec (Layer 1-3 population from topline_profile.md + clinical history)
- Confidence ratings on each finding

**Timeline:** This is Priority 1 research. Begin immediately after Brain Analysis work is complete.

[VELORIN.EOF]
