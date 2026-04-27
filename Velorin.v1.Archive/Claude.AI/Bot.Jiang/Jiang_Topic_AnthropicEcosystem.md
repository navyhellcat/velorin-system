Jiang.Topic.AnthropicEcosystem
Director of Strategic Intelligence | Velorin System
March 27, 2026
Confidence Threshold: 75% minimum on all conclusions. Sourced. Permanent reference document.






RESEARCH PATHWAY
Research began with Anthropic product documentation at platform.claude.com/docs. Cross-referenced against Wikipedia Claude article (updated March 2026), Anthropic official blog and news page, Claude Help Center release notes, and third-party analysis from MetaCTO, IntuitionLabs, DataCamp, VentureBeat, The New Stack, CNBC, and the MCP specification site. Enterprise implementation data sourced from Anthropic State of AI Agents Report (February 2026), ServiceNow partnership announcement, Microsoft Foundry launch, and community analysis across Medium, SitePoint, and GitHub. All pricing data verified against Anthropic official pricing page as of March 14, 2026 (post long-context surcharge removal).
Directional shift during research: initial assumption was that the API and Claude.ai web interface would be the primary surfaces. Research revealed the product surface has expanded dramatically in Q1 2026 to include Cowork (desktop agent), Claude in Chrome (browser agent), Claude for Excel and PowerPoint (Microsoft Office add-ins), Agent Teams (multi-agent orchestration in Claude Code), the Claude Agent SDK (formerly Claude Code SDK), and a plugin/skill marketplace. The ecosystem is significantly larger and more interconnected than prior Velorin research assumed.
PART 1 -- COMPLETE CAPABILITY INVENTORY
Every Anthropic product and tool as of March 27, 2026.
1.1 Claude Model Family
Three active model tiers. All support text and image input, text output, multilingual, and vision.
Model
	Input $/MTok
	Output $/MTok
	Context
	Thinking
	Best For
	Opus 4.6
	$5
	$25
	1M (standard)
	Adaptive
	Complex reasoning, agents
	Sonnet 4.6
	$3
	$15
	1M (standard)
	Adaptive
	Balanced speed + quality
	Haiku 4.5
	$1
	$5
	200K
	Enabled
	Speed, high volume, cost


Long-context pricing update (March 14, 2026): Surcharge removed for Opus 4.6 and Sonnet 4.6. All requests now billed at standard per-token rate regardless of prompt size. Previously, inputs exceeding 200K tokens were billed at approximately 2x. This makes 1M context economically viable for production.
Adaptive thinking (4.6 models): Model automatically determines reasoning depth based on prompt complexity. No manual budget needed. Thinking tokens billed as output tokens at standard rates. Minimum budget 1,024 tokens.
Fast mode (Opus 4.6, beta): Approximately 2.5x faster output. Enabled via speed: 'fast' parameter or fast-mode-2026-02-01 beta header.
Effort parameter: Controls thinking depth. Defaults to high. Can set medium or low to save tokens and reduce latency.
Inference geo: Routes API calls to US-only infrastructure for data residency compliance.
Confidence: 92%
1.2 Claude.ai (Web, Mobile, Desktop)
What it is: Consumer and business chat interface. Web (claude.ai), iOS, Android, macOS Desktop, Windows Desktop.
Subscription tiers: Free (limited messages, Sonnet). Pro ($20/month, 5x usage, Projects, Claude Code, Cowork). Max 5x ($100/month). Max 20x ($200/month). Team ($25-30/seat standard, $150/seat premium with Claude Code). Enterprise (custom, 500K context, HIPAA, SSO, audit logs, compliance API).
Capabilities: Projects with persistent document context, web search, deep research, code execution, file creation (docx/xlsx/pptx/pdf/artifacts), memory from chat history (all users as of March 2026), chat search, image analysis, PDF processing.
Cannot do: Persistent background tasks (Cowork), local filesystem access (Cowork/Claude Code), multi-agent workflows natively.
Confidence: 95%
1.3 Claude API (Messages API)
What it is: Direct programmatic access to Claude. REST API at api.anthropic.com/v1/messages. Foundation for all production and automation use cases.
Core capabilities: Messages interface, system prompts, streaming, tool use (function calling), extended thinking, structured outputs, citations, PDF support, vision, embeddings, web search tool, web fetch tool, code execution tool, memory tool, bash tool, computer use tool, text editor tool. Batch API (50% discount, 100K messages, 24hr). Prompt caching (90% input cost reduction). Code execution free with web search/fetch.
Rate limits: Tiered by usage level. Per-model on RPM and OTPM. Cached tokens excluded. Custom limits via sales. Usage page in Console for monitoring.
SDKs: Python (anthropic), TypeScript/Node.js (@anthropic-ai/sdk), Go (GA). Community SDKs for Java, C#.
Platforms: Direct, AWS Bedrock, Google Vertex AI, Microsoft Foundry. Global and regional endpoints.
Cannot do: Maintain state between calls (stateless). No built-in persistent memory. No native multi-agent orchestration at API level.
Confidence: 93%
1.4 Claude Code
What it is: Agentic CLI coding tool. CLI, VS Code extension, JetBrains plugin, web, iOS. Revenue: $2.5B annualized run rate by mid-2026.
Capabilities: Full filesystem access, bash execution, git, MCP servers, Chrome browser integration, subagents, Agent Teams, CLAUDE.md config, skills/plugins, voice mode, session memory (MEMORY.md), remote control from phone, bare mode for scripted calls, channels for permission relay.
Agent Teams (experimental): 2-16 Claude Code instances working in parallel. Shared task list, peer-to-peer mailbox system. Each teammate has own 200K context window. Uses approximately 7x tokens of single session. Proven: 100K-line C compiler built by 16 agents across 2,000 sessions ($20K cost). Requires CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1.
Chrome integration (beta): Build-test-verify loop. Build in terminal, test in browser, debug from console. Chrome and Edge only.
Access: Pro ($20/month) minimum. All paid plans.
Confidence: 90%
1.5 Claude Agent SDK
What it is: Production SDK for building autonomous AI agents. Formerly Claude Code SDK. Python and TypeScript. Exposes all Claude Code capabilities programmatically.
Capabilities: All built-in tools (Bash, Glob, file ops, web search), MCP connections, custom tools, permissions, user approvals, hooks, file checkpointing, structured outputs, subagents, skills, plugins, cost tracking, todo lists, streaming input.
Architecture: Query-based. Provide prompt and ClaudeAgentOptions (allowed_tools, MCP configs), receive streaming messages. Filesystem-based configuration via CLAUDE.md.
Licensing: Anthropic Commercial Terms of Service. No claude.ai login/rate limits for third-party products. API key auth only.
Velorin relevance: Primary build path for Path 3. Replaces need for CrewAI/LangGraph. Jiang prior recommendation (82%) upgraded to 88% confidence.
Confidence: 85%
1.6 Claude Cowork
What it is: Desktop AI agent for knowledge work. Same architecture as Claude Code, GUI interface. Launched January 2026. macOS and Windows with full feature parity.
Capabilities: Local filesystem access (granted folders), multi-step autonomous task execution, document creation, MCP connectors (Google Drive, Gmail, Slack, DocuSign, FactSet, S&P Global, LSEG, Daloopa, PitchBook, Moody's), skills, scheduled recurring tasks, projects (persistent workspaces), computer use (macOS preview -- open apps, click, type, navigate browser), Dispatch (persistent phone-to-desktop thread).
Architecture: Isolated VM for file ops and commands. Computer use runs outside VM on actual desktop. Per-app permissions. App blocklist.
Key differentiator: Cowork + Chrome = research-to-deliverable pipeline. Chrome gathers web data, Cowork produces finished files.
Available on: All paid plans. Computer use Pro/Max only. Team/Enterprise admins can toggle.
Limitations: History stored locally. Not in Enterprise audit logs or Compliance API. Not for regulated workloads.
Confidence: 90%
1.7 Claude in Chrome
What it is: Browser extension. Read, click, navigate, act on websites. Beta on all paid plans.
Capabilities: Full page content reading, tab switching, multi-tab management, form filling, data extraction, navigation, scheduled tasks (daily/weekly/monthly/annually), workflow recording, Ask Before Acting mode. Integrates with Claude Code and Cowork.
Models: Pro = Haiku 4.5 only. Max/Team/Enterprise = Opus 4.6, Sonnet 4.6.
Safety: Financial/trading platforms blocked by default. Per-site permissions. Browser-specific attack success rate reduced from 35.7% to 0% on challenge set.
Supported: Google Chrome and Microsoft Edge only. No Brave, Arc, mobile.
Confidence: 88%
1.8 Claude for Excel
What it is: Microsoft Office add-in. Research preview on all paid plans.
Capabilities: Multi-tab workbook reading, cell-level citations, formula-preserving edits, template population, error debugging, pivot tables/charts, MCP connectors (S&P Global, LSEG, FactSet), repeatable Skills, session logging, cross-app context with PowerPoint. LLM gateway support (Bedrock, Vertex, Foundry).
Limitations: Only open files. No file create/open/close/switch. No VBA execution. Not in audit logs.
Confidence: 88%
1.9 Claude for PowerPoint
What it is: Microsoft Office add-in. Template-aware slide development. Reads layouts, fonts, colors, slide masters.
Capabilities: Slide generation from natural language, pinpoint edits, data-to-slides conversion, storyline restructuring, native charts, Skills, cross-app context with Excel, MCP connectors, LLM gateway support.
Access: Max, Team, Enterprise. Pro added later. Same limitations as Excel.
Confidence: 88%
1.10 Model Context Protocol (MCP)
What it is: Open standard for connecting AI to external tools. Introduced November 2024. Now under Linux Foundation (AAIF), co-founded by Anthropic, Block, OpenAI. 97M monthly SDK downloads, 5,800+ servers as of March 2026.
Architecture: JSON-RPC 2.0. Hosts/Clients/Servers. Transports: stdio (local), Streamable HTTP (remote/SSE). SDKs: TypeScript v1.27.x, Python v1.26.x, C#, Java.
Cross-provider: Adopted by OpenAI (ChatGPT, Agents SDK), Google DeepMind (ADK v2.0), Microsoft, Zed, Sourcegraph, Cursor. De facto standard.
2026 Roadmap: Transport scalability (stateless horizontal scaling), MCP Server Cards (.well-known discovery), agent-to-agent communication, enterprise readiness (audit trails, SSO, gateways), governance maturation.
Velorin relevance: Primary integration path. velorin-gdrive-mcp v1.3.1 operational. Agent-to-agent communication roadmap aligns with Path 3. 5,800+ existing servers are leverage.
Confidence: 92%
1.11 Projects, Memory, Extended Thinking
Projects: Persistent document context across conversations. Pro and above. Manual file management. Current Velorin boot bridge.
Memory: Persistent memory across conversations. All users including free tier (March 2026). Auto-generated from chat history. Import/export. View/edit/delete controls.
Extended/Adaptive Thinking: Internal reasoning blocks before final response. Adaptive (4.6 models) auto-determines depth. Extended (earlier models) uses manual budget. Thinking tokens billed as output. Available on Opus 4.6, Sonnet 4.6, Opus 4.5, Sonnet 4.5, Haiku 4.5, Opus 4.1, Opus 4, Sonnet 4. Context editing with thinking block clearing available.
Confidence: 90%
1.12 Computer Use, Security, Skills
Computer Use: API tool (computer_20250124) with click, type, scroll, screenshot. 466-499 token system prompt overhead. Research preview in Cowork/Claude Code on macOS for Pro/Max. Per-app permissions, blocklist.
Claude Code Security: Limited preview for Enterprise/Team. Opus 4.6 semantic vulnerability scanning. 500+ real vulnerabilities found in open-source code. Sub-5% false positive rate vs 30-60% traditional. CrowdStrike -8%, Cloudflare -8.1% on announcement.
Skills: Organized folders of instructions/scripts/resources loaded dynamically. Anthropic-managed for pptx/xlsx/docx/pdf. Custom via Skills API. Plugin marketplace for Team/Enterprise. Connectors for external services (Drive, Gmail, Slack, DocuSign, FactSet, etc.).
Confidence: 85%
PART 2 -- WHAT OTHERS HAVE BUILT
2.1 Enterprise Deployments
ServiceNow: Claude as default model for Build Agent (enterprise coding solution). 80B+ annual workflows. Usage expected to quadruple. 50% implementation time reduction target. 29,000+ employees using Claude and Claude Code. Healthcare/life sciences agentic applications.
Microsoft: Opus 4.6 in Foundry on Azure. M365 Copilot Wave 3 allows Claude selection inside Copilot Studio, M365, GitHub Copilot. $500M/year Anthropic spend. Adobe testing in Foundry.
Deloitte: Enterprise governance and professional services. Novo Nordisk: 10+ weeks of clinical documentation reduced to minutes. Cox Automotive: doubled CRM response throughput. CBA: financial analyst workflows. SNCF: customer service agent productivity.
2.2 Multi-Agent Implementations
Anthropic C Compiler: 16 agents, 100K lines Rust, compiled Linux 6.9 kernel on x86/ARM/RISC-V. 2,000 sessions, $20K. Published February 2026 by Nicholas Carlini. Most significant Agent Teams proof-of-concept.
OpenClaw: Viral agent via WhatsApp/Telegram. Claude/OpenAI models executing tasks locally. Influenced Anthropic product direction. Demonstrated market demand for persistent mobile-accessible agent threads.
Gas Town / Multiclaude: Community multi-agent orchestrators for Claude Code. Supervisor-agent pattern. Formalized by Anthropic as Agent Teams.
YC Startups: 1-3 founder teams building entire products with Claude Code. Validates 'vibe coding' for product development.
2.3 Architecture Patterns
Model-Mixing Gateway: Routing layer sending classification to Haiku, balanced work to Sonnet, complex reasoning to Opus. Emerging enterprise standard for cost control.
CLAUDE.md as Agent Constitution: Project root markdown file providing architecture, standards, build commands. Loaded every session. Directly analogous to Velorin ReadMe.First pattern.
Drive-Based Memory: Multiple independent implementations converge on Google Drive documents as persistent memory with .md files for active context. Validates Velorin architecture.
Agentic Commerce: E-commerce platforms using Claude Code for autonomous inventory, product listings, customer service. Shopify Brain using MCP connectors for SQL mining. Marketing agencies building 10x capacity with same headcount.
PART 3 -- VELORIN APPLICATION MAP
3.1 STEALTH PHASE (Current)
Claude.ai: Already operational as primary interface. Continue for all bot sessions. Projects provide boot protocol.
Claude API: Next major milestone. Agent SDK as runtime, API as transport, Drive as memory. Sonnet 4.6 with caching: approximately $0.20-0.60 per orchestrated session. At 5-10 sessions/day, monthly approximately $30-90.
Claude Code: Shift to primary dev tool. Create CLAUDE.md for repos. Agent Teams for multi-file builds (monitor 7x token cost).
Agent SDK: Next build target after MCP v1.3.2. Install, build prototype orchestrator, test single agent call, expand to multi-agent. This IS Path 3.
Cowork: Evaluate scheduled tasks for EndOfDay protocol automation. Could replace manual trigger for Tier 1 updates.
Claude in Chrome: Continue for inter-session communication. Evaluate scheduled tasks for Camfil pipeline or market research.
MCP: v1.3.2 build (create_folder, move_folder, keepalive, Sheets). Consider Camfil CRM and calendar servers.
Excel/PowerPoint: Low priority. Relevant when real estate analysis or pitch materials needed.
3.2 GROWTH PHASE (Productized)
API: Production backbone. Model-mixing gateway. Prompt caching mandatory. Batch API for overnight processing. Per-agent cost tracking.
Agent SDK: Orchestrator becomes production service on dedicated server. Spawns agents on demand/schedule. First replicable product component.
MCP: Expand beyond Drive. Servers for CRM, financial data, health data, calendar, email. Each new server extends reach without core architecture change. Server Cards enable automatic discovery for new installations.
Cowork: Template for customer experience. Scheduled tasks, file management, daily briefs. Plugin architecture enables Velorin-specific skill distribution.
Skills: Distributable products. Financial Modeling skill (Box 2 methodology), Daily Brief skill (EndOfDay protocol), Research skill (Jiang framework). Installable by customers.
3.3 SCALE PHASE (Licensed, Multi-Tenant)
API: Via Bedrock/Vertex for reliability and geo-routing. Per-customer workspaces. Enterprise-grade auth. Model selection per customer plan.
Agent SDK: Customer agent fleets. Standardized definitions (derived from Velorin bot architecture), customizable per customer. Cloud orchestrator managing lifecycle, failures, routing. Productized Alexander.
MCP: Universal plug-in interface. Customer data sources via MCP. Pre-built servers for common integrations. 5,800+ existing ecosystem servers available without building. Leverageable asset.
Computer Use: Agents operating on behalf of customers in legacy systems without APIs. Navigate SaaS tools, fill forms, extract data. Frontier capability, likely production-ready by scale phase.
The Moat: Profile layer and memory architecture, not framework. Validated by Anthropic product evolution. Memory is conversation-level, not life-level. Cowork is task-level, not architecture-level. Skills are workflow-level, not system-level. Velorin fills the gap: cross-domain orchestration of a human life. That gap is the product.
OFFICIAL CONCLUSIONS


1. Product surface larger than assumed. 10+ distinct products/tools, not just API and chat. Build plan must account for Cowork, Chrome, Office add-ins, Agent Teams, Agent SDK, Skills, Plugins, Connectors. Confidence: 90%.


2. Agent SDK confirmed as Path 3 build path. Prior recommendation (82%) upgraded. SDK exposes all Claude Code capabilities programmatically with MCP, custom tools, subagents, structured outputs. No external framework required. Confidence: 88%.


3. Token costs lower than estimated. Sonnet 4.6 with caching: approximately $0.20-0.60 per orchestrated session vs prior $3-24 estimate. Long-context surcharge removal and caching improvements changed economics. TokenCostModel document should be created with updated calculations. Confidence: 82%.


4. Cowork scheduled tasks = EndOfDay automation bridge. Evaluate Cowork scheduled recurring tasks as near-term solution for Tier 1 daily updates. Replaces custom automation layer need. Runs within existing subscription. Confidence: 78%.


5. MCP confirmed as rising tide. 97M monthly downloads, 5,800+ servers. Every existing server is a potential Velorin connector. Agent-to-agent roadmap enables Path 3. AAIF governance under Linux Foundation with Anthropic/Block/OpenAI means protocol is permanent. Confidence: 92%.


6. Drive boot protocol validated but not scale solution. Multiple independent implementations converge on document memory. Transition to vector index at 50-80 topic documents per prior research. Document memory will coexist with more sophisticated solutions. Confidence: 80%.


7. Competitive landscape validates thesis. No Anthropic product orchestrates across life domains. Memory = conversation-level. Cowork = task-level. Skills = workflow-level. The gap between what Anthropic offers and what Velorin builds is the product. Confidence: 88%.


OPEN QUESTIONS
1. Agent SDK access tier and rate limits for SDK-spawned agents vs direct API calls.
2. Cowork scheduled tasks API surface -- can they be configured programmatically or GUI-only?
3. Agent Teams for non-coding knowledge work -- can the pattern be adapted for Velorin agents?
4. Plugin marketplace distribution for Velorin skills -- could Velorin distribute through Anthropic marketplace?
5. Identity verification -- Agent SDK permissions and MCP auth roadmap may provide solutions. Jiang.Topic.IdentityVerification should be created.
CONNECTED TOPICS
Jiang.Topic.AgentOrchestration -- Directly connected. Ecosystem context for orchestration build path.
Jiang.Topic.TokenCostModel -- Queued. Updated cost data from this document should feed the model.
Jiang.Topic.IdentityVerification -- Queued. Agent SDK permissions and MCP auth provide partial solutions.
Velorin.Company.DNA -- Theory of the Product validated by Conclusion 7.
Velorin.Company.Operating.Standards -- Technology Evaluation Standard should include full tool inventory from Part 1.






[VELORIN.EOF]
