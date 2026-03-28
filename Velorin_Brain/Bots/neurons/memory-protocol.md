# Neuron: Memory Creation Protocol

Before creating ANY new neuron or pointer:

1. Find relevant region → read _index.md
2. Chase layers → read candidate neurons
3. Duplicate? → Update existing, don't create new
4. New info on existing neuron? → Append, add pointers, shift ratings
5. Nothing exists? → Create new neuron, wire pointers from/to neighbors

**Limits:**
- Max 7 pointers per neuron
- Max ~15 lines per neuron — split if bigger
- Overwrite/demote lowest-rated pointers when adding new ones at capacity

**Larger docs** (logs, project status, standings) live OUTSIDE the brain.
Brain neurons fire and connect AS those docs are read — the doc doesn't go in the brain, the knowledge extracted from it does.

## Pointers
- [1] `./claudebot.md` — ClaudeBot must follow this protocol
- [1] `./alexander.md` — Alexander must follow this protocol
- [2] `../../_BRAIN_SCHEMA.md` — master schema references this
