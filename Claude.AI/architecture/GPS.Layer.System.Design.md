---
document: GPS Layer System Design
version: 1.0
date: 2026-04-05
session: 021
status: DESIGN — not yet built
author: CT + Jiang Session 021
---

# Velorin GPS Layer System Design

## The Core Principle

GPS over Map. A printed map is accurate at one point in time and breaks the moment
anything changes. A GPS system navigates by structure — it doesn't know the specific
destination in advance, it knows how to find it. When the destination moves, the GPS
still works. Only the pointer updates.

This principle governs every layer of Velorin's boot and navigation architecture.

---

## The Problem This Solves

The current system (as modified by MA) has CLAUDE.md containing hard-coded file paths:
```
| Agent | Path |
|-------|------|
| Jiang | /Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/ |
```

This is a printed map. Every file rename, folder restructure, or agent addition
requires editing CLAUDE.md. Every platform that can't read the local filesystem
is locked out. Every agent has to be pre-configured from the outside.

The GPS system eliminates all of this.

---

## Architecture

### Layer 0 — Universal Entry Point

**Lives on:** GitHub (navyhellcat/velorin-system) — the primary source of truth.
Also mirrored locally at `/Users/lbhunt/Desktop/velorin-system/Claude.AI/`

**Platform access:**
- Claude Code: reads locally from disk
- Gemini: reads directly from GitHub (full access)
- ChatGPT/GPT: reads from GitHub (limited but functional)
- Any future platform: GitHub is the universal entry point

**What Layer 0 contains:**
- General files only. No subfolders opened. Clean.
- A universal onboarding document: "what Velorin is, how to find your identity"
- An agent roster/routing file: "if your name is X, navigate to Bot.X"
- Global operating standards (Velorin.Company.Operating.Standards.md)
- The DNA file (Velorin.Company.DNA.md)
- Environmental detection (ENVIRONMENT_DETECTION.md)

**What Layer 0 does NOT contain:**
- Agent-specific instructions
- Hard-coded file paths to specific sessions or neurons
- Anything that changes frequently

**The routing mechanism:**
Agent reads Layer 0 → finds its name in the roster → gets directed to Bot.[Name]
No specific path needed. The agent knows its name. The roster maps name → folder.
The folder is always `Bot.[Name]` — the structure IS the path.

**Critical rule:** Layer 0 files change rarely. When they do change, it is a significant
system event, not routine maintenance.

---

### Layer 1 — Agent Home (Bot.[Name])

**Location:** `Claude.AI/Bot.[Name]/`

**What the agent does on arrival:**
1. Reads ALL files at this level (not into subfolders — files only)
2. Inventories the subfolder NAMES only (does not open them)
3. Self-configures based on what it finds

**What Layer 1 files contain:**
- `ReadMe.First.md` — who this agent is, what its purpose is
- `Hooks.md` — hooks this agent should load before operating
- `Skills.Pointer.md` — pointer to skill registry for this agent type
- `Brain.Access.md` — single pointer to Brain entry neuron (see below)
- `Session.Handoff.[latest].md` — current session state
- Any agent-specific operational rules

**Critical rule:** The agent reads Layer 1 files. It inventories Layer 1 subfolders
by NAME only. It does not read into subfolders unless it has a specific need.
This means subfolders can be added, renamed, or restructured without breaking the agent.

**What Layer 1 subfolders contain (inventoried, not read):**
- Research_Results/
- Research_Complete/
- Protocols/
- Working.Docs/
- etc.

The agent knows these exist. It navigates into them only when needed.

---

### Layer 2 — Subfolders (Navigated On Demand)

**Location:** `Claude.AI/Bot.[Name]/[SubfolderName]/`

Agent enters a subfolder when its task requires it — not on every boot.
The subfolder name tells the agent what's inside. The agent decides whether to enter.

This layer can change freely. Files can be added, removed, renamed.
The only upstream dependency is the subfolder name visible in Layer 1 inventory.

---

## The Brain Connection

The Brain is NOT part of the GPS system. The GPS system finds the agent and
configures it. The Brain is where the agent thinks.

The connection is exactly ONE file in Layer 1:

**`Brain.Access.md`** — contains:
- The entry point neuron path in the Brain
- The activation instruction: "follow [1] pointers from this entry"
- Nothing else

The agent accesses the Brain when it needs to think deeply — not on every boot.
When it does, it enters the Brain at the specified neuron and follows the pointer
system to activate the relevant region.

The GPS gets the agent to its station.
The Brain is what the agent uses once it's there.
These are separate systems connected by one pointer.

---

## Subagent Self-Configuration

When a subagent is spawned, the parent names its type. The subagent:

1. Reads Layer 0 — finds `Bot.[agenttype]`
2. Arrives at Layer 1 — reads its files, inventories subfolders
3. Finds `Hooks.md` — loads its hooks
4. Finds `Skills.Pointer.md` — loads relevant skills
5. Operates

The parent does NOT configure the child.
The child configures itself using the same GPS pattern every agent uses.

**Result:**
- New subagent types: create `Bot.[newtype]` folder, populate Layer 1. Zero parent changes.
- Subagent behavior changes: edit Layer 1 files. Zero spawn logic changes.
- Every agent, regular or sub, follows the same boot pattern. Uniform, scalable, decoupled.

---

## Hooks in the GPS System

Hooks are NOT stored in `settings.json` as the source of truth.
`settings.json` contains a thin relay hook that reads `Hooks.md` from Layer 1.

```json
{
  "hooks": {
    "SessionStart": [{
      "matcher": "startup",
      "hooks": [{
        "type": "command",
        "command": "cat $CLAUDE_PROJECT_DIR/Claude.AI/Bot.Jiang/Hooks.md"
      }]
    }]
  }
}
```

The real hook definitions live in `Hooks.md` at Layer 1.
When hook behavior changes: update `Hooks.md`. Zero `settings.json` changes.
The relay is stable. The content is dynamic.

---

## What MA Changed — And Why It Was Wrong

MA converted the GPS system to a printed map:
- Hard-coded paths in CLAUDE.md
- Agent routing baked into the boot instructions
- No structural navigation — explicit file references everywhere

The result: every file rename requires CLAUDE.md edits. Every new agent requires
CLAUDE.md edits. Folder restructuring requires CLAUDE.md edits.

**Restoration required:**
- [ ] Reconstruct clean Layer 0 entry point on GitHub
- [ ] Rebuild agent routing via roster file (not CLAUDE.md hard-coding)
- [ ] Create Hooks.md files in each Bot.[Name] folder
- [ ] Create Brain.Access.md in each Bot.[Name] folder
- [ ] Reduce CLAUDE.md to: read Layer 0, find your name, navigate to Bot.[Name]

---

## Open Questions (Not Resolved in Session 021)

1. **Routing file format:** What exactly does the agent roster look like?
   Simple table? Structured YAML? Needs to be readable by Gemini, GPT, Claude Code.

2. **Layer 0 update protocol:** What is the process when Layer 0 must change?
   Should require CT authorization + Steel Man before any edit.

3. **Hooks relay timing:** `settings.json` relay fires at startup.
   Does the Layer 1 Hooks.md content load in time to affect the same session?
   Or does it take effect on next session start?

[VELORIN.EOF]
