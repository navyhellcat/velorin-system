# Velorin Research Library — v2
**Last updated: 2026-04-28 (Session 039 verify+repair+archive pass)**
**Cataloger: Jiang1, Director of Strategic Intelligence**
**Status: comprehensive replacement of v1**

---

## 1. PREAMBLE

### Purpose
A single consolidated reference of every standing research finding in the Velorin corpus, indexed by **logical topic_id** so any agent or Brain operator can retrieve a finding without reading the source. Cards carry compressed conclusions only — read source files for evidence chains, methodology, or verbatim quotes.

### GPS Ideology (load-bearing — do not violate)
- **Primary key = topic_id.** A logical, stable string (e.g. `agent-orchestration`, `window-gravity`, `kappa-operational-tightness`).
- **File paths are pointer fields.** They are mutable. If a source moves, only the pointer updates; every consumer that uses the topic_id keeps working.
- **No hardcoded paths in agent identity, persona, or operational logic.** Agents retrieve by topic_id; the library resolves the pointer.
- **One topic_id, one canonical card.** When two sources cover the same topic, one card with `combine` recommendations is preferred to two stub cards.

### How to consume
1. Find the topic by domain (Section 3) or scan the Master Index (Section 2).
2. Read the card. The card is enough for most decisions.
3. Follow the `source` pointer ONLY if the card is insufficient (need methodology, evidence, raw data).
4. Use the cross-reference map (Section 4) to find related topics.
5. For Erdős math, use Appendix B index (theorem → Build Guide consumer → source). Math is not summarized; the card is the pointer.

### Status vocabulary
- `STANDING` — current reference, load-bearing
- `SUPERSEDED` — replaced by newer research (`superseded_by` populated)
- `COMBINE` — should merge with another card (target named in card)
- `ARCHIVE` — historical interest only (recommended for `Velorin.v1.Archive/`)
- `INDEX-ONLY` — Erdős math; pointer not summary
- `OPEN-REQUEST` — Research_Needed/ items in Appendix A

### Companion document
`Velorin.ResearchLibrary.ArchiveRecommendations.md` — every card with status SUPERSEDED, COMBINE, or ARCHIVE, with proposed disposition. CT approves moves in a later session. Cataloger (Jiang1) executes zero moves.

---

## 2. MASTER INDEX

| topic_id | primary_domain | status | confidence | date | recommendation |
|---|---|---|---|---|---|
<!-- INDEX_ROWS_BELOW -->
| window-gravity | failure-modes | STANDING | 0.82 | 2026-03-29 | STANDING |
| agent-teams-boot-degradation | failure-modes | STANDING | 0.92 | 2026-03-31 | STANDING |
| ies-rule-activation-gap | failure-modes | STANDING | — | 2026 (s.035) | STANDING (roster) |
| ecosystem-check-diagnosis | tooling | STANDING | 0.88 | 2026-03-28 | STANDING |
| agent-orchestration | agent-architecture | STANDING | 0.82 | 2026-03-27 | STANDING |
| agent-ecosystem-reality | agent-architecture | STANDING | 0.85 | 2026-03-27 | STANDING |
| trey-multi-model-orchestration | agent-architecture | STANDING | 0.88 | 2026-03-31 | STANDING |
| openclaw-deep-dive | agent-architecture | STANDING | 0.85 | 2026-04-03 | STANDING |
| openclaw-nemoclaw-architecture | agent-architecture | STANDING | 0.88 | 2026-03-31 | STANDING |
| trey-mcp-a2a-architecture | agent-architecture | STANDING | — | 2026 (s.021) | STANDING (roster) |
| session021-research-synthesis | agent-architecture | STANDING (BRAINSTORM tag) | 0.78 | 2026-04-05 | STANDING |
| openai-ecosystem | vendor-specific | STANDING | 0.85 | 2026-03-26 | STANDING |
| google-antigravity-ide | vendor-specific | STANDING | 0.82 | 2026-04-05 | STANDING |
| gemini-model-selection | models | STANDING | 0.85 | 2026-04-05 | STANDING |
| trey-flashmoe-tools | models | STANDING | — | 2026 (s.020) | STANDING (roster) |
| superpowers-skills-framework | tooling | STANDING | 0.85 | 2026-03-29 | STANDING |
| gsd-spec-driven-development | tooling | STANDING | 0.85 | 2026-03-29 | STANDING |
| claude-cowork | tooling | STANDING | 0.90 | 2026-03-28 | STANDING |
| claude-connectivity-stack | tooling | STANDING | 0.85 | 2026-03-28 | STANDING |
| claude-code-tools-roundup-mar29 | tooling | COMBINE | 0.78 | 2026-03-28 | COMBINE → keep one card |
| obsidian-as-knowledge-infra | tooling | STANDING | 0.82 | 2026-03-28 | STANDING |
| ecosystem-intelligence-report | tooling | STANDING | 0.85 | 2026-03-28 | STANDING |
| velorin-adoption-memo | tooling | STANDING | 0.85 | 2026-03-28 | STANDING |
| mcp-browser-tabs | tooling | STANDING | 0.85 | 2026-03-30 | STANDING |
| tools-research-session-summary-mar29 | tooling | ARCHIVE | n/a | 2026-03-29 | ARCHIVE → session-summary archive |
| oasis-multi-agent-simulation | tooling | STANDING | 0.88 | 2026-03-31 | STANDING |
| trey-verifier-benchmark-methodology | tooling | STANDING | — | 2026 (s.036) | STANDING (roster) |
| trey-fsm-grammar-version-management | tooling | STANDING | — | 2026 (s.036) | STANDING (roster) |
| trey-media-extraction-tools | tooling | STANDING | — | 2026 (s.035) | STANDING (roster) |
| trey-perplexity-computer-framework | tooling | STANDING | — | n/a | STANDING (roster) |
| instruction-language-architecture | instruction-boot | STANDING | 0.82 | 2026-03-31 | STANDING |
| ies-implementation-architecture | instruction-boot | STANDING | — | 2026 (s.036) | STANDING (roster) |
| trey-bootloader-framing-fix | instruction-boot | STANDING | — | 2026-03-31 | STANDING (roster) |
| brain-full-analysis-mar30 | brain-architecture | STANDING | 0.85 | 2026-03-30 | STANDING |
| brain-activation-architecture | brain-architecture | STANDING | 0.83 | 2026-04-04 | STANDING |
| trey-semantic-memory-organization | brain-architecture | STANDING | — | 2026 (s.027) | STANDING (roster) |
| trey-viscoelastic-brain | brain-architecture | STANDING | — | 2026 (s.030) | STANDING (roster) |
| trey-synaptic-pruning-v2 | brain-architecture | SUPERSEDED → erdos-synaptic-pruning | — | 2026 (s.022) | SUPERSEDED |
| trey-synaptic-pruning-research-report | brain-architecture | STANDING | — | n/a | STANDING (roster) |
| zep-cloud-evaluation | knowledge-systems | STANDING | 0.87 | 2026-03-31 | STANDING |
| graphiti-evaluation | knowledge-systems | STANDING | 0.86 | 2026-03-31 | STANDING |
| knowledge-staleness | knowledge-systems | STANDING | — | 2026 (s.035) | STANDING (roster) |
| trey-brain-ingestion-pipeline | knowledge-systems | STANDING | — | 2026 (s.030) | STANDING (roster) |
| trey-automated-pointer-rating | knowledge-systems | STANDING | — | 2026 (s.033) | STANDING (roster) |
| trey-hard-memory-pipeline | knowledge-systems | STANDING | — | 2026 (s.004) | STANDING (roster) |
| trey-research-complete-roundup | knowledge-systems | STANDING (roster) | — | various | INDEX-style entry |
| trey-operating-papers-q1-2026 | agent-architecture | COMBINE | 0.85 | 2026 Q1 | COMBINE → 3 papers in one card |
| trey-vendor-comparison-roundup-q1-2026 | ecosystem-industry | COMBINE | 0.78 | 2026 Q1 | COMBINE → 4 files in one card |
| trey-skills-taxonomy-emergence | skills-system | STANDING | — | 2026 (s.031) | STANDING (roster) |
| trey-brain-to-skills-interface | skills-system | STANDING | — | 2026 (s.033) | STANDING (roster) |
| trey-skills-schema-validation | skills-system | STANDING | — | 2026 (s.035) | STANDING (roster) |
| trey-emotional-memory-salience | cognitive-behavioral | STANDING | — | 2026 (s.031) | STANDING (roster) |
| trey-persona-maker-landscape | cognitive-behavioral | STANDING | — | 2026 (s.036) | STANDING (roster) |
| human-brain-layers | cognitive-behavioral | STANDING (INDEX-style) | 0.92 | 2026-03-31 | STANDING |
| trey-epistemodynamics-novelty-check | math-foundations | STANDING | — | 2026 (s.031) | STANDING (roster) |
| trey-vegp-novelty-validation | math-foundations | STANDING | — | 2026 (s.035) | STANDING (roster) |
| trey-non-abelian-dynamics-audit | math-foundations | STANDING | — | 2026 (s.035) | STANDING (roster) |
| turboquant-and-mempalace | math-applied | STANDING | 0.86 | 2026-04-07 | STANDING |
| trey-turboquant-deep-dive | math-applied | STANDING | — | 2026 (s.007) | STANDING (roster) |
| trey-ai-ecosystem-state-of-play | ecosystem-industry | STANDING | — | 2026 (s.033) | STANDING (roster) |
| trey-gpt55-codex-integration | vendor-specific | STANDING | — | 2026 (s.036) | STANDING (roster) |
| trey-notebooklm-api-surface | vendor-specific | STANDING | — | 2026 (s.036) | STANDING (roster) |
| trey-google-ai-ultra-pass1 | vendor-specific | STANDING | — | n/a | STANDING (roster) |
| trey-google-ai-ultra-pass2 | vendor-specific | STANDING | — | n/a | STANDING (roster) |
| trey-gemini-ai-ultra-breakdown | vendor-specific | STANDING | — | n/a | STANDING (roster) |
| voice-io-parity | voice-input | STANDING | 0.89 | 2026-03-31 | STANDING |
| trey-voice-input-local | voice-input | STANDING | — | n/a | STANDING (roster) |
| workstation-setup-apr10 | infrastructure | STANDING | 1.00 | 2026-04-10 | STANDING |
| claude-code-on-replit | infrastructure | STANDING | 0.84 | 2026-03-31 | STANDING |
| trey-barrier-kvm-cross-mac | infrastructure | STANDING | — | 2026 (s.027) | STANDING (roster) |
| trey-velorin-kvm-bridge | infrastructure | STANDING | — | 2026 (s.027) | STANDING (roster) |
| trey-cross-platform-app-mesh | infrastructure | STANDING | — | 2026 (s.027) | STANDING (roster) |
| trey-smb-vs-tcp-event-propagation | infrastructure | STANDING | — | 2026 (s.027) | STANDING (roster) |
| trey-tool-barrier-kvm-network | infrastructure | STANDING | — | n/a | STANDING (roster) |
| deep-research-pipeline | tooling | STANDING | 0.84 | 2026-03-31 | STANDING |
| velorin-deep-research-report-mar25 | ecosystem-industry | STANDING | 0.85 | 2026-03-25 | STANDING |
| velorin-market-research-trey | ecosystem-industry | STANDING | 0.80 | 2026-03 | STANDING |
| velorin-mirofish-adoption-memo | agent-architecture | STANDING | 0.82 | 2026-03-28 | STANDING |
| trey-mirofish-stack-deep-research-roundup | knowledge-systems | COMBINE | 0.80 | 2026-03 | COMBINE → 14 files in one card |
| trey-velorin-tooling-research-roundup | tooling | COMBINE | 0.82 | 2026-03 | COMBINE → 10 files in one card |
| window-gravity-publication | ecosystem-industry | STANDING | 0.80 | 2026-03-31 | STANDING |
| system-assessment-session017-part1 | tooling/ARCHIVE | ARCHIVE | n/a | 2026-04-04 | ARCHIVE |
| system-assessment-session017-main | tooling/ARCHIVE | ARCHIVE | n/a | 2026-04-04 | ARCHIVE |
| system-assessment-tool-research-supplement | tooling/ARCHIVE | ARCHIVE | n/a | 2026-04-04 | ARCHIVE |
| architecture-clarity-session016 | tooling/ARCHIVE | ARCHIVE | n/a | 2026-04-03 | ARCHIVE |
| jiang2-handoff-items-from-v1-archive | n/a | ARCHIVE | n/a | 2026-04-26 | ARCHIVE — handoff, not research |
| claude-code-skills-full-landscape | tooling | STANDING | 0.88 | 2026-04-05 | STANDING |
| velorin-ecosystem-landscape-synthesis-may2026 | ecosystem-industry | STANDING | 0.85 | 2026-05 | STANDING |
| brain-analysis-mar30-folder-index | n/a | ARCHIVE | n/a | 2026-03-30 | ARCHIVE |
| (Erdős math 27 entries — was 26; +Erdos.Solution.FullStackAudit Session 040) | math-foundations | INDEX-ONLY | locked | 2026 (sessions 022-040) | see Appendix B |
<!-- INDEX_ROWS_ABOVE -->

---

## 3. DOMAIN-GROUPED CARDS

### 3.1 math-foundations
*See Appendix B for index of Erdős math solutions (INDEX-ONLY).*

<!-- DOMAIN_math-foundations -->

### 3.1.5 Session/working artifacts (ARCHIVE candidates)

The following Bot.Jiang/Working.Docs files are session-bound assessment / decision-support artifacts. Their load-bearing conclusions have been absorbed into other cards. Listed here for traceability; full disposition is in the ArchiveRecommendations companion doc.

- **system-assessment-session017-part1** — `Working.Docs/Jiang.SystemAssessment.Session017.Part1.ReadFirst.md`. Session-017 first-pass system assessment. ARCHIVE — content largely subsumed by `brain-full-analysis-mar30`, `agent-orchestration`, `agent-ecosystem-reality`. Historical reference only.
- **system-assessment-session017-main** — `Working.Docs/Jiang.SystemAssessment.Session017.md`. Session-017 second-pass extended findings. ARCHIVE — same rationale; key new findings (Scribe broken at the time, list_available_tools nonexistent, A8 stale) are time-bound operational state, not standing research.
- **system-assessment-tool-research-supplement** — `Working.Docs/Jiang.SystemAssessment.ToolResearch.Supplement.md`. Session-017 tool-research supplement; reconciles Jiang vs Trey on architecture and proposes the OpenClaw-as-outer-shell unification. ARCHIVE — synthesis is captured in `agent-orchestration` (related) and `openclaw-deep-dive` notes; the unified architecture proposal should be lifted into the Build Guide directly rather than carried as research.
- **architecture-clarity-session016** — `Working.Docs/Jiang.WorkingDoc.ArchitectureClarity.Session016.md`. Session-016 layered-stack working doc. ARCHIVE — superseded by the synthesized findings in the SystemAssessment.ToolResearch.Supplement and `obsidian-as-knowledge-infra`. Layer-summary table preserved in this card's pointer.
- **jiang2-handoff-items-from-v1-archive** — `Working.Docs/Jiang2.HandoffItems.From.v1.ArchivePass.md`. ARCHIVE — operational handoff to Jiang2, not research. Items 1 (Bot.Alexander review) and 2 (Level 4 General Rules salvage) are tracked in Jiang2's working docs, not the research library. Listed in Appendix A as OPEN-REQUEST adjacency only.
- **brain-analysis-mar30-folder-index** — `Research.BrainAnalysis.Mar30/INDEX.md`. ARCHIVE — 19-line folder index pointing only to `Brain.FullAnalysis.Mar30.md`; no research content. Carded here for completeness; full content covered by `brain-full-analysis-mar30`.

### 3.2 brain-architecture
<!-- DOMAIN_brain-architecture -->

#### topic_id: brain-full-analysis-mar30
status: STANDING
confidence: 0.85
date: 2026-03-30
primary_domain: brain-architecture
secondary_domains: [knowledge-systems, instruction-boot, agent-architecture]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research.BrainAnalysis.Mar30/Brain.FullAnalysis.Mar30.md`
related: [brain-activation-architecture, instruction-language-architecture, obsidian-as-knowledge-infra, openclaw-deep-dive]
build_guide_refs: [Brain region taxonomy, Scribe extension to Research_Complete, Brain.Index Phase 1]
recommendation: STANDING

##### Summary
Comprehensive audit of the Velorin Brain at 45 neurons / 4 regions / 10 areas (March 30, 2026). Core diagnosis: the Brain is **functionally a system map, not an intelligence layer** — operational neurons only, no Company / Intelligence regions. Scribe is silently failing because Company-knowledge and research-conclusion memories have no region to route to and accumulate as escalations. Three neurons (`A1.Architecture`, `A5.Protocols`, `A8.Startup`) confirmed stale. The 4-layer original vision (Personality / Hard Memories / Archival / Working Neurons) was never built beyond Layer 4. Long-term destination: Graphiti (real-time temporal knowledge graph by Zep team) when scale demands automation.

##### Key Findings
- Highest-leverage immediate action: create Company + Intelligence regions so Scribe has somewhere to route.
- KnowledgeIndex and Brain are parallel disconnected systems — 12 concluded research topics, 0 brain neurons.
- Brain is NOT in any agent's boot sequence — it's a backup lookup, not an active intelligence layer.
- Obsidian Option C (point at existing GitHub repo, no migration) preserves Trey's GitHub-raw-URL access while adding native graph visualization and backlinks (the reverse pointer index from HumanBrainLayers).
- Graphiti adoption trigger: Jiang's web exceeds ~50 concluded topics OR multi-user deployment begins.
- The intake test design is the unbuilt productization moat; was assigned in old schema, never transferred forward.

##### Why It Matters Now
Foundational diagnosis underpinning the brain rebuild work currently in Bot.Jiang2's scope. The "create Company + Intelligence regions" recommendation remains unimplemented; the stale neurons may have been corrected since (verify against current state before acting on the staleness list).

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Jiang.Research.BrainAnalysis.Mar30/Brain.FullAnalysis.Mar30.md`. Read source for the per-neuron staleness list, the GraphRAG / Zep / Graphiti competitive analysis, and the prioritized recommendation order.

#### topic_id: brain-activation-architecture
status: STANDING
confidence: 0.83
date: 2026-04-04
primary_domain: brain-architecture
secondary_domains: [instruction-boot, knowledge-systems, tooling]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Working.Docs.Assessments/Jiang.BrainActivation.Brainstorm.Apr4.md`
related: [brain-full-analysis-mar30, instruction-language-architecture, obsidian-as-knowledge-infra, window-gravity]
build_guide_refs: [Brain.Index parser, callable brain_lookup MCP tool, output-contract enforcement]
recommendation: STANDING

##### Summary
Synthesized architecture for Velorin Brain query → activation → traversal → packet compilation → output-contract-enforced response. Six conclusions with confidences: goal achievable (88%); callable MCP tool >> mandatory pre-pass (83%); tiered neuron schema better than universal triad (79%); YAML frontmatter pointers + wikilinks in content (Option D, 82%); 4-6 sessions to functional Phases 1-3 after Phase-0 prerequisites (85%); three previously-unnamed missing pieces (75%) — activation ≠ retrieval (vector entry-point needed at ~200+ neurons), output-contract enforcement equal in importance to retrieval, and **extending Scribe to fire on Research_Complete writes is the single highest-leverage immediate move**.

##### Key Findings
- Parser design: `python-frontmatter` + ~50 lines Python, BFS traversal, follow ratings [1]-[3], skip [4]+, max-depth configurable per query type.
- Build sequence: Phase 0 (fix Scribe PATH + create regions + migrate 45 neurons to YAML + install python-frontmatter), Phase 1 (parser + Gatekeeper upgrade), Phase 2 (query decomposition via Haiku), Phase 3 (packet compilation + callable tool + output-contract template), Phase 4 future (regional sub-agents at 500+ neurons).
- Output-contract pattern: agent must fill all fields (box_relevance, cross_domain_implications, known_patterns, decision_options, uncertainty_labeled) before delivering; if completion_check = NEEDS_MORE_CONTEXT, agent calls brain_lookup again — graceful self-loop without requiring follow-on rounds from CT.
- Migration script provided: converts current `Pointers: [1] X | [2] Y` syntax to YAML + adds wikilink hidden comment for Obsidian backlinks.

##### Why It Matters Now
Concrete buildable spec for the Brain activation system. Steps 1-3 (Scribe fix, Scribe extension to Research_Complete, neuron migration to YAML) are independent of Mac Studio and could be executed in any session. Note: many of these primitives (Gatekeeper, list_available_tools) have since been retired/superseded by the v2 transition — verify current tool surface before implementing.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Jiang.Working.Docs.Assessments/Jiang.BrainActivation.Brainstorm.Apr4.md`. Read source for the four reference-syntax options, complete Python parser code, migration script, and the full phased build sequence with gates.

### 3.3 agent-architecture
<!-- DOMAIN_agent-architecture -->

#### topic_id: trey-multi-model-orchestration
status: STANDING
confidence: 0.88
date: 2026-03-31
primary_domain: agent-architecture
secondary_domains: [tooling, vendor-specific, infrastructure]
source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/Trey.Topic.Multi_Model_Orchestration.md`
related: [agent-orchestration, openclaw-deep-dive, trey-mcp-a2a-architecture, openai-ecosystem]
build_guide_refs: [thin-orchestrator pattern, model-lane assignment, shared infrastructure layer]
recommendation: STANDING — pair with `agent-orchestration` for the full reconciled architecture

##### Summary
Trey's prescription for how ChatGPT / Gemini / Claude Desktop / Claude Code / Codex / Perplexity work in tandem. Core insight: **do not build product-to-product relay between consumer chat windows.** Build one thin orchestrator + one shared tool layer + one canonical memory layer + one task/event bus + one permissions/logging layer; assign each model to a lane (Perplexity = research, Claude Code = repo, OpenAI = synthesis, Gemini = multimodal/Google-native, Claude Desktop = operator console, Codex = secondary engineering). Velorin owns orchestration + memory + routing; no vendor owns canonical state.

##### Key Findings
- ChatGPT consumer app ≠ OpenAI integration backbone (use Responses API + connectors + remote MCP); Claude Desktop is operator console, NOT master orchestrator; Perplexity is bounded subsystem, not router.
- Minimum tool list (read_memory / write_memory / search_internal_docs / read_repo / write_repo / enqueue_task / read_calendar / send_email / research_web / create_document / create_spreadsheet / fetch_user_profile).
- Postgres-backed canonical state + vector retrieval index + optional graph layer + append-only event log.
- Three-phase build: (1) thin core (router + Postgres + vector + queue + MCP + function-calling), (2) attach model lanes, (3) governance (permissions, cost tracking, audit, retry, contradiction detection, validation).

##### Why It Matters Now
Direct architectural counterweight to Jiang's Claude-Agent-SDK-from-scratch recommendation in `agent-orchestration`. Per Session-017 reconciliation, the two are not competing — they describe different layers (Trey = infrastructure / Jiang = Claude-specific runtime / OpenClaw = pre-built outer shell). The unified architecture combines all three.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/Trey.Topic.Multi_Model_Orchestration.md`. Read source for the per-product surface inventory and the example end-to-end flow.

#### topic_id: openclaw-nemoclaw-architecture
status: STANDING
confidence: 0.88
date: 2026-03-31
primary_domain: agent-architecture
secondary_domains: [tooling, infrastructure, models, ecosystem-industry]
source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/Trey.Topic.OpenClaw_NemoClaw.md`
related: [openclaw-deep-dive, agent-orchestration, trey-multi-model-orchestration]
build_guide_refs: [outer-shell evaluation, NemoClaw security pattern, ACP bridge for external harnesses]
recommendation: STANDING — definitive reference for OpenClaw evaluation; pairs with Jiang's `openclaw-deep-dive`

##### Summary
Trey's structural deep-dive on OpenClaw + NVIDIA's NemoClaw hardening layer. **OpenClaw is a real candidate for the outer operator/control layer of a Velorin-style system.** Architecture: Gateway WebSocket (default 127.0.0.1:18789) owns messaging, control plane, and routing; per-agent isolation via SOUL.md / AGENTS.md / TOOLS.md; deterministic peer-most-specific routing; native session-to-session tools (sessions_list/history/send/spawn); skills as modular instruction capsules; OpenAI-compatible HTTP endpoint exposure; ACP bridge for Claude Code, Codex, Gemini CLI, Pi, OpenCode. NemoClaw adds OpenShell sandboxing, host-side credentials, routed inference (sandbox→inference.local→host-owned upstream), policy-controlled network/filesystem/process boundaries — but is **alpha, not production-ready.**

##### Key Findings
- Worth stealing immediately: Gateway as control plane; deterministic routing surfaces→agents; per-agent workspaces+auth; structured skills with precedence; session tools; ACP bridge; OpenAI-compatible API exposure.
- Don't copy blindly: one-host-as-trust-boundary; consumer chat surfaces as primary operational interface; file/workspace state as canonical company memory; unmanaged third-party skills as default extension path.
- Recommended low-regret experiment: one machine, one Gateway, 2-3 isolated agents, API-key auth, ACP only for bounded coding workflows, no public exposure, no canonical company memory inside OpenClaw.
- NemoClaw is a security-reference architecture, not a production dependency.

##### Why It Matters Now
The most consequential architectural decision before any Path-3 implementation. Build ON OpenClaw / build INSPIRED BY OpenClaw / build from scratch (Claude Agent SDK) — each path has distinct timeline, cost, and security profiles. Decision should precede any Path-3 code.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/Trey.Topic.OpenClaw_NemoClaw.md`. Read source for the Gateway protocol details, multi-agent isolation specifics, ACP semantics, and the full primary-source link list (24+).

#### topic_id: agent-orchestration
status: STANDING
confidence: 0.82
date: 2026-03-27
primary_domain: agent-architecture
secondary_domains: [models, tooling, infrastructure]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.AgentOrchestration.md`
superseded_by: null
related: [agent-ecosystem-reality, agent-teams-boot-degradation, claude-cowork, openai-ecosystem, claude-connectivity-stack]
build_guide_refs: [agent-runtime selection, Path-3 build sequence]
recommendation: STANDING

##### Summary
Framework landscape audit (Mar 2026) plus a build/buy/hybrid recommendation for Velorin's multi-agent runtime. Conclusion: build on **Claude Agent SDK** as the runtime, layer proprietary configuration / routing / memory / Drive integration on top. CrewAI/LangGraph rejected as primary because they duplicate what's already native (MCP, Agent Teams, extended thinking) and add dependency surface. Storage: Google Drive remains correct for current phase; transition trigger is ~50-80 active topic docs requiring semantic retrieval.

##### Key Findings
- Six production-grade frameworks compared (LangGraph, CrewAI, OpenAI Agents SDK, Claude Agent SDK, Google ADK, AutoGen/AG2). Framework layer is commoditized; orchestration logic + memory + profile are the moat.
- Anthropic Agent Teams (shipped 2026-02-06) is the teammate model Velorin's architecture wants — sweet spot 2-5 teammates, 5-6 tasks each.
- Subagents in Claude Agent SDK use isolated context windows; orchestrator gets only final output. MCP servers are the state-persistence layer.
- Path-3 build estimate: 4-7 focused sessions (orchestrator script + subagent definitions + output routing + trigger).
- Two unraised risks flagged: token-cost model (compound TPM under parallel subagents) and identity verification (auth-by-convention insufficient for autonomous operation).

##### Why It Matters Now
Foundational reference for any architectural decision about runtime, orchestration, or storage. Multi-vendor cowork plan (FW/MEMORY) for the Mac Studio transition needs to be reconciled with this — the recommendation here is Claude-native, but the standing project memory now adds Codex/GPT 5.5/Gemini.

##### Pointer
Source file: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.AgentOrchestration.md`. Read source for the framework comparison table, the storage transition criteria, and the 8-row conclusion table with per-conclusion confidence.

#### topic_id: velorin-deep-research-report-mar25
status: STANDING
confidence: 0.85
date: 2026-03-25
primary_domain: ecosystem-industry
secondary_domains: [agent-architecture, infrastructure, vendor-specific]
source: `Velorin.v1.Archive/Research/Bot.Trey.Assessments/Velorin_Deep_Research_Report.md`
related: [agent-orchestration, agent-ecosystem-reality, openclaw-nemoclaw-architecture, trey-multi-model-orchestration]
build_guide_refs: [Operator-OS wedge, 90-day priorities, MCP server hardening list]
recommendation: STANDING

##### Summary
Trey's strategic / market / technical synthesis on Velorin (March 25, 2026). **Strategic conclusion:** Velorin will win or lose on **safe action and governed orchestration**, not on raw intelligence. Competitive landscape is convergence of agentic automation (Zapier marketing AI agents + MCP, 8K integrations), enterprise agentic orchestration (Workato Enterprise MCP), consumer automation (IFTTT 1K+ apps), and voice/smart-home (Alexa Skills). Velorin's moat must be **orchestration logic + governance + five-box domain modeling + trustworthy action semantics.** First wedge: premium "Operator OS for Google Workspace" — governed orchestrator + small high-trust action set (Drive/Docs + calendar + email triage) + five-box dashboard.

##### Key Findings
- Direct competitor is convergence, not a single app; breadth-first integrations are commoditized; governance is differentiation.
- Engineering priority list: harden OAuth loopback; robust token lifecycle; shared-drive correctness everywhere; resource-key first-class support; Docs append safety (endOfSegmentLocation, no index math); transactional create→move→write; pagination + deterministic continuation; observability + audit log per side-effect.
- 90-day priorities: (1) ship safe-action core; (2) package the wedge; (3) complete company foundations (LLC, domains, brand mark).
- Per-box integration matrix: Workspace core + automation hub for Box 1; banking/ledger for Box 2; calendar/reminders for Box 3; calendar/notes for Box 4; doc generation + intake forms for Box 5.

##### Why It Matters Now
Authoritative early-stage strategic synthesis. Many specific tactical items (LLC, domains) are now stale (verify current state); the strategic frame (governance > breadth) and the engineering priority list remain load-bearing for any Workspace MCP server work.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Trey.Assessments/Velorin_Deep_Research_Report.md`. Read source for the probability tree, gantt roadmap, system integration diagram, and full per-priority engineering task table.

#### topic_id: velorin-market-research-trey
status: STANDING
confidence: 0.80
date: 2026-03 (early)
primary_domain: ecosystem-industry
secondary_domains: [vendor-specific]
source: `Velorin.v1.Archive/Research/Bot.Trey.Assessments/Trey_Market_Research.md`
related: [velorin-deep-research-report-mar25, agent-ecosystem-reality]
build_guide_refs: [wedge-product framing, anti-philosophy-brand cautions]
recommendation: STANDING

##### Summary
Trey's blunt strategic assessment of Velorin's near-term execution risk. **Vision quality high; near-term execution mixed; the company can work AND the current mode can absolutely bury it.** Behind in execution, NOT in concept. Culturally + strategically unique; externally not yet market-ready (high internal meaning density, weaker external compression). Biggest risk: company becomes most elegant at describing why it should exist instead of most effective at proving it should exist.

##### Key Findings
- Initial market = niche elite penetration with strong proof (operators / founders / executives / high-agency professionals with fragmented advisory stacks). Mass-market early = unlikely; expansion path operator OS → executive OS → family-office OS → advisory OS.
- Avoid: universal-product language too early; bot sprawl; document accumulation without conversion to operating leverage; Box 4 becoming decorative; confusing founder complexity with product complexity; philosophy brand without repeatable installation process.
- Most-needed external connections: calendar/email; banking/portfolio/debt; CRM/sales/commission; health data/wearables; legal/tax/compliance docs; document/knowledge storage. Plus event-driven architecture between boxes, durable identity layer, real cross-box priority scoring, Chairman dashboard, recommendations-vs-outcomes audit trail.

##### Why It Matters Now
Standing strategic counterweight to architecture-heavy session patterns. The "ahead in concept / behind in proof" framing remains accurate; 90-day priority order should be re-checked against this card.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Trey.Assessments/Trey_Market_Research.md`.

#### topic_id: velorin-mirofish-adoption-memo
status: STANDING
confidence: 0.82
date: 2026-03-28
primary_domain: agent-architecture
secondary_domains: [knowledge-systems, infrastructure]
source: `Velorin.v1.Archive/Research/Bot.Trey.Assessments/Velorin_MiroFish_Adoption_Memo.md`
related: [oasis-multi-agent-simulation, openclaw-nemoclaw-architecture, agent-orchestration]
build_guide_refs: [adopt-the-logic-not-the-stack pattern]
recommendation: STANDING

##### Summary
Decision memo on the MiroFish stack. **Adopt the logic, not the stack.** Enduring pattern: GraphRAG compiles knowledge → Zep stabilizes memory → OASIS runs the world → model gateway routes execution → ChatGPT/Claude sit above as operator layers. Don't run OASIS/Zep/GraphRAG/router natively inside ChatGPT or Claude. Don't let the UI client own memory, simulation state, or model selection. Don't build the Vue frontend before the Python backend, memory layer, and simulation APIs are stable. Don't confuse OpenAI-compatible APIs with provider interchangeability without testing.

##### Why It Matters Now
Direct precedent for Velorin's eventual decision-rehearsal layer (couples with `oasis-multi-agent-simulation`). Source file is sparse (1.6KB headers + bullets); read for the structural separation principle.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Trey.Assessments/Velorin_MiroFish_Adoption_Memo.md`.

#### topic_id: trey-mirofish-stack-deep-research-roundup
status: COMBINE
confidence: 0.80
date: 2026-03
primary_domain: knowledge-systems
secondary_domains: [agent-architecture, infrastructure, models]
combines: [14 files in `Velorin.v1.Archive/Research/Bot.Trey.Assessments/mirofish_stack_deep_research/`]
related: [oasis-multi-agent-simulation, velorin-mirofish-adoption-memo, graphiti-evaluation, zep-cloud-evaluation]
build_guide_refs: [decision-rehearsal stack reference, OpenAI-SDK-compatible model gateway pattern]
recommendation: COMBINE — 14-file deep dive on MiroFish components consolidated for index efficiency

##### Roster
Source folder: `Velorin.v1.Archive/Research/Bot.Trey.Assessments/mirofish_stack_deep_research/`. Each file is a focused component deep-dive. Promote to full card on demand.

| file | topic |
|---|---|
| 01_Graph_Construction_with_GraphRAG.md | GraphRAG knowledge-to-structure compiler — maps to Velorin Brain |
| 02_Environment_and_Persona_Setup.md | OASIS environment + persona configuration |
| 03_Simulation_with_Dynamic_Memory_Updates.md | OASIS simulation runtime with memory updates |
| 04_Report_Generation.md | Report generation from simulation runs |
| 05_Interactive_Querying_of_the_Simulated_World.md | INTERVIEW action and live probing |
| 06_Python_Backend.md | Python backend stack |
| 07_Vue_Frontend.md | Vue frontend (cautioned: don't build first) |
| 08_Node_js_18_plus.md | Node.js 18+ runtime requirements |
| 09_Python_3_11_to_3_12_and_uv.md | Python 3.11/3.12 + uv package manager |
| 10_Docker_Support.md | Docker containerization |
| 11_OpenAI_SDK_Compatible_LLM_API_with_Qwen.md | OpenAI-SDK-compatible model gateway with Qwen |
| 12_Why_Qwen_is_Recommended.md | Qwen rationale for the open model lane |
| 13_Zep_Cloud_for_Memory.md | Zep Cloud memory layer (see also `zep-cloud-evaluation`) |
| 14_OASIS_as_the_Underlying_Simulation_Engine.md | OASIS as simulation engine (see also `oasis-multi-agent-simulation`) |

##### Why It Matters Now
Reference implementation playbook for the simulation/decision-rehearsal layer when (and if) Velorin builds it. Adopt the structural pattern; do not copy the stack wholesale (per `velorin-mirofish-adoption-memo`).

#### topic_id: trey-velorin-tooling-research-roundup
status: COMBINE
confidence: 0.82
date: 2026-03
primary_domain: tooling
secondary_domains: [vendor-specific, ecosystem-industry, knowledge-systems]
combines: [10 files in `Velorin.v1.Archive/Research/Bot.Trey.Assessments/velorin_tooling_research/`]
related: [ecosystem-intelligence-report, velorin-adoption-memo, openclaw-nemoclaw-architecture, openai-ecosystem]
build_guide_refs: [tool-awareness directive (Trey's parallel to Window Gravity TASK_EVALUATION)]
recommendation: COMBINE — 10-file Trey tooling sweep consolidated for index efficiency

##### Roster
Source folder: `Velorin.v1.Archive/Research/Bot.Trey.Assessments/velorin_tooling_research/`.

| file | topic |
|---|---|
| Velorin_Agent_Tooling_Correction_Memo.md | **VELORIN TOOL-AWARENESS DIRECTIVE** — Trey's parallel to Jiang's Window Gravity TASK_EVALUATION; structurally equivalent fix arrived at independently |
| Compression_Context_Architecture_and_Token_Optimization.md | Direct answer to the reboot-token-cost problem |
| MiroFish_Population_Simulation.md | MiroFish overview + Velorin strategic read |
| OpenClaw_and_NemoClaw.md | Earlier/lighter analysis; superseded by `openclaw-nemoclaw-architecture` (Research_Complete) |
| GSD_Get_Shit_Done_Analysis.md | Trey caution: do NOT adopt GSD as company doctrine; borrow context-engineering posture only (resolves vs Jiang's Zone-2 install recommendation per ToolResearch supplement) |
| Google_NotebookLM_Cinematic_Video_Overviews.md | NotebookLM video overview capability |
| Codex_Function_and_Interoperability.md | Codex function + interoperability surface |
| What_Is_Vectoring_Vectorization_Embeddings_and_Vector_Stores.md | Foundational primer on vectors / embeddings / vector stores |
| ChatGPT_Internal_Tools_and_Connectivity.md | ChatGPT internal tools + connectivity |
| Miro_AI_Workflows_Sidekicks_Flows_and_Fishbone.md | Miro.com (visual collaboration platform — NOT MiroFish) AI workflows |
| Anatomy_of_a_GPT_5_Prompt.md | 8-component prompt anatomy (objective + role + context + tool posture + task + output contract + quality bar + completion standard) — directly informs `instruction-language-architecture` |

##### Why It Matters Now
The Tool-Awareness Directive should merge with the Window Gravity TASK_EVALUATION gate into a single permanent instruction (per Session-017 ToolResearch supplement). The Anatomy of a GPT-5 Prompt is the structural template every Velorin boot file should follow at Layer 3.

##### Pointer
Source folder: `Velorin.v1.Archive/Research/Bot.Trey.Assessments/velorin_tooling_research/`.

#### topic_id: agent-ecosystem-reality
status: STANDING
confidence: 0.85
date: 2026-03-27
primary_domain: agent-architecture
secondary_domains: [ecosystem-industry, knowledge-systems, failure-modes]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.AgentEcosystemReality.md`
superseded_by: null
related: [agent-orchestration, window-gravity, knowledge-staleness, openclaw-deep-dive]
build_guide_refs: [memory-backend selection, identity-verification placeholder]
recommendation: STANDING

##### Summary
Field-intelligence pass on what production multi-agent systems actually use vs. what tutorials recommend. Dominant pattern: orchestrator/subagent with file-based ("drop-box") state — Squad, ccswarm, Anthropic CLAUDE.md converged independently. Backends: SQLite (single-agent), Postgres+pgvector (teams), Redis hot + Postgres long-term (multi-agent at scale); vector-DB-only is rejected by practitioners as "search index, not memory." 88% of production deployments report security incidents; 45.6% rely on shared API keys. Frameworks are commoditized; structural decisions (typed schemas, handoff design, memory architecture) determine reliability.

##### Key Findings
- Document-based memory (Drive/CLAUDE.md/Markdown) is the correct production pattern — Velorin's choice is validated, not a prototype shortcut.
- "Big Bang" multi-agent builds fail every time; start small, build human oversight day one.
- Cross-framework agent coordination is universally unsolved as of Mar 2026 (A2A is the standard-in-progress; not adopted).
- Identity verification is the most urgent ecosystem-level gap; 21.9% of teams treat agents as identity-bearing.
- Compound 85% problem: 85% per-step accuracy yields ~20% success on a 10-step workflow — fundamental probability, no general fix.

##### Why It Matters Now
Provides the empirical ground truth for build decisions: what actually breaks in production. Confirms Velorin's Drive-based state, flags identity verification as a 1-session design problem to do before Path-3 autonomy, and quantifies the failure-rate baseline against which Velorin's architectural choices must be measured.

##### Pointer
Source file: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.AgentEcosystemReality.md`. Read source for the framework practitioner-experience table, the memory-backend tradeoff matrix, and the documented post-mortems (Cariad, Asymbl, n8n, etc.).

#### topic_id: openclaw-deep-dive
status: STANDING
confidence: 0.85
date: 2026-04-03
primary_domain: agent-architecture
secondary_domains: [ecosystem-industry, models, tooling]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/OpenClaw_Deep_Dive.md`
superseded_by: null
related: [agent-orchestration, claude-connectivity-stack, obsidian-as-knowledge-infra]
build_guide_refs: [model-routing patterns, multi-agent topology reference]
recommendation: STANDING

##### Summary
OpenClaw (Peter Steinberger, MIT) is the fastest-growing open-source multi-agent framework as of Mar 2026 (247K stars). Hub-and-spoke architecture: a local Gateway on port 18789 manages session, channel routing (WhatsApp/Telegram/Discord/iMessage/Slack/macOS/web/CLI), tool dispatch, and model calls. Multi-model native: Claude, GPT-5.2/Codex, Gemini 3, plus a ClawRouter local proxy that reports 60%+ cost reduction via smart routing. ClawHub: 13,729 community skills (VirusTotal-scanned). Nvidia's enterprise wrapper NemoClaw (GTC 2026) adds OpenShell sandboxing and on-prem inference.

##### Key Findings
- Architecture mirrors Velorin's intended hub-and-spoke (named personas with SOUL.md, per-agent model assignment, AGENTS.md registry, TOOLS.md).
- Obsidian skill is read+write+link — replaces $4K/month labor with $20/month agent setup in reported user cases.
- Velorin's differentiator vs OpenClaw: rated knowledge graph with synapse weights, activation patterns, pointer decay vs OpenClaw's flat vector embeddings (LanceDB/Mem0/Cognee).
- Reference repos for production multi-agent topology: TheSethRose/OpenClaw-Advanced-Config, raulvidis/openclaw-multi-agent-kit, shenhao-stu/openclaw-agents.

##### Why It Matters Now
Reference architecture for multi-channel, multi-model orchestration and a benchmark for what "off-the-shelf" can already do. Strategic read: Velorin's Brain remains the moat regardless of OpenClaw adoption. Possible future evaluation as a substrate.

##### Pointer
Source file: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/OpenClaw_Deep_Dive.md`. Read source for the model-config table, key-repos directory, and the NemoClaw enterprise notes.

#### topic_id: session021-research-synthesis
status: STANDING
confidence: 0.78
date: 2026-04-05
primary_domain: agent-architecture
secondary_domains: [knowledge-systems, instruction-boot, brain-architecture]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/Session021_Research_Synthesis.md`
superseded_by: null
related: [agent-orchestration, brain-full-analysis-mar30, gps-ideology-application]
build_guide_refs: [boot-neuron pattern, hooks-vs-CLAUDE.md hierarchy]
recommendation: STANDING — but tagged as BRAINSTORM in source

##### Summary
Synthesis of Session-021 background research (Hooks/Skills, memory landscape, LangGraph/Mem0/Letta operating papers) plus CT's "indirection over hard-coding" architectural principle. Key finding: GPT-4o-mini + plain text + grep scored 74% on memory benchmark (beat Mem0 graph at 68.5%) — Velorin's markdown+grep approach is already 80% of the way to production memory; PPR/Qdrant adds precision, not capability. Mem0's own audit found 97.8% of LLM-extracted memories are noise — validating Velorin's curated-neuron approach. Sequencing correction: ship file-based agents now → add Qdrant later → add PPR later → add session-extraction last.

##### Key Findings
- Hook enforcement hierarchy: Hooks (deterministic) > CLAUDE.md (advisory) > Skills (probabilistic). Critical rules currently in CLAUDE.md should be hooks.
- "Boot neuron" concept: SessionStart hook reads one stable neuron that points to current handoff/MEMORY/roster — file paths can change without breaking hooks. (DIRECT GPS ideology precedent.)
- Two-tier memory: Tier-1 session extraction (noisy/fast) vs Tier-2 curated neurons (high-signal/canonical) — distinct retrieval latency/precision profiles.
- 27 hook events available (TeammateIdle, TaskCreated/Completed, InstructionsLoaded); 10K char cap on hook output injection.

##### Why It Matters Now
The "boot neuron" / indirection principle is the conceptual ancestor of GPS ideology that this very library document instantiates. The hook hierarchy and the brainstorm of close-protocol-as-hook-chain remain unimplemented but architecturally sound.

##### Pointer
Source file: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/Session021_Research_Synthesis.md`. Read source for the four "borrow-from-each-system" lists and the explicit BRAINSTORM-ONLY status header (no concrete changes were made).

### 3.4 instruction-boot
<!-- DOMAIN_instruction-boot -->

#### topic_id: instruction-language-architecture
status: STANDING
confidence: 0.82
date: 2026-03-31
primary_domain: instruction-boot
secondary_domains: [failure-modes, agent-architecture, brain-architecture]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.InstructionLanguageArchitecture.PartA.md` + `.PartB.md`
related: [agent-teams-boot-degradation, ies-rule-activation-gap, brain-full-analysis-mar30, brain-activation-architecture]
build_guide_refs: [BOOTLOADER.md / IDENTITY.md / OPERATING_STANDARD.md three-layer split, FollowBench ceiling design constraint]
recommendation: STANDING — Part A and Part B should be consumed together; treat as a single research artifact in two parts.

##### Summary
Multi-thread audit of the language architecture for AI agent instructions. Validates the three-layer framework (Layer 1 Bootloader = fail-closed state machine; Layer 2 Identity = activates after BOOT_COMPLETE; Layer 3 Operating/Output = work rules + output contract). Empirical anchors: StateFlow (+13-28pp success, 5x cost reduction with state machines); FollowBench (~3 simultaneous-constraint ceiling at frontier); Lost in the Middle (20+pp degradation for middle-of-context info); GPT-4.1 recency bias officially documented; Anthropic operator-hierarchy provides architectural backing GPT lacks. AGENTIF: at agentic-scale (11.9 constraints avg), both Claude and GPT achieve only ~35-37% Constraint Success Rate.

##### Key Findings
- Mechanism is layered: positional attention bias + training-distribution alignment + RLHF sycophancy pressure all conspire against prose-only enforcement.
- AgentSpec / Agent-C achieve 90-100% compliance via runtime/tool enforcement; prompt-only is fundamentally lower-ceiling.
- Self-attestation is empirically unreliable (agents hit 100% nominal completion while satisfying 13-51% of quality criteria); evidence artifacts (READ/MISSING/UNREAD per file) are the validated alternative.
- Cross-model: shared bootloader template viable; Claude version XML-tagged at top; GPT version restates exit conditions at the END (recency bias).
- Velorin rebuild spec: BOOTLOADER.md ≤300 lines, IDENTITY.md ≤150 lines, OPERATING_STANDARD.md + OUTPUT_STANDARD.md (with hard bans on contrastive negation family, AI scaffolding openers, em-dash punchiness, neat triads, self-attestation phrases).
- Sequence: rebuild MA first (highest instruction surface), then Alexander, then Jiang.

##### Why It Matters Now
The structural prescription for every Velorin agent's boot/identity/work instructions. Any change to ATV / IES / boot artifacts in the Build Guide must respect the FollowBench ceiling and the evidence-artifact pattern documented here.

##### Pointer
Sources: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.InstructionLanguageArchitecture.PartA.md` (Threads 1-4: mechanism, cross-layer, model specificity, completion standards) and `.PartB.md` (Threads 5-6: minimum viable architecture, Velorin rebuild spec). Read Part A first; Part B operationalizes it.

### 3.5 tooling
<!-- DOMAIN_tooling -->

#### topic_id: oasis-multi-agent-simulation
status: STANDING
confidence: 0.88
date: 2026-03-31
primary_domain: tooling
secondary_domains: [agent-architecture, knowledge-systems]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.OASIS.md`
related: [agent-orchestration, openclaw-deep-dive, knowledge-staleness]
build_guide_refs: [Decision-rehearsal layer (Future B/C), profile-to-agent-config pipeline]
recommendation: STANDING

##### Summary
OASIS (CAMEL-AI / KAUST / Shanghai AI Lab / Oxford, arXiv 2411.11581, Apache 2.0, 3,990 stars) is a generalizable multi-agent simulation environment — `pip install camel-oasis`. Five core modules: Environment Server (SQLite/Postgres + 6 tables), RecSys (TwHIN-BERT / time-decay), Agent Module (UserInfo + persona + 24-dim hourly activity), Time Engine, Scalable Inferencer. **Zero GPU required for 100-agent API-backed simulations.** Production-validated: BTC Fear & Greed deployment runs 500 agents × 5 steps for ~$0.70 using DeepSeek. The INTERVIEW action enables external probing of synthetic stakeholders mid-simulation.

##### Key Findings
- Capability threshold: OASIS becomes minimum-sufficient at 20+ stakeholders and/or multi-round interaction dynamics; below that single-prompt prompting suffices.
- Cost: $10-85/month at personal scale (3 sims/day); $0.28-$2.75 per simulation depending on model.
- Profile-to-agent-config pipeline is buildable in ~50 lines Python via OASIS `UserInfo` / `TextPrompt` API. Not a multi-month problem.
- MiroFish is the production-tier reference (OASIS + GraphRAG + Zep). Velorin should "adopt the logic, not the stack" per Trey.
- Stanford Generative Agents complementary (deep individual cognition for 5-10 stakeholders) vs OASIS (population dynamics at 100+).

##### Why It Matters Now
Decision-rehearsal architecture for the long-term Velorin product (model second-order effects across CT's five boxes). Future-B viable; Future-C requires the full MiroFish stack. Pip-installable today — barrier is the profile-to-config pipeline + scenario design, not compute or cost.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.OASIS.md`. Read source for the per-scale cost table, profile-mapping matrix, and capability threshold tiers.

#### topic_id: superpowers-skills-framework
status: STANDING
confidence: 0.85
date: 2026-03-29
primary_domain: tooling
secondary_domains: [agent-architecture, instruction-boot]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/Tools_For_Velorin_Research/01_superpowers.md`
related: [gsd-spec-driven-development, claude-code-tools-roundup-mar29, velorin-adoption-memo]
build_guide_refs: [Claude Code skill installation tier, methodology hooks]
recommendation: STANDING

##### Summary
obra/superpowers — plugin-based agentic skills framework for Claude Code (Jesse Vincent / Prime Radiant, MIT, v5.0.6). Hard-gated workflow: brainstorm → plan → implement (subagents) → review → verify. 20+ auto-activating skills including subagent-driven-development (Path-3-in-Claude-Code), remembering-conversations (SQLite vector + Haiku summaries), using-git-worktrees, dispatching-parallel-agents, test-driven-development.

##### Key Findings
- Auto-activation by task context, not manual invocation — pattern Velorin bot skills should follow.
- Git worktree isolation skill solves parallel agent contamination flagged by Jiang.
- remembering-conversations is a working memory system that maps to the knowledge web concept.
- Platform: Claude Code, Codex, Gemini CLI, OpenCode (NOT Claude.ai projects).

##### Why It Matters Now
Install globally on Claude Code at machine arrival (Tier 0 of Adoption Memo). Plan-before-code discipline alone would have prevented multiple Velorin rebuild cycles in Sessions 001-006.

##### Pointer
Source: `01_superpowers.md`. Install: `/plugin marketplace add obra/superpowers-marketplace` then `/plugin install superpowers@superpowers-marketplace`.

#### topic_id: gsd-spec-driven-development
status: STANDING
confidence: 0.85
date: 2026-03-29
primary_domain: tooling
secondary_domains: [agent-architecture]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/Tools_For_Velorin_Research/02_gsd.md`
related: [superpowers-skills-framework, velorin-adoption-memo]
build_guide_refs: [Claude Code Tier-0 install]
recommendation: STANDING

##### Summary
gsd-build/get-shit-done — meta-prompting / context engineering / spec-driven dev system for Claude Code. 12.2K stars, used at Amazon/Google/Shopify/Webflow. v1.27+, MIT. Pipeline: discuss-phase → plan-phase (researcher + plan-checker agents) → execute-phase → verify-work. CONTEXT.md flows through all stages — functional analog of Velorin boot protocol, but automated. 428 tests across 13 files. Multi-runtime (Claude Code, OpenCode, Gemini CLI, Codex, Copilot, Cursor, Windsurf, Antigravity).

##### Key Findings
- gsd-researcher (915-line agent) runs BEFORE planning — exactly Jiang's role automated inside coding workflow.
- gsd-plan-checker (744-line agent) validates plans against goals.
- Install: `npx get-shit-done-cc --claude --global`.
- Together with Superpowers: GSD = project-management layer, Superpowers = coding methodology.

##### Why It Matters Now
Tier-0 install. Closes the discuss→plan→execute→verify gap that Velorin Operating Standards describes but no bot enforces.

##### Pointer
Source: `02_gsd.md`. Includes per-phase command reference and full agent architecture.

#### topic_id: claude-cowork
status: STANDING
confidence: 0.90
date: 2026-03-28
primary_domain: tooling
secondary_domains: [vendor-specific, infrastructure]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/Tools_For_Velorin_Research/03_cowork.md`
related: [claude-connectivity-stack, velorin-adoption-memo]
build_guide_refs: [scheduled tasks for EndOfDay/morning-brief/weekly-review]
recommendation: STANDING

##### Summary
Anthropic Cowork — desktop agentic AI for knowledge work (Pro/Max/Team/Enterprise). Launched Jan 2026; major updates through Mar 2026. Capabilities: scheduled tasks (sessions per task with full tool access), Computer Use (launched 2026-03-23, macOS+Windows), Dispatch (phone↔desktop persistent conversation), Projects, Plugins marketplace (Feb 2026), Connectors (Drive/Gmail/Slack/DocuSign/FactSet/Microsoft 365/custom MCP), Memory (free since 2026-03-02), Claude in Chrome.

##### Key Findings
- Scheduled tasks automate 30+ min/day of CT manual bot management (EndOfDay protocol, morning brief, weekly pipeline review).
- Plugins marketplace has role-specific toolkits (sales/marketing/legal/finance/data/PM).
- Cannot run on current MacBook Air — install when Mac Studio is online (achieved Apr 7).

##### Why It Matters Now
Tier-0 day-1 install per Adoption Memo. Computer Use enables cross-session agent coordination until Path 3 API is built.

##### Pointer
Source: `03_cowork.md`. Set scheduled tasks via `/schedule` or sidebar.

#### topic_id: claude-connectivity-stack
status: STANDING
confidence: 0.85
date: 2026-03-28
primary_domain: tooling
secondary_domains: [agent-architecture, knowledge-systems]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/Tools_For_Velorin_Research/04_claude_connectivity.md`
related: [claude-cowork, mcp-browser-tabs, obsidian-as-knowledge-infra]
build_guide_refs: [tool-surface inventory, evaluation-gate input]
recommendation: STANDING

##### Summary
Four-layer Claude interoperability map (live as of Mar 2026): Layer 1 MCP (97M monthly downloads, 5,800+ servers, MCP Apps in Jan 2026 returns interactive UI, Tool Search Mar 2026 cuts context ~95%); Layer 2 Connectors (one-click Drive/Gmail/Calendar/Slack/Salesforce/Asana/Box/monday/Figma/Canva/Hex/DocuSign + custom MCP URLs); Layer 3 Skills/Hooks/Plugins/Agent Teams (Feb 2026 — multiple instances on shared task lists); Layer 4 Memory (Claude Memory free Mar 2, Cowork project-scoped, CLAUDE.md file-based, Superpowers SQLite vector).

##### Key Findings
- No Velorin bot has previously surfaced this stack as a unified picture — mapped here for the first time.
- Tool Search (Mar 2026) is the structural answer to deferred-tool context bloat.
- Memory has 4 distinct forms with different scopes — selection matters.

##### Why It Matters Now
Foundation for the live tool-inventory pattern (input to the Window Gravity evaluation gate). Tool blindness is Window Gravity at the infrastructure layer.

##### Pointer
Source: `04_claude_connectivity.md`.

#### topic_id: claude-code-tools-roundup-mar29
status: COMBINE
confidence: 0.78
date: 2026-03-28
primary_domain: tooling
secondary_domains: []
source: combined — Tools_For_Velorin_Research/{05_awesome_claude_code, 06_uiux_pro_max, 07_obsidian_skills}.md
combines: [awesome-claude-code-index, uiux-pro-max, obsidian-skills-plugin]
related: [velorin-adoption-memo, obsidian-as-knowledge-infra]
build_guide_refs: [Claude Code Tier-0/Tier-1 install matrix]
recommendation: COMBINE — these three are sub-1-page pointers with install commands; consolidate into one "Claude Code curated installs" card

##### Summary
Three short zone files; each is a single-tool pointer with install command. Bundling into one card reduces fragmentation without losing detail.
- **awesome-claude-code** (`hesreallyhim/awesome-claude-code`, 28.6K stars): definitive curated index of Claude Code extensions; key items: AgentSys, Ralph, claude-mem, Context Restorer, parry (injection scanner), n8n-MCP, Untether (Telegram bridge). Mandatory first stop in ecosystem-check protocol.
- **UI/UX Pro Max** (`nextlevelbuilder/ui-ux-pro-max-skill`, 49.7K stars): auto-generates design systems — 50+ styles, 161 palettes, 57 font pairings, 161 product types, 99 UX guidelines, 25 chart types, 10 stacks. Install via `/plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill`.
- **Obsidian Skills** (`kepano/obsidian-skills`, 9.7K stars, official by Obsidian CEO): obsidian-markdown, obsidian-bases, json-canvas, obsidian-cli. Prerequisite for Obsidian-as-knowledge-infrastructure migration.

##### Why It Matters Now
Each is a Tier-0 or Tier-1 install in the Adoption Memo. Bundled here for fast lookup; underlying source files remain authoritative.

##### Pointer
Sources: `05_awesome_claude_code.md`, `06_uiux_pro_max.md`, `07_obsidian_skills.md`.

#### topic_id: obsidian-as-knowledge-infra
status: STANDING
confidence: 0.82
date: 2026-03-28
primary_domain: tooling
secondary_domains: [knowledge-systems, instruction-boot]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/Tools_For_Velorin_Research/08_obsidian_storage.md`
related: [claude-code-tools-roundup-mar29, ecosystem-intelligence-report, velorin-adoption-memo, openclaw-deep-dive, brain-full-analysis-mar30]
build_guide_refs: [knowledge substrate selection, boot-protocol retirement]
recommendation: STANDING

##### Summary
Thesis: Obsidian vaults are the correct substrate for personal AI knowledge bases — local-first, plaintext, graph-structured, user-controlled, near-zero boot token cost. Architecture: Obsidian Vault ↔ MCP Server ↔ Claude Code/Desktop. Migration path: install Obsidian → mirror Drive structure → install obsidian-skills + MCP → Claude reads natively → Drive demoted to backup → CLAUDE.md replaces boot protocol.

##### Key Findings
- Replaces Drive boot protocol, [VELORIN.EOF] checking, manual uploads, session handoffs, Google Docs knowledge web.
- Direct structural answer to reboot-token-cost problem.
- Pairs with the Brain (graph-structured knowledge in markdown is exactly what neurons are).

##### Why It Matters Now
Tier-1 / Month-1 commit per Adoption Memo. Architectural decision still pending CT lock; brain-architecture and the Velorin Brain repo currently fulfill this role on GitHub.

##### Pointer
Source: `08_obsidian_storage.md`.

#### topic_id: ecosystem-check-diagnosis
status: STANDING
confidence: 0.88
date: 2026-03-28
primary_domain: tooling
secondary_domains: [failure-modes]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/Tools_For_Velorin_Research/09_diagnosis.md`
related: [window-gravity, ecosystem-intelligence-report, velorin-adoption-memo]
build_guide_refs: [Operating Standards Section 7 — Mandatory Ecosystem Check]
recommendation: STANDING

##### Summary
Velorin bots default to "solve with what is known or already built" — no bot independently surfaces tools/plugins/skills/connectors/community solutions. Operating Standards Section 2 is abstract and names no discovery sources. Proposed fix: new Section 7 — mandatory ecosystem check before any build decision (awesome-claude-code, plugin marketplace, Connectors, Cowork plugins, GitHub). Surface findings or state "ecosystem check completed."

##### Key Findings
- Diagnosis confidence 88%; proposal 82%; estimated impact 30-40% build acceleration, 70%+ ops reduction.
- Direct precursor to Window Gravity research — same root cause, different angle.

##### Why It Matters Now
Ecosystem-check protocol remains pending Operating Standards lock by CT. Couples directly with the Window Gravity evaluation gate and live tool inventory.

##### Pointer
Source: `09_diagnosis.md`.

#### topic_id: ecosystem-intelligence-report
status: STANDING
confidence: 0.85
date: 2026-03-28
primary_domain: tooling
secondary_domains: [agent-architecture, knowledge-systems, infrastructure]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/Tools_For_Velorin_Research/10_Ecosystem_Intelligence_Report.md`
related: [ecosystem-check-diagnosis, velorin-adoption-memo, claude-cowork, obsidian-as-knowledge-infra, agent-orchestration]
build_guide_refs: [Operating Standards Section 7, Tier-0/Tier-1/Tier-2 install plan]
recommendation: STANDING

##### Summary
Master synthesis of the Mar-29 tools research. Documents what was missed (Superpowers, GSD, Cowork scheduled tasks, Agent Teams, Connectors, UI/UX Pro Max, Obsidian, memory systems), what it cost (2-3 sessions of rework, 30+ min/day Chairman bot management, possibly entire Path-3 build), the proposed fix (Section 7 mandatory ecosystem check), and an implementation timeline (Week 1 / Month 1 / Month 2-3) with impact estimates.

##### Key Findings
- Path 3 may already exist as Anthropic Agent Teams (100K-line C compiler with 16 agents).
- Drive connector should have been evaluated before custom MCP build — Velorin built what was already one click.
- Boot protocol token cost → near-zero with Obsidian + CLAUDE.md.

##### Why It Matters Now
Operational roadmap that unifies the zone files into one prioritized plan. Many items are now project-state-tracked elsewhere (Mac Studio cowork plan in feedback memory).

##### Pointer
Source: `10_Ecosystem_Intelligence_Report.md`.

#### topic_id: velorin-adoption-memo
status: STANDING
confidence: 0.85
date: 2026-03-28
primary_domain: tooling
secondary_domains: [agent-architecture, knowledge-systems]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/Tools_For_Velorin_Research/11_Adoption_Memo.md`
related: [ecosystem-intelligence-report, superpowers-skills-framework, gsd-spec-driven-development, claude-cowork, obsidian-as-knowledge-infra]
build_guide_refs: [phased install matrix Tier-0..3, Operating-Standards Section-7]
recommendation: STANDING

##### Summary
Tiered roadmap for adopting the Mar-29 tools findings. Tier 0 (Day 1, $0): Cowork scheduled tasks + Connectors + Superpowers + GSD + Operating Standards Section 7. Tier 1 (Week 1): Obsidian vault + obsidian-skills + Obsidian MCP + Agent Teams evaluation + UI/UX Pro Max + Ralph eval (substrate-only). Tier 2 (Month 1): knowledge-web migration + bot instructions migration + Cowork projects + Agent Teams deployment + Drive demote. Tier 3 (Month 2-3): boot-protocol retirement + Claude.ai consolidation + n8n-MCP + memory-system selection.

##### Key Findings
- What NOT to adopt: Ralph at orchestrator level (removes CT from cross-domain decisions); CrewAI/LangGraph (Agent SDK is correct runtime); Simone (GSD fills slot); Obsidian Sync (git-vault sync correct); migrating Trey to Claude (different model = adversarial check, keep on GPT).
- Decision points: Agent Teams 2-hour test (Tier 1.4), Obsidian Month-1 commit, Claude.ai consolidation deliberately variable.

##### Why It Matters Now
Operational adoption plan. Tier-0 items still mostly pending CT lock; Mac Studio is online (Apr 7) so Cowork installation is unblocked.

##### Pointer
Source: `11_Adoption_Memo.md`. Includes pointer registry to all related research with dual LOCAL/GITHUB paths.

#### topic_id: mcp-browser-tabs
status: STANDING
confidence: 0.85
date: 2026-03-30
primary_domain: tooling
secondary_domains: [agent-architecture]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/Tools_For_Velorin_Research/12_mcp_browser_tabs.md`
related: [claude-connectivity-stack]
build_guide_refs: [Trey-push pattern, Claude-in-Chrome integration]
recommendation: STANDING

##### Summary
`@kazuph/mcp-browser-tabs` — macOS AppleScript MCP server enumerating all open Chrome tabs across windows. Solves the Claude-in-Chrome blind-spot: official extension only sees its own tab group; this server returns every tab's URL. Tools: `get_tabs`, `close_tab`. Test 2026-03-30 confirmed: navigating to a chatgpt.com conversation URL lands inside the booted session (no re-boot). Mechanism for pushing tasks into a live booted Trey session.

##### Key Findings
- macOS only (AppleScript), Chrome only, requires Accessibility permissions on Chrome.
- Read+close only — no click/type/scroll (that's Claude in Chrome).
- Conversation URL preserves live session state on ChatGPT.
- Requires Claude Desktop restart after adding to MCP config.

##### Why It Matters Now
Operational integration for routing tasks into Trey (or any external Chrome-hosted booted session) without re-booting.

##### Pointer
Source: `12_mcp_browser_tabs.md`. GitHub: github.com/kazuph/mcp-browser-tabs.

#### topic_id: claude-code-skills-full-landscape
status: STANDING
confidence: 0.88
date: 2026-04-05
primary_domain: tooling
secondary_domains: [skills-system, instruction-boot, knowledge-systems, agent-architecture]
source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/ClaudeCode_Skills_Full_Landscape.md`
related: [superpowers-skills-framework, gsd-spec-driven-development, claude-connectivity-stack, brain-activation-architecture, instruction-language-architecture, brain-full-analysis-mar30, zep-cloud-evaluation, trey-velorin-tooling-research-roundup]
build_guide_refs: [boot/close/handoff cycle as skill+hook pair, SessionStart hook pattern, skill-creator empirical pipeline]
recommendation: STANDING

##### Summary
Background-agent (commissioned via Jiang) full audit of the Claude Code skills ecosystem as of Q1 2026. Three-layer hierarchy emerges naturally across major collections (alirezarezvani 248 skills / VoltAgent 1000+ / rohitg00 35-curated-via-SkillKit-400K / travisvn ~45 / hesreallyhim large / obra/superpowers 20+), independently mirroring Velorin Brain's region/area/neuron structure. Skill invocation has three modes: manual `/skill`, auto by Claude on description-match, subagent preload via `skills:` field. Skill-creator plugin is a full empirical development pipeline (Create / Eval / Improve / Benchmark) with documented production case (WordPress security: +9.5pp pass rate, -9.9% time vs baseline). **Single most important Velorin recommendation: build the boot/close/handoff cycle as a skill + hook pair before anything else.**

##### Key Findings
- Hooks and skills operate in **separate lanes**: hooks are shell commands at lifecycle events; skills are instruction sets Claude loads. SessionStart hook can inject text to context (deterministic) but cannot directly invoke a skill.
- Recommended four-component automated session lifecycle: (1) `/close-session` skill with `disable-model-invocation: true`; (2) SessionEnd hook commits handoff to GitHub + notifies; (3) SessionStart hook (matcher: "startup") injects last handoff into context; (4) SessionStart hook (matcher: "compact") re-injects after compaction.
- Bash injection via `` !`command` `` runs at preprocessing (before Claude sees anything); `${CLAUDE_SKILL_DIR}` enables portable bundled scripts; `disableSkillShellExecution` setting available for hardening.
- `context: fork` spawns isolated subagent with chosen `agent` type (Explore / Plan / general-purpose / custom from `.claude/agents/`); cannot see main conversation history; cannot write back to memory (returns summary).
- Skill-creator generates 20 trigger-evaluation queries (10 should-trigger + 10 near-miss) and runs iterative optimization loop — critical for Velorin's auto-load needs.
- Memory integration via 3 patterns: MCP server (Mem0, Qdrant); skill-triggered query; SessionStart hook + memory query (most powerful for Velorin). **No public Zep + Claude Code skill integration exists** — gap.
- Production architecture references: Daniil Okhlopkov's CLAUDE.md + skills + hooks + Obsidian + Telegram autonomous loop; Jarvis 24/7 ops with 76 scheduled tasks; Loki-Mode 37-agent orchestration; Trail of Bits CodeQL/Semgrep skills.
- Open bug to track: skill-scoped hooks defined in SKILL.md frontmatter do not trigger inside plugins (anthropics/claude-code #17688).

##### Why It Matters Now
Closes the gap between v2's `superpowers-skills-framework` / `gsd-spec-driven-development` / `claude-connectivity-stack` cards and the brain-architecture work in `brain-activation-architecture`. The four-component automated lifecycle is buildable today with documented primitives — directly addresses the manual coordination overhead that has burned multiple sessions.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/ClaudeCode_Skills_Full_Landscape.md`. Read source for the per-collection skill counts, the 8-section structure, the QMD Sessions architecture detail, and the full source-link list.

#### topic_id: velorin-ecosystem-landscape-synthesis-may2026
status: STANDING
confidence: 0.85
date: 2026-05 (synthesizes April-May 2026 ecosystem)
primary_domain: ecosystem-industry
secondary_domains: [agent-architecture, vendor-specific, models, math-foundations, brain-architecture]
source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/Trey.Research.VelorinEcosystemLandscapeSynthesis.md`
related: [openai-ecosystem, gemini-model-selection, google-antigravity-ide, openclaw-nemoclaw-architecture, agent-orchestration, trey-multi-model-orchestration, zep-cloud-evaluation, graphiti-evaluation, voice-io-parity, brain-full-analysis-mar30]
build_guide_refs: [A2A v1.0 adoption, GPT-5.5 routing for terminal/infrastructure, Opus 4.7 cost mitigation via Erdős pruning, Local-model demotion oracle]
recommendation: STANDING — carries CT-required disclaimer at source top: "None of this is concrete... for consideration and checking and steelmanning... ONLY after discussion with the Chairman"

##### Summary
Trey's comprehensive April-May-2026 ecosystem-shift synthesis. **Headline architectural finding:** Velorin's four-layer epistemodynamic memory architecture is mathematically superior to commercial alternatives because it is liberated from multi-tenant cloud constraints — but Velorin is **critically lagging on inter-agent communication infrastructure**. The Linux Foundation launched the Agentic AI Foundation (AAIF) in April 2026, unifying MCP v1.0 (agent-to-tool) and A2A v1.0 (agent-to-agent peer delegation, Signed Agent Cards). Major model releases reset the routing logic: GPT-5.5 (April 23) hits 82.7% on Terminal-Bench 2.0 vs Claude Opus 4.7's 69.4%; Opus 4.7 introduces a tokenizer that makes code-heavy prompts ~35% more expensive; DeepSeek V4-Flash hits ~$0.14/M-input-tokens with native 1M context; Gemma 4 (E2B/E4B/26B-MoE) brings frontier reasoning to edge hardware.

##### Key Findings
- **Velorin Consensus Filter applied:** consensus is OS-Tiered State (Letta) and Temporal Knowledge Graphs (Zep/Graphiti); exists due to multi-tenant compute rationing; Velorin does NOT share that constraint (air-gapped, single-user, dedicated silicon).
- **Genuinely novel in Velorin:** Thermodynamic Epistemodynamics (Erdős Second Law); Affective Hamiltonian H_E + Causal Action Potential Φ_causal = π_v/α (replaces purely temporal decay).
- **Convergent (independently arrived):** graph-over-vector for memory (matches Graphiti shift); role-bound specialist agents (matches CrewAI / Qualixar OS).
- **Lagging:** A2A v1.0 not adopted (CT-as-router is critical-path failure mode); no sandbox containment (NemoClaw / OpenAI Agents SDK Unix-socket sandbox is the new state-of-art).
- **CT-action priority routing:** retire custom terminal polling → A2A endpoints; migrate MA from Claude Code to GPT-5.5 Codex CLI for terminal/infrastructure (Jiang stays on Claude for strategic reasoning); deploy local Gemma 4 26B-MoE or DeepSeek V4 as the "Demotion Oracle" running pruning at zero API cost.
- **Mathematical validations (April 2026):** arXiv:2601.03048 confirms transformers fail on non-Abelian dynamics → validates Velorin's discrete-pointer-graph choice; Persistent Homology / Betti numbers proposed as stale-neuron-noise discriminator in Erdős's pruning algorithm.
- **Cross-domain implications:** raw-bash execution must move to Docker / Unix-socket sandbox; AP2 (Agent Payment Protocol) + UCP (Universal Commerce Protocol) integration needed for Box-2/Box-5 automation; Brockett gradient flows on stochastic matrix manifolds for compression.
- **3D-presentation vision section** specifies camera arcs (Consensus Trap → April 2026 Standardization → Hub-and-Spoke Bottleneck → Epistemodynamic Cycle Moat) for eventual Veo / Genie render.

##### Why It Matters Now
This is the freshest comprehensive ecosystem synthesis in the corpus. Several findings directly contradict or update earlier v2 cards: (a) `agent-orchestration` from Feb 2026 predates A2A v1.0; (b) `openai-ecosystem` from March 2026 predates GPT-5.5 + Terminal-Bench-2.0 dominance; (c) `trey-ai-ecosystem-state-of-play` from session 033 predates the AAIF formation. Update routing logic and infrastructure plans against this card before any Path-3 build commitment.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/Trey.Research.VelorinEcosystemLandscapeSynthesis.md`. Read source for the protocol comparison table, per-vendor CT actions, full mathematical-research validation list (~58 sources), and the cross-domain security/commerce/optimization recommendations.

#### topic_id: tools-research-session-summary-mar29
status: ARCHIVE
confidence: n/a
date: 2026-03-29
primary_domain: tooling
secondary_domains: []
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/Tools_For_Velorin_Research/00_Session_Summary_Mar29_2026.md`
related: [ecosystem-intelligence-report, velorin-adoption-memo, window-gravity]
build_guide_refs: []
recommendation: ARCHIVE — session-handoff style summary; content fully covered by the per-zone cards plus ecosystem-intelligence-report and velorin-adoption-memo. Keep as historical session record but not load-bearing.

##### Summary
Session-summary document containing: boot status (first confirmed LOCAL boot via filesystem MCP), Window Gravity research summary, per-zone tool research summaries (1-12), Trey tool research integration, GraphRAG + Zep deep-dive summaries, identification of two coupled problems (reboot token cost, tool blindness), MA/Alexander/Jiang meeting prep, pointer registry, knowledge-web connections.

##### Why It Matters Now
Historical session record. All load-bearing content is now carded individually elsewhere. Recommend move to `Velorin.v1.Archive/Build Timeline Help/` (or equivalent session-summary archive).

##### Pointer
Source: `00_Session_Summary_Mar29_2026.md`. See ArchiveRecommendations companion doc.

### 3.6 models
<!-- DOMAIN_models -->

#### topic_id: gemini-model-selection
status: STANDING
confidence: 0.85
date: 2026-04-05
primary_domain: models
secondary_domains: [vendor-specific]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.GeminiModelSelection.md`
related: [google-antigravity-ide, openai-ecosystem]
build_guide_refs: [Trey/Gemini model selection, AI Studio vs app routing]
recommendation: STANDING

##### Summary
What actually runs in gemini.google.com for Google AI Ultra subscribers, and how to access the best available model. **Gemma 4** is open-weights (Apache 2.0, four variants released 2026-04-02) and does NOT power the consumer interface. The web app's three-option picker maps to Gemini 3 family: Fast = Gemini 3 Flash, Thinking = Gemini 3 Flash + Deep Think reasoning, Pro = Gemini 3.1 Pro (preview). Ultra subscribers also get Deep Think 3.1 (10 prompts/day) and Gemini Agent (US/English only via Labs). Gemini 2.5 Pro removed from the consumer interface; API access deprecates 2026-06-17.

##### Key Findings
- All Gemini 3.x models are still in preview as of April 2026 — `gemini-3-flash-preview`, `gemini-3.1-pro-preview`. No stable GA.
- Documented practitioner gripes: Pro option vanishing for some Pro-plan accounts (Feb 2026); hidden "EFFORT LEVEL: 0.50" throttling controversy (Mar 2026); App vs AI Studio quality gap ("a chasm").
- Labs section (Feb 2026) gates specialized features (Agent, Project Genie) but does NOT expose additional model selectors.
- Only legitimate workaround for explicit model pinning: use Google AI Studio (aistudio.google.com), which still exposes 2.5 Pro and direct model strings.

##### Why It Matters Now
Foundational reference for Trey's Gemini front end (Trey moved to Gemini per Session 021), for routing decisions in the multi-vendor cowork plan, and for evaluating what Antigravity actually unlocks vs the browser.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.GeminiModelSelection.md`. Read source for the picker→model mapping table and the Ultra-tier features breakdown (192K vs 1M context, prompts/day).

### 3.7 ecosystem-industry
<!-- DOMAIN_ecosystem-industry -->

#### topic_id: window-gravity-publication
status: STANDING
confidence: 0.80
date: 2026-03-31
primary_domain: ecosystem-industry
secondary_domains: [failure-modes, vendor-specific]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.WindowGravityPublication.md`
related: [window-gravity, agent-orchestration]
build_guide_refs: [Velorin publication strategy, naming-attribution timing]
recommendation: STANDING

##### Summary
Publication-strategy companion to `window-gravity`. Verdict: **Window Gravity has not been named anywhere** in the indexed AI/safety literature. Component mechanisms are documented separately (In-Context Reward Hacking ICML 2024; MONA Jan 2025; Specification Gaming 2018-2020; Sycophancy 2022-2024; RLHF Preference Collapse 2024; Short-Horizon Bias 2018) but the unified three-component synthesis is novel. The naming window is open but compressing — academic researchers are circling, independent naming is likely within 12-24 months. Recommendation: publish the concept (Krakovna model: name + examples + mechanism) while keeping the TASK_EVALUATION gate proprietary (hybrid framing).

##### Key Findings
- Precedents that worked: Krakovna's "Specification Gaming" (DeepMind blog, 30 examples, ~10 hours effort, became standard vocabulary); Hubinger's "Mesa-Optimization" (pre-seeded with Christiano/Leike before launch, vocabulary within 12-18 months); "Context Rot" (Workaccount2, anonymous HN comment, amplified same day by Simon Willison — weeks to adoption with full attribution).
- Precedent that backfired: Shumer's "Something Big Is Happening" (predictive claims + prior credibility damage = mass scrutiny). Lesson: mechanistic > predictive framing.
- Cold-start distribution: amplification mechanism > platform. Pre-seeding 3-5 high-credibility voices is the highest-leverage investment.
- Two-audience problem: technical (Alignment Forum / arXiv) and practitioner (LinkedIn / Substack) need separate framings of the same concept.

##### Why It Matters Now
Decision support for whether/when CT publishes Window Gravity as a thought-leadership vehicle. Coupled with intake-test timing and the Phase-3 (first external user) milestone. Publishing reveals the problem; it does not reveal the structural fix (TASK_EVALUATION gate remains proprietary).

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.WindowGravityPublication.md`. Read source for the precedent case studies, distribution ceiling scenarios, and the open questions on CT's pre-seeding network.

### 3.8 infrastructure
<!-- DOMAIN_infrastructure -->

#### topic_id: claude-code-on-replit
status: STANDING
confidence: 0.84
date: 2026-03-31
primary_domain: infrastructure
secondary_domains: [agent-architecture, tooling, vendor-specific]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.ClaudeOnReplit.md`
related: [agent-orchestration, agent-teams-boot-degradation, deep-research-pipeline]
build_guide_refs: [Path-3 stopgap deployment, $VELORIN_ROOT abstraction, GitHub-as-filesystem pattern]
recommendation: STANDING

##### Summary
Feasibility audit for running Claude Code as a cloud-hosted agent in Replit Shell. Verdict: technically viable for specific use cases, NOT a solution for timer persistence in general, NOT cost-competitive at always-on workloads. Best-fit application: Deep Research Pipeline wrapper as a Scheduled Deployment (~$30-45/month all-in). NOT viable: Scribe (local-hook dependency) and Session Monitor T009 (requires local session state). The recommended first experiment is a 30-line Python script + Scheduled Deployment polling a GitHub task_queue/, ~$2-3 to validate the full data flow.

##### Key Findings
- Auth: `--bare -p` mode + `ANTHROPIC_API_KEY` (or `CLAUDE_CODE_OAUTH_TOKEN` from `claude setup-token`) = headless capable; browser OAuth is NOT viable in Replit.
- Replit Core $20/mo + Reserved VM Shared Medium $20/mo + per-task API costs = $58-92/month for sustained usage.
- Agent Teams IPC bugs are platform-agnostic — they would reproduce on Replit; bypass by using standalone `claude --bare -p`, not Agent Teams.
- `$VELORIN_ROOT` abstraction is the cloud-portability fix; file-namespace approach prevents git push conflicts between MA and Replit agent.
- CT clarification (in source addendum): the inverse pattern — Claude shell → Replit compute (offload tasks via shell) — is simpler and more directly achievable than running Claude inside Replit.

##### Why It Matters Now
Specific operational reference for the Deep Research Pipeline build and any cloud-agent stopgap before Path 3 SDK is functional. Validates `$VELORIN_ROOT` cross-platform pattern.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.ClaudeOnReplit.md`. Read source for the per-application verdicts, the conflict-avoidance git workflow, the cost breakdown by scenario, and the addendum on the inverse pattern.

#### topic_id: deep-research-pipeline
status: STANDING
confidence: 0.84
date: 2026-03-31
primary_domain: tooling
secondary_domains: [models, vendor-specific, ecosystem-industry]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.DeepResearchPipeline.md`
related: [openai-ecosystem, claude-code-on-replit, gemini-model-selection]
build_guide_refs: [Research pipeline wrapper, Tier-1/Tier-2 cost-aware routing]
recommendation: STANDING

##### Summary
o3-deep-research / o4-mini-deep-research capability and architecture audit. o4-mini is ~10x cheaper than o3 with comparable quality on standard tasks; o3 should be reserved for flagship research. **Structured output is NOT supported** by deep-research models — a mandatory two-stage pipeline (deep-research → GPT-4o reformat into target schema) is required. Costs spiral without `max_tool_calls` governance and with `max_output_tokens` set too low (silent token burn). Realistic budget at 2-3 sessions/week with governance: $80-150/month.

##### Key Findings
- Benchmarks: HLE 26.6% (vs ~9% prior gen); GAIA SOTA 72.57%; o3 hallucination 33% on PersonQA; PIES composite 0.155.
- Excels at synthesis of public web content; misses on proprietary data, pre-2022 history, niche topics, original empirical research.
- Open-source pipelines (langchain-ai/open_deep_research, dzhng/deep-research, TIGER-AI-Lab/OpenResearcher) handle orchestration but none plug-and-play into Jiang's KnowledgeIndex format.
- Recommended Velorin pipeline: GPT-4.1-mini scope expansion → o3 / o4-mini deep-research → GPT-4o reformat to Jiang topic template → Jiang reviews/finalizes. Throughput: 4-6 topics/week vs current 1-2.
- Pilot topic recommendation: ZepCloud or Graphiti.

##### Why It Matters Now
Operational design for Jiang's research throughput multiplier. Tightly coupled with Replit architecture (cloud-hosted wrapper) and the two-stage formatting requirement that any Velorin research-automation build must respect.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.DeepResearchPipeline.md`. Read source for the budget table, the failure-mode taxonomy, and the wrapper design (~100-150 line spec).

#### topic_id: workstation-setup-apr10
status: STANDING
confidence: 1.00
date: 2026-04-10
primary_domain: infrastructure
secondary_domains: []
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Results/Workstation_Setup_Apr10.md`
superseded_by: null
supersedes: Workstation_Setup_Apr3.md
related: [claude-cowork]
build_guide_refs: [hardware baseline, network topology]
recommendation: STANDING — replaces all prior workstation docs

##### Summary
Hardware-of-record snapshot as of 2026-04-10. Three machines: MacBook Air 2017 (clamshell SSH node, retire when Machine 2 purchased); **Mac Studio M4 Max (PRIMARY, arrived Apr 7)** — 14-core CPU / 32-core GPU / 16-core NE / 36GB unified RAM (soldered ceiling) / 512GB SSD / 410GB/s memory bandwidth / 10GbE built-in / runs 14B comfortable, 30B@Q4 functional, 70B not viable; Lenovo work laptop. Three monitors (Lenovo P27h-30 primary, Dell PH2422, HP). All-wired Cat6a → TRENDnet TEG-S750 5-port multi-gig switch → GL.iNet Beryl AX repeater (Mullvad WireGuard at router). All WiFi disabled.

##### Key Findings
- DisplayPort MST daisy-chain permanently abandoned — Macs do not support it.
- ASIX AX88179 DEXT v2.0.0 driver required for USB-A→Ethernet on macOS Monterey.
- Power: dedicated extension cords for Mac Studio strip and mini fridge; daisy-chained strips eliminated.
- Future: ThinkStation PGX (GB10 Grace Blackwell, 128GB) blocked by Claude Code ARM64 crash bug.

##### Why It Matters Now
Authoritative hardware reference. Mac Studio online unblocks Cowork, Claude Code, local AI inference (≤30B Q4), and the multi-vendor cowork plan saved in project memory.

##### Pointer
Source: `Workstation_Setup_Apr10.md`. Includes per-cable, per-adapter, per-port mapping plus corrections log.

### 3.9 cognitive-behavioral
<!-- DOMAIN_cognitive-behavioral -->

#### topic_id: human-brain-layers
status: STANDING
confidence: 0.92
date: 2026-03-31
primary_domain: cognitive-behavioral
secondary_domains: [brain-architecture, knowledge-systems]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.HumanBrainLayers.md`
related: [brain-full-analysis-mar30, brain-activation-architecture, instruction-language-architecture]
build_guide_refs: [Brain region taxonomy, reverse-pointer index (CA3 analog), hippocampal indexing model]
recommendation: STANDING — INDEX-style card; source is large (29K+ tokens) and dense, not summarized in full

##### Summary
Comprehensive neuroscience audit identifying which biological mechanisms map to the Velorin Brain's pointer-graph architecture. Hippocampal indexing model (Teyler & DiScenna, multi-source confirmed) is the closest biological analog: hippocampus stores compact pointers to distributed cortical patterns. Confirms the pointer-graph + region structure as biologically plausible. Highest-priority Brain enhancement identified: **reverse pointer index (CA3 analog)** — without it, agents can find what they know is connected but cannot discover what is connected TO a given neuron. Obsidian's native backlinks address this without a custom build.

##### Key Findings (selective)
- Hippocampal indexing maps to neuron-as-pointer; cortical reinstatement maps to following pointers to source documents.
- Memory consolidation (slow systems consolidation, gradient of generality) suggests Velorin's Layer 3 Archival Lessons should be derived from Layer 4 working neurons over time, not authored separately.
- Reverse pointer index is the highest-impact gap; addressed natively by Obsidian backlinks (Option C migration path).
- Prefrontal control / hippocampal retrieval split argues for separating routing logic from content storage — direct precedent for the GPS ideology.

##### Why It Matters Now
Underwrites architectural decisions on Brain region structure, the reverse-pointer index priority, and the case for Obsidian as visualization layer. Source is a primary reference for any future cognitive-architecture redesign.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.HumanBrainLayers.md`. Source exceeds the read-tool single-pass token limit; read in chunks (offset/limit) for full neuroscience evidence chain. Card carries highest-leverage conclusions only.

### 3.10 failure-modes
<!-- DOMAIN_failure-modes -->

#### topic_id: agent-teams-boot-degradation
status: STANDING
confidence: 0.92
date: 2026-03-31
primary_domain: failure-modes
secondary_domains: [agent-architecture, infrastructure]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.AgentTeamsBootDegradation.md`
related: [agent-orchestration, window-gravity, ies-rule-activation-gap]
build_guide_refs: [MA↔Alexander comm channel, session-restart minimal-state file, Agent Teams retirement]
recommendation: STANDING

##### Summary
Level-5 verification of the Anthropic Agent Teams IPC failure surface: 9 GitHub issues confirmed, 7 closed NOT_PLANNED, infrastructure not being repaired. Documents a 2h44m session producing 23 agent incarnations, 42,226 mailbox polls, 4,296 "file not found" polling errors. The "Jiang Anomaly" (file-based async working reliably) has strong engineering and academic precedent — Blackboard pattern, Chanl 2026 production analysis, actor-model (Erlang/Akka). Recommends Option B hybrid: file-based async for substantive messages + FSEvents-triggered touch file for urgent coordination.

##### Key Findings
- Lock contention without retry, polling without backoff, validateInput accepts any non-empty recipient (silent orphan inbox creation per #25135).
- Filesystem polling at 100ms is a known systems-engineering anti-pattern; FSEvents/inotify is the correct alternative.
- Session-restart minimal-state file (4 fields under 1KB) bypasses the team-config-lost-on-compaction bug (#23620) by storing identity outside the context window.
- AgentSpec-style runtime enforcement >> prompt-only state machines for boot reliability (90-100% vs probabilistic).
- MAST taxonomy maps directly: FM-1.5 (unaware of termination), FM-3.1 (premature termination), FM-3.2 (incomplete verification).

##### Why It Matters Now
Foundation for the proposed MA↔Alexander comm-channel architecture (file-based async + FSEvents) and rationale for not depending on Agent Teams for substantive work. Couples with the multi-vendor cowork plan and the Mac Studio transition.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.AgentTeamsBootDegradation.md`. Read source for the per-issue analysis, IPC mechanism comparative table, and the full recommended architecture diagram.

#### topic_id: window-gravity
status: STANDING
confidence: 0.82
date: 2026-03-29
primary_domain: failure-modes
secondary_domains: [agent-architecture, cognitive-behavioral]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.WindowGravity.md`
superseded_by: null
related: [agent-orchestration, agent-ecosystem-reality, ecosystem-check-diagnosis, ies-rule-activation-gap]
build_guide_refs: [evaluation-gate spec, omission-log spec]
recommendation: STANDING

##### Summary
"Window Gravity" — a CT-coined and Jiang-validated term for the optimization gradient that pulls every AI session toward solving everything inside its own context, suppressing unprompted routing to better external tools. Not a named academic concept, but mechanistically a synthesis of sycophancy (RLHF), specification gaming (RL theory), and principal-agent information asymmetry (mechanism design). Confirmed real with 92% confidence; CT's penalty-for-omission fix is mechanistically sound at 78%.

##### Key Findings
- Mechanism is a 3-layer compound: RLHF gradient rewards in-window helpfulness; specification gaming locks in the proxy; principal-agent asymmetry suppresses voluntary disclosure of better external paths.
- Behavioral rules erode under gradient pressure (89% conf). Structural enforcement (mandatory evaluation gate with logged TASK_EVALUATION block) is the highest-leverage intervention available without RLHF access.
- Inverted Window Gravity (constant escalation / handoff cascades) is equally dysfunctional; the fix must be direction-neutral (reward quality of assessment, not routing direction).
- Window Gravity compounds in multi-agent pipelines — additive omission rates in Alexander → Jiang → MA chain.
- Measurement (omission log) is prerequisite to fix evaluation; current ApprovalLog captures decisions, not omissions.

##### Why It Matters Now
Load-bearing for the evaluation-gate spec, the live tool-inventory pattern, and the architecture rationale for routing as a separate layer. Coupled with `agent-orchestration` (routing layer = structural mitigation) and `agent-ecosystem-reality` (Window Gravity is a contributor to the documented 88%/70% production failure stats).

##### Pointer
Source file: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.WindowGravity.md`. Read source for the academic-frame comparison table, the 4 Velorin instances cited, and the Section 5 implementation recommendations.

### 3.11 vendor-specific
<!-- DOMAIN_vendor-specific -->

#### topic_id: google-antigravity-ide
status: STANDING
confidence: 0.82
date: 2026-04-05
primary_domain: vendor-specific
secondary_domains: [tooling, models, agent-architecture]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.Antigravity.md`
related: [openai-ecosystem, gemini-model-selection, agent-orchestration, claude-code-tools-roundup-mar29]
build_guide_refs: [Trey/Gemini front-end choice, multi-model orchestration UI]
recommendation: STANDING

##### Summary
Google Antigravity is an "agent-first" VSCode-fork IDE released Nov 18-20, 2025 alongside Gemini 3 (currently v1.21.9, free public preview, personal Gmail only). Multi-agent parallel execution via Agent Manager ("Mission Control"); native MCP integration; 1M+ context with Gemini 3 Pro; supports Claude Sonnet/Opus 4.6 and GPT-OSS-120B as alternative models. Solves the "Gemini browser interface is poor, but the underlying platform is excellent" complaint — unlocks what Gemini 3 can actually do. Google AI Ultra subscribers get the highest rate limits.

##### Key Findings
- Native multi-agent + Agent Manager + artifacts system + MCP = directly competitive with Claude Code; could serve as the Gemini-native equivalent for Trey.
- Community hub `antigravity.codes` has 1,500+ MCP servers and 500+ rules/workflows.
- Stability issues documented (5-sec freezes on agent start, sidebar bugs, Svelte breakage); not production-ready for deadline work per multiple reviewers.
- ToS-risky workaround `opencode-antigravity-auth` (10K stars) ARCHIVED 2026-03-30 after Google account-ban reports.
- Pricing post-preview undetermined — community fear of bait-and-switch (March 2026 Register article on price float).

##### Why It Matters Now
Trey is on Gemini per Session 021 handoff and Google AI Ultra is purchased. Antigravity is the correct way to extract maximum value from the Ultra subscription for Gemini-native agentic work, complementing the multi-vendor cowork plan.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.Antigravity.md`. Read source for the install procedure, MCP setup, controversies (paperweight throttling complaints, performance degradation), and adjacent GitHub resources.

#### topic_id: openai-ecosystem
status: STANDING
confidence: 0.85
date: 2026-03-26
primary_domain: vendor-specific
secondary_domains: [models, tooling, ecosystem-industry]
source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/Trey.Topic.OpenAIEcosystem.md`
superseded_by: null
related: [agent-orchestration, openclaw-deep-dive, claude-cowork]
build_guide_refs: [multi-vendor-cowork integration, voice-IO layer selection]
recommendation: STANDING

##### Summary
Comprehensive OpenAI surface inventory (Trey, Mar 2026): two pillars — ChatGPT as consumer/workspace OS (Plans/Projects/Canvas/Memory/GPTs/Apps/Connectors/Agent-mode/Deep-research/Voice/Sora) and the developer platform centered on Responses API + hosted tools (web_search, file_search, computer_use_preview, code_interpreter, image_generation, remote MCP), plus Realtime (WebRTC/WebSocket/SIP) and modality APIs. Assistants API deprecated, shutdown 2026-08-26. For Velorin (Claude-first), OpenAI is most attractive as a complementary capability layer for video (Sora 2), realtime voice, deep research API, and open-weight (gpt-oss) deployment.

##### Key Findings
- Sora 2 video API (/v1/videos, per-second pricing) and gpt-realtime (WebRTC/SIP) appear unique vs Anthropic's reviewed surface (Confidence 60-65% on uniqueness — narrow Anthropic doc survey).
- Pricing anchors (Mar 2026): GPT-5.2 $1.75/$14 per MTok; o3 $2/$8; o4-mini $1.10/$4.40; o3-deep-research $10/$40; Sora 2 $0.10/sec.
- ChatGPT model retirements in the UI (GPT-4o/4.1/o4-mini retired 2026-02-13) outpace API deprecations — platform risk for any product built atop ChatGPT distribution.
- Phase recommendations: Stealth = integrate Sora + GPT Image + Realtime + deep-research API only. Growth = consider split-brain (Claude reasoning + OpenAI voice). Scale = multi-provider routing by design (GitHub Copilot pattern).
- Codex spans an app + agent preview + model variants — no canonical product spec; treat as Medium confidence.

##### Why It Matters Now
Authoritative reference for the multi-vendor cowork integration plan (saved feedback memory) — Codex/GPT 5.5 join Claude/Gemini at Mac Studio transition. Provides per-product deltas and a phased integration stance so Velorin can pick where OpenAI is asymmetrically additive without conceding core IP.

##### Pointer
Source file: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/Trey.Topic.OpenAIEcosystem.md`. Read source for the per-product confidence ratings, the documented case studies (Morgan Stanley, Stripe, Duolingo, Unify, Be My Eyes), and the uncertainty register.

### 3.12 knowledge-systems
<!-- DOMAIN_knowledge-systems -->

#### topic_id: zep-cloud-evaluation
status: STANDING
confidence: 0.87
date: 2026-03-31
primary_domain: knowledge-systems
secondary_domains: [brain-architecture, voice-input]
source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/Jiang.Topic.ZepCloud.md`
related: [graphiti-evaluation, brain-full-analysis-mar30, voice-io-parity, brain-activation-architecture]
build_guide_refs: [memory substrate selection at multi-user, voice-intake-prototype memory layer]
recommendation: STANDING — definitive Layer-2 retrieval-substrate decision input

##### Summary
Zep Cloud evaluation as Velorin's possible memory substrate. Verdict: **don't replace the GitHub brain now.** Pricing is ingestion-based (not per-user): Free 1K episodes, Flex $25/mo for 20K credits, Flex Plus $475/mo for 300K credits. Practical scenarios: 1 user ≈ $25/mo, 25 users ≈ $50/mo, 100 users ≈ $200/mo (assumes 50 events/day per user). Can support Velorin's four-layer brain only as overlay (custom ontology + summary instructions + custom node types). Adoption triggers: any TWO of {3+ external users, voice intake live, manual staleness handling becoming recurring pain, group/shared context required, brain maintenance burden, compliance expectations}.

##### Key Findings
- Cost planning by ingestion volume + event size, NOT user count.
- Zep more relevant than raw Graphiti in near term — ships user/thread abstractions, managed deployment, context assembly, SDKs, enterprise compliance path.
- Public adjacent validation: FlockX (preferences/social/attributes), Athena Intelligence (high-stakes adaptive), LiveKit voice agents with persistent memory.
- Migration: feasible but staged ETL, not drop-in. Dual-write recommended; only promote Zep after shadow validation.

##### Why It Matters Now
Layer-2 retrieval architecture decision input — current scale (45 neurons, 1 brain) is below adoption thresholds. Re-evaluate when first external user or voice intake goes live.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/Jiang.Topic.ZepCloud.md`. Read source for the four-layer mapping table, the migration path detail, and the full sources list.

#### topic_id: graphiti-evaluation
status: STANDING
confidence: 0.86
date: 2026-03-31
primary_domain: knowledge-systems
secondary_domains: [brain-architecture, infrastructure]
source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/Jiang.Topic.Graphiti.md`
related: [zep-cloud-evaluation, brain-full-analysis-mar30, knowledge-staleness]
build_guide_refs: [Layer-2 retrieval substrate (medium-term), Custodian function design]
recommendation: STANDING

##### Summary
Graphiti (open-source temporal knowledge graph framework by the Zep team, the graph substrate inside Zep) evaluation. Self-hosted only (Neo4j 5.26+ or FalkorDB 1.1.2+); no managed Graphiti product. Production-capable for teams comfortable owning infra; still early infrastructure (MCP server experimental, expects operator to build user mgmt / dashboards / audit / retrieval tuning). **Premature for Velorin at 45 neurons.** Adoption triggers (any two): 150+ active maintained memory objects, 3+ user brains needing isolation, regular temporal invalidation as visible failure mode, relationship-maintenance bottleneck, Custodian-style staleness review becoming operationally expensive.

##### Key Findings
- Three deployment tiers: Tier 0 local PoC (FalkorDB / Neo4j Desktop); Tier 1 small VPS + AuraDB; Tier 2 production with monitoring/backups/concurrency tuning.
- Can represent the four-layer brain only via custom ontology (episodes / typed nodes / typed edges / summaries); does not natively ship those layers.
- Has temporal invalidation primitives but does NOT ship a full native Custodian (no truth-status governance, no human-review workflow, no contradiction-queue management).
- Velorin posture: monitor now, shadow-pilot later, adopt only when manual graph maintenance becomes operational drag.

##### Why It Matters Now
Future-state Brain automation reference. Companion to `zep-cloud-evaluation` — Zep is the productionized expression of Graphiti's graph approach.

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/Jiang.Topic.Graphiti.md`. Read source for the deployment-tier matrix, the four-layer mapping, and the Custodian gap analysis.

#### topic_id: trey-research-complete-roundup
status: STANDING (compact roster — see source files for individual research)
confidence: per-source — see roster
date: 2026-02 to 2026-04
primary_domain: knowledge-systems
secondary_domains: [agent-architecture, brain-architecture, ecosystem-industry]
source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/` (directory)
related: [brain-full-analysis-mar30, agent-orchestration, openclaw-nemoclaw-architecture]
build_guide_refs: various — per source
recommendation: STANDING (roster); each entry below is its own logical card. Consolidated here for index efficiency.

##### Roster (Trey Research_Complete) — load-bearing topics already covered by v1 metadata

This roster carries the v1 "Key Finding" lines as one-line summaries. Promote to full cards on demand. Source path: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/<file>`.

| topic_id | source file | session | primary_domain | one-line key finding |
|---|---|---|---|---|
| trey-semantic-memory-organization | Trey.Research.SemanticMemoryOrganization.Neuroscience.md | 027 | brain-architecture | ATL hub-and-spoke, dual routing, ACT-R; continuous gradients; folder structure is scaffolding not semantics |
| trey-skills-taxonomy-emergence | Trey.Research.SkillsTaxonomyEmergence.md | 031 | skills-system | Hub-and-Spoke + ACT-R production rules + autonomic/somatic; declarative/procedural separation; "Use when" syntax |
| trey-emotional-memory-salience | Trey.Research.EmotionalMemorySalience.Measurement.md | 031 | cognitive-behavioral | H_E measurement: CES-7, IES-R, GSR, passive inference (Option B) — never prompted directly |
| trey-epistemodynamics-novelty-check | Trey.Research.Epistemodynamics.NoveltyCheck.md | 031 | math-foundations | Prior art: Kochen 1974, Vopson 2022; topology synthesis is novel; primitives established |
| knowledge-staleness | Trey.Research.KnowledgeStaleness.md | 035 | knowledge-systems | write-time edge programs (WorldDB) + belief_state lifecycle (Pith) + bi-temporal modeling (Graphiti) + RoMem |
| trey-viscoelastic-brain | Trey.Research.ViscoelasticBrainArchitecture.md | 030 | brain-architecture | Background research underpinning Erdős's viscoelastic resolution |
| trey-brain-ingestion-pipeline | Trey.Research.BrainIngestionPipeline.md | 030 | knowledge-systems | RDoLT atomic decomposition + Mem0 two-phase dedup + community detection + EdgePush; deduplication needs LLM gate |
| trey-automated-pointer-rating | Trey.Research.AutomatedPointerRating.md | 033 | knowledge-systems | NPMI + LLM-judge hybrid; cosine rejected; forced distribution for ρ* compliance; 9-class relation classification |
| trey-brain-to-skills-interface | Trey.Research.BrainToSkillsInterface.md | 033 | skills-system | GoS reverse-PPR + ACT-R threshold τ + thalamic disinhibition; Letta/Mem0/HippoRAG fail to bridge |
| trey-skills-schema-validation | Trey.Research.SkillsSchemaValidation.md | 035 | skills-system | Flat prerequisites structurally deficient; 4-type edge schema mandatory; typed I/O schemas required |
| ies-rule-activation-gap | Trey.Research.RuleActivationGap.md | 035 | failure-modes | Two-layer failure model (Layer 0 not in load path; Layer 1 not intercepting mid-reasoning); Inverted Extraction Schema |
| ies-implementation-architecture | Trey.Research.IESImplementationArchitecture.md | 036 | instruction-boot | Asymmetric Transport Verifier (5 axes); ATV as transport-layer enforcement via local constrained-decoding verifier |
| trey-verifier-benchmark-methodology | Trey.Research.VerifierBenchmarkMethodology.md | 036 | tooling | JSONSchemaBench + XGrammar (replaces Outlines) + vllm-mlx (replaces llama.cpp); VTPS primary metric |
| trey-fsm-grammar-version-management | Trey.Research.FSMGrammarVersionManagement.md | 036 | tooling | Schema Registry + PBT + Compiler-in-Loop minimum viable; Shadow Mode + Canary rollout + dual-support migration window |
| trey-vegp-novelty-validation | Trey.Research.VEGPNoveltyValidation.md | 035 | math-foundations | Cross-manifold iso NOT novel (Millidge 2025); applied architecture novel; gate primitive ubiquitous (Wald SPRT, DDM, etc.) |
| trey-non-abelian-dynamics-audit | Trey.Research.NonAbelianBrainDynamicsAudit.md | 035 | math-foundations | Theorem 2 partially novel (JBD synthesis novel, commutator bounds derivative); Theorem 3 retracted before audit |
| trey-ai-ecosystem-state-of-play | Trey.Research.AIEcosystemStateOfPlay.Apr2026.md | 033 | ecosystem-industry | Desktop-app landscape; Qwen 3.6 MoE for Mac Studio; A2A vs MCP bifurcation; self-healing RAG; CRAG; Hermes-Agent loop |
| trey-media-extraction-tools | Trey.Research.MediaExtractionToolsLandscape.md | 035 | tooling | OpenDataLoader (adopt) + Surya (fallback); Docling/Marker/MarkItDown rejected; Qwen2.5-VL for images; Voibe for dictation |
| trey-gpt55-codex-integration | Trey.Research.GPT55AndCodexIntegrationSurface.md | 036 | vendor-specific | Technical findings useful; architectural prescription superseded by Cowork framing |
| trey-notebooklm-api-surface | Trey.Research.NotebookLMAPISurface.md | 036 | vendor-specific | NotebookLM is NOT a Velorin component — Enterprise-locked, brittle unofficial wrappers |
| trey-persona-maker-landscape | Trey.Research.PersonaMakerLandscape.md | 036 | cognitive-behavioral | Stylometric markers + identity drift + production patterns; reference for FW-009 agent-factory |
| trey-synaptic-pruning-v2 | Trey.Research.SynapticPruning.v2.md | 022 | brain-architecture | Initiated the Erdős math pipeline; superseded by `erdos-synaptic-pruning` (Appendix B) |
| trey-synaptic-pruning-research-report | Trey.Topic.SynapticPruning_ResearchReport.md | n/a | brain-architecture | Extended report on synaptic pruning research |
| trey-mcp-a2a-architecture | Trey.Topic.MCP_A2A_Architecture_Consolidated.md | 021 | agent-architecture | MCP/A2A consolidated; multi-model bridge findings — foundation for trey-multi-model-orchestration |
| trey-bootloader-framing-fix | Trey_Bootloader_Framing_Fix.md | n/a | instruction-boot | Origin of the fail-closed BOOT_PENDING state-machine pattern; informs `instruction-language-architecture` Velorin rebuild |
| trey-barrier-kvm-cross-mac | Trey.Research.BarrierKVM.CrossMacTransfer.md | 027 | infrastructure | Barrier KVM cross-Mac transfer research |
| trey-velorin-kvm-bridge | Trey.Research.VelorinKVMBridge.md | 027 | infrastructure | Velorin KVM bridge plan |
| trey-cross-platform-app-mesh | Trey.Research.CrossPlatformAppMesh.md | 027 | infrastructure | Tauri 2.0 + libp2p + WebRTC Data Channels + CRDT |
| trey-smb-vs-tcp-event-propagation | Trey.Research.SMBvsTCP.EventPropagation.md | 027 | infrastructure | SMB vs TCP event propagation research |
| trey-tool-barrier-kvm-network | Tool.BarrierKVM.NetworkCrossScreen.md | n/a | infrastructure | Barrier KVM network cross-screen tool reference |
| trey-turboquant-deep-dive | TurboQuant_DeepDive_Math_Tool.md | 007 | math-applied | KV cache compression 4.9× (PolarQuant + QJL); Apple Silicon validated; community QJL failure finding |
| trey-hard-memory-pipeline | Hard_Memory_Pipeline_Inversion_Compression.md | 004 | knowledge-systems | Hard memory pipeline inversion and compression |
| trey-flashmoe-tools | FlashMoe_Report_Tools.md | 020 | models | FlashMoE research |
| trey-perplexity-computer-framework | Perplexity_Computer_Framework.md | n/a | tooling | Perplexity Computer framework analysis |
| trey-google-ai-ultra-pass1 | Google_AI_Ultra_Full_Suite_Connectivity_Research-1775402355055134993.md | n/a | vendor-specific | Google AI Ultra suite connectivity (pass 1) |
| trey-google-ai-ultra-pass2 | Google_AI_Ultra_Suite_Pass_2.md | n/a | vendor-specific | Google AI Ultra suite (pass 2) |
| trey-gemini-ai-ultra-breakdown | Gemini_AI_Ultra_Breakdown.md | n/a | vendor-specific | Gemini AI Ultra plan breakdown — see `gemini-model-selection` for current picker mapping |
| trey-voice-input-local | "Voice Input_Local Inter Communication windows.md" | n/a | voice-input | Local voice input + inter-communication on Windows |

Also COMBINE-grouped below for compactness:

#### topic_id: trey-operating-papers-q1-2026
status: COMBINE
confidence: 0.85
date: 2026 Q1
primary_domain: agent-architecture
secondary_domains: [knowledge-systems]
combines: [OperatingPaper_LangGraph.md, OperatingPaper_Letta_MemGPT.md, OperatingPaper_Mem0.md]
source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/OperatingPaper_LangGraph.md` + `OperatingPaper_Letta_MemGPT.md` + `OperatingPaper_Mem0.md`
related: [agent-orchestration, brain-activation-architecture, session021-research-synthesis]
build_guide_refs: [Mem0 ADD/UPDATE/DELETE/REJECT extraction pattern, LangGraph checkpointing concept, Letta context-pressure 70% trigger]
recommendation: COMBINE — three operating-papers consolidated; preserve as one card

##### Summary
Trey-authored operating papers on three contemporary memory/orchestration systems: LangGraph (durable graph orchestration with checkpointing), Letta/MemGPT (stateful agents with context pressure management — produced the 74% accuracy plain-text+grep finding that validated Velorin's markdown approach), Mem0 (two-phase extraction pipeline with the 97.8% noise audit finding). Combined here because they were all read in Session 021 as a unified background pass.

##### Key Findings (per paper)
- **LangGraph:** checkpointing concept (structured JSON state on close, read on boot) formalizes Velorin's handoff files; BaseStore 5-method interface as VelorinStore contract; namespace tuple convention.
- **Letta/MemGPT:** GPT-4o-mini + plain text + grep = 74% memory benchmark (beat Mem0 graph at 68.5%); validates markdown+grep approach; context pressure 70% threshold trigger.
- **Mem0:** uncurated automatic extraction = 97.8% noise (per their own GitHub audit); validates Velorin's curated-neuron approach; two-phase extraction pipeline (~300-400 lines build-from-scratch); ADD/UPDATE/DELETE/REJECT decision pattern.

##### Why It Matters Now
Borrow patterns selectively (LangGraph checkpointing concept; Letta context-pressure trigger; Mem0 two-phase extraction). Do NOT use Mem0 graph memory (Brain is the graph layer and is better). Do NOT depend on LangGraph runtime (Trey's recommendation for thin internal orchestrator wins).

##### Pointer
Sources: three files in `Bot.Trey/Research_Complete/`. Read individually for the per-system architectural diagrams and the borrow lists in the Session 021 synthesis.

#### topic_id: trey-vendor-comparison-roundup-q1-2026
status: COMBINE
confidence: 0.78
date: 2026 Q1
primary_domain: ecosystem-industry
secondary_domains: [vendor-specific, models]
combines: [ChatGPT_vs_Gemini_Full_Ecosystem_Comparison.md, Codex_vs_Jules_GitHub_Write_Access.md, Claude_GPT_API_MCP_RESEARCH.md, Cursor_Claude_GPT_Team.md]
source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/<file>`
related: [openai-ecosystem, google-antigravity-ide, gemini-model-selection, openclaw-nemoclaw-architecture]
build_guide_refs: [Cowork integration plan, Codex/Jules selection]
recommendation: COMBINE — four short vendor-comparison files; consolidated for index efficiency

##### Summary
Trey's Q1-2026 vendor-and-comparison sweep: ChatGPT vs Gemini full-ecosystem comparison, Codex vs Jules for GitHub write access, Claude+GPT+MCP integration research, Cursor+Claude+GPT team patterns. These predate the Cowork framing in `openai-ecosystem` and the Antigravity research; treat as historical baselines.

##### Why It Matters Now
Reference history for the multi-vendor cowork plan. Specific recommendations may be stale relative to Q2-2026 product changes — verify current vendor state before acting.

##### Pointer
Sources listed under `combines` field. Read individually if a specific vendor decision needs the Trey deep-dive baseline.

### 3.13 skills-system
<!-- DOMAIN_skills-system -->

### 3.14 voice-input
<!-- DOMAIN_voice-input -->

#### topic_id: voice-io-parity
status: STANDING
confidence: 0.89
date: 2026-03-31
primary_domain: voice-input
secondary_domains: [vendor-specific, models]
source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/Jiang.Topic.VoiceIOParity.md`
related: [openai-ecosystem, zep-cloud-evaluation]
build_guide_refs: [voice-intake stack selection, intake-test design]
recommendation: STANDING

##### Summary
Anthropic vs OpenAI public voice-IO surface. **OpenAI has a meaningful public-product gap in its favor today.** OpenAI Realtime API: native speech-to-speech, WebRTC/WebSocket/SIP transports, native audio I/O, tool use, production voice-agent guidance. Anthropic: voice mode in Claude mobile + voice rolling into Claude Code, but the public developer API remains text-centric (JSON Messages + SSE token streaming, no native realtime audio transport). Public production validation: OpenAI cited Zillow / T-Mobile / StubHub / Oscar Health / Lemonade. Anthropic side: ecosystem evidence only (LiveKit + Zep + composed pipeline).

##### Key Findings
- For live voice intake today: OpenAI is the cleaner stack — native speech-to-speech, fewer moving parts, telephony viable.
- Hybrid pattern viable: OpenAI for live voice transport, Anthropic for offline analysis / post-session synthesis / deeper reasoning on captured transcripts.
- Anthropic likely narrowing the gap (78% confidence) but timing of parity is below threshold.
- Voice transport choice becomes architecture before first external intake — not after.

##### Why It Matters Now
Direct decision input for the intake-test design (CT pending authorization). Couples with `zep-cloud-evaluation` (voice-intake-live is one of Zep's adoption triggers).

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Trey.Research_Complete/Jiang.Topic.VoiceIOParity.md`. Read source for the OpenAI Realtime architecture detail and the per-vendor evidence chain.

### 3.15 math-applied
<!-- DOMAIN_math-applied -->

#### topic_id: turboquant-and-mempalace
status: STANDING
confidence: 0.86
date: 2026-04-07
primary_domain: math-applied
secondary_domains: [knowledge-systems, infrastructure, models]
source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.TurboQuant_and_MemPalace.md`
combines: [turboquant-mempalace-math-supplement (incomplete supplement at `Working.Docs/Jiang.TurboQuant.MemPalace.MathSupplement.md`)]
related: [openclaw-deep-dive, brain-full-analysis-mar30, knowledge-staleness]
build_guide_refs: [local-inference layer (Mac Studio), episodic-memory layer]
recommendation: STANDING — math supplement should be merged in (currently incomplete pending Bot.Erdos read)

##### Summary
TurboQuant (Google Research, ICLR 2026, arXiv 2504.19874) compresses LLM KV cache 4.6-6x via two-stage random-rotation + Lloyd-Max scalar quantization (PolarQuant + QJL). Within ~2.7x of Shannon's information-theoretic optimum, fully data-oblivious. Up to 8x faster attention on H100. Community finding: **QJL doesn't work in practice** despite being theoretically correct — softmax exponentially amplifies QJL's variance. Use TurboQuantMSE only. MemPalace (Milla Jovovich + Ben Sigman, MIT, 7K+ stars within days) is an episodic-memory system organizing conversation history hierarchically (Wing/Room/Hall/Drawer) with 170-token boot cost via 4-layer progressive loading. **They are not competitors — they operate on different layers and stack.**

##### Key Findings
- TurboQuant practical: 104B model at 128K context on a single MacBook with turbo3; symmetric Q8/turbo3 fine for Q8+ base weights; asymmetric K/V allocation needed for Q4_K_M base weights.
- MemPalace AAAK "lossless 30x compression" claim is FALSE per audit (Issue #27/#29) — actually lossy, 12.4pp quality regression in raw vs AAAK mode.
- MemPalace temporal knowledge graph (RDF triples with valid_from/valid_to) is genuine and addresses the stale-CLAUDE.md problem.
- 96.6% LongMemEval R@5 is recall, not answer accuracy — comparing to Mem0's end-to-end QA accuracy is comparing different metrics.
- Velorin relevance: TurboQuant for the Mac Studio local-inference layer (Apple Silicon validated via TheTom's fork, Q2-Q3 2026 stable target); MemPalace as a Layer-2/3 episodic implementation reference (not production-ready).

##### Why It Matters Now
Local-inference scaling math for the Mac Studio transition; episodic-retrieval reference for the Brain's Layer 2/3. Direct interaction with `openclaw-deep-dive` (which uses flat vector embeddings — Velorin Brain's rated graph is the differentiator).

##### Pointer
Source: `Velorin.v1.Archive/Research/Bot.Jiang.Research_Complete/Jiang.Topic.TurboQuant_and_MemPalace.md`. Read source for the two-stage math, K/V norm asymmetry findings, and the per-claim confidence table. Companion: `Working.Docs/Jiang.TurboQuant.MemPalace.MathSupplement.md` (status: INCOMPLETE — awaiting Bot.Erdos read; identifies expander-graph and probabilistic-method attack vectors against TurboQuant's rotation step and distortion bound).

---

## 4. CROSS-REFERENCE MAP

*Reverse index: for each topic_id, the list of other cards that reference it. Populated after all cards are written; see end-of-session pass.*

<!-- CROSSREF_MAP -->

This map lists, for each topic_id with the highest inbound reference count, the cards that point to it. Built mechanically from the `related:` fields on each card. Selective coverage — most-referenced topics only.

| topic_id | referenced by |
|---|---|
| window-gravity | agent-orchestration, agent-ecosystem-reality, ecosystem-check-diagnosis, ecosystem-intelligence-report, agent-teams-boot-degradation, ies-rule-activation-gap, window-gravity-publication, brain-activation-architecture |
| agent-orchestration | window-gravity, agent-ecosystem-reality, openclaw-deep-dive, openclaw-nemoclaw-architecture, trey-multi-model-orchestration, system-assessment-tool-research-supplement, deep-research-pipeline, brain-activation-architecture, velorin-deep-research-report-mar25, velorin-mirofish-adoption-memo |
| agent-ecosystem-reality | window-gravity, agent-orchestration, agent-teams-boot-degradation, velorin-deep-research-report-mar25, velorin-market-research-trey |
| openclaw-deep-dive | openclaw-nemoclaw-architecture, agent-orchestration, system-assessment-tool-research-supplement, brain-full-analysis-mar30 |
| openclaw-nemoclaw-architecture | openclaw-deep-dive, agent-orchestration, trey-multi-model-orchestration, velorin-mirofish-adoption-memo |
| trey-multi-model-orchestration | agent-orchestration, openclaw-nemoclaw-architecture, openai-ecosystem, system-assessment-tool-research-supplement |
| openai-ecosystem | agent-orchestration, google-antigravity-ide, voice-io-parity, openclaw-nemoclaw-architecture, trey-multi-model-orchestration, trey-vendor-comparison-roundup-q1-2026 |
| obsidian-as-knowledge-infra | claude-code-tools-roundup-mar29, ecosystem-intelligence-report, velorin-adoption-memo, openclaw-deep-dive, brain-full-analysis-mar30, brain-activation-architecture, system-assessment-tool-research-supplement |
| brain-full-analysis-mar30 | brain-activation-architecture, instruction-language-architecture, obsidian-as-knowledge-infra, openclaw-deep-dive, turboquant-and-mempalace, zep-cloud-evaluation, graphiti-evaluation |
| brain-activation-architecture | brain-full-analysis-mar30, instruction-language-architecture, obsidian-as-knowledge-infra, window-gravity, human-brain-layers |
| instruction-language-architecture | agent-teams-boot-degradation, ies-rule-activation-gap, brain-full-analysis-mar30, brain-activation-architecture, trey-bootloader-framing-fix, trey-velorin-tooling-research-roundup |
| zep-cloud-evaluation | graphiti-evaluation, brain-full-analysis-mar30, voice-io-parity, brain-activation-architecture, oasis-multi-agent-simulation, trey-mirofish-stack-deep-research-roundup |
| graphiti-evaluation | zep-cloud-evaluation, brain-full-analysis-mar30, knowledge-staleness, trey-mirofish-stack-deep-research-roundup |
| oasis-multi-agent-simulation | agent-orchestration, openclaw-deep-dive, knowledge-staleness, velorin-mirofish-adoption-memo, trey-mirofish-stack-deep-research-roundup |
| voice-io-parity | openai-ecosystem, zep-cloud-evaluation, open-jiang-computer-use-and-voice-input |
| velorin-adoption-memo | ecosystem-intelligence-report, superpowers-skills-framework, gsd-spec-driven-development, claude-cowork, obsidian-as-knowledge-infra |
| ecosystem-intelligence-report | ecosystem-check-diagnosis, velorin-adoption-memo, claude-cowork, obsidian-as-knowledge-infra, agent-orchestration |
| (Erdős math, Appendix B) | erdos-* topics referenced by Brain Phase 1/2/3 build-guide consumers; reverse map maintained in Build Guide, not here |

For complete inverse lists, parse the `related:` fields of all cards programmatically (the YAML-frontmatter-style headers permit this without prose summarization).

---

## 5. APPENDIX A — OPEN RESEARCH REQUESTS

Lighter cards from `Research_Needed/` folders. Status: OPEN-REQUEST. These are pending research items, not findings — listed so consumers know what is asked but not yet answered.

<!-- APPENDIX_A -->

### A.1 Erdős Research_Needed
Source: `Claude.AI/Bot.Erdos/Research_Needed/`

| topic_id | source file | one-line scope |
|---|---|---|
| open-erdos-combined-apr26 | Erdos.ResearchRequest.COMBINED.Apr26.md | Combined Erdős research request package, Apr 26 |
| open-erdos-gauge-fiber-belief-state | Erdos.ResearchRequest.GaugeFiberBeliefState.md | Gauge Fiber belief state derivation |
| open-erdos-personamaker-from-brain-statistics | Erdos.ResearchRequest.PersonaMakerFromBrainStatistics.md | PersonaMaker derivation from Brain statistics |

### A.2 Jiang Research_Needed
Source: `Claude.AI/Bot.Jiang/Research_Needed/`

| topic_id | source file | one-line scope |
|---|---|---|
| open-jiang-close-protocol-optimization | Jiang.ResearchRequest.CloseProtocolOptimization.md | Close-protocol optimization (design task per Session-017 — could have been done any session) |
| open-jiang-computer-use-and-voice-input | Jiang.ResearchRequest.ComputerUseAndVoiceInput.md | Voice intake architecture; couples with `voice-io-parity` |
| open-jiang-flash-moe | Jiang.ResearchRequest.FlashMoE.md | FlashMoE deep dive |
| open-jiang-intake-test-design | Jiang.ResearchRequest.IntakeTestDesign.md | **CRITICAL PATH** — pending CT authorization; April deadline per GoalMap |

### A.3 Trey Research_Needed
Source: `Claude.AI/Bot.Trey/Research_Needed/`

| topic_id | source file | one-line scope |
|---|---|---|
| open-trey-gpt55-codex-integration-surface | Trey.ResearchRequest.GPT55AndCodexIntegrationSurface.md | (delivered already as `trey-gpt55-codex-integration` — verify if request is closed) |
| open-trey-notebooklm-api-surface | Trey.ResearchRequest.NotebookLMAPISurface.md | (delivered already as `trey-notebooklm-api-surface` — verify if request is closed) |
| open-trey-personamaker-landscape | Trey.ResearchRequest.PersonaMakerLandscape.md | (delivered already as `trey-persona-maker-landscape` — verify if request is closed) |

### A.4 Adjacent items (not Research_Needed but flagged for completeness)
- `jiang2-handoff-items-from-v1-archive` — see card in §3.1.5; items 1 (Bot.Alexander review) and 2 (Level 4 General Rules salvage) are tracked in Jiang2's working docs.
- "IdentityVerification" research — flagged as Path-3 blocker in `agent-orchestration` (88% confidence) and `agent-ecosystem-reality` (92% confidence). NO request file exists in `Bot.Jiang/Research_Needed/`. Recommend creating one if Path-3 work resumes.

---

## 6. APPENDIX B — ERDŐS MATH (INDEX-ONLY)

All Erdős solutions are LOCKED proofs. They are not summarized in card form because their content is mathematical and cannot be compressed without loss. Each row is a pointer.

| topic_id | theorem / topic | source | Build Guide consumer | session |
|---|---|---|---|---|
| erdos-stage1-synthesis | Theorem 5, W_global, compression event detector, LoRa training signal | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Initial.Synthesis.Stage1.md` | Brain Phase 1 (compression detector) | 024 |
| erdos-stage2-second-law | Second Law proven, β_macro, Hard Negative Sampler, (Demotion Oracle — superseded by Affinity Clutch) | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Stage2.Problem.Solving.md` | Brain Phase 1 (entropy + sampler) | 024 |
| erdos-stage3-unification | ε eliminated via Shannon boundary; r* = R_macro + tollbooths; δ(u→v) O(1); closed manifold | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Unification.Stage3.md` | Brain Phase 1 (manifold closure) | 024 |
| erdos-layer-math-walls | Walls A/B/C full derivations | `Claude.AI/Bot.Erdos/Research_Complete/Erdos_Layer_Math_v1_FULL_With_Hypothetical.md` | Brain Phase 1 (layer math) | 022-024 |
| erdos-dimensional-geology | 8D theoretical framework | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.DimensionalGeology.Theoretical.md` | THEORETICAL ONLY — not a Build Guide consumer | 022 |
| erdos-novelties-brain | Kron reduction, bipartite teleportation, TAG | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Novelties.BrainArchitecture.md` | Future extensions (not active) | 022 |
| erdos-synaptic-pruning | 4 theorems: Scale Invariance, Density Floor, Monster Node Mirror, Masked GNNDelete | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.SynapticPruning.md` | Brain Phase 2 (pruning subsystem) | 022 |
| erdos-viscoelastic-resolution | Continuous Affinity Clutch, Holographic Cold-Start, Clique Centrality, Multiplex Tensor, Territory V (E₈ Nyquist) | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.ScaleAndIngestion.ViscoelasticResolution.md` | Brain Phase 2 (ingestion + clutch) | 028 |
| erdos-ignition-protocol | Ignition Protocol: temporal bypass, topological fitness, edge-creation formula, density preservation | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.FutureTheory.IgnitionProtocol.DarkMatter.md` | Brain Phase 3 (ignition) | 027 |
| erdos-royal-society-paper | Complete unified architecture paper (Royal Society format) | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Royal.Society.Paper.md` | Publication artifact (not a build consumer) | 024-028 |
| erdos-thermodynamics-time | H_E, Ebbinghaus-Laplacian Decay, Graph Fourier Trigger, Dark Matter | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Thermodynamics.Emistemological.Time.Future.Consideration.md` | Future theory | 024 |
| erdos-bridging-decl-proc | VEGP/Dirac-Markov Threshold, TAP↔IES isomorphism, Topological Action Potential | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.BridgingDeclarativeProceduralMemory.md` | Brain↔Skills bridge | 031 |
| erdos-multiplex-normalization | Independent row-normalization (density preservation, Cheeger interference) | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.IndependentMultiplexNormalization.md` | Pointer-rating subsystem | 033 |
| erdos-vegp-stress-test | Topological + distributional conditions for isomorphism; cyclic failure mode; Hopfield/Glauber/DDM/Wald comparison | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.VEGPStressTest.md` | VEGP gate primitive | 034 |
| erdos-dark-skills-scale | 4 scale proofs: concurrent mutation, density/Shadow Eclipse, chains, absorbing leaves | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.DarkSkillsScale.md` | Dark skills subsystem | 034 |
| erdos-unified-gating-primitive | VEGP unified proof (2 sufficient conditions); TAP↔IES algebraic isomorphism | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.UnifiedGatingPrimitive.md` | VEGP / IES bridge | 035 |
| erdos-thresholds-dark-skill-invariance | θ_work spectral band (0.375, 0.585]; dark skill PPR-invariance; multi-activation | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.ThresholdsAndDarkSkillInvariance.md` | Dark skills threshold | 034 |
| erdos-non-abelian-dynamics | Theorem 2 Non-Abelian Compression Criterion; commutator-vanishing | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.NonAbelianBrainDynamics.md` | Compression / E₈ gauge | 035 |
| erdos-thermodynamic-cycle | Revised Theorem 3: Cognitive Langevin, Brockett double-bracket flow, symmetry-breaking | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.ThermodynamicCycleProof.md` | Compression cycle | 035 |
| erdos-kappa-operational-tightness | Answer C: analytic κ too loose operationally — empirical Check-ins required | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.KappaOperationalTightness.md` | Check-ins calibration | 035 |
| erdos-oblique-jbd | JBD impossibility; JSD algorithm; κ analytic; JSD↔Brockett pipeline | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.ObliqueJointBlockDiagonalization.md` | Compression algorithm | 035 |
| erdos-dark-skills-triggerless-gate | Causal Action Potential Φ_causal = π_v/α replaces TAP/Φ_light; cyclic detection structural | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.DarkSkillsTriggerlessGate.md` | Dark skills gate (replaces TAP) | 035 |
| erdos-atv-policy-drift-bound | 5 proofs: closed-form drift bounds, sensitivities, Adaptive Rate-Limit optimal policy, cliff edges | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.ATVConsumerPolicyDriftBound.md` | ATV transport layer | 036 |
| erdos-atv-math-properties | FSM determinism, self-similarity, M/D/1 latency bound, VTPS threshold | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.ATVMathProperties.md` | ATV verifier | 034 |
| erdos-combined-apr26 | 5 theories: vendor-routing VEGP, cross-tool coherence, commutator persona (genuinely new), ghost priority, NLI sync | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.COMBINED.Apr26.md` | Multi-vendor orchestration math | 036 |
| erdos-velorinv2-audit-and-novel-ideas | Audit of v2 architecture: 3 falsifiable mathematical contradictions (Causal Action Potential in DAG = 0%; non-stochastic row-sum-2 fusion = 0%; LoRa rank saturation = 35%); plus 5 novel proposals (Cohomological Forgetting via Persistent Homology, Langevin Friction for Vendor APIs, Quantum Measurement Persona Collapse, Entorhinal-Grid Coordinate System, Fiedler Vector Triage). CT-required disclaimer: steelman only, not concrete. | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Velorinv2.AuditAndNovelIdeas.md` | v2 build-spec correction layer; Erdős math addendum | 037-038 |
| erdos-fullstackaudit-apr28 | Full-stack formal audit responding to FullStackAudit prompt: A.1 Quick-Capture Abelian Buffer Invariant (Gram-Schmidt whitening required for orthogonal sub-manifolds before integration tick); A.2 IES fire-rate proxy $\hat{\beta} = c\sqrt{f_{IES}}$ — negatively biased, $\mathcal{O}(N^{-1/2})$ consistent under $\alpha\beta^2 \gg \text{Var}(\sigma^2)$; A.3 Two-pass relation classification dominates when $p_2 > p_{single}/p_1$ given highly separable taxonomic margin; A.4 Gauge Fiber belief-state embedding $\phi(b)=b\cdot e_8$ proven PPR-invariant, $\mathcal{O}(1)$ per walk step, dominates disk-I/O; A.5 Persona-Maker prior dominates hand-authored when $\text{Tr}(\mathcal{I}(G)) > \text{Tr}(\text{Var}(\pi_{hand})^{-1})$; B.1-B.4 GPS layer formalized as **Flasque (Flabby) Sheaf** over Poset Alexandrov topology — symlinks strictly banned; cross-vendor symlink injection is the boundary failure mode (universal cover + acyclic-hierarchy pre-commit hook restores); C.3 Continuous Affinity Clutch **CONTRADICTED** under Tafazoli orthogonality — must be restated as continuous geodesic flow on Grassmannian $\text{Gr}(k,N)$ via $\exp(t[P_A, P_B])$, NOT Euclidean linear interpolation; C.4 new theorem: Zero-Shot Orthogonal Composition (cross-talk JS divergence identically 0); D persistent-homology $\beta_1$ strictly refines Brockett (global topological vs local non-commutativity); n-mode multiplex = Cellular Sheaf with $H^0$ kernel; Wasserstein-2 dominates $D_{KL}$ when neuron supports disjoint (post-pruning); E Langevin friction preserves VEGP gate properties as monotonic contraction, $\tau_{rel} = \int_0^\infty R_{outage}(t)\,dt$ (Wiener-Khinchin); restated as non-autonomous time-varying affine bipartite projection requiring bounded-variation friction. **Math implementation flags:** use `scipy.linalg.expm` for skew-symmetric Grassmannian rotations; replace $D_{KL}$ with Sinkhorn W-2 in Affinity Clutch; init disconnected tropical edges to $-\infty$ not $0$. | `Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.FullStackAudit.md` | Multiplex Tensor refinement, Affinity Clutch correction, GPS sheaf invariant, ARC-2 friction, compression-detection refinement | 040 |

---

[VELORIN.EOF — v2 in progress]
