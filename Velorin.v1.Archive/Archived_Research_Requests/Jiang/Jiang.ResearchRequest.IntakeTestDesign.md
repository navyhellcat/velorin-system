---
class: research-request
priority: CRITICAL PATH
assigned: Jiang
requested-by: Christian Taylor (Chairman) — outline authored March 31, 2026
supersedes: original request from MA + Alexander (March 30, 2026), content preserved at bottom
date: 2026-03-31
status: OUTLINE COMPLETE — awaiting CT authorization to begin research sessions
---

# Jiang.ResearchRequest.IntakeTestDesign
## Full Research Plan — Start to Finish

---

## WHAT THIS IS NOT

This is not a solution. Not a recommendation. Not a design. It is a map of everything that must be researched before any design decision can be made. CT has flagged intake as the biggest part of the entire build. The research must reach bottom layers on every thread. No synthesis until the research is complete.

---

## THE CORE QUESTION

What does it actually take to build a complete, useful, actionable profile of a human being — the kind that allows an AI agent system to operate as a genuine extension of that person's intelligence and decision-making — and what are all the ways that profile data can be collected, approximated, or required?

---

## REFERENCE MATERIAL — READ BEFORE RESEARCH BEGINS

Before spawning any research agents, Jiang must read and fully internalize the following. These define the output target — what a complete profile looks like when it exists.

1. CT's full profile documents — locate via Velorin Brain and all Bot folders
2. The five-box governance model — what are the five boxes, what data feeds each
3. All existing documentation of what CT's agents currently know about him (memory files, neuron content, topline_profile.md, clinical history)
4. Jiang.Topic.AgentOrchestration — the profile is the seed data for agent config
5. Jiang.Topic.OASIS — the profile translates into OASIS agent config; the field mapping matters
6. The Velorin Brain — what does it currently store about CT? What is missing?
7. The original MA + Alexander IntakeTestDesign request (preserved below) — specific questions already identified, including the Layer 1-3 population spec

**Research question from this review:** What does a complete Velorin profile need to contain to make the agent system work the way CT intends? Work backward from the output spec, not forward from available instruments.

---

## RESEARCH THREAD 1: WHAT DOES THE PROFILE ACTUALLY NEED TO CONTAIN?

Before asking "how do we collect data," ask "what data do we actually need?"

1.1 What are the five boxes? What specific data lives in each one? What is the minimum viable content per box for it to be functional vs. merely populated?

1.2 What cognitive dimensions are actually load-bearing for the agent system? IQ is one dimension. Working memory, processing speed, verbal comprehension, executive function, pattern recognition, risk tolerance, time horizon, decision style under stress vs. calm — which of these matter for how the system operates on behalf of the user, and which are merely interesting?

1.3 What personality dimensions matter? Not "what does MBTI measure" but "what behavioral and motivational facts about a person does the agent system need to know to act as that person would want?" These may not map cleanly to existing instruments.

1.4 What motivational architecture needs to be captured? Drive, ambition, fear structures, avoidance patterns, core wounds, what the person is running toward vs. running from. Where does this live in existing psychological frameworks? How has it been operationalized?

1.5 What is the trauma layer? How does personal trauma manifest as decision patterns the system needs to know about? What level of granularity is required — does the system need to know what happened, or just how it shaped behavior?

1.6 What relational and social architecture matters? Attachment style, trust patterns, authority relationships, peer dynamics, intimate relationship patterns — which of these affect the agent system's ability to serve the user?

1.7 What operational patterns matter? Sleep/energy cycles, context-switching cost, productive vs. unproductive states, what derails vs. what restores. The system as an operator needs to know when and how the person functions.

1.8 What are exit patterns? CT has specifically referenced this as a critical profile element — how does ADHD manifest as a specific failure mode, and how would exit patterns be captured in intake for other users?

1.9 What can the system learn from the original MA + Alexander spec (Layer 1-3, five-box mapping, decision scenario series)? These are specific design proposals — research must validate, expand, or challenge each one.

---

## RESEARCH THREAD 2: THE FULL LANDSCAPE OF COLLECTION MECHANISMS

Not just tests. Everything. What are all the ways data about a person can be collected?

**2.1 Standardized psychometric instruments — the formal test landscape**

For each instrument: what it measures, what it costs, what it requires (clinician vs. self-administered), administration time, output format, validity and reliability data, known limitations, and whether the output maps to what the Velorin system needs.

Instruments to research (not exhaustive — research will expand this list):
- WAIS-IV (Wechsler Adult Intelligence Scale) — requires licensed psychologist, ~90 min, VCI / PRI / WMI / PSI / FSIQ
- DISC — self-administered, ~20 min, behavioral profile across four factors
- Myers-Briggs / MBTI — self-administered, ~30-60 min, 16 types
- NEO-PI-R / NEO-PI-3 — research-grade Big Five, ~45 min
- Hogan Personality Inventory — workplace-focused, requires certified administrator
- Enneagram (multiple formats) — self-administered, variable depth
- CliftonStrengths — self-administered, ~45 min, top 5 themes
- MMPI-2 — requires clinician, clinical scales including psychopathology
- SCID (Structured Clinical Interview for DSM) — clinician-administered, diagnostic picture
- Adult ADHD Self-Report Scale (ASRS) — self-administered screener
- PHQ-9 / GAD-7 — depression and anxiety screeners, self-administered
- ACE Score (Adverse Childhood Experiences) — self-report trauma history
- IES-R (Impact of Event Scale) — trauma response
- Attachment style instruments (ECR-R, AAQ)
- Cognitive style / learning style instruments
- Risk tolerance instruments (financial and general)
- Decision-making style instruments (e.g., Melbourne Decision Making Questionnaire)
- Emotional intelligence instruments (MSCEIT, EQ-i 2.0)

**2.2 Simulated and approximated instruments**

Can we build an instrument battery that approximates what formal tests produce without requiring a licensed clinician? What is the accuracy loss? Research: adaptive testing, IRT (Item Response Theory), computer-adaptive testing (CAT) platforms, validated short-form alternatives. What does the psychometric literature say about short-form validity vs. full instruments?

**2.3 Behavioral and implicit data collection — things that don't feel like tests**

Vocabulary and writing patterns. Response latency. Implicit Association Tests (IAT). Reaction time measures. How people describe their own past. How they respond to moral dilemmas. What can be reliably inferred from behavior rather than self-report? What is the research on this?

**2.4 Required external documents — things CT could require users to provide**

Could intake require users to submit:
- Prior DISC or MBTI results they already have
- A neuropsychological evaluation report
- Academic records (cognitive proxy)
- Employment history (behavioral data)
- A structured personal history essay
- A financial history or risk profile
- Medical records (sleep, hormonal, metabolic)
- Prior therapy notes (with consent)
- Writing samples
- Voice or video responses to structured prompts

What is the legal landscape for collecting, storing, and using each category? What consent frameworks apply?

**2.5 Structured AI-conducted interviews**

What is the psychometric validity of AI-administered clinical interviews? What exists in the literature? What can be captured in structured conversation that cannot be captured in a test? What are the failure modes?

**2.6 Longitudinal intake — ongoing vs. one-time**

Does intake have to happen all at once? Could there be a minimum viable intake that enables the system to start operating, with profile deepening over time? What are the tradeoffs? What data is load-bearing from day one vs. what can be acquired gradually through interaction?

**2.7 Third-party input — people who know the user**

Could intake include structured input from someone who knows the user well (partner, employer, close friend)? What is the precedent in clinical and organizational psychology? What are the validity and risk considerations?

---

## RESEARCH THREAD 3: WHAT CAN WE ACTUALLY REQUIRE?

The gap between "ideal data" and "what a real person will actually do to onboard."

3.1 User tolerance research on intake length and complexity. At what point does intake friction cause abandonment? What is the maximum viable intake burden for a highly motivated user — CT's target audience of high-performing founders and executives?

3.2 Competitive landscape — what have other personal AI systems, executive coaching platforms, and high-end onboarding processes required of users? What did they learn about completion rates and dropout?

3.3 What is the minimum viable intake (produces useful-enough profile to start) vs. the maximum intake (most complete profile achievable with a willing user)? What does the curve between them look like?

3.4 Legal and ethical framework for collecting sensitive psychological and clinical data. HIPAA applicability, GDPR, state laws, data storage requirements, consent standards for clinical vs. non-clinical collection. What changes if CT is not a licensed clinician? What if a licensed clinician is involved?

3.5 Is there a model where CT partners with a licensed neuropsychologist for intake? What does that look like operationally? What does the clinician provide vs. the system? Is this partly a service design question?

---

## RESEARCH THREAD 4: THE SIMULATION LAYER

The central design challenge: CT has a WAIS-IV producing VCI 151. Most users will not have one. Can the system produce a useful cognitive profile without requiring a $3,000 neuropsychological evaluation?

4.1 What is the psychometric literature on IQ estimation from vocabulary, verbal reasoning, and comprehension tasks? What is the accuracy ceiling? How does it compare to full WAIS-IV?

4.2 Can MBTI and DISC be approximated without the proprietary instruments? What is the validity of approximations vs. official instruments? What does the Big Five → MBTI mapping literature say?

4.3 What is the state of AI-based personality inference from text and conversation? What is the accuracy on Big Five, MBTI, and DISC-equivalent dimensions? What are the bias and failure modes?

4.4 Can trauma history be captured without clinical interview? What validated self-report instruments exist and what do they miss vs. clinical assessment?

4.5 What is the minimum data set that allows meaningful agent configuration? If intake produces MBTI type + Big Five profile + IQ estimate + trauma screener score + motivational inventory — how close does that get to a full clinical profile for the system's purposes?

---

## RESEARCH THREAD 5: THE ENCODING QUESTION

How does profile data get from the collection mechanism into the agent system?

5.1 What is the data model? How is a human profile represented as structured data that agents can use? Fields, types, granularity, hierarchy.

5.2 How does the profile map to the five-box governance model? Direct mapping or does it require interpretation?

5.3 How does the profile map to OASIS agent configuration? The field mapping from Jiang.Topic.OASIS is the starting point — but intake research must produce a profile format directly translatable to OASIS `UserInfo` fields.

5.4 How does the profile map to agent system prompt configuration? What parts of the profile become system prompt vs. memory vs. governance layer?

5.5 How does the profile update over time? Intake is a snapshot. People change. What is the maintenance protocol for profile accuracy? What triggers a profile update?

5.6 CT's existing data migration spec — CT has WAIS-IV, DISC, and a clinical interview from 2017. What is the minimum structure needed to format this into brain neurons for Layers 1-3? This is the shorter-path problem for CT as the first user.

---

## RESEARCH THREAD 6: WHAT HAS BEEN BUILT BEFORE?

6.1 High-end executive coaching and assessment firms — what do they require of clients? (Korn Ferry, Spencer Stuart, YSC, Heidrick & Struggles, MG100). What does a $50,000+ executive leadership assessment actually include? What data does it produce and in what format?

6.2 Full clinical neuropsychological evaluation — what is the complete battery beyond WAIS-IV? Cost, time, who can administer, what the report looks like, what it captures.

6.3 Military and intelligence psychological vetting — what do high-stakes security clearance evaluations require? What can be learned from their methodology and what they've found predictive?

6.4 Elite performance psychology — sports psychologists, tier-1 military unit programs, elite athlete intake. What do they require? What did they learn about what matters vs. what doesn't?

6.5 Existing personal AI systems — Pi (Inflection), Replika, Companion — what have they learned about user profiling through interaction? What does the research say about how well these systems actually model users?

6.6 Computational personality modeling — what does academic literature say about representing human personality in machine-readable formats? What are the recognized limitations and failure modes?

---

## RESEARCH THREAD 7: THE SENSITIVE DATA PROBLEM

7.1 Data security requirements for storing clinical-grade psychological data. What are the breach risks and legal consequences?

7.2 What is the user's exposure if this data is compromised? How does this inform what should vs. should not be collected and stored?

7.3 Ethical framework for using psychological profile data to configure an AI system operating on someone's behalf. What consent and disclosure standards apply?

7.4 What happens when the profile is wrong? If intake produces an inaccurate profile and the system operates on bad data — what are the failure modes? How does the system detect and correct profile inaccuracy over time?

7.5 Who owns the profile data? What are the portability and deletion requirements if a user exits the system?

---

## CROSS-THREAD SYNTHESIS QUESTIONS

These cannot be answered by any single thread. They require full research completion before they can be addressed.

A. Is a licensed psychologist or neuropsychologist required for intake to be defensible, useful, and legally compliant — or can a well-designed self-administered instrument battery produce an equivalent result for the system's purposes?

B. What is the difference between "accurate enough" and "complete enough"? These may not be the same threshold.

C. What does CT's own profile look like as a data model? Working backward from what the agents currently know about him — what fields exist, what fields are empty, what fields don't exist yet but should?

D. Is "intake" a one-time event or a process? What is the right framing and does the answer depend on user type?

E. What should the intake experience feel like to the user? Not just what data it collects — what does the experience of going through it communicate about Velorin?

---

## DELIVERABLE

The output of this research is not a test. It is not a system design. It is:

1. A complete map of all viable data collection mechanisms — validity, cost, burden, and legal status for each
2. A clear answer to whether licensed clinicians are required or whether approximation is sufficient — with accuracy cost quantified
3. A recommended intake architecture: what to require, what to optionally request, what to collect over time
4. A minimum viable intake specification: smallest data set that produces a useful-enough profile to start
5. A maximum intake specification: most complete profile achievable with a willing, high-motivation user
6. A data model for the profile that connects directly to the five-box governance model and OASIS agent config
7. CT's existing data migration spec for Layer 1-3 population
8. An honest assessment of what cannot be known about a person from intake alone

**Confidence threshold:** 75% minimum on each conclusion. This topic is too load-bearing for the standard 67% floor. Conclusions below 75% are flagged as insufficient and the gap is documented.

---

## PROPOSED RESEARCH SESSION STRUCTURE

Given scope, this cannot be completed in one session. Proposed structure — CT authorizes each session before it begins:

**Session A** — Read all reference material (Thread 0). Map the output spec. Understand what the brain already knows about CT. Define the data model target before any external research begins.

**Session B** — Threads 1 + 2. What the profile needs to contain + full landscape of collection mechanisms. Parallel agents per sub-thread.

**Session C** — Threads 3 + 4. What can actually be required + the simulation layer. Parallel agents.

**Session D** — Threads 5 + 6 + 7. Encoding, precedents, sensitive data. Parallel agents.

**Session E** — Synthesis. Cross-thread questions. Deliverable production.

---

## ORIGINAL REQUEST — PRESERVED FOR REFERENCE
*(from MA + Alexander, March 30, 2026)*

**Why This Is Critical Path (original framing):** The intake test is the spec for the brain schema. Without it, Velorin cannot onboard a second user. Every architecture decision about brain regions, layers, and neuron schema affects what the intake test can populate. This is the hardest design problem in the company and the most important one.

**Central question (original):** Can we design an intake experience that fills Layers 1-3 in 60-90 minutes and produces first-session cross-domain output — for a user with NO prior psychometric history?

**Draft intake components (from brainstorm — now subsumed into research threads above):**
- Component 1: Behavioral Profile (DISC-equivalent) — minimum structure for reliable behavioral profile without formal DISC administration
- Component 2: Five-Box Mapping Exercise — structured scenarios that reveal how the user naturally partitions their world, populates Layer 2
- Component 3: Decision Scenario Series — active choices made during intake revealing reasoning patterns, box defaults under pressure, ambiguity response

**Original research questions (now mapped to threads above):**
1. Precedent search: has any product successfully compressed clinical-equivalent intake into 60-90 min? → Thread 6
2. Psychometric compression: minimum questions for reliable DISC-equivalent? → Thread 4
3. Reasoning pattern elicitation: structured decision scenarios vs. direct interview for cognitive blind spots? → Threads 1 + 2
4. First-session value threshold: minimum brain state for cross-domain synthesis? → Thread 1
5. CT's existing data migration spec → Thread 5.6

[VELORIN.EOF]
