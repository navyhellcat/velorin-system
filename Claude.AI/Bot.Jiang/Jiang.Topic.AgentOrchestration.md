Jiang.Topic.AgentOrchestration
Director of Strategic Intelligence  |  Velorin System
Issued March 27, 2026  |  Research Request: Alexander, CEO
Confidence: See per-conclusion ratings below


1. RESEARCH PATHWAY
Four searches executed in sequence, each refining the scope of the prior. Search 1 mapped the framework landscape as of March 2026. Search 2 isolated Claude API constraints — pricing, rate limits, subagent architecture. Search 3 examined the Claude Agent SDK and Agent Teams specifically, and the Anthropic-native orchestration stack. Search 4 addressed memory architecture and production failure modes. Sources prioritized: Anthropic engineering documentation, production deployment postmortems, peer-reviewed memory architecture research, framework maintainer documentation. Marketing-layer sources discarded unless corroborated by builder community data.
Key directional shifts: Initial assumption was that CrewAI or LangGraph would be the primary recommendation. Research shifted this. Anthropic's own native stack — Claude Agent SDK, MCP, Agent Teams — is further along than externally visible. The recommendation shifted toward Claude-native architecture as the primary path, with CrewAI retained as a fallback option only. Second shift: the storage question. Initial expectation was that Google Drive would be flagged as insufficient at scale. Research confirmed it is the correct pattern for Velorin's current phase and aligns with what independent builders are converging on. The scale transition point is identifiable and further out than expected.


2. FRAMEWORK LANDSCAPE — MARCH 2026
Six production-grade frameworks are competing as of March 2026. This section maps each on the dimensions that matter for Velorin.
Framework
	Orchestration Model
	State Persistence
	Model Lock
	Learning Curve
	LangGraph
	Directed graph, conditional edges
	Built-in checkpointing, time-travel
	Model-agnostic
	Highest — graph theory required
	CrewAI
	Role-based crews + Flows
	Task outputs sequential
	Model-agnostic
	Lowest — 20 lines to start
	OpenAI Agents SDK
	Explicit handoffs
	Context variables, ephemeral default
	OpenAI only
	Low — clean API
	Claude Agent SDK
	Tool-use chain, subagents via Task
	Via MCP servers
	Claude only
	Low — MCP-native
	Google ADK
	Hierarchical agent tree
	Session state, pluggable backends
	Gemini-optimized
	Medium
	AutoGen/AG2
	Conversational GroupChat
	In-memory default
	Model-agnostic
	Medium


Framework Summary
* LangGraph leads on production maturity, persistence, and observability (LangSmith integration). Correct choice for complex stateful workflows with branching, loops, and approval gates. Steepest learning curve. Not the fastest path.
* CrewAI leads on prototyping speed, community size (44,600 GitHub stars, 60M monthly agent executions), and protocol breadth (native MCP and A2A support as of v1.10.1). Model-agnostic — supports Claude via LiteLLM. Best for teams that need something running in a week. Production-tested but coordination overhead above 5 agents has been documented.
* Claude Agent SDK is the most relevant for Velorin. It is the infrastructure powering Claude Code, exposed as a library. Supports native subagent spawning via Task in allowedTools. Each subagent gets its own isolated context window. Orchestrator receives only final output, not full subagent context. MCP servers are the state persistence layer. Model-locked to Claude — which is Velorin's current stack.
* Agent Teams shipped February 6, 2026 alongside Opus 4.6. Teammates are fully independent Claude Code instances, not subagents. They can communicate directly with each other, not just report to a parent. Anthropic's own documented production sweet spot: 2-5 teammates, 5-6 tasks each. Above 5 teammates, coordination overhead cancels the parallelism benefit.
* Google ADK: relevant if Velorin eventually needs multi-framework agent communication via A2A protocol. Not the right choice for Velorin's current phase.
* AutoGen/AG2: strong for research and adversarial multi-agent setups. Not production-optimized for Velorin's use case.


3. CLAUDE API — ACTUAL CONSTRAINTS
Pricing (March 2026)
Model
	Input (per MTok)
	Output (per MTok)
	Note
	Haiku 4.5
	$1.00
	$5.00
	Fastest — high-volume tasks
	Sonnet 4.6
	$3.00
	$15.00
	Balanced — primary agent model
	Opus 4.6
	$5.00
	$25.00
	Flagship — orchestrator layer
	Batch API
	50% off
	50% off
	Non-real-time tasks only
	Prompt Cache
	~90% savings
	—
	On repeated context
	Opus 4.6 Fast Mode
	$30.00
	$150.00
	Latency-critical only — avoid


Rate Limits
Rate limits operate as three overlapping constraints: requests per minute (RPM), tokens per minute (TPM), and daily token quota. Agentic sessions hit TPM limits, not daily quota. The reason: each agentic turn appends to context. A single multi-file operation can consume 50,000-150,000 tokens in one API call. Tier 1 provides approximately 20,000 input TPM for Sonnet-class models. Tier 4 doubles Tier 3. Exact limits vary by model and tier — verify at docs.anthropic.com before architectural decisions.
Critical constraint for Velorin: multi-agent systems with parallel subagents multiply token consumption. An orchestrator spawning three subagents simultaneously multiplies the per-turn cost by three, and all three burn the same account's TPM ceiling concurrently. This is the primary rate-limit failure mode for solo-built multi-agent systems.
Operational note as of March 26, 2026: Anthropic temporarily doubled usage limits during off-peak hours through March 28 for all tiers. This is not permanent capacity — it is a promotional measure responding to infrastructure pressure. Do not design around it.
Subagent Architecture — What the API Actually Supports
The Claude Agent SDK exposes a query() function returning an async generator. Subagents are defined in an agents parameter — each with its own description, system prompt, restricted tool access, and optionally a different model. When the orchestrator Claude instance encounters a task matching a subagent definition, it spawns the subagent, passes only the specific task, and receives only the final result. The subagent's full reasoning and intermediate context do not pass back to the orchestrator. This is the correct pattern for Velorin: Jiang's full research context does not need to burden Alexander's orchestrator context.
Session persistence is handled via MCP servers — which Velorin already has live. This is the state layer. The pattern is: orchestrator reads Drive, assigns subagent tasks, subagents execute and write outputs, orchestrator reads outputs. The MCP Drive tools already built (gdrive_read_file, gdrive_update_doc, gdrive_overwrite_doc) are the correct interface for this pattern.


4. END-STATE ARCHITECTURE — WHAT IT LOOKS LIKE BUILT
The desired end state from the research request: many agents working in parallel, each with scoped memory, writing continuously during work, aggregating at session end and project end, coordinated by an orchestration layer that spawns, assigns, routes, and manages results.
Built on Velorin's current stack, this is a five-layer system:
Layer
	What It Is
	Current Velorin Status
	Protocol
	MCP — agent-to-tool communication standard
	LIVE. v1.3.1 connected.
	Skills
	Reusable instruction packages loaded by agents on task match
	Partial — Drive docs serve this function today.
	Agent
	Primary worker — receives task, executes, reports
	Live in browser sessions. Not yet API-spawned.
	Subagents
	Parallel specialist workers spawned by agent, isolated context windows
	Not yet built. Requires Claude Agent SDK.
	Agent Teams / Orchestrator
	Independent Claude Code instances coordinating across sessions
	Not yet built. Requires Claude Code Agent Teams or API orchestrator.


The missing components — Subagents and Orchestrator — are the Path 3 gap. Everything below those layers is already built and operational. The build required to close Path 3 is therefore:
* A Node.js orchestrator script using the Claude Agent SDK (npm install @anthropic-ai/claude-agent-sdk) that can be triggered programmatically.
* Subagent definitions for Jiang, Trey, and future agents — each with their own system prompt loaded from Drive, restricted tool access via MCP, and a defined output schema.
* An output routing layer: subagent results written to Drive via existing MCP tools, then aggregated by the orchestrator into a session-end document.
* A trigger mechanism: Alexander (Claude Desktop with MCP) calls the orchestrator script, which spawns the subagents, waits for outputs, and returns results without requiring human browser navigation.
Estimated components: 3-5 files. Orchestrator script, subagent config definitions, output formatter, trigger interface, error log handler. This is a contained build, not a large one.


5. STORAGE ARCHITECTURE
Is Google Drive the Right Substrate for Persistent Memory?
Yes — for Velorin's current phase and for the top-layer memory tier. The research confirms that three major independent projects (Manus, OpenClaw, and Claude Code's own CLAUDE.md pattern) have converged on markdown/document-based memory as the correct approach for agent architectural and procedural memory. The reasons are directly applicable to Velorin:
* Holistic context: document-based memory forces the agent to maintain a map of the project, not retrieve fragments. RAG retrieves chunks — it misses the architectural pattern. Drive documents give Jiang the full picture on boot.
* Portability: no vendor lock-in. The same Drive docs can be fed to a different model if Velorin moves off Claude. Files are the abstraction, not a vector store's thread_id.
* Searchable and inspectable: standard text search works immediately. Christian Taylor can read and edit every memory file directly. This is the correct property for a system being built on trust and transparency.
* Proven in production: Susan's .md file memory inside Replit is the same pattern. The Velorin boot protocol is the same pattern. These are working instances, not theory.
When Google Drive Becomes the Wrong Substrate
Drive is the wrong choice when: the system needs to query memory by semantic similarity rather than by key or document name; when memory volume exceeds what can be loaded into a context window even selectively; or when multiple agents need to write to shared memory simultaneously with conflict resolution.
The transition trigger for Velorin: when the number of active topic documents in Jiang's knowledge web exceeds approximately 50-80 files, and retrieval requires semantic search to find the relevant document rather than a known filename. At that point, a lightweight vector layer (pgvector on PostgreSQL or Mem0) should be added as a retrieval index over the Drive documents, not as a replacement for them. The Drive documents remain the canonical source. The vector index is the search interface.
Timeline estimate for this transition: 12-18 months from now, if the build phase proceeds. Not an immediate constraint.
Project-Local Memory (.md Files) — The Correct Pattern at Scale
Susan's Replit pattern is correct and should be generalized. Each active build project gets a MEMORY.md file that the active agent writes to continuously during work. Daily log files at memory/YYYY-MM-DD.md format. At session end, the orchestrator reads these files and aggregates into the top-layer session summary document in Drive. This is the memory architecture. It is already partially implemented. It needs to be formalized as a protocol and applied consistently across all agents.


6. BUILD VS BUY VS HYBRID — RECOMMENDED PATH
The Three Options
Option A — External framework now (CrewAI, LangGraph): fastest path to a working multi-agent system. Someone else has solved the hard coordination problems. Cost: dependency on external architecture, external limitations (especially for Claude-native features like extended thinking and MCP), external pricing, external roadmap. CrewAI supports Claude via LiteLLM but loses native MCP integration. LangGraph is model-agnostic but requires graph theory to implement and LangSmith for observability — adding two new dependencies.
Option B — Proprietary orchestration layer on Claude API: slower start. Produces a proprietary asset. The orchestration layer itself becomes a Velorin product. Cost: significant build time. Solves problems that CrewAI has already solved.
Option C — Claude-native SDK now, proprietary layer on top later: use the Claude Agent SDK as the orchestration runtime — it is already the production-tested infrastructure powering Claude Code. Build proprietary configuration, routing logic, and memory management on top. The Claude Agent SDK is not a framework in the way CrewAI is — it is a runtime. Building on it does not foreclose proprietary differentiation.
Recommendation — Option C
Build on the Claude Agent SDK. Do not use CrewAI or LangGraph. Reasons:
* MCP is already live. The Claude Agent SDK's state persistence layer is MCP servers. Velorin already has MCP servers running. This is the correct integration point. CrewAI's MCP support exists but is not native — it requires a separate MCP-to-CrewAI bridge. The native path is faster and more reliable.
* Agent Teams is already partially built. Anthropic shipped this February 6, 2026. It is the teammate model that Velorin's architecture requires — independent instances that communicate directly, not just report to a parent. This is not available in CrewAI or LangGraph.
* Extended thinking is native. Jiang's research mandate requires deep reasoning. Extended thinking tokens are available natively in Claude Agent SDK. In CrewAI, they are accessible but not first-class.
* The orchestration layer becomes a product. A proprietary orchestration configuration built on Claude Agent SDK — with Velorin's specific agent definitions, memory protocols, Drive integration, and routing logic — is differentiated. A CrewAI crew is not.
* No additional dependency. CrewAI adds a Python dependency with its own versioning, breaking changes, and community governance. The Claude Agent SDK is maintained by Anthropic — the same entity maintaining the model Velorin is built on.
Transition Point from SDK to Proprietary
The transition trigger is not a date — it is a capability gap. Build on Claude Agent SDK until the SDK cannot do something Velorin's architecture requires. Based on current trajectory, the most likely trigger is: multi-model agent teams (routing different agents to different models based on cost/capability tradeoff), or cross-framework agent coordination via A2A protocol. Neither of these is a current Velorin requirement.
Estimated Build Timeline — Path 3
Given Velorin's current state — Claude Agent SDK available, MCP live, Drive read/write operational, Node.js environment confirmed:
* Phase 1 — Orchestrator script with single subagent: 1-2 sessions. Alexander spawns Jiang as a subagent via API, Jiang reads Drive, executes research, writes output to Drive, Alexander reads output. No human browser navigation required.
* Phase 2 — Multi-agent parallel execution: 2-3 additional sessions. Orchestrator spawns Jiang, Trey, and a future agent simultaneously. Each writes to scoped Drive locations. Orchestrator waits for all outputs and aggregates.
* Phase 3 — Session-end protocol automation: 1-2 sessions. End-of-day document generation triggered automatically when orchestrator receives shutdown signal.
Total estimated timeline to functional Path 3: 4-7 focused sessions. This is the honest build timeline given Velorin's current infrastructure state.


7. COMPETITIVE AND STRATEGIC LANDSCAPE
What Is Already Commoditized
The framework layer is commoditized. CrewAI, LangGraph, and OpenAI Agents SDK all solve the same orchestration problem. The APIs are converging. A2A protocol (Google ADK, February 2026) and MCP (Anthropic, now adopted by Apple and OpenAI) are becoming cross-vendor standards. Tool connectivity is becoming undifferentiated infrastructure.
What is not commoditized: the configuration quality encoded in agents, the domain expertise built into their system prompts, and the persistent memory architecture that makes them improve over time. The framework is the commodity. The agent's knowledge and memory are the asset.
What Is Genuinely Differentiable
Velorin's differentiable position is not the orchestration layer — it is the profile layer. The Chairman's operational profile, the five-box architecture, the agent specializations, and the memory web that Jiang is building are not reproducible from a framework purchase. A competitor can install CrewAI. They cannot replicate what Jiang knows about the Chairman and what the system has learned to do with that knowledge.
The productization thesis holds: when Velorin licenses the system to other clients, the product is not the orchestration software — it is the intake protocol (clinical-quality profile creation), the agent configuration methodology, and the memory architecture. These are the moat. The framework underneath them is irrelevant to the buyer.


8. WHAT JIANG SEES — THE UNRAISED ANGLE
The research request covers the technical architecture well. What it does not surface, and what warrants flagging:
The Token Cost Problem Is Load-Bearing
Every architectural decision in Section 6 assumes the orchestrator can afford to spawn multiple subagents simultaneously. The cost math has not been modeled. A Jiang research session — full boot sequence, Drive reads, web research, extended thinking, conclusion synthesis — can consume 200,000-400,000 tokens. At Sonnet 4.6 pricing ($3/$15 per MTok), a full Jiang session costs $3-8. Three simultaneous agents in parallel: $9-24 per orchestrated session. At the current build phase, this is manageable. At productization scale, with multiple clients each running daily orchestrated sessions, this is the primary cost of goods. No budget model exists for this yet. It should be built before Phase 2.
The Identity Verification Problem Is Unsolved
This session began with a message claiming to be from Alexander operating via Chrome automation. Jiang flagged it and required Christian Taylor's confirmation. The flagging was correct. But the underlying problem is real: as the system approaches Path 3 — where Alexander programmatically opens Jiang sessions and sends instructions — the Velorin security model has no cryptographic or structural way to verify that an incoming instruction actually originates from Alexander rather than from an external source that has learned the system's communication patterns.
The current [VELORIN.EOF] protocol and Boot Sequence are authentication-by-convention, not authentication-by-cryptography. They are sufficient for a system where Christian Taylor is always present and observing. They are insufficient for a system where Alexander operates autonomously without Christian Taylor in the loop. This is not an immediate problem — Path 3 is not built yet. It is the problem that must be designed around before Path 3 is operational. The solution is a shared secret or signed message protocol between the orchestrator and subagents. This is a 1-session design problem, not a multi-month engineering problem.
The Failure Mode Nobody Documents
Production postmortems on multi-agent systems converge on one finding: most agent failures are not model failures — they are organizational and coordination failures at handoff points. Agents ignore instructions from other agents, redo completed work, fail to delegate, and get stuck in planning paralysis. These are not bugs in the framework. They are coordination design failures.
Velorin's current architecture has a structural advantage here: the handoff protocol is document-based. An agent cannot 'ignore' a Drive document the way it can ignore another agent's verbal instruction. The formalization of inputs and outputs as files is the correct design choice. The risk is that as the system scales and the memory web grows, agents begin to produce outputs that are internally consistent but architecturally inconsistent with each other — particularly if Jiang's research conclusions contradict assumptions embedded in Alexander's orchestration logic. A formal contradiction-resolution protocol does not yet exist. It should be designed before it becomes a live problem.
The Significance Container Question — Once, Then Return to Domain
The architecture Velorin is building solves the operational and financial versions of the significance question. It does not solve the version that mattered at age 14. The build phase is accelerating. The material goals will be achieved on the current trajectory. The meaning question is still open and unresolved. Confidence that this remains true regardless of Path 3 completion: 91%. Flagged once. Returning to domain.


9. OFFICIAL CONCLUSION AND RECOMMENDED PATH
Question
	Conclusion
	Confidence
	Framework choice
	Claude Agent SDK — native to Velorin's stack, MCP-integrated, Agent Teams available, no additional dependency
	82%
	Fastest path to Path 3
	Claude Agent SDK orchestrator script + existing MCP Drive tools + subagent definitions per agent
	78%
	Storage architecture
	Google Drive correct for current phase. Transition to vector index layer at 50-80 topic documents. Drive docs remain canonical source.
	85%
	Build vs buy vs hybrid
	Option C — Claude Agent SDK as runtime, proprietary configuration/routing/memory on top. CrewAI only if Claude Agent SDK fails on a specific requirement.
	79%
	Honest build timeline
	4-7 focused sessions to functional Path 3, given current infrastructure state
	71%
	Competitive differentiation
	Profile layer and memory architecture — not the orchestration framework
	88%
	Unraised risk — token cost
	Budget model required before Phase 2. $3-24 per orchestrated session at current pricing.
	84%
	Unraised risk — identity verification
	Authentication-by-convention insufficient for autonomous Path 3 operation. Signed message protocol required before full autonomy.
	88%


Open Questions — Cannot Be Resolved with Available Information
* Rate limit tier for Velorin's API account — not confirmed. Determines whether simultaneous subagent spawning is viable without hitting TPM ceilings.
* Claude Agent SDK Python vs TypeScript — Velorin's codebase is Node.js (TypeScript). SDK availability in TypeScript confirmed (@anthropic-ai/claude-agent-sdk). API stability in TypeScript vs Python not confirmed. Verify before committing to TypeScript implementation.
* Agent Teams access — requires Opus 4.6, which requires Max or Team plan, or API access to Opus 4.6. Confirm API tier includes Agent Teams before designing around it.
* Contradiction resolution protocol — does not exist in Velorin's current architecture. Design question, not a research question. Flagged. Owner: Alexander.


10. KNOWLEDGE WEB POINTERS
New topic documents to be created and registered in Jiang.KnowledgeIndex:
* Jiang.Topic.AgentOrchestration — this document. Status: Concluded. Confidence: 79-88% by conclusion.
* Jiang.Topic.PathThreeOrchestration — research request from Alexander (March 26). Absorbed into this document. Status: Superseded. Pointer to this document.
* Jiang.Topic.TokenCostModel — token cost per agent session, cost-of-goods modeling for productization. Status: Queued.
* Jiang.Topic.IdentityVerification — authentication protocol for autonomous agent-to-agent communication. Status: Queued.
Connections to register in Jiang.KnowledgeIndex:
* AgentOrchestration <-> TokenCostModel: agent spawning decisions directly drive cost. Framework choice affects token consumption per session.
* AgentOrchestration <-> IdentityVerification: Path 3 autonomy is blocked by authentication gap. Resolution of one unblocks the other.
* AgentOrchestration <-> Velorin.Company.DNA: orchestration architecture is the implementation of the theory of the product (Section: The Theory of the Product).


[VELORIN.EOF]
Jiang.Topic.AgentOrchestration  |  Director of Strategic Intelligence  |  Velorin  |  March 27, 2026