# OASIS as the Underlying Simulation Engine

## What MiroFish says

MiroFish explicitly thanks CAMEL-AI and states that its simulation engine is powered by **OASIS**.

That is one of the most important disclosed architecture facts in the whole repo.

## What OASIS is

OASIS stands for **Open Agent Social Interaction Simulations**.

The official repo and paper describe it as a scalable open-source social media simulator capable of modeling up to **one million agents** on platforms like Twitter/X and Reddit, with support for phenomena such as:
- information spread
- group polarization
- herd behavior

## What OASIS contributes

The OASIS paper describes five foundational components:
- Environment Server
- RecSys
- Agent Module
- Time Engine
- Scalable Inferencer

This is crucial. It means OASIS is not “just agent chat.”
It is a **world runtime**.

## What those components mean

### 1. Environment Server
Holds world state:
- users
- relationships
- posts
- environment configuration

### 2. RecSys
Recommendation logic. In social simulations, visibility is not random. Feeds matter.

### 3. Agent Module
Where individual agent behaviors are generated.

### 4. Time Engine
Advances the system over time and coordinates state transitions.

### 5. Scalable Inferencer
Allows the system to scale to large numbers of agents without collapsing into brute-force serial computation.

## Why this matters for MiroFish

MiroFish does not need to invent a million-agent social simulation engine from scratch if OASIS already provides:
- scalable time progression
- agent action loops
- dynamic environments
- social-media-like interactions

MiroFish can then add:
- world construction from seed documents
- persona generation
- memory layer
- report generation
- interactive querying

That division of labor makes sense.

## What OASIS is good at

- large-scale social dynamics
- platform-like interaction modeling
- studying cascades and polarization
- controllable simulation environments
- research-grade experimentation

## What OASIS is not by itself

- a polished end-user product
- a graph-construction layer
- a long-term memory platform
- a report system
- a front-end application

That is exactly why MiroFish can be seen as an application layer built on top of OASIS.

## Where to get it

- GitHub repo: `https://github.com/camel-ai/oasis`
- CAMEL-AI org: `https://github.com/camel-ai`
- Paper / preprint: OASIS: Open Agent Social Interaction Simulations with One Million Agents

## ChatGPT integration path

No native OASIS connector.

Correct pattern:
- run OASIS behind your own backend
- expose simulation operations via MCP / app tools
- keep ChatGPT as the operator/client layer

Useful ChatGPT tools:
- `launch_oasis_run`
- `advance_time`
- `inject_event`
- `get_world_snapshot`
- `query_agent_cluster`
- `compare_runs`

## Anthropic / Claude integration path

Same principle.

Best fit:
- OASIS behind a backend
- backend exposed through remote MCP or local MCP depending use case
- Claude as orchestration / interrogation layer

Useful Anthropic distribution options:
- Claude Code for internal build work
- remote MCP for production systems
- desktop extension / MCP bundle for internal operators
- custom Skill for run standards and analysis playbooks

## Velorin relevance

Extremely high.

OASIS-class thinking matters for Velorin because it suggests a path toward:
- stakeholder simulations
- narrative propagation modeling
- market reaction systems
- policy consequence exploration
- internal multi-agent world testing

Even if Velorin never uses OASIS directly, it should understand the separation:

- world runtime
- memory layer
- graph construction
- persona setup
- report layer
- conversational interrogation layer

That separation is strategically important.

## Risks

- over-believing simulation realism
- treating agent scale as proof of correctness
- weak grounding in real data
- no calibration against real-world outcomes
- agent interactions producing plausible but misleading narratives

## Best practice

Use OASIS as:
- simulation substrate
not:
- truth engine

You still need:
- calibration
- evaluation
- evidence tracking
- repeatability
- scenario comparison

## Decision

OASIS is one of the most substantive parts of the disclosed MiroFish architecture. It is the engine that makes the project more than a prompt workflow. If GraphRAG builds the world model and Zep stabilizes memory, OASIS is what gives the system a real social simulation runtime.

## Sources

- MiroFish README acknowledgments and workflow
- OASIS repo
- OASIS paper / architecture description
