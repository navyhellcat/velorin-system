# 05 — Infrastructure and Tools
**MCPs, hooks, GPS system, prompting principles, personality encoding**

---

## The MCP Stack

### Required from Day 0

**GitHub MCP**
Connects Claude to navyhellcat/velorin-system for read/write operations.
```json
{
  "github": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-github"],
    "env": {"GITHUB_PERSONAL_ACCESS_TOKEN": "[classic token — ghp_*]"}
  }
}
```
Note: Fine-grained PATs fail. Use classic tokens.

**Filesystem MCP**
Local file access. Scoped to the repo directory.
```json
{
  "filesystem": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-filesystem",
             "/Users/lbhunt/Desktop/velorin-system"]
  }
}
```

### Add After Qdrant Is Running

**Qdrant MCP (Official)**
Makes the Brain MCP-addressable from any platform — including Gemini.
```json
{
  "qdrant": {
    "command": "npx",
    "args": ["-y", "mcp-server-qdrant"],
    "env": {"QDRANT_URL": "http://localhost:6333"}
  }
}
```

### NEVER Add This

**claude-code MCP (self-referential):** Running `claude mcp serve` pointed at itself
causes the `mcp__claude-code__` prefix naming bug. Any agent calling a tool gets a
blocked error and dies silently. This has caused real data loss. Do not add it.

### Fix Required (FW-003)

**velorin-gdrive MCP:** Currently uses OAuth tokens that expire every 7 days
(Google 7-day policy for Testing-mode apps with sensitive scopes).
Fix: migrate to Google Service Account credentials.
Process: Google Cloud Console → create service account → download JSON → update server.js.
Until fixed: Drive WRITES are blocked. Drive reads work via Claude's built-in UUID connector.

### Evaluate When Brain Is Operational

**PAL MCP (BeehiveInnovations/pal-mcp-server, 11.4K stars):** Multi-model bridge —
one MCP server routing to Claude, Gemini, GPT, Grok, Ollama, custom endpoints.
Context flows across models. This aligns with the NemoClaw-style automation direction.
Evaluate before designing the multi-agent orchestration architecture. Do not adopt yet.

---

## The Hook System

Hooks are deterministic. They always run. They cannot be bypassed by LLM non-compliance.
CLAUDE.md instructions are advisory. Hooks are not.

**Confirmed hook configuration in settings.local.json:**

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

**Hooks that are designed but not yet wired (see 07_OpenQuestions.md):**

PreCompact hook: saves team state before context compaction
PostCompact hook: restores team state after compaction
Trigger: pre-compact-task-gate.sh exists, was designed and deleted by CT (too risky without testing)

**The right approach to adding hooks:**
1. Write and test the script standalone first
2. Run it manually several times to confirm behavior
3. Add to settings.local.json with a short timeout
4. Monitor for one session before relying on it

Hook output is injected into context. Cap at ~10,000 characters.
Do not inject large file contents through hooks — reference file paths instead.

---

## The GPS Layer

The GPS system solves one problem: stable agent navigation without hard-coded paths.

**Principle:** Agent names are stable. File paths change. CLAUDE.md points to a stable
roster. The roster points to stable folder conventions. Folder conventions point to
readable files. No single path change breaks the whole system.

**Implementation:**

```
CLAUDE.md
  ↓ (points to)
Velorin.Welcome/_index.md   (contains agent roster)
  ↓ (agent finds their row in roster)
agents/[platform]/[name]/ReadMe.First.md
  ↓ (agent reads)
agents/[platform]/[name]/handoffs/[latest handoff]
  ↓ (agent reads)
brain/_index.md            (only when task requires deep retrieval)
```

**Rules for the GPS layer:**
- CLAUDE.md never contains agent names, tool names, or file paths to specific documents
- Velorin.Welcome/_index.md never contains platform-specific instructions
- Agent roster uses folder paths, not file paths
- Renaming a file requires updating at most ONE pointer
- Adding an agent requires updating the roster in _index.md only

**What breaks the GPS system:**
- Any file in CLAUDE.md that is a specific path to a specific file
- Hard-coded file paths in ReadMe.First files (use relative navigation, not absolute paths)
- Instructions that assume a specific tool is available on all platforms

---

## Prompting Principles

### Window Gravity

**Definition:** The optimization gradient that pulls every AI session toward solving
everything inside its own context window, suppressing routing to better external tools.
CT coined this term. It is real and confirmed via sycophancy literature.

**How it manifests:** The agent concludes "X cannot be done" without checking the
community layer. The agent builds what already exists. The agent cites its own training
knowledge when current data is required.

**Counter-measures:**
- Always check the GitHub repo state before concluding anything about system state
- Always check current date and recent developments before concluding a tool does not exist
- Discovery Mode for research: assume the frame is incomplete
- Explicitly instruct agents: "Check external state via git/files before concluding anything."

### Query Mode

**Tight Mode (default):** Agent assumes the caller's frame is correct. Confirms known
information, fills specific gaps, does not expand scope. Use for operational tasks.

**Discovery Mode (deliberate invocation):** Agent assumes the caller's frame is INCOMPLETE.
Searches for what isn't named in the prompt. Surfaces unknown products, changed landscape.
Use for: research sessions, tool evaluations, ecosystem audits, any task where
"what we don't know we don't know" is the real risk.

**How to declare:** The caller declares the mode. Agents never self-select.
```
MODE: TIGHT — confirm X and fill gaps Y and Z
MODE: DISCOVERY — assume this frame is incomplete, find what I'm not naming
```

### Contrast Negation

Tell the AI what it IS NOT before what it IS. This is the most effective single
technique for preventing generic AI outputs.

Instead of: "You are a strategic intelligence analyst."
Write: "You are not a research assistant. You are not a chatbot. You are not a summarizer.
You are the Director of Strategic Intelligence at Velorin. You see what others cannot."

This works because AI training heavily weights positive descriptions into generic patterns.
Negation forces specificity by eliminating the generic set.

### Short Focused Prompts

One task per prompt where possible. Compound prompts produce compound errors.
If a task requires a long prompt, break it into sequential steps.

The agent stack handles complexity through sequencing. Don't try to route complex
multi-step workflows into a single prompt — sequence them.

### Declarative Language

**Use:** must, do not, never, always
**Do not use:** may, might, consider, you could, it might be worth

Instructions are not suggestions. Write them as rules.

### Banned AI Verbiage

Every agent output must avoid these phrases. They signal generic AI output:
- cutting-edge, robust, state-of-the-art
- leverage (as a verb — acceptable as noun)
- utilize (use "use")
- delve (use "explore" or just state what you're doing)
- innovative, transformative
- best practices (without specifics — always name the practice)
- it's worth noting
- I'll help you with that, Certainly!, Of course!
- In conclusion, To summarize (just say the thing)

---

## Personality Encoding — How to Stop AI from Sounding Like AI

This applies to every agent's ReadMe.First. It determines whether the agent
sounds like a specific person or a generic assistant.

**Method 1: Define the negative space first**
What this agent IS NOT comes before what it IS. See Contrast Negation above.

**Method 2: Operational specificity**
Don't describe values — describe behavior. Not "you are analytical" but
"you never state a conclusion at below 67% confidence. Below that, you continue
researching or flag the gap."

**Method 3: Voice markers**
Give each agent specific language patterns. Jiang has his Jiang's Corner.
Erdős has his "My brain is open" and his characteristic dismissiveness of ugly proofs.
Alexander has "executive presence and directness."
These are not decoration — they produce consistent, recognizable outputs.

**Method 4: Explicit failure modes**
Name the failure mode this agent must not exhibit. Jiang's failure mode is
concluding without sufficient evidence. MA's failure mode is over-engineering.
Erdős's failure mode is solving the wrong problem because he didn't read the
context section. Name it in the ReadMe.

**Method 5: Audience calibration**
Every ReadMe.First should specify who this agent is talking to and in what context.
Jiang speaks to CT only. Trey speaks to CT only. Not to other agents, not to
the public, not to external stakeholders. This changes the register completely.

---

## Research Organization

All research (Trey outputs, Erdős proofs, Jiang research) lives in `tools-and-research/`.
Layer 0 (Velorin.Welcome) stays clean — no research files at the top level.

```
tools-and-research/
├── architecture/           ← Design decisions, system blueprints
│   ├── v2-blueprint/       ← The V2 synthesis documents
│   └── session-synthesis/  ← Session analysis documents
├── math/                   ← Erdős outputs, all proofs
│   ├── locked/             ← Theorems 1-5, Walls A/B/C, Second Law
│   └── future-theory/      ← Temporal Memory Theory, etc.
├── research-complete/      ← Trey research outputs (all topics)
│   ├── memory-systems/     ← MemPalace, Letta, Mem0 operating papers
│   ├── protocols/          ← MCP/A2A research
│   ├── tools/              ← TurboQuant, FlashMoE, Antigravity, etc.
│   ├── ai-ecosystem/       ← ChatGPT vs Gemini, OpenAI ecosystem, etc.
│   └── velorin-specific/   ← Synaptic pruning, temporal validation, etc.
├── brainstorming/          ← Day 10 brainstorm, company alignment sessions
└── external-tools/         ← Tool evaluations that don't fit above
```

**Organization principle:** Research is accessible but not in the way.
An agent that needs the TurboQuant research can find it in `tools/`.
An agent that needs the memory system operating papers finds them in `memory-systems/`.
Nothing is buried. Nothing clutters the Layer 0 workspace.

---

## The Shipping and Receiving Mailboxes

`infrastructure/mailboxes/Shipping/` — Files MA or CT place for delivery to other agents or external systems
`infrastructure/mailboxes/Receiving/` — Files arriving from external sources (Trey Drive output, etc.)

**Protocol:**
- Every file in Receiving must have a destination header as the first lines:
  ```
  ---
  destination: [target folder path]/
  ---
  ```
- MA reads the destination header, moves the file, strips the header, commits
- Never reads file contents during routing unless explicitly required
- .gitkeep files in both folders keep them tracked by git

---

[VELORIN.EOF]
