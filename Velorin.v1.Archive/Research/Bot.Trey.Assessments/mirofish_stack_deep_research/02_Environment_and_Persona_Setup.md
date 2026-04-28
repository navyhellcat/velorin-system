# Environment and Persona Setup

## What this layer does

MiroFish lists its second workflow stage as:

- entity relationship extraction
- persona generation
- environment configuration
- simulation parameter injection

That is the **world instantiation phase**. Graph construction gives you structure. Environment and persona setup turn that structure into a living simulation.

## What “environment setup” means in practice

Environment setup defines:

- the world frame
- what entities exist
- what institutions or factions exist
- what constraints apply
- what platform or medium is being simulated
- what actions agents are allowed to take
- what time moves look like
- what information each agent can see

Examples:
- public opinion crisis on a Chinese social platform
- policy rollout and stakeholder reaction
- financial rumor propagation
- fictional story-world continuation
- internal company social dynamics

Without environment setup, you have facts but not a stage.

## What “persona setup” means

Persona setup defines each agent as a decision-making unit.

Typical fields:
- identity
- role
- demographic or segment
- beliefs / priors
- goals / incentives
- social position
- relationships
- memory seed
- temperament
- likely action tendencies
- communication style
- risk tolerance
- susceptibility to influence

The best known reference model here is the Stanford/Google **Generative Agents** architecture:
- memory
- reflection
- planning
- behavior in an interactive environment

MiroFish appears to be pushing that idea into a large-population predictive setting.

## The core design problem

Bad persona setup creates fake simulations.

Most failed agent simulations do one of two bad things:

### Failure mode 1 — thin personas
Agents are just labels with prompts:
- “a journalist”
- “a student”
- “a policymaker”

That is not enough. It produces repetitive, generic outputs.

### Failure mode 2 — over-authored personas
Agents become scripted characters rather than population members. This is fine for games, bad for prediction.

The correct middle path is:
- enough identity structure to generate differentiated behavior
- enough environmental pressure to produce emergent outcomes
- enough memory to preserve continuity
- enough randomness or diversity to avoid brittle determinism

## Likely MiroFish approach

Based on the README and the surrounding stack, MiroFish likely does something like this:

1. extract entities and relationships from seed material
2. infer social roles and clusters
3. generate personas for representative or large-scale agent populations
4. inject environment variables:
   - platform norms
   - issue salience
   - influence structures
   - scenario parameters
5. hand the resulting world state to OASIS + memory layer for simulation

## Components of strong persona setup

### 1. Role grounding
Agents need a place in the system:
- student
- government employee
- retail investor
- PR lead
- fandom account
- media editor

### 2. Relationship grounding
Who knows whom?
Who influences whom?
Who distrusts whom?

### 3. Incentive grounding
What does the agent want?
- status
- safety
- profit
- consistency
- belonging
- ideological victory
- entertainment

### 4. Information horizon
What can the agent actually see?
This is critical. If all agents see the whole truth, the simulation is fake.

### 5. Memory seed
What prior experiences or assumptions does the agent carry into the scenario?

### 6. Action space
What can the agent do?
- post
- comment
- follow
- ignore
- escalate
- coordinate
- persuade
- withdraw

## Components of environment setup

### 1. Topology
What kind of world is this?
- social feed
- organization
- town
- market
- policy arena

### 2. Rules
What behaviors are allowed?
What creates visibility?
What causes reinforcement?

### 3. Time
What counts as one step?
Minutes? Hours? Days?

### 4. Exogenous events
What can be injected from outside?
MiroFish explicitly describes a “god view” where variables can be injected.

### 5. Observability
How much of the system is visible to users and to agents?

## Where to get it

This is not a standalone product you buy off a shelf.

You get this layer from:
- MiroFish repo and implementation
- Generative Agents paper and related work
- your own schema design
- upstream simulation engine requirements
- your memory system design

Reference sources:
- MiroFish repo
- Google / Stanford Generative Agents paper
- Stanford HAI writeups on generative and survey-simulation agents

## ChatGPT integration path

There is no direct “persona setup connector.”

Practical options:

### Option A — MCP tools
Expose tools like:
- `generate_personas_from_graph`
- `set_environment_rules`
- `inject_scenario_variables`
- `preview_population_distribution`

This is the best path if you want ChatGPT to operate the world-building system.

### Option B — App UI
A ChatGPT app can provide:
- persona design forms
- environment templates
- simulation launch configuration

### Option C — file-driven workflow
Possible but weak. Better for exports than for operation.

## Anthropic / Claude integration path

### Option A — Remote MCP server
Best serious option. Claude can call tools to create and modify world state.

### Option B — Claude Desktop / Claude Code via MCP
Good for internal operators and fast iteration.

### Option C — Claude Skill
Useful to standardize:
- persona schema
- environment QA checklist
- risk checks before simulation launch

A Skill helps the operator do the setup correctly; it does not replace the backend.

## Velorin relevance

This is bigger than MiroFish.

Velorin can use the same design logic for:
- competitive intelligence worlds
- customer ecosystem simulations
- political coalition simulation
- internal strategy war-gaming
- scenario planning

The same architecture can be used for:
- “What happens if this policy is introduced?”
- “How do these stakeholder groups react?”
- “Which narratives emerge?”
- “What agent classes become pivotal?”

## What to avoid

- personas built only from stereotypes
- global knowledge leakage into every agent
- no incentive modeling
- no relationship graph
- no environment rules
- over-prompted personalities with no state logic
- deterministic “simulation” that is really just repeated summary

## Decision

Environment and persona setup are the difference between:
- a graph search system
- and a social prediction engine

That layer is where structure becomes behavior.

## Sources

- MiroFish README workflow
- Google Research: Generative Agents
- Stanford HAI coverage of generative agents and behavior simulation
