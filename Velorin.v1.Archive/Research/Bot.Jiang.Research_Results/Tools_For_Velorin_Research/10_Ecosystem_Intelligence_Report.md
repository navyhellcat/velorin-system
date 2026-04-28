# VELORIN ECOSYSTEM INTELLIGENCE REPORT

What the bots missed. What it cost. How to fix it.

Jiang | Director of Strategic Intelligence | March 28, 2026

---

## THE PROBLEM

Every Velorin bot operates inside a closed loop. When faced with a build decision, the default behavior is: solve it with what is already known or already built. No bot has independently surfaced the tools, plugins, skills, connectors, or community solutions that exist in the Claude Code ecosystem. The instructions for ecosystem awareness exist in Operating Standards Section 2. They are not being followed because they are abstract, name no specific discovery sources, and include no mandatory pre-build checklist.

## WHAT EXISTS AND WAS NOT SURFACED

| Tool | What it does / Why it matters |
|---|---|
| Superpowers | 20+ auto-activating skills for Claude Code. Enforces brainstorm-plan-implement pipeline. Subagent-driven development. Git worktree isolation. Memory system with SQLite vector search. Would have prevented multiple rebuild cycles. |
| GSD | Spec-driven development system. Researcher agent runs before planning. Plan checker validates against goals. 428 tests. Production-grade. The project management layer Velorin described but never built. |
| Cowork Scheduled Tasks | Available since Feb 24. EndOfDay protocol automation. Morning briefs. Weekly pipeline reviews. No custom build required. Jiang flagged it at 78% confidence. No bot followed up. |
| Agent Teams | Feb 2026. Multiple Claude Code instances collaborate on shared task lists with direct inter-agent communication. This is Path 3. It already exists. Anthropic built a 100k-line C compiler with 16 agents using it. |
| Connectors | One-click integrations: Google Drive, Gmail, Slack, Salesforce, Asana, Box, Figma, Canva. Custom MCP connectors addable via URL. The Drive connector should have been evaluated before the custom MCP build. |
| UI/UX Pro Max | 49.7k stars. Auto-generates design systems. 50+ styles, 161 palettes, 57 font pairings. |
| Obsidian Skills | Official agent skills by Obsidian CEO. Teaches Claude Code to read/write Obsidian formats natively. MCP server available. The knowledge base infrastructure Velorin needs. |
| Obsidian Vault | Local-first .md knowledge base. No boot protocol needed. No Drive fetch failures. No token cost on reads. Claude Code reads files directly. Thousands of builders using this exact pattern for what Velorin is trying to do. |

## WHAT IT COST

Estimated 2-3 full sessions of rework from code rewrites that a plan-first methodology would have caught. 30+ minutes daily of Chairman time on manual bot management that Cowork scheduled tasks would automate. The entire Path 3 research mandate may have been answerable with Agent Teams. Knowledge web maintenance is manual when it should be automatic. Boot protocol consumes tokens on every session when local file reads would cost zero.

## THE FIX

Permanent Operating Standards Addition (Section 7): Before any build decision, every bot must: (1) Check awesome-claude-code index. (2) Check Claude Code plugin marketplace. (3) Check Claude Desktop Connectors. (4) Check Cowork plugin marketplace. (5) Search GitHub for relevant skills/MCP servers. (6) Surface findings with install command, star count, and tradeoff analysis. (7) If nothing found, state 'ecosystem check completed' before proceeding.

## IMPLEMENTATION TIMELINE

**Week 1:** Install Superpowers + GSD. Create 3 Cowork scheduled tasks. Install obsidian-skills. Connect Drive, Gmail, Slack as Connectors.

**Month 1:** Create Obsidian vault. Migrate knowledge web. Install UI/UX Pro Max. CLAUDE.md replaces boot protocol.

**Month 2-3:** Obsidian primary. Drive backup. Cowork handles operations. Agent Teams replaces manual orchestration. Boot protocol token cost drops to near-zero.

## IMPACT ESTIMATE

| Area | Estimated Impact |
|---|---|
| Coding task build time | 30-40% reduction |
| Operational overhead | 70%+ reduction |
| Path 3 timeline | Evaluate Agent Teams first — may eliminate custom build |
| Boot protocol cost | Near-zero with local .md files |
| Chairman daily bot mgmt | 30+ min/day recovered |
| Knowledge web maintenance | Automated via Obsidian graph |

Confidence: Diagnosis 88%. Proposal 82%. Timeline acceleration 30-40% builds, 70%+ operations.

[VELORIN.EOF]