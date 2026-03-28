# Velorin Brain — Master Schema

**Type:** Neural File Graph
**Location:** `velorin-system/Velorin_Brain/`
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
Neurons should be general and hold pointers to hard memories. They should NOT
hold specifics that may change. They SHOULD hold specifics that apply generally
(e.g., "never use the Mac account name as the Chairman's name" — specific but
permanently applicable). The distinction: will this specific fact need rewriting
when circumstances change? If yes, it belongs in a hard memory that a neuron
points to, not in the neuron itself.

## Other Future Considerations
- **Neuron consolidation:** Numbered list files (1-100, a-z) to reduce file opens
- **Token/hallucination testing:** End of session benchmarks
