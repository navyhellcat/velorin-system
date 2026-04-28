Trey.Topic.OpenAIEcosystem
Executive summary
As of March 26, 2026, OpenAI's product suite is best understood as two tightly-coupled pillars: (1) ChatGPT as the consumer + workspace "operating system" (plans, projects, canvas, memory, GPTs, apps/connectors, agent mode, deep research, voice/video/image tools) and (2) the OpenAI developer platform centered on the Responses API with first-party hosted tools (web search, file search via vector stores, computer use, code interpreter, image generation) plus Realtime (voice-first, low-latency) and specialized modality APIs for video (Sora) and images (GPT Image / legacy DALL-E). [1]
OpenAI has clearly been migrating developers from older surfaces to newer ones: Chat Completions remains supported, but official docs frame Responses as "most advanced" and recommend it for new projects; the Assistants API is deprecated with a shutdown date of August 26, 2026 (per docs), pushing builders toward Responses + new agent tooling. [2]
Strategic differentiators visible in public docs and pricing pages include: (a) fully productized "agent mode" in ChatGPT (evolved from Operator + deep research), (b) an enterprise/workspace ecosystem of GPTs + Apps/Connectors + MCP, (c) native multimodality breadth (notably video generation via Sora 2 + API), (d) a dedicated Realtime model line (WebRTC/WebSocket/SIP), and (e) "open-weight" model releases (gpt-oss) under Apache 2.0. [3]
For Velorin (Claude-first), OpenAI is most attractive as a complementary "capability layer" for (1) video (Sora) and high-fidelity images (GPT Image), (2) realtime voice experiences, (3) deep research models specialized for large-scale browsing/synthesis, and (4) optional open-weight deployment paths (gpt-oss) for customers demanding local/controlled inference. Where Claude already offers analogous features (e.g., computer use, web search), OpenAI's advantage is less "unique capability" and more maturity of product packaging and integration (ChatGPT Agent, Apps directory, GPT Store, enterprise admin controls) plus breadth across modalities. [4]
Information needs and confidence rubric
The research required clarity on six things that are both decision-critical and time-sensitive:
OpenAI's current ChatGPT plan lineup and pricing, including Business rename, Pro pricing, and how "credits" work across plans. [5]
OpenAI's current model catalog (flagship GPT-5 family, o-series, deep research models, realtime/audio, image/video, open-weight) and which endpoints each supports. [6]
The authoritative developer API surfaces and migrations (Responses vs Chat Completions; Assistants deprecation; Conversations state). [7]
What "agentic" means operationally in OpenAI terms: ChatGPT Agent, Computer Use, Agents SDK, MCP, and tool stack. [8]
Representative external implementations with documented outcomes (not just "someone built a demo"). [9]
Claude parity points (computer use, web search, pricing) to avoid "false differentials." [10]
Confidence scale used throughout this report
High (>=85%): directly supported by primary OpenAI/Anthropic docs or pricing, or first-party customer story pages.
Medium (70-84%): supported by sources but requires interpretation (e.g., mapping product labels to APIs, or from plan pages to operational availability).
Low (<70%): inference from incomplete evidence, or where the public docs don't clearly specify a detail; these are explicitly flagged.
OpenAI product and capability inventory
Product graph and API surface map
flowchart TB
  subgraph ChatGPT["ChatGPT (consumer + workspace)"]
    Plans["Plans: Free / Plus / Pro / Business / Enterprise / Edu"]
    ToolsUI["Tools: Agent mode, Deep research, Search, Voice, Image gen, Sora, Data analysis"]
    Projects["Projects + project memory"]
    Canvas["Canvas (writing/coding editor)"]
    GPTs["Custom GPTs + GPT Store"]
    Apps["Apps (formerly connectors) + Sync + Custom MCP connectors"]
  end

  subgraph Platform["OpenAI Developer Platform"]
    Models["Models (GPT-5 family, o-series, deep research, realtime/audio, image, video, open-weight)"]
    Responses["Responses API /v1/responses"]
    ChatComp["Chat Completions /v1/chat/completions"]
    Realtime["Realtime API /v1/realtime (WebRTC/WebSocket/SIP)"]
    Conversations["Conversations API /v1/conversations"]
    ImagesAPI["Images API /v1/images/*"]
    AudioAPI["Audio API /v1/audio/*"]
    VideosAPI["Videos API /v1/videos"]
    Embeddings["Embeddings /v1/embeddings"]
    Moderation["Moderations /v1/moderations"]
    FineTune["Fine-tuning /v1/fine_tuning/jobs"]
    Assistants["Assistants API /v1/assistants (deprecated)"]
    ToolsHosted["Hosted tools: web_search, file_search (vector stores), computer_use_preview, code_interpreter, image_generation, remote MCP"]
    AgentsSDK["Agents SDK (Python/TS) + tracing"]
    AgentKit["AgentKit / Evals (platform tooling)"]
  end

  ChatGPT --> Models
  ToolsUI --> Responses
  ToolsUI --> Realtime
  Apps --> ToolsHosted
  GPTs --> Apps
  GPTs --> "GPT Actions (OpenAPI schema --> function calling)"

  Responses --> ToolsHosted
  Realtime --> ToolsHosted
  Responses --> Conversations
  ChatComp --> Models
  Responses --> Models
  ImagesAPI --> Models
  VideosAPI --> Models
  AudioAPI --> Models
  Assistants --> ToolsHosted
  AgentsSDK --> Responses
  AgentsSDK --> Realtime
Source support for the edges above: Responses capabilities and endpoint are defined in the Responses API reference; tools (web/file search, MCP, etc.) are described in the tools guides; Realtime model and transport options are documented in the model page; Apps/Connectors and GPT actions are described in ChatGPT help and platform GPT Actions docs. [11]
Timeline of major launches and changes through March 2026
timeline
  title OpenAI product timeline (selected milestones)
  2023-03-23 : ChatGPT plugins introduced (later deprecated)
  2023-11-06 : GPTs introduced (custom GPTs + forthcoming GPT Store)
  2024-02-15 : Sora technical report ("world simulators") published
  2024-10-03 : Canvas introduced (writing/coding collaboration UI)
  2024-12-05 : ChatGPT Pro announced ($200/mo; early reasoning models + tools)
  2024-12-09 : Sora "research preview --> product rollout" at sora.com (Sora Turbo)
  2025-01-23 : Operator introduced; Computer-Using Agent (CUA) published
  2025-02-02 : Deep research introduced (ChatGPT)
  2025-07-17 : ChatGPT agent announced (Operator + deep research evolution)
  2025-09-30 : Sora 2 released; Sora app launches; API planned/rolling out
  2025-12-17 : "Connectors" renamed to "Apps" in ChatGPT
  2026-02-02 : Codex app introduced (macOS) in ChatGPT release notes
  2026-02-13 : GPT-4o/4.1/o4-mini retired from ChatGPT (API unchanged)
Citations for each milestone are the corresponding OpenAI product posts or help center release notes. [12]
Consumer and workspace products
ChatGPT plans (Free / Plus / Pro / Business / Enterprise)
What it does: Provides the ChatGPT app experience (web + mobile + desktop), with plan-based access to models, voice, file uploads/data analysis, image generation, deep research, agent mode, projects, tasks, and custom GPT usage/creation. [13]
Key limitations: Model availability in ChatGPT changes over time; OpenAI explicitly retired multiple legacy models from ChatGPT on Feb 13, 2026 while keeping API access unchanged (important if you expect "ChatGPT model picker" to mirror API availability). [14]
Pricing / access tier: Free ($0), Plus ($20/mo), Pro ($200/mo), Business (~$25/seat/mo billed annually or $30 billed monthly), Enterprise (sales), with separate "credits" concepts for certain advanced features (Business/Enterprise/Edu flexible pricing; Plus/Pro credits add-ons for Codex & Sora). [15]
API surface: N/A (consumer/workspace app), but Business/Enterprise/Edu features include admin controls and integrations; deep research activity is referenced as being visible via a Conversation/Compliance API in admin contexts. [16]
Confidence: High (90%) for pricing tiers and major inclusions; Medium (75%) for any plan-specific usage limits because they are described as variable and governed by in-product counters/credits. [17]
ChatGPT Business (formerly "Team")
What it does: A self-serve multi-seat workspace with GPTs, projects, shared links, and enterprise privacy posture ("no training by default" for workspace data). [18]
Key limitations: "Unlimited" messaging is still bounded by policy/anti-abuse constraints; certain advanced features use credit pools beyond included limits. [19]
Pricing / access tier: $25/seat/mo annually or $30/seat/mo monthly (minimum 2 users). [20]
Confidence: High (90%). [20]
ChatGPT agent (integrated Agent Mode; evolution of Operator + Deep Research)
What it does: Lets ChatGPT "think and act" by selecting from agentic skills and using its own computer to execute tasks end-to-end. OpenAI positions it as a bridge from research to action and explicitly describes it as a natural evolution of Operator and deep research. [21]
Key limitations: As an agent that uses a computer/browser, it inherits reliability and safety limitations typical of UI automation, and OpenAI positions prior Operator as a research preview with sunset of the standalone site after integration. [22]
Pricing / access tier: "Agent mode" is a ChatGPT feature; availability is described as plan dependent (Plus/Pro/Business include agent references on pricing pages; Operator originally Pro US). [23]
API surface: Closely related to the platform "computer use" tool + agentic tool stack (but ChatGPT agent itself is not an API). [24]
Confidence: High (85%) on existence/positioning; Medium (70-80%) on exact plan gating by geography because rollout language varies by post. [25]
Deep research (ChatGPT tool + specialized API models)
What it does (ChatGPT): Creates a proposed plan (user can edit), uses selected sources (web, files, and enabled apps), and outputs a documented report with citations; OpenAI notes enterprise admin controls (RBAC) and that deep research uses read actions from connected apps in that mode. [26]
What it does (API): Deep research models (o3-deep-research, o4-mini-deep-research) are optimized to find/analyze/synthesize many sources via Responses API, requiring at least one data source (web search, MCP servers, or file search over vector stores). [27]
Key limitations: Deep research models trade off cost/speed and have constrained supported features (notably, model pages state function calling/structured outputs are not supported for deep research models). [28]
Pricing / access tier: ChatGPT usage is plan-limited; API pricing is token-based (e.g., o3-deep-research $10/$40 per 1M tokens input/output; o4-mini-deep-research $2/$8). [29]
API surface: /v1/responses with tool requirements; model guide and cookbook describe "Deep Research API" as "via responses endpoint." [30]
Confidence: High (90%). [31]
Projects (ChatGPT)
What it does: "Smart workspaces" grouping chats, files, and custom instructions; includes project memory modes (including project-only memory) and sharing for Business/Enterprise/Edu. [32]
Key limitations: Data handling differs by plan (Business/Enterprise/Edu default no-training; Free/Plus/Pro may be used for training if user's setting enabled). [33]
Pricing / access tier: Included across Free and paid; shared project features vary by plan. [32]
Confidence: High (90%). [32]
Canvas (ChatGPT)
What it does: A writing/coding collaboration UI with inline edits, version history, code execution options, and admin toggles for enterprise network access; available on Web/Windows/macOS. [34]
Key limitations: Help center notes "Canvas is not available with pro-series models." (This affects workflows that default to pro-series models.) [35]
Pricing / access tier: Feature available broadly (sharing available for all plans) but rollout and execution controls differ by workspace type. [34]
Confidence: High (85%). [34]
Memory (ChatGPT)
What it does: Two mechanisms: saved memories and chat history reference; Plus/Pro have both, Free has saved memories only; supports user control (delete/disable, temporary chats). [36]
Key limitations: Memory is not supported for custom GPTs (stateless sessions even if user memory is on). [37]
Confidence: High (90%). [38]
Custom GPTs + GPT Store + GPT Builder + GPT Actions
What it does: Lets users build custom versions of ChatGPT (instructions + knowledge files + capabilities + custom actions/apps), and discover them via GPT Store; GPT Builder is itself implemented as a custom GPT with an action "under the hood." [39]
Key limitations:
- GPTs with custom actions have model compatibility constraints; Enterprise docs describe availability changes and mappings when models are retired/transitioned. [40]
- Memory does not carry into custom GPTs (stateless). [37]
Pricing / access tier: Creation is available to paid plans (Plus/Business/Enterprise) per FAQ; Free can use GPTs with limits. [41]
API surface: GPT Actions (platform docs) rely on function calling and can be imported from OpenAPI schemas; on the ChatGPT side, actions allow GPTs to call third-party APIs; Enterprise can domain-restrict actions. [42]
Confidence: High (85%) for core; Medium (70-80%) for exact model gating nuances across workspaces because multiple help pages describe transitions with date-specific rules. [43]
Apps in ChatGPT (formerly "Connectors") + Sync + Custom MCP Connectors
What it does: ChatGPT can connect to third-party applications to search/reference content in chat, use them in deep research, and (for some) sync/index content for faster retrieval; OpenAI notes the terminology shift from "connectors" to "apps" as of Dec 17, 2025. [44]
Key limitations: Apps availability varies by plan and region; synced connectors have plan and data residency constraints (and may be incompatible with some enterprise key management setups). [45]
Pricing / access tier: Apps for chat and deep research available to Plus/Pro/Business/Enterprise/Edu; synced apps available to Pro/Business/Enterprise/Edu in described configurations; custom connectors via MCP available to Plus/Pro and workspaces. [46]
Confidence: High (85%). [44]
Plugins (legacy; deprecated, replaced by GPT Actions)
What it does: Historically enabled third-party tools and browsing/computation inside ChatGPT; OpenAI's plugins post is explicitly marked deprecated; new plugin signups are closed and builders are directed to use Actions inside GPTs. [47]
Confidence: High (95%). [48]
Sora app (consumer) + Sora 2 (video + audio generation)
What it does: Sora is OpenAI's video generation product; Sora 2 adds synced audio (dialogue/sfx) and is deployed through a dedicated app and sora.com with staged rollout; OpenAI describes the original research preview (Feb 2024), product rollout (Dec 2024 "Sora is here"), and Sora 2 release (Sep 2025). [49]
Key limitations: Availability is staged/invite-based in the app; some help pages note deprecation of "Sora 1 on web" and shifts to new experiences and "Sora for Business" messaging. [50]
Pricing / access tier: ChatGPT plan pages indicate Sora access is limited on Plus and extended on Pro; credits can be purchased for additional usage; the API pricing is per second for sora-2/sora-2-pro. [51]
API surface: Video API /v1/videos with model values (sora-2, sora-2-pro). [52]
Confidence: High (90%). [53]
Codex (agentic coding) + Codex app (macOS) + "Codex agent" research preview
What it does: ChatGPT release notes (Feb 2, 2026) describe a Codex macOS app to manage multiple coding agents in parallel (background tasks, diffs, progress); ChatGPT plan pages mention "Codex agent research preview" for Pro and that Business includes access to Codex and ChatGPT agent across documents/tools/codebases. [54]
Key limitations: Details are productized but still framed as "research preview" in some plan descriptions; credit usage rules emphasize guardrails after plan limits. [55]
Pricing / access tier: Included as a plan feature (Pro mentions access; Business includes access), with credits as add-on for additional usage beyond included limits. [56]
API surface: Codex-aligned model variants appear in the platform model list (e.g., GPT-5.-Codex) and GitHub Copilot docs reference OpenAI Codex model families used in Copilot Chat. [57]
Confidence:* Medium (75-85%) because "Codex" spans app + models + previews and public docs are distributed across release notes, model pages, and third-party hosting docs rather than a single canonical "Codex product spec." [58]
Developer platform: models, APIs, tools, pricing
Model catalog (high level)
OpenAI's platform model catalog explicitly groups:
- Frontier text/reasoning: GPT-5.2, GPT-5 mini, GPT-5 nano, plus GPT-5.2 pro. [59]
- o-series reasoning: o3, o4-mini, plus pro variants and deep research specializations. [60]
- Deep research: o3-deep-research, o4-mini-deep-research. [27]
- Realtime/audio: gpt-realtime (+ mini), gpt-audio (+ mini), plus transcription/TTS models. [61]
- Images: GPT Image family (gpt-image-1.5, gpt-image-1, gpt-image-1-mini) and legacy DALL-E models (deprecated). [62]
- Video: Sora 2 family. [63]
- Open-weight: gpt-oss-120b, gpt-oss-20b. [64]
Key limitation: "ChatGPT models" are listed as not recommended for API use (separate from the API-facing models). [65]
Confidence: High (90%). [65]
API pricing anchors (decision-useful, not exhaustive)
- Text tokens (examples): GPT-5.2: $1.75/$14 per 1M input/output tokens; GPT-5.2 pro: $21/$168; o3: $2/$8; o4-mini: $1.10/$4.40; gpt-realtime: $4/$16 for text tokens plus audio token pricing. [66]
- Image generation: GPT Image pricing depends on token + per-image costs; OpenAI pricing pages and model cards provide per-image estimates and token-based rates. [67]
- Video generation: Sora API priced "per second" (e.g., sora-2 $0.10/sec, sora-2-pro higher). [68]
Confidence: High (85-90%) for the quoted prices because they come from published pricing pages; Medium (70-80%) for any "effective cost per task" inference because it depends on token counts and tool usage. [69]
Responses API (primary surface)
What it does: Generates stateful model responses with support for text/image inputs, structured outputs, tool calling, and multi-turn continuation (e.g., previous_response_id). Endpoint: POST /v1/responses. [70]
Key limitations: Feature support varies by model; some models explicitly don't support certain tools (e.g., model pages list tool support for GPT-5.2 vs GPT-5.2 pro). [71]
Pricing: Not priced separately; billed at selected model rates. [72]
Confidence: High (90%). [73]
Chat Completions API (supported; "legacy-ish" for new builds)
What it does: Classic chat-based requests: POST /v1/chat/completions, with stored completions capabilities when store=true. [74]
Key limitation: Docs advise new projects to consider Responses for "latest platform features." [75]
Confidence: High (90%). [76]
Realtime API (low-latency multimodal sessions)
What it does: Provides realtime text+audio I/O over WebRTC, WebSocket, or SIP using realtime models (e.g., gpt-realtime). [77]
Key limitations: Model cards note structured outputs not supported for gpt-realtime (and other feature constraints), and realtime implementations require session protocols and "prompt update" flows. [78]
Pricing: Token-based with distinct audio token rates, plus standard token rates for text. [79]
Confidence: High (85%). [78]
Conversations API (conversation state storage across Responses API calls)
What it does: Create/manage conversations and items via /v1/conversations and /v1/conversations/{id}/items, with "include" options for tool call details. [80]
Key limitation: It is state management, not "memory"; you still govern what gets put into conversation context. (This distinction matters for compliance and retention.) [81]
Confidence: High (85%). [80]
Assistants API (deprecated)
What it does (historically): Higher-level agent abstraction with threads/tools; included Code Interpreter, file search, etc. [82]
Status: Deprecated; OpenAI docs state it will shut down on August 26, 2026; migration guidance directs to Responses API. [82]
Confidence: High (90%). [82]
Hosted tools in the platform (usable via Responses; some via Chat Completions)
- Web search tool (web_search): enables up-to-date retrieval; docs describe multiple modes and that it can be used from Responses (and sometimes Chat Completions). [83]
- File search tool: semantic + keyword search over OpenAI-hosted vector stores; used as a Responses tool. [84]
- Function calling: call developer code; also underpins GPT Actions. [85]
- Remote MCP: tool guide framing MCP servers as remote tools for extending model capabilities. [86]
- Computer use tool (computer_use_preview + computer-use-preview model): loop-based UI automation; docs warn against high-stakes/authenticated environments and describe safety checks. [87]
- Code Interpreter tool: sandboxed Python for analysis; includes "containers" concept and /v1/containers endpoint support. [88]
- Image generation tool: uses GPT Image models through Responses tool calls and/or Images API; notes that DALL-E models are deprecated with a planned support end date for DALL-E 2/3 in 2026. [89]
Confidence: High (85-90%). [90]
Modality APIs (images, audio, video)
- Images API: /v1/images/generations, /v1/images/edits, /v1/images/variations (DALL-E 2 only for variations); supports GPT Image and DALL-E models. [91]
- Audio API: speech-to-text /v1/audio/transcriptions + translations; supports whisper-1 and newer GPT-4o transcription snapshots; also provides speech generation endpoints. [92]
- Video API: /v1/videos for Sora models with job-style creation/retrieve/delete; plus video generation guide for Sora. [93]
Confidence: High (90%). [94]
Core utility APIs (embeddings, moderation, fine-tuning)
- Embeddings: POST /v1/embeddings. [95]
- Moderations: POST /v1/moderations with default omni-moderation-latest. [96]
- Fine-tuning: POST /v1/fine_tuning/jobs and related retrieval/list endpoints. [97]
Confidence: High (90%). [98]
Agents SDK + tracing
What it does: OpenAI's Agents SDK (Python/TypeScript) is positioned as a library to build agentic apps with tool use, handoffs, streaming output, and "full trace of what happened." [99]
Key limitation: The SDK is a library; production readiness depends on your orchestration, tool implementations, and security posture. (Public docs describe capability but don't guarantee application-level correctness.) [100]
Confidence: High (85%). [99]
Open-weight models (gpt-oss + gpt-oss-safeguard)
What it does: OpenAI offers "open-weight reasoning models" (120B and 20B) intended for local/data center deployment, under Apache 2.0; help center release notes call out the initial release (Aug 5, 2025). [101]
Key limitation: These are text-only reasoning models per release notes; capabilities will differ from frontier hosted models and may require significant infra to deploy at scale. (This is a practical inference; Confidence <70% for strong statements about performance relative to current Claude/OpenAI frontier models because those comparisons aren't specified in the cited sources.) [102]
Confidence: High (85%) on existence/licensing; Low (60%) on competitive performance claims without separate benchmarking. [103]
Representative implementations
This section is intentionally representative rather than exhaustive. Implementations were selected because they (a) clearly name OpenAI models/features, (b) document an operational architecture pattern, and (c) provide a measurable or decision-relevant outcome.
Cross-product implementation patterns that recur
A repeating pattern in OpenAI-backed production systems is "LLM + retrieval + evaluation + guardrails": GPT models are embedded into workflows, grounded on internal data, and governed by evaluation frameworks and content/security filters. This is explicit in the Morgan Stanley[104] case study emphasis on evals at adoption time, and in GitHub[105] documentation noting content filtering and "zero data retention" agreements when serving OpenAI models in Copilot Chat. [106]
A second pattern is "model specialization by task": organizations route different tasks to different models (e.g., fast small reasoning models for throughput, stronger reasoning models for higher-stakes steps, computer use for UI-bound tasks). Unify[107]'s case study is essentially a narrative of "match OpenAI o3, GPT-4.1, and CUA to the right tasks," describing outcome lift from that routing strategy. [108]
Product-to-implementation comparison table
Product (OpenAI)
	Implementation name
	Architecture notes
	Problem solved
	Outcome / impact
	GPT-4 / GPT models (general)
	AI @ Morgan Stanley Assistant
	GPT-4 embedded into advisor workflows; adoption driven by evaluation framework and controls (case study highlights evals + trust controls). [109]
	Fast internal knowledge retrieval and summarization for advisors
	"Over 98% adoption" among advisor teams (case study). [109]
	GPT-4 (vision)
	Be My Eyes "Virtual Volunteer / Be My AI"
	Uses GPT-4 visual input capability to interpret images/screens and hold a conversation; positioned as superior to basic image recognition due to interactive reasoning. [110]
	Visual interpretation and independence for blind/low-vision users
	Public statements cite "unparalleled performance" and rapid beta-to-user release intent (qualitative impact). [110]
	GPT-4 (text)
	Stripe prototype-to-product pipeline
	Stripe ran internal prototyping (100 employees); previously used GPT-3 for support routing/summarization; GPT-4 expanded feasible use cases; claims model outperformed human reviewers in site summaries. [111]
	Support customization, docs Q&A, and fraud signal detection
	15 prototypes identified as strong product candidates; "GPT-4 was basically better than human reviewers" in one workflow (case study language). [111]
	GPT-4 + consumer app integration
	Duolingo Max
	Duolingo explicitly states new subscription tier built on GPT-4; features include interactive Roleplay and Video Call, with human-authored scenarios + human review + user reporting loop. [112]
	Scalable conversational practice and explanations in language learning
	Shipped as a paid tier; positioned as "future of AI education" in investor release and product blog. [113]
	Multi-model routing + agentic stack
	Unify "system of action"
	Case study describes pairing o3, gpt-4.1, and Computer-Using Agent (CUA) to different GTM tasks; explicitly frames growth as measurable/iterable engineering. [108]
	Automated prospecting + hyper-personalized outreach at scale
	"Generates 30% more pipeline" (case study headline/claim). [108]
	Computer-Using Agent / computer use
	Operator --> ChatGPT agent
	OpenAI describes CUA powering Operator and training via RL to interact with GUIs without app-specific APIs; positioned as universal interface with safety mitigations. [114]
	Completing tasks that require clicking/typing/scrolling in UI
	Product evolution: Operator standalone integrated into ChatGPT agent; positioned as broader utility. [115]
	OpenAI models in dev tooling
	GitHub Copilot Chat
	GitHub documents hosting for OpenAI models (including GPT-5.* and Codex variants) across OpenAI + GitHub Azure infra, with data commitments and content filtering pipeline. [116]
	AI pair-programming and chat assistance for developers
	Public documentation of multi-provider model hosting and "zero data retention" posture (security/enterprise impact). [116]
	GPT-5.2 in enterprise copilots
	Microsoft 365 Copilot model selector
	Microsoft blog states GPT-5.2 added to Microsoft 365 Copilot and Copilot Studio; connects to internal "Work IQ" and enterprise context. [117]
	Enterprise writing + reasoning grounded in org data
	Availability announced Dec 11, 2025; increases capability of agent experiences (qualitative; Microsoft claim). [118]
	Coverage note (explicit): I did not locate a single authoritative public "case study" for every OpenAI surface (e.g., I do not have a fully sourced third-party implementation writeup specifically for the Conversations API or the Moderations endpoint). Where missing, I avoid inventing architecture and treat these as platform primitives used implicitly in many systems. Confidence: High that these primitives are in wide use; Confidence: Low (<70%) on naming specific external products unless documented. [119]
Strategic assessment for Velorin
Velorin is Claude-first. This assessment focuses on where OpenAI is (a) clearly additive, (b) roughly parity, or (c) strategically irrelevant--and recommends a stance per phase: Ignore / Monitor / Integrate complementarily / Consider migration.
Capability deltas that are clearly documented
Video generation + synced audio at product and API level (Sora 2) is a clear OpenAI-documented capability with published API surface (/v1/videos) and per-second pricing, plus a consumer social app. I have not found an Anthropic equivalent in the Anthropic docs reviewed here; absence of evidence is not evidence of absence, so I treat "OpenAI unique" as Confidence 65% rather than >70%. [120]
OpenAI Realtime (WebRTC/WebSocket/SIP) is a maturely specified capability with dedicated models and pricing. Anthropic does not advertise an equivalent WebRTC/SIP realtime multimodal session API in the subset of Anthropic docs reviewed here (computer use + web search); again, Confidence 60% on uniqueness because this comparison is incomplete without a broader Anthropic doc survey. [121]
Open-weight models (gpt-oss) are explicitly positioned by OpenAI for local/anywhere deployment under Apache 2.0; this provides a lever for customers who insist on running weights on their infra. Whether Anthropic has an equivalent open-weight offering is not established by the sources used here (Confidence 55% that OpenAI is uniquely positioned on "open weights" among frontier vendors; verify before making a bet). [122]
ChatGPT as a distribution and workflow layer: OpenAI's plan pages and help center describe an unusually broad set of end-user features: projects with memory boundaries, canvas editor, GPT Store, apps directory with sync, deep research planning UI, and agent mode. Even if Velorin competes at the model layer, this "product OS" is the strongest competitive vector for OpenAI. [123]
Areas of strong parity (don't assume OpenAI is "alone")
Computer use / UI automation: Anthropic provides a computer use tool (screenshots + mouse/keyboard control) with explicit "agent loop" documentation and safety considerations. OpenAI provides computer use in the Responses API and describes similar loop mechanics and safety checks. Net: neither vendor should be assumed to have a monopoly; you should evaluate on reliability, safety controls, and integration ergonomics for Velorin's workloads. [124]
Web search as a tool: Anthropic documents a web search tool with cited sources; OpenAI documents a web search tool in the Responses API with multiple modes. This is functionally comparable at the "tool exists" layer (differences will be in citation quality, cost, tool-call controls, and orchestration). [125]
Recommendations by phase
Stealth phase (now)
Default stance: Claude stays primary. Use OpenAI only where it creates asymmetric advantage without forcing an architecture rewrite.
Integrate complementarily - Sora API for marketing/prototyping and "demo gravity." If Velorin needs video demos, onboarding explainers, or "generated walkthrough" content, OpenAI's /v1/videos and Sora 2 model line are the most directly productized option in the sources reviewed. [126]
- GPT Image via Responses tool or Images API for high-fidelity creative generation/editing (with the caveat that legacy DALL-E is deprecated and has an announced end-of-support date in 2026 per docs). [127]
- Realtime API if Velorin's differentiation includes live voice agents; OpenAI documents low-latency voice-first transport options (WebRTC/WebSocket/SIP), which can be used as a specialized I/O layer even if Claude remains the reasoning "brain." [77]
- Deep research models (API) for internal competitive research and synthesis pipelines (especially where you need agentic browsing + citations at scale). This can operationally reduce analyst time during stealth without embedding OpenAI into Velorin's customer-facing core. [128]
Monitor - Open-weight models (gpt-oss): monitor for viability (quality, safety, infra cost). Potentially useful for customer deployments requiring local inference, but performance/fit versus Claude and other open-weight options requires benchmarking (Confidence 60% on "must have" without internal evals). [103]
- Codex ecosystem: monitor because OpenAI is productizing multi-agent coding (Codex app) and shipping Codex-labeled model variants; this can affect developer expectations and adjacent tooling markets. [129]
Ignore (for Velorin product) - ChatGPT plan features as a direct dependency (Projects/Canvas/GPT Store) unless Velorin is intentionally building "inside ChatGPT." These are competitive factors, not necessarily integration points for an independent product.
Growth phase
Integrate complementarily - Responses API tool stack + MCP where Velorin needs hosted retrieval (file search/vector stores), web search, or managed tool execution without building/hosting every component. This reduces engineering burden as you scale features. [130]
- Computer use: decide between Claude vs OpenAI based on evals. Both provide computer use; OpenAI's computer use docs explicitly discourage fully authenticated/high-stakes usage in preview--this pushes Velorin toward human-in-the-loop designs for either vendor. [131]
Monitor - ChatGPT agent as a competitor: its "research --> action" packaging competes with many agentic SaaS roadmaps. Track feature velocity and enterprise rollout because it can compress time-to-market for customers who might otherwise buy Velorin. [21]
- Model churn in ChatGPT: OpenAI's retirement of GPT-4o/4.1/o4-mini from ChatGPT (Feb 2026) demonstrates that ChatGPT UI model availability can shift faster than API deprecations. If Velorin ever builds distribution on top of ChatGPT (GPT Store), this increases platform risk. [14]
Consider migration (only for specific components) - If Velorin's product-market fit is heavily voice-first and you need WebRTC/SIP-level realtime maturity quickly, consider migrating the voice I/O layer to OpenAI while keeping Claude for core reasoning (a "split brain" architecture). Confidence 70% that this can be net-positive; exact value depends on latency, cost, and safety constraints in Velorin's domain. [132]
Scale phase
Integrate complementarily - Multi-provider orchestration by design: emulate the pattern visible in GitHub Copilot's multi-model hosting approach--treat model providers as interchangeable behind strong policy, evals, and routing. This reduces vendor lock-in and lets Velorin pick OpenAI where it is strongest (video, images, realtime, deep research) without conceding core IP. [133]
- Enterprise alignment: OpenAI's Business plan explicitly states "no training" for workspace data, and GitHub describes "zero data retention" agreements with OpenAI for Copilot--these are the kinds of procurement/compliance signals you'll need at scale when integrating OpenAI components. [134]
Monitor - OpenAI "Apps" ecosystem and MCP: the shift from connectors to apps and the continued investment in sync/indexing are indicators of OpenAI's intent to own the enterprise knowledge interface layer. Velorin should keep a compatibility strategy (likely MCP-aligned) so customers can reuse connectors across assistants. [44]
Consider migration (rare) - Full migration off Claude to OpenAI for core reasoning is not recommended based on currently cited evidence alone; the right decision hinges on Velorin's domain, safety posture, and cost structure. Confidence <70% on any blanket "migrate" call without internal benchmarks that compare Claude vs GPT-5.2/o3 across your exact tasks.
Uncertainty register
OpenAI uniqueness vs Anthropic (video + realtime + open weights): I have strong evidence OpenAI offers Sora API, Realtime API, and open-weight gpt-oss models. I do not have fully comprehensive evidence about Anthropic equivalents beyond the Anthropic pages reviewed (computer use + web search + pricing), so claims of "Anthropic does not have X" remain Low confidence (55-65%). [135]
Codex scope ambiguity: Public sources show Codex as (a) a ChatGPT macOS app feature, (b) "Codex agent" preview in plan pages, and (c) Codex-labeled model variants used in developer tooling (including GitHub Copilot docs). Without a single canonical Codex product spec, any attempt to define "Codex" as one product is Medium confidence only. [136]
Plan limits and credit mechanics: OpenAI describes credits for flexible usage and notes that deep research usage varies by plan and is tracked in-product; exact limits therefore require checking the live UI and/or contract terms. Any numeric "limits" not explicitly stated in help docs should be treated as unknown. [137]
Model availability inside custom GPTs and transitions: OpenAI publishes date-specific transition rules (e.g., GPT retirements and mappings). These are accurate as of the cited pages but can change; treat as time-sensitive. [138]
________________


[1] [2] [7] [11] [30] [70] [73] [85] [104] [130] https://platform.openai.com/docs/api-reference/responses/compact?api-mode=responses
https://platform.openai.com/docs/api-reference/responses/compact?api-mode=responses
[3] [8] [21] [25] https://openai.com/index/introducing-chatgpt-agent/
https://openai.com/index/introducing-chatgpt-agent/
[4] [10] [124] https://docs.anthropic.com/en/docs/build-with-claude/computer-use
https://docs.anthropic.com/en/docs/build-with-claude/computer-use
[5] [13] [15] https://openai.com/chatgpt/pricing/
https://openai.com/chatgpt/pricing/
[6] [57] [59] [61] [64] [65] https://platform.openai.com/docs/models
https://platform.openai.com/docs/models
[9] [106] [109] https://openai.com/customer-stories/morgan-stanley/
https://openai.com/customer-stories/morgan-stanley/
[12] [47] https://openai.com/blog/chatgpt-plugins
https://openai.com/blog/chatgpt-plugins
[14] https://help.openai.com/en/articles/20001051
https://help.openai.com/en/articles/20001051
[16] [17] [26] [29] [31] https://help.openai.com/en/articles/10500283-deep-research
https://help.openai.com/en/articles/10500283-deep-research
[18] [19] [20] [134] https://help.openai.com/en/articles/8792828-what-is-chatgpt-team
https://help.openai.com/en/articles/8792828-what-is-chatgpt-team
[22] [115] https://openai.com/index/introducing-operator/
https://openai.com/index/introducing-operator/
[23] [51] https://openai.com/pricing
https://openai.com/pricing
[24] [87] [131] https://platform.openai.com/docs/guides/tools-computer-use/
https://platform.openai.com/docs/guides/tools-computer-use/
[27] [128] https://platform.openai.com/docs/guides/deep-research
https://platform.openai.com/docs/guides/deep-research
[28] https://platform.openai.com/docs/models/o3-deep-research
https://platform.openai.com/docs/models/o3-deep-research
[32] [33] https://help.openai.com/articles/10169521
https://help.openai.com/articles/10169521
[34] [35] https://help.openai.com/en/articles/9930697-what-is-the-canvas-feature-in-chatgpt-and-how-do-i-use-it
https://help.openai.com/en/articles/9930697-what-is-the-canvas-feature-in-chatgpt-and-how-do-i-use-it
[36] [38] https://help.openai.com/en/articles/8983136-what-is-memory
https://help.openai.com/en/articles/8983136-what-is-memory
[37] https://help.openai.com/en/articles/8983148-does-memory-function-with-gpts.%C2%A0
https://help.openai.com/en/articles/8983148-does-memory-function-with-gpts.%C2%A0
[39] https://openai.com/index/introducing-gpts/
https://openai.com/index/introducing-gpts/
[40] [43] [138] https://help.openai.com/en/articles/8555535-gpts-chatgpt-enterprise-version%3F.midi
https://help.openai.com/en/articles/8555535-gpts-chatgpt-enterprise-version%3F.midi
[41] https://help.openai.com/en/articles/8554407-gpts-faq
https://help.openai.com/en/articles/8554407-gpts-faq
[42] https://platform.openai.com/docs/actions/introduction/get-started-on-building%3B.doc
https://platform.openai.com/docs/actions/introduction/get-started-on-building%3B.doc
[44] [123] https://help.openai.com/en/articles/11487775-apps-in-chatgpt
https://help.openai.com/en/articles/11487775-apps-in-chatgpt
[45] [46] https://help.openai.com/en/articles/11487775/
https://help.openai.com/en/articles/11487775/
[48] https://openai.com/waitlist/plugins
https://openai.com/waitlist/plugins
[49] https://openai.com/research/video-generation-models-as-world-simulators
https://openai.com/research/video-generation-models-as-world-simulators
[50] https://help.openai.com/en/articles/12456897
https://help.openai.com/en/articles/12456897
[52] [53] [93] [107] [120] [126] [135] https://platform.openai.com/docs/api-reference/videos/content
https://platform.openai.com/docs/api-reference/videos/content
[54] [58] [129] [136] https://help.openai.com/en/articles/6825453-chatgpt-plus-upgrade-faq
https://help.openai.com/en/articles/6825453-chatgpt-plus-upgrade-faq
[55] [56] https://help.openai.com/en/articles/9793128
https://help.openai.com/en/articles/9793128
[60] https://platform.openai.com/docs/models/o3
https://platform.openai.com/docs/models/o3
[62] [127] https://platform.openai.com/docs/guides/image-generation?lang=javascript
https://platform.openai.com/docs/guides/image-generation?lang=javascript
[63] https://developers.openai.com/api/docs/models/sora-2
https://developers.openai.com/api/docs/models/sora-2
[66] [71] https://platform.openai.com/docs/models/gpt-5.2/
https://platform.openai.com/docs/models/gpt-5.2/
[67] [68] https://openai.com/api/pricing/
https://openai.com/api/pricing/
[69] https://platform.openai.com/pricing
https://platform.openai.com/pricing
[72] https://openai.com/api/pricing
https://openai.com/api/pricing
[74] [105] https://platform.openai.com/docs/api-reference/chat/create-chat-completion
https://platform.openai.com/docs/api-reference/chat/create-chat-completion
[75] [76] https://platform.openai.com/docs/api-reference/chat/get
https://platform.openai.com/docs/api-reference/chat/get
[77] [78] [79] [121] [132] https://platform.openai.com/docs/models/gpt-realtime
https://platform.openai.com/docs/models/gpt-realtime
[80] [81] https://platform.openai.com/docs/api-reference/conversations?lang=curl
https://platform.openai.com/docs/api-reference/conversations?lang=curl
[82] https://platform.openai.com/docs/guides/realtime/function-calls
https://platform.openai.com/docs/guides/realtime/function-calls
[83] https://platform.openai.com/docs/guides/tools-web-search
https://platform.openai.com/docs/guides/tools-web-search
[84] https://platform.openai.com/docs/guides/tools-file-search
https://platform.openai.com/docs/guides/tools-file-search
[86] [90] https://platform.openai.com/docs/guides/tools/file-search
https://platform.openai.com/docs/guides/tools/file-search
[88] https://platform.openai.com/docs/guides/tools-code-interpreter/
https://platform.openai.com/docs/guides/tools-code-interpreter/
[89] https://platform.openai.com/docs/guides/tools-image-generation/
https://platform.openai.com/docs/guides/tools-image-generation/
[91] [94] https://platform.openai.com/docs/guides/images/image-generation
https://platform.openai.com/docs/guides/images/image-generation
[92] https://platform.openai.com/docs/guides/speech-to-text
https://platform.openai.com/docs/guides/speech-to-text
[95] [98] https://platform.openai.com/docs/api-reference/embeddings/object?lang=node.js
https://platform.openai.com/docs/api-reference/embeddings/object?lang=node.js
[96] [119] https://platform.openai.com/docs/api-reference/moderations
https://platform.openai.com/docs/api-reference/moderations
[97] https://platform.openai.com/docs/api-reference/fine-tuning/retrieve?lang=node
https://platform.openai.com/docs/api-reference/fine-tuning/retrieve?lang=node
[99] [100] https://platform.openai.com/docs/guides/agents-sdk/
https://platform.openai.com/docs/guides/agents-sdk/
[101] [103] [122] https://openai.com/open-models
https://openai.com/open-models
[102] https://help.openai.com/en/articles/9624314-mo
https://help.openai.com/en/articles/9624314-mo
[108] https://openai.com/index/unify/
https://openai.com/index/unify/
[110] https://openai.com/index/be-my-eyes/
https://openai.com/index/be-my-eyes/
[111] https://openai.com/customer-stories/stripe
https://openai.com/customer-stories/stripe
[112] https://blog.duolingo.com/duolingo-max/
https://blog.duolingo.com/duolingo-max/
[113] https://investors.duolingo.com/news-releases/news-release-details/duolingo-max-shows-future-ai-education
https://investors.duolingo.com/news-releases/news-release-details/duolingo-max-shows-future-ai-education
[114] https://openai.com/index/computer-using-agent/
https://openai.com/index/computer-using-agent/
[116] [133] https://docs.github.com/en/copilot/reference/ai-models/model-hosting
https://docs.github.com/en/copilot/reference/ai-models/model-hosting
[117] [118] https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/available-today-gpt-5-2-in-microsoft-365-copilot/
https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/available-today-gpt-5-2-in-microsoft-365-copilot/
[125] https://docs.anthropic.com/en/docs/agents-and-tools/tool-use/web-search-tool
https://docs.anthropic.com/en/docs/agents-and-tools/tool-use/web-search-tool
[137] https://help.openai.com/en/articles/11487671-flexible-pricing-for-the-enterprise-edu-and-team-plans
https://help.openai.com/en/articles/11487671-flexible-pricing-for-the-enterprise-edu-and-team-plans
[VELORIN.EOF]
