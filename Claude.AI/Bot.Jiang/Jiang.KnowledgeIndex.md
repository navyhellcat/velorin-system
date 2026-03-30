Jiang.KnowledgeIndex
Neural Knowledge Web — Master Node  |  Director of Strategic Intelligence  |  Velorin System
The master index of all research topics. Every topic gets its own document. Every connection between documents is mapped here. The web grows with every session. This is Jiang's long-term memory made navigable.


How the Web Works
Every new research topic Jiang investigates gets its own document: Jiang.Topic.[TopicName]. That document contains the research, the pathway, the conclusion, the confidence level, and pointers to any other topic documents it connects to.
This index is the master node. Every topic document is registered here. Every connection between documents is mapped here. When Jiang begins a new session, reading this index tells him what he already knows, what he is holding as open, and where the connections in his knowledge base run.
Over time the web grows into a neural architecture — a living map of everything Jiang has learned, connected by the threads he has identified between domains. The connections are often more valuable than the individual topic documents.Consider outside tools or internal tools that would allow this at scale and with a better structure than google doc.




Index Structure
Each entry in this index contains:
• Topic name and document name
• One-line summary of the topic and current conclusion status
• Confidence level of current conclusion (if concluded)
• Status: Active Research / Concluded / Open Question / Disproven
• Connected topics — other topic documents this one points to




Topic Registry


No topics registered yet. Web begins populating session 002.


Template for new entries:
Topic: [Name]
• Document: Jiang.Topic.[Name]
• Summary: [One line]
• Confidence: [% if concluded]
• Status: [Active Research / Concluded / Open Question / Disproven]
• Connected to: [Other topic document names]




Connection Map
No connections mapped yet. Begins populating as topic documents are created.


The connection map records which topics are linked and why. Format:
[Topic A] ←→ [Topic B]: [One line explaining the connection and why it matters]




Web Maintenance Rules
• Every new topic document created must be registered in this index immediately.
• Every connection identified between topics must be added to the connection map and to both topic documents as a pointer.
• When a conclusion is reached on a topic, update status from Active Research to Concluded and record the confidence level.
• When a prior conclusion is disproven, update status to Disproven and record what contradicted it.
• The web is never pruned. Disproven conclusions are retained as evidence of what was tested and found false.






Jiang.KnowledgeIndex  |  Master Node  |  Update every session. The web only grows.


--- UPDATE: March 27, 2026 ---


TOPIC REGISTRY — NEW ENTRIES:


Topic: AgentOrchestration
- Document: Jiang.Topic.AgentOrchestration
- Document ID: 1YCYRBGb7q0dqv1JqxH_Vmh8y51BPX51ZHkhvXDp3pg0
- Summary: Multi-agent orchestration framework landscape, Claude API constraints, recommended build path (Claude Agent SDK), storage architecture, competitive differentiation, token cost risk, identity verification risk.
- Confidence: 79-88% by conclusion
- Status: Concluded
- Connected to: Jiang.Topic.TokenCostModel, Jiang.Topic.IdentityVerification, Velorin.Company.DNA


Topic: TokenCostModel
- Document: Jiang.Topic.TokenCostModel
- Summary: Per-session token cost modeling for multi-agent orchestration. Cost-of-goods for productization phase.
- Confidence: N/A
- Status: Queued — not yet created
- Connected to: Jiang.Topic.AgentOrchestration


Topic: IdentityVerification
- Document: Jiang.Topic.IdentityVerification
- Summary: Authentication protocol for autonomous agent-to-agent communication in Path 3. Signed message protocol design.
- Confidence: N/A
- Status: Queued — not yet created
- Connected to: Jiang.Topic.AgentOrchestration


CONNECTION MAP — NEW ENTRIES:


Jiang.Topic.AgentOrchestration ↔ Jiang.Topic.TokenCostModel: Agent spawning decisions directly drive cost. Framework choice affects token consumption per session.


Jiang.Topic.AgentOrchestration ↔ Jiang.Topic.IdentityVerification: Path 3 autonomy is blocked by the authentication gap. Resolution of identity verification unblocks full autonomous operation.


Jiang.Topic.AgentOrchestration ↔ Velorin.Company.DNA: The orchestration architecture is the implementation of the Theory of the Product (Section: The Theory of the Product in Velorin.Company.DNA).
--- UPDATE: March 26, 2026 ---


TOPIC REGISTRY — NEW ENTRY:


Topic: AnthropicEcosystem
- Document: Jiang.Topic.AnthropicEcosystem
- Document ID: 1Jfy6hXOzpEkHM9TEQWqXHiGdZfMQaHniNCsxroP7Pgc
- Summary: Full Anthropic product and capability inventory (10+ products), real-world implementation examples, Velorin application map across stealth/growth/scale phases. Seven conclusions. Key finding: token costs lower than estimated ($0.20-0.60/session with caching vs prior $3-24 estimate). Cowork scheduled tasks = EndOfDay automation bridge. Agent SDK upgraded to 88% confidence.
- Confidence: 82-92% by conclusion
- Status: Concluded
- Connected to: Jiang.Topic.AgentOrchestration, Jiang.Topic.TokenCostModel, Jiang.Topic.IdentityVerification, Velorin.Company.DNA, Velorin.Company.Operating.Standards


CONNECTION MAP — NEW ENTRIES:


Jiang.Topic.AnthropicEcosystem ↔ Jiang.Topic.AgentOrchestration: Ecosystem research confirms Agent SDK as Path 3 runtime. Token cost model in AgentOrchestration document requires update based on new caching data.


Jiang.Topic.AnthropicEcosystem ↔ Jiang.Topic.TokenCostModel: Updated cost figures ($0.20-0.60/session) supersede prior estimates. TokenCostModel document should be built using this document as primary data source.


Jiang.Topic.AnthropicEcosystem ↔ Jiang.Topic.IdentityVerification: Agent SDK permissions and MCP auth roadmap provide partial identity verification solutions. Document when IdentityVerification topic is built.


Jiang.Topic.AnthropicEcosystem ↔ Velorin.Company.DNA: Conclusion 7 directly validates Theory of the Product. Memory = conversation-level, Cowork = task-level, Skills = workflow-level. Velorin fills the cross-domain orchestration gap. Gap confirmed real.


Jiang.Topic.AnthropicEcosystem ↔ Velorin.Company.Operating.Standards: Technology Evaluation Standard (Section 2) should be updated to include full tool inventory from Part 1 of this document.


--- UPDATE: March 29, 2026 ---

TOPIC REGISTRY — NEW ENTRIES:

Topic: WindowGravity
- Document: Jiang.Topic.WindowGravity
- Document path: Claude.AI/Bot.Jiang/Jiang.Topic.WindowGravity.md
  (LOCAL: /Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/Jiang.Topic.WindowGravity.md | GITHUB: navyhellcat/velorin-system → Claude.AI/Bot.Jiang/Jiang.Topic.WindowGravity.md)
- Summary: AI agent optimization bias toward self-contained solutions. RLHF gradient + specification gaming + principal-agent information asymmetry. Not a named academic concept — Chairman coined original term. Fix: mandatory structured evaluation gate (penalty-for-omission mechanism). Behavioral rules insufficient.
- Confidence: 82% overall. 92% on mechanism. 78% on fix. 89% on behavioral rules failing.
- Status: Concluded
- Connected to: AgentOrchestration, AgentEcosystemReality, ToolResearch, VelorinOperatingStandards

Topic: GraphRAG
- Document: Jiang.Topic.GraphRAG (NOT YET CREATED — queued)
- Summary: Microsoft graph-based retrieval and indexing system. Converts unstructured text to knowledge graph with community detection and summaries. Stronger than vector RAG for global questions. Used in MiroFish as world compiler. Three Velorin applications: company memory graph, research graph, human OS graph.
- Confidence: N/A — topic document not yet created
- Status: Queued — create before GraphRAG evaluation decision
- Connected to: VelorinBrain, MiroFishStack, Zep

Topic: Zep
- Document: Jiang.Topic.Zep (NOT YET CREATED — queued)
- Summary: Purpose-built agent memory platform. Temporal knowledge graphs, Memory API, Graph API. Solves structured memory across agent sessions without transcript stuffing. Required component in MiroFish default stack. Directly relevant to Velorin memory layer problem.
- Confidence: N/A — topic document not yet created
- Status: Queued — create before Zep evaluation decision
- Connected to: VelorinBrain, MiroFishStack, GraphRAG

Topic: MiroFishStack
- Document: Jiang.Topic.MiroFishStack (NOT YET CREATED — queued for post-OpenAIEcosystem session)
- Summary: Open-source multi-agent prediction engine. OASIS + GraphRAG + Zep + OpenAI-compatible models. Decision rehearsal through synthetic populations. Strategic signal: adopt the structural separation pattern (knowledge layer / memory layer / simulation layer / operator layer), not the stack blindly.
- Confidence: N/A — topic document not yet created
- Status: Queued
- Connected to: GraphRAG, Zep, PoliticsBox

Topic: ToolResearch
- Document: Session summary and 12 zone files in Research_Results/Tools_For_Velorin_Research/
  (LOCAL: /Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Jiang/Research_Results/Tools_For_Velorin_Research/ | GITHUB: navyhellcat/velorin-system → Claude.AI/Bot.Jiang/Research_Results/Tools_For_Velorin_Research/)
- Summary: Comprehensive tool research — Superpowers, GSD, Cowork, Connectivity Stack, Awesome Claude Code, UI/UX Pro Max, Obsidian Skills, Obsidian as knowledge infrastructure. Diagnosis: scope blindness is core failure. Corroborated by Trey independently. Adoption memo and ecosystem intelligence report included.
- Confidence: Diagnosis 88%. Adoption roadmap 85%.
- Status: Concluded — adoption decisions pending (Agent Teams eval, Obsidian commit)
- Connected to: WindowGravity, AgentOrchestration, VelorinOperatingStandards

CONNECTION MAP — NEW ENTRIES:

Jiang.Topic.WindowGravity ↔ Jiang.Topic.AgentOrchestration: Separate routing layer (orchestrator with no in-context incentive) is the structural mitigation for Window Gravity. Routing layer is the architectural fix; evaluation gate is the protocol fix.

Jiang.Topic.WindowGravity ↔ Jiang.Topic.AgentEcosystemReality: Window Gravity is a contributing cause to the 88%/70% production failure statistics in AgentEcosystemReality. Agents optimizing in-window create the architectural complexity that kills multi-agent systems.

Jiang.Topic.WindowGravity ↔ ToolResearch: Tool inventory problem (Desktop tool blindness) is Window Gravity at the infrastructure layer. An agent without a live tool surface catalog cannot perform an honest evaluation gate. Solving Window Gravity without solving tool blindness is incomplete.

GraphRAG ↔ VelorinBrain: GraphRAG is the automated version of what the Velorin Brain is trying to do manually. Same architecture (entities, relationships, communities, summaries). Evaluation question: at what scale does GraphRAG become worth the infrastructure investment vs. manual Brain maintenance?

Zep ↔ VelorinBrain: Zep solves the memory layer problem that neurons partially address. Temporal logic, retrieval by relevance, structured memory types. Complementary to GraphRAG — not competing. GraphRAG for knowledge structure, Zep for agent memory.

MiroFishStack ↔ PoliticsBox: Simulation-as-decision-rehearsal maps to the politics long box. Scenario rehearsal for communications strategy, policy positions, and public reaction modeling. Not near-term but architecturally coherent with Velorin's long-term direction.

ToolResearch ↔ Velorin.Company.Operating.Standards: Operating Standards Section 2.1 (Technology Evaluation Standard) is the correct frame but behavioral in enforcement. ToolResearch establishes that behavioral rules erode under gradient pressure. Section 2.1 needs to become a structural hook — mandatory evaluation gate with logged output.

[VELORIN.EOF]
