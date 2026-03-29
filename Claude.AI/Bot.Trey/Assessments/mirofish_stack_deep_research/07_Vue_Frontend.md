# Vue Frontend

## Why the frontend is Vue

The MiroFish repo language breakdown shows a substantial Vue footprint, which is consistent with:
- dashboard-style UIs
- admin / operator consoles
- chat surfaces
- simulation controls
- report viewers

Vue is a component-based JavaScript framework that sits cleanly between:
- raw JS simplicity
- full SPA capability
- relatively low conceptual overhead

## What the frontend is probably doing in MiroFish

Likely responsibilities:
- seed material upload
- scenario configuration
- persona/environment setup UI
- simulation launch controls
- report viewing
- interactive chat with agents / report agent
- visual exploration of the simulated world

## Why Vue is a sensible fit

### Strengths
- component model is clean
- easy to build control panels and dashboards
- lower complexity curve than some React setups
- good for incremental UI composition
- strong ecosystem for charts/forms/router/state

### Weaknesses
- can become fragmented if not opinionated
- complex data-heavy worlds still need strong state management
- heavy interactive graph UIs may require additional libraries and performance work

## What a good MiroFish-style frontend should include

### 1. Operator shell
A stable application shell with:
- run list
- active simulation
- report access
- settings

### 2. Simulation launch panel
- input docs
- scenario selection
- parameter controls
- runtime knobs

### 3. World exploration UI
- entity panel
- community panel
- timeline
- event feed
- agent lookup

### 4. Interactive query UI
- ask the report agent
- talk to a specific agent
- inspect citations / evidence / memory

### 5. Export / compare
- report export
- run comparison
- branch comparison

## Where to get Vue

Official docs:
- `https://vuejs.org/guide/introduction`
- `https://vuejs.org/guide/quick-start`

Typical start path:
```bash
npm create vue@latest
cd my-app
npm install
npm run dev
```

## Docker relevance for Vue

Docker now has official Vue.js guides for containerizing Vue applications. That matters if you want:
- consistent local dev
- portable deployment
- production-ready builds
- compose-based full-stack startup

## ChatGPT integration path

ChatGPT does not consume Vue directly.

The integration pattern is:

### Option A — ChatGPT app with custom UI
If you want a native ChatGPT app experience, you do not simply drop in a Vue app unchanged. You expose tools and build the app using the Apps SDK / MCP path.

### Option B — external web app
Keep Vue as a separate web application and let ChatGPT call your backend tools via MCP or APIs.

This is often cleaner for serious products.

## Anthropic / Claude integration path

Claude does not have a “Vue plugin.”

Paths are:

### Option A — keep Vue external
Claude calls backend tools; the real operator UI remains your own Vue app.

### Option B — use Claude for control, Vue for rendering
Claude can operate or query backend systems; Vue remains the human console.

### Option C — internal desktop-extension mediated flows
Useful if Claude is being used as an operator front-end for internal staff.

## Velorin recommendation

For Velorin, Vue is useful if the company wants:
- a private operator dashboard
- a simulation control console
- research / graph exploration UI
- executive brief viewer

Do not confuse:
- conversational interface
with
- operational dashboard

You usually need both.

## Risks

- chat-only experience with no operational console
- dashboard-only experience with weak conversational access
- poor state management for long-running jobs
- weak loading / run-status handling
- no evidence drill-down

## Decision

Vue is a solid frontend choice for this category. The value is not “Vue because Vue.” The value is a controlled operator surface for a system that is too stateful and too structured to live only inside chat.

## Sources

- MiroFish repo language breakdown and structure
- Vue official docs
- Docker’s official Vue containerization guides
