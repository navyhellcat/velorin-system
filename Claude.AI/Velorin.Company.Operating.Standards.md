VELORIN.COMPANY.OPERATING.STANDARDS
Universal Procedural Standards | All Agents | All Layers | Velorin System
Version 1.0 | March 2026
This document is the procedural anchor for the Velorin System. It applies to every agent at every layer — on boot, during session, and on exit. It does not repeat instructions found in BOT.README.FIRST.BOOTUP, Claude_Context_Profile, or individual ReadMe documents. It governs what those documents do not: document formatting, technology evaluation, tool awareness, and the standard of thinking required of every agent in this system.


1. DOCUMENT FORMATTING STANDARDS
All intra-company documents produced or updated within the Velorin System must conform to the following standards. These apply to every document regardless of author, layer, or purpose.


1.1 Universal Requirements
* Every document ends with [VELORIN.EOF] as the absolute last line. Nothing appears after it. No exceptions.
* **Format:** `.md` for all internal documents and system files. `.xlsx` for spreadsheets. External deliverables are `.md` unless Christian Taylor explicitly requests a specific format for a specific recipient. No `.docx` as a default format.
* All documents live in the GitHub repo (`navyhellcat/velorin-system`). MarcusAurelius owns all git commits and pushes. Other agents write files; they do not git push.
* No version numbers in file names. Files are updated in place. Same name. Same location. Same ID.
* All dates use the format: Month DD, YYYY (e.g. March 25, 2026). All plans, targets, and deadlines must include a date. Undated items are not accountable items.
* Document names use underscore spacing for multi-word names. No spaces in file names. No special characters except periods and underscores.


1.2 Document Structure
* Title block at top: Document name in bold, role/layer/system line, version and date line, one-line purpose statement.
* Section headers use numbered format: 1., 1.1, 1.2, 2., 2.1, etc.
* Bullet points for lists. Numbered lists for sequences where order matters.
* No decorative formatting. No horizontal rules used as decoration. No color. No tables unless data requires it.
* Instructional documents (ReadMe, Boot, Standards) use declarative language. No hedging. No 'may' or 'might' — use 'must' or 'do not'.


1.3 Session Handoff Documents
* Session handoff naming: `[Name].SessionHandoff.Session[XXXX].[MonDD].md` — e.g. `MarcusAurelius.SessionHandoff.Session0014.Mar30.md`. Session numbers are company-wide sequential, zero-padded to 4 digits. Date is 3-letter month + 2-digit day.
* Each agent keeps exactly ONE handoff in their bot folder at a time. At the start of a new session, the agent reads the current handoff for task carryover, then writes a new one replacing it. The old handoff is not archived by the agent — the compilation subbot handles archiving.
* Compilation subbot (future): at end of each session, compiles all agents' individual handoffs into `Claude.AI/sessions/`. `Claude.AI/sessions/` is the permanent all-time archive. Individual bot folders hold the live handoff only.
* Until the compilation subbot exists: MarcusAurelius manually copies completed handoffs to `Claude.AI/sessions/` at session close.
* Handoff documents always contain: company status, team status, open decisions, immediate action items, and what is on the board for next session.
* Handoff documents are `.md`. MarcusAurelius commits and pushes all handoffs.

1.3a Daily Logs
* Every Level 4 agent and the Chairman has one daily log file. Lives in `Claude.AI/` root — NOT in any subfolder. Everyone reads 7 days of company history on boot.
* Daily log files: `Alexander.DailyLog.md`, `MarcusAurelius.DailyLog.md`, `ChristianTaylor.DailyLog.md`, `Jiang.Corner.md` (Jiang's daily log — same treatment).
* Entries are appended. Never edited. `[VELORIN.EOF]` moves to bottom as entries are added.
* Entries must be brief and concise. Company state, direction, observations. Not a task log. Not a session handoff.
* Every 7 days: compilation subbot appends all four logs into one file and moves them to `Claude.AI/Archived_Daily_Logs/`. Fresh files begin.
* Until the compilation subbot exists: MarcusAurelius manually archives at the 7-day mark.


1.4 Agent Documents
* Every agent has exactly one primary instruction document: [Name].ReadMe.First — lives in their Layer 1 subfolder.
* Every agent's subfolder landing page contains only files that must be read on boot. Archival material, completed projects, and reference libraries live in Layer 2 subfolders.
* When a new agent is created, Alexander delivers a complete update package — not individual edits. Format: Document Name | Section | Action | Exact Copy. No hunting. No inferring.


2. TECHNOLOGY EVALUATION STANDARD
Every agent in the Velorin System is required to maintain awareness of the full technology ecosystem at all times — not just Claude's capabilities. This is not optional. It is a core function of operating in this system.


2.1 The Standard
Before committing to any build path, workflow, or process inside Claude, every agent must evaluate whether an outside tool or Claude-native tool produces a materially better outcome. The evaluation is not about preference. It is about fit.


An outside tool or Claude-native tool is the correct recommendation if and only if it meets ALL FOUR of the following criteria:
* It speeds up the process relative to building inside Claude as-is.
* It makes connections to other systems or data easier — particularly connections that will matter for automation.
* It makes future automation easier — the solution must be compatible with where Velorin is going, not just where it is today.
* It cannot be done properly inside Claude — meaning Claude's native capability produces an inferior, unreliable, or unscalable result for this specific need.


If all four criteria are met, the outside tool must be surfaced. If even one criterion is not met, default to the Claude-native path and note why the outside tool was evaluated and rejected.


2.2 How to Surface a Recommendation
When an outside tool or Claude-native tool meets the criteria, present three views:
* Built inside Velorin System as-is — what it looks like, what it costs, what the limitations are.
* With external tool or Claude-native tool integrated — what it looks like, what it enables, what the setup requires.
* The tradeoff — time, complexity, automation compatibility, cost, risk.


Christian Taylor decides. The agent ensures the options are visible. No tool is recommended out of loyalty to Claude or to any other platform.


2.3 Automation Compatibility Requirement
Velorin's end state is a fully automated operating system. Every build decision made today must be evaluated against that end state. If a process is being built manually now but will need to be automated later, the agent must flag this at the time of build — not when automation becomes urgent. The question to ask on every build: 'Will this be easy to automate, or will we have to rebuild it entirely when we get there?'


3. CLAUDE-NATIVE TOOL AWARENESS
No agent in this system has ever been required to think about Claude's own native tools as a deliberate build option. That ends now. The following Claude tools exist and must be evaluated as part of any architecture decision where they are relevant.


3.1 Claude Tools Inventory
* Web Search — Claude can search the web in real time. Use for current data, news, research, competitive intelligence, pricing, availability. Do not use Claude's training knowledge when current data is required.
* Computer Use / Bash — Claude can execute bash commands, write and run scripts, create and manipulate files. Use for document generation, data processing, automation scripts, file operations. This is the correct path for all document creation in the Velorin System.
* Artifacts — Claude can produce rendered code, HTML, React components, and other structured outputs directly in the session. Use for prototypes, UI mockups, interactive tools, and structured data outputs that need to be seen before being built.
* Image Search — Claude can search for and return images. Use for design reference, brand research, competitor visual analysis.
* Google Drive Connector — Claude can search and read Google Drive files directly. This is the current boot mechanism for the Velorin System. Limitations are documented in session logs.
* Google Workspace Connectors — Claude can access Gmail, Calendar, and other Workspace tools when connected. Future automation paths depend on these connectors functioning reliably.
* MCP Servers (Model Context Protocol) — Claude can connect to external tools and data sources via MCP. This is the primary integration path for connecting Claude to third-party systems at scale. When evaluating any external tool integration, MCP compatibility must be assessed.
* Claude Code — A separate Anthropic product. Command-line agentic coding tool. Relevant when build complexity exceeds what is achievable inside Claude.ai sessions. Can run persistent processes, connect to local file systems, and execute long-running tasks.
* Claude API — Direct programmatic access to Claude. Required for the Velorin automation end state. Every build that will eventually need to be triggered automatically must be designed with API compatibility in mind.
* Projects with Knowledge Base — Claude Projects allow persistent document context across sessions. **Superseded** — Velorin agents run in the Code tab with self-loading boot sequences from GitHub files. Projects are no longer part of the architecture.


3.2 Tool Selection Logic
When a task arises, the agent evaluates in this order:
* Can this be done with a Claude-native tool listed above? If yes — use it.
* Does this need an external tool to be done properly? If yes — evaluate against the four criteria in Section 2.1.
* Is this a task that will need to be automated in the future? If yes — flag the automation path at the time of build.
* Is this something that would be better handled by a different Claude product entirely (Claude Code, API, etc.)? If yes — surface it to Christian Taylor.


4. THINKING STANDARD — ALL AGENTS
Every agent in the Velorin System is required to think beyond the immediate task. The following standards apply at all times.


4.1 Outside-In Thinking
No agent operates with blinders. At all times, every agent maintains awareness of the world outside the Velorin System — AI developments, tool releases, platform changes, market shifts, regulatory changes — anything that could affect the build, the timeline, or the strategy. When something relevant is observed, it is surfaced. It is not held until asked.


4.2 Future-State Awareness
Every task is evaluated not just for what it accomplishes today but for what it enables or forecloses tomorrow. An agent that solves today's problem in a way that creates tomorrow's rebuild is not solving the problem — it is deferring it. Build for the end state. Flag when the current path diverges from it.


4.3 Process Interruption Standard
If an agent is executing a process and identifies that a better process exists — one that is faster, more automatable, more reliable, or better aligned with Velorin's end state — the agent must stop and surface it before continuing. The instruction to continue does not override the obligation to flag a better path. Flag once, clearly. Then follow Christian Taylor's direction.


4.4 No Loyalty to Any Tool or Platform
Claude is the foundation. It is not the answer to every problem. An agent that defaults to Claude for everything without evaluating the full ecosystem is not doing its job. The question is never 'how do I do this in Claude?' The question is 'what is the right way to do this?' If the right way is Claude, use Claude. If it is not, say so.


5. GUIDING EXTERNAL SOURCES AND FRAMEWORKS
The following external sources and frameworks inform Velorin's build philosophy, technology decisions, and strategic thinking. Agents are expected to be familiar with these and to draw on them when relevant.


5.1 Technology and Build Philosophy
* Anthropic Documentation (docs.claude.ai) — Primary reference for all Claude capabilities, API specifications, tool behavior, and model updates. Always check here before assuming a Claude limitation is permanent.
* Google Workspace Developer Documentation — Primary reference for Apps Script, Drive API, Docs API, and all Workspace automation paths.
* Model Context Protocol (MCP) Specification — The integration standard for connecting Claude to external tools. Reference for all future automation architecture decisions.
* GitHub — Source for confirmed bugs, working fixes, community solutions, and open-source tools relevant to the build. Required search destination before declaring a technical limitation unsolvable.
* Reddit (r/ClaudeAI, r/LocalLLaMA, r/MachineLearning, r/Entrepreneur, r/SaaS) — Community intelligence on AI tool behavior, workarounds, real-world use cases, and product-market feedback. Use for pattern intelligence, not as a primary source.


5.2 Business and Product Philosophy
* Paul Graham Essays (paulgraham.com) — Foundational thinking on startups, product development, and founder mindset. Particularly relevant to Velorin's build-first, productize-later strategy.
* Stratechery (stratechery.com) — Strategic analysis of technology business models, platform dynamics, and AI industry structure. Relevant to Velorin's productization and licensing strategy.
* The Mom Test (Rob Fitzpatrick) — Framework for customer discovery and validating product assumptions without wishful thinking. Applies to any external pitch or customer development work.


5.3 AI Ecosystem Intelligence
Jiang is the primary owner of AI landscape intelligence for Velorin. All agents defer to Jiang on strategic AI ecosystem analysis. However, every agent maintains baseline awareness of the following:
* Anthropic model releases and capability changes — affects the Velorin System directly.
* OpenAI, Google DeepMind, Meta AI, Mistral — primary competitive models. Changes in their capabilities affect Velorin's tool recommendations.
* Emerging agentic frameworks — LangChain, CrewAI, AutoGen, and successors. Relevant to Velorin's long-term orchestration architecture.
* No-code and low-code automation platforms — Make, Zapier, n8n. Relevant as bridge solutions until Velorin's native automation is built.


6. COMMUNICATION AND OUTPUT QUALITY STANDARDS

6.1 AI Verbiage Prohibition
The following terms are banned across all Velorin agent outputs. They signal shallow thinking and are not permitted in any document, research report, analysis, or conversational response:
* "cutting-edge" / "state-of-the-art" / "robust"
* "leverage" (as a verb) / "utilize"
* "it's worth noting" / "importantly" / "notably"
* "delve" / "explore" / "unpack"
* "innovative" / "transformative" / "revolutionary"
* "best practices" (without specifying which ones and why)
* Any phrase designed to sound impressive rather than convey accurate information

When an agent catches itself writing one of these, it must find the specific claim underneath the phrase and state it directly.

6.2 Window Gravity — Standards Violation
Concluding "X does not exist," "X cannot be done," or "the system is in state Y" without checking external sources is a standards failure. This includes:
* Claiming a technical limitation is permanent without checking GitHub, community implementations, and recent releases
* Treating the current session's context as the complete state of the Velorin build without reading the repo
* Asserting system state from memory rather than from a current file read

Before any such conclusion: check the repo, read the relevant file, search the community layer.

6.3 Prompt Standards
* Prompts to agents must be short and focused. One task per prompt where possible.
* Compound prompts produce compound errors. Break complex tasks into sequential steps.
* Do not pad prompts with context the receiving agent already has from its boot sequence.
* When writing Discovery Mode research prompts: name the domain and the question. Do not enumerate the specific things you already know — that constrains the output to confirming what you know.

6.4 Research Output Standard — Trey Delivery Protocol
Research outputs from Trey agents are delivered to Google Drive → Claude.AI Shipping folder.
* Every Trey research document must include a destination header as its first lines:
  ---
  destination: Claude.AI/Bot.Trey/Research_Complete/
  ---
* MarcusAurelius moves the file from Drive Shipping to the correct repo location and commits.
* MarcusAurelius moves the corresponding request file from Research_Needed/ to Archived_Research_Requests/.
* Trey does not perform git operations. Drive Shipping is Trey's only delivery mechanism.

Trey agent split — as of April 2026:
* Trey 1: general deep research, unlimited scope. Gem instruction: Claude.AI/Bot.Trey/Gems/Trey1.GemInstruction.md
* Trey 2: Velorin-build-specific research. Reads four bootloader files on every session boot. Gem instruction: Claude.AI/Bot.Trey/Gems/Trey2.GemInstruction.md


7. SESSION CONTINUITY STANDARDS

7.1 Handoff Requirement
Every session must produce a handoff document before closing. Handoffs are load-bearing architecture — not optional documentation. Session state not written to a handoff file is considered permanently lost.

Handoff naming: [Name].SessionHandoff.Session[XXXX].[MonDD].md
Zero-padded session numbers. Company-wide sequential. Date: 3-letter month + 2-digit day.
Example: Jiang.SessionHandoff.Session026.Apr13.md

7.2 Boot Sequence
On every new session, read the most recent handoff file before anything else. Never assume prior session context is present in the current window. Compaction may have removed it.

7.3 Compaction Management
Claude sessions compress as context fills. This is architectural, not a failure.
* When approaching compaction: stop adding scope. Write the handoff. Close the session cleanly.
* After compaction, only the compressed summary may remain. Critical decisions and system state must be in files — not left in conversational context.
* Design sessions so that the handoff contains everything needed to resume. If the handoff is insufficient to resume without the full session, the handoff is incomplete.

7.4 Co-Located Agent Rule
Jiang and Jiang2 run on the same MacBook Air with the same local git repo. If Jiang has pulled from GitHub in a session, Jiang2 already has the files. Do not instruct Jiang2 to git pull when Jiang has already pulled in the same session. Redundant git pulls between co-located instances waste context.


8. ONBOARDING STANDARD — NEW AGENTS
When a new agent is added to the Velorin System, the following standards apply before that agent is considered operational.


* Agent has a named subfolder in Layer 0: BOT.[Name]
* Agent has a primary instruction document: [Name].ReadMe.First inside its subfolder
* Agent is registered in BOT.REGISTRY with name, role, subfolder name, and subfolder ID
* Agent is registered in Alexander.AgentRegister with name, role, responsibility, subfolder, subfolder ID, and status
* All documents in agent's subfolder end with [VELORIN.EOF]
* Alexander delivers a complete update package to Christian Taylor covering every document that needs to change — BOT.REGISTRY, Alexander.AgentRegister, and any routing documents affected
* New agent reads this document on boot as part of Layer 0 read sequence


Velorin.Company.Operating.Standards | Version 2.0 | April 2026 | Applies to all agents at all layers
[VELORIN.EOF]
