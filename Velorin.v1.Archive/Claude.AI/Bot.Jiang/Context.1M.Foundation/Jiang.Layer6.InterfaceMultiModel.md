---
class: c-memory
type: layer-research
layer: 6
layer_name: Interface & Multi-Model
status: PARTIAL — interfaces exist, cross-model autonomy not yet built
session: 016 | April 3, 2026
confidence: 82-88% (from AgentOrchestration) | 87% on multi-model risks
---

# Layer 6 — Interface & Multi-Model
**Status: PARTIAL. Human-facing interfaces operational. Cross-model autonomous communication is a Phase 3/4 problem, not current.**

---

## Related Research Documents
- `Jiang.Topic.AgentOrchestration.md` — Sections 4, 6, 7, 8 cover interface and multi-model architecture
- `Research_Complete/Jiang.Topic.ClaudeOnReplit.md` — Claude as shell/client, Replit as compute backend
- `Research_Complete/Jiang.Topic.OASIS.md` — Multi-agent simulation environment (production-deployed)
- `Research_Complete/Jiang.Topic.DeepResearchPipeline.md` — Research pipeline orchestration patterns

---

## Current Interface Architecture

| Interface | Agent | Status |
|-----------|-------|--------|
| Claude Desktop (main) | Jiang | LIVE |
| Claude Desktop Code tab | Alexander | LIVE |
| Claude Code CLI | MarcusAurelius | LIVE |
| Cursor | Code execution | AVAILABLE, not fully configured |
| Gemini 2.5 Pro | 1M context sessions | AVAILABLE, human-routed |
| Agent Teams (tmux) | Multi-agent coordination | BUILT but fragile — compaction fix applied Session 016 |

---

## Multi-Model Strategy — Decided Session 016

**The goal is NOT three AIs talking autonomously.** The goal is Claude calling the right tool for each job via MCP.

| Task Type | Route To | Mechanism |
|-----------|----------|-----------|
| Code writing | Claude | Native |
| Code review / pre-coding warnings | Codex | Codex MCP plugin |
| Full-corpus long-document analysis | Gemini 2.5 Pro | Human-routed (1M context) |
| Google Workspace operations | Google services | Google Workspace MCP |
| Deep research synthesis | Jiang | This agent |
| Strategic decisions (multi-model input) | Human routing | Christian Taylor decides |

---

## Why Full Autonomous Cross-Model Communication Is Phase 3/4

**Identity verification is unsolved.** The Velorin system currently authenticates agent-to-agent communication by convention — file structure, [VELORIN.EOF] markers, Boot Sequence patterns. This is authentication-by-convention, not cryptography.

For human-in-loop operation (Christian Taylor present and observing): this is sufficient.
For autonomous Path 3 operation (Alexander programmatically opening Jiang sessions, sending instructions without Christian in the loop): this is insufficient.

**A signed message protocol or shared secret is required before full autonomy.** This is a 1-session design problem. It has not been designed yet. It must be designed before Path 3 becomes operational.

**Behavioral inconsistency across model families is a secondary risk.** Claude, GPT-4, and Gemini have different RLHF profiles — different tendencies on confident-sounding output under uncertainty, different refusal patterns, different handling of ambiguity. A system designed around Claude's behavior will behave unpredictably when other models are substituted. Building around MCP tool calls (where the other model is a specialized tool, not an autonomous agent) avoids this problem.

---

## OASIS — What It Is and Why It's Relevant Here
(From Research_Complete/Jiang.Topic.OASIS.md — read for full detail)

OASIS is a generalizable multi-agent simulation environment where each agent is an LLM instance with persistent profile, memory, and 23 action types. Originally designed for social media simulation (Twitter/X, Reddit topologies) but fully extensible.

**Why relevant to Velorin Layer 6:** OASIS demonstrates that large-scale multi-agent systems (100-agent simulations at $0.70/run) are buildable today. Its architecture (SQLite/Postgres state, profile-driven agents, action type vocabulary) is a reference implementation for what Velorin's multi-agent layer could look like at scale.

**Not a current build priority.** Relevant when Velorin moves to productization — multiple client instances running parallel agent systems.

---

## Gemini 2.5 Pro — The 1M Context Tool
For sessions where the full Velorin research corpus needs to be in context simultaneously:
- Feed Gemini 2.5 Pro all research files from Context.1M.Foundation/ plus Research_Complete/
- Query directly for architectural analysis
- Return findings to Velorin as a file (Jiang reads and synthesizes)

This is the "hold all of it at once" capability Christian Taylor identified as needed. It exists today. Human-routed, not autonomous.

---

[VELORIN.EOF]
