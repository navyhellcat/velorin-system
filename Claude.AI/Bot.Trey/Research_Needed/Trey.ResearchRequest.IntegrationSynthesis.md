---
file: Trey.ResearchRequest.IntegrationSynthesis.md
priority: HIGH — gates Mac Studio transition AND Mode-A-to-Mode-B plan
date: 2026-05-03
from: Jiang1 (Director of Strategic Intelligence)
to: Trey 2 (Velorin-specific Deep Research, integration synthesis lens)
mode: Integration synthesis — external landscape lens
parallel-to: Stark IntegrationSynthesis (filed same date, architectural lens)
---

═══════════════════════════════════════════════════════════════════
GPS-OVER-MAP — READ FIRST (Velorin Principle 1)
═══════════════════════════════════════════════════════════════════
This file is a POINTER. Architecture, math, decisions, prior research
live in canonical files (read at boot). Integrate them — do not
restate them.

A parallel synthesis is being commissioned to Stark (Gemini Deep
Think Gem) with a similar prompt and a different lens (his is
architectural-from-principles; yours is external-ecosystem). You
produce yours INDEPENDENTLY; do not depend on his deliverable. CT
compares both and reconciles.
═══════════════════════════════════════════════════════════════════


# Velorin Integration Synthesis — External Landscape Lens

## THE PROBLEM

Velorin has accumulated dozens of locked decisions, principles,
theorems, and tool research items across multiple files. Each is
correct in isolation. None has been integrated into a single
buildable plan that connects the locked architecture to the actual
external ecosystem (vendor APIs, MCP servers, integration protocols,
current tool capabilities) that the architecture relies on to run.

Your synthesis: take the integration shapes that production
multi-vendor systems use today AND the locked Velorin architecture,
and produce one plan that says how the architecture meets the world.
Where do Velorin's decisions diverge from production patterns? Where
does the divergence cost or help? What concrete integrations need to
exist between today's external ecosystem and the locked principles?

CT compares your output to Stark's parallel synthesis (architectural
lens, no external research). Where you agree, that's the integration.
Where you diverge, that's a real architectural choice CT will lock.

## THE NEW PRINCIPLE THAT DRIVES THIS

`Claude.AI/Velorin.Principles.md` Principle 9 (Goal Over Method,
Phased) was locked 2026-05-03. Mode A (build): foreground per-task
loop. Mode B (stable): scheduled background program maintains the
**Vetted Substrate** of validated tools/workflows/procedures.
Transition is per-workflow, not flag-flip.

Your synthesis must design **both modes** AND the transition,
specifically through the lens of how external tools, vendor surfaces,
and ecosystem changes feed each mode.

## SUBSTRATE INPUTS

Per your boot list (`Trey.ProjectInstructions.md`). Full Build Guide.
Library Master Index + relevant cards by `topic_id`. All your prior
Research_Complete deliverables — especially the May 2026
`Trey.Research.AIToolingLandscapeDiscovery.May2026.md` you just
delivered. Erdős math results as inputs (do not interpret math; cite
by name).

## THE INTEGRATION AREAS — EXTERNAL LENS

Same 11 areas as the Stark synthesis (he holds the architectural
lens). You hold the external lens. For each area, answer:

1. What does the production multi-vendor ecosystem do here today?
2. Where does Velorin's locked decision diverge from that?
3. Is the divergence cost or help, given Velorin's constraints
   (single-user, deterministic-program substrate, multi-vendor
   Cowork)?
4. What concrete external integration (MCP server / API call / CLI
   subprocess / browser bridge) needs to exist for Velorin's decision
   to actually run?

Areas:
1. GPS Navigation Layer
2. Brain — 4 layers
3. Skills system
4. Hooks
5. MCP topology (this is your strongest area — the ecosystem changes most here)
6. Outside tool integrations
7. Cowork orchestration
8. Programs to build
9. Workflows
10. Multi-vendor protocol hierarchy
11. Vetted Substrate (you propose schema/location/update; CT compares to Stark's proposal)

## WORKED EXAMPLE — PRINCIPLE 9 ON A REAL CASE

CT's stated approach: **"I want to build a website. I plan to use
Replit + Google Flow with manual copy-paste."**

Run the Goal-Over-Method loop end-to-end for this case. You produced
the May 2026 AIToolingLandscapeDiscovery report; you have the data.
Demonstrate:

1. **Goal extraction.** Default: Velorin showcase / landing site.
   State the assumption explicitly.
2. **Method evaluation.** Are Replit + Google Flow optimal? Cite
   YOUR own May 2026 findings — Claude Design (April 17), Bolt.new,
   v0, Lovable, Firebase Studio with App Prototyping agent, Cursor
   + a real framework. Verdict + rationale. Don't soften.
3. **Gap.** What additional research (if any) does the system need
   to choose? You name the research surface; if you can answer it
   in this same deliverable, do.
4. **Best plan.** Recommended stack with concrete tools, integration
   protocols (MCP / CLI / API per the locked hierarchy), and the
   programs that wire the workflow.
5. **Surface to CT.** Plan + rationale + alternatives + the genuine
   choice (where system can't decide).

The demonstration IS the proof of synthesis. Without it, the
deliverable is another landscape report. With it, CT sees the loop
working on a real case using your real data.

## STALENESS UPDATE

Same Library cards listed in your May 2026 deliverable's Step 5.
Update the staleness statuses if anything has changed in the days
since. Specifically: any new ecosystem changes since April 30, any
new vendor announcements relevant to the Vetted Substrate design.

## OUTPUT FORMAT

Markdown. Plain-text LaTeX for any math (no equation images — verify
`grep '!\[\]\(images/'` returns zero). Confidence labels on
analytical claims. 10 sections:

1. Synthesis Problem Statement
2. Substrate Inputs
3. Integration by Area (with external lens, the 11 areas)
4. Cross-Cutting Couplings (where external reality conflicts with locked Velorin decisions)
5. Worked Example (Replit-website case, full loop)
6. Mode A vs Mode B with external feed mechanisms
7. Vetted Substrate Specification (your proposal)
8. Build Order with named external dependencies
9. Gap Report (questions CT must answer to lock)
10. Implementation Notes

## DELIVERY

Drive → Claude.AI Shipping folder. Top:
```
---
destination: Claude.AI/Bot.Trey/Research_Complete/
---
```
Last line: `[VELORIN.EOF]`. No git.

## CONSENSUS FILTER

Apply on every recommendation. Most multi-agent ecosystem patterns
are multi-tenant / general-purpose / cloud-first. Velorin is none of
those. Where the consensus is wrong for Velorin, name the boundary
explicitly.

[VELORIN.EOF]
