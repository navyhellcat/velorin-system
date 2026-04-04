# neurons.agents.roster

## A. Active Bots

### A1. Alexander
Claude Desktop app bot (Code tab as of 2026-03-30). GUI-based. Manages MCP servers (start/stop with app). Accesses filesystem via bash/claude-code MCP, GitHub via github MCP, Google Drive via velorin-gdrive MCP.
**Your folder:** LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Alexander/` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.Alexander/`
**Boot:** Read `Alexander.ReadMe.First.md` → most recent session handoff in your folder.
last-touched: 2026-03-31
Pointers: [1] neurons.agents.protocols.A4 | [1] A2 | [1] neurons.agents.protocols.A1 | [2] neurons.connectivity.mcp.A6 | [2] neurons.agents.protocols.A2 | [2] neurons.connectivity.mcp.A4

### A2. MarcusAurelius
Claude Code CLI bot. Runs in terminal. Master instructions: `/Users/lbhunt/CLAUDE.md`. Local memory: `~/.claude/projects/-Users-lbhunt/memory/MEMORY.md`. Startup doc: `Claude.AI/Bot.MarcusAurelius/STARTUP.md`. Permissions: `Bash(*)` wildcard. MCP: velorin-gdrive, velorin-gatekeeper, github.
**Your folder:** LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.MarcusAurelius/` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.MarcusAurelius/`
**Boot:** Read `STARTUP.md` in your folder.
last-touched: 2026-03-31
Pointers: [1] A4 | [1] neurons.agents.protocols.A4 | [1] A1 | [1] neurons.agents.protocols.A1 | [1] A7 | [2] neurons.agents.protocols.A3 | [2] neurons.agents.protocols.A2

### A3. Gatekeeper
Parallel watcher bot. Runs as MCP server 24/7. Not a blocker — watches, corrects paths, checks health, searches brain, reads logs.
last-touched: 2026-03-28
Pointers: [1] neurons.connectivity.mcp.A3 | [2] neurons.agents.protocols.A1 | [2] A2

### A5. Jiang
Claude Desktop app bot (default as of 2026-03-30). Previously browser-based. Read/write capable. Manages long-context research tasks. CT assessment (2026-03-31): best-performing agent in the system by significant margin. Future: mobile agent planned (minimal boot, low token load — not yet built).
**Your folder:** LOCAL: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/` | GITHUB: `navyhellcat/velorin-system` → `Claude.AI/Bot.Jiang/`
**Boot:** Read `Jiang.ReadMe.First.md` → most recent session handoff in your folder.
last-touched: 2026-03-31
Pointers: [1] neurons.agents.protocols.A9 | [1] A1 | [1] neurons.agents.protocols.A4 | [2] A2 | [2] neurons.agents.protocols.A1

### A6. Trey
ChatGPT-based agent (NOT Perplexity — confirmed 2026-04-04). OpenAI custom GPT. Runs inside ChatGPT with a project box. Currently $25/month plan — deep research output is shallow (19-24 lines). Upgrade decision pending: Google AI Ultra ($249.99/month) is the current recommendation over ChatGPT Pro ($200/month) based on ecosystem value, API credits, and Jules GitHub write access. Research complete — see `Bot.Trey/Research_Complete/`. Accesses GitHub via raw URLs. Boot order: Operating Standards → Company DNA → Claude_Context_Profile → topline_profile.
last-touched: 2026-04-04
Pointers: [1] neurons.agents.protocols.A7 | [2] A4 | [3] neurons.agents.levelrules.A1

### A8. CT's Brain Model (planned — not yet built)
CT's own model. Will run locally on Mac Studio. Owns the Velorin brain — neurons, retrieval, Overseer role. Fine-tuned on Velorin knowledge corpus (neurons with confidence ≥ 0.8 are the training gate). This model is the center of Velorin — not Claude. Claude supervises and interfaces. CT's model routes tasks to external AI models (Claude, o3-pro, Gemini, others) as contractors. No dependency on any one AI company. Protocol between Claude and this model is not yet designed. Build begins after Mac Studio arrives April 7, 2026.
last-touched: 2026-04-04
Pointers: [1] neurons.operations.architecture.A9 | [1] neurons.operations.architecture.A8 | [2] A4 | [2] neurons.agents.roster.A5

### A7. Scribe
Background Claude Code subprocess ("ghost bot"). Fires via PostToolUse hook on Write when MarcusAurelius writes a memory file. Classifies memory → Region → Area → Neuron: updates existing neurons, creates new ones, or writes escalation if brain structure is missing. Cannot create regions. Commits locally — MA pushes.
Key files: Spec `Claude.AI/Bot.Scribe/SCRIBE.md` | Trigger `Claude.AI/Bot.Scribe/scribe-trigger.sh` | Run log `Claude.AI/Bot.Scribe/scribe_run_log.txt` | Escalation `Claude.AI/Bot.Scribe/escalation.md`
last-touched: 2026-03-30
Pointers: [1] neurons.agents.protocols.A3 | [1] A2 | [2] neurons.agents.protocols.A4 | [3] A3

### A4. Chairman Identity
The system serves one human — the Chairman. All bots reference this identity. The Chairman's name, cognitive profile, and behavioral patterns are loaded from their profile hard memory on boot. Never use machine account names. Current Chairman: Christian Taylor. Mac account "lbhunt" is NOT his name.
last-touched: 2026-03-28
Pointers: [1] A2 | [1] A1 | [2] neurons.agents.protocols.A2 | [3] neurons.principles.coredrives.A1
