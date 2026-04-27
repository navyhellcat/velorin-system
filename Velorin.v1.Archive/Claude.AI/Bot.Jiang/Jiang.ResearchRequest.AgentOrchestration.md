Jiang.ResearchRequest.AgentOrchestration
Director of Strategic Intelligence | Velorin System
March 27, 2026
Issued by: Alexander, CEO


RESEARCH REQUEST — MULTI-AGENT ORCHESTRATION ARCHITECTURE


1. THE PROBLEM


Christian Taylor currently operates with a single AI instance at a time — one Claude chat session or one Claude Desktop session with MCP. There is no parallelism. No coordination between agents working simultaneously. No persistent per-project memory that builds automatically during a work session and aggregates into a structured reference at session end and project end.


The desired end state is:


- Many agents working in parallel, each with its own scoped memory
- Each agent writes a memory file (.md or equivalent) as it works — logging decisions, progress, and context continuously
- At session end: an aggregation layer produces a top-level document with pointers to all memory files, summaries, and forward plans
- At project end: a further top-level document summarizing the entire project for future reference
- The whole system coordinated by an orchestration layer that spawns agents, assigns tasks, routes outputs, and manages results


The memory architecture is already partially solved: Google Drive for persistent top-layer documents that evolve over time. Project-local .md files for active build context. Susan (Replit-based consultant) already uses .md file memory inside Replit projects successfully. The Velorin boot protocol uses Drive documents as persistent memory. These patterns are proven. The missing piece is the orchestration and spawning layer.


2. PRELIMINARY HYPOTHESES FROM ALEXANDER


These are starting points only. Jiang must evaluate them against actual research and reach independent conclusions.


Hypothesis A — Use an existing orchestration framework now (CrewAI, AutoGen, LangChain/LangGraph). Fastest path to working multi-agent system. Someone else has solved the hard coordination problems. Downside: dependency on external architecture, external limitations, external pricing, external roadmap.


Hypothesis B — Build a proprietary orchestration layer on the Claude API. Slower start. Produces a proprietary asset. The orchestration layer itself becomes a Velorin product. Downside: significant build time, requires solving problems others have already solved.


Hypothesis C — Use existing frameworks as scaffolding now, build proprietary layer on top or replace them later once the architecture is proven. Potentially the right path but requires knowing when and how to transition cleanly.


These hypotheses may all be wrong or incomplete. Jiang should discard them if the data contradicts them.


3. RESEARCH MANDATE


Jiang will research and reach independent conclusions on the following questions:


3.1 What orchestration frameworks exist today for multi-agent AI systems? What are their actual capabilities, limitations, pricing models, and failure modes? Not marketing — real operational data from builders who have used them.


3.2 What does the Claude API actually enable for multi-agent spawning and coordination? What are the real constraints — cost, rate limits, latency, context management at scale?


3.3 What does a system that matches the desired end state above actually look like when built? What are the components, the dependencies, the points of failure?


3.4 What is the storage architecture question? Is Google Drive the right substrate for the top-layer persistent memory? What are the alternatives and their tradeoffs? For project-local memory (.md files), what is the right pattern at scale?


3.5 Build vs. buy vs. hybrid — given Velorin's current state (solo build, Claude API access, MCP infrastructure live, Google Drive as memory layer, target of productization and licensing), what is the recommended path? At what point does a hybrid approach transition to proprietary? What are the trigger conditions?


3.6 What is the competitive and strategic landscape? Who else is building this? What is already commoditized vs. what is still genuinely differentiable? If Velorin builds a proprietary orchestration layer, what is the actual defensible value?


3.7 What does Jiang see that Alexander has not raised? This question is open-ended and required. The most valuable output may be the angle nobody thought to look at.


4. OUTPUT REQUIRED


One conclusion document: Jiang.Topic.AgentOrchestration


Structure:
- Research pathway — what was found, what caused directional shifts, key sources
- Answers to each question in Section 3 above
- Official conclusion and recommended path for Velorin
- Confidence percentage on the recommendation
- Open questions that could not be resolved with available information
- Pointers to any related topic documents in the knowledge web


Minimum confidence threshold for recommendation delivery: 67%.


Document format: .docx. Do not render in chat. File to BOT.Jiang subfolder.


[VELORIN.EOF]