# Velorin Brain — Master Schema

**Type:** Neural File Graph
**Location:** `velorin-system/Claude.AI/Velorin_Brain/`
**Shared by:** All Velorin agents (consult `Bots/_index.md` for current roster)

## How to Use This Brain

1. Find the region → read its `_index.md`
2. Read the entry neuron → follow level 1 pointers
3. Fan out parallel agents on branches if needed
4. Protection layer after each cycle: resolved? looping? expand?

## Pointer Ratings

| Rating | Action |
|--------|--------|
| 1 | Read immediately — critical dependency |
| 2 | Read if level 1 didn't resolve |
| 3-5 | Related context, expanding search |
| 6-10 | Tangential, deep exploration only |

## Rules

- Neurons: ONE idea, ~15 lines max — split if bigger
- Max 7 pointers per neuron — demote/remove lowest-rated when at capacity
- Every neuron has at least one rated pointer
- Never duplicate — point instead
- Protection layer is mandatory between cycles

## Memory Creation Protocol

Before creating ANY new neuron:
1. Check region → chase layers → read candidate neurons
2. If duplicate exists → update/append/shift ratings, do NOT create new
3. If new → create neuron, wire pointers from/to neighboring neurons
4. Update local memory pointer (MEMORY.md) to reference brain location

Larger documents (logs, project status) live OUTSIDE the brain.
Brain neurons fire as those docs are read — extract knowledge into neurons, don't copy docs.

See `Bots/neurons/memory-protocol.md` for full protocol.
See `BOT.Alexander/VELORIN_BRAIN_SCHEMA.md` for full specification.

## Target Architecture — Brain Layers (not yet implemented)

The brain should mature into a layered funnel, top to bottom:

### Layer 1: Base Personality
Encompasses everything. Tied to BOTH the top and bottom of the funnel.
General character, values, behavioral patterns. Informs how all other layers
are interpreted and expressed. Feeds down into everything; the bottom neuron
layer feeds back up into it.

### Layer 2: Hard Memories
Facts that don't change or change rarely. History, mathematics, established
relationships, proven architecture. The stable foundation other layers build on.

### Layer 3: Archival Lessons Learned
Already processed — outputs have been applied to neurons, personality, hard
memories. Still accessible going down the funnel if needed but generally
skipped during normal activation. Safety net for deep retrieval.

### Layer 4: Neurons (current system)
Bottom of the funnel. Small, cross-linked, fast-firing. The working layer
that handles day-to-day activation and retrieval.

### Key Rule: Generality in Neurons
Neurons default to general for ease of bot flow, but CAN contain specific
information when: (a) the information is short and direct enough to fit the
neuron title, and (b) it won't need rewriting when circumstances change.
This allows each user's personal neurons to be different while keeping the
structure universal.

Specifics that change frequently belong in hard memories that neurons point to.
Specifics that are permanent and atomic (e.g., "the Mac account name is not the
Chairman's name") can live directly in a neuron.

The test: would this neuron need to be rewritten if shipped to a different user?
If yes → the specific belongs in a hard memory. If no → it can stay in the neuron.

## Productization Architecture — Brain Shipping Model

The Velorin Brain is designed to be shipped as a product. The shipped version contains:

### What Ships (Universal)
- `_BRAIN_SCHEMA.md` — how brains work, universal rules
- Region folders with named sublayer structure
- Empty `_index.md` files with A-Z, 1-100 neuron slot format
- Empty `neurons/` directories — grow with use
- Bot maintenance processes (Scribe, Custodian, Mobility) — they know HOW to
  write neurons, not WHAT to write in them

### What Does NOT Ship (Personal)
- No pre-loaded neurons — each user's brain grows from zero
- No identity data — filled during structured intake
- No domain-specific knowledge — built through interaction

### Onboarding Sequence
1. **Structured intake test** — design questions that map directly to neuron
   regions. Extracts cognitive style, decision patterns, risk tolerance, domain
   priorities, goals, avoidances. Each answer fires a neuron into the correct
   region with initial pointer ratings.
2. **Account connections** — banking (Box 2), calendar (time patterns), social
   (behavioral signals), health apps (Box 3), email (professional patterns).
   Auto-generates hard memories that neurons point to.
3. **First bot analysis** — Scribe creates cross-domain pointer connections the
   user wouldn't think to make. The gap between WHO they are (test) and WHERE
   they are (connections) is where the product operates.
4. **First session** — presents what the brain sees, asks user to correct errors.
   Brain is ~30-40% developed — enough to be useful, enough gaps to keep growing.

### Why This Model
Pre-loaded neurons carry assumptions from the original user's cognitive profile.
Process that works for a 99.9th percentile verbal thinker with ADHD executive
function gaps may be wrong for someone with a different profile. Each brain must
develop its own firing patterns from its own data.

The intake test + account connections are the moat. Nobody can shortcut it because
the intake IS the product. The brain that results is tuned to one specific person.

## Other Future Considerations
- **Neuron consolidation:** Numbered list files (1-100, a-z) to reduce file opens
- **Token/hallucination testing:** End of session benchmarks
- **Intake test design:** Research assignment for Jiang — questions must extract
  data that predicts behavior and maps to actionable architecture, not just categorize
