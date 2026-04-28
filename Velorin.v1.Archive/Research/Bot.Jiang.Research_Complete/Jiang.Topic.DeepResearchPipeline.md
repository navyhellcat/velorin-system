---
class: c-memory
type: research-output
request: Jiang.ResearchRequest.DeepResearchPipeline.md
date: 2026-03-31
confidence: see per-conclusion ratings
---

# Jiang.Topic.DeepResearchPipeline
Director of Strategic Intelligence | Velorin System
Research completed: March 31, 2026


## 1. RESEARCH PATHWAY

Entry point: OpenAI official documentation, OpenAI Cookbook, developer community forums. Cross-referenced with: benchmark studies (HLE, GAIA, DRB), hallucination taxonomy research (arxiv 2601.22984), independent cost analyses (Artificial Analysis, Simon Willison), open-source pipeline survey (GitHub), and builder community posts. Key directional shifts: initial assumption was that o3-deep-research would be the clear recommendation. Reality is more nuanced — o4-mini-deep-research costs 10x less with comparable quality on standard tasks; structured output requires a mandatory two-model pipeline; and the cost ceiling without `max_tool_calls` governance is dangerously high. The recommendation shifted toward a hybrid architecture.


## 2. CAPABILITY ENVELOPE — WHERE IT EXCELS AND WHERE IT MISSES

### Benchmark performance

**Humanity's Last Exam (HLE):** o3-deep-research scored 26.6% vs. o1/DeepSeek-R1 at ~9%. A 3x jump over prior models. Expert humans estimated above 50% — current AI still materially below that floor. (Model used web search during test; comparison to non-search models is imperfect.)

**GAIA Benchmark (multi-step real-world research):** Deep Research set new SOTA at 72.57%, up from previous top of 63.64%. Particularly strong on Level 3 tasks (complex multi-step synthesis).

**Deep Research Bench (91 real-world tasks, offline web snapshots):** LangChain's open_deep_research ranks #6 at RACE score 0.4344. GPT-5 scores 0.4943. Notably: ChatGPT o3 standard outperforms Deep Research mode on search-focused tasks within OpenAI's own family — meaning Deep Research isn't always the best tool even when you're already paying for OpenAI.

**Hallucination rates (PIES taxonomy study, arxiv 2601.22984):**
- OpenAI composite hallucination score: 0.155 (second-best across all tested systems)
- ~22% explicit claim fabrication rate
- >57% of source errors occur in the early stages — initial fabrications cascade downstream
- Near-best-in-class on constraint following (~4% restriction neglect)

**o3 hallucination on PersonQA benchmark:** 33% hallucination rate on OpenAI's own in-house accuracy benchmark — roughly double prior reasoning models. Specific failure types: fabricated quotes from real public figures, broken URLs, fabricated code tool outputs.

### Where it excels
- Synthesizing publicly available web content into coherent multi-source narratives
- Strategic/argumentative questions where breadth matters more than pinpoint accuracy
- Literature-style synthesis with 30+ footnoted citations in a single session
- Multi-step reasoning requiring sub-question decomposition
- Constraint following (near-best-in-class)
- Academic/technical questions where the answer is indexable on the public web

### Where it misses
- Quantitative analysis requiring real data access (SEC filings, academic paywalls, clinical data, patents)
- Questions requiring recent/live data not yet indexed
- Proprietary or internal knowledge not on the public web
- Historical research before ~2021-2022 (sources dry up; fabrication fills the gap)
- Highly specialized niche topics with thin web coverage (model confabulates confidently)
- Original empirical research (surveys, interviews, novel data collection)
- Cross-disciplinary systems engineering requiring genuine expert integration vs. surface synthesis

### Time profile vs. human
A skilled human researcher producing a multi-source, citation-rich brief: hours to days. o3-deep-research: 3–20 minutes. Speed advantage is real. Quality comparison: competitive with a competent analyst on publicly-known information synthesis. Not competitive for primary research or expert-level technical domains.


## 3. PROMPT STRUCTURES THAT PRODUCE BEST OUTPUTS

### Official OpenAI two-stage recommended workflow

**Stage 1 (optional but strongly recommended):** Use a lightweight model (GPT-4.1) to rewrite or expand vague queries before submission. Two variants: (a) auto-expand — lightweight model expands the query automatically, or (b) clarification first — ask necessary clarifying questions, then rewrite the refined response.

**Stage 2:** Submit the fully-formed, expanded prompt to o3-deep-research.

The API does NOT ask clarifying questions like the ChatGPT interface does. All preferences, dimensions, scope, and output format expectations must be in the initial prompt.

### Documented prompt best practices

**From OpenAI documentation:**
1. Specify desired source types directly: "Prioritize peer-reviewed research, official government sites, primary technical documentation"
2. Explicitly request tabular data when comparing multiple items — the model won't generate tables unless asked
3. Include inline citation instructions and source metadata requests
4. Set `reasoning={"summary": "detailed"}` for thorough reports vs. `"auto"` for standard
5. Use `max_tool_calls` to constrain cost and latency — this is the primary cost control lever
6. Set `max_output_tokens` to at least 50,000–100,000 — critically, setting it too low causes the model to burn 1M+ tokens in reasoning/search while producing zero final output

**From Ahmad Osman's 9-section builder framework (widely adopted):**
1. Objective & Core Questions
2. Context & Scope (concrete timeframes, e.g., "2021–2025," not "recent")
3. Key Terms & Definitions (precise terminology reduces confabulation in specialized domains)
4. Step-by-step research instructions (foundational → data → competitive → synthesis → recommendations)
5. Output Format & Structure (section headers, required tables)
6. Role/Perspective ("You are a Senior Industry Analyst at a Tier-1 consulting firm")
7. Justification & Sources (demand evidence-backed claims with credible citations)
8. Reasoning & Flexibility (mandate logical transparency; allow relevant tangential discoveries)
9. Quality Check (instruct self-review before outputting)

**Workflow note:** Use o3 or Gemini 2.5 Pro to refine scope before submitting. Treat scope specification like firewall rules — what's excluded matters as much as what's included.

**Key technical constraint:** o3-deep-research does NOT support OpenAI's structured outputs API. JSON schema compliance cannot be guaranteed from the model directly.


## 4. COST MODELING

### Official pricing (confirmed)

| Item | Cost |
|---|---|
| Input tokens | $10.00 / 1M tokens |
| Output tokens | $40.00 / 1M tokens |
| Cached input | $2.50 / 1M tokens |
| Web search calls | $10.00 / 1,000 calls ($0.01/call) |
| Code interpreter | $0.03 / session |
| Batch API discount | 50% off token costs |

### Real-world token consumption data

**Artificial Analysis (10 benchmark queries):**
- Average cost per query: ~$10
- Maximum observed: ~$30
- Comparison: o4-mini-deep-research for same 10 queries: $9.18 total (~$0.92/query)
- **o3 is ~10.9x more expensive than o4-mini per equivalent query**

**Simon Willison's measured session (single complex query):**
- Input tokens: 60,506 | Output tokens: 22,883 | Total: 83,389
- Web search calls: 77 × $0.01 = $0.77
- Total at o4-mini pricing: $1.10
- Equivalent at o3 pricing: ~$5–6
- Session activity: 17 thinking steps, 45 searches, 24 page visits, 12 code executions
- Final output: 90KB JSON

**Critical cost failure pattern (community forum):** Developer ran 5 test requests, consumed 6 million total tokens ($17 total). Individual requests hit 900K–1.5M tokens. Root cause: `max_output_tokens` set too low (16,000). Model burned massive input/reasoning tokens with no output. The vast majority of tokens are consumed by internal reasoning and web search context accumulation — not final output length.

### Monthly budget at 2–3 sessions/week

| Scenario | Sessions/Month | Avg Cost/Session | Monthly Total |
|---|---|---|---|
| Conservative (simple, tight scope) | 8 | $5 | ~$40 |
| Mid-range (standard research) | 10 | $10 | ~$100 |
| Heavy (complex multi-faceted) | 12 | $15–20 | ~$180–240 |
| Worst case (broad scope, no cap) | 12 | $30 | ~$360 |

Web search cost adds $5–10/session (~$50–120/month additional).

**Realistic mid-range with `max_tool_calls` governance: $80–150/month** for 8–12 sessions/month.

### Cost control levers
1. `max_tool_calls` — primary lever for cost/quality tradeoff
2. `max_output_tokens` — set to 50,000+ to avoid silent token burn
3. Use o4-mini-deep-research for simpler or iterative queries (~10x cheaper)
4. Batch API for non-time-sensitive research (50% token discount)
5. Cache repeated context (system prompt boilerplate) to reduce input token costs


## 5. OPEN-SOURCE PIPELINES AND WRAPPERS

### Production-grade

**langchain-ai/open_deep_research** — https://github.com/langchain-ai/open_deep_research
Active, updated 2025. 4-node pipeline: Search Agent → Summarization → Compression → Report Generation. Ranks #6 on Deep Research Bench (RACE 0.4344). Supports GPT-4.1, GPT-5, Claude Sonnet 4, OpenRouter, Ollama. Fully configurable per stage. Deployment: LangGraph Studio (local), LangGraph Platform (cloud), RESTful API.

**dzhng/deep-research** — https://github.com/dzhng/deep-research
"Simplest implementation of a deep research agent." Iterative web research combining search, scraping, and LLMs. Lower overhead. Good starting point for custom builds.

**TIGER-AI-Lab/OpenResearcher** — https://github.com/TIGER-AI-Lab/OpenResearcher
Full open pipeline for long-horizon research trajectory synthesis. Academic focus. arxiv 2603.20278.

**Prompt template collections:**
- langgptai/awesome-deep-research-prompts — templates for OpenAI, Gemini, Qwen deep research
- aref-vc/deep-research-prompting-guide — 50 business research templates across 5 domains

**None of the above are plug-and-play for Jiang's KnowledgeIndex format.** They handle orchestration and search; output formatting to a specific template requires a second model call regardless of which wrapper is used.


## 6. OUTPUT FORMAT

### Default output
Freeform markdown. Accessible via `response.output[-1].content[0].text`.

The full `response.output` array contains all intermediate steps as an ordered log:
- `"reasoning"` — internal planning summaries
- `"web_search_call"` — exact search queries executed
- `"code_interpreter_call"` — code execution records

Inline citations include annotation metadata: character indices (start/end), source title, URL. Programmatic bibliography generation is straightforward.

### Structured output gap
o3-deep-research does NOT support OpenAI's structured outputs API. JSON schema compliance is not guaranteed.

**Canonical two-stage pipeline (community-validated):**
1. o3-deep-research → markdown report with citations
2. GPT-4o or GPT-5-Pro → extract/reformat into target JSON schema

This is the correct architecture. Not a workaround — it is the documented production pattern.

### Output size
Typical final report: 5,000–15,000 words (dense, citation-rich prose). Output tokens for the final report are relatively small (~7,000) despite total session consuming 80K–1.5M tokens — the vast majority of token consumption is internal reasoning and web search context, not final output.


## 7. DOCUMENTED FAILURE MODES

**From PIES hallucination taxonomy (arxiv 2601.22984):**
- Strategic content fabrication (18.95% of generation failures): plausible but unfounded academic constructs, methods, data, narratives — mimics scholarly rigor
- Insufficient external information acquisition (16.3% of retrieval failures): single largest failure mode — agent fails to find what it needs but doesn't flag the gap; fills it instead
- Early-stage cascading failures: >57% of source errors occur in the first research phase; initial fabrications create dependency chains throughout the full report
- Temporal bias / Anchor Effect: agents disproportionately favor early search retrievals; later discoveries are dramatically underweighted
- Homogeneity bias: preference for redundant confirming sources over novel findings

**From independent analyst work (FutureSearch):**
- Overconfidence: reports wrong answers with same confidence as correct ones
- Source selection failures: prefers company blogs and SEO-spam over authoritative sources
- Outdated data used confidently with incorrect extrapolations

**Latency profile:**

| Mode | Typical Completion |
|---|---|
| o4-mini-high | Near-instant |
| o3 standard | ~1 min 25 sec |
| o3-deep-research | 3–20 min (complex queries 20 min+) |


## 8. ARCHITECTURE RECOMMENDATION FOR VELORIN

### The pipeline that makes sense

**Tier 1 — Standard research topics (competitive landscape, adoption curves, pricing, tool surveys):**
Use o4-mini-deep-research. ~10x cheaper than o3. Estimated $0.90–2/session. Reserve o3 for topics where depth and synthesis quality visibly matter.

**Tier 2 — Flagship research (strategic decisions, CT-specific implications, high-stakes topics):**
Use o3-deep-research with tight `max_tool_calls` (50–75 max) and `max_output_tokens` ≥ 50,000. Budget $10–20/session.

**Two-stage formatting layer (required for both tiers):**
1. o3/o4-mini-deep-research → markdown report with citations
2. GPT-4o (cheap, fast) → reformat into Jiang.KnowledgeIndex template structure

**Pre-processing stage (optional but recommended):**
GPT-4.1-mini or Claude Haiku → expand and scope the research request before submission. This is the official OpenAI recommendation and measurably improves output quality.

### What Jiang's domain judgment still provides that the pipeline cannot replace

The research is clear on this. o3-deep-research excels at synthesis of publicly available information. It does not:
- Apply CT-specific context (five-box governance, Velorin's specific build phase, CT's cognitive profile)
- Rate confidence with domain-aware weighting
- Identify what's missing from the public web and flag it
- Connect findings across Velorin's knowledge web
- Evaluate architectural fit for Velorin's specific situation
- Spot when a source is SEO-spam vs. authoritative (without explicit source specification)

The correct model: o3-deep-research handles the first-pass synthesis and source gathering (currently 60–70% of session time). Jiang reviews, applies CT-specific context, rates confidence, flags gaps, and writes the final topic file. **Throughput estimate: 4–6 topics/week instead of current 1–2, maintaining output quality.**

### What MA needs to build

A thin wrapper (~100–150 lines Python/Node.js):
1. Reads a research request file from `Research_Needed/`
2. Optionally calls GPT-4.1-mini to expand/scope the query
3. Submits to o3 or o4-mini deep-research via API with appropriate parameters (`max_tool_calls`, `max_output_tokens`, `reasoning` level)
4. Receives markdown output + citation annotations
5. Passes to GPT-4o for reformatting into a structured draft matching Jiang's topic file template
6. Writes draft to `Research_Needed/drafts/[topic].draft.md` for Jiang review

Jiang reviews the draft, adds CT-specific context and confidence ratings, and writes the final topic file. MA commits and pushes.

### Pilot recommendation

First topic to pilot: **ZepCloud or Graphiti** (now in Trey's Research_Needed). Standard competitive/landscape research — exactly what o3-deep-research does well. Low-stakes enough to evaluate quality. If output quality is sufficient with Jiang review, proceed to o4-mini-deep-research for all Tier 1 topics.


## 9. OFFICIAL CONCLUSIONS

| Question | Conclusion | Confidence |
|---|---|---|
| Is o3-deep-research capable for Jiang's use cases? | Yes for synthesis/landscape/survey. No for proprietary data, pre-2022 history, niche topics | 88% |
| Should o3 be the default model? | No — o4-mini-deep-research is the default. o3 reserved for flagship research | 82% |
| Monthly cost at 2–3 sessions/week | $80–150/month with governance. $360+ without it | 85% |
| Does a build-from-scratch pipeline make sense? | No — langchain open_deep_research handles orchestration. Custom work only for Jiang template formatting layer | 84% |
| Is structured output a problem? | Yes — requires mandatory two-stage pipeline. Not optional. | 97% |
| Does this replace Jiang's judgment? | No — handles first-pass synthesis only. CT-specific context, confidence ratings, knowledge web connections remain Jiang's domain | 95% |
| Realistic throughput improvement | 4–6 topics/week vs. current 1–2, maintaining quality with Jiang review | 72% |
| Pilot topic | ZepCloud or Graphiti — standard competitive landscape, low-stakes for quality evaluation | 80% |


## 10. OPEN QUESTIONS

- o4-mini-deep-research quality vs. o3 for Jiang's specific research types — not empirically tested. The 10x cost differential warrants testing before committing to o3 as default.
- `max_tool_calls` optimal value for a Velorin research session — needs empirical calibration. Start at 50, adjust based on output quality and cost.
- Latency handling — o3-deep-research can run 20+ minutes. MA's pipeline needs async architecture with background job pattern, not synchronous HTTP.
- Whether o3-deep-research API requires specific OpenAI tier access — not confirmed. Verify before MA begins the build.


## 11. KNOWLEDGE WEB POINTERS

- **Jiang.Topic.DeepResearchPipeline** ↔ **Jiang.Topic.AgentOrchestration** [5] — pipeline is an orchestration layer; same architectural patterns apply
- **Jiang.Topic.DeepResearchPipeline** ↔ **Jiang.Topic.TokenCostModel** [4] — o3/o4-mini pricing and session token costs feed directly into cost-of-goods model
- **Jiang.Topic.DeepResearchPipeline** ↔ **Jiang.Topic.IntakeTestDesign** [7] — if intake test design uses deep research for CT profile research, same pipeline applies

[VELORIN.EOF]
