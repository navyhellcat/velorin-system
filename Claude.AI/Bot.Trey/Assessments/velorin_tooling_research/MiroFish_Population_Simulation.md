# MiroFish Population Simulation Analysis

## Correction

The product name is **MiroFish**, not Microfish.

## 1. What MiroFish is

MiroFish is an open-source, multi-agent prediction engine built to simulate large populations inside a high-fidelity digital world. The core idea is not standard forecasting. Instead, it creates thousands of AI agents with distinct personalities, memory, and behavioral logic, then lets them interact inside a simulated environment to estimate how an event, policy, financial signal, or narrative might evolve.

The official positioning is direct: upload seed material from the real world, describe the prediction question in natural language, and MiroFish returns both:

- a detailed prediction report
- an interactive digital world you can continue interrogating

### Claimed use cases from the project

- public-opinion simulation
- policy and PR rehearsal
- financial-event prediction
- creative/narrative simulation
- scenario testing for "what if" questions

## 2. What it uses

From the official repository and related project materials, the stack is roughly:

### Core simulation engine
- **OASIS** by CAMEL-AI as the simulation engine
- OASIS is built for large-scale social interaction simulation and can scale to very large agent populations

### Knowledge / memory layer
- **GraphRAG** during graph construction and memory injection
- **Zep Cloud** for agent memory / long-term memory support

### Model layer
- Compatible with **OpenAI-SDK-style LLM APIs**
- The repo specifically recommends **Alibaba Bailian / Qwen-Plus** as a default model path

### App stack
- **Python backend**
- **Vue frontend**
- **Node.js 18+** for frontend/runtime tasks
- **Python 3.11-3.12** for backend
- **uv** as Python package manager
- **Docker / Docker Compose** supported for deployment

### Licensing / operational note
- Open-source under **AGPL-3.0**

## 3. How it works

The repository lays out a five-step workflow.

### Step 1: Graph construction
MiroFish ingests seed material from the real world and builds a knowledge graph using GraphRAG. It injects both individual and collective memory so the simulation does not start from a blank slate.

### Step 2: Environment construction
It extracts entities and relationships, creates character/persona structures, and configures the simulated environment with parameters that shape the run.

### Step 3: Simulation
The system launches the simulation and parses the prediction request. Agents interact in parallel, and the system dynamically updates time-sequenced memory as events unfold.

### Step 4: Report generation
A ReportAgent interacts with the simulated environment and produces a structured prediction report.

### Step 5: Deep interaction
The user can interact with individual agents inside the world or continue querying the report layer.

## 4. What makes it different

MiroFish is not just "many agents answering in parallel." The differentiator is the attempt to simulate **emergent population behavior** rather than single-shot reasoning.

That means it is closer to:

- agent-based modeling with LLM-driven agents
- social simulation
- synthetic population forecasting
- scenario rehearsal

rather than:

- a normal chatbot
- a normal RAG app
- a single-agent planner

## 5. What it is probably good for

### Strongest plausible uses
- testing how a public reaction might fragment across groups
- rehearsing communications strategy before release
- probing second-order effects in policy or PR
- running synthetic focus-group style scenario exploration
- exploring branching narrative or social outcomes in fiction or entertainment

### More speculative uses
- market forecasting
- political forecasting
- macro social prediction

These are the most seductive claims, but they are also the most fragile. The system can be valuable as a **decision rehearsal engine** even if it is not truly a reliable oracle.

## 6. Practical limitations

- Output quality depends heavily on the seed data.
- Agent realism is constrained by the base models and memory design.
- Simulated populations are not the same as actual populations.
- Feedback loops, calibration, and validation are still the hard problem.
- It is easy to over-read believable simulations as accurate forecasts.

The operationally serious use case is not "predict the future with certainty." It is "surface plausible paths, social fractures, and failure modes before reality does."

## 7. Similar systems and what they were built for

### A. Generative Agents (Stanford / Google)
**What it is:** A landmark research system in which generative agents simulate believable human behavior inside a small virtual town.

**What it was built for:**
- immersive environments
- rehearsal spaces for interpersonal communication
- prototyping tools
- believable social behavior in simulated spaces

**Why it matters:** This is one of the clearest intellectual ancestors of systems like MiroFish. It showed that memory, reflection, and planning could produce surprisingly realistic social behavior in a synthetic population.

### B. OASIS (CAMEL-AI)
**What it is:** A large-scale open-source social media simulator for up to one million agents.

**What it was built for:**
- information spread analysis
- group polarization
- herd behavior
- social-media interaction research

**Why it matters:** OASIS is not just "similar" to MiroFish. It is directly acknowledged by the MiroFish repo as the simulation engine that powers it.

### C. Casevo
**What it is:** A cognitive-agent social evolution simulator built for social simulation on complex networks.

**What it was built for:**
- social network analysis
- public opinion dynamics
- behavior prediction in complex social systems
- discrete-event social simulation

**Example use in the paper:** The authors used a U.S. 2020 midterm election TV debate scenario to demonstrate the framework.

### D. AgentSociety
**What it is:** A large-scale social simulator for urban and societal modeling with LLM-driven agents.

**What it was built for:**
- urban simulation
- complex societal scenario modeling
- large-scale behavioral experiments
- social science research

**Why it matters:** This is one of the more serious "population simulation" frameworks aimed at structured societal environments rather than broad consumer forecasting.

## 8. Strategic read for Velorin

For Velorin, MiroFish matters less as a retail product and more as a **signal**:

- synthetic populations are moving from research novelty toward applied tooling
- scenario rehearsal is becoming a practical product category
- orchestration plus simulation may become a decision-support layer for strategy, politics, PR, finance, and consumer testing

The real takeaway is not "Velorin should copy MiroFish."
The real takeaway is:

- population simulation can become a decision-support module
- policy / PR / market rehearsal can be productized
- agent orchestration becomes more valuable when agents are embedded in environments rather than only answering prompts

## 9. Bottom line

MiroFish is an open-source Chinese-built swarm-intelligence simulation engine designed to build digital populations from real-world seed material and simulate how events may evolve.

Its core stack appears to be:
- OASIS for simulation
- GraphRAG for graph / world construction
- Zep for memory
- LLM API-compatible models, with Qwen recommended
- Python backend + Vue frontend + Docker deployment

Its strongest current value is not mystical future prediction. It is **decision rehearsal through synthetic populations**.

## Sources

- https://github.com/666ghj/MiroFish
- https://github.com/666ghj/MiroFish/blob/main/README-EN.md
- https://github.com/camel-ai/oasis
- https://arxiv.org/abs/2304.03442
- https://hai.stanford.edu/news/computational-agents-exhibit-believable-humanlike-behavior
- https://arxiv.org/abs/2412.19498
- https://github.com/rgCASS/casevo
- https://github.com/tsinghua-fib-lab/AgentSociety
- https://agentsociety.readthedocs.io/
