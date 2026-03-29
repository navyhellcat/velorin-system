# Velorin Brain — Neural File Graph Schema

**What this is:** The Velorin Brain is a neural file graph — a memory architecture shared across all Velorin bots (ClaudeBot, Alexander, and any future agents). Knowledge is stored as tiny atomic files (neurons) organized in regions (folders), connected by rated pointers (synapses).

---

## Core Concepts

### Neurons
- The smallest unit of knowledge. One idea per file.
- Lives at the bottom layer of a region.
- Maximum ~10-15 lines. If it's longer, split it into multiple neurons.
- Every neuron contains:
  1. The knowledge itself (a few lines)
  2. Rated pointers to other neurons

### Synapses (Rated Pointers)
Pointers connect neurons to each other. Each pointer has a **priority rating (1-10)**:

| Rating | Meaning | When to follow |
|--------|---------|----------------|
| 1 | Critical — read immediately | First cycle. Always follow these. |
| 2 | Important — read if level 1 didn't resolve | Second cycle. Follow if still searching. |
| 3-5 | Related — useful context | Third cycle. Expanding the search. |
| 6-10 | Tangential — distant connections | Deep exploration only. Rarely followed. |

### Regions (Folders)
Clusters of related neurons, organized in layers:
- **Layer 0** — Broadest categories (MCP, Auth, Architecture, Tools, Startup, etc.)
- **Layer 1** — Subcategories within a region
- **Layer 2+** — Increasingly specific. Bottom layer = neurons.

Each region has an `_index.md` entry point that lists its neurons and their purpose.

### Activation Pattern
How a bot uses the brain to solve a problem:

1. **Trigger** — A question or task comes in
2. **Locate** — Find the relevant Layer 0 region
3. **Enter** — Read the region's `_index.md` to find the right neuron(s)
4. **Activate** — Read the entry neuron, follow its level 1 pointers
5. **Spread** — Multiple agents can fan out in parallel, each following different pointer branches ("lighting up" the region)
6. **Protect** — After each cycle, the protection layer checks:
   - Did we find what we need? → **Stop, return answer**
   - Are we looping? → **Stop, escalate to user**
   - Do we need more? → **Follow level 2 pointers, expand search**
7. **Repeat** — Cycles continue (level 2, then 3, etc.) until resolved or escalated

### Protection Layer
Runs after every pointer cycle. It asks:
- **Resolved?** — Did the activated neurons answer the question?
- **Looping?** — Are we reading the same neurons again? If yes, stop.
- **Expanding?** — Is following more pointers likely to help, or are we drifting?
- **Decision:** Resolve, expand to next level, or escalate to user.

---

## Structure in GitHub

```
velorin-system/
  Velorin_Brain/
    _BRAIN_SCHEMA.md           ← this file (copied here for reference)
    Layer0_Regions/
      _index.md                ← master index of all regions
    MCP/
      _index.md                ← region entry point
      neurons/                 ← bottom layer
        gdrive-server.md
        github-mcp.md
        ...
    Auth/
      _index.md
      neurons/
        oauth-tokens.md
        github-pat.md
        ...
    (more regions as needed)
```

## Where Each Bot Stores Local Pointers

- **ClaudeBot** (Claude Code CLI): `~/.claude/projects/-Users-lbhunt/memory/` — local MEMORY.md points into Velorin_Brain on GitHub
- **Alexander** (Claude Desktop): Reads Velorin_Brain directly via GitHub MCP or bash MCP

## Rules

1. Neurons are TINY. One idea. If you're writing more than 15 lines, split it.
2. Every neuron must have at least one rated pointer (even if it just points back to its region index).
3. Pointers must include the rating and a one-line reason.
4. Never duplicate knowledge — point to it instead.
5. When adding new knowledge, find the right region first. Create a new region only if nothing fits.
6. The protection layer is NOT optional. Every activation cycle must check before expanding.

---

*This schema governs all Velorin Brain operations. Both bots follow it.*
