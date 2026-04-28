# Gemini Model Selection — Research Report
**Topic:** What model runs in gemini.google.com for Google AI Ultra subscribers, and how to access the best available model
**Researcher:** Jiang (Claude Code agent)
**Date:** April 5, 2026
**Confidence notation:** [HIGH] = multiple corroborating sources / [MED] = 1-2 sources / [LOW] = inferred or single source

---

## QUESTION 1: What Is Gemma 4?

### Short Answer
Gemma 4 is a separate **open-weights** model family from Google DeepMind. It does NOT power the Gemini web interface. An Ultra subscriber should NOT expect to be running Gemma 4 at gemini.google.com — they are entirely different products.

### Is Gemma 4 Open-Weights?
**[HIGH confidence]** Yes. Gemma 4 was released April 2, 2026 as four open-weight models under Apache 2.0 licensing:
- **E2B** — edge/smartphone scale
- **E4B** — edge/smartphone scale
- **26B MoE** — Mixture-of-Experts, optimized for speed
- **31B Dense** — most capable, ranks #3 on LMArena text leaderboard as of release

Available on Hugging Face, Kaggle, Ollama, Google AI Studio (as a model to call), and Google Cloud. Commercially deployable. Anyone can download and run it.

Sources: [Google Blog: Gemma 4](https://blog.google/innovation-and-ai/technology/developers-tools/gemma-4/), [Google DeepMind](https://deepmind.google/models/gemma/gemma-4/), [HuggingFace blog](https://huggingface.co/blog/gemma4), [The Register](https://www.theregister.com/2026/04/02/googles_gemma_4_open_weights/)

### Does Gemma 4 Power the Gemini Web Interface?
**[HIGH confidence]** No. The Gemini web interface (gemini.google.com) runs on the **Gemini 3 family** — specifically Gemini 3 Flash (Fast/Thinking options) and Gemini 3.1 Pro (Pro option). Gemma 4 is a separate open-source family.

### Relationship Between Gemma 4 and Gemini 3/2.5
**[MED confidence]** Gemma 4 is architecturally informed by the same research that produced the Gemini model families, but they are distinct products:
- Gemini = Google's proprietary, closed, commercial model family (powers gemini.google.com, API, Vertex AI)
- Gemma = Google's open-weights model family, released for developers/researchers to run and fine-tune themselves

The naming is confusingly similar. The lineage is: Gemma 1 → Gemma 2 → Gemma 3 → **Gemma 4** (open-weights series). Separately: Gemini 1 → Gemini 1.5 → Gemini 2.0 → Gemini 2.5 → Gemini 3 → **Gemini 3.1** (proprietary series). These are parallel tracks, not the same model.

Wavespeed AI notes: Gemma 4 is "built from Gemini 3 research" but is a distinct product with different licensing and deployment targets. HuggingFace's blog describes Gemma 4 as building on previous Gemma versions, not as a distillation from Gemini.

### Is Gemma 4 Available in the gemini.google.com Chat Interface?
**[HIGH confidence]** No. Gemma 4 is not available in the consumer gemini.google.com interface. It is accessible through:
- Google AI Studio (aistudio.google.com) — as a model choice for API/developer use
- Hugging Face, Kaggle, Ollama — for direct download/self-hosting
- Google Cloud (Vertex AI) — for enterprise API use

---

## QUESTION 2: What Model Is Actually Running in gemini.google.com for Ultra Subscribers?

### The Three-Option Picker (Fast / Thinking / Pro)
**[HIGH confidence]** The gemini.google.com interface presents three model tiers in a picker. These map to the Gemini 3 family as follows:

| Picker Label | Underlying Model | Generation | Notes |
|---|---|---|---|
| **Fast** | Gemini 3 Flash | Gemini 3 | Quick answers, unlimited or generous quota |
| **Thinking** | Gemini 3 Flash with Deep Think reasoning | Gemini 3 | Internal reasoning loop before responding |
| **Pro** | Gemini 3.1 Pro | Gemini 3.1 | Most capable consumer option, 500 prompts/day for Ultra |

The Gemini 3 Flash (Fast/Thinking) was introduced to the app on December 17, 2025. Gemini 3.1 Pro (the "Pro" option) was introduced February 19, 2026.

Sources: [9to5Google Gemini 3 Flash rollout](https://9to5google.com/2025/12/17/gemini-app-3-flash-rollout/), [Google Blog Gemini 3 Flash app](https://blog.google/products/gemini/gemini-3-flash-gemini-app/), [Gemini release notes](https://gemini.google/release-notes/), [Devoteam guide](https://www.devoteam.com/expert-view/gemini-model-fast-vs-thinking-vs-pro/)

### Is "Pro" the Same as gemini-3.1-pro-preview?
**[MED confidence]** The API identifier confirmed by the Google AI developer documentation is `gemini-3.1-pro` (still in preview/pre-GA status as of April 2026, though accessible to subscribers via the app as the "Pro" label). The developer forum confirmed that as of April 2026, Gemini 3 series models remain in preview status — "gemini-3-flash-preview" and "gemini-3.1-pro-preview" are the current strings, with stable GA versions not yet released. [Source: Google AI Developers Forum deprecation thread](https://discuss.ai.google.dev/t/clarification-on-stable-replacement-models-for-gemini-2-5-flash-and-gemini-2-5-pro-before-june-2026-deprecation/130009)

### Most Capable Model for Ultra Subscribers
**[HIGH confidence]** The most capable option available to Ultra subscribers in the web interface is **Pro (Gemini 3.1 Pro)**. Ultra subscribers also get:
- **Deep Think 3.1** — available as a special mode, limited to 10 prompts/day (unlocks deeper reasoning on top of 3.1 Pro)
- **Gemini Agent** — US only, English only, accessible through Labs/Experimental features

The 9to5Google Ultra features breakdown (March 2026) confirms:
- Thinking: 1,500 prompts/day, 192K token context window
- Pro: 500 prompts/day, 1 million token context window
- Deep Think 3.1: 10 prompts/day (most powerful reasoning option)

Source: [9to5Google Ultra features March 2026](https://9to5google.com/2026/03/17/google-ai-pro-ultra-features/), [Google AI subscriptions page](https://gemini.google/subscriptions/)

### Is Gemini 2.5 Pro Accessible in the Browser Interface?
**[HIGH confidence]** No. Gemini 2.5 Pro is no longer surfaced in the gemini.google.com consumer interface. The interface has been updated to the Gemini 3 family. Gemini 2.5 Pro remains accessible via:
- Direct API (gemini-2.5-pro model string)
- Google AI Studio (aistudio.google.com)
- Vertex AI

Gemini 2.5 Pro is scheduled for API deprecation June 17, 2026. Supervised fine-tuned Gemini 2.5 Pro endpoints shut down October 17, 2026.

---

## QUESTION 3: How to Change Models in gemini.google.com

### Is the Fast/Thinking/Pro Picker the ONLY Model Selector?
**[MED confidence]** For practical purposes, yes — the three-option picker is the primary model selection mechanism. However, there are additional access pathways through Gemini Labs.

### Gemini Labs — Experimental Features
**[HIGH confidence]** Google launched a "Gemini Labs" section in February 2026. It lives in the Tools menu of the Gemini web app, marked with a beaker icon. Labs contains:

**Stable tools (Tools section):**
- Deep Research, Create videos, Create images, Canvas, Guided Learning, Deep Think

**Experimental features section:**
- **Agent** (AI Ultra subscribers, US only, English only)
- **Dynamic View / Visual Layout** (available to all users)
- **Personal Intelligence** (all paid subscribers)
- **Project Genie** — AI world model, Ultra-only, US only (research prototype)

**Key finding:** Labs does NOT expose additional model selector options or let you switch to different underlying models. It gates access to specialized features and agent-mode capabilities, not raw model switching.

Source: [Winbuzzer Gemini Labs](https://winbuzzer.com/2026/02/04/google-gemini-labs-splits-experimental-features-stable-tools-xcxwbn/), [Android Police Labs coverage](https://www.androidpolice.com/gemini-experimental-labs-features-tab/), [Project Genie blog](https://blog.google/innovation-and-ai/models-and-research/google-deepmind/project-genie/)

### Reddit/Community Reports on Model Selection Frustration
**[MED confidence — no direct Reddit thread fetched, drawn from news coverage of Reddit commentary]**

Documented community frustrations:
1. **Pro mode disappearing** — In February 2026, a number of Google AI Pro subscribers reported the "Pro" option vanishing from their picker, leaving only Fast and Thinking. The bug appeared inconsistent — company-managed Gemini accounts retained all three options while personal Pro plan accounts lost it. Google support gave conflicting responses. [PiunikaWeb coverage](https://piunikaweb.com/2026/02/06/gemini-pro-option-missing-google-ai-pro-subscribers/)

2. **Hidden effort level / throttling** — In March 2026, users discovered Gemini 3.1 Pro responds to certain system-level prompts with "EFFORT LEVEL: 0.50" — interpreted as evidence that even Ultra subscribers are not getting full compute. Multiple users on Reddit and X reproduced the result. Google's official docs use different terminology (LOW/MEDIUM/HIGH), so the numerical result may be a hallucinated-but-plausible response rather than confirmed throttling. [PiunikaWeb coverage](https://piunikaweb.com/2026/03/09/gemini-3-1-pro-hidden-effort-level-prompt/)

3. **App vs AI Studio quality gap** — The Google AI Developer Forum thread titled "The Gap Between Gemini App and Google AI Studio Is a Chasm" documents paying subscribers observing that the same model (2.5 Pro, 3.0 Pro) performs noticeably better in AI Studio than in the consumer app. User quote: "I am paying for access to intelligence, but being redirected to a version of it that is deliberately constrained, while the stronger, more capable version sits right next to it." [Google AI Dev Forum thread](https://discuss.ai.google.dev/t/the-gap-between-gemini-app-and-google-ai-studio-is-a-chasm-and-paying-users-are-falling-into-it/122134)

4. **Model picker as a long-term project problem** — Developer forum post "New Model Levels (Fast/Thinking/Pro) Continue to Be a Problem for Long Term Projects" (Google AI Studio forum) notes that the abstracted labels make it impossible to pin a specific model version for consistency across sessions. [Google AI Developers Forum](https://discuss.ai.google.dev/t/new-model-levels-fast-thinking-pro-continue-to-be-a-problem-for-long-term-projects/112416)

### Any Non-Obvious Ways to Access Better Models in the Browser?
**[MED confidence]** No verified backdoor model selector exists in gemini.google.com. The only legitimate workaround is to move to a different interface:
- **Google AI Studio (aistudio.google.com)** gives direct model selection with explicit model ID strings
- The Gemini app does not expose model ID strings or allow pinning to specific preview versions

---

## QUESTION 4: The Gemini 2.5 Pro Situation

### Was Gemini 2.5 Pro a Significant Capability Jump?
**[HIGH confidence]** Yes. Gemini 2.5 Pro was widely recognized as a major leap — it held top positions on LMArena, WebDev Arena, and the coding leaderboards for much of 2025. Google itself marketed it as "world-leading" on multiple benchmarks.

### Is Gemini 2.5 Pro Available in gemini.google.com for Ultra Users?
**[HIGH confidence]** No longer. The web interface was updated to the Gemini 3 family (December 2025 for Flash, February 2026 for 3.1 Pro). Gemini 2.5 Pro is no longer surfaced as a named option in the consumer interface. Ultra subscribers get Gemini 3.1 Pro (the "Pro" picker) as the current top-tier consumer model.

### Where IS Gemini 2.5 Pro Accessible?
**[HIGH confidence]**
- **Google AI Studio (aistudio.google.com)** — free tier, accessible via model string `gemini-2.5-pro`; rate limits were reduced ~50-80% in December 2025 due to abuse but still available
- **Gemini API (ai.google.dev)** — direct API access with `gemini-2.5-pro` model string, free tier with rate limits; paid API access billed per token
- **Vertex AI** — enterprise API access, pay-per-token

**Deprecation schedule:** API access to `gemini-2.5-pro` will be shut down **June 17, 2026**. Supervised fine-tuned endpoints shut down October 17, 2026. After June 2026, developers will need to migrate to Gemini 3.x API strings.

Sources: [Google Deprecations doc](https://ai.google.dev/gemini-api/docs/deprecations), [Google AI Developers Forum deprecation thread](https://discuss.ai.google.dev/t/clarification-on-stable-replacement-models-for-gemini-2-5-flash-and-gemini-2-5-pro-before-june-2026-deprecation/130009), [Google AI Models page](https://ai.google.dev/gemini-api/docs/models)

### Are Gemini 3.x API Model Strings in GA or Preview?
**[HIGH confidence]** As of April 2026, Gemini 3.x models are still in preview. The developer forum confirms:
- `gemini-3-flash-preview` — preview
- `gemini-3.1-pro-preview` — preview
- No stable GA version yet announced for either

The consumer web app uses these preview models under the abstracted Fast/Thinking/Pro labels. Production developers are in an awkward position: 2.5 Pro is being deprecated but the 3.x replacement models haven't achieved stable GA status yet.

---

## Summary: What Should an Ultra Subscriber Know?

| Question | Answer |
|---|---|
| What is Gemma 4? | Open-weights model family, separate from Gemini, for developers to self-host. NOT what runs in the web app. |
| What's running in the web app? | Gemini 3 family: Fast = Gemini 3 Flash, Thinking = Gemini 3 Flash + reasoning, Pro = Gemini 3.1 Pro |
| Best model in the browser? | Pro (Gemini 3.1 Pro), and Deep Think 3.1 mode for 10 prompts/day |
| Is Gemini 2.5 Pro in the browser? | No. It's been replaced by the Gemini 3 interface. Still accessible via AI Studio and API (until June 2026). |
| How to access older/different models? | Use Google AI Studio (aistudio.google.com) — free, model selector is explicit, can still access 2.5 Pro |
| Any hidden model access in the browser? | No verified backdoor. Labs section adds features, not model choices. |
| Is Gemini 3.1 Pro ("Pro") actually good? | MED confidence. Community reports quality gap vs AI Studio version; hidden effort level controversy unresolved. |
| Are there Gemini 3.x GA models yet? | No. All Gemini 3.x are still in preview as of April 2026. |

---

## Confidence Summary

- **Gemma 4 is open-weights, not the Gemini web app:** HIGH
- **Fast/Thinking/Pro = Gemini 3 Flash/Flash-Think/3.1Pro:** HIGH
- **Gemini 2.5 Pro deprecated from web interface, API deadline June 2026:** HIGH
- **Labs doesn't expose additional model selector:** MED (fetched source was ad-heavy, limited detail)
- **Pro picker = gemini-3.1-pro-preview API string:** MED (API doc confirms model exists, label mapping from release notes)
- **AI Studio accesses better-performing version of same models:** MED (developer forum reports, no controlled study)
- **Effort level "0.50" is confirmed throttling:** LOW — community-reproduced but Google terminology mismatch; may be hallucination

---

*Research methodology: WebSearch + WebFetch across Google official blogs, release notes, developer forums, 9to5Google, PiunikaWeb, Devoteam, Vertu, and HuggingFace. Reddit direct search returned no indexed results for the specific queries; community commentary was sourced via tech journalism covering Reddit/developer forum threads. All claims cited inline.*
