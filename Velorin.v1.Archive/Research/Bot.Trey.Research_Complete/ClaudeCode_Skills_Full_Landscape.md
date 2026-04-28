---
destination: Claude.AI/Bot.Trey/Research_Complete/
researcher: Jiang (background agent)
date: 2026-04-05
---

# Claude Code Skills: Full Landscape Analysis
## Research Request: skills-001 | Session 021

---

## Executive Summary

Claude Code skills have evolved from simple slash-command aliases into a full modular instruction layer that functions as the middleware between human intent, deterministic automation (hooks), and Claude's reasoning. As of Q1 2026, the ecosystem contains thousands of public skills across dozens of domains, with a natural taxonomy emerging that closely mirrors how humans organize professional workflows. The strategic finding for Velorin: skills are the right primitive for externalizing agent behavior, but the boot/close/handoff cycle that Velorin currently runs manually cannot be fully automated through skills alone — it requires skills + hooks working in concert, and the pattern is documented, tested, and ready to use.

---

## Part 1: The Public Skills Ecosystem — What Exists

### 1.1 Official Anthropic Repository

**Source:** [github.com/anthropics/skills](https://github.com/anthropics/skills)
**Confidence:** High (primary source)

Anthropic's official skills repository is the canonical reference implementation. It houses Anthropic's own skill-creator, document processing suite (docx, pdf, pptx, xlsx), design tools (algorithmic-art, canvas-design), and development tools (mcp-builder, webapp-testing). Every skill is structured identically: a directory with a `SKILL.md` as the required entrypoint, optional `scripts/`, `references/`, and `assets/` subdirectories.

A separate repository, [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official), contains the plugin-packaged version of the skill-creator and hook-development skill, showing Anthropic's own production pattern for bundling skills with hooks.

### 1.2 The Community Ecosystem — Scale

The community has grown rapidly. Key collections as of April 2026:

| Repository | Skills Count | Domain Focus |
|---|---|---|
| alirezarezvani/claude-skills | 248 production skills | Engineering, Marketing, Product, C-Level, Regulatory |
| VoltAgent/awesome-agent-skills | 1000+ cross-platform | Official + community, Codex/Cursor compatible |
| rohitg00/awesome-claude-code-toolkit | 35 curated + 400k via SkillKit | Multi-domain toolkit |
| travisvn/awesome-claude-skills | ~45 curated | Design, Document, Dev, Security |
| hesreallyhim/awesome-claude-code | Large curated list | DevOps, Security, Research, Orchestration |
| glebis/claude-skills | Community collection | Enhanced AI workflows |
| abubakarsiddik31/claude-skills-collection | Community curated | Productivity, creativity, coding |
| obra/superpowers | 20+ battle-tested | Brainstorm, plan, execute workflow chain |

**Source:** GitHub search results, direct repository inspection.
**Confidence:** High for named repositories. The 400k "SkillKit" claim from agentskills.io appears to be a marketplace aggregator and may include skills for other AI tools beyond Claude Code — treat that number as an ecosystem figure, not Claude-specific.

### 1.3 Natural Taxonomy — How Humans Organize AI Workflows

The most important finding from reverse-engineering these collections is that a natural taxonomy does emerge. Humans do not organize skills arbitrarily. Across the largest collections, the same domain clusters appear independently:

**Tier 1: Universal Categories (appear in every large collection)**
1. Code Quality and Review (linting, security auditing, code review, refactoring)
2. Document Processing (PDF, Word, Excel, PPT — the office suite layer)
3. DevOps and Infrastructure (deploy, CI/CD, Kubernetes, Terraform, Helm)
4. Testing and QA (Playwright, unit tests, integration, fuzzing)
5. Planning and Project Management (issue decomposition, sprint planning, estimation)

**Tier 2: Domain-Specific but Common**
6. Security (CodeQL, Semgrep, vulnerability scanning, penetration testing)
7. API Design and Integration (REST conventions, OpenAPI, SDK generation)
8. Frontend/UI (React, Tailwind, design systems, accessibility)
9. Data and Analytics (SQL, dashboards, metrics, visualization)
10. Communication (reports, newsletters, internal docs, cross-posting)

**Tier 3: Specialized / Emerging**
11. Scientific Research (chemistry, biology, engineering libraries)
12. Regulatory/Compliance (ISO 13485, MDR, FDA, GDPR)
13. C-Suite Advisory (CEO, CFO, CTO decision frameworks)
14. Multi-Agent Orchestration (swarm coordination, agent chains)
15. Memory and Context Management (vector search, session indexing)

**Does this map to Broad-Domain → Area → Specific-Task?**

Yes, clearly. The alirezarezvani collection explicitly organizes 248 skills into 9 primary domains, each with 7-45 sub-skills. The estructura is: Domain (Engineering) → Area (Engineering Powerful Tier) → Skill (RAG Architect). This is a three-layer hierarchy identical in structure to Velorin's Brain regions/areas/neurons.

The key difference: human skill taxonomies tend to organize by *professional role* at the top level (Engineer, Marketer, Product Manager, C-Level), then by *function* at the second level, then by *specific task* at the leaf. Velorin's Brain organizes by *concept type* (principles, agents, protocols). Both are valid — they optimize for different retrieval patterns. Role-based retrieval is faster when you know who the actor is; concept-based retrieval is faster when you know what the problem category is.

**Strategic implication for Velorin Brain architecture:** The Brain's region/area/neuron structure is defensible and mirrors real-world practice. The only upgrade worth considering is adding role-context indexing at the area level so that when a specific agent (Alexander, Jiang, MarcusAurelius) activates a region, the area index can surface agent-relevant neurons first.

---

## Part 2: Auto-Triggering, Hooks, and Automation

### 2.1 How Skills Get Invoked — The Full Picture

**Source:** [code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills)
**Confidence:** High (official documentation)

Skills have three invocation modes:

**Mode 1: Manual user invocation.** User types `/skill-name [arguments]`. This is the most controlled path. Skills with `disable-model-invocation: true` in frontmatter ONLY fire this way.

**Mode 2: Auto-invocation by Claude.** Claude reads all skill descriptions at session start and decides when to load and run a skill based on semantic match to the conversation. This is the "description-as-trigger" pattern. The description must front-load the key use case; descriptions are capped at 250 characters in the skill listing.

**Mode 3: Subagent preloading.** When a subagent is configured with a `skills` field, the full skill content (not just description) is injected at subagent startup, bypassing the semantic-match trigger entirely.

**Can skills be auto-triggered without manual invocation?**

Yes. Claude will automatically load a skill when the conversation matches the description. This works reliably for skills with strong, specific descriptions. The failure mode is when descriptions are weak or when many skills compete for similar triggers — this leads to under-triggering or wrong-skill activation. The skill-creator plugin was built specifically to solve this problem through description optimization.

### 2.2 SessionStart Hooks — The Boot Mechanism

**Source:** [code.claude.com/docs/en/hooks-guide](https://code.claude.com/docs/en/hooks-guide)
**Confidence:** High (official documentation, directly confirmed)

The `SessionStart` hook fires when a session begins OR resumes. It accepts a `matcher` field that can distinguish between session types:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup",
        "hooks": [{
          "type": "command",
          "command": "cat ~/.claude/boot-context.md"
        }]
      },
      {
        "matcher": "compact",
        "hooks": [{
          "type": "command",
          "command": "echo 'Context compacted. Reminder: Bun not npm. Auth refactor sprint active.'"
        }]
      }
    ]
  }
}
```

Matcher values for SessionStart: `startup`, `resume`, `clear`, `compact`.

The hook output mechanism: **any text written to stdout by a SessionStart hook is injected directly into Claude's context**. This is the primary mechanism for deterministic boot-time context injection. It bypasses Claude's selective reading behavior.

SessionStart hooks can also persist environment variables by writing `export KEY=VALUE` statements to `$CLAUDE_ENV_FILE`. These persist across all subsequent Bash tool calls in the session.

**Critical distinction confirmed: Hooks and skills operate in separate lanes.** Hooks are shell commands that run at lifecycle events. Skills are instruction sets Claude loads and executes using its own tools. A `SessionStart` hook cannot directly invoke a skill (e.g., call `/boot-sequence`). What a hook CAN do is inject text into Claude's context that INSTRUCTS Claude to invoke a skill, or inject the contents of a SKILL.md file directly.

### 2.3 The Combined Pattern: Skills + Hooks + CLAUDE.md as a Boot System

This is the most important synthesis question. Based on documentation and community practice, here is what the complete pattern looks like:

**Layer 1: CLAUDE.md (Advisory, Always-Present)**
Contains project identity, conventions, and agent instructions. Loaded every session. Not guaranteed to be followed during very long sessions (advisory, not deterministic).

**Layer 2: SessionStart Hook (Deterministic, Boot-Time)**
Runs a shell script that injects critical context into Claude's context window. This is guaranteed to execute. Pattern: the hook reads a state file and echoes it into context.

```json
{
  "SessionStart": [{
    "matcher": "startup",
    "hooks": [{
      "type": "command",
      "command": "cat $CLAUDE_PROJECT_DIR/.claude/session-state.md && git log --oneline -5"
    }]
  }]
}
```

**Layer 3: Skills (On-Demand Workflows)**
Skills handle the structured work: `/start-session`, `/close-session`, `/handoff`. These can be explicitly invoked after boot, or set with `user-invocable: false` so Claude auto-loads them as reference context.

**Layer 4: PostCompact / PreCompact Hooks (Session Continuity)**
`PreCompact` fires before context compaction. `PostCompact` fires after. A PreCompact hook can write current state to a file. A SessionStart hook with `matcher: "compact"` re-injects it after compaction.

**Full boot/close/state-management pattern in practice:**

```
Session Start:
  1. SessionStart hook (startup) → reads last session state, injects git log, active tasks, agent identity
  2. InstructionsLoaded hook → fires when CLAUDE.md loads, can augment with dynamic data
  3. Claude reads CLAUDE.md → loads advisory instructions
  4. Skills with user-invocable: false → auto-loaded by Claude as reference context
  5. User (or Claude) invokes /start-session skill → confirms active work and creates session log entry

During Session:
  6. PreToolUse hooks → enforce constraints deterministically
  7. PostToolUse hooks → auto-format, auto-save, audit logging

Before Compaction:
  8. PreCompact hook → writes current state snapshot to .claude/session-state.md

After Compaction:
  9. SessionStart/compact hook → re-injects state snapshot into context

Session End:
  10. User invokes /close-session skill → writes handoff document
  11. SessionEnd hook → triggers git commit of state files, sends notification
```

**Has anyone built this complete system?**

Multiple people have built pieces of it. The most complete documented implementations:

- Daniil Okhlopkov's setup (okhlopkov.com) uses CLAUDE.md + skills + hooks + Obsidian vault as persistent context, with 24/7 autonomous operation via Telegram trigger. Skills handle domain expertise (blockchain analysis, cross-posting). Hooks handle guardrails (credential protection). Obsidian provides session-persistent state.

- The "jarvis" project (referenced in rohitg00/awesome-claude-code-toolkit) runs "24/7 AI ops system" with Discord integration, 76 scheduled tasks, and local RAG. Uses Claude Max idle capacity.

- The botmonster.com productivity stack explicitly documents the CLAUDE.md → Skills → Hooks → Worktrees hierarchy with the feedback loop: "Rules violating CLAUDE.md repeatedly should graduate to hooks. Emerging patterns become skills."

- LaunchDarkly's claude-code-session-start-hook (github.com/launchdarkly-labs/claude-code-session-start-hook) uses SessionStart to dynamically add configuration context from their feature flag system.

No one has published a complete open-source boot/close/handoff system exactly matching Velorin's neuron/handoff/multi-agent pattern, but all the primitives exist and are documented.

### 2.4 Hooks Scoped to Skills (Native Integration)

**Source:** Official docs, skills frontmatter reference
**Confidence:** High, with one confirmed bug caveat

Skills can contain their own hook definitions in frontmatter:

```yaml
---
name: deploy
description: Deploy the application to production
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "bash ${CLAUDE_SKILL_DIR}/scripts/validate-deploy.sh"
---
```

These hooks are scoped to the skill's lifecycle — they only run while the skill is active. This is powerful for creating self-contained workflows where the skill brings its own guardrails.

**Important caveat:** There is an open GitHub issue (#17688 in anthropics/claude-code) reporting that skill-scoped hooks defined in SKILL.md frontmatter do not trigger properly within plugins. As of April 2026 this is an active bug. Skill-scoped hooks work in standalone skill files but may fail when the skill is bundled inside a plugin.

---

## Part 3: Skill Writing Best Practices

### 3.1 Bash Injection — The `!` Command Syntax

**Source:** Official documentation, direct examples
**Confidence:** High

The `` !`command` `` syntax runs shell commands as *preprocessing* before the skill content is sent to Claude. Claude never sees the command itself — only the output. This is not something Claude executes during the skill run; it executes before Claude sees anything.

```yaml
---
name: pr-summary
description: Summarize changes in a pull request
context: fork
agent: Explore
allowed-tools: Bash(gh *)
---

## Pull request context
- PR diff: !`gh pr diff`
- PR comments: !`gh pr view --comments`
- Changed files: !`gh pr diff --name-only`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Your task
Summarize this pull request for a non-technical stakeholder...
```

When this skill runs: each `` !`command` `` executes immediately (before Claude sees anything), and its output replaces the placeholder in the final prompt Claude receives.

**Multi-line bash injection** uses a fenced code block with `!` as the language tag:

````markdown
## Environment
```!
node --version
npm --version
git status --short
df -h /tmp
```
````

**Security policy:** To disable shell execution in skills from user/project/plugin sources, set `"disableSkillShellExecution": true` in settings. Bundled and managed skills are not affected.

**Variable available during bash injection:** `${CLAUDE_SKILL_DIR}` gives the skill's directory, enabling portable paths to bundled scripts.

### 3.2 context:fork — What It Spawns and What It Can See

**Source:** Official documentation
**Confidence:** High

`context: fork` causes the skill to run in an isolated subagent context rather than inline in the main conversation.

```yaml
---
name: deep-research
description: Research a topic thoroughly
context: fork
agent: Explore
---
Research $ARGUMENTS thoroughly...
```

**What the forked context CAN see:**
- CLAUDE.md files (loaded normally)
- Files it actively reads using its tools
- The skill content (which becomes its task prompt)
- Skills preloaded by the parent if configured

**What the forked context CANNOT see:**
- Main conversation history
- Files not explicitly read

**The `agent` field** specifies which subagent type drives execution. Built-in options: `Explore` (read-only, codebase exploration), `Plan` (planning-optimized), `general-purpose` (default, full tools). You can also reference custom agents from `.claude/agents/` by name.

**Important distinction from the docs:** With `context: fork`, you write the task in the skill and pick the agent type. The inverse — defining a custom subagent that preloads skills — is configured in the subagent's own `.claude/agents/agent-name.md` file using a `skills` frontmatter field.

**context:fork caveats:**
- Skills with `context: fork` that contain only reference guidelines (not actionable tasks) return without meaningful output — the subagent receives guidelines but has no task to act on.
- Forked context cannot write back to the main conversation's memory; it summarizes and returns results.

### 3.3 Argument Passing — Full Reference

**Source:** Official documentation
**Confidence:** High

| Variable | What it provides |
|---|---|
| `$ARGUMENTS` | All arguments as a single string |
| `$ARGUMENTS[N]` | Zero-indexed individual argument |
| `$0`, `$1`, `$2`... | Shorthand for `$ARGUMENTS[0]`, `$ARGUMENTS[1]`, etc. |
| `${CLAUDE_SESSION_ID}` | Current session ID for logging/file naming |
| `${CLAUDE_SKILL_DIR}` | Directory containing the skill's SKILL.md |

If a skill doesn't include `$ARGUMENTS` anywhere and the user invokes it with arguments, Claude Code automatically appends `ARGUMENTS: <value>` at the end of the skill content — Claude sees the arguments but not in a structured location.

**Example: multi-argument skill:**
```yaml
---
name: migrate-component
description: Migrate a component from one framework to another
---
Migrate the $0 component from $1 to $2.
Preserve all existing behavior and tests.
```

Invoked as: `/migrate-component SearchBar React Vue`
Claude receives: "Migrate the SearchBar component from React to Vue."

**Example: session-scoped logging:**
```yaml
---
name: session-logger
description: Log activity for this session
---
Log the following to logs/${CLAUDE_SESSION_ID}.log:
$ARGUMENTS
```

### 3.4 Reading Multiple Files in Sequence

Two patterns for skills that need to process multiple files:

**Pattern 1: Bash injection to gather file contents at preprocessing time:**
```yaml
---
name: audit-configs
description: Audit all configuration files for security issues
allowed-tools: Read Grep
---
## Configuration files to audit

### package.json
```!
cat package.json 2>/dev/null || echo "not found"
```

### .env.example
```!
cat .env.example 2>/dev/null || echo "not found"
```

Audit the above for security issues...
```

**Pattern 2: Instruction-based sequential reading (Claude uses Read tool):**
```yaml
---
name: review-all-tests
description: Review all test files for coverage gaps
allowed-tools: Read Glob Grep
---
1. Use Glob to find all test files matching **/*.test.ts
2. Read each file in sequence
3. For each file: note what's tested and what's missing
4. Compile a coverage gap report
```

Pattern 1 is faster (no tool-use round trips) but limited to files known at skill-write time. Pattern 2 is flexible and handles dynamic file sets.

### 3.5 Writing Output to a Specific File Path

```yaml
---
name: generate-report
description: Generate a sprint summary report
allowed-tools: Write Bash(date)
---
Generate a sprint summary report and write it to:
reports/sprint-!`date +%Y-%m-%d`.md

The report should include:
- Completed tasks this sprint
- Blockers encountered
- Next sprint priorities

Use the Write tool to save it to the path above.
```

For more complex file naming using session ID:
```yaml
---
name: session-handoff
description: Write a session handoff document
allowed-tools: Write
---
Write a handoff document to:
handoffs/handoff-${CLAUDE_SESSION_ID}.md

Include: what was accomplished, what's in progress, decisions made, next steps.
```

### 3.6 What Makes a Good Skill vs. a Bad Skill

**Source:** Skill-creator documentation, community practitioner writing, leehanchung.github.io deep dive
**Confidence:** High (synthesized from multiple independent sources)

**Good skills:**
- **Focused on one job.** A skill that does one thing well, with a clear trigger description that says exactly when to use it. Skills that try to cover three different workflows confuse Claude's auto-trigger.
- **Descriptions are "pushy."** The skill-creator documentation explicitly uses the word "pushy" — descriptions should include contexts where the skill should activate even if the user doesn't explicitly request it. Example: "Use when explaining how code works, teaching about a codebase, OR when the user asks 'how does this work?'" — the OR clause catches implicit triggers.
- **Progressive disclosure.** Frontmatter (~100 tokens) → SKILL.md body (<500 lines) → bundled reference files (loaded on demand). Don't dump everything into SKILL.md.
- **Explains the why.** Instructions that tell Claude the reasoning behind requirements are more robust than heavy MUST/ALWAYS rules. Claude follows rationale better than mandates.
- **Scoped tool permissions.** `allowed-tools` lists only what the skill actually needs. This reduces permission prompts and makes the skill's footprint predictable.
- **Uses `disable-model-invocation: true` for side-effecting actions.** Deploy, send message, commit — anything with external effects should require explicit user invocation.

**Bad skills:**
- **Vague descriptions.** "Helps with coding" will never auto-trigger reliably. The description budget is 250 characters; use every character.
- **Everything in one file.** SKILL.md files over 500 lines are slower to load and harder to maintain. Move reference docs to `references/`.
- **No argument handling.** Skills that are always invoked with arguments but don't include `$ARGUMENTS` force Claude to parse appended text instead of using structured input.
- **MUST/ALWAYS heavy.** Caps-heavy rule lists fight Claude's reasoning. Brief explanations of why a rule exists outperform imperative mandates.
- **No supporting files when needed.** Complex multi-step workflows that cram everything into SKILL.md content load the entire context on every invocation. Supporting files load only when needed.

---

## Part 4: The Skill-Creator Plugin

### 4.1 What It Is

**Source:** [claude.com/plugins/skill-creator](https://claude.com/plugins/skill-creator), nathanonn.com guide, official SKILL.md source
**Confidence:** High

The skill-creator is not a simple template generator. It is a full empirical development pipeline for building, testing, and optimizing skills — implemented as a skill itself. When you invoke `/skill-creator`, you engage a multi-mode agent that guides you through:

**Mode 1: Create.** Claude interviews you about what the skill should do, what contexts should trigger it, expected input/output format, and edge cases. It then generates a complete SKILL.md file with optimized frontmatter and instructions.

**Mode 2: Eval.** Generates `evals.json` with multiple test prompts, then spawns parallel agents — 3 agents running tests WITH the skill enabled, 3 running the same tests as baseline Claude WITHOUT the skill. Produces side-by-side HTML benchmarks with pass rates, token usage, and timing.

**Mode 3: Improve.** Analyzes eval failures, identifies specific gaps, proposes concrete changes to SKILL.md, then reruns evals in the next iteration directory.

**Mode 4: Benchmark.** Quantitative performance measurement with variance analysis across multiple iterations.

### 4.2 How It Generates Skills

The creation process is context-aware. Before writing anything, skill-creator reads your project structure to understand: what language/framework, existing patterns, what problem you're solving. The generated SKILL.md is tailored to your codebase, not generic.

**Example from documented production use (WordPress security skill):**
- Pass rate: 100% (with skill) vs 90.5% (baseline) = +9.5% improvement
- Token usage: 74,427 (with skill) vs 69,734 (baseline) — slightly higher due to richer context
- Execution time: 276s (with skill) vs 307s (baseline) — 9.9% faster (fewer backtracking loops)

### 4.3 Description Optimization — The Hidden Capability

The most underused feature: trigger accuracy optimization. Skill-creator generates 20 trigger evaluation queries (10 should-trigger, 10 should-not-trigger near-misses), then runs an iterative optimization loop via:

```bash
python -m scripts.run_loop \
  --eval-set trigger-eval.json \
  --skill-path path/to/skill \
  --model <model-id> \
  --max-iterations 5 \
  --verbose
```

This iteratively tests and refines the description until trigger precision improves. For Velorin, where agents need to auto-load the right skills based on context without manual invocation, this optimization step is critical.

### 4.4 Architectural Structure Skill-Creator Enforces

The "3-level progressive disclosure" pattern that skill-creator builds into every generated skill:

- **Level 1:** Metadata (name + description) — always in Claude's context (~100 words)
- **Level 2:** SKILL.md body — in context when skill triggers (<500 lines ideal)
- **Level 3:** Bundled resources — loaded only when skill references them (scripts/, references/, assets/)

This is the correct architecture for a system like Velorin where context budget is precious.

---

## Part 5: Sophisticated Public Setups Using Skills

### 5.1 Complete Production Architectures

**Daniil Okhlopkov's Setup (okhlopkov.com, 2026)**
The most architecturally coherent public example. Three interlocking layers:
- CLAUDE.md as routing OS (106 lines, voice note routing rules, project conventions)
- MCP servers for external system access (Coolify deployment, Telegram messaging, Codex review)
- Skills for domain expertise (ton-analyst for blockchain SQL, ton-profiler for wallet investigation, crosspost for multi-language publishing)
- Hooks for guardrails (pre-commit credential protection)
- Obsidian vault as persistent cross-session memory (files persist, agent understands context from prior sessions by reading the vault)

The key pattern: Claude operates in a "while True loop" autonomously, processing Telegram voice notes, routing via CLAUDE.md rules, executing via skills, persisting via Obsidian.

**Jarvis Project (documented in awesome-claude-code-toolkit)**
24/7 autonomous AI ops using Claude Max idle capacity. Features: Discord integration, 76 scheduled tasks, local RAG system. Uses Claude's scheduled remote triggers (the `/schedule` skill) combined with hooks for task validation.

**Loki-Mode (travisvn/awesome-claude-skills)**
37-agent autonomous startup orchestration across 6 swarms. Skills coordinate agent handoffs. Represents the state-of-the-art in public multi-agent skill architectures.

**obra/superpowers Workflow Chain**
Simple but widely adopted. Three chained skills: `/brainstorm` → `/write-plan` → `/execute-plan`. Each skill is self-contained but designed to consume the output of the prior. The execute-plan skill reads the plan file written by write-plan. This is the documented pattern for stateful skill chains without shared memory.

### 5.2 Trail of Bits Security Skills

High-confidence production deployment. Security firm published CodeQL and Semgrep skills for Claude Code that integrate static analysis tools into the Claude workflow. Skills call the external tools via bash injection, parse their output, and provide structured vulnerability analysis. This is the reference pattern for "skill calls external tool, processes output, returns analysis."

---

## Part 6: Memory Systems and Skills

### 6.1 The Memory Integration Landscape

Three integration patterns exist for connecting Claude Code skills to memory systems:

**Pattern A: MCP Server (most common)**
Memory system exposes tools via MCP. Claude sees `add_memory`, `search_memories`, `get_memories` as available tools. Claude decides when to call them based on conversation context. No skill required — the MCP tools are always available.

Primary implementations:
- **Mem0 MCP server** (mem0.ai): Hybrid vector + key-value + optional graph. Integrates via `.mcp.json`. Reports 90% lower token usage and 91% faster responses vs. full-context approaches. Queries automatically "whenever needed" — Claude decides, not the user.
- **Qdrant MCP server** (official, github.com/qdrant/mcp-server-qdrant): Semantic memory layer on top of Qdrant. Tools: `qdrant-store`, `qdrant-find`, `qdrant-delete`, `qdrant-list-collections`. Used for "semantic code search across codebase" and RAG systems.
- **cldmemory by david-strejc**: MCP Memory Server with human-like memory system.
- **claude-code-memory-mcp-server** (Docker): Anthropic MCP SDK + Mem0 + Qdrant stack in a single container.

**Pattern B: Skill-Triggered Memory Query**
A skill explicitly queries a memory system as part of its execution. The Qdrant vector memory skill (documented at mcpmarket.com) provides exactly this: Claude auto-invokes the skill when context retrieval is needed, and the skill calls `qdrant-find` to return semantically similar stored content.

```
User: "How did we solve the auth issue last month?"
Claude: [auto-triggers memory-recall skill based on description match]
Skill: [calls qdrant-find("auth issue solution")]
Returns: Ranked results from stored session memories
```

**Pattern C: SessionStart Hook + Memory Query**
The most powerful pattern for Velorin's use case. A SessionStart hook runs a script that queries the memory system at boot time and injects relevant context into Claude's context window before the first user message.

```json
{
  "SessionStart": [{
    "matcher": "startup",
    "hooks": [{
      "type": "command",
      "command": "python ~/.claude/scripts/boot-memory-query.py"
    }]
  }]
}
```

The script calls the memory API (Mem0, Qdrant, or local file graph), retrieves the most relevant memories for the current project, and writes them to stdout. Claude receives them as injected context.

### 6.2 The QMD Sessions System — Most Complete Implementation

**Source:** williambelk.com/blog/qmd-sessions
**Confidence:** Medium-High (some page content was CSS, but search results confirm the architecture)

The most sophisticated public implementation of skill + vector memory + auto-query:

- Reads every session JSONL file across all projects
- Extracts and indexes all messages into BM25 + vector search
- Outputs organized markdown files per project/date/session
- Claude Code can search via the qmd MCP server using keyword, semantic vector, or deep search (auto-expands queries, re-ranks results)
- Proactive querying: the system searches **at session start**, before architectural decisions, and after receiving corrections
- Converts the current session before context compaction, updates the index when session ends

This is the closest public analog to what Velorin's Brain attempts: a searchable, semantic knowledge store that gets queried automatically at boot time.

### 6.3 The Gap: No One Has Built Skill + Zep

Searching specifically for Zep integration with Claude Code skills found nothing. Zep (a structured memory system for AI agents) has MCP integration documented generally but no publicly documented Claude Code skill using it. The Mem0 and Qdrant ecosystems are significantly more mature in the Claude Code context.

---

## Part 7: The Taxonomy Mapping to Velorin Brain

The natural human organization of AI workflows, as reverse-engineered from public skill collections, produces this hierarchy:

```
Domain (broad professional area)
  └─ Function (what type of work within the domain)
       └─ Task (specific executable action)
```

Examples:
- Engineering → Security → CodeQL vulnerability scan
- Product → Research → User interview synthesis
- Operations → Infrastructure → Kubernetes deployment

Velorin Brain currently organizes as:
```
Region (broad concept category)
  └─ Area (concept sub-type)
       └─ Neuron (atomic fact/procedure)
```

Both are three-layer hierarchies. The difference is orientation: skill collections organize by *who does the work* (role-first), Brain neurons organize by *what the knowledge is* (concept-first).

**The finding:** Neither is wrong. They optimize for different query patterns. A role-first index helps when you know you're in "Jiang mode" and want to load relevant skills. A concept-first index helps when you're trying to resolve a specific problem and need to find relevant knowledge.

**Recommendation:** Velorin Brain's structure is sound and does not need to be restructured. The potential enhancement is adding a parallel index at the region level that maps agent identities to relevant regions, enabling faster agent-specific activation at session start.

---

## Part 8: The Single Most Important Thing for Velorin

**Question:** What is the single most important thing a team building a custom AI OS should do with skills?

**Answer: Build the boot/close/handoff cycle as a skill + hook pair before building anything else.**

Here is the reasoning:

Every other capability in a multi-agent AI OS depends on agents knowing where they are, what has been done, and what comes next. That is the handoff problem. Velorin currently solves this through manual coordination between sessions — agents write handoff documents, humans read them, humans copy-paste context. This is the bottleneck.

The fully automated version of this exists today, uses documented primitives, and requires four components:

1. **A `/close-session` skill** (with `disable-model-invocation: true`) that the agent invokes at session end. It writes a structured handoff file to a known path, including: active tasks, decisions made, next steps, open questions, and a pointer to the brain regions that were active.

2. **A `SessionEnd` hook** that triggers after the close-session skill runs, commits the handoff file to the GitHub repo (brain), and sends a notification confirming the commit.

3. **A `SessionStart` hook** (matcher: "startup") that reads the last handoff file for the current agent and injects its contents into Claude's context before the first user message. Claude wakes up knowing exactly where things left off.

4. **A `SessionStart` hook** (matcher: "compact") that re-injects the handoff file after context compaction. This prevents mid-session amnesia.

This four-component system eliminates the manual coordination overhead. It means agents boot with full context, close with a clean record, and the GitHub Brain is the source of truth throughout.

The Velorin system already has all the pieces: CLAUDE.md as the agent identity layer, the Brain as the knowledge graph, GitHub as the persistence layer. The missing piece is the automated session lifecycle management that turns it from a manually-coordinated system into a self-managing one.

Skills are the right primitive for this because they let the agent participate in its own session management — the agent writes its own handoff, not just receives one. That agency is what makes the system scale across multiple simultaneous agents.

---

## Confidence Summary

| Finding | Confidence | Basis |
|---|---|---|
| Skills ecosystem scale and taxonomy | High | Direct repository inspection, multiple sources |
| Official SKILL.md format and frontmatter | High | Official documentation |
| Bash injection mechanics | High | Official documentation with examples |
| context:fork mechanics | High | Official documentation |
| Argument passing ($ARGUMENTS, $N) | High | Official documentation |
| SessionStart hook capabilities | High | Official documentation |
| Hooks cannot directly invoke skills | High | Confirmed via documentation (hooks are shell commands, not skill invocations) |
| Skills + hooks combined boot patterns | High | Multiple community implementations documented |
| Skill-creator plugin capabilities | High | Official SKILL.md source + practitioner guides |
| Mem0/Qdrant memory integration | High | Official Mem0 blog, Qdrant MCP documentation |
| QMD sessions system architecture | Medium-High | Search results confirmed; direct page had rendering issues |
| Zep integration gap | High | No evidence found after targeted search |
| Velorin Brain taxonomy mapping | Medium | Extrapolated from community patterns, no direct comparison study exists |
| "Most important thing" recommendation | High | Directly follows from documented primitives and Velorin's documented pain points |

---

## Sources

- [Official Claude Code Skills Documentation](https://code.claude.com/docs/en/skills)
- [Official Claude Code Hooks Guide](https://code.claude.com/docs/en/hooks-guide)
- [anthropics/skills — Official Skills Repository](https://github.com/anthropics/skills)
- [anthropics/claude-plugins-official — Skill-Creator Plugin Source](https://github.com/anthropics/claude-plugins-official/blob/main/plugins/skill-creator/skills/skill-creator/SKILL.md)
- [alirezarezvani/claude-skills — 248 Skills Collection](https://github.com/alirezarezvani/claude-skills)
- [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code)
- [travisvn/awesome-claude-skills](https://github.com/travisvn/awesome-claude-skills)
- [rohitg00/awesome-claude-code-toolkit](https://github.com/rohitg00/awesome-claude-code-toolkit)
- [VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills)
- [anthropics/claude-code — Hook Development SKILL.md](https://github.com/anthropics/claude-code/blob/main/plugins/plugin-dev/skills/hook-development/SKILL.md)
- [Skill Creator Plugin — Anthropic](https://claude.com/plugins/skill-creator)
- [Nathan Onn — Skill Creator Guide](https://www.nathanonn.com/claude-code-skill-creator-guide/)
- [Improving Skill-Creator — Anthropic Blog](https://claude.com/blog/improving-skill-creator-test-measure-and-refine-agent-skills)
- [Lee Hanchung — Claude Skills Deep Dive](https://leehanchung.github.io/blogs/2025/10/26/claude-skills-deep-dive/)
- [Skills Auto-Activation via Hooks](https://paddo.dev/blog/claude-skills-hooks-solution/)
- [How to Activate Claude Skills Automatically](https://dev.to/oluwawunmiadesewa/claude-code-skills-not-triggering-2-fixes-for-100-activation-3b57)
- [Okhlopkov — My Claude Code Setup MCP Hooks Skills](https://okhlopkov.com/claude-code-setup-mcp-hooks-skills-2026/)
- [Botmonster — CLAUDE.md Productivity Stack](https://botmonster.com/posts/claude-md-productivity-stack-custom-commands-git-worktrees-agent-rules/)
- [Mem0 — Add Persistent Memory to Claude Code](https://mem0.ai/blog/claude-code-memory)
- [Qdrant MCP Server — Official](https://github.com/qdrant/mcp-server-qdrant)
- [Qdrant Vector Memory Skill](https://mcpmarket.com/es/tools/skills/qdrant-vector-memory)
- [William Belk — QMD Sessions: Claude Code Memory](https://www.williambelk.com/blog/qmd-sessions-claude-code-memory-with-qmd-20260303/)
- [LaunchDarkly Session Start Hook](https://github.com/launchdarkly-labs/claude-code-session-start-hook)
- [Skill-scoped hooks bug in plugins — Issue #17688](https://github.com/anthropics/claude-code/issues/17688)
- [DEV.to — How I Automated My Entire Claude Code Workflow with Hooks](https://dev.to/ji_ai/how-i-automated-my-entire-claude-code-workflow-with-hooks-5cp8)
- [Claude Code Session Hooks — Auto-Load Context](https://claudefa.st/blog/tools/hooks/session-lifecycle-hooks)
- [Mem0 Self-Hosted via MCP — DEV Community](https://dev.to/n3rdh4ck3r/how-to-give-claude-code-persistent-memory-with-a-self-hosted-mem0-mcp-server-h68)

[VELORIN.EOF]
