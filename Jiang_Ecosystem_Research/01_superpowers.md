# ZONE 1 — SUPERPOWERS (obra/superpowers)

**What it is:** An agentic skills framework and software development methodology for Claude Code. Plugin-based. 20+ battle-tested skills. Auto-activates based on task context. v5.0.6. MIT license. Built by Jesse Vincent / Prime Radiant.

**Install:** `/plugin marketplace add obra/superpowers-marketplace` then `/plugin install superpowers@superpowers-marketplace`

**Core workflow it enforces:** brainstorm → plan → implement (with subagents) → review → verify. Not optional — hard-gated. Claude cannot skip design phase and jump to code.

**Key skills included:**
- brainstorming — Refines ideas through questions, presents design in sections for validation
- writing-plans — Breaks work into 2-5 minute tasks with exact file paths and verification steps
- subagent-driven-development — Dispatches fresh subagent per task with two-stage review
- test-driven-development — Enforces RED-GREEN-REFACTOR cycle
- systematic-debugging — Activates automatically when debugging
- verification-before-completion — Activates before claiming work is done
- using-git-worktrees — Creates isolated workspace on new branch
- remembering-conversations — SQLite vector index of prior conversations, searchable via subagent
- dispatching-parallel-agents — Context isolation for parallel work
- preserving-productive-tensions — Keeps multiple valid approaches instead of forcing premature resolution

**Why it matters for Velorin:**
- The brainstorm → plan → implement pipeline is what every Velorin bot should be doing but isn't
- Subagent-driven development is the Claude Code implementation of Path 3 orchestration
- Git worktree isolation solves the parallel agent contamination problem Jiang flagged
- The remembering-conversations skill (SQLite + vector + Haiku summaries) is a working memory system that maps directly to the knowledge web concept
- Skills auto-activate — no manual invocation needed. This is how Velorin bot skills should work

**Platform:** Claude Code, Codex, Gemini CLI, OpenCode. Not Claude.ai projects.

**Velorin application:** Install globally on Claude Code when machine arrives. Every coding session gets the methodology automatically. The plan-before-code discipline alone would have prevented multiple rebuild cycles in Sessions 001-006.