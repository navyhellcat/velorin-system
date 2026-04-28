# Report Generation

## What this stage does

MiroFish’s fourth workflow stage says:

- ReportAgent has a rich toolset
- it interacts deeply with the post-simulation environment

That means report generation is not a static export. It is an **analysis layer over the finished simulation state**.

## Why report generation matters

A simulation that cannot explain itself is not operationally useful.

Decision-makers do not want:
- raw event logs
- thousands of agent traces
- opaque latent dynamics

They want:
- what happened
- why it happened
- which actors mattered
- what paths are likely next
- what interventions change the result

The report layer is where the simulator becomes a product.

## What a strong simulation report should contain

### 1. Scenario statement
What was simulated?
What inputs were used?
What prediction question was asked?

### 2. World assumptions
What environment rules were used?
What persona generation assumptions were used?
What external variables were injected?

### 3. Major outcomes
What emerged?
What changed?
What factions, narratives, or cascades became dominant?

### 4. Mechanisms
Why did the result occur?
Not just “what happened,” but:
- which memories mattered
- which relationships mattered
- which events shifted the trajectory

### 5. Critical actors
Which agents or clusters were pivotal?

### 6. Confidence / stability
Was this outcome robust across runs, or brittle?

### 7. Intervention options
What changes would likely alter the trajectory?

### 8. Evidence trace
What simulation states, logs, or source materials support the claims?

## What “ReportAgent with a rich toolset” probably means

The repo does not publish the full agent design, but the wording suggests a report agent that can:
- query simulation state
- inspect agent histories
- inspect world summaries
- synthesize outcomes
- answer follow-up questions
- maybe compare branches or episodes

That is important: the report is probably not produced by one blind LLM pass. It likely uses tools to explore the simulated world after the run.

## Strong architecture pattern

Best practice is:

1. simulation completes or reaches a checkpoint
2. report agent gets access to tools
3. report agent queries:
   - aggregate metrics
   - narrative clusters
   - key agents
   - timeline inflection points
4. report agent writes:
   - executive summary
   - mechanisms
   - evidence-backed interpretation
5. report remains interactive afterward

That final point matters. Report generation should flow naturally into interactive querying.

## Where to get it

This is not a purchased product category. You build it from:

- your simulation state schema
- your analytics tooling
- your LLM/tool-calling layer
- your visualization/export layer

Upstream references:
- MiroFish repo
- OASIS outputs and architecture
- GraphRAG summaries and graph queries
- standard LLM agent report-generation patterns

## How it should work technically

### Data sources
- run metadata
- event logs
- memory snapshots
- community summaries
- agent-level traces
- environment-state changes

### Tools the report agent should have
- timeline query
- agent query
- cluster query
- causal chain query
- top-influencer query
- compare-runs query
- narrative summary query

### Outputs
- markdown
- HTML dashboard
- PDF / DOCX export
- structured JSON for downstream systems

## ChatGPT integration path

### Best path
Expose the report system through an MCP-backed ChatGPT app:
- `generate_report`
- `get_run_summary`
- `get_top_actors`
- `compare_runs`
- `explain_outcome`

### Good UI pattern
A ChatGPT app can present:
- executive brief
- drill-down tabs
- charts
- run comparison
- “ask the simulation” follow-up panel

### Weak path
Uploading raw logs into chat is bad. It wastes context and loses tool interactivity.

## Anthropic / Claude integration path

### Best path
Remote MCP server with tool-enabled reporting.

### Good additions
- Claude Skill for report quality standards
- Claude Desktop / Claude Code for internal operator workflows
- MCP bundle if internal teams need one-click local install

## Velorin relevance

This layer is extremely relevant to Velorin because the company does not just need simulations. It needs **decision-grade outputs**.

Potential use cases:
- strategic memos
- policy war-games
- market simulations
- founder operating scenario reports
- cross-box consequence briefs

This is also where Velorin can differentiate:
- not “we ran a simulation”
- but “we ran a simulation and can explain the mechanisms cleanly”

## Failure modes

- pure narrative with no evidence path
- overconfident causal language
- no distinction between source assumptions and simulated emergence
- failure to compare alternate runs
- generic executive summary with no mechanism analysis

## Recommended operating standard

Every report should include:
- assumptions
- main outcome
- mechanism explanation
- major actors
- intervention levers
- uncertainty statement
- evidence trail

## Decision

Report generation is not a cosmetic last step. It is the interface between simulation and human action.

## Sources

- MiroFish README workflow
- OASIS architecture paper
- GraphRAG docs and research posts
