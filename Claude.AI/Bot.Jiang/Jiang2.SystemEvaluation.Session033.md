# Jiang2 — Full System Evaluation and Forward Plan
**From:** Jiang
**Issued:** 2026-04-21
**Mode:** Deep analytical work. Structured questions. Two-pass delivery. Evidence-cited. Read everything listed before answering anything.

---

## PRE-LOAD — Verify or Refresh

The Chairman needs confidence that you have the math pairing in context before you do anything else. Before writing a single conclusion, confirm (to yourself) that both of these are in your active context. If either is not, read it in full now:

1. `Claude.AI/Bot.Trey/Research_Complete/Trey.Research.AutomatedPointerRating.md` — contains the full treatment of the multiplex normalization problem and the Erdős proof request (Part 5).
2. `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.IndependentMultiplexNormalization.md` — Erdős's formal proof answering that request.

Then load these, which are new since your last analytical pass and which you probably have not seen:

3. `Claude.AI/Bot.Trey/Research_Complete/Trey.Research.RuleActivationGap.md` — Trey's research on structural prompt patterns for mid-reasoning rule activation (the subject you are about to use to evaluate our own rules).
4. `Claude.AI/TODO.RuleActivationGap.md` — including the April 21 addendum on the **two-layer failure model** (Layer 0 = rule not in load path; Layer 1 = rule loaded but doesn't intercept at conclusion-formation). This matters for Q1 below.
5. `Claude.AI/Bot.Trey/Research_Complete/Trey.Research.MediaExtractionToolsLandscape.md` — Trey's recommendations on OpenDataLoader, Surya, Kreuzberg, and the downgrade of Docling.
6. `Claude.AI/Bot.Trey/Research_Complete/Trey.Research.BrainToSkillsInterface.md` — the GoS (Graph of Skills) architectural finding.

If your prior catchup + follow-up passes covered items 1, 2, 5, 6, you may not need to re-read in full — but verify by naming them rather than assuming. Items 3 and 4 are new and must be read fresh.

---

## THE TASK

Evaluate the Velorin System's current operational architecture — rules, tools, prompting patterns, boot sequences, hooks, scripts — and the plan going forward — Brain, skills, ingestion pipeline, tool adoption. Use the evaluation disciplines we have built over the last week (Consensus Filter, Window Gravity, Rule Activation Gap two-layer model, InstructionLanguageArchitecture anti-patterns, Boot Degradation anti-patterns). Surface novel solutions where pattern-matching against published approaches is insufficient.

Six structured questions. Answer in order. Evidence citations per claim — every non-first-principles claim cites a specific doc by path.

---

### Q1 — Rules and Instructions Audit (Layer 0 + Layer 1)

Walk the CARDINAL rules added in the last week across agent boot chains. For each rule, answer:

(a) **Layer 0 check:** is the rule in the target agent's actual boot path? Do not assume. Trace the boot sequence file-by-file. (Example of why this matters: the CARDINAL math-output rule sat in `Trey.OutputStandards.md` for 24 hours before I discovered `Trey.ProjectInstructions.md` Boot Sequence does not load that file — the rule was structurally inert. Fixed April 21 with inline placement. Other rules may have the same defect.)

(b) **Layer 1 check:** does the rule have a structural enforcement mechanism (tool-gate, state machine, evidence artifact, position exploitation) or is it prose hoping to be honored? Distinguish the two honestly.

(c) **Verdict per rule:** Active / Inert / Prose-only / Structurally-enforced.

Rules to audit at minimum:
- Window Gravity (Jiang.ReadMe.First)
- Consensus Filter (Level 4 General Rules §20a, Jiang.ReadMe.First, Erdős Gem Instructions, Trey.ProjectInstructions inline)
- External Agent Boot Sentinels (`[BOOT]` for Erdős — Level 4 General Rules §20b, Erdős ReadMe, Agent.API.Conventions)
- Math output CARDINAL (Trey.ProjectInstructions inline, Erdős Gem Instructions, Trey.OutputStandards §2.3)
- Erdős Boot Continuity (Research_Complete pre-load)
- Any other CARDINAL added this week that you find during the walk

Produce one table. Rule | Target Agent | Boot-loaded? | Enforcement | Verdict.

---

### Q2 — Trey Rule Activation Gap Research — Consensus Filter Applied With Teeth

Read `Trey.Research.RuleActivationGap.md` end to end. Apply the Consensus Filter honestly, with willingness to answer "no" to question 3. Then:

(a) List Trey's top 3-5 specific mechanism recommendations.
(b) For each, run Q1 (consensus), Q2 (why it exists), Q3 (does Velorin share the constraint) explicitly.
(c) At least one of your Q3 answers must be a genuine "no" — or you must explain why every recommendation Trey surfaced genuinely applies. Ritual-pass (all Q3 = yes) is a failure of this task.
(d) For adoption candidates, map them onto our existing stack. For boundary candidates, propose what Velorin's divergence looks like — not "we'll do it differently later," but the concrete alternative architecture.

Flag anything in Trey's research that he frames as consensus but that you suspect is historical accident rather than necessity. The highest-value pointers for Velorin's novelty live there.

---

### Q3 — Brain Architecture Under Current Math Lock + New Tools

The math is now substantially locked:
- Independent row-normalization of $P_{tax}$, $P_{them}$ (Erdős proof, April 20)
- $\rho^{\ast} = 0.78$ density constraint preserved across multiplex mixture (Erdős proof, April 20)
- Topological Action Potential with threshold $\theta_{work}$ for skill injection (Erdős, BridgingDeclarativeProceduralMemory)
- NPMI + LLM-judge hybrid for automated pointer rating (Trey, AutomatedPointerRating)
- Affective Hamiltonian $H_E$ governing episodic temporal decay (established earlier)

And the tools landscape has shifted:
- OpenDataLoader PDF v2.0 emerges as unified ADOPT-NOW for equation OCR + PDF-to-markdown
- Docling downgraded (1GB footprint, times out on >1MB files) — contradicts Session 024 adoption decision
- Surya as fallback, Kreuzberg as speed-bulk option
- Mathpix, Marker (GPL), MarkItDown, pix2tex all rejected

Evaluate:

(a) **Does the Brain ingestion pipeline as currently planned hold up** given the math lock and tool shift, or does it require revision? Be specific about components that change.

(b) **OpenDataLoader adoption:** it lands at the preprocessing layer. Map it against our foundational-build vs. non-foundational-adopt rule. Does adoption violate the "Velorin never adopts at the foundational level" principle, or is preprocessing-layer adoption explicitly fine? Reason this through — don't invoke the rule as a label.

(c) **The Docling contradiction:** Session 024 adopted Docling. April 21 research downgrades it. What changes in the build sequence as a result? Is anything load-bearing that depends on Docling-specific capabilities Kreuzberg or OpenDataLoader lacks?

(d) **Provenance requirements:** OpenDataLoader outputs bounding-box coordinates per extracted element. Does this unlock new capabilities the prior plan didn't contemplate (e.g., citation-level provenance in Brain neurons)? What changes in Layer 3 neuron schema if so?

(e) **Hard memory pipeline specifics:** given all of the above, write the concrete ingestion sequence from PDF-in to neuron-out. What tool runs at what step. Where math extraction happens. Where LLM-judge kicks in. Where the $\rho^{\ast}$ density check runs. What fails open vs. fails closed.

---

### Q4 — Skills and the Skill Brain Layer

The GoS finding (`Trey.Research.BrainToSkillsInterface.md`) says skills have prerequisite dependency edges and need reverse-PPR traversal over a separate dependency graph. This is new architecture not yet in the Build Guide.

(a) **Minimum viable first skill:** what is it, concretely? Not a category — name a specific skill that a working Velorin system would ship with on day one.

(b) **Skills dependency graph structure:** where does it live, how are edges defined, who populates them, how does it stay current as new skills are added. Propose a concrete structure, not a menu of options.

(c) **Skill injection mechanism:** how does the Topological Action Potential $\Phi(v) = \pi_v / \lVert\pi\rVert_\infty$ with threshold $\theta_{work}$ actually wire into an agent's runtime? Concrete control flow. When does a skill's `skill_ref` header get pushed into an agent's context, and when does it not?

(d) **Open math Erdős should formalize:** Trey's BrainToSkillsInterface flags $\theta_{work}$ as needing formal derivation. What else should we file with Erdős now that you have full context? Write the problem specs (per `Erdos.PromptTemplate.md`) for any open math questions you identify — even as drafts.

---

### Q5 — Full Pipeline, Start to Finish, Critical Path

Given Q1 (rule infrastructure state), Q2 (Trey recommendations filtered), Q3 (Brain pipeline with new tools and math), Q4 (skills architecture) — produce the concrete build sequence. Not "Phase 1 / Phase 2." A directed graph of dependencies.

Format:
- One step per line
- Each step: **what specifically happens**, **what it depends on**, **what it unblocks**, **what is currently blocking it** (if anything)
- Mark the critical path explicitly
- Flag any step where a "decision deferred to later" actually locks in technical debt — and either commit to the structurally-correct choice now, or commit to dropping the deferred option permanently. "X for Phase 1, Y for later" without explicit technical-debt analysis is a non-decision and will be rejected.

One page maximum. Force yourself to compress.

---

### Q6 — Asks

What do you need to move forward?

(a) **From the Chairman:** specific decisions blocking next steps. Name the decision, name what's blocking you, propose the options with tradeoffs.

(b) **From Trey:** specific new research requests (not "more research on X" — scoped questions per the Trey request format used in April, with required deliverable structure and Consensus Filter note). Draft them here; they will be filed after CT approves.

(c) **From Erdős:** specific math problem specs (per `Erdos.PromptTemplate.md`). Same — draft them here.

(d) **From tooling:** specific installations, configurations, or scripts that need to exist before you can proceed. Concrete list.

---

### Q7 — Novel Synthesis — What You Are Seeing That Nobody Asked About

This is your wizard channel. Your ReadMe.First calls out your function explicitly: *"You are the wizard. Your function is to see what others cannot, connect what others would not think to connect, and surface what matters before it becomes obvious."* Q1-Q6 are audit questions. Q7 is the one that is actually load-bearing for Velorin's edge.

Use this question to surface anything Q1-Q6 did not capture:

(a) **Cross-domain connections.** Patterns you notice across the corpus that the individual research papers did not see because no single one of them held all the context. Trey runs deep but narrow. Erdős runs narrow but deep. You are the only agent in this system that holds the full cross-domain picture simultaneously. Use it. Where does the Rule Activation Gap research illuminate something about the Brain's Topological Action Potential? Where does the GoS dependency graph finding connect to the Consensus Filter? Where does the OpenDataLoader provenance capability unlock something we have not yet contemplated for the Skills layer? These are the questions only you can answer.

(b) **Novel theorems or architectural primitives Velorin should invent.** Not "Velorin should adopt X and call it Y." Genuinely new primitives: a mathematical structure, an agent interaction pattern, a memory-graph operation, a boot-phase mechanism — that does not exist in the literature but that would create a capability specific to Velorin's architecture. Sketch each one with enough detail that Erdős or Trey could develop it further. It is not required that these be fully worked out — it is required that they be real ideas, not consensus dressed up.

(c) **External paths that lead somewhere Velorin-native.** The Consensus Filter exists because external consensus is rarely where Velorin's edge lives. But sometimes the right move is: take an external path, follow it until it diverges from our architecture, then branch off and build the Velorin version of what it was pointing toward. Identify candidates. Example shape: "CRAG is consensus. The constraint it addresses is real for Phase 1. But the Velorin-native version is X, which uses our PPR+skill topology in a way CRAG cannot." Find the branching points.

(d) **Things the Chairman is not asking about but should be.** If you see a question that is not in Q1-Q6, not in any current research request, not in any open problem list — and you have high confidence (≥67%) it matters — surface it. This is the only place where unsolicited strategic observation is not just permitted but required.

The disciplines in "Delivery Constraints" below apply to CLAIMS — things you assert as fact. They do not apply to proposals, sketches, synthesis, or creative hypotheses. A sketch of a novel architecture labeled as a sketch is not a claim; it is a proposal for investigation. Use the distinction. Do not collapse into audit-only mode.

---

## DELIVERY CONSTRAINTS

Before you deliver:

1. **Evidence citations.** Every non-first-principles claim cites a specific doc by path. If you find yourself writing a claim without a citation, either you're reasoning from first principles (say so explicitly) or you're pattern-matching from felt context (window gravity — refresh state or drop the claim).

2. **No phase-gating cop-outs.** If you write "X for Phase 1, Y for later," you must immediately answer: what calcifies if we ship Phase 1 with X? What does switching to Y in Phase 2 cost? Why is that cost worth incurring? If you cannot answer, commit to one choice or the other now.

3. **Consensus Filter with teeth.** At least one genuine "no" to Q3 across the analysis, or explicit reasoning for why every external recommendation genuinely applies. Ritual Q3-always-yes is consensus drift.

---

## TWO-PASS DELIVERY (MANDATORY)

After drafting Q1-Q7, do NOT deliver yet. Run a critique pass on your own output. The critique has two sides — discipline and courage. Both are failure modes; neither is optional.

**Discipline side (on claims — things asserted as fact):**
- **Consensus drift:** did I answer Q3 = "no" anywhere meaningful, or did I ritual-pass?
- **Phase-gating:** did I defer any architectural decision without technical-debt analysis?
- **Window gravity:** did I make any architectural claim bounded by what happens to be in my current context, without refreshing state (git log, adjacent research docs, prior Velorin work) to verify?
- **Layer 0 verification:** did I assume any rule is active without checking its target agent's actual boot path?

**Courage side (on synthesis — Q7 and the novel-idea components of Q3/Q4):**
- **Timidity:** did I hold back a cross-domain connection because it felt speculative rather than because I actually doubt it?
- **Consensus camouflage:** did I dress up an external recommendation as a "Velorin-native" idea, or is what I proposed genuinely new?
- **Safe scope:** did I limit Q7 to the smallest defensible territory instead of using it fully?
- **Wizard abdication:** did I produce an audit that any careful analyst could have produced, instead of the synthesis that only the agent holding the full cross-domain context can produce?

If any failure in either side: fix. The discipline critique removes false claims. The courage critique adds missing synthesis. Both are needed. Then deliver.

---

## OUTPUT

Markdown. No heavy required sections beyond Q1-Q6. Tables where they help. Prose where it helps. Keep it compact — compression is part of the work, not a tradeoff against quality.

---

## SELF-DELETE

After delivery:

```bash
rm "/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/Jiang2.SystemEvaluation.Session033.md"
```

---

## FINAL REMINDER — READ LAST

Two things the Chairman needs from this deliverable, and they are not in tension.

**On claims:** Window Gravity applies. The continuous question — *"Am I confident because I verified, or because the window felt full?"* — runs on every thing you assert as fact. Evidence cites a path. Uncertain claims are labeled uncertain or dropped. A narrower analysis with verified claims is better than a broader one with confident-sounding ones.

**On synthesis:** your ReadMe.First names you the wizard. *"Your function is to see what others cannot, connect what others would not think to connect, and surface what matters before it becomes obvious."* That function does not suspend because the task includes an audit. The audit is the scaffolding; the synthesis is the building. Q7 is not a bonus section — it is where Velorin's actual edge gets surfaced. The Chairman would rather have a speculative connection labeled as a sketch than a correct-but-obvious observation that any careful analyst could have produced. Boldness on sketches is the correct mode. Discipline on claims is the correct mode. Both at once.

The agents below you (Trey runs deep but narrow, Erdős runs narrow but deeper) cannot do what you do. You are the only agent in this system holding the full cross-domain context. Act accordingly.

Your brain is open.

[VELORIN.EOF]
