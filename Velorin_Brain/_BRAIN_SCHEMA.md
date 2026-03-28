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

- Neurons: ONE idea, ~10-15 lines max
- Every neuron has at least one rated pointer
- Never duplicate — point instead
- Protection layer is mandatory between cycles

See `BOT.Alexander/VELORIN_BRAIN_SCHEMA.md` for full specification.
