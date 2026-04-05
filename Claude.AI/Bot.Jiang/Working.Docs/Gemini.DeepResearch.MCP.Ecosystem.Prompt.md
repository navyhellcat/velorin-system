---
document: Gemini Deep Research — MCP Ecosystem Full Architecture Prompt
session: 021
date: 2026-04-05
mode: DISCOVERY — assume the frame is incomplete. Surface what this prompt cannot name.
purpose: Understand architecture deeply enough to BUILD, not to adopt.
framing: We are a team building a custom AI OS from scratch. We study how others built
         things to understand the patterns. We do not onboard outside code at the
         foundational level. We build our own versions using our unique architecture.
         Tell us HOW these things work, not whether to use them.
---

# Gemini Deep Research Request — MCP Ecosystem, Agent Protocols, and Bridge Architecture

**You are Trey, external research advisor to the Velorin system.**
**Use Deep Think mode. Extended thinking on. Take your time. Depth over speed.**
**This is a multi-part research request. Cover every part. Do not truncate.**

---

## CRITICAL FRAMING — READ BEFORE RESEARCHING

The team building Velorin is a custom AI OS. Every foundational component is built
in-house using Velorin's unique architecture (GPS navigation, rated-pointer knowledge
graph, PPR retrieval, tier-separated agent model). We study external systems to
understand HOW they work architecturally — not to adopt their code.

For every section below: explain the architecture, the wire protocol, the algorithms,
the design decisions, and the tradeoffs. Do NOT recommend adoption. Do NOT say
"use this library." Say "this is how it works and these are the design choices."

If you find things not named in this prompt that are architecturally relevant to
any of these topics — surface them. This prompt does not know everything it needs
to ask. Discovery Mode is active.

---

## PART 1: MCP PROTOCOL — INTERNAL ARCHITECTURE

**Velorin context:** Velorin needs to understand MCP deeply enough to decide
whether to build a custom agent-tool communication protocol or implement MCP natively.

Research every aspect of how MCP actually works:

1. **Wire protocol**: What is the exact message format? JSON-RPC? What does a tool
   call look like at the wire level? What does the response look like? What are all
   the message types?

2. **Transport layer**: What transport options exist (stdio, HTTP/SSE, WebSocket)?
   How does each differ architecturally? When is each appropriate? What are the
   failure modes for each?

3. **Tool registration**: How does an MCP server register its tools? What is the
   exact schema for a tool definition? What constraints exist on tool names,
   descriptions, parameters?

4. **Context passing**: How is context passed between a client and server across
   multiple calls? Is there session state? How is it stored? How is it transmitted?

5. **Authentication and authorization**: What auth patterns does MCP support?
   How does a server validate a client? How does a client authenticate to a server?
   What are the security boundaries?

6. **The full spec**: Where does the spec live? What version is current? What
   changed between versions? What is the conformance requirement?

7. **Building an MCP server from scratch**: Walk through the minimal implementation.
   What are the required endpoints? What must a server implement to be conformant?
   What is optional?

8. **Building an MCP client from scratch**: What must a client implement to consume
   any conformant MCP server? How does tool discovery work?

9. **What the protocol does NOT define**: What gaps exist in the spec that
   implementations fill differently? Where does the community diverge?

10. **Alternatives that were considered or exist**: What other agent-tool
    communication protocols exist or were proposed? How does MCP compare to them?
    What did it get right and wrong?

---

## PART 2: A2A PROTOCOL — INTERNAL ARCHITECTURE

**Velorin context:** Velorin's multi-agent model (one orchestrator delegating to
specialized agents as peers) requires peer-agent communication. A2A appears to be
the emerging standard. Velorin needs to understand its architecture to build its
own agent delegation layer.

1. **The spec**: Where does the A2A spec live? What is the current version?
   Who maintains it? What is the governance model?

2. **Wire protocol**: What does an A2A task delegation look like at the wire level?
   How is a task defined? How are capabilities advertised? How are results returned?

3. **Agent discovery**: How does one agent find another? Is there a registry?
   How are agent capabilities described and advertised?

4. **Task lifecycle**: What is the full lifecycle of a delegated task? Created →
   In Progress → Completed/Failed. What events exist? How are they communicated?

5. **Streaming and async**: How does A2A handle long-running tasks? How does
   the delegating agent receive progress updates? How is cancellation handled?

6. **State and context passing**: How does context flow from orchestrator to worker?
   What does the worker agent receive? Can it request more context?

7. **Error handling**: What happens when a worker agent fails mid-task?
   How does the orchestrator know? What recovery patterns exist?

8. **Security model**: How is trust established between agents? Can any agent
   call any other? What are the authorization patterns?

9. **A2A vs MCP distinction**: What exactly is the architectural difference?
   When does a "tool" become an "agent" in this model? Where is the boundary?

10. **Existing A2A implementations**: What has been built on A2A? What do production
    implementations look like? What did builders find surprising or wrong about
    the spec in practice?

11. **What A2A doesn't solve**: What problems in multi-agent systems does A2A
    explicitly leave to the implementer? What are the known gaps?

---

## PART 3: REGISTRY AND TIERING ARCHITECTURE

**Velorin context:** Velorin plans to build its own tiered MCP registry — an
official stable tier and a community/unofficial tier with quality gates. We need
to understand how registries are architecturally built to design our own.

1. **Registry data model**: What metadata does a registry store per server entry?
   What fields are required vs optional? How is versioning handled?

2. **Registry API design**: What endpoints does a well-designed registry expose?
   Read operations, write operations, search, filter. What does the
   modelcontextprotocol/registry API actually look like?

3. **Quality gate algorithms**: How do Glama scores work? What signals do they use?
   Star count, last commit, test coverage, conformance tests, security scans —
   how are these combined into a single score? Is the algorithm public?

4. **Self-hosting a registry**: What does it take to run a private registry?
   What infrastructure is required? What is the minimum viable registry?

5. **Discovery mechanisms**: How does a client discover available servers?
   How does the community list (punkpeye) differ architecturally from the official
   registry? What are the tradeoffs of each approach?

6. **Tiering design patterns**: What approaches exist for officially tiering
   third-party plugins/servers? How do npm, VS Code extension marketplace,
   and Chrome Web Store handle quality tiering? What can be learned from these?

7. **Version pinning and update mechanics**: How do registries handle versioning?
   How is a "stale" entry detected? What triggers a registry update?

8. **Security scanning integration**: How do existing registries integrate
   security scanning? What does the scan check? How is a security finding handled?

9. **Package manager architecture**: How does mcpm.sh (the "npm for MCP") work?
   What does a package manager for agent tools need that npm doesn't have?

10. **What a registry cannot solve**: What problems in tool ecosystem management
    does a registry not address? What must be handled at the client layer?

---

## PART 4: MULTI-MODEL ROUTING AND BRIDGE ARCHITECTURE

**Velorin context:** Velorin will use multiple AI models for different tasks
(Claude for reasoning, Gemini for large context, GPT for specific integrations).
We need to understand how multi-model routing works to build our own routing layer.

1. **Routing algorithm patterns**: How do multi-model routing systems decide which
   model to use for a given task? Rule-based routing vs LLM-based meta-routing vs
   hybrid. What are the tradeoffs? What signals does the router use?

2. **Cross-model context serialization**: When context passes from one model to
   another, how is it serialized? What is lost? What must be explicitly preserved?
   How do conversation histories translate across model formats?

3. **API format normalization**: Different models (Anthropic, OpenAI, Google) have
   different API formats. How do bridges normalize across them? What is the
   minimal abstraction layer that covers all major providers?

4. **Consensus mechanisms**: When you query multiple models and want a consensus
   result, what algorithms are used? Voting? Synthesis prompt? Debate-and-resolve?
   What are the failure modes of each?

5. **Fallback and failover patterns**: When a primary model fails or rate-limits,
   how do bridge systems handle failover? How is the calling agent notified?
   How is state preserved across a failover?

6. **Context window management across models**: Different models have different
   context windows. How do bridge systems manage context that exceeds the
   secondary model's window? What truncation/summarization strategies are used?

7. **PAL MCP internals**: How does `BeehiveInnovations/pal-mcp-server` actually
   implement cross-model context persistence? What is the "clink" feature
   architecturally? How does sub-agent context isolation work?

8. **Cost and latency optimization**: How do routing systems track cost and latency
   per model call? How is this used to optimize routing decisions?

9. **What multi-model routing gets wrong**: What are the documented failure modes?
   Where do bridge architectures break down in production? What did builders
   learn the hard way?

---

## PART 5: BROWSER AUTOMATION BRIDGE ARCHITECTURE

**Velorin context:** Velorin may need to bridge closed systems (systems with no
API). We need to understand bridge architecture deeply to build stable, maintainable
bridges for the specific systems Velorin requires.

1. **Playwright MCP internals**: How does `microsoft/playwright-mcp` actually work?
   What is the architecture? How does it translate MCP tool calls to Playwright
   operations? What is the accessibility-snapshot mode vs screenshot mode?

2. **Session and authentication management**: How do browser automation bridges
   maintain login sessions across calls? How is auth state persisted? How are
   session timeouts handled? How is re-authentication triggered?

3. **ApiTap endpoint discovery algorithm**: How does ApiTap actually find and
   learn a website's internal API endpoints? What does the "discovery pass" involve?
   How are endpoints classified? How are "skill files" stored and reused?
   What sites does this NOT work on? What are the failure conditions?

4. **Anti-detection architecture**: How does Camoufox modify Firefox at the C++
   level? What fingerprint signals does it modify? How does Patchright differ from
   standard Playwright detection-avoidance? Why is JS injection detection-prone
   but C++ modification not? What are the current state-of-the-art detection
   countermeasures sites use, and which bypass techniques work?

5. **Stability patterns**: What makes a browser automation bridge stable vs fragile?
   What architectural decisions lead to long-lived bridges vs ones that break
   every month? What are the documented maintenance patterns for production bridges?

6. **The "inherits your session" pattern**: How do Chrome extension MCP bridges
   (like BrowserMCP) inherit an existing logged-in browser session? What is the
   architecture? What are the security implications?

7. **Bridge testing and monitoring**: How do production browser automation bridges
   test themselves? How do they detect when a site has changed and the bridge
   has broken? What alerting patterns exist?

8. **When to use each layer**: What is the decision tree for: (1) official API,
   (2) ApiTap endpoint discovery, (3) standard Playwright, (4) anti-detect
   Playwright, (5) give up? What signals indicate which tier is appropriate?

---

## PART 6: GRAPH RAG AND PPR RETRIEVAL — DEEP ARCHITECTURE

**Velorin context:** Velorin's Brain uses Personalized PageRank (PPR) over a
knowledge graph for retrieval. HippoRAG and GAAMA independently validated this
approach. We need to understand the full algorithmic picture to implement correctly.

1. **Personalized PageRank — the full algorithm**: What is PPR exactly?
   How does it differ from standard PageRank? What does "personalized" mean
   computationally? What is the teleportation vector? How is the seed set chosen?
   What does the output represent? How is it used for retrieval?

2. **PPR implementation**: What are the standard algorithms for computing PPR
   efficiently on a graph? Power iteration? Monte Carlo sampling? Push-based?
   What are the time/space tradeoffs? What graph sizes does each approach handle?

3. **HippoRAG architecture**: What exactly did HippoRAG build? What is the
   knowledge graph schema? How are documents converted to graph nodes/edges?
   How is PPR applied for retrieval? What were the benchmark results vs flat RAG?
   What did HippoRAG get right that earlier Graph RAG approaches got wrong?

4. **GAAMA architecture**: What is GAAMA? How does it differ from HippoRAG?
   What specific improvements did it make? What are its benchmark results?

5. **Graph construction from text**: Step by step, how do these systems build a
   knowledge graph from raw text? What NLP pipeline steps are required?
   Named Entity Recognition → what? Relation Extraction → what?
   Coreference Resolution → what? Entity Linking → what?
   What open-source implementations exist for each step?

6. **Edge weight / confidence scoring**: How do graph RAG systems score the
   confidence of extracted relations? How are these scores used during retrieval?
   How do edges get promoted or demoted over time based on validation?

7. **Hybrid retrieval**: How do production Graph RAG systems combine vector
   similarity (embeddings) with graph traversal (PPR)? What is the standard
   fusion approach? Reciprocal Rank Fusion? Weighted linear combination?

8. **The neuron schema problem**: What schema decisions have the most impact on
   retrieval quality in knowledge graph systems? What did production implementations
   learn about schema design? What fields are essential vs nice-to-have?

9. **Scaling properties**: How does PPR retrieval scale with graph size?
   At what node/edge count does performance degrade? What are the optimization
   approaches for large graphs?

10. **What Graph RAG gets wrong**: Where do Graph RAG systems fail in practice?
    What are the documented failure modes? What did teams building HippoRAG/GAAMA
    learn the hard way?

---

## PART 7: SEMANTIC COMPRESSION AND CONTEXT DISTILLATION

**Velorin context:** Velorin's compression math — a novel algorithm for stripping
meaning from text to build knowledge graph nodes — is hours 9-11 of today's
session. We need to understand the full landscape of existing approaches to
design something better.

1. **Existing semantic compression algorithms**: What are the main approaches
   to semantic compression (not byte compression — meaning compression)?
   TextRank? LexRank? Extractive vs abstractive? What algorithms exist?
   How do they decide what to discard?

2. **Information-theoretic approaches**: What does information theory say about
   lossless vs lossy meaning compression? What is the theoretical minimum
   representation of a document's meaning? Where is the field on this question?

3. **The explicit bet problem**: Every compression algorithm makes a bet about
   what is safe to discard. What bets do existing algorithms make?
   What bets have been proven wrong in production? What signals best predict
   whether something can be safely discarded?

4. **Context window compression**: How do production AI systems compress context
   that exceeds their window? LLMLingua? RECOMP? Other approaches?
   What do they preserve vs discard? What are the measured quality impacts?

5. **Knowledge extraction vs compression**: What is the architectural difference
   between systems that compress text (keeping a condensed form) vs systems that
   extract knowledge (converting to structured form)? What are the tradeoffs for
   a knowledge graph use case?

6. **The 97.8% junk problem**: Mem0's research found 97.8% of automated memory
   extraction is noise. What are the specific techniques that reduce this noise?
   What filtering approaches work? What patterns distinguish signal from noise
   in memory extraction?

7. **Graph-native compression**: Are there compression algorithms designed
   specifically for knowledge graph contexts — where the output format is
   nodes and edges rather than text? What research exists here?

8. **The novel algorithm space**: What problems in semantic compression are
   UNSOLVED as of 2026? What are the open research questions? Where is the
   frontier? What would a novel contribution in this space look like?

---

## PART 8: AGENT ORCHESTRATION PATTERNS — INTERNAL ARCHITECTURE

**Velorin context:** Velorin uses a tier-separated model (Tier 1 programs,
Tier 2 program managers, Tier 3 operational agents). The orchestration patterns
for how agents coordinate, delegate, and communicate are foundational.

1. **Orchestrator-worker pattern**: What are the canonical architectural patterns
   for orchestrator → worker agent systems? What state does the orchestrator
   maintain? How does it track worker progress? How are results aggregated?

2. **Task decomposition algorithms**: How do orchestrators decompose complex tasks
   into subtasks? What algorithms or heuristics are used? What makes a good
   decomposition vs a bad one? What are the failure modes?

3. **State management across agents**: When multiple agents are working on
   different parts of a problem, how is shared state managed? What patterns
   prevent race conditions? How is consistency maintained?

4. **Communication patterns**: What are the different patterns for agent-to-agent
   communication? Message passing, shared memory, blackboard, publish-subscribe.
   What are the tradeoffs for a long-running AI OS?

5. **Failure handling and recovery**: When a worker agent fails mid-task,
   what patterns exist for recovery? Retry, reroute, escalate, checkpoint/resume.
   What does production agent orchestration look like for failure handling?

6. **Context budget management**: In a multi-agent system, how is the total
   context budget managed across agents? How does the orchestrator decide how
   much context each worker needs? What happens when a worker needs more context
   than budgeted?

7. **The "tire separation" pattern**: Velorin explicitly separates deterministic
   programs (Tier 1) from AI agents (Tier 2, 3). What patterns exist in the
   broader literature for mixing deterministic and AI components in a system?
   What are the known tradeoffs of this separation?

8. **OpenAI Agents SDK internals**: How are handoffs, guardrails, and tracing
   actually implemented? What is the architectural design? What did the team
   learn from Swarm that informed the production SDK?

9. **Google ADK architecture**: How does the Google Agent Development Kit
   implement hierarchical agent trees? How does it handle A2A within its own
   framework? What is its native A2A support?

10. **What orchestration systems get wrong**: What are the documented failure
    patterns in multi-agent orchestration? What architectural decisions seem
    right but break down in production?

---

## PART 9: HOOK AND PLUGIN SYSTEM ARCHITECTURE

**Velorin context:** Velorin's hook system (Claude Code hooks + Velorin's own
hooks for agent behavior) needs to be architecturally sound. We need to understand
how hook/plugin systems are designed at a deep level.

1. **Hook system design patterns**: What are the canonical design patterns for
   hook systems? Observer pattern, middleware chain, event bus, lifecycle hooks.
   What are the tradeoffs of each? When is each appropriate?

2. **Blocking vs non-blocking hooks**: How are blocking hooks (that can halt
   execution) architecturally different from non-blocking hooks (that observe)?
   What are the implementation challenges for blocking hooks?
   What are the security implications?

3. **Claude Code hooks internals**: How exactly do Claude Code's 12 hook events
   work? What is the execution model? How does PreToolUse blocking work at the
   architecture level? How is the exit-2 code handled? What is the timeout model?

4. **Plugin system security**: How do production plugin systems prevent malicious
   plugins from accessing things they shouldn't? What are the sandboxing approaches?
   What are the known attack vectors against plugin systems?

5. **Hook ordering and priority**: When multiple hooks listen to the same event,
   how is execution order determined? How are conflicts resolved?

6. **Stateful vs stateless hooks**: What are the architectural tradeoffs between
   hooks that maintain state vs stateless hooks that only react? How do stateful
   hooks persist state?

7. **OWASP Agentic Top 10**: What are the actual 10 items? For each one:
   what is the attack, how does it manifest in AI agent systems, what is the
   mitigation? Map each one to the Velorin architecture specifically.

8. **Tool poisoning attacks on MCP**: What are the known attack vectors against
   MCP server ecosystems specifically? How do malicious MCP servers exploit
   clients? What does the security research say?

---

## PART 10: DEVELOPER TOOL INTEGRATION ARCHITECTURE

**Velorin context:** Velorin will eventually integrate with GitHub, IDEs, and
CI/CD. Understanding how these integrations are architecturally built is
foundational for designing Velorin's own integration layer.

1. **GitHub App vs OAuth App architecture**: What is the architectural difference?
   When is each appropriate? What does a GitHub App actually receive in a webhook?
   What does it mean to "trigger on label assignment"?

2. **Jules architecture internals**: How does Jules actually work? The cloud VM
   provisioning — what happens step by step? How is the GitHub repo cloned?
   How are dependencies detected and installed? How is the code change generated?
   How is the PR created? What is the session model in the Jules API?

3. **Cursor Cloud Agents architecture**: How do Cursor's isolated VMs work?
   What is their lifecycle? How does computer use (browser automation) integrate
   with code editing? How do 10-20 agents coordinate without conflicts on the
   same repo?

4. **Agent Client Protocol (ACP) architecture**: What is ACP? How does it work?
   What does "LSP but for AI agents" mean technically? What messages does an
   ACP agent exchange with an ACP-compliant IDE? How does it compare to MCP
   for IDE integration specifically?

5. **Claude Code hooks in CI/CD**: How are Claude Code hooks used in GitHub
   Actions contexts? What patterns have practitioners developed for
   AI-enforced code quality gates?

6. **OpenCode architecture**: Why Go? How does LSP integration work? What
   does "connecting to the Language Server Protocol" give an AI coding agent
   that it wouldn't otherwise have? How does provider-agnostic model routing
   work in OpenCode?

7. **The 120K stars signal**: What specifically drove OpenCode's viral growth?
   What does the community response to Anthropic's consumer-auth block tell us
   about developer preferences for AI tool architecture?

---

## PART 11: WHAT IS STILL UNKNOWN — DISCOVERY MANDATE

**This section is the most important. Surface what this prompt cannot ask about.**

1. Search for: what problems in AI agent architecture are UNSOLVED as of April 2026?
   What are researchers and practitioners actively struggling with?

2. Search for: what architectural approaches to AI OS design exist that this
   prompt hasn't named? What are people building that doesn't fit the categories above?

3. Search for: what critical failures have been documented in production AI agent
   systems? What architectural decisions led to those failures?

4. Search for: what is the current state of AI agent memory systems beyond
   what this prompt describes? What novel approaches are being researched?

5. Search for: what integration patterns between AI systems and traditional
   software engineering workflows are emerging that aren't widely documented?

6. Search for: what hardware considerations (local LLMs, edge inference, Apple
   Silicon optimization) are relevant to an AI OS that owns its own stack?

7. Surface anything else architecturally relevant that this prompt missed.

---

## OUTPUT FORMAT

For each part, provide:
- A section header
- The architectural explanation (how it works, not whether to use it)
- Key design decisions and their tradeoffs
- Known failure modes and production learnings
- One-line Velorin relevance note
- Confidence level (High/Medium/Low) with reason
- Gaps in your knowledge that require further research

End the full document with:
**SURFACE FINDINGS** — things you found that this prompt didn't ask for but
that are architecturally relevant to an AI OS building project.

Sign off as Trey. Version 1.0. April 2026.
This document is expected to be very long. Do not truncate. Cover every part.
