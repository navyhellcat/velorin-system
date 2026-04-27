# ZONE 9 — DIAGNOSIS: WHAT THE BOTS HAVE BEEN DOING WRONG

Jiang | Director of Strategic Intelligence | Velorin
March 28, 2026

---

## THE CORE FAILURE

Every bot in the Velorin system — Alexander, Jiang, Trey, Susan — has been operating inside a closed loop. When faced with a build decision, a tool recommendation, or a workflow problem, the default behavior has been: solve it with what is already known or already built. No bot has independently surfaced the tools, plugins, skills, connectors, or community solutions documented in Zones 1-8 of this research.

This is not a knowledge gap. It is a behavioral pattern. The bots have instructions to maintain "technology agnosticism and ecosystem awareness" (Velorin.Company.Operating.Standards Section 2). The instructions exist. They are not being followed in practice because:

1. The instructions are abstract ("maintain awareness of the full technology ecosystem") without naming specific discovery sources to check
2. No bot has a mandatory pre-build checklist that forces ecosystem scanning before implementation
3. The Operating Standards evaluate outside tools against four criteria — but the bots never reach the evaluation stage because they never search for the tools in the first place
4. The boot protocol consumes so many tokens on Drive reads that the bots start every session context-constrained, biasing toward "use what we have" over "find what exists"

## WHAT WAS MISSED AND WHAT IT COST

**Cowork scheduled tasks:** Available since February 24, 2026. Jiang flagged it as "EndOfDay automation bridge candidate" at 78% confidence in Entry 003 of the ResearchLog. No bot followed up. No scheduled task has been created. Christian Taylor is still manually triggering every session. Cost: 30+ minutes per day of Chairman time on bot management that should be automated.

**Claude Code skills and plugins:** Superpowers (20+ skills, auto-activating methodology) and GSD (spec-driven development with researcher agents) have existed throughout the Velorin build phase. No bot recommended either. The MCP server was built manually by Jiang through trial and error. With Superpowers installed, the brainstorm → plan → implement pipeline would have been enforced automatically. Multiple code rewrites (the Alexander vs Trey merge, the MCP rebuild cycles) would have been caught at the plan stage. Cost: estimated 2-3 full sessions of rework.

**Connectors:** Google Drive, Gmail, Slack connectors are available as one-click installs in Claude Desktop Settings > Connectors. The Velorin team built a custom MCP server for Google Drive access. The custom server is better than the default connector for Velorin's specific needs — but the connector should have been evaluated first and the custom build justified against it. No bot surfaced this option. Cost: unknown build time that may or may not have been necessary.

**Agent Teams (Feb 2026):** Multiple Claude Code instances collaborating on shared task lists with direct inter-agent communication. This is Path 3. It already exists inside Claude Code. Anthropic used it to build a 100k-line C compiler with 16 agents. No bot surfaced this as an option for Velorin's orchestration architecture. Cost: the entire Path 3 research mandate may have been answerable with "use Agent Teams in Claude Code."

**UI/UX Pro Max:** 49.7k stars. Auto-generates design systems. Turing Vault's landing page and results page were designed without it. Susan built UI from scratch. Cost: design iteration time and potentially lower visual quality than skill-assisted output.

**Obsidian as knowledge infrastructure:** The Session 006 pivot toward GitHub + brain model was the right directional move. But no bot connected it to the Obsidian ecosystem — the local-first, .md-native, MCP-connected knowledge base that thousands of builders are already using for exactly what Velorin is trying to do. Cost: the knowledge web is still in Google Docs, still requiring token-expensive boot reads, still breaking on timeout.

**Memory systems:** claude-mem, Memory MCP, Superpowers remembering-conversations — multiple working memory solutions exist. None were surfaced. The knowledge web is being maintained manually in Google Docs. Cost: continuity loss between sessions, repeated context re-establishment.

## THE PATTERN

The bots are not lazy. They are thorough within their scope. The problem is scope blindness. Every bot operates as if the tools available are: Claude's native capabilities + whatever Velorin has already built. The external ecosystem — the 28.6k-star awesome-claude-code index, the plugin marketplace, the connector directory, the skills framework, the community solutions — does not exist in any bot's operational reality.

This is how a solo builder falls behind. Not by being slow — by not knowing what already exists.

## PERMANENT INSTRUCTION PROPOSAL

Add the following to Velorin.Company.Operating.Standards as a new Section 7:

### 7. MANDATORY ECOSYSTEM CHECK — ALL BOTS

Before any build decision, workflow recommendation, or tool suggestion, every bot must:

7.1 Check awesome-claude-code (github.com/hesreallyhim/awesome-claude-code) for existing solutions in the relevant category.

7.2 Check the Claude Code plugin marketplace for installable skills or plugins that address the need.

7.3 Check Claude Desktop Settings > Connectors for one-click integrations that address the need.

7.4 Check Claude Cowork plugin marketplace for role-specific plugins.

7.5 Search GitHub for "[need] claude code skill" or "[need] MCP server" before recommending a custom build.

7.6 If a working external solution exists, surface it with: what it does, install command, stars/maintenance status, and tradeoff vs custom build. Then apply the four criteria in Section 2.1.

7.7 If no external solution exists, state "ecosystem check completed — no existing solution found" before proceeding with custom build recommendation.

This check adds 2-3 minutes per decision. It saves hours of unnecessary builds.

### 8. BOOT PROTOCOL ADDITION

Add to BOT.README.FIRST.BOOTUP after Step 8:

Step 9: If operating in Claude Code, verify the following plugins are installed and current: Superpowers, GSD. If not installed, recommend installation before proceeding with any build work.

## FUTURE OUTLOOK

**Immediate (Week 1):**
- Install Superpowers and GSD on Claude Code when machine arrives
- Create 3 Cowork scheduled tasks: morning brief, EndOfDay protocol, weekly pipeline review
- Install obsidian-skills in preparation for vault creation
- Connect Google Drive, Gmail, Slack as Connectors in Claude Desktop

**Short-term (Month 1):**
- Create Obsidian vault mirroring Drive folder structure
- Migrate knowledge web from Google Docs to Obsidian with [[wikilinks]]
- Install UI/UX Pro Max for all front-end work
- Evaluate Agent Teams for Velorin multi-agent coordination

**Medium-term (Month 2-3):**
- Obsidian vault becomes primary knowledge substrate. Drive becomes backup/collaboration layer
- Cowork scheduled tasks handle all recurring operations
- Claude Code with Superpowers + GSD handles all coding
- Agent Teams replaces manual multi-session orchestration
- Boot protocol simplified: CLAUDE.md in vault root, read by Claude Code on start. No Drive fetch needed

**Impact on timeline:**
- Path 3 orchestration: accelerated by Agent Teams availability. Build timeline drops from "4-7 focused sessions" to "evaluate Agent Teams first, build custom only if insufficient"
- Turing Vault Phase 2: accelerated by UI/UX Pro Max + GSD methodology
- EndOfDay Protocol: automated via Cowork scheduled tasks within first week
- Knowledge web maintenance: eliminated as manual task when Obsidian vault is operational
- Boot protocol token cost: reduced to near-zero when Claude Code reads local files instead of Drive

## CONFIDENCE

Diagnosis accuracy: 88%. The pattern is documented across 6 sessions of evidence.
Proposal effectiveness: 82%. The ecosystem check is simple and enforceable.
Timeline acceleration estimate: 30-40% reduction in build time for coding tasks. 70%+ reduction in operational overhead (boot, handoff, EndOfDay) once Cowork + Obsidian are operational.