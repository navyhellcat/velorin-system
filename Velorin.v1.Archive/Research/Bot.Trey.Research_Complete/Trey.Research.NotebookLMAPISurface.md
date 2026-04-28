# Trey.Research.NotebookLMAPISurface.md

---

## ⚠️ CT SCOPE-CORRECTION BANNER (applied at port — 2026-04-26)

**This research is USEFUL BUT MISGUIDED. Read this banner before reading the research below.**

Trey produced this NotebookLM API audit under the framing that NotebookLM was a candidate Velorin memory layer / context-of-record for multi-vendor Cowork. **That framing was a misread of CT's intent.** CT's actual use case for NotebookLM is materially smaller and operates outside the Velorin agent system:

- NotebookLM is a **secondary memory state for individual projects** that CT works on
- Its role: **feed Google Deep Think the entire context of a single project** so Deep Think can reason over the project comprehensively and provide outside-perspective audit / feedback
- Comparison to **Obsidian**: a human-facing tool CT uses, NOT integrated into Velorin's automated agent workflow
- NotebookLM is NOT a Velorin component, NOT a memory substrate, NOT part of the multi-vendor Cowork architecture

**Why the research is still useful:** Trey's analysis (sections 5-7 specifically) provides decisive evidence that NotebookLM cannot serve as a programmatic memory primitive — the API surface is enterprise-locked, the unofficial wrappers are structurally brittle (reverse-engineered RPCs, cookie scraping), the MCP servers consume up to 150K tokens just registering tools, and the underlying RAG abstraction mathematically conflicts with Erdős's Personalized PageRank / density / topological routing proofs for the Velorin Brain. **Even though the original framing was wrong, the research independently validates the architectural decision NOT to integrate NotebookLM into Velorin.** This research stays as a reference for why that decision was correct.

**Why the research is misguided:** The Executive Summary, sections 1-4, and the Recommendation in section 8 all frame NotebookLM as a candidate that was evaluated and rejected for Velorin integration. The actual situation is that NotebookLM was never a candidate in the first place — CT never intended it as a Velorin component. The "rejection" framing makes the research read as a major architectural decision; in reality, it's verification that an assumption Trey made (and Jiang2's earlier WholeSystemReimagining synthesis amplified) was incorrect.

**The real use case (for future readers):** CT will use NotebookLM via the human web UI for individual project workflows, feeding the project corpus to Deep Think for outside-perspective reasoning. He does not have enterprise access; he does not need programmatic API. Velorin agents do not interact with NotebookLM. The "context-of-record" role in v2 is filled by the native Qdrant + Markdown architecture (which Trey's Section 7.4 correctly identifies as the right answer for Velorin's actual constraints).

Read the research below with this framing. Use sections 5-7 as confirmatory evidence; ignore the "should Velorin adopt" framing in the Executive Summary and Section 8.

---

## Original Trey Research Output (April 2026)

Exhaustive Technical Audit: Google NotebookLM Programmatic Surface and Velorin v2 Architecture Integration

## Executive Summary

As of April 2026, Google provides an official NotebookLM API strictly within its Enterprise tier, operating through the Google Cloud Discovery Engine. While this API supports automated document ingestion, notebook creation, and audio overview generation, it critically lacks official endpoints for exporting chat history, extracting structured notes, or querying cross-notebook synthesis programmatically. To bypass these restrictions, the developer community relies entirely on reverse-engineered Python wrappers that intercept obfuscated internal Google RPCs using extracted browser cookies. Consequently, the current proliferation of NotebookLM MCP servers—which the Velorin v2 architecture assumes will enable multi-vendor Cowork interaction—are built on this fragile foundation. For Velorin, treating NotebookLM as the context-of-record is architecturally fatal; it introduces a black-box retrieval mechanism that permanently voids Erdős's mathematical proofs for the Velorin Brain, necessitating a pivot toward Vertex AI Agent Search or a persistence of the native local Markdown and Qdrant architecture.

## 1. The Official Google NotebookLM API Surface

The assumption that NotebookLM offers a widely accessible, developer-friendly REST API similar to Anthropic's Messages API or OpenAI's platform is factually incorrect. Google has bifurcated the product into a consumer application and a highly regulated enterprise service.

### 1.1 API Availability and Endpoint Architecture

There is a programmatic NotebookLM API, but it is entirely inaccessible to consumer Google accounts or standard Google Workspace users. The official programmatic surface is exclusively branded as NotebookLM Enterprise, defined as a Generative AI Service operating securely within the Google Cloud Platform (GCP) ecosystem.

The API is exposed via the Google Cloud Discovery Engine, utilizing the v1alpha API surface. The base URL for all notebook operations is structurally bound to GCP project identifiers and geographic locations: `https://{ENDPOINT_LOCATION}-discoveryengine.googleapis.com/v1alpha/projects/{PROJECT_NUMBER}/locations/{LOCATION}/notebooks`.

Endpoints are strictly segregated by multi-region designations (e.g., us, eu, global), and the API handles NotebookLM purely as an extension of enterprise data storage. It is fortified with enterprise-grade compliance, including Virtual Private Cloud Service Controls (VPC-SC) and Customer-Managed Encryption Keys (CMEK), ensuring that data cannot be shared externally without explicit organizational authorization. This structural design indicates that Google envisions the API as an internal knowledge management utility for large corporations, not as a flexible backend for independent, multi-agent personal operating systems.

### 1.2 Authentication and Identity Models

Consumer API keys, such as those used by OpenAI or Anthropic, do not exist for NotebookLM. Authentication relies strictly on Google Cloud Identity and Access Management (IAM) and OAuth 2.0 access tokens. System-to-system automation requires the provisioning of GCP Service Accounts, while user-level interactions mandate Cloud Identity, Google Workspace, or Workforce Identity Federation (Bring Your Own ID via Microsoft Entra ID, Okta, etc.).

Accessing the API requires either the broad `https://www.googleapis.com/auth/cloud-platform` OAuth scope or highly specific Discovery Engine scopes, such as `https://www.googleapis.com/auth/discoveryengine.readwrite`. This authentication model strictly prohibits lightweight, local-only agent scripts from accessing the API without routing every request through a fully provisioned, centrally governed Google Cloud Project.

The architectural implication for Velorin is severe. The integration would necessitate establishing a permanent GCP footprint, managing service account key rotation, and incurring cloud billing overhead, merely to replicate the storage primitives currently handled gracefully by the local filesystem and GitHub.

## 2. Supported Operations and Critical Architectural Gaps

If Velorin elects to operate within the GCP Enterprise environment, the following operations are officially supported via the v1alpha REST and RPC surfaces. However, the omissions within this API dictate its ultimate utility.

### 2.1 Corpus Management: Creation, Deletion, and Sharing

The API provides standardized Create, Read, Update, and Delete (CRUD) operations for the notebook container itself. The endpoints `CreateNotebook`, `GetNotebook`, `ListRecentlyViewedNotebooks`, and `DeleteNotebook` allow an orchestrator agent to spin up isolated project spaces on demand. Furthermore, `ShareNotebook` manages IAM bindings at the notebook level, defining Owner, Editor, and Viewer permissions. Crucially, to enforce enterprise security, notebooks cannot be shared publicly via the API; they remain mathematically locked within the enterprise VPC boundary.

### 2.2 Document and Source Ingestion

The API exhibits high competence at programmatic document ingestion, exposed via the `notebooks.sources` methods. The `BatchCreateSources` endpoint permits the simultaneous upload of multiple files. The `UploadFile` method supports raw binary uploads, requiring explicit header declarations for `X-Goog-Upload-File-Name` and `Content-Type`.

Supported MIME types explicitly include PDF files (application/pdf), raw text, Markdown, and Google Workspace-specific formats such as Google Docs, Slides, and Sheets. Notably, files already residing in Google Drive can be attached directly to a notebook by passing the DOCUMENT_ID_GOOGLE string, circumventing the need to stream binary data over the network.

### 2.3 Programmatic Audio Overview Generation

Google exposes the programmatic generation of NotebookLM's flagship feature, Audio Overviews, via the `CreateAudioOverview` RPC method. Developers can programmatically dictate the `episode_focus` to instruct the AI hosts on thematic emphasis, select specific `source_ids` to ground the discussion, and define the `language_code` from over 80 supported BCP 47 languages. Because audio generation is computationally intensive, the API returns a long-running operation object that eventually yields a URI to a downloadable .wav or .mp4 file.

### 2.4 Programmatic Querying and Citations

NotebookLM does not possess a dedicated, intuitive `/chat` endpoint within the notebooks API hierarchy. Instead, NotebookLM operates as a highly specialized data store configuration within the broader Google Discovery Engine.

To programmatically query a notebook's corpus, an agent must formulate a request to the Conversational Search API: `POST /v1beta/projects/*/locations/*/collections/*/dataStores/*/sessions/*/answers:answer` or utilize the gRPC equivalent, `ConversationalSearchService.AnswerQuery`.

The response schema natively returns structured citations. The `AnswerQueryResponse` includes an `ExtractiveSegment` object alongside a citations array. This array provides the `start_index` and `end_index`—measured precisely in UTF-8 Unicode bytes—mapping the AI's synthesized claim directly to the underlying source document text. The latency profile is problematic: enterprise queries typically execute in low single-digit seconds for text, but implementing the StreamAnswerQuery endpoint is mandatory to minimize Time-To-First-Token (TTFT) for synchronous agents.

### 2.5 The Fatal Gap: Export and History Extraction

The definitive failure of the official API for Velorin's v2 architecture lies in its omissions. **There is no official API endpoint to export chat history, retrieve generated notes, or extract structured data artifacts (such as mind maps or reports) from a notebook.**

Google provides a bulk "Data Export" tool through the Google Workspace Admin console designed for legal compliance and eDiscovery. However, this is an asynchronous, manual administrative process requiring human intervention, not a synchronous API endpoint accessible to an autonomous agent. The data is effectively trapped within the graphical user interface.

## 3. The Shadow Ecosystem: Programmatic-ish Interfaces

### 3.1 Unofficial Python Wrappers (notebooklm-py)

The most prominent workaround is `teng-lin/notebooklm-py`, an unofficial open-source Python library that reverse-engineers NotebookLM's internal, undocumented RPCs.

This library executes lightweight, asynchronous HTTP calls via the `httpx` library, formatting payloads to match Google's internal `batchexecute` endpoints. To bypass authentication, it requires a one-time browser instantiation (typically via Playwright) to extract Google session cookies. These cookies are stored locally in `~/.notebooklm/storage_state.json` and injected into all subsequent HTTP requests.

The capabilities of this wrapper far exceed the official Enterprise API: it can bulk-export complete chat histories as JSON or Markdown, download generated Mind Maps as structured JSON, extract the raw OCR-processed text from uploaded PDFs and YouTube videos, and command video generation.

**Velorin Architectural Risk Assessment:** Relying on `notebooklm-py` is structurally hazardous. Google's internal RPC method IDs are obfuscated and change arbitrarily without versioning or notice. The repository maintainer relies on daily automated end-to-end testing against the live Google service to catch breakages. Building a permanent Velorin context-of-record on undocumented endpoints that require persistent cookie scraping is an engineering anti-pattern.

### 3.2 Browser Automation via Playwright and Puppeteer

Repositories such as `DataNath/notebooklm_source_automation` and `osen77/NotebookLM-API` utilize Playwright to instantiate a Chromium instance, physically render the NotebookLM DOM, simulate mouse clicks, and scrape the resulting text. The brittleness of this approach is extreme — any minor CSS class alteration, A/B test, or DOM restructuring deployed by Google instantly breaks the script.

### 3.3 Third-Party Scraper APIs

Commercial scraping services (e.g., `clearpath/notebooklm-api` on Apify) wrap browser automation into a paid HTTP endpoint. They require the user to transmit Google account email and a generated Google App Password. This approach introduces severe security vulnerabilities by handing credentials for primary Google accounts to third-party scraping infrastructure — entirely disqualifying it for proprietary data workflows.

## 4. Multi-Vendor Compatibility and the MCP Landscape

### 4.1 The Explosion of NotebookLM MCP Servers

Because Google has not published an official MCP server for NotebookLM, the community has rapidly filled the void by wrapping the unofficial `notebooklm-py` library into diverse MCP implementations:
- `jacob-bd/notebooklm-mcp-cli` and `set2374/notebooklm-mcp` — up to 31 distinct MCP tools
- `PleasePrompto/notebooklm-mcp` — focused on zero-hallucination citation-backed querying
- `roomi-fields/notebooklm-mcp` — concurrent HTTP REST and MCP execution
- `Pantheon-Security/notebooklm-mcp-secure` — security-hardened fork

### 4.2 Capabilities Exposed to the Agent

These MCP servers provide extensive capabilities: `cross_notebook_query`, `source_add`, `source_sync_drive`, `studio_create` for Audio Overview generation, etc. The integration pattern has gained traction with Google Antigravity (Gemini 3.1 Pro coding agents querying technical documentation in NotebookLM).

### 4.3 The Context Window Exhaustion Failure Mode

**Critical architectural failure mode: MCP Tool Bloat.** Leading MCP servers register up to 31 distinct tools with the client LLM. The MCP specification requires the server to transmit the complete JSON Schema definition for every single tool — including all parameters, type definitions, and semantic descriptions — into the LLM's system prompt on every conversational turn.

In complex setups, tool schemas can consume up to **150,000 tokens of the context window**. For Velorin, where Claude must retain intricate system states, multi-agent instructions, and the complex rules of the Velorin Brain, sacrificing tens of thousands of tokens merely to define NotebookLM tools severely degrades available reasoning capacity. This overhead violates the token-economy principles essential for sustained autonomous agent operations.

## 5. Practical Limits, Constraints, and Economics

### 5.1 Corpus and Size Limits

A single source cannot exceed 500,000 words or 200 MB. Capacity scaling by tier:

| Tier | Max Notebooks | Max Sources per Notebook | Monthly Cost |
|---|---|---|---|
| Free Tier | 100 | 50 | $0 |
| NotebookLM Plus / Pro | 500 | 300 | ~$19.99/user |
| NotebookLM Enterprise (Highest Level) | 500 | 600 | ~$9 - $40+/user |

### 5.2 Rate Limits and Query Caps

- **Queries (Chat/RAG):** Free tier ~50 queries/day. Enterprise standard 500 queries/user/day. Highest enterprise tier 5,000 queries/day.
- **Audio Overviews:** Free tier 3/day. Enterprise standard 20/user/day. Highest enterprise 200/day.

### 5.3 Latency Profiles

- **Ingestion:** Highly variable, dependent on Gemini embedding and chunking queues
- **Querying:** P95 latency in low single-digit seconds for targeted queries against fully indexed notebooks
- **Generation:** Audio and Video overviews require minutes to complete asynchronously; agents must poll for status

## 6. Velorin Consensus Filter and the Catastrophic Mathematical Conflict

### 6.1 Industry Consensus vs. Velorin Constraints

The broader AI industry consensus utilizes NotebookLM primarily as an isolated, human-in-the-loop research synthesis tool. When developers design an "Agent Context-of-Record," the consensus heavily favors dedicated, headless vector databases (Pinecone, Qdrant) or fully managed RAG-as-a-service APIs (Vertex AI Search, AWS Bedrock).

This consensus exists because autonomous agents demand predictable, highly structured API contracts (JSON input/output), millisecond latency for embedding generation, the ability to rapidly delete or update specific document chunks without re-indexing entire PDFs, and granular observability into the retrieval logic. NotebookLM is explicitly engineered to hide this complexity behind a consumer-friendly interface, making its design fundamentally antagonistic to headless, high-speed agent operations.

Velorin shares these exact industry constraints but extends them significantly. Velorin requires deterministic routing, strict metadata tracking (including temporal validity and the emotional charge metric), and the capacity to selectively demote specific semantic pointers. NotebookLM operates as a "black box" RAG system — it completely abstracts away the chunking, embedding, and retrieval algorithms.

### 6.2 The Conflict with Erdős's Mathematical Architecture (CRITICAL)

The adoption of NotebookLM as the context-of-record directly contradicts and voids the fundamental mathematical architecture proven by Erdős:

1. **The Second Law of Epistemodynamics:** Erdős mathematically established that Velorin's memory operates on a thermodynamically irreversible distillation cycle (Layer 3 → Layer 1 PPR geodesics → Layer 0 LoRa weights). If NotebookLM replaces Layers 1 and 2, Velorin loses the explicit, human-curated topological pointer graph. Without explicit topological pointers, the transition matrix ceases to exist, meaning the core retrieval algorithm — Personalized PageRank — can no longer be computed.

2. **Density Constraint (ρ* = 0.78):** Erdős proved that the semantic graph must maintain a strict maximum edge density of 0.78 to prevent retrieval collapse during PageRank walks. NotebookLM's internal Gemini retrieval mechanism does not expose its knowledge graph or edge weights. It is computationally impossible to enforce, measure, or validate the density floor inside the NotebookLM environment.

3. **The Monster Node Resolution:** Erdős resolved central node collapse by applying Fisher Information penalties to specific transition matrices. NotebookLM does not allow developers to penalize or manipulate the attention mechanism applied to specific documents during retrieval — the Monster Node fix cannot be deployed.

**Architectural Verdict:** Velorin cannot implement NotebookLM as its primary memory substrate without entirely discarding the mathematical foundation of the Velorin Brain.

## 7. Realistic Alternative Architectures

### 7.1 Vertex AI Agent Search / RAG Engine

The enterprise infrastructure that actually powers NotebookLM under the hood. Vertex AI RAG Engine is a fully managed cloud service that unbundles the RAG pipeline. Provides explicit API control over document ingestion, chunking, embedding model selection, and retrieval methods. Integrates natively with Google's Agent Builder. Better engineering control than NotebookLM but still fails Velorin's mathematical constraints.

### 7.2 OpenAI Responses API (formerly Assistants API)

Assistants API is officially deprecated, scheduled for shutdown August 26, 2026. OpenAI is migrating developers to the Responses API and Microsoft Foundry Agents service. Introduces vendor lock-in to OpenAI's ecosystem and abstracts retrieval logic away from Velorin's proprietary routing.

### 7.3 Anthropic Claude Files API

Native file handling integrated directly into the Claude ecosystem. Most seamless option for Claude-centric operations. Functions as a context-injection mechanism rather than a structured knowledge graph — no topological routing capabilities.

### 7.4 The Velorin Native Architecture: Local Qdrant + Markdown

The existing Velorin blueprint designates Layer 1 as a routing layer utilizing a Qdrant vector store as an MCP-addressable index over local Markdown files. A custom MCP server querying a local Qdrant instance provides millisecond latency, zero ongoing API costs, infinite rate limits, and complete schema control. External agents (Claude, Codex, Gemini) can communicate flawlessly via the custom Qdrant MCP server, preserving multi-vendor capabilities without token bloat.

**This is the only architecture that satisfies Velorin's First Principles.** It preserves the explicit directional pointers (1-10 ratings) necessary to execute Erdős's Personalized PageRank retrieval, enforce the density constraint, and enable the future Layer 0 LoRa compression mechanisms.

## 8. Confidence-Weighted Conclusions & Strategic Recommendations

(Note from CT scope-correction banner: Sections 8's "should Velorin adopt" framing is moot — NotebookLM was never a candidate. Treat the recommendations below as confirmation of the architectural decision against NotebookLM-as-Velorin-component.)

1. **NotebookLM API as Context-of-Record:** The official NotebookLM API is strictly an enterprise data-ingestion pipeline, not a flexible agent memory substrate. It fundamentally lacks the export and query-extraction features required for multi-agent reasoning, forcing reliance on highly brittle, reverse-engineered RPC wrappers that violate Velorin's architectural stability requirements.

2. **The MCP Ecosystem Presents Severe Stability Risks:** The current proliferation of unofficial NotebookLM MCP servers injects massive token overhead into the LLM context window by transmitting extensive JSON schemas on every turn. Relying on unstable browser cookie extraction for authentication renders them entirely unfit for persistent, zero-touch orchestration.

3. **Mathematical Incompatibility with Velorin Brain:** Offloading the context-of-record to NotebookLM destroys Velorin's proprietary routing logic. It regresses the Velorin Brain into a standard wrapper application, voiding the proven crystal routing, the Personalized PageRank density constraints, and the future Layer 0 LoRa compression mechanisms derived by Erdős.

**Original Recommendation (from Trey, framed against the misread use case):**
"Do not implement NotebookLM as the Part 1 architecture for v2 multi-vendor cowork."

**CT scope-corrected reframing:** Velorin was never going to integrate NotebookLM as a memory layer — that was never CT's intent. Trey's research independently confirms that integration would have been architecturally destructive. The native Qdrant + Markdown architecture (Section 7.4) is the correct path for Velorin's context-of-record. NotebookLM remains a human-facing tool for individual project workflows feeding Deep Think; it does not enter the Velorin agent ecosystem.

## Sources

(Original Trey research cited 62 sources — Google Cloud documentation, GitHub repositories, Reddit threads, blog posts, and official Anthropic / OpenAI / Google product documentation. Full citation list preserved in research notes; not duplicated here for brevity.)

[VELORIN.EOF]
