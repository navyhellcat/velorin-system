---
class: c-memory
type: layer-research
layer: 0
layer_name: Storage & Persistence
status: BUILT
session: 016 | April 3, 2026
---

# Layer 0 — Storage & Persistence
**Status: BUILT. Settled. No decisions pending.**

---

## What This Layer Does
Everything lives here permanently. The ground truth of the Velorin system. All other layers read from and write to this layer. If it doesn't exist here, it doesn't exist.

---

## Current Velorin Architecture

### GitHub (navyhellcat/velorin-system) — PRIMARY
- Canonical source of truth for all system architecture, agent rules, brain neurons, session records
- Pull-before-read rule: always pull before reading. Local is a cache.
- Push immediately after write. Any agent that writes and doesn't push has created a split state.
- MCP: `mcp__github__*` tools available

### Google Drive — SECONDARY
- Working documents, research outputs, larger files not suited for GitHub
- Accessible via `mcp__velorin-gdrive__*` tools
- Read: `gdrive_read_file`, `gdrive_search`, `gdrive_list_folder`
- Write: `gdrive_create_doc`, `gdrive_update_doc`, `gdrive_overwrite_doc`

### Local Filesystem — EXECUTION ENVIRONMENT
- `/Users/lbhunt/Desktop/velorin-system/` — architecture repo (synced to GitHub)
- `/Users/lbhunt/Desktop/Velorin/Velorin Code/` — active build (synced to GitHub)
- Local reads/writes via native Code tab tools (Read, Write, Edit, Glob, Grep, Bash)

---

## Open Questions
None. This layer is settled.

Transition trigger to watch: when active topic documents exceed ~50-80 files in Drive, retrieval will require semantic search rather than known filenames. At that point: add a vector index at Layer 2. Drive docs remain canonical — the vector index is a search interface, not a replacement.

---

[VELORIN.EOF]
