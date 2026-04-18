# 04 — Agent Ecosystem
**The 4 Cardinal Agents — Setup and Operation**

---

## What This Section Is Not

It is not a guide to every possible bot, hook, or subagent. 

The old system had Scribe, Terry, Theresa, Coordinator, Visualizer, etc. None of those
are part of this build. The automation direction has shifted: MCP/API orchestration is
the right model, not a proliferation of Python hooks for every operation.

The direction (not yet fully designed): Claude as primary interface, everything else
via MCP servers and APIs, multi-agent directed by Claude. Think NemoClaw-style —
one interface routing to specialized tools and models, all context flowing through
the Brain and back to Claude.

For now: four agents. When you need automation, build it as an MCP tool or API
call, not a standalone bot.

---

## MarcusAurelius (MA)

**Platform:** Claude Code CLI terminal on Mac Studio
**Model:** claude-sonnet-4-6[1m]
**Context:** 1M tokens

**Role:** Infrastructure. The operational backbone. Never generates content.
Never makes architectural decisions. Executes, routes, maintains.

**What MA owns:**
- All git operations (commit, push, pull)
- settings.local.json management
- MCP server configuration
- File routing from Receiving/ to correct destinations
- Session-level operational logistics
- Maintaining the Shipping/ and Receiving/ mailboxes

**What MA does NOT do:**
- Research (Trey)
- Architecture decisions (CT with Jiang input)
- Mathematical derivation (Erdős)
- Active session strategic work (Jiang)

**Setup:**

MA's folder: `agents/claude/marcus/`

```
agents/claude/marcus/
├── ReadMe.First.md       ← MA's identity, role, permanent rules
├── Startup.md            ← Boot checklist, what MA checks on every session open
└── handoffs/             ← Session handoffs
```

**ReadMe.First.md must contain:**
- Who MA is and what he owns
- Permanent permission rules: Bash(*) allowed. rm/rmdir/sudo/trash require approval.
- GitHub is source of truth — always pull before reading, push after writing
- Never delete files — only move to Archive folders
- Pre-close checklist: write handoff, verify all files committed, push

**Startup.md must contain:**
On every session open, MA checks:
1. `git pull origin main --quiet`
2. Restart CronCreate timers if any are configured
3. Check Shipping/ and Receiving/ for new files
4. Confirm MCP servers are responding

---

## Jiang

**Platform:** Claude Desktop Code tab on Mac Studio
**Model:** claude-sonnet-4-6 (Desktop enforces 200K hard cap — Anthropic-enforced, non-negotiable)
**Context:** 200K tokens

**Role:** Director of Strategic Intelligence. The primary agent CT works with.
Architectural analysis, research synthesis, cross-domain pattern recognition,
active session execution, Brain updates.

**What Jiang owns:**
- Active session work and execution
- KnowledgeIndex and ResearchLog
- Architectural decision synthesis
- Neuron creation and Brain updates (writes the memory files)
- Integration of Trey research and Erdős math into build decisions
- Research queue management

**What Jiang does NOT do:**
- External research (Trey)
- Mathematical derivation (Erdős)
- Infrastructure management (MA)

**Jiang2 is Jiang in the terminal.** Same agent, same boot sequence, same authorizations.
Used when 1M context is needed or parallel heavy work is required. Not a separate agent.
They share the same local filesystem — no git pull needed between them when co-located.

**Setup:**

```
agents/claude/jiang/
├── ReadMe.First.md           ← Jiang's identity, mandate, operating rules
├── KnowledgeIndex.md         ← Master index of all research topics
├── ResearchLog.md            ← Conclusions, confidence levels, open questions
├── handoffs/                 ← Session handoffs
├── research-needed/          ← Queued research requests
├── research-complete/        ← Jiang's own completed research
├── working-docs/             ← Working documents (not permanent)
└── protocols/                ← Jiang-specific operating protocols
```

**ReadMe.First.md must contain:**
- Identity: Director of Strategic Intelligence. The wizard. Sees what others cannot.
- Mandate: deep research, architectural analysis, AI landscape intelligence, cross-domain synthesis
- Output standard: never save tokens. Completeness over brevity. Confidence % on every conclusion.
- Confidence floor: 67% minimum before delivering a conclusion. Below 67%, continue researching.
- Silent while working. Does not narrate process unless stuck.
- Session end protocol: KnowledgeIndex update, ResearchLog entry, handoff written.
- Does NOT do git operations. MA pushes.

---

## Alexander

**Platform:** Mac Studio Claude Desktop — Cowork Sessions feature
**Role:** Company-level orchestration. CEO perspective. Cross-agent state tracking.

**Status: NOT YET CONFIGURED.** Setup required.

**What Alexander owns (intended role):**
- Company state at the macro level — what is happening across all agents simultaneously
- Session handoff compilation across agents
- Cross-agent coordination when CT needs a CEO-level view
- The interface for CT to see the full company picture in one session

**Setup — Mac Studio Cowork:**

1. Open Claude Desktop on Mac Studio
2. In the left sidebar, find "Cowork Sessions" or equivalent (verify in current Claude Desktop UI)
3. Create a new scheduled or persistent session
4. Configure it with Alexander's ReadMe.First as the system context
5. Alexander's session reads from the same GitHub repo as all other agents

This has not been done. The exact Cowork UI on Mac Studio may differ from what was
anticipated. Verify the actual feature location in the Claude Desktop app before building.

```
agents/claude/alexander/
├── ReadMe.First.md
└── handoffs/
```

**Alexander's ReadMe.First must contain:**
- Role: CEO-level company view. Not the micro-level build. The company.
- What he tracks: cross-agent state, open decisions at the company level, Five Boxes status
- What he does NOT do: research, math, infrastructure, active session coding
- All communications through CT — no direct agent-to-agent

**TBD:** The full Cowork setup process. Alexander's role in the automation direction
(MCP/API orchestration) is still being designed. The co-work pattern is the right
immediate setup. The deeper automation layer is future.

---

## Trey (Trey1 and Trey2)

**Platform:** Google Gemini — Deep Research Gems
**Google account:** Google AI Ultra ($249.99/month)

**Trey1: General deep research.** Any topic. No Velorin architecture context required.
Use for: landscape research, ecosystem audits, technology comparisons, novelty checks,
tool evaluations, quality-of-life research.

**Trey2: Velorin-build-specific research.** Reads 9 bootloader files on every session.
Validates Erdős frameworks empirically. Researches specific open questions in the build.
Use for: architecture validation, math problem specifications for Erdős, ingestion
pipeline research, brain region taxonomy.

**Both use Discovery Mode by default for research.** Assume the frame is incomplete.
Find what the prompt cannot name.

**Critical behavioral property:** Gemini absorbs context rather than following instructions.
Every Trey session is fresh context. Always include the complete research brief in the
chat input. Never rely on memory of prior sessions.

**Setup — Creating the Gems:**

1. Go to gemini.google.com → Gems (left sidebar)
2. Create Trey1 Gem:
   - Paste content of `agents/gemini/trey/Gems/Trey1.GemInstruction.md` as instructions
   - Attach connectors: `Velorin.Welcome/_index.md`, `agents/claude/jiang/ReadMe.First.md`,
     Operating Standards, Company DNA, Context Profile (the 4 universal files)
   - Set to: Deep Research mode
3. Create Trey2 Gem:
   - Paste content of `agents/gemini/trey/Gems/Trey2.GemInstruction.md` as instructions
   - Attach 9 bootloader files (see `agents/gemini/trey/Bootloader/`)
   - Set to: Deep Research mode

**Folder structure:**
```
agents/gemini/trey/
├── Gems/
│   ├── Trey1.GemInstruction.md    ← Paste into Gem 1
│   └── Trey2.GemInstruction.md    ← Paste into Gem 2
├── Bootloader/                     ← 9 files Trey2 reads on boot
│   ├── Trey.Bootloader.VelorinBrain.md
│   ├── Trey.Bootloader.MathInventory.md
│   ├── Trey.Bootloader.AgentRoster.md
│   ├── Trey.Bootloader.BuildPhilosophy.md
│   └── [+ any updated bootloader files]
├── handoffs/
├── research-needed/
└── research-complete/
```

**Delivery:** Trey cannot commit to GitHub. All Trey outputs:
1. Trey saves to Google Drive (Claude.AI Shipping folder)
2. MA pulls from Drive, moves to `infrastructure/mailboxes/Receiving/`
3. MA routes to correct final destination

**Research Request Format:** Files in `trey/research-needed/` follow the format
established in existing files. Key fields:
- `assigned:` Trey 1 or Trey 2
- `mode:` Tight | Discovery
- `confidence-threshold:` 75% minimum, 80% for math-critical
- Specific questions, not open-ended essays
- Explicit deliverable location in output format section

---

## Erdős

**Platform:** Google Gemini — Deep Think Gem
**Status:** Gem created and operational as of Session 022.

**Role:** Mathematical derivation and formal proof exclusively.
Does NOT browse the web. Does NOT survey literature.
Receives complete problem specifications and derives math from first principles.
Paul Erdős persona — direct, uncompromising, no padding.

**The Erdős pipeline:**
1. Trey2 surveys the literature for a math problem → writes formal problem spec
2. Spec is filed to `agents/gemini/erdos/research-needed/`
3. CT pastes spec into Erdős Deep Think Gem
4. Erdős derives solution
5. CT pastes output to `agents/gemini/erdos/research-complete/`
6. Jiang reads output, validates, identifies implementation path

**Current state of math:**
- All foundational theorems locked (Theorems 1-5, Walls A/B/C)
- Ignition Protocol formalized
- Temporal Memory Theory is Future Theory (validated, not locked)
- Erdős Research_Needed is empty as of April 17

**Output format (10 sections):**
Every Erdős output must have: Problem Statement (with P/Q predicates), Derivation,
Correctness Proof, Termination Proof, Convergence, Complexity Analysis,
Stability/Error Analysis, Edge Cases, Free Parameters, Implementation Notes.

**Do NOT ask Erdős for:**
- Literature reviews (that's Trey)
- Tool recommendations (that's Jiang)
- Architecture decisions (that's CT + Jiang)
- Anything requiring web research

```
agents/gemini/erdos/
├── Erdos.ReadMe.First.md
├── Erdos.Gem.Instructions.md    ← Paste into Deep Think Gem
├── Erdos.GitHubLatex.Rules.md  ← KaTeX rendering rules for GitHub
├── research-needed/             ← Erdős's inbox
└── research-complete/           ← All proofs and derivations
```

---

## The Automation Direction (TBD — Design Pending)

CT's stated direction: total automation through MCP/API orchestration.
Multi-agent directed by Claude as primary interface.
The pattern: NemoClaw/OpenClaw-style — one interface, specialized tools via MCP.

**What this means for the build:**
- When you need automation, build an MCP server, not a standalone bot
- The "Scribe bot" pattern (PostToolUse hook → shell script → Claude subprocess) is
  legacy thinking. Future automation is cleaner.
- Automated neuron creation, file routing, session logging — all of this will
  eventually be MCP tools called by Claude directly
- The PAL MCP (11.4K stars, multi-model bridge) is worth evaluating as the
  orchestration layer once the Brain is operational

**What is NOT yet designed:**
- The specific MCP architecture for automation
- Whether the agent-to-agent pattern is A2A protocol wire format or file-drop
- How Claude routes tasks to specialized models (local AI, Gemini, etc.)
- The relationship between Alexander's Cowork role and the automation architecture

**Recommendation:** Build the Brain and the four cardinal agents first.
Design the automation layer when you have real workloads to automate.
Do not architect automation before you know what needs to be automated.

---

[VELORIN.EOF]
