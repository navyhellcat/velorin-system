# Python 3.11–3.12 and uv

## Why MiroFish pins this range

MiroFish documents:
- Python >= 3.11 and <= 3.12
- uv as the Python package manager

That is a deliberate compatibility window.

## Why not “latest Python”

In AI and simulation stacks, “latest” is often not the safest choice because:
- transitive dependencies lag
- compiled packages lag
- graph / ML / serving stacks are sensitive to version drift
- reproducibility matters more than novelty

Pinning 3.11–3.12 is a stability decision.

## Why 3.11 is attractive

Python 3.11 brought substantial performance improvements over 3.10. The Python docs describe it as **10–60% faster**, with about **1.25x average speedup** on the benchmark suite.

That matters for:
- orchestration-heavy backends
- repeated simulation loops
- API performance
- background jobs

## Why 3.12 is attractive

Python 3.12 is stable and continues cleanup/performance work. It also removed deprecated standard library pieces like `distutils`, which matters for modern packaging assumptions.

## Why uv matters

uv is a fast Python package and project manager written in Rust. It is meant to replace a pile of older tools and gives:
- fast dependency installs
- environment management
- Python version management
- script execution
- lockfile / project tooling

For a repo like MiroFish, uv reduces setup friction.

## What uv is doing operationally here

The MiroFish README indicates backend setup auto-creates the Python environment. uv is probably being used to:
- create/manage the virtual environment
- install pinned dependencies
- standardize project setup
- make onboarding less fragile

## Where to get them

### Python
- `https://www.python.org/downloads/`

### uv
- `https://docs.astral.sh/uv/`

Official uv install examples:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

or package manager alternatives.

## Why this combo is strong

Python 3.11/3.12 + uv gives:
- mature runtime
- modern packaging
- faster setup
- lower onboarding pain
- cleaner reproducibility

That is especially useful when a project mixes:
- frontend setup
- backend setup
- Docker option
- long-lived local dev work

## ChatGPT integration path

No direct connector here.

These are runtime/developer-environment choices.

ChatGPT-relevant use:
- build the MCP server in Python
- build orchestration tools in Python
- run retrieval/simulation/reporting backends in Python
- expose those tools to ChatGPT through MCP or APIs

## Anthropic / Claude integration path

Same logic.

These choices matter because:
- Claude Code works well with Python projects
- MCP servers can be written in Python
- Claude-facing tools often run on Python backends

But Claude is not integrating with “Python 3.11” as a product surface. It is integrating with services built on top of it.

## Velorin recommendation

For reproducible internal systems:
- pin the Python minor version
- standardize uv
- avoid ad hoc pip usage
- treat the runtime as part of the architecture, not a developer preference

## Risks

- silent dependency breakage on Python 3.13+
- mixed local environments
- no lock discipline
- pip / venv / pyenv / poetry fragmentation across developers

## Decision

The Python 3.11–3.12 + uv combination is one of the more sensible parts of the MiroFish stack. It is a signal that the team chose stability and onboarding speed over novelty.

## Sources

- MiroFish README prerequisites
- Python.org docs for 3.11 and 3.12
- uv official docs
