CAMFIL BIRMINGHAM — AI SALES OPERATIONS PLATFORM
Project Architecture & Build Outline
Version 0.1 — Draft for Refinement | March 2026
1. PROJECT VISION
Build a personal AI-powered sales and operations platform for the Camfil Birmingham territory. The system operates as a suite of coordinated agents accessible in the field, enabling real-time data access, pricing, quoting, customer intelligence, and follow-up management — without dependence on corporate systems or office personnel.
End state: A fully automated, field-deployable toolset that eliminates manual friction across every stage of the sales cycle. Long-term target: productize and license to other reps or distributors.
2. PROBLEM STATEMENT
The following pain points currently exist in daily field sales operations:
* Pricing Access
   * List prices for standard and special filters are not accessible in the field. Every non-standard item requires a call to the office, a lookup, and a callback. This introduces delays and creates dependency on an always-behind operations team.
* Special Filter Configuration
   * Non-standard or custom filters require office involvement to size, configure, assign a part number, and return a price. No tool exists for the rep to estimate or prepare this independently.
* Customer History
   * No fast, accessible way to answer: What did I sell this customer before? What size, what family, what price? This forces reliance on memory or manual file searches.
* Follow-Up Management
   * No system tracks which customers have gone cold, which emails have not been responded to, or which follow-ups were promised and not executed.
* Pre-Call Intelligence
   * No way to quickly prepare for a sales call with relevant context: last order, last contact, products used, open needs.
* Quoting
   * Quote generation is slow and manual. No voice-to-quote or rapid-entry option exists for field use.
* Product Knowledge at Point of Need
   * Rep must know from memory: what does this filter family do, where is it used, what MERV is appropriate, what's an example install? No quick reference exists in the field.
* Meeting and Call Review
   * No recording or transcription system tied to CRM or action items. Missed follow-throughs go untracked.
* Operations Visibility
   * Stock levels, order status, and fulfillment are opaque. Rep finds out about problems only when the customer does.
3. SYSTEM ARCHITECTURE OVERVIEW
The platform is organized into five functional layers. Each layer contains one or more agents or tools. All layers feed into a central interface accessible by the rep in the field.
Layer 1 — Data Foundation
The structured data backbone everything else depends on.
* Master Product Database — List Price Full (current Excel), migrated to queryable format. All 1,833+ Camfil SKUs with family, model, type, MERV, size, pockets, special build, and list price.
* Customer Sales History — CT 2024 and CT 2025 transaction data. Linked to customer, product, price, and date.
* 2026 YTD Data — Blended and current. Continuously updated as new exports are available.
* Pricing Reference — List price plus actual selling price history by customer. Basis for margin and discount visibility.
Layer 2 — Intelligence Agents
AI agents that interpret queries and return actionable answers.
* Pricing Agent — Answers 'what does this filter cost?' for any SKU in the master database. Handles standard and special filter size estimation logic.
* Product Knowledge Agent — Answers 'what is this filter, where does it go, what MERV do I need?' with examples from actual sales history.
* Customer Intelligence Agent — Answers 'what has this customer bought, at what price, when was last contact, what do they likely need?'
* Special Filter Configuration Agent — Walks rep through sizing and spec of non-standard filters, produces an estimated price and spec sheet pending office confirmation.
Layer 3 — Workflow Agents
Agents that manage ongoing sales cycle tasks.
* Follow-Up Agent — Monitors email and communication history. Flags customers who have gone cold, promises that were not fulfilled, and threads that need re-engagement.
* Quote Agent — Generates formatted quotes from voice input or typed product/customer data. Outputs to a shareable or printable format.
* Pre-Call Brief Agent — On demand before a sales call, assembles a one-page brief: customer history, last products, last price, open items, suggested talking points.
* Meeting/Call Review Agent — Transcribes and summarizes recorded calls. Extracts action items and routes them to follow-up queue.
Layer 4 — Operations Visibility
Passive monitoring and alerting on operational status.
* Inventory / Stock Monitor — Tracks known stock levels against open opportunities. Flags shortfalls before they become customer problems.
* Order Status Tracker — Where is this order? What is the ETA? Surfaces answers without requiring a call to the warehouse.
Layer 5 — Interface & Access
How the rep interacts with the system in the field.
* Desktop Interface — Always-open dashboard on a personal laptop. Not behind the corporate firewall. Displays live agent outputs, quote drafts, follow-up queue, and daily brief.
* Voice Interface — Rep speaks a query or dictates a quote. Agent responds in real time. Enables hands-free use during drive time or on-site.
* Mobile Access — Lightweight mobile view of pricing lookup, customer history, and follow-up queue.
4. BUILD PHASES
Phases are sequential. Each phase must be functional before the next begins.
* Phase 1 — Data Foundation (Current)
   * Migrate and clean master product database. Resolve 2026 data blending. Establish queryable pricing and customer history. This is the bedrock all agents depend on. Nothing else works without it.
* Phase 2 — Pricing & Product Agent
   * First working agent. Answers pricing and product questions from the master database. Deployable as a simple query interface. Immediate daily utility.
* Phase 3 — Customer Intelligence Agent
   * Builds on sales history data. Answers customer-specific questions. Enables pre-call prep and history lookup.
* Phase 4 — Quote Agent
   * Generates quotes from structured data. Integrates pricing agent. Voice input optional at this stage.
* Phase 5 — Follow-Up & Communication Agent
   * Email scraping and follow-up tracking. Requires integration with email platform.
* Phase 6 — Meeting & Call Review Agent
   * Recording, transcription, and action item extraction. Requires integration with phone or recording tool.
* Phase 7 — Operations Visibility
   * Stock and order monitoring. Requires access to internal data feeds or manual export workflow.
* Phase 8 — Full Integration & Interface
   * All agents connected. Desktop and mobile interface live. Voice input enabled. System operates as a unified platform.
* Phase 9 — Productization
   * Document the system. Identify replication requirements for other territories or reps. Define licensing or SaaS model. Begin external pitch preparation.
5. CONSTRAINTS & DEPENDENCIES
* Corporate systems are closed — no API access to Camfil's internal pricing, inventory, or CRM. All data must come from exports, scrapes of accessible sources, or manual inputs.
* Part number corruption risk — all part numbers must remain stored as text. This is a recurring failure mode in the data layer.
* Non-Camfil products exist in sales data — product classification must be verified individually, not assumed by family name.
* Field access limitations — the interface must operate entirely outside the corporate network on personal hardware.
* Solo build — all development and architecture is managed by CT with AI assistance. No dev team. Complexity must be staged accordingly.
6. OPEN QUESTIONS — TO BE RESOLVED
These items require decisions before the affected phase can begin.
* Internal vs. external product path — build for personal use only, internal pitch to Camfil, or external SaaS/license model? Determines architecture decisions around multi-tenancy, branding, and security.
* Email platform — what email system is in use? (Outlook, Gmail, other?) Determines integration path for the follow-up agent.
* Call recording — what is the preferred method for capturing sales calls? (Mobile app, dedicated recorder, softphone?) Determines transcription integration.
* Data refresh cadence — how often will sales export data be pulled and updated in the system? Manual or automated?
* Quote delivery format — how are quotes currently delivered to customers? Email, PDF, verbal? Determines output requirements for the quote agent.


[VELORIN.EOF]
— Draft. For refinement and game theory with CT. Version 0.1 —
