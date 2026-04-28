# OpenAI-SDK-Compatible LLM API Path with Qwen

## What MiroFish documents

MiroFish explicitly says its LLM API layer supports:
- any API in **OpenAI SDK format**
- recommended model: `qwen-plus`
- base URL: Alibaba / DashScope compatible endpoint

This is a major architectural decision.

## What “OpenAI-SDK-compatible” means

It means the system expects the model provider to expose endpoints that behave like the OpenAI API enough that standard OpenAI clients can call them.

Typical knobs:
- `base_url`
- `api_key`
- `model`
- OpenAI-style request shape
- chat completions / responses compatibility

This is attractive because it reduces vendor lock-in.

## Why this is smart

If your application is written against an OpenAI-compatible interface, you can often swap providers by changing:
- model name
- base URL
- credentials

instead of rewriting the whole application.

That gives MiroFish portability.

## Qwen support

Alibaba Cloud Model Studio explicitly documents an **OpenAI-compatible interface** for Qwen models.  
Qwen’s own docs also describe OpenAI-compatible serving paths using vLLM or SGLang and usage via common HTTP clients or OpenAI SDKs.

So there are two major routes:

### Route 1 — Hosted provider
Use Alibaba / DashScope / Model Studio compatible endpoint.

### Route 2 — Self-hosted
Serve Qwen through:
- vLLM
- SGLang

and then call it through an OpenAI-compatible API.

## Why this matters for MiroFish

A multi-agent simulation engine wants flexibility across:
- cost
- latency
- context length
- reasoning style
- deployment constraints

OpenAI-compatible design lets the project:
- start on one provider
- migrate later
- test multiple models
- self-host if necessary

## What this layer should expose

At minimum:
- chat completions
- tool/function calling if used
- streaming if useful
- consistent error handling
- model selection
- request tracing
- retry policy

## Where to get it

### Hosted Qwen path
- Alibaba Cloud Model Studio / DashScope compatibility docs

### Self-hosted Qwen path
- Qwen docs
- vLLM
- SGLang

## ChatGPT integration path

Important distinction:
- ChatGPT itself is not going to use your Qwen endpoint natively inside the product UI unless you expose it via your own app/tool layer.
- But your **ChatGPT app backend** can absolutely call a Qwen endpoint via OpenAI-compatible SDK semantics.

That means:

### Recommended path
- your app backend talks to Qwen
- ChatGPT talks to your backend through MCP/app tools

Do not assume ChatGPT is going to become a direct Qwen shell.

## Anthropic / Claude integration path

Same rule.

Claude can orchestrate tools that call:
- Qwen
- hosted APIs
- self-hosted vLLM/SGLang endpoints

Useful patterns:
- Claude calls a tool that hits a Qwen endpoint
- Claude uses MCP to query results from a service powered by Qwen
- Claude-based internal workflows can switch models under the hood without changing the operator experience

## Velorin relevance

This design pattern is one of the most important parts of the stack.

Velorin should care because it enables:
- tool/model agnosticism
- cost control
- fallback models
- selective use of proprietary vs open models
- internal routing by task class

That is exactly the kind of capability your agents have been under-surfacing.

## Risks

- assuming every “OpenAI-compatible” provider behaves identically
- subtle differences in tool calling
- subtle differences in streaming
- context-window assumptions
- tokenizer differences
- safety behavior differences

So “compatible” means “portable with testing,” not “drop-in perfect.”

## Decision

OpenAI-compatible LLM API design is one of the strongest strategic choices in the MiroFish stack. It is a practical anti-lock-in pattern and a good example of the broader architectural thinking Velorin agents should have been surfacing much earlier.

## Sources

- MiroFish README env vars and Qwen recommendation
- Alibaba Cloud Model Studio compatibility docs
- Qwen docs on OpenAI API compatibility
