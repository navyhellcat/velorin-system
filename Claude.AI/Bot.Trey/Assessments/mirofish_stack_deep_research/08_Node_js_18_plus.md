# Node.js 18+

## Why Node.js is in the stack at all

MiroFish explicitly requires **Node.js 18+** for the frontend runtime. That does not mean the whole system is a Node backend. It means the frontend build/dev toolchain depends on Node and npm.

In a stack like this, Node normally covers:
- frontend package installation
- bundling
- dev server
- build pipeline
- possibly root-level scripts that start both frontend and backend

## Why 18+ specifically matters

Node 18 introduced browser-like globals such as:
- `fetch`
- `FormData`
- `Headers`
- `Request`
- `Response`

That reduced friction in modern full-stack tooling and is one reason many front-end and developer-tool stacks standardized on Node 18 as a baseline.

## What MiroFish is likely using Node for

From the README:
- frontend runtime
- npm
- root-level setup scripts
- dev orchestration commands like `npm run dev`
- combined dependency install / startup flows

The repo also includes:
- `package.json`
- `package-lock.json`
- `frontend/`
- root-level npm setup commands

So Node is operationally important even if the backend is Python.

## Where to get Node.js

Official:
- `https://nodejs.org/`

MiroFish says:
- Node.js 18+

That means:
- minimum supported baseline = 18
- newer versions may work, but 18+ is the documented floor

## Why this matters to operators

If a team member installs the wrong Node version:
- frontend dependency resolution can fail
- build tools can behave inconsistently
- dev server behavior can diverge
- lockfile assumptions can break

For reproducible teams, Node version pinning matters.

## Best practice for this stack

Use one of:
- `.nvmrc`
- Volta
- asdf
- containerized frontend

That avoids “works on my machine” front-end startup failures.

## ChatGPT integration path

There is no direct “Node connector.”

Node is infrastructure, not an app feature.

Relevant ChatGPT paths:
- a Node-based MCP server
- a Node-based app backend for the Apps SDK
- a Node-based deployment wrapper around your tools

In other words: ChatGPT can integrate with systems built using Node, but it does not care that Node exists unless you expose tool endpoints.

## Anthropic / Claude integration path

Same principle.

Claude can interact with:
- MCP servers built in Node
- services built with Node
- apps packaged through Claude-compatible extension flows

But Node itself is not the integration surface. MCP / API is.

## Velorin recommendation

For internal platform work:
- keep Node use narrow and deliberate
- use it for frontend / app tooling
- do not spread business logic across Python and Node without clear boundaries

## Risks

- frontend startup tied to undocumented Node assumptions
- scripts that implicitly assume specific shell behavior
- too much shared orchestration logic in npm scripts
- no version management policy

## Decision

Node 18+ is a practical frontend/runtime dependency, not the intellectual center of the stack. Treat it as build infrastructure, pin it, and keep product logic elsewhere unless you have a real reason not to.

## Sources

- MiroFish README prerequisites and startup commands
- Node.js official release announcement for Node 18
