# Velorin Brain — Master Schema

**Type:** Neural File Graph
**Location:** `velorin-system/Velorin_Brain/`
**Shared by:** ClaudeBot (Claude Code CLI), Alexander (Claude Desktop)

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

## Future Considerations (not yet implemented)
- **Neuron consolidation:** Numbered list files (1-100, a-z) to reduce file opens
- **Short-term vs long-term:** Separate fast-association neurons from hard memories
- **Token/hallucination testing:** End of session benchmarks
