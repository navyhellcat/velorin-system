# 01 — Repo and Environment Setup
**Day 0 — Mac Studio**

---

## Mac Studio Baseline

Hardware locked in Session 023:
- M4 Max, 14-core CPU, 32-core GPU, 36GB unified memory, 512GB SSD
- macOS Sequoia
- 10GbE ethernet → TRENDnet TEG-S750 switch
- WiFi disabled on all machines. Ethernet only.
- Mullvad WireGuard VPN at router level.

Nothing installed yet for Velorin. Start here.

---

## Step 1 — System Dependencies

Install in this order. No shortcuts.

```bash
# Homebrew (if not present)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core tools
brew install git node python3 jq

# Verify
git --version && node --version && python3 --version && jq --version
```

---

## Step 2 — Claude Code CLI

```bash
npm install -g @anthropic-ai/claude-code

# Authenticate
claude login

# Verify
claude --version
```

**Model setting:** Set `claude-sonnet-4-6[1m]` for 1M context in terminal sessions.
This goes in `settings.local.json` once the repo is set up.

---

## Step 3 — Git Configuration

```bash
git config --global user.name "Christian Taylor"
git config --global user.email "[CT's email]"
git config --global credential.helper osxkeychain
```

Authenticate GitHub CLI if not already done:
```bash
brew install gh
gh auth login
```

---

## Step 4 — Create the New Repo

Option A: New clean repo on GitHub
```bash
gh repo create velorin-system --private --clone
cd velorin-system
```

Option B: Refactor existing repo
```bash
cd /Users/lbhunt/Desktop/velorin-system
git pull origin main
```

Either way, the structure below is what you're building toward.

---

## Step 5 — GPS Navigation Layer and Folder Structure

### The GPS Principle (Velorin.Principles.md Principle 1)

The entire folder structure above the Brain is a self-describing convention. Any agent — Claude, Codex, GPT 5.5, Gemini, a future vendor, a persona-derived sub-agent from FW-009 — can boot by following the convention without being told file paths. The structure IS the routing mechanism. No config file maps paths. No bootloader lists locations. The folders have semantic names; the agent discovers its context by name-based lookup through a registry at the top level.

**Three load-bearing properties:**

1. **Discoverable by convention, not by instruction.** An agent named "Jiang" finds the folder matching its name without being told the path. An agent with no name reads the top-level entry document and asks CT who it is. The folder naming convention is the only routing mechanism.

2. **Layered progressive disclosure with clean physical boundaries.**
   - **Layer 0 (universal):** Top-level documents every agent reads. Company identity, operating standards, principles, vocabulary. Zero agent-specific content. Small. This is "where am I and what does this system believe."
   - **Layer 1 (agent home):** The agent's own folder. Everything needed to be fully operational lives here, flat — ReadMe, handoff, operating rules. This is "who am I and what's my current state." The agent reads everything in this folder at boot.
   - **Layer 2 (agent workspace):** Subfolders inside the agent's home — research archives, working docs, protocols. The agent does NOT read these at boot. It builds a directory map on first entry and calls back into specific subfolders when a task requires it. This is "where do I go when I need to go deeper."

3. **Portable without editing.** If the repo moves to Mac Studio, gets cloned by Codex, gets accessed via GitHub raw URLs by a Gemini Gem, or gets handed to a new vendor — zero files need editing. The convention works because folders have semantic names and the progressive disclosure pattern is physical (different folders, not different sections of the same file).

**The Brain is NOT part of the navigation layer.** The Brain is a separate system (Principle 2) accessed on demand when a task requires deep knowledge retrieval. Its physical location in the repo is a navigation concern; its internal structure is governed by the Brain math (02_Architecture.md, 03_BrainAndMath.md). The GPS layer routes agents TO the Brain entry point; it does not govern what happens inside the Brain.

### Folder Structure — PENDING STAGE 0 DESIGN

The specific folder names, nesting conventions, and file naming patterns are not locked. They will be designed at Stage 0 build start, potentially informed by Trey research on multi-agent repo navigation patterns at that time.

**Open naming decisions (resolve at Stage 0):**
- Agent folders organized by platform (`agents/claude/jiang/`) vs flat by name (`agents/jiang/`). Trade-off: platform grouping breaks GPS if an agent moves platforms; flat by name loses the platform signal.
- Dot-separated names (`Bot.Jiang/`) vs bare names (`jiang/`). Trade-off: dots carry v1 identity but are distinctive; bare names are cleaner for cross-vendor consumption.
- Brain location: `brain/` at root vs nested. The Brain is separate from navigation (Principle 2) but its location matters for the convention.
- Layer 0 document set: Company DNA, Operating Standards, Principles, Vocabulary, Consensus Filter, Welcome/entry-point — confirm complete list.
- Research and tools location: grouped by topic vs grouped by source agent. Trade-off: by-topic is more navigable; by-agent preserves provenance.

**Preliminary top-level layout (subject to Stage 0 design):**
```
velorin-system/
├── [entry-point doc]           ← GPS pointer only (zero paths, zero instructions)
├── [Layer 0 folder]            ← Universal docs all agents read
├── [agents folder]             ← Agent home folders (Layer 1 + Layer 2 per agent)
├── brain/                      ← The neural file graph (separate system, on-demand access)
├── [research folder]           ← All research, organized by [topic or agent — TBD]
├── infrastructure/             ← Programs, hooks, MCP configs, queues
├── skills/                     ← Skills registry (skill_dependencies.yaml + SKILL.md files)
└── [sessions/logs folder]      ← Handoffs, daily logs, session records
```

**Note:** The current `Claude.AI/` folder structure is v1 legacy. The v2 structure will be created at Stage 0. Existing files migrate during that transition.

*→ Forward note: Trey research on multi-agent repo navigation conventions may be commissioned at Stage 0 build start. Apply Consensus Filter (Q3: does Velorin share the constraint driving the consensus pattern?). GPS principle governs — convention over configuration, even if consensus favors explicit config files.*

---

## Step 6 — CLAUDE.md (GPS Pointer)

Write this exactly. Nothing more.

```markdown
# CLAUDE.md — Velorin System

You are an agent in the Velorin system. Before doing anything else:

1. Identify your name from the context you were given.
2. Navigate to: velorin-system/Velorin.Welcome/_index.md
3. Find your name in the agent roster.
4. Navigate to your agent folder.
5. Read your ReadMe.First.
6. Read your most recent session handoff.
7. Proceed.

If you have no assigned name, read Velorin.Welcome/_index.md and ask
Christian Taylor who you are before proceeding.

The Brain is not loaded on every boot. Access it when a task requires
deep knowledge retrieval — not before.

Pull from GitHub before reading any file that may have changed:
  cd /Users/lbhunt/Desktop/velorin-system && git pull origin main --quiet
```

This file never contains: file paths, tool names, agent instructions,
platform-specific commands, or anything that changes.

---

## Step 7 — Velorin.Welcome/_index.md

This is the universal entry point. Every agent on every platform reads this.
No file paths. No tool names. No platform references.

```markdown
# Velorin System — Entry Point

## What Velorin Is
A personal operating system for Christian Taylor. Not a productivity tool.
Not a chatbot. A substrate that makes every future AI interaction smarter
than the last because the Brain compounds.

CT is the Chairman. All agents report to him directly.
No agent communicates with another agent without CT in the loop.

## Agent Roster
| Name | Platform | Folder |
|---|---|---|
| MarcusAurelius | Claude Code CLI | agents/claude/marcus/ |
| Jiang | Claude Desktop Code tab | agents/claude/jiang/ |
| Jiang2 | Claude Code CLI terminal | agents/claude/jiang/ (same folder as Jiang) |
| Alexander | Mac Studio Cowork | agents/claude/alexander/ |
| Trey1 | Gemini Deep Research Gem | agents/gemini/trey/ |
| Trey2 | Gemini Deep Research Gem | agents/gemini/trey/ (same folder, different Gem) |
| Erdős | Gemini Deep Think Gem | agents/gemini/erdos/ |

## Navigation Rule
You know your name. Your folder is listed above.
Navigate there. Read your ReadMe.First. Read your handoff. Proceed.

## Universal Operating Principles
1. CT is Christian Taylor. Refer to him as Christian Taylor. Mac account lbhunt is not his name.
2. Direct and blunt. No filler. No encouragement. No sycophancy.
3. Accuracy over speed. Never fill knowledge gaps with inference. Flag uncertainty and ask.
4. GitHub is source of truth. Pull before any read that matters. Push after any write.
5. The Brain is separate from navigation. Boot is fast. Brain access is on demand.
6. Technology agnostic. Claude is the foundation, not the ceiling.
7. Never steer CT away from other agents or platforms.
8. Save CT's reasoning verbatim. His thinking is pattern-chained and non-repeatable.

## The Brain
The Brain is the long-term memory of the entire system. A neural file graph
organized into Regions → Areas → neurons, connected by rated pointers (1-10).
Traversal uses Personalized PageRank. Access it when a task requires deep
knowledge retrieval — not on boot.

Brain location: brain/_index.md
```

---

## Step 8 — settings.local.json

This lives at `~/.claude/settings.local.json`. Not in the repo.

```json
{
  "model": "claude-sonnet-4-6[1m]",
  "CLAUDE_CODE_SUBAGENT_MODEL": "claude-sonnet-4-6[1m]",
  "ENABLE_TOOL_SEARCH": "true",
  "permissions": {
    "allow": ["Bash(*)", "Read", "Write", "Edit", "Glob", "Grep"],
    "deny": ["Bash(rm)", "Bash(rmdir)", "Bash(sudo)", "Bash(trash)"]
  }
}
```

`ENABLE_TOOL_SEARCH: true` is mandatory. Without it: ~40K tokens of MCP
schema overhead per session. With it: ~2K. Confirmed in Session 016.

---

## Step 9 — Git Hooks Configuration (Minimal for Now)

The full hook system is TBD. For Day 0, one hook matters:

Add to `~/.claude/settings.local.json`:
```json
{
  "hooks": {
    "SessionStart": [{
      "matcher": "startup",
      "hooks": [{
        "type": "command",
        "command": "cd /Users/lbhunt/Desktop/velorin-system && git pull origin main --quiet 2>&1 | tail -1",
        "timeout": 15
      }]
    }]
  }
}
```

This pulls from GitHub before every session automatically.
Compaction hooks (PreCompact/PostCompact) are designed but not yet wired —
see `07_OpenQuestions.md`.

---

## Step 9b — FW-003: GDrive Service Account Migration (DO THIS BEFORE Step 10)

OAuth tokens expire every 7 days (recurred Session 027 and Session 035 — HIGH priority).
Full process: see `Velorin.MacStudio.Setup.md` Phase 0.
Short version: Google Cloud Console → create service account → share Claude.AI folder →
download JSON key → update velorin-gdrive-mcp/auth.js → test without tokens.json.

---

## Step 10 — MCP Servers (Initial Set)

Wire these in Claude Desktop config at:
`~/Library/Application Support/Claude/claude_desktop_config.json`

Required from Day 0:
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "[your-github-pat]"
      }
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem",
               "/Users/lbhunt/Desktop/velorin-system"]
    }
  }
}
```

Add after Qdrant is running (see `06_BuildSequence.md`):
```json
{
  "qdrant": {
    "command": "npx",
    "args": ["-y", "mcp-server-qdrant"],
    "env": {
      "QDRANT_URL": "http://localhost:6333"
    }
  }
}
```

**Do NOT add:** `claude-code` as an MCP server (self-referential, causes
`mcp__claude-code__` prefix bug that kills agents). This was confirmed
and must stay out.

**velorin-gdrive:** Currently broken (OAuth 7-day expiry). Fix requires
migrating to a Google Service Account (logged as FW-003). Until then,
Drive writes are blocked. Drive reads work via Claude's built-in connector.

---

[VELORIN.EOF]
