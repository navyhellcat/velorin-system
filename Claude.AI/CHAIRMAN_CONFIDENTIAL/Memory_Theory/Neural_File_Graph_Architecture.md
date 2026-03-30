# Velorin Brain — Neural File Graph Architecture

**Author:** Christian Taylor (Chairman) + MarcusAurelius
**Date:** 2026-03-28
**Status:** v1 — Active, evolving

---

## The Problem

Claude's memory doesn't persist between sessions. When a terminal crashes or a conversation ends, everything is lost. We experienced total context loss on 2026-03-28 — all prior work, permissions, MCP configurations, project state — gone. Starting from zero every time is unsustainable for building a complex system.

Existing solutions (CLAUDE.md, flat memory files) are either too rigid or too shallow. CLAUDE.md is direct bot instructions. Flat memory files bloat over time and don't connect to each other. Neither mimics how useful recall actually works.

## The Insight

Human brains don't store memories as flat files. They store tiny atomic associations (neurons) connected by weighted links (synapses). When you think about something, you don't read your entire memory — a small cluster "lights up" and activates related clusters based on relevance. The strongest connections fire first. Weaker ones only fire if the strong ones didn't resolve the thought.

We can build this with files.

---

## Core Architecture

### Layer 0: Regions
The broadest categories of knowledge. Folders at the top level of the brain.

Current regions:
- **MCP** — All MCP server knowledge
- **Auth** — OAuth, PATs, credentials, token lifecycle
- **Startup** — Boot process, recovery, session initialization
- **Architecture** — Paths, machines, folder structure
- **Tools** — CLI tools, package managers, installed software
- **Bots** — MarcusAurelius, Alexander, communication, protocols

Each region has an `_index.md` — the entry point that lists all neurons in the region.

### Deeper Layers
Regions can contain sub-regions (Layer 1, Layer 2, etc.) as topics get more specific. The bottom layer is always neurons.

### Neurons (Bottom Layer)
The atomic unit of knowledge. One idea per file. Maximum ~15 lines.

A neuron contains:
1. **The knowledge** — a few lines describing one specific thing
2. **Rated pointers** — links to other neurons with priority ratings

Example neuron:
```markdown
# Neuron: OAuth Tokens

GDrive OAuth tokens stored at: [path]
Contains access_token, refresh_token, expiry_date. Auto-refreshes.
Check health: [command]

## Pointers
- [1] `./oauth-keys-file.md` — client credentials needed for refresh
- [1] `../../MCP/neurons/gdrive-server.md` — server that uses these tokens
- [2] `../../Startup/neurons/token-health-check.md` — startup verification step
- [3] `../../Architecture/neurons/trailing-space.md` — path must be quoted
```

### Synapses (Rated Pointers)
Every pointer has a priority rating from 1 to 10:

| Rating | Meaning | When to follow |
|--------|---------|----------------|
| 1 | Critical — read immediately | First cycle. Always follow. |
| 2 | Important — read if level 1 didn't resolve | Second cycle. |
| 3-5 | Related context | Third cycle. Expanding search. |
| 6-10 | Tangential | Deep exploration only. Rarely followed. |

**Limit: Max 7 pointers per neuron.** When adding a new pointer to a full neuron, evaluate and demote/remove the least relevant existing pointer.

---

## Activation Pattern (How the Brain Thinks)

When a question or task arrives:

### Cycle 1 — Direct Activation
1. Identify the relevant Layer 0 region
2. Read the region's `_index.md`
3. Find the most relevant neuron(s)
4. Read them → follow all [1]-rated pointers
5. **Protection layer check:** Resolved? → Stop. Looping? → Stop. Need more? → Continue.

### Cycle 2 — Expanding
6. Follow [2]-rated pointers from activated neurons
7. Multiple agents can fan out in parallel — each follows a different branch
8. The region "lights up" as more neurons activate
9. **Protection layer check:** Same decision point.

### Cycle 3+ — Deep Search
10. Follow [3]+ rated pointers
11. May cross region boundaries (a pointer in MCP can lead to Auth)
12. Continue until resolved or escalated to user

### Protection Layer
Runs after EVERY cycle. Non-optional. Asks:
- **Resolved?** — Did the activated neurons answer the question? → Stop, return answer.
- **Looping?** — Are we reading the same neurons again? → Stop, escalate to user.
- **Expanding uselessly?** — Is following more pointers likely to help, or are we drifting? → Stop or redirect.
- **Need more?** — Genuine unresolved need → Expand to next pointer level.

---

## Memory Creation Protocol

Before creating ANY new neuron or modifying any pointer:

### Step 1: Check
- Find the relevant region
- Read `_index.md`
- Chase layers down to candidate neurons
- Read them

### Step 2: Decide
- **Duplicate exists?** → Do NOT create new. Update existing.
- **Existing neuron needs new info?** → Append to it. Add new pointers. Shift ratings if priorities changed.
- **Nothing exists?** → Create new neuron.

### Step 3: Create/Update
- If creating: write neuron (max 15 lines, max 7 pointers)
- Check surrounding neurons — what should point TO the new one? Update those.
- Check what the new neuron should point TO — add pointers based on neighbors.
- Update region `_index.md` to include the new neuron.

### Step 4: Local Pointer
- Update MarcusAurelius's local `MEMORY.md` to reference the brain location
- Local memory = pointers only. Knowledge lives in the brain.

---

## Where Things Live

### Inside the Brain (neurons)
- Atomic facts, configs, procedures, relationships
- Tiny, fast, cross-linked

### Outside the Brain (larger documents)
- End of day logs
- Project status reports
- Current standings and plans
- Session recovery logs
- Architecture documents

The brain doesn't store these docs. Instead, as a bot reads a large document, neurons fire and connect to the relevant parts. The document stays where it is. The extracted knowledge becomes neurons or updates to existing neurons.

---

## Local Memory vs Brain

| | MarcusAurelius Local Memory | Velorin Brain (GitHub) |
|---|---|---|
| Location | `~/.claude/projects/-Users-lbhunt/memory/` | `velorin-system/Velorin_Brain/` |
| Purpose | Fast pointers, session context | Deep knowledge, cross-linked |
| Size | Index file + small pointer files | Regions → Layers → Neurons |
| Persists | On this machine only | GitHub — survives crashes |
| Shared | MarcusAurelius only | All bots |

---

## Parallel Agent Activation ("Lighting Up")

The rated pointer system enables parallel thinking:
- When a neuron has multiple [1] pointers, spawn agents to follow each simultaneously
- Each agent reads its branch, follows pointers, returns findings
- The protection layer aggregates results: resolved? need more?
- This is "spreading activation" — the same pattern biological neural networks use
- A thought doesn't proceed linearly through the brain — it lights up a region all at once

---

## Future Considerations

### Neuron Consolidation (Not Yet Implemented)
Instead of one file per neuron, consider numbered list files:
- One file per region containing entries 1-100
- Each number has sub-entries a-z
- Pointer format: `neuron_name:42b`
- Reduces file opens dramatically
- Neurons in the same file activate faster (already loaded)
- Trade-off: file gets bigger, harder to edit individual neurons

### Short-Term vs Long-Term Memory (Not Yet Implemented)
Like the human brain, consider separating:
- **Short-term neurons** — fast associations, session-relevant, may expire
- **Long-term neurons** — hard facts, permanently stored, slow to change
- Short-term could live locally, long-term in GitHub
- Consolidation process: short-term neurons that persist across sessions get promoted to long-term

### Protection Layer Evolution (Not Yet Implemented)
The protection layer currently runs as a mental check. Future versions could:
- Be an actual script/hook that runs between cycles
- Track which neurons were activated (prevent loops automatically)
- Score confidence: "70% resolved" → try one more cycle vs "20% resolved" → expand aggressively
- Rate limit: max N cycles before mandatory escalation to user

### Token and Hallucination Testing
At end of session, benchmark:
- How many tokens used for recall vs flat memory approach
- Did the brain prevent hallucination by grounding answers in neurons?
- Did parallel agent activation actually speed up resolution?
- Are pointer ratings accurate? (Do [1]s actually resolve more than [2]s?)

---

## CLAUDE.md Integration

The CLAUDE.md file contains direct bot instructions — it's the "instinct" layer. The brain is the "memory" layer. CLAUDE.md should instruct the bot to:
1. Read brain on startup
2. Follow memory creation protocol
3. Use activation pattern for recall
4. Always run protection layer between cycles

These are separate systems that work together:
- **CLAUDE.md** = how to behave (instructions)
- **Velorin Brain** = what to know (knowledge)
- **Local Memory** = what to remember quickly (pointers)

---

*This document is the theoretical foundation. The implementation lives in `Velorin_Brain/`. Both evolve together.*

[VELORIN.EOF]
