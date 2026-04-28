# Python Backend

## Why MiroFish uses Python on the backend

The MiroFish repo shows a Python-heavy codebase and explicitly requires Python **>=3.11 and <=3.12** for the backend.

That is a very normal choice for this kind of system because the backend owns:
- LLM orchestration
- graph construction
- simulation control
- memory access
- report generation
- API exposure to the frontend

Python remains the default language for AI-heavy orchestration and research systems.

## What the backend is likely responsible for

In a MiroFish-style stack, the Python backend probably owns:

- corpus ingestion
- GraphRAG calls or wrappers
- entity/relationship extraction
- persona generation logic
- simulation orchestration
- state progression
- memory reads/writes
- report generation
- chat endpoints for world interrogation
- APIs consumed by the Vue frontend

## Why Python fits here

### Strengths
- strongest AI/ML ecosystem
- easy integration with LLM SDKs
- rich graph, data, and simulation tooling
- easy to expose APIs using frameworks like FastAPI
- fast developer velocity

### Weaknesses
- not the fastest raw execution path
- can become messy without strict architecture
- long-running concurrent simulation work must be designed carefully

## “How it should be built” guidance

### Good backend separation
1. API layer  
2. orchestration layer  
3. simulation layer  
4. memory layer  
5. reporting / analytics layer  
6. persistence layer

### Bad backend pattern
One giant service that mixes:
- prompts
- state management
- HTTP routes
- report formatting
- memory rules

That becomes unmaintainable fast.

## Where to get Python

Official source:
- `https://www.python.org/downloads/`

For the MiroFish version window:
- 3.11 series
- 3.12 series

As of now, Python.org shows:
- 3.12 in security support
- 3.11 in security support

That is acceptable for pinned project runtimes even though 3.13/3.14 exist.

## Common framework choices

### FastAPI
Strong fit for AI backends because it gives:
- clean async APIs
- type hints
- OpenAPI docs
- easy deployment patterns

Even if MiroFish does not publicly document FastAPI in the README, it is a common and sensible Python backend choice in this category.

## ChatGPT integration path

ChatGPT does not “run your Python backend” by default.

To connect it:

### Option A — MCP-backed app
Expose backend capabilities as MCP tools and package them as a ChatGPT app.

### Option B — standard API behind your own app
Your Python backend can serve:
- REST
- websocket
- task queue APIs

Then your ChatGPT-facing app talks to that backend.

### Option C — file export/import
Weakest option. Fine for reports, bad for operational control.

## Anthropic / Claude integration path

### Option A — Remote MCP server
Expose backend capabilities as tools.

### Option B — Claude Code local operation
Good for dev and ops work, not enough by itself for product distribution.

### Option C — Desktop extension / MCP bundle
Good for internal operator deployment.

### Option D — Skill
A Skill can teach Claude how to use the backend safely, but it does not replace the backend itself.

## Velorin recommendation

If Velorin adopts this stack pattern, Python should own:
- orchestration
- simulation logic
- graph operations
- memory glue
- scenario evaluation
- report generation APIs

Do not put that logic in frontend JavaScript.

## Risks

- prompt logic mixed into route handlers
- no task queue for long-running simulations
- blocking calls in API paths
- memory writes without schema discipline
- lack of observability and run IDs
- no run reproducibility

## Best practice stack for a serious version

- Python 3.11 or 3.12
- uv for dependency and environment management
- FastAPI API surface
- background task worker / queue
- structured logging
- Dockerized services
- MCP wrapper for AI clients

## Decision

Python backend is the right default for a MiroFish-like system. The main question is not whether Python is right. The question is whether the service boundaries are disciplined enough to keep the simulator from turning into a monolith.

## Sources

- MiroFish README / repo structure and requirements
- Python.org download and version docs
- FastAPI docs
