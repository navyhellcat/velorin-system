# Why Qwen is Recommended

## What MiroFish says

The repo recommends:
- Alibaba Bailian / DashScope
- `qwen-plus`
- starting with fewer than 40 rounds because simulation consumption is high

That tells you three things immediately:

1. model cost matters
2. simulation round count matters
3. the team believes Qwen is a good tradeoff for this workload

## Why Qwen is a sensible recommendation here

### 1. OpenAI-compatible access
It fits the project’s portable API design.

### 2. Good multilingual performance
For a Chinese-built public-opinion / narrative / social simulation engine, strong Chinese capability is not optional.

### 3. Hosted and self-hostable paths
You can use a hosted endpoint or serve Qwen through OpenAI-compatible infrastructure.

### 4. Cost/performance flexibility
For multi-agent simulations, the cost of many agents over many rounds is load-bearing. A model that is “good enough and cheaper” often beats the single strongest premium model.

## Why “qwen-plus” specifically

MiroFish explicitly points to the Bailian platform and `qwen-plus`. That implies:
- the team has tested that path
- the latency/cost/quality balance is acceptable
- the model is practical for many-agent, many-turn simulations

This is not proof it is universally best. It is proof it is their preferred operational default.

## When Qwen is a better fit than frontier premium models

- very high simulation volume
- Chinese-language content
- toolable hosted endpoint
- desire to keep per-run cost under control
- willingness to accept some quality tradeoff in exchange for scale

## When Qwen may not be enough

- highest-stakes reasoning per agent
- maximal report-writing polish
- edge-case tool-calling compatibility requirements
- very long, complex executive synthesis

A serious system may use model routing:
- Qwen for bulk simulation
- stronger model for report generation or final review

## ChatGPT integration path

ChatGPT is not the place where you “switch ChatGPT to Qwen.”

Correct architecture:
- ChatGPT app / backend uses Qwen where appropriate
- ChatGPT remains the client experience
- the model choice lives behind your service boundary

This is exactly the kind of distinction internal agents should be explaining:
**client experience** and **underlying model provider** are separate decisions.

## Anthropic / Claude integration path

Same logic.

Claude can orchestrate systems whose underlying workload is done by Qwen. For example:
- Claude queries a simulation service powered by Qwen
- Claude compares outputs from multiple model providers
- Claude operates a model router through tools

Again: Claude as operator does not imply Claude as every underlying model.

## Velorin relevance

This matters a lot for Velorin because the company needs:
- tool agnosticism
- model agnosticism
- task-specific routing
- budget discipline

Your agents should have been surfacing questions like:
- Is a frontier model actually needed here?
- Is there a cheaper compatible model for the bulk work?
- Which tasks should be premium vs commodity?
- Can we separate orchestration model from execution model?

That is the core lesson.

## Recommended policy

Use a model-class matrix:
- bulk simulation / synthetic population turns -> lower-cost or self-hostable model
- final report / memo / board-facing synthesis -> premium model
- evaluation / adjudication -> strongest reliable model
- translation / multilingual extraction -> best multilingual model for the data

## Risks

- over-trusting one recommended default model
- not testing alternate providers
- assuming quality scales linearly with cost
- underestimating the value of domain/language fit

## Decision

Qwen is being recommended because it fits the operational economics and language profile of the system. The larger lesson is more important than the specific vendor: **choose models by task economics and fit, not by brand gravity.**

## Sources

- MiroFish README
- Alibaba / Qwen compatibility docs
- Qwen serving / SDK docs
