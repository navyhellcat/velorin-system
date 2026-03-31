---
destination: Claude.AI/Bot.Jiang/Research_Needed/
status: UNPROCESSED
priority: HIGH
requested_by: Christian Taylor (Chairman)
date: 2026-04-01
---

# Research Request: Claude Code in Replit Shell — Velorin Applications

## Context

CT flagged this as high-potential during Session 016 review. The current Velorin system has four documented persistence/portability failures (Root Problems 3 and 4 in CompanyAlignment1.Summary.md):
- CronCreate timers die on session close
- `durable: true` confirmed non-functional
- Agents require manual reconstruction every session open
- Every path is hardcoded to `/Users/lbhunt/Desktop/` — cannot ship

Replit shell running Claude Code (`claude --print --dangerously-skip-permissions`) is an always-on, cloud-hosted alternative. The pattern already works in Velorin — Scribe uses it as a subprocess today. The question is how far it extends.

## Research Questions

### Thread 1 — Feasibility and Constraints
1. What are the exact steps to install and authenticate Claude Code CLI in a Replit shell? What authentication options exist (API key vs OAuth vs claude.ai login)?
2. What Replit plan is required for always-on execution? What are the cost tiers (free / Core / Teams)?
3. What are the CPU/memory/disk constraints on Replit Repls that would affect Claude Code subprocess execution?
4. Can a Replit Repl authenticate to a private GitHub repo via PAT and perform git pull/push reliably?
5. What is Replit's uptime SLA / restart behavior? How does a Repl handle crashes, restarts, and cold starts?

### Thread 2 — Velorin-Specific Applications
6. Which current Velorin pain points does Replit-hosted Claude solve that local CronCreate cannot?
   - Terry (shipping/receiving monitor) — viability as always-on Replit process?
   - Scribe escalation processor — viability as cloud subprocess?
   - Deep Research Pipeline wrapper — viability as Replit-hosted script?
   - Session Monitor T009 — needs active Claude session; does Replit change this?
7. What is the minimum viable Replit setup to replace the 4 known dead timer agents (T001-T004)?
8. Can a Replit-hosted Claude agent read from and write to the velorin-system GitHub repo as its persistent state layer — effectively treating GitHub as the filesystem?

### Thread 3 — Architecture Implications
9. If Replit becomes always-on infrastructure, what changes in the boot sequence? Does MA still need to recreate timers on session open?
10. What is the IPC pattern between a Replit-hosted agent and a local Claude Code CLI session? File-based via GitHub? Direct API call? Something else?
11. Does running Claude Code on Replit expose the same Agent Teams IPC bugs (Issue #23415, #25135, #23620), or does the Replit environment sidestep them?
12. What are the security implications of storing an Anthropic API key + GitHub PAT in Replit Secrets for a private personal operating system?
13. Could Replit-hosted Claude serve as the always-on component of Path 3 (orchestrator layer) before the Claude Agent SDK build is complete? What would that look like architecturally?

### Thread 4 — Portability Intersection
14. If Replit uses `$VELORIN_ROOT` pointing to a cloned GitHub repo rather than a local disk path, does this solve the portability problem for cloud-hosted agents while the local agents still use hardcoded paths?
15. What is the git workflow for a Replit agent that needs to read state, process, and write results back — without conflicting with local MA pushes?

## Deliverable

Not a recommendation to adopt. A map of what is actually possible, what it costs, what it breaks, and where it fits in the Velorin architecture. Confidence threshold: 75%.

Specific outputs needed:
- Feasibility verdict on each Thread 2 application (viable / conditional / not viable + reason)
- Architectural diagram (text-based) of Replit agent ↔ GitHub ↔ local MA data flow
- Cost estimate for always-on Replit running Claude Code at current Velorin task volume
- Single recommended first experiment: lowest-risk, highest-signal test CT could run in one session

## Session Structure

This is a single-session research topic. No CT authorization required before Jiang begins — CT has already directed this as a priority.

[VELORIN.EOF]
