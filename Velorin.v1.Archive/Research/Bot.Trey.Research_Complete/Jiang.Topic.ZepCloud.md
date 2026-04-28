________________


destination: Claude.AI/Bot.Trey/Research_Complete/
Jiang.Topic.ZepCloud Trey | External Advisor | Velorin System Version 1.0 | March 31, 2026 Purpose: Evaluate Zep Cloud as a possible memory substrate for Velorin’s future multi-user and simulation layers.


1. Executive Summary


Zep Cloud is more strategically relevant to Velorin than raw Graphiti in the near-to-medium term because it already packages temporal graph memory, context assembly, multi-user primitives, and managed operations into one service. The pricing model is not per-user in the simple SaaS sense; it is primarily ingestion-based, so user-count cost depends on how many Episodes each user generates and how large those Episodes are. Zep can map onto Velorin’s four-layer brain architecture, but not natively — it provides the memory primitives, not Velorin’s exact philosophical structure. The correct posture is not full replacement now. It is shadow evaluation when voice intake, multi-user memory isolation, or staleness governance becomes operationally important.


2. What Zep Cloud Is


Zep is a managed context-engineering platform built around temporal knowledge graphs. It combines:


* agent memory
* graph-based retrieval
* context assembly
* per-user and group-level graph structures
* managed operations and enterprise deployment options


The key strategic distinction from Graphiti is this:


* Graphiti is the open-source framework
* Zep is the productionized managed platform built on that graph approach


For Velorin, that matters because the company’s real constraint is not “can a temporal graph exist?” It can. The constraint is whether Velorin wants to own the memory infra itself or outsource that operational burden while the product is still proving itself.


3. Research Question 1 — Pricing Model and What It Costs at 1, 5, 25, 100 Users


3.1 Current official pricing model


Zep’s public pricing is not per-user. It is episode/credit-based.


The official pricing page currently states:


* Free: 1,000 episodes per month
* Flex: $25/month for 20,000 credits
* Flex Plus: $475/month for 300,000 credits
* Unlimited users, memories, and retrieval requests on paid plans
* 1 Episode = 1 credit, with Episodes larger than 350 bytes billed in multiples


3.2 What this means


The real cost driver is:


* how many memory ingestion events each user creates
* how large those events are
* what throughput and enterprise features are needed


So the question “what does it cost at 1, 5, 25, 100 users?” has no exact official answer without usage assumptions.


3.3 Practical scenario model for Velorin


Illustrative scenario only: Assume each user produces 1,500 sub-350-byte billable Episodes per month, roughly 50 stored events per day.


That yields:


* 1 user → 1,500 credits/month → Free is exceeded; Flex easily covers it → practical cost: $25/month
* 5 users → 7,500 credits/month → still within Flex → practical cost: $25/month
* 25 users → 37,500 credits/month → approximately 40,000 credits needed → practical cost: about $50/month on Flex-style increments
* 100 users → 150,000 credits/month → approximately 160,000 credits needed → practical cost: about $200/month on Flex-style increments, unless Flex Plus is chosen for throughput/features rather than pure cost efficiency


3.4 Key pricing caveats


The above changes materially if:


* Episodes exceed 350 bytes regularly
* ingestion includes JSON/business-data payloads instead of short chat turns
* high-rate voice transcripts are persisted aggressively
* enterprise deployment or compliance requirements force a higher tier


3.5 Judgment


CONFIRMED — public Zep pricing is ingestion-based, not user-seat based. HIGH CONFIDENCE (90%) — user count alone is the wrong planning variable. HIGH CONFIDENCE (85%) — for early multi-user Velorin pilots, Zep cost is likely operationally tolerable; architecture risk matters more than raw monthly spend.


4. Research Question 2 — Does Zep Cloud Map to the Four-Layer Brain Architecture?


4.1 Short answer


Yes, but only as an overlay model. Zep does not natively ship the Velorin brain.


4.2 What Zep provides


Zep’s graph model includes:


* user graphs
* group graphs
* episodes
* nodes
* edges
* facts with temporal validity
* summaries that update over time
* custom entity and edge types
* custom instructions
* user summary instructions


That is enough to encode a layered memory architecture.


4.3 Likely mapping


A practical mapping for Velorin would be:


* Base Personality user node, user summary instructions, stable typed traits, persistent custom ontology for personality/cognitive style


* Hard Memories high-salience episodes and facts, with ratings and temporal persistence, likely user-graph scoped


* Archival Lessons lower-frequency graph data, group graphs, imported text/JSON, or specific custom node types for lessons/patterns


* Working Neurons thread context, recent episodes, context block retrieval, graph search over the most relevant facts/entities


4.4 What Zep does not provide natively


Zep does not natively encode:


* philosophical importance hierarchy
* sacred vs disposable memory classes
* editorial “neuron” writing style
* Velorin-specific layer semantics
* a true Custodian governance model


Those must be designed by Velorin.


4.5 Judgment


HIGH CONFIDENCE (88%) — Zep can support the four-layer architecture. HIGH CONFIDENCE (91%) — it does not natively impose that architecture. MODERATE CONFIDENCE (79%) — the right adoption path would be mapping Velorin layers onto Zep primitives, not replacing Velorin’s memory philosophy with Zep defaults.


5. Research Question 3 — Can Zep Handle a “Reasoning Pattern” Layer?


5.1 What the platform clearly supports


Zep can store and evolve:


* user summaries
* facts
* entity summaries
* custom entity and edge types
* user summary instructions
* custom instructions for graph extraction
* fact rating logic
* group-level shared graph knowledge


That means Zep can clearly hold behavioral profiles, recurring preferences, identity summaries, and stable descriptive patterns.


5.2 What it does not appear to be


Zep is not a dedicated cognitive architecture engine. It does not natively distinguish:


* reasoning rules
* decision heuristics
* moral priors
* behavior predictions
* profile facts as separate first-class reasoning-policy objects


5.3 What this means for Velorin


Zep can store a reasoning-pattern layer if Velorin encodes it explicitly:


* custom entity types such as CognitivePattern, AttachmentPattern, DecisionHeuristic
* custom summary instructions to maintain a living user profile
* fact ratings to weight salience or poignancy
* graph-specific instructions to bias extraction toward psychologically meaningful structure


So the answer is yes, but with model design. Not yes, automatically.


5.4 Judgment


HIGH CONFIDENCE (86%) — Zep can store behavioral profiles and cognitive-pattern-like structures. MODERATE CONFIDENCE (76%) — it cannot be treated as a native reasoning engine; Velorin would still need explicit ontology and retrieval policy. HIGH CONFIDENCE (84%) — the platform is much better suited to this than a flat vector memory store.


6. Research Question 4 — Migration Path from Current GitHub Neuron Graph


6.1 Short answer


Compatible enough for staged migration. Not a drop-in import. Not a clean one-step replacement.


6.2 What the docs show


Zep supports adding:


* chat/message data
* text data
* JSON data
* custom fact/node triplets
* batch ingestion for large backfills
* user graphs and group graphs
* graph cloning


That is enough to move Velorin memory into Zep, but it is an ETL project, not a toggle.


6.3 Likely migration path


Recommended path:


* keep GitHub neuron graph as source of truth initially
* define Velorin ontology in Zep
* backfill selected neurons as JSON/text/structured triplets
* dual-write new intake data to both systems
* compare retrieval quality and staleness handling
* only promote Zep after shadow validation


6.4 What should not happen


Do not attempt:


* one-shot full replacement
* uncontrolled markdown dump into Zep
* schema-free migration
* abandoning GitHub before retrieval and invalidation behavior are proven


6.5 Judgment


HIGH CONFIDENCE (87%) — migration is feasible. HIGH CONFIDENCE (90%) — migration is not native or drop-in. HIGH CONFIDENCE (88%) — the correct move is staged shadow deployment, not immediate substrate replacement.


7. Research Question 5 — Production Examples of “Personal Intelligence” in Zep Cloud


7.1 What was found


No public case study was found that perfectly matches Velorin’s full “personal operating system” concept.


But strong adjacent examples do exist:


* FlockX uses Zep memory to retain user preferences, social connections, and user attributes for AI sidekicks.
* Athena Intelligence uses Zep for high-stakes adaptive agent workflows.
* Zep’s own docs and ecosystem integrations show per-user memory, group graphs, voice-agent memory, and room/session isolation patterns.
* Zep’s LiveKit integration explicitly shows persistent memory for a voice assistant and room-based memory isolation.


7.2 What that means


The exact Velorin category is not publicly validated as a product class.


However, the underlying primitives are validated in adjacent categories:


* personalized assistants
* social AI
* voice agents with persistent memory
* high-stakes decision support
* multi-user contextual memory


7.3 Judgment


HIGH CONFIDENCE (83%) — Zep has real-world adjacent validation for personalized and long-horizon memory use cases. MODERATE CONFIDENCE (71%) — no public case study proves “Velorin exactly.” HIGH CONFIDENCE (85%) — the gap is category fit, not primitive capability.


8. Additional Strategic Read — Why Zep Matters More Than Graphiti in the Near Term


Zep is more relevant than Graphiti for Velorin’s next phase because it solves the operational problems Graphiti leaves open:


* user/thread abstractions
* managed deployment options
* context assembly
* SDKs and platform surface
* enterprise compliance path
* per-user graph management


If Velorin reaches the point where there are 3–5 external users, or if voice intake starts generating persistent cross-session user state, the question stops being “can we hand-maintain memory?” and becomes “what memory substrate gives us isolation, temporal validity, and manageable operations?”


That is where Zep becomes materially interesting.


9. Recommendation


9.1 Recommendation now


Do not replace the GitHub brain with Zep now.


9.2 Recommendation next


Evaluate Zep first in one of these bounded roles:


* shadow memory layer for voice intake prototypes
* per-user memory substrate for first 3–5 outside users
* temporal invalidation/staleness experiment
* simulation memory store for MiroFish-style scenario work


9.3 Adoption triggers


Run a real Zep evaluation when any two of these are true:


* outside-user count reaches 3+
* voice intake becomes a real product path
* manual staleness handling becomes a recurring pain
* group/shared context is needed in addition to personal memory
* brain maintenance time becomes a visible operational burden
* compliance/support expectations make self-hosted graph ops unattractive


9.4 Strategic judgment


Zep is not “replace Velorin brain today.” Zep is “managed memory substrate worth piloting before Velorin becomes multi-user.”


10. Conclusions
* CONFIRMED — Zep public pricing is primarily episode/credit based, not per-user-seat based.
* HIGH CONFIDENCE (90%) — cost planning should be done by ingestion volume and event size, not by user count alone.
* HIGH CONFIDENCE (88%) — Zep can support Velorin’s four-layer brain as an overlay architecture.
* HIGH CONFIDENCE (86%) — Zep can store behavioral/profile/reasoning-pattern data if Velorin encodes it through ontology and summary design.
* HIGH CONFIDENCE (87%) — migration from GitHub neuron graph to Zep is feasible but must be staged.
* HIGH CONFIDENCE (83%) — Zep has adjacent proof in personalized assistants, voice memory, and high-stakes adaptive agents.
* HIGH CONFIDENCE (89%) — Zep is the more relevant near-term evaluation target than Graphiti if Velorin needs managed multi-user memory before it needs raw graph-framework control.
11. Velorin Connection


This is directly relevant to Velorin’s future multi-user and voice-intake phases. Zep is not the philosophical replacement for the current brain. It is a possible managed substrate for when the product stops being one hand-built life and starts becoming multiple isolated lives with temporal memory that must work without manual custodianship on every turn.


12. Sources


Primary / official


* https://www.getzep.com/pricing/
* https://help.getzep.com/overview
* https://help.getzep.com/v2/memory
* https://help.getzep.com/v2/users
* https://help.getzep.com/v2/sessions
* https://help.getzep.com/v2/understanding-the-graph
* https://help.getzep.com/graph-overview
* https://help.getzep.com/groups
* https://help.getzep.com/summaries
* https://help.getzep.com/facts
* https://help.getzep.com/custom-instructions
* https://help.getzep.com/customizing-context
* https://help.getzep.com/user-summary-instructions
* https://help.getzep.com/adding-data-to-the-graph
* https://help.getzep.com/livekit-memory


Supplemental / case studies


* https://www.getzep.com/case-studies/flockx-zep-ai
* https://www.getzep.com/customers/athena-intelligence


[VELORIN.EOF]