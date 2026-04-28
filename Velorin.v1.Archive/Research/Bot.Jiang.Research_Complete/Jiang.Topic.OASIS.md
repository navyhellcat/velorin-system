---
class: c-memory
type: research-output
request: Jiang.ResearchRequest.OASIS.md
date: 2026-03-31
confidence: see per-conclusion ratings
---

# Jiang.Topic.OASIS
Director of Strategic Intelligence | Velorin System
Research completed: March 31, 2026


## 1. RESEARCH PATHWAY

Entry point: OASIS arXiv paper (2411.11581), GitHub repo, and production deployments. Cross-referenced with MiroFish architecture, BTC Fear & Greed production deployment, Stanford Generative Agents, and AgentTorch. Priority: deployability and personal-scale cost realism over academic framing. Key directional shift: initial assumption was that OASIS would be research-grade and impractical. Reality: it is pip-installable today, requires zero GPU for API-backed 100-agent simulations, and has been deployed in production for $0.70/run.


## 2. WHAT OASIS ACTUALLY IS

**Paper:** "OASIS: Open Agent Social Interaction Simulations with One Million Agents"
**arXiv:** https://arxiv.org/abs/2411.11581 — published November 19, 2024. Revised March 2025 (v4).
**Authors:** 23 researchers — CAMEL-AI.org, KAUST, Shanghai AI Laboratory, University of Oxford, and others.
**GitHub:** https://github.com/camel-ai/oasis — 3,990 stars, Apache 2.0, actively maintained.
**Install:** `pip install camel-oasis`

OASIS is a generalizable multi-agent simulation environment where each agent is an LLM instance with a persistent profile, memory of prior interactions, and 23 available action types (post, comment, like, follow, mute, search, interview, etc.). It was designed for social media simulation (Twitter/X and Reddit topologies) but is fully extensible via `custom_platform_simulation.py`.

**Five core modules:**
1. **Environment Server** — SQLite/Postgres database, 6 tables: users, posts, comments, relationships (follow/mute graph), traces (full action history), recommendations. Live stateful world — updates as agents act.
2. **RecSys** — TwHIN-BERT embedding similarity (Twitter mode) or time-decay hot-score (Reddit mode). Swappable.
3. **Agent Module** — Each `SocialAgent` receives: `UserInfo` object (name, MBTI, persona narrative, interested topics, 24-dimensional hourly activity vector), accumulated memory, and a fully customizable `TextPrompt` template.
4. **Time Engine** — 24-dimensional activity probability vector per agent. Agents activate at probabilistically scheduled timesteps, not all simultaneously. Prevents artificial synchrony.
5. **Scalable Inferencer** — vLLM GPU manager for large-scale runs. For API-backed models (OpenAI, DeepSeek, Anthropic), this module is bypassed in favor of async API calls. Personal-scale deployment uses this path exclusively.

**The INTERVIEW action** is the critical feature for decision rehearsal. At any timestep, an external actor can issue `ActionType.INTERVIEW` to any agent with a custom prompt and receive that agent's in-character response based on their full accumulated memory state. This is how a user probes synthetic stakeholders mid-simulation.

**Deployability verdict:** Fully deployable at personal scale today. No GPU required for 100-agent API-backed simulations.


## 3. MINIMUM VIABLE USE CASE — THE CAPABILITY THRESHOLD

### What single-prompt multi-persona approaches do
Prompting one LLM with multiple personas produces:
- Stateless responses — no memory across rounds
- No emergent influence — personas cannot change each other's positions through accumulated interaction
- No cascade dynamics — cannot observe how a message propagates and reshapes downstream agents
- No network effects — no follow/mute graph, no topology effects
- No independent action — all agents are reactive only

### Where the capability threshold actually activates
OASIS becomes the minimal sufficient tool when the scenario requires any of:

1. **Multi-round propagation** — A message introduced at T=0. By T=5, which stakeholders have seen it? Which resisted? Which amplified it?
2. **Opinion drift through interaction** — Agent A starts skeptical, sees two positive posts from followed agents, and shifts. Requires memory accumulation across steps.
3. **Population-level statistics** — "What fraction of my 100 stakeholder archetypes engaged positively?" requires actual counts.
4. **Herd dynamics and polarization** — Emerges at 100+ agents. Definitionally absent from single-agent prompting.
5. **Veto player identification** — Who in the population resists despite social pressure? The trace log surfaces these. Single prompting cannot.

### Capability threshold summary
- < 5 stakeholders, 1 decision, no interaction dynamics → Single-prompt Claude. No infrastructure.
- 5–20 stakeholders, 2–3 rounds, moderate interaction → Custom async loop or CrewAI. Minimal infrastructure.
- 20–100 stakeholders, 5–10 rounds, emergent dynamics → OASIS is the minimal sufficient tool.
- 100+ stakeholders, network topology effects, longitudinal drift → OASIS + GraphRAG memory (MiroFish architecture).


## 4. PRODUCTION DEPLOYMENTS

### MiroFish (primary production-tier reference)
**Repo:** https://github.com/666ghj/MiroFish
**Status:** Topped GitHub Global Trending, March 2026. Received investment from Shanda Group founder Chen Tianqiao.
Uses OASIS as simulation engine explicitly. Stack: GraphRAG (knowledge graph from seed documents) + Zep Cloud (agent memory) + OASIS (simulation runtime). Five-stage pipeline: Graph Building → Environment Setup → Simulation → Report Generation → Deep Interaction.
**Offline fork** (nikmcfly/MiroFish-Offline): Neo4j + Ollama, zero cloud dependencies. 32 GB RAM / 24 GB VRAM recommended. https://github.com/nikmcfly/MiroFish-Offline

### BTC Fear & Greed Index (cost-validated production run)
**Repo:** https://github.com/robin-ph/btc-fear-greed-index
500 OASIS agents (diverse investor personas) interact on simulated Reddit for 5 rounds. Output: panic contagion index weighted 60% OASIS simulation, 40% LLM sentiment.
**Actual production cost: ~$0.70 per full run (500 agents × 5 steps) using DeepSeek.**
This is the most important cost validation data point.

### OASIS Marketing Engine
**Repo:** https://github.com/ammar-ahmed22/oasis-marketing-engine
Iterative agent simulations to test viral potential of social posts before publishing. Personal-scale use case.


## 5. PROFILE-TO-AGENT-CONFIG PIPELINE

### Native OASIS agent profile fields
- `realname`, `username`, `age`, `gender`, `country`, `profession`
- `bio` (1–2 sentence public description)
- `mbti` (e.g., "ENTP")
- `persona` (2–4 sentence behavioral narrative)
- `interested_topics` (array of 2–3 topics)
- 24-dimensional hourly activity probability vector

### How a Velorin-style profile maps

| User Profile Element | OASIS Field | Notes |
|---|---|---|
| MBTI type | `mbti` | Direct field, native to OASIS |
| Decision patterns (risk tolerance, time horizon) | `persona` narrative | Embed as behavioral description |
| VCI / cognitive profile | `persona` narrative | Reasoning style, abstraction preference |
| Five-box governance role | `profession` + `persona` | E.g., "acts as operator/strategist" |
| Interest domains | `interested_topics` | Direct mapping |
| Custom prompt template | `user_info_template` | Full control via `TextPrompt` class |

The `custom_prompt_simulation.py` API allows fully custom prompts — construct a `SocialAgent` with a `TextPrompt` template and a `profile` dict containing any keys needed. This means a structured user profile dict (MBTI + VCI + governance model + decision patterns) can be passed directly with full control over how the LLM receives it.

**Research precedent:** The MBTI-in-Thoughts (MiT) framework (2025) confirms LLMs can reliably embody all 16 MBTI types through prompt conditioning alone — no fine-tuning required. BIG5-CHAT (2025, ACL) confirms prompting sufficient for simulation purposes where directional accuracy matters more than absolute consistency.

**Key finding:** In multi-agent simulations, personality divergence *increases* through interaction — agents' expressed personalities shift in ways consistent with MBTI predictions about social influence. A 100-agent simulation seeded with diverse profiles produces more distinct behavioral profiles at T=10 than at T=0. This is the desired property for decision rehearsal.

**Gap:** No existing open-source tool provides automated pipeline from structured user profile JSON to validated OASIS agent config. BTC project handcrafted 500 personas. MiroFish uses LLM-based persona generation from seed documents. **This is buildable in ~50 lines of Python using the OASIS `UserInfo` / `TextPrompt` API.** It is not a multi-month build.


## 6. COST AND COMPLEXITY AT PERSONAL SCALE

### GPU requirements by scale (from paper compute data, v4)

| Scale | GPUs Required | Time per Step |
|---|---|---|
| 1,000,000 agents | 27 × A100 | ~18 hours |
| 100,000 agents | 5 × A100 | ~3 hours |
| 10,000 agents | 2 × A100 | ~12 minutes |
| **100 agents (API mode)** | **0 GPUs** | **~minutes** |

**For personal-scale API-based use (100 agents): zero GPU required.**

### Cost per simulation (100 agents, 10 steps)

Empirical basis: BTC project measured $0.70 for 500 agents × 5 steps using DeepSeek ≈ $0.00028 per agent-step.

| Model | Cost per Simulation | Notes |
|---|---|---|
| DeepSeek V3 ($0.27/$1.10 per M) | ~$0.28 | Most cost-effective, BTC-validated |
| GPT-4o-mini ($0.15/$0.60 per M) | ~$0.17 | Cheapest mainstream model |
| Claude Haiku 3.5 ($0.80/$4.00 per M) | ~$0.94 | Good reasoning, higher output cost |
| GPT-4o ($2.50/$10.00 per M) | ~$2.75 | Overkill for most agents |

### Monthly cost (3 simulations/day, 90 sims/month)

| Model | Monthly Cost |
|---|---|
| DeepSeek V3 | ~$25/month |
| GPT-4o-mini | ~$15/month |
| Claude Haiku 3.5 | ~$85/month |
| GPT-4o | ~$250/month |

**Verdict: $15–$85/month at 3 sims/day. Under $10/month at 1 sim/day with cheap models.**

### Runtime
100 agents via async API: each step completes in ~3–10 seconds (parallel async calls, limited by slowest API response). 10 steps = 30–100 seconds per simulation. Real-time viable.

### Local (zero API cost) option
MiroFish-Offline stack (Ollama + qwen2.5:14b + Neo4j): 16 GB VRAM minimum. Runtime: ~500 seconds per step for 100 agents with 7B model — impractical for interactive use. Viable for overnight batch runs only. API is the correct deployment model for personal decision rehearsal.


## 7. LIGHTER ALTERNATIVES

### Stanford Generative Agents (Park et al., 2023)
**Paper:** https://arxiv.org/abs/2304.03442 | **Repo:** https://github.com/joonspk-research/generative_agents
Architecture: Memory stream with recency/importance/relevance scoring + reflection triggers + daily planning. 25 agents in a Sims-like sandbox.
**Advantage over OASIS:** More sophisticated individual agent cognition — true memory reflection, long-horizon planning. Better for deep-diving 5–10 key stakeholders.
**Disadvantage:** Far fewer agents. No social network topology. Environment coupled to specific sandbox.
**Verdict:** Complementary, not a replacement. Use Generative Agents architecture for the 3–5 critical stakeholder deep-dives. Use OASIS for population-level dynamics.

### AgentTorch (MIT Media Lab)
**Repo:** https://github.com/AgentTorch/AgentTorch
Differentiable agent-based modeling. Agents are mathematical rules, not LLM instances. Suitable for epidemiological/economic archetype models. Not appropriate for stakeholder simulation where individual reasoning matters.

### CrewAI
Workflow-oriented (tasks complete in sequence). Cannot model emergent social dynamics. Suitable for structured decision pipelines, not open-ended behavioral simulation.

### Simple multi-persona prompting
Works for: directional initial reactions, obvious objections, 1-round ideation.
Fails for: any scenario where the value is in agent-to-agent interaction over time.


## 8. OFFICIAL CONCLUSIONS

| Question | Conclusion | Confidence |
|---|---|---|
| Is OASIS deployable today? | Yes — pip install, zero GPU for API mode, Apache 2.0 | 97% |
| GPU required at 100-agent scale? | No — async API calls only | 95% |
| Monthly cost for personal use | $10–$85/month depending on model and frequency | 90% |
| Capability threshold vs. single-prompt | Activates at 20+ stakeholders and/or multi-round interaction dynamics required | 88% |
| Profile-to-agent-config pipeline | Buildable in ~50 lines Python. Not a multi-month problem | 85% |
| Best production reference | BTC Fear & Greed (validated cost) + MiroFish (full architecture) | 93% |
| Is this Future C territory? | Yes for full MiroFish stack. Minimum viable 100-agent sim is Future B (pilot-able sooner) | 82% |
| Best lighter alternative | Generative Agents for individual depth; nothing competes for population dynamics | 85% |

**The bottom line:** OASIS is not research-grade infrastructure. It is a pip-installable Python package that ran 500 agents for $0.70 in production last month. The barrier to a minimum viable decision rehearsal prototype is not compute or cost — it is building the profile-to-agent-config pipeline (~50 lines) and defining the first scenario. The MiroFish architecture is the production-proven playbook for the full stack when CT is ready for it.


## 9. OPEN QUESTIONS

- Which model produces the most behaviorally consistent agent outputs at 100-agent scale? DeepSeek is cheapest but behavioral fidelity vs. GPT-4o is unverified for stakeholder personas specifically.
- What is the minimum persona narrative length that produces meaningfully distinct agent behavior? Not established in the literature for < 100 token personas.
- Does OASIS's `INTERVIEW` action support streaming responses? Relevant for interactive use. Not confirmed in current docs.


## 10. KNOWLEDGE WEB POINTERS

- **Jiang.Topic.OASIS** ↔ **Jiang.Topic.AgentOrchestration** [8] — OASIS is the simulation runtime layer in the full multi-agent architecture
- **Jiang.Topic.OASIS** ↔ **Jiang.Topic.TokenCostModel** [6] — OASIS cost modeling feeds directly into total system cost-of-goods
- **Jiang.Topic.OASIS** ↔ **Jiang.Topic.IntakeTestDesign** [7] — The user profile generated by intake is the seed data for OASIS agent configuration

[VELORIN.EOF]
