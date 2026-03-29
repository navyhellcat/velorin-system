# Velorin Brain — Master Schema

**Type:** Neural File Graph
**Location:** `Claude.AI/Velorin_Brain/` (LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Velorin_Brain/` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Velorin_Brain/`)
**Shared by:** All Velorin agents

---

## Structure: Region → Area → Neurons

The brain is organized in three physical levels:

| Level | What it is | Naming convention | Example |
|-------|-----------|-------------------|---------|
| **Region** | Broad functional category (folder) | `brain.region.[name]` | `brain.region.operations` |
| **Area** | Specific zone within a region (folder) | `brain.area.[name]` | `brain.area.startup` |
| **Neurons** | Consolidated neuron file at the bottom | `neurons.[region].[area]` | `neurons.operations.startup` |

**Neurons exist ONLY at the bottom.** Regions and Areas are folders with `_index.md` files. The `neurons.md` file inside each Area contains all neurons for that Area, indexed A-Z with numbered entries.

---

## Layer Convention

| Layer | Contents |
|-------|----------|
| Layer 0 | `Velorin_Brain/` itself |
| Layer 1 | `_index.md` (brain entry) + Region folders |
| Layer 2 | Region `_index.md` files + Area folders |
| Layer 3 | `neurons.md` files inside Areas |

---

## Neuron Format (inside neurons.md)

```
## A. [Category Name]

### A1. [Neuron Title]
[Content — max ~10 lines]
last-touched: YYYY-MM-DD
Pointers: [1] A2 | [2] neurons.connectivity.auth.A3 | [3] neurons.agents.roster.B1
```

- **A-Z** = category sections within the file
- **1-100** = individual neurons within each category
- **Pointers** use IDs within same file (`A2`) or full path for cross-area (`neurons.[region].[area].[id]`)

---

## Pointer Ratings

| Rating | Action |
|--------|--------|
| 1 | Read immediately — critical dependency |
| 2 | Read if level 1 didn't resolve |
| 3-5 | Related context, expanding search |
| 6-10 | Tangential, deep exploration only |

---

## Rules

- Neurons: ONE idea, ~10 lines max per entry
- Max 7 pointers per neuron — demote/remove lowest when at capacity
- Every neuron has at least one rated pointer
- Never duplicate — point instead
- Every neuron has a `last-touched` timestamp
- Protection layer mandatory between activation cycles

---

## Generality Rule

Neurons default to general for ease of bot flow, but CAN contain specific
information when: (a) short and direct enough to fit the neuron title, and
(b) won't need rewriting if circumstances change.

The test: would this neuron need rewriting if shipped to a different user?
If yes → the specific belongs in a hard memory, neuron points to it.
If no → it can stay in the neuron.

---

## Memory Creation Protocol

Before creating ANY new neuron:
1. Find relevant region → read `_index.md`
2. Find relevant area → read `neurons.md`
3. If duplicate exists → update/append/shift ratings, do NOT create new
4. If new → add entry in correct A-Z position, wire pointers, update `last-touched`

---

## How to Activate (Read Pattern)

1. Find the region → read its `_index.md`
2. Find the area → read `neurons.md`
3. Follow level 1 pointers (may cross areas/regions)
4. Batch all cross-area reads into one parallel call
5. Protection layer: Resolved? Looping? Need more?
6. If not resolved → follow level 2 pointers, repeat

---

## Productization Architecture — Brain Shipping Model

### What Ships (Universal)
- `_BRAIN_SCHEMA.md` — how brains work, universal rules
- Region folders with named Area structure
- Empty `neurons.md` files with A-Z slot format
- Bot maintenance processes (Scribe, Custodian, Mobility)

### What Does NOT Ship (Personal)
- No pre-loaded neurons — each user's brain grows from zero
- No identity data — filled during structured intake
- No domain-specific knowledge — built through interaction

### Onboarding Sequence
1. Structured intake test → fires neurons into correct areas
2. Account connections → generates hard memories neurons point to
3. First bot analysis → Scribe creates cross-domain pointers
4. First session → presents what the brain sees, user corrects errors

---

## Current Regions

| Region | Areas | Neuron Count |
|--------|-------|-------------|
| Operations | Startup, Architecture, Tools | 19 |
| Connectivity | Auth, MCP | 11 |
| Agents | Roster, Protocols, LevelRules | 9 |
| Principles | RewardAlignment, CoreDrives | 4 |
| **Total** | **10 areas** | **43 neurons** |
