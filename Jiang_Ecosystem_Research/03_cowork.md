# ZONE 3 — CLAUDE COWORK

**What it is:** Anthropic's agentic AI system for knowledge work. Runs on desktop. Completes multi-step tasks autonomously. Research preview, available on Pro/Max/Team/Enterprise plans. Launched January 2026. Major updates through March 2026.

**Core capability:** Describe an outcome, step away, come back to finished work. Not chat — task delegation. Claude reads, edits, and creates files in folders you grant access to.

**Key features as of March 28, 2026:**
- Scheduled tasks — Daily, weekly, hourly, on-demand. Each task spins up its own session with full tool access. Set via /schedule or sidebar
- Computer Use — Opens apps, navigates browser, fills spreadsheets, clicks buttons. No setup. macOS and Windows. Launched March 23, 2026
- Dispatch — Persistent conversation accessible from phone and desktop. Assign tasks from phone, Claude works on desktop
- Projects — Group related tasks into workspaces with their own files, context, instructions, and memory
- Plugins — Pre-built role-specific toolkits (sales, marketing, legal, finance, data analysis, product management). Marketplace launched February 2026
- Connectors — Google Drive, Gmail, Slack, DocuSign, FactSet, Microsoft 365 (Team/Enterprise), and custom MCP connectors
- Memory — Retains context across sessions. Free for all users since March 2, 2026
- Claude in Chrome — Browser control from within Cowork

**Scheduled task examples documented in the wild:**
- Morning brief: Check Slack channels, summarize overnight activity, write to markdown file. Daily 7:30 AM
- Weekly client report: Pull from project notes, summarize deliverables, format for sending. Fridays 4 PM
- Metrics pull: Export analytics dashboard data to weekly report template

**Constraints:**
- Desktop app must remain open while working
- Cowork conversation history stored locally, not on Anthropic servers
- Not captured in Audit Logs, Compliance API, or Data Exports (yet)
- Consumes more usage allocation than chat — complex tasks are token-intensive
- Computer Use is research preview with safeguards. Claude requests permission before accessing new apps

**Why it matters for Velorin:**
- Scheduled tasks are the EndOfDay Protocol automation bridge Jiang identified. No custom build required
- Computer Use eliminates the "Alexander can't type into Jiang's session" problem — Cowork can navigate to Claude.ai and interact with it
- Dispatch means Christian Taylor can assign tasks from phone while away from desk
- Connectors to Google Drive, Gmail, Slack are live and ready — no MCP build needed for these
- Projects feature maps directly to Velorin's box structure — one project per box or per product

**Velorin application:** Install Cowork plugins relevant to each box. Create scheduled tasks for EndOfDay protocol, morning brief, and weekly pipeline review. Use Computer Use for cross-session agent coordination until Path 3 API is built.