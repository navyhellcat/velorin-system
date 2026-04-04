---
class: c-memory
type: layer-research
layer: 4
layer_name: Agent Identity & Memory
status: BUILT — FollowBench ceiling is a known structural issue
session: 016 | April 3, 2026
confidence: 82% instruction architecture | 87% compaction bug | 79% fix
---

# Layer 4 — Agent Identity & Memory
**Status: BUILT. Two known issues: FollowBench constraint ceiling and compaction degradation (fix implemented Session 016).**

---

## Full Research Documents
- `Research_Complete/Jiang.Topic.InstructionLanguageArchitecture.PartA.md` — Threads 1-4
- `Research_Complete/Jiang.Topic.InstructionLanguageArchitecture.PartB.md` — Threads 5-6 + synthesis
- `Research_Complete/Jiang.Topic.AgentTeamsBootDegradation.md` — 796 lines, root cause + fix
- `Bot.MarcusAurelius/AgentTeams.CompactionFix.ImplementationMemo.md` — implementation spec

---

## The Three-Layer Instruction Architecture
(Confidence: 82%)

**Layer 1 — Bootloader/Enforcement:**
BOOT_PENDING fail-closed state machine. AgentSpec structural constraints. 90-100% compliance. This is the enforcement layer — what fires before identity activates.

**Layer 2 — Identity Activation:**
8-component prompt anatomy. Lost in the Middle mitigation via front/back positioning of critical instructions. Identity loads here.

**Layer 3 — Output Control:**
Contrastive negation (RLHF artifact — "don't do X" is processed differently than "do Y"). FollowBench output constraint ceiling.

---

## The FollowBench Ceiling — Critical Known Issue
(Confidence: 85%)

Frontier models reliably comply with approximately **3 simultaneous behavioral constraints**. Rules 4 through N in any instruction set operate probabilistically, not reliably.

**Every Velorin agent boot file exceeds 3 constraints.** This means the current boot architecture is partially decorative above the ceiling. We do not know which rules are below the ceiling (reliable) and which are above it (probabilistic).

**This is not a rules problem. It is a structural problem.** Adding more rules to fix unreliable rules makes it worse. Fix requires: structural enforcement via AgentSpec/bootloader pattern — constraining behavior architecturally, not instructionally.

**Status: Known, documented, not yet fixed. Requires a dedicated architecture session.**

---

## The Compaction Degradation Bug — Fixed Session 016
(Root cause confidence: 87% | Fix confidence: 79%)

**Root cause:** When context compacts in an Agent Teams session, team configuration is stripped. Unlike CLAUDE.md (re-injected after compaction), team metadata has no re-injection mechanism. Anthropic closed related bugs NOT_PLANNED.

**Fix implemented Session 016:**
- `Claude.AI/hooks/pre-compact-team-save.sh` — saves team state to TEAM_STATE.md before compaction
- `Claude.AI/hooks/post-compact-team-restore.sh` — verifies state file is fresh post-compaction
- `settings.local.json` — PreCompact and PostCompact hooks added
- `CLAUDE.md` — Step 0 added: check TEAM_STATE.md before boot
- `Level4.General.Rules.md` — Compaction Recovery rule added

**What remains:** Testing. Start a team session, trigger /compact manually, verify TEAM_STATE.md is written and team context is restored on next turn.

---

## Current Agent Roster
| Agent | Platform | Mandate |
|-------|----------|---------|
| MarcusAurelius | Claude Code CLI | Operations, git, infrastructure, system maintenance |
| Alexander | Claude Desktop Code tab | CEO, orchestration, strategic decisions |
| Jiang | Claude Desktop | Director of Strategic Intelligence, deep research |

---

## Boot File Locations
| File | Path |
|------|------|
| CLAUDE.md | `/Users/lbhunt/CLAUDE.md` |
| Level4 Rules | `Claude.AI/Bot.Agent.Level4/Level4.General.Rules.md` |
| Jiang ReadMe.First | `Claude.AI/Bot.Jiang/Jiang.ReadMe.First.md` |
| MA STARTUP | `Claude.AI/Bot.MarcusAurelius/STARTUP.md` |
| Alexander ReadMe.First | `Claude.AI/Bot.Alexander/` (check current file) |

---

[VELORIN.EOF]
