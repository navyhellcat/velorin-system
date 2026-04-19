# Jiang2 — New Research Review Prompt — April 19, 2026

Three Trey research docs just landed. Read them. Then think. Then write a decision plan for the Chairman.

## Read These

```
Claude.AI/Bot.Trey/Research_Complete/Trey.Research.Epistemodynamics.NoveltyCheck.md
Claude.AI/Bot.Trey/Research_Complete/Trey.Research.EmotionalMemorySalience.Measurement.md
Claude.AI/Bot.Trey/Research_Complete/Trey.Research.SkillsTaxonomyEmergence.md
```

Also pull first: `cd /Users/lbhunt/Desktop/velorin-system && git pull`

---

## Posture

These are Trey's findings, not directives. The fact that a paper points in a direction does not mean that direction is correct, complete, or what we should build. Read them the way a skeptical engineer reads a vendor proposal — extract the signal, challenge the framing, and form your own view.

Do not update the Build Guide. Nothing gets locked until the Chairman reviews your decision plan.

---

## What to Produce

After reading, write a **decision plan** saved to:
`Claude.AI/Bot.Jiang/Jiang2.DecisionPlan.Apr19.md`

The plan should cover:

1. **What each paper actually establishes** — not what it claims. What is verified, what is asserted, what is speculation.
2. **What it changes (if anything)** — does this alter any architecture decision in the Build Guide, or does it confirm what's already there?
3. **Your synthesis** — after reading everything together (these two docs, the earlier Erdős and Trey research, the Build Guide), is there a more optimal path forward than what's currently documented? If you see something novel, put it forward. Don't bury it in hedges.
4. **Decisions required from the Chairman** — a short list of specific choices that only he can make. No open-ended questions. Crisp options with your recommended call and one-line rationale.

---

## On Offloading

If your analysis surfaces a question that requires pure research or math, do not attempt to resolve it yourself. Write the task as a research request for Trey or Erdős and include it in the decision plan. That's what they're for. Keeping that work out of your context window is the correct instinct — follow through on it.

---

## Scope

This prompt covers only the two new docs. Your earlier briefing (`Jiang2.ResearchBriefing.Apr19.md`) covers the four docs from the April 17 gap — handle that separately or together, your call on sequencing.

## When Done

Delete this prompt file. It is consumed once you've completed the decision plan.

```
git rm Claude.AI/Bot.Jiang/Jiang2.NewResearchReview.Apr19.md && git add -A && git commit -m "Jiang2: delete consumed prompt NewResearchReview.Apr19" && git push
```

[VELORIN.EOF]
