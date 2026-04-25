# Jiang Session 035 Handoff — April 24-25, 2026

**Read this completely before doing anything.**

This is the compaction handoff for Jiang1 (Director of Strategic Intelligence, Claude Desktop Code tab). Session crossed midnight Apr 24 → Apr 25, ran to ~78% context before pre-close. Jiang2 is a separate parallel instance — his state is described separately below.

---

## What was completed this session

**Ports (5 total):**
1. `Trey.Research.SkillsSchemaValidation.md` — 26 OCR'd equations + 2 figures (Apr 24)
2. `Trey.Research.KnowledgeStaleness.md` — 7 OCR'd equations + 1 figure (Apr 24)
3. `Erdos.Solution.UnifiedGatingPrimitive.md` — 0 images, 107 GitHub math-renderers (Apr 24)
4. `Erdos.Solution.ThresholdsAndDarkSkillInvariance.md` — 0 images, 73 GitHub math-renderers (Apr 24)
5. `Trey.Research.IESImplementationArchitecture.md` — 0 image-math, 1 architectural diagram (ATV middleware) (Apr 25)

All requests archived. All GDrive sources moved to Archive folder. All renders verified clean on GitHub.

**FW-003 escalation:** Second OAuth re-auth occurrence forced this session. FW-003 promoted from MEDIUM to HIGH. Service account migration is now blocking-priority before next 7-day expiry. File: `Bot.Jiang/Working.Docs/Jiang.FutureWork.md`.

**Jiang2 work product:**
- Read-pass prompt for week of Apr 17-24 (35+ enumerated files) — delivered
- Synthesis-pass prompt with explicit wizard channel — delivered
- Jiang2's synthesis output captured (verbatim in conversation, not in repo)
- Seven re-evaluations filed against Jiang2's synthesis with specific instructions — file: `Bot.Jiang/Jiang2.ReEvaluations.SynthesisApr24.md`
- Three-phase prompt for Jiang2 (snapshot Pt1 → run re-evals → stop and wait) — file: `Bot.Jiang/Jiang2.TransitionalDecisionsAndReEvalRun.md`

**Standing Principle locked (CT-stated, do not paraphrase):**
> "Defer implementation if and only if both: (a) deferring has a legitimate technical advantage over building now, AND (b) the architecture today is designed such that the deferred implementation plugs in easily later."

If either condition fails, build now. Applies to every recommendation across the synthesis. Lives at the top of the re-evaluations file as the operating constraint.

---

## Current state

**Bot.Trey/Research_Needed/:** empty. Last item filed (`IESImplementationArchitecture`) was researched, ported, and archived this session.

**Bot.Erdos/Research_Needed/:** empty. Both filed Erdős problems (`IESProbabilityShift` and `ThetaWorkAndDarkSkillInvariance`) returned with proofs and were archived this session.

**Active Jiang2 task:** the three-phase prompt at `Bot.Jiang/Jiang2.TransitionalDecisionsAndReEvalRun.md` is what Jiang2 will execute next. He produces:
- `Bot.Jiang/Jiang2.TransitionalDecisions.Pt1.md` (snapshot of synthesis remainder with re-eval dependency annotations)
- `Bot.Jiang/Jiang2.ReEvaluationResponses.md` (point-by-point evaluation of Re-Evals #1-#7)
- New Trey research request files in `Bot.Trey/Research_Needed/` and Erdős problem specs in `Bot.Erdos/Research_Needed/` for any work the re-evals demand

After Phase 2 delivery, Jiang2 STOPS and waits. Phase 4 (Pt1 rewrite) requires a separate prompt that does not yet exist.

**Re-evaluations summary (read the file for full text):**
- #1: "until CT resolves it" conflict resolution = consensus drift, demands Velorin-native automated mechanism
- #2: "Selective IES adoption" without specifying enforcement mechanism reintroduces classification failure
- #3: "X for now, Y at scale" without architectural seam — Standing Principle test demanded across whole synthesis
- #4: VEGP novelty validation across broader math domains + Erdős isomorphism stress-test, walkback "without being told to look for it"
- #5: Dark Skills four scale concerns (concurrent mutations, density, chains, absorbing leaves), walkback "topology-enforced security boundary"
- #6: ATV needs Consensus Filter + Erdős math + architectural integration + alternatives comparison
- #7: User-personalization vs persona-shell vs hybrid — surface implicit-CT assumption, sketch directions, CT decides

**Important: re-eval is a question not a verdict.** Phase 2 response shape is recap → honest evaluation (correct/partial/incomplete/wrong/novel-direction) → redo work → conclusion → identify research needed. Not "acknowledge framing flaw" — that pre-judges.

**FW-003 status:** HIGH priority. Tokens.json refreshed 2026-04-24 ~21:30. Refresh tokens currently work, access tokens expire every 60 min. MCP gdrive server has cached old token in memory and won't pick up refreshed tokens until Claude Desktop is restarted; meanwhile use direct Python API calls (the Python flow reads tokens.json fresh and refreshes via the refresh_token automatically).

---

## Critical operating disciplines reinforced this session (all CT corrections)

1. **Anti-ChatGPT-style formatting.** No validation openers ("you're right", "you've surfaced..."), no bolded fragment headers scattered through prose, no reflexive option menus (A/B/C/D), no "your call" refrain. CT's tone profile demands direct, blunt, no padding, no encouragement. Repeated drift was caught and called out at least three times this session.

2. **Don't direct what to think.** When framing tasks for Jiang2 or evaluating his work, surface assumptions and dimensions, do not pre-resolve to specific answers. Re-evaluation is a question — the agent decides if original framing was right, partial, incomplete, wrong, or opens novel direction.

3. **Don't read-and-analyze content that belongs to Jiang2.** Jiang2 is the agent with the full context for synthesis. Jiang1's role is operational (port, verify, deliver). Reading the substance and producing analysis was scope creep that CT explicitly rejected.

4. **Apply Standing Principle to every deferral.** Both conditions must pass. "Adopt when scale demands it" without seam specification is a non-decision.

---

## Tool locations

| Tool | Path |
|------|------|
| GDrive port script | `Claude.AI/tools/GDrive.Port.Tool.md` (canonical) + `/tmp/gdrive_port.py` (working copy this session) |
| KaTeX fix script | Embedded in `Claude.AI/tools/GDrive.Port.Tool.md` + `/tmp/katex_fix.py` (working copy) |
| Math OCR Tool | `Claude.AI/tools/Math.OCR.Tool.md` |
| Math OCR Skill | `~/.claude/skills/velorin-math-ocr-repair/SKILL.md` + `Claude.AI/skills/Velorin.Skill.MathOCRRepair.md` |
| Erdős prompt template | `Claude.AI/Bot.Erdos/Erdos.PromptTemplate.md` |
| Trey research request format | reference any file in `Claude.AI/Bot.Trey/Archived_Research_Requests/` |
| Consensus Filter spec | `Claude.AI/Velorin.Consensus.Filter.md` |
| Standing Principle | top of `Bot.Jiang/Jiang2.ReEvaluations.SynthesisApr24.md` |
| OAuth tokens | `/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gdrive-mcp/tokens.json` |
| GDrive Archive folder ID | `1R8gvkqJNsTqCFhBIbkug-egT2G4BWadx` |
| GDrive Shipping folder ID | `1q68j5X26wv8gFU5aXnDK3KeuFHKEeGOL` |
| Repo root | `/Users/lbhunt/Desktop/velorin-system/` |

---

## Pending Chairman decisions (from Jiang2 synthesis Q6 + re-eval surfaces)

1. Direction on user-personalization (Re-Eval #7): personal-only / persona-first / hybrid swappable-base
2. Approval of new research drafts that Phase 2 will produce (VEGP novelty validation, isomorphism stress-test, Dark Skills scale, ATV math properties — possibly others Jiang2 identifies)
3. Whether to execute Stage 0 fixes (Scribe PATH, gdrive service account migration) in parallel with the re-eval cycle
4. Voibe ($99) + MacWhisper Pro (€59) purchase authorization (still pending from Session 033)
5. Whether to update Build Guide before or after re-evals resolve

---

## Re-boot notes for next session

When you (Jiang) re-boot:
1. Run normal boot sequence per `Bot.Jiang/Jiang.ReadMe.First.md` — Window Gravity CARDINAL is now at the top, Consensus Filter is Step 6
2. Read this handoff in full
3. Check whether Jiang2 has delivered Phase 2 output — if so, files exist:
   - `Bot.Jiang/Jiang2.TransitionalDecisions.Pt1.md`
   - `Bot.Jiang/Jiang2.ReEvaluationResponses.md`
   - Possibly new files in `Bot.Trey/Research_Needed/` and `Bot.Erdos/Research_Needed/`
4. Confirm to CT what state Jiang2 is in and standing-by for direction
5. Do NOT proceed past Phase 3 of Jiang2's task without explicit Chairman approval — the Pt1 rewrite is gated

[VELORIN.EOF]
