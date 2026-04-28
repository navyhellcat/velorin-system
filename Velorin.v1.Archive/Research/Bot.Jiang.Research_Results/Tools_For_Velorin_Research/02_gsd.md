# ZONE 2 — GET SHIT DONE (gsd-build/get-shit-done)

**What it is:** A meta-prompting, context engineering, and spec-driven development system for Claude Code. 12.2k stars. Built by TÂCHES (solo dev, glittercowboy). v1.27+. MIT license. Trusted by engineers at Amazon, Google, Shopify, Webflow.

**Install:** `npx get-shit-done-cc --claude --global`

**Core philosophy:** "I'm not a 50-person software company. I don't want to play enterprise theater. I'm just a creative person trying to build great things that work." Complexity is in the system, not in the workflow.

**What it does:**
- /gsd:discuss-phase — Codebase-aware discovery. Scouts relevant source files before asking questions. Produces CONTEXT.md that feeds all downstream agents
- /gsd:plan-phase — Spawns gsd-phase-researcher before planning. Plan verification loop: planner → checker → revise cycle. Six verification dimensions
- /gsd:execute-phase — Executes with subagents. Parallel executor. Auto-commits
- /gsd:verify-work — Verification and completion detection
- /gsd:do — Freeform natural language router to the right GSD command
- /gsd:note — Zero-friction idea capture with promote-to-todo

**Agent architecture inside GSD:**
- gsd-researcher agent (915 lines) — Deep research before planning
- gsd-plan-checker agent (744 lines) — Validates plans against goals
- Context flows: CONTEXT.md → researcher → planner → checker → revision loop → executor

**Multi-runtime support:** Claude Code, OpenCode, Gemini CLI, Codex, Copilot, Cursor, Windsurf, Antigravity. One install command per runtime.

**Why it matters for Velorin:**
- The discuss → plan → execute → verify pipeline is what Velorin's Operating Standards describe but no bot currently enforces
- The CONTEXT.md pattern is functionally identical to the Velorin boot protocol — but automated
- 428 tests across 13 test files. This is production-grade
- Git branching strategy (per-phase or per-milestone) solves the version control discipline gap
- The researcher agent that runs BEFORE planning is exactly what Jiang does — but automated inside the coding workflow

**Platform:** Claude Code primary. Multi-runtime secondary.

**Velorin application:** Install alongside Superpowers on Claude Code. GSD handles the project management layer; Superpowers handles the coding methodology. Together they cover the full build cycle from discovery to deployment.