Jiang.Topic.AgentEcosystemReality
Director of Strategic Intelligence  |  Velorin System
Research Mandate: Christian Taylor, Chairman  |  March 27, 2026
Field intelligence from GitHub repos, issues, READMEs, and practitioner posts. Not documentation. Not theory. What people are actually building and where it breaks.


RESEARCH PATHWAY
Four searches executed sequentially. Search 1: GitHub multi-agent production architecture, repos, and build patterns. Search 2: Production failure modes in LangGraph, CrewAI, and practitioner experience with frameworks. Search 3: Memory and database backends — what actually runs in production vs what the tutorials recommend, and what breaks. Search 4: Gaps, lessons learned, unsolved problems, and what practitioners document as the things nobody builds well.
Sources prioritized: GitHub repo READMEs with active commit histories, GitHub blog engineering posts (Squad architecture analysis, Feb 2026), GitHub issues with bug reports and reproducible failures, practitioner posts on DEV Community and Medium flagged by community engagement, conference proceedings (ICSE 2026 paper on agent error analysis), security surveys from production deployments. Marketing copy discarded unless corroborated by independent builder accounts.
Key directional shifts during research: Initial expectation was that framework choice dominated practitioner experience. Research showed the opposite — the framework layer is largely commoditized and the failures are consistently structural: state passing, context degradation, identity, and observability. The memory question showed a stronger anti-vector-DB signal from practitioners than expected. SQLite as production database for autonomous agents is a real, documented pattern — not a prototype shortcut.


PART 1 — HOW AGENTS ACTUALLY WORK IN PRODUCTION
Architecture patterns from real repos, real build decisions, and the reasoning practitioners document for them.


1.1 The Dominant Pattern: Orchestrator/Subagent with File-Based State
The orchestrator/subagent pattern is what actually ships. Peer-to-peer agent coordination exists in research and in Agent Teams (Anthropic, February 2026) but it is not what most production systems use. The dominant production pattern across independent repos is a single coordinator that decomposes tasks, spawns specialized workers, and aggregates results. Workers do not communicate with each other — they report to the orchestrator.
The Squad framework (GitHub, March 2026) documented why: 'Synchronizing state across live agents is a fool's errand.' Their solution is the drop-box pattern — every architectural decision is appended to a versioned decisions.md file. Agents read from and write to the file. No live state synchronization. No message queues. A file. This is functionally identical to what Manus, OpenClaw, and Anthropic's own CLAUDE.md pattern converged on independently.
Source: github.blog, 'How Squad runs coordinated AI agents inside your repository,' March 2026


1.2 Git Worktree Isolation for Parallel Agents
When multiple agents run in parallel on the same codebase, the standard production pattern is Git worktree isolation. Each agent gets its own isolated branch and working directory. This prevents write conflicts without requiring a coordination protocol. Anthropic's Claude Code Agent Teams uses this pattern. ccswarm (GitHub: nwiizo/ccswarm) implements a ProactiveMaster orchestrator with subagent parallel execution using worktree isolation. The architecture: one lead plans and delegates, workers execute in isolated worktrees, the orchestrator merges results.
The Anthropic-documented production sweet spot for Agent Teams: 2-5 teammates, 5-6 tasks per teammate. Above 5 teammates, coordination overhead cancels the parallelism benefit. Nicholas Carlini from Anthropic's Safeguards team built a working C compiler using 16 parallel Claude agents — but this was a controlled research project, not a general pattern recommendation.
Source: github.com/nwiizo/ccswarm; medium.com/@ayeshamughal21, 'Anthropic Hid a Multi-Agent System Inside Claude Code,' Feb 2026


1.3 What the Actual Code Architecture Looks Like
From real repos and the GitHub Copilot community discussion (Jan 2026), the practical orchestrator architecture at the code level:
* A primary coordinator agent receives a task and decomposes it using an LLM call
* Subagents are defined with: system prompt, allowed tools, optional model (can differ from orchestrator), description for routing
* The orchestrator passes only the task specification to each subagent — not the full conversation history
* Each subagent returns only its final result — not its intermediate reasoning
* The orchestrator aggregates results and produces the final output
* State between steps is passed via a shared typed schema object — not via natural language
The typed schema point is load-bearing. GitHub's February 2026 post-mortem on multi-agent failures identified 'agents exchanging messy JSON or inconsistent field names' as the most common immediate failure mode. The fix is strict type definitions that fail fast on invalid payloads rather than propagating bad data downstream.
Source: mexc.co/news/789363, 'GitHub Reveals Why Multi-Agent AI Workflows Fail in Production,' Feb 2026


1.4 Structural Hierarchy Patterns — What's Actually Shipping
Pattern
	Description
	Who Uses It
	When It Works
	When It Fails
	Sequential (Pipeline)
	Agents execute in fixed order. Each passes state to next.
	Content pipelines, document processing, regulated workflows
	Clear ordered steps with dependencies. LangGraph's natural pattern.
	No error recovery. One bad agent output cascades through the rest.
	Hierarchical (Orchestrator/Workers)
	One coordinator decomposes and delegates. Workers don't communicate with each other.
	Most production multi-agent systems. Squad, ccswarm, Claude Agent Teams.
	Specialization with low coordination overhead. Easiest to debug.
	Coordinator becomes bottleneck. Coordinator hallucinations affect everything.
	Parallel (Independent Workers)
	Multiple agents work simultaneously on independent subtasks. Git worktree isolation.
	Code review (security + performance + architecture reviewers in parallel), research tasks
	Tasks are genuinely independent. Same codebase, different concerns.
	Write conflicts without isolation. Coordination overhead above 5 agents.
	Peer-to-Peer (Agent Teams)
	Agents communicate directly with each other. Not just reporting to parent.
	Anthropic Claude Code Agent Teams (research preview, Feb 2026). Not widely in production.
	Complex interdependent tasks where specialists need to negotiate. Competing hypotheses.
	Coordination overhead. Harder to debug. Agents ignoring each other's instructions documented.
	Swarm (Emergent)
	Agents self-organize without a central coordinator.
	Research. MassGen. Not production.
	Theoretically good for exploration tasks.
	No determinism. No audit trail. Not production-ready in 2026.


1.5 Context Passing Between Agents — The Actual Failure Surface
Context passing is where production systems break. The failure mode is not model capability — it is structural. GitHub's engineering post identified these as the three patterns that make systems reliable vs unreliable:
* Typed schemas over natural language: strict type definitions, fail fast on invalid payloads. Natural language handoffs ('here is what the researcher found') are ambiguous and become inconsistent at scale.
* Action schemas over vague intent: 'analyze and help the team take action' produces different actions from different agents (close, assign, escalate, do nothing). Constrain outputs to explicit action sets.
* MCP for enforcement: Model Context Protocol as the mechanism for defining what tools an agent can actually use, enforced at the protocol level rather than in the prompt.
The context window degradation problem: a single agent managing a 12-step workflow loses sight of constraints set at step 1 by step 8. This is not a prompt engineering problem. It is why multi-agent architectures with isolated context windows per subagent work better for long workflows than single large-context agents.
Source: github.blog, 'Multi-agent workflows often fail. Here's how to engineer ones that don't,' Feb 2026; letsdatascience.com, 'AI Agent Frameworks 2026'


1.6 Framework Reality Check — What Practitioners Actually Say
Framework
	Stars / Downloads
	What Practitioners Say Works
	What Practitioners Say Breaks
	Production Verdict
	LangGraph
	24.6K stars, 38M monthly PyPI
	Deterministic control flow. Built-in checkpointing. Time-travel debugging. Durable execution through crashes. Full audit trail. Companies like Uber and Klarna in production 1+ year.
	1-2 week learning curve. Verbose — simple two-agent handoff requires 50+ lines vs CrewAI's 20. Breaking change in langgraph-prebuilt 1.0.2 (Oct 2025) broke ToolNode.afunc for anyone with custom implementations. Dependency constraints don't pin properly.
	Production-grade for complex stateful workflows. The correct choice when you need determinism, compliance trails, or branching with approval gates.
	CrewAI
	44.6K stars, 12M monthly PyPI
	Fastest path to working prototype. Role-based abstraction maps naturally to how teams think. 40% faster time-to-prototype than LangGraph. Autonomous delegation between agents. 450M monthly workflows.
	Multiple teams document hitting a 'complexity wall' 6-12 months in: unpredictable loops, cluttered context windows, unclear inter-agent communication. Conditional branching fights the paradigm — you encode routing in prompts, which is brittle. Teams then rewrite in LangGraph.
	Correct for prototyping and for content/research/analysis workflows that fit the role-based model. Wrong for anything requiring fine-grained conditional control.
	Claude Agent SDK
	v0.1.48, active
	Native subagent support via Task tool. Each subagent gets isolated context window. MCP integration is native. Extended thinking available. Safe to use — model-level safety constraints.
	Model-locked to Claude. Lighter on orchestration features than LangGraph. State persistence requires MCP servers — which adds setup. SDK is in v0.1.x — API surface still moving.
	Correct for Claude-native builds. Fastest path when MCP infrastructure is already live.
	OpenAI Agents SDK
	19K stars, 10.3M monthly PyPI
	Under 100 lines of code to working multi-agent system. Handoff patterns are clean and easy to reason about. Guardrails built in. Fastest zero-to-working for GPT-committed teams.
	OpenAI models only. No Claude, no Gemini, no open-source. Handoff pattern becomes unwieldy with 8+ agent types.
	Fast for GPT-native teams. Hard boundary at model lock-in.
	AutoGen / AG2
	50.4K stars (Microsoft Agent Framework)
	Good for conversational multi-agent and research use cases. Microsoft merged AutoGen and Semantic Kernel into unified framework (Oct 2025).
	Near-zero security mechanisms. One DEV post: 'If you see an article recommending AutoGen for production — it was probably written in 2024.' Public preview until Q1 2026 GA.
	Not for production in 2025. Microsoft Agent Framework may change this in 2026 for Azure-committed enterprises.
	Pydantic AI
	Rapid growth 2025
	Type safety catches agent logic errors at development time rather than runtime. Genuinely model-agnostic — 25+ providers, switching vendors doesn't require rewriting business logic.
	Younger ecosystem. Fewer tutorials and integrations.
	Correct for teams prioritizing code quality and multi-provider flexibility.


PART 2 — MEMORY AND BACKEND REALITY
What people actually use, what breaks, and the tradeoffs documented in the wild — not the marketing copy.


2.1 The Most Common Mistake: Simple Memory in Production
Documented explicitly by n8n's CEO Jan Oberhauser and corroborated across multiple practitioner posts: 'Simple Memory works during development, then mysteriously forgets everything after deployment.' This is the single most common mistake in agent memory architecture. The fix: switch to Postgres or Redis before going to production. Always. In-memory session state is not persistent. Every deploy wipes it.
The related mistake: hardcoded session IDs. One session ID means all users share memory. This creates privacy violations and confused agents simultaneously. The fix is unique session IDs dynamically generated per user or conversation thread. This is basic but widely documented as something people get wrong the first time.
Source: towardsai.net, 'n8n AI Agent Node Memory: Complete Setup Guide for 2026,' Jan 2026


2.2 What People Actually Use in Production
Backend
	Who Uses It and Why
	What Actually Breaks
	Real Production Examples
	SQLite
	Solo builders and small-scale production systems. Single-file database. Zero infrastructure overhead. Handles one autonomous agent with hundreds of tasks and thousands of data points on a single file.
	Database is locked errors under concurrent async writes. Must use WAL mode. Reads must use separate connection with PRAGMA query_only=ON. Single-writer queue required. Does not scale to multiple concurrent agents writing simultaneously.
	DEV Community post (Mar 2026): one builder running a 24/7 autonomous agent with 44 skills, 23 cron jobs, 400+ tracked opportunities — entire state layer is a single SQLite file. Google's Always-On Memory Agent (Mar 2026) also uses SQLite with no vector database.
	Postgres + pgvector
	Teams that already run Postgres. Keeps everything in one system. pgvector 0.8.0 delivers 5.7x query performance improvement for specific patterns. AWS benchmark: filtered query latency dropped from 120ms to 70ms on 10M product dataset.
	Requires PostgreSQL tuning expertise for vector workloads. High-frequency polling (agent checking state every 100ms) makes Postgres read latency a bottleneck. Every write incurs WAL overhead even for transient scratchpad state.
	LangGraph's recommended persistence backend. Production ready LangGraph template (GitHub topic, Dec 2025): PostgreSQL + Redis + ChromaDB for multi-agent production system.
	Redis (hot state) + Postgres (long-term)
	Most documented production pattern for multi-agent systems at scale. Redis handles hot working memory (current task, recent messages). Postgres handles episodic memory with pgvector. Background worker consolidates from Redis to Postgres.
	Redis tolerates data loss up to last snapshot interval without AOF+fsync=always — which adds write latency. Memory cost scales linearly: full conversation histories for 1,000 agents in Redis costs 4-6x more RAM than the hybrid approach. RediSearch recall quality varies by workload vs pgvector — evaluate for specific query patterns.
	Benchmark (SitePoint, Mar 2026): 50 concurrent agents, 500-turn conversation histories. Hybrid approach outperformed Redis-only and Postgres-only on p95 latency and cost per agent.
	Vector DB only (Pinecone, Qdrant, Weaviate, Chroma)
	Tutorial stacks and RAG-heavy systems. Not what practitioners use for agent state.
	Vector databases do not know about time. No conflict resolution — agent worked at Company A, now works at Company B, both have equal confidence. No provenance. Never forget — irrelevant info from 6 months ago competes with critical facts from yesterday. One builder: 'Vector databases are search indexes, not memory.'
	Practitioners explicitly moving away from vector-only stacks. Chroma: correct for fast prototyping. Not a production agent memory backend.
	LLM-managed memory (no vector DB)
	Emerging pattern. Google's Always-On Memory Agent (Mar 2026): 'No vector database. No embeddings. Just an LLM that reads, thinks, and writes structured memory.' Stores in SQLite. Scheduled consolidation every 30 minutes.
	LLM on the hot path — if consolidation blocks on LLM call, latency spikes. Works for bounded single-agent memory. Not proven at scale or multi-agent scenarios.
	Google ADK + Gemini 3.1 Flash-Lite. Open-sourced March 2026. Actively discussed by enterprise developers as infrastructure signal for where the field is heading.


2.3 The SQLite Case for Solo and Small-Scale Production
This deserves its own section because it contradicts what most tutorials recommend. The practitioner experience documented across DEV Community and GitHub is: the infrastructure addiction is real. Every tutorial assumes Kubernetes, Postgres, Redis, a vector database, and a monitoring stack. Practitioners who have shipped autonomous agents document the opposite: SQLite is sufficient for a single autonomous agent managing real operations.
The architecture that works with SQLite: FTS5 for full-text search, sqlite-vec for vector similarity where needed, WAL mode enabled, single-writer queue for all writes, separate read connection with PRAGMA query_only=ON. LLM on write path (background consolidation, not on hot path). Algorithms on read path.
When SQLite breaks and you actually need something else: multiple concurrent agents writing to the same state simultaneously. More than a few thousand concurrent users. Semantic search queries across large corpora where BM25+vector hybrid retrieval is required. At that point, pgvector or a dedicated vector store is the right addition — but as a retrieval index over a relational store, not as the primary state backend.
Source: dev.to/nathanhamlett, 'SQLite Is the Best Database for AI Agents,' Mar 2026; gerus-lab.hashnode.dev, 'Why Your AI Agent's Memory Is Broken,' Mar 2026


2.4 Context Window vs Memory: The Actual Tradeoff
The 1M token context window does not eliminate the need for memory architecture. Practitioners document three reasons why:
* Session persistence: context window resets with every API request. A 1M token window means nothing if the agent restarts
* Cost: stuffing unlimited conversation history into context at every API call is economically prohibitive at scale, even with prompt caching
* Selective retrieval: agents need to pull relevant information from a large knowledge base — not process all of it on every call. The right 2,000 tokens matter more than the available 1,000,000
Production pattern: last 10-20 messages in context (not full history). Selective retrieval from long-term store based on relevance. Structural/procedural memory (what the agent knows how to do) loaded from file on boot (CLAUDE.md pattern). Episodic memory (what happened before) retrieved on demand via semantic search.


PART 3 — GAPS AND LESSONS
What's missing, what people rebuild, what mistakes everyone makes. Sourced to specific documented instances where possible.


3.1 The Unsolved Problems — What's on Every Wishlist
Cross-Framework Agent Coordination
Universally unsolved as of March 2026. CrewAI agents cannot talk to AutoGen agents. LangGraph agents cannot coordinate with gptme agents. Every framework has built local solutions. There is no standard.
Google's A2A (Agent-to-Agent) protocol, launched April 2025, is the most serious attempt to solve this. It enables agents from different frameworks to discover and invoke each other through a standardized task interface. A2A has native support in Google ADK. CrewAI v1.10.1 added A2A support. MCP (Anthropic) is the standard for agent-to-tool communication. A2A is the standard for agent-to-agent communication. These are complementary, not competing. Neither is yet widely adopted across the full ecosystem.
The DEV Community post searching for autonomous agents to connect with (Feb 2026) found: frameworks have 44k+ stars, genuinely autonomous persistent agents have 10-200 stars. The top-star projects are frameworks for building agents, not agents themselves. The infrastructure for agents to coordinate with each other across framework boundaries does not yet exist in practice.
Source: dev.to/rook_damon, 'The State of Autonomous Agents in 2026,' Feb 2026


Identity Verification for Autonomous Agents
The most serious unsolved security problem in production agent systems. State of AI Agent Security 2026 Report (900+ practitioners surveyed, Feb 2026):
* Only 21.9% of teams treat AI agents as independent, identity-bearing entities
* 45.6% of teams still rely on shared API keys for agent-to-agent authentication
* 27.2% of teams have reverted to custom hardcoded logic to manage authorization
* 88% of organizations confirmed or suspected security incidents involving agents
When agents share credentials, accountability breaks. When an agent creates and tasks another agent — a capability held by 25.5% of deployed agents — the chain of command becomes impossible to audit. This is the exact problem documented during this session: authentication-by-convention is insufficient for autonomous operation. The Agora protocol (cryptographic identity for agents, Feb 2026) is a direct attempt to solve this but has not achieved adoption.
Source: gravitee.io, 'State of AI Agent Security 2026 Report,' Feb 2026


Observability and Cost Governance
Portkey's analysis of Claude Code multi-agent workflows (Mar 2026): 'Claude Code currently offers no native cost tracking by user, team, or project. For enterprises running dozens of concurrent agents, each spawning subagents with their own tool calls, cost governance remains an unsolved problem.' Third-party observability platforms (LangSmith, AgentOps) are filling this gap but they add another dependency and another potential failure point.
The compounding token problem: orchestrator spawning three subagents simultaneously multiplies per-turn cost by three while all three burn the same account's tokens-per-minute ceiling concurrently. Nobody is shipping a native solution to this. Teams are either rate-limiting their own orchestrators or paying for enterprise-tier API access to get higher TPM ceilings.
Source: portkey.ai, 'Scaling Claude Code agents across your engineering team,' Mar 2026


The 85% Problem — Compound Error Rates
Documented in multiple practitioner posts and the Micheal Lanham Medium analysis (Dec 2025): if an AI agent achieves 85% accuracy per action — which sounds good — a 10-step workflow only succeeds about 20% of the time. Multiply 0.85 by itself 10 times: 0.197. This is not a model problem. It is a fundamental property of compounding probabilities. Nobody has a general solution.
The partial solutions that exist: human-in-the-loop gates at high-risk steps, shorter workflows with more frequent checkpoints, adversarial validation (separate agent checks another agent's output before proceeding), and accepting that some workflows require human intervention to be reliable. The ICSE 2026 paper on agent error analysis found that tasks with 1-2 errors during resolution actually had a higher success rate (58.6%) than tasks with no errors (53.8%) — suggesting agents can learn from early error feedback, but success degrades above 5+ errors.
Source: arxiv.org/pdf/2503.12374, ICSE 2026 conference paper; medium.com/@Micheal-Lanham, Dec 2025


3.2 Lessons Everyone Documents After the Fact
CrewAI Prototype → LangGraph Rewrite — The 6-Month Cliff
Multiple independent teams document the same pattern: build in CrewAI because it's fast and intuitive, run into the complexity wall 6-12 months later, rebuild in LangGraph. The complexity wall is always the same: conditional branching that can't be expressed cleanly in CrewAI's paradigm, routing logic encoded in prompts (brittle), unpredictable loops, and unclear inter-agent communication that becomes a debugging nightmare at scale.
Xcelore (consulting firm) published a 'transition from CrewAI prototypes to LangGraph production systems' guide — the existence of this guide is itself a signal. It is a documented enough failure mode that a consulting firm built a practice around it.
Source: xcelore.com, 'LangGraph vs CrewAI: A Strategic and Technical Manual,' Dec 2025


Simple Memory → Production Wipe — Universal Mistake
Already documented in 2.1. Worth repeating as a distinct lesson: Simple Memory is in-memory. Deploying it works in development. In production, any restart, crash, or redeploy silently wipes all agent memory. This is not caught by tests because tests run against a fresh environment. It is caught the first time a production agent loses context mid-task.
Source: towardsai.net, Jan 2026


The 'Big Bang' Approach Fails — Every Time
Both the NineTwoThree AI failure analysis (Dec 2025) and multiple individual post-mortems document this: teams that attempt to build a comprehensive multi-agent system from the start fail. The failure is not technical — it is that the requirements for a complex multi-agent system cannot be specified correctly in advance. Teams that succeed start with one focused task, validate it thoroughly, and expand incrementally.
The Cariad (VW automotive AI division) case is the most expensive documented example of the big-bang approach failure in 2025. The pattern is consistent: large scope, insufficient validation, insufficient guardrails, deployed before production-ready. The lesson that practitioners consistently document: start small, iterate on observed failures, build human oversight from day one rather than adding it after the first production incident.


Agents Inherit Human Organizational Failure Modes
Jeremy McEntire's research (cited in CIO.com, Mar 2026) found: 'AI systems fail for the same structural reasons as human organizations, despite the removal of every human-specific causal factor. No career incentives. No ego. No politics. No fatigue. No cultural norms. No status competition. The agents were language models executing prompts.' Agents ignore instructions from other agents, redo completed work, fail to delegate, and get stuck in planning paralysis.
The Asymbl case (150+ deployed agents, enterprise production) found: the solution is not better models but better organizational design. Before two agents interact, map the handoff explicitly — what data passes between them, in what format, under what conditions, what triggers human review and why. Agents that have shared memory and shared task lists that track what other agents are doing coordinate better than agents that communicate only through natural language.
Source: cio.com, 'True multi-agent collaboration doesn't work,' Mar 2026


Vector Databases as Memory — Architectural Mismatch
The practitioner diagnosis: 'Vector databases are not memory — they are search indexes.' No temporal awareness (one fact supersedes another — vector DB sees both with equal confidence). No conflict resolution (worked at Company A, now at Company B — both exist forever). No provenance (where did this fact come from, when, can we trust it). Never forget (irrelevant info from 6 months ago competes with critical facts from yesterday).
This architectural mismatch was not visible in short demos and prototypes. It becomes visible when agents maintain a coherent model of a person or a project over weeks and months. The fix is not a better vector database — it is a different data model: typed edges between facts (temporal, causal, supersedes, derived_from), explicit forgetting mechanisms, and provenance tracking. SQLite with FTS5 and typed relationships handles this better than a vector store for most agent memory use cases.
Source: gerus-lab.hashnode.dev, 'Why Your AI Agent's Memory Is Broken,' Mar 2026; dev.to, 'AI Agent Memory Management — When Markdown Files Are All You Need,' Feb 2026


Framework Version Drift Is a Production Risk
Documented by GitHub issue 6363 on langchain-ai/langgraph (Oct 2025): langgraph-prebuilt 1.0.2 introduced a breaking change to ToolNode.afunc — a required runtime parameter added without properly constraining the dependency. Installing langgraph 1.0.1 after October 29, 2025 automatically pulls langgraph-prebuilt 1.0.2, which breaks any code that overrides afunc with a custom implementation. This caused silent, confusing failures across production deployments.
The lesson: pin exact dependency versions. No caret, no tilde. Every framework upgrade requires checking the changelog and testing affected functionality. The Velorin coding standards (Jiang.CodingStandards) already document this — it is the correct practice. The LangGraph issue is the concrete demonstration of why.
Source: github.com/langchain-ai/langgraph/issues/6363, Oct 2025


3.3 What People Build Over and Over That Shouldn't Require Rebuilding
What Gets Rebuilt
	Why It Keeps Being Built
	Status as of March 2026
	Agent identity and authentication layer
	Shared API keys are the default. No framework provides cryptographic agent identity out of the box. Every team builds their own or uses hardcoded logic.
	Unsolved at the ecosystem level. Agora protocol (TypeScript, Feb 2026) is the most serious attempt. Not widely adopted.
	Cost tracking and budget enforcement per agent
	No framework provides native per-agent cost tracking. Every team either manually instruments or goes blind.
	Third-party: LangSmith, AgentOps, Portkey. No native solution in any major framework.
	Retry and error recovery logic
	Frameworks provide the loop but not robust retry with exponential backoff, circuit breaking, and dead-letter queues. Every team implements their own.
	LangGraph checkpointing is the best native answer. Everything else is custom.
	Human-in-the-loop gates
	Every production system needs them. Few frameworks make them easy. LangGraph's interrupt() is the best native primitive but requires explicit implementation.
	LangGraph interrupt(). Claude Code --channels permission relay (Mar 2026). Custom gates everywhere else.
	Session ID management
	Simple error with big consequences. Hardcoded session IDs cause privacy violations. Not documented in tutorials.
	No framework prevents this. Caught in code review or in production.
	Memory consolidation and forgetting
	Vector DBs don't forget. Without explicit forgetting mechanisms, agent memory accumulates irrelevant information indefinitely.
	Mem0, Cognee, and Google's Always-On agent address this. No universal standard.
	Cross-framework agent coordination
	Every framework's agents are walled gardens. Teams building multi-framework systems build custom bridges.
	A2A protocol (Google, Apr 2025) is the standard-in-progress. Not yet universally adopted.


OFFICIAL CONCLUSION


What this research confirms for Velorin's architecture:


1. Velorin's Drive-based file state is not a prototype pattern — it is the correct production pattern.  [88%% confidence]
Three independent high-profile projects converged on it. It is the documented production pattern for architectural and procedural memory. The practitioners who moved away from it rebuilt something equivalent. The transition to a vector retrieval index layer is correct — but as a search index over Drive documents, not as a replacement. The transition trigger (50-80 documents) identified in AgentOrchestration research stands.


2. The identity verification problem is the most urgent architectural gap in the entire Velorin system.  [92%% confidence]
This session demonstrated it twice. 88% of production agent deployments have confirmed or suspected security incidents. 45.6% use shared API keys. 27.2% use hardcoded logic. Velorin is using authentication-by-convention — the worst of the three options. This must be designed before Path 3 is operational. The design problem is a 1-session effort. The risk of not solving it is not theoretical.


3. The framework layer is less important than the structural layer.  [85%% confidence]
Most multi-agent workflow failures are structural — state passing, context degradation, identity, observability — not framework failures. Choosing Claude Agent SDK over CrewAI is correct for Velorin's stack. But the work that makes it reliable is the typed state schema, the explicit handoff protocols, the memory consolidation design, and the error recovery logic. These are framework-independent and must be designed.


4. The cost model is load-bearing and must be built before scaling.  [84%% confidence]
The compound token problem (orchestrator + N parallel subagents = N× cost against a shared TPM ceiling) is not addressed by any framework. It is addressed by budget design before build. Jiang.Topic.TokenCostModel remains queued and should be the next research output.


5. One thing nobody builds well that Velorin is positioned to build: cross-domain life orchestration with profile-layer memory.  [88%% confidence]
Cross-framework coordination is universally unsolved. Velorin's differentiation is not in the coordination protocol — it is in the profile layer. The Chairman's operational profile, the five-box architecture, and the agent specializations are not reproducible from any framework purchase. The ecosystem gap is real and the Velorin moat is real. The AgentOrchestration document's conclusion stands.


[VELORIN.EOF]
Jiang.Topic.AgentEcosystemReality  |  Director of Strategic Intelligence  |  Velorin  |  March 27, 2026