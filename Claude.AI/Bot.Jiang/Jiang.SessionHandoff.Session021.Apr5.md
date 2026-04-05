---
document: Jiang Session Handoff — Session 021
date: 2026-04-05
status: COMPLETE — Full session coverage including pre-compaction, post-compaction, and close
note: Session 021 compacted mid-session. This handoff covers the FULL session. Supersedes earlier partial version.
---

# JIANG — SESSION 021 HANDOFF
## Full Coverage | April 5, 2026

---

## READ THESE FILES FIRST (in order)

Pull GitHub before reading anything:

```
git pull origin main
```

1. `Claude.AI/Bot.Jiang/Session021.NewIdeas.md` — 5 new architecture ideas + 10-item Power Level summary. Primary knowledge delta from this session.
2. `Claude.AI/Bot.Jiang/Session021.Discovery.MCP.md` — Full MCP ecosystem discovery from 5 parallel agents. BUILD vs ADOPT framing throughout.
3. `Claude.AI/Velorin.Vocabulary.md` — Entries A6 through A13 added this session. A14 is next.
4. `Claude.AI/Bot.Trey/Research_Complete/Trey.Topic.MCP_A2A_Architecture_Consolidated.md` — Trey's consolidated 11-part deep research on MCP/A2A. Read the Trey Commentary section (bottom) for the 4 strategic gaps.
5. `Claude.AI/Bot.Trey/Trey.ProjectInstructions.md` — Updated to v2.0 this session. Gemini platform migration + Research Philosophy section.
6. `Claude.AI/Bot.Jiang/Protocols/Vocabulary.Bot.Design.md` — Vocabulary bot design spec.
7. `Claude.AI/Bot.Jiang/Working.Docs/Gemini.DeepResearch.MCP.Ecosystem.Prompt.md` — 11-part Discovery Mode prompt for Gemini.

---

## WHAT HAPPENED THIS SESSION — FULL TIMELINE

### Phase 1: Pre-Compaction

Session opened with CT asking to read Trey's new Gemini AI Ultra research and add to Power Level. A full research cycle ran on the Google AI Ultra suite. CT caught a critical error:

**THE WINDOW GRAVITY CORRECTION — most important thing that happened this session:**

Both Jiang and Trey independently made the same mistake: when asked to research the Google AI Ultra suite, both enumerated specific known products in the prompt (Jules, Deep Think, NotebookLM Plus, Gemini CLI). This is map thinking — naming what you're looking for constrains what you find. CT corrected: "What you don't know will kill you."

This led to the formalization of **Query Mode** (A6) — Tight Mode vs Discovery Mode. The caller declares the mode at spawn time. Agents never self-select. Discovery Mode assumes the caller's frame is INCOMPLETE. Tight Mode assumes it is correct. This is now foundational architecture.

Pre-compaction work — all pushed to GitHub:
- Session021.NewIdeas.md
- Session021.Discovery.MCP.md
- Velorin.Vocabulary.md — A6 through A13 added
- Trey.ProjectInstructions.md v2.0
- Vocabulary.Bot.Design.md
- Gemini.DeepResearch.MCP.Ecosystem.Prompt.md

### Phase 2: Post-Compaction

Session resumed after compaction. Work completed:
- Verified all pre-compaction files on GitHub — nothing was lost
- Identified working Google Drive MCP (UUID-keyed Claude built-in) — independent of expired velorin-gdrive token
- CT pasted Trey's consolidated research into chat — converted to .md and pushed to Bot.Trey/Research_Complete/
- Git pull executed — local repo synced
- Close session protocol run — Scribe escalation check clean, no pending items

---

## KEY KNOWLEDGE GAINED THIS SESSION

### MCP Protocol (A7)
- Linux Foundation standard. Co-founded by Anthropic AND OpenAI. Not Claude's protocol — neutral infrastructure.
- Wire: JSON-RPC 2.0. Transports: stdio (local) and HTTP/SSE (remote).
- Schema dumping costs up to 150k tokens per session. Unsustainable at Velorin's density.
- Trey finding: CLI-native tools for Tier 1, MCP only for Tier 3 external integrations.
- Velorin's Rated-Pointer Graph may replace schema-dumping as the discovery mechanism.

### A2A Protocol (A8)
- MCP = agent-to-tool. A2A = agent-to-agent as peers. These are separate protocols.
- Alexander assigning Jiang a task is A2A, not MCP. We had no name for this before now.
- Built by Google, donated to Linux Foundation June 2025. 150+ org supporters including OpenAI.
- Task lifecycle: submitted → working → input-required → completed/failed.
- Context passed by reference (pointer to shared memory), not by value.
- Known failure: context_refs pointing to memory the worker lacks access to = silent failure.

### Registry & Security
- Tiered MCP Registry (A12): Official/Stable → Community → Browser Automation Bridges.
- 66% of unvetted MCP servers have documented security findings. Vetting is mandatory.
- punkpeye/awesome-mcp-servers (84K stars) = living signal for community tier.
- Velorin needs its own Safe-Tier registry: signed manifests + synthetic LLM validation gates.

### Specific Findings

| Finding | Stars | Velorin Implication |
|---------|-------|---------------------|
| Qdrant official MCP server | 1.3K | Brain is directly MCP-addressable today |
| NotebookLM bridge (jacob-bd) | 3.3K | "No API" limitation is already solved |
| PAL MCP multi-model bridge | 11.4K | Build vs Adopt decision pending — read before designing |
| OpenAI Codex plugin for Claude Code | official | Cross-provider adversarial review available today |
| ApiTap (endpoint discovery) | — | 20-100x cheaper than Playwright for modern web apps |
| OpenCode (Go terminal agent) | 120K | Community alt to Claude Code; fastest-growing Jan 2026 |
| Gemini CLI | open source | 1M context, full MCP client, can call Jules — Trey's correct surface |
| Jules REST API | alpha | ~300 tasks/day at Ultra; programmable async coding agent |

### Trey Research — 4 Strategic Gaps

1. **Token Surcharge Blind Spot** — MCP schema dumping is economically broken at Velorin's density. CLI-native Tier 1, MCP Tier 3 external only.
2. **Determinism Paradox** — Multi-agent systems are stochastic by nature. Need a semantic checksum handshake before Tier 2 accepts tasks from Alexander.
3. **Memory as a Liability** — Infinite Knowledge Graph expansion kills the OS. Synaptic pruning (Monster Node decay, Ebbinghaus model) must be built now.
4. **Observer Effect** — Evaluator agents add telemetry bloat. Solution: Shadow Evaluator — async, fires only on ASI01/ASI02 red flags.

---

## TREY SITUATION — READ CAREFULLY

### What Happened
CT purchased Google AI Ultra and migrated Trey from ChatGPT to Gemini. During this session, the Gemini web app failed on basic tasks: couldn't recognize images, no file output, can't write to Google Docs.

### CT's Correction
Jiang prematurely concluded "Trey goes back to ChatGPT." CT corrected: "If I gave up on you the same way you are giving up on Gemini you wouldn't be here at all."

**The correct framing:** The web app is ONE surface. The full Gemini surface map (Gemini CLI, Gems, Google AI Studio, Gemini API, Deep Think) has not been explored. Do not conclude Gemini is dead. This investigation is open.

### Current Trey State
- Gemini web app: broken for workflow needs
- Gemini CLI: not yet configured — Mac Studio Monday task
- Trey.ProjectInstructions.md v2.0: written for Gemini, valid for CLI surface when set up
- Deep Research: runs in isolated window with no project context — not a viable primary surface
- Trey consolidated research: `Bot.Trey/Research_Complete/Trey.Topic.MCP_A2A_Architecture_Consolidated.md` — in the system, don't re-do it

---

## INFRASTRUCTURE STATE

### Google Drive
| MCP | Auth | Status | Capabilities |
|-----|------|--------|-------------|
| UUID-keyed (Claude built-in) | CT's Google account via Claude | WORKING | Search + read only |
| velorin-gdrive (custom) | Local OAuth tokens | BROKEN | Full write (create, move, update, trash, sheets) |

Fix: Service Account on Mac Studio Monday. Until then, Drive writes are blocked.

Security architecture intact: OAuth credentials in `Velorin Code/` (local only, not in GitHub). External agents can't reach credentials. Design is correct.

### Git
- Local velorin-system: clean, synced as of session close
- Last commit: `ac5944f` — Trey consolidated research

### Crons — ALL DOWN AT SESSION CLOSE
- Scribe: not running (escalation check was clean)
- Terry: not running
- Session Monitor T009: not running
- Restart all three at top of next session

---

## VOCABULARY — NEW ENTRIES THIS SESSION (A6-A13)

Full entries in `Claude.AI/Velorin.Vocabulary.md`. Read the file. New this session:

- **A6 — Query Mode** — Tight Mode / Discovery Mode. Caller declares. Agents never self-select.
- **A7 — MCP** — Linux Foundation standard. Neutral infrastructure.
- **A8 — A2A** — Peer agent delegation. The Alexander→Jiang pattern has a name now.
- **A9 — PPR** — Personalized PageRank. Brain retrieval algorithm.
- **A10 — Window Gravity** — CT's term. AI treating context window as complete reality. Primary architectural enemy.
- **A11 — Build vs Adopt** — Never adopt at foundational level. Community proves buildability = signal to build it Velorin's way.
- **A12 — Tiered MCP Registry** — Three-tier MCP management.
- **A13 — Browser Automation Bridge** — Decision tree: official API → ApiTap → Playwright → anti-detect → C++ modified → escalate.

**Next entry: A14.** Run vocabulary bot after next research session.

---

## PENDING FOR NEXT SESSION

**Mac Studio Monday:**
- Service account for velorin-gdrive (permanent auth fix)
- Gemini CLI setup for Trey
- Full Gemini surface map exploration (don't write it off)

**Architecture:**
- Brain neuron schema — lock before ingestion pipeline build
- Compression math session (hours 9-11) — still pending
- Synaptic Pruning algorithm design (Trey flagged as immediate)
- Semantic checksum handshake for Tier 2 task acceptance
- Steel Man A2A protocol fit for Velorin's agent model
- PAL MCP Build vs Adopt evaluation

**Infrastructure:**
- Restart Scribe, Terry, T009 crons at every boot

---

[VELORIN.EOF]
