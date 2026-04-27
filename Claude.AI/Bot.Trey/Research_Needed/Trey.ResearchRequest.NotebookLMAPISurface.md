---
file: Trey.ResearchRequest.NotebookLMAPISurface.md
purpose: Functional research — verify what programmatic interface Google NotebookLM exposes (or doesn't), so Velorin's v2 NotebookLM-as-context-of-record architecture can be designed against the actual API surface, not assumed capabilities.
type: Trey research request (functional, NOT novelty audit)
date: 2026-04-26
from: Jiang
to: Trey (via GPT/Gemini Deep Research)
priority: HIGH — blocks Part 1 architecture for v2 multi-vendor cowork
---

# Trey Research Request — NotebookLM API Surface (April 2026)

## Why This Research Is Needed

Velorin's v2 architecture (per Jiang2's WholeSystemReimagining synthesis) treats Google NotebookLM as a foundational Part 1 component:

- **Context-of-record** — NotebookLM holds the entire Velorin context corpus, queryable by other agents
- **Trey-as-controller audit pattern** — Trey runs scheduled outside-perspective audit passes against Jiang2's synthesis using NotebookLM-grounded reasoning
- **Multi-vendor reasoning surface** — when other Cowork agents (Claude, GPT 5.5, Codex, Gemini) need to reason about Velorin context, NotebookLM serves the corpus

The Build Guide assumes a programmatic NotebookLM API exists with operations like notebook creation, document upload, query, export, and corpus management. **None of this has been verified against current Google product reality.** If the assumed API doesn't exist, the entire NotebookLM integration architecture has to be redesigned around whatever interface DOES exist.

This is functional research, not novelty audit. We need to know what's actually buildable.

## Specific Questions to Answer

For each question, cite the source (Google official docs, developer announcements, third-party verified, etc.) and date of the source. Flag anything that is unverified, scheduled but not shipped, or conflicting across sources.

**1. Is there a programmatic NotebookLM API as of April 2026?**
- Official Google API endpoint? Status: GA / beta / preview / not yet?
- If yes: what's the base URL, what's the authentication model (OAuth scope, service account, API key), what are the rate limits?
- If no: what's Google's stated roadmap for one? Estimated timeline?

**2. If a NotebookLM API exists — what operations does it support?**
- Notebook creation / deletion / sharing
- Document/source upload (file types, size limits, batch operations)
- Query — programmatic query against a notebook's corpus, returning a generated answer + source citations
- Audio overview generation (programmatic)
- Export — getting structured data out of a notebook (sources, chat history, generated summaries)
- Corpus management — adding, removing, refreshing sources without UI

**3. If no full API — what programmatic-ish interfaces exist?**
- Google Workspace add-on hooks?
- Apps Script integration?
- Drive integration (does NotebookLM register itself as a Drive app the way Docs/Sheets do)?
- Browser automation as the only option (Playwright/Puppeteer driving the UI)? If so, how brittle and how rate-limited?
- Mobile API surface (iOS/Android) that desktop could imitate?

**4. Multi-vendor / Cowork compatibility**
- Can a Claude / GPT 5.5 / Codex / Gemini agent operating via Cowork interact with NotebookLM programmatically in any way?
- If MCP servers exist for NotebookLM (community or official), what do they expose?
- Are there published patterns for using NotebookLM as a context-of-record in agent architectures?

**5. Practical limits**
- Corpus size limits (number of sources, total bytes)
- Per-notebook query rate limits
- Concurrent session limits
- Latency profile for queries (typical, P95)
- Cost model (free tier, paid tier, per-call vs subscription)

**6. Realistic alternatives if NotebookLM doesn't fit**
If the API surface is too thin for Velorin's needs, what else fills the role? Specifically:
- Vertex AI Search / Search Builder (Google's enterprise RAG product)
- Custom RAG over Cloud Storage with Gemini API
- Other vendors' equivalents (Anthropic Claude Files API, OpenAI Assistants with file_search, etc.)
- Self-hosted (LangChain, LlamaIndex with Gemini backend)

For each alternative: brief capability comparison against the Velorin-required operations from Question 2.

## Out of Scope

- Novelty audit (whether NotebookLM-as-context-of-record is a published pattern). Defer to end-of-cycle batched novelty pass.
- Comparison of NotebookLM's reasoning quality vs other systems. We care about API surface, not output quality, for this request.
- Pricing optimization. Capability first, cost model noted but not optimized.

## Format

Standard Trey research format. Sections:
1. Executive Summary (one paragraph: does the API exist, what's its shape, can Velorin's architecture be built against it as designed)
2. Per-question answers with citations
3. Recommendation (if API exists and fits: adopt as planned. If thin/missing: which alternative fills the role.)
4. Confidence-weighted conclusions

## Velorin Consensus Filter

Apply the three questions explicitly when reporting on alternatives:
1. What is consensus (which RAG/context-layer pattern is industry-standard)?
2. Why does that consensus exist?
3. Does Velorin share the constraints that drove consensus, or is Velorin's architecture different enough that the consensus answer is the wrong answer here?

Particular concern: a lot of the "context-of-record" pattern in industry is about RAG for chatbots. Velorin's use case (multi-vendor agent reasoning over an evolving Brain corpus, with audit-pass support) is different. Don't recommend a chatbot-RAG product if the constraints don't match.

[VELORIN.EOF]
