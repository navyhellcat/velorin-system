# ZONE 5 — AWESOME CLAUDE CODE (hesreallyhim/awesome-claude-code)

**What it is:** The definitive curated index of Claude Code extensions. 28.6k stars. 1.9k forks. Maintained by hesreallyhim and community. Categories: skills, hooks, slash commands, agent orchestrators, applications, plugins.

**Why it matters:** This is the discovery layer. Every tool, skill, and plugin that exists for Claude Code is cataloged here. No Velorin bot has referenced it.

**Key items from the index relevant to Velorin:**

**Agent orchestrators:**
- Simone — Project management workflow for Claude Code. Documents, guidelines, processes for planning and execution
- AgentSys — Workflow automation with plugins, agents, skills. PR management, code cleanup, drift detection, multi-agent code review
- Ralph — Autonomous AI development framework. Runs Claude Code in automated loops until specs are fulfilled. Circuit breaker patterns, rate limiting, safety guardrails. REVISED STATUS: Approved for Tier 1 adoption, scoped to substrate-level coding and individual task bots only. Not approved at orchestrator level.
- Claude Code Agents (UndeadList) — E2E development workflow with subagent prompts for solo devs

**Skills repos:**
- Claude Scientific Skills (K-Dense) — Research, science, engineering, analysis, finance, writing. Described as "one of the best skills repos on GitHub"
- cc-devops-skills — DevOps engineering. IaC for any platform. Worth downloading as documentation alone
- Book Factory — Publishing pipeline for nonfiction using specialized skills

**Memory and context:**
- claude-mem — Captures everything Claude does during sessions, compresses with AI, injects into future sessions
- Claude Code Context Restorer — Restores context from previous sessions via session files and git history. Handles 2GB session files

**Security:**
- parry — Prompt injection scanner for hooks. Scans inputs/outputs for injection attacks, secrets, data exfiltration

**Utilities:**
- n8n-MCP — Build n8n workflows from Claude Desktop/Code via natural language
- Untether — Telegram bridge for Claude Code. Send tasks by voice or text, stream progress, approve changes from phone

**Output styles:**
- awesome-claude-code-output-styles — Override Claude Code's default system prompt. Custom personas and specialized modes

**Velorin application:** This index should be bookmarked and referenced by Alexander and Jiang whenever evaluating build tools. It is the ecosystem map that was missing from every prior session.