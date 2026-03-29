# Docker Support

## What Docker support means in the MiroFish stack

MiroFish offers two deployment modes:
- source deployment
- Docker deployment

The documented Docker path is:
```bash
cp .env.example .env
docker compose up -d
```

with ports mapped for:
- frontend: 3000
- backend: 5001

That means the team expects at least a baseline full-stack local deployment story through containers.

## Why Docker matters here

Without Docker, a stack like this has a high chance of environment drift:
- wrong Node version
- wrong Python version
- missing system dependencies
- frontend and backend starting inconsistently
- teammate onboarding friction

Docker reduces that.

## What Docker is doing conceptually

Docker lets you package:
- OS-level dependencies
- runtime versions
- app files
- startup commands

Docker Compose then lets you define and run multiple services together.

For MiroFish-like systems, Compose is the useful part because the app is multi-service:
- frontend
- backend
- possibly memory service
- maybe supporting infrastructure

## Why this is strategically important

A system that needs:
- Python
- uv
- Node
- npm
- environment variables
- backend/frontend coordination

will become operationally painful without containers.

## Where to get Docker

Official:
- Docker Desktop: `https://docs.docker.com/desktop/`
- Docker Compose docs: `https://docs.docker.com/compose/`

Docker now also publishes official language/framework guides, including Vue.js containerization guidance.

## What a good Docker setup should include

### Minimum
- Dockerfile(s)
- docker-compose.yml
- env var loading
- port mapping
- restart policy
- persistent volumes where needed

### Better
- separate dev and prod compose files
- health checks
- slim production images
- clear secrets policy
- explicit dependency startup ordering

## What MiroFish publicly documents

The README confirms:
- Dockerfile present
- docker-compose.yml present
- `docker compose up -d`
- `.env` loaded from root
- 3000 / 5001 exposed

That is enough to show the repo is designed for practical local deployment, not only manual hand-built setup.

## ChatGPT integration path

Docker is not a connector. It is deployment substrate.

But it matters for ChatGPT because:
- MCP servers often need consistent deployment
- remote app backends must run somewhere stable
- Docker makes it easier to host your ChatGPT-facing app/tool infrastructure

Practical pattern:
- package your MCP server and backend services with Docker
- deploy behind HTTPS
- connect ChatGPT via Apps SDK / MCP

## Anthropic / Claude integration path

Same logic:
- Dockerize the MCP server
- Dockerize the backend
- optionally package local-only flows with Claude Desktop extension bundles for installation ease

Docker is especially useful when you want:
- internal deployment consistency
- private remote MCP services
- local dev parity for Claude Code / Desktop workflows

## Velorin recommendation

If Velorin builds internal tool infrastructure:
- Docker should be standard
- local dev should work from a single compose entry point
- every non-trivial service should have a container story
- MCP servers should be deployable the same way across environments

## Risks

- one giant container instead of service separation
- secrets baked into images
- no health checks
- no volume strategy for persistent state
- different commands between source and Docker modes

## Decision

Docker support is not optional polish in this kind of stack. It is operational hygiene. MiroFish having a documented Docker path is a sign the team cares about reproducible startup, not just code release.

## Sources

- MiroFish README Docker deployment section
- Docker Desktop docs
- Docker Compose docs
- Docker official Vue guides
