# ZONE 7 — OBSIDIAN SKILLS (kepano/obsidian-skills)

**What it is:** Official agent skills for Obsidian, built by Steph Ango (kepano), CEO of Obsidian. 9.7k stars. Teaches AI agents to understand and create Obsidian-specific file formats. Follows Agent Skills specification. MIT license.

**Install (Claude Code):** `/plugin marketplace add kepano/obsidian-skills` then `/plugin install obsidian@obsidian-skills`

**Skills included:**
- obsidian-markdown — Obsidian-flavored Markdown: [[wikilinks]], callouts, frontmatter/YAML properties, tags, embeds (![[file]]), and all syntax that differs from standard Markdown
- obsidian-bases — Obsidian's structured data layer. Databases built on top of notes with typed properties, filters, sorts, views. CRM tables, sprint trackers, research databases
- json-canvas — JSON Canvas format for visual whiteboards. Nodes, edges, groups, spatial layouts that render as interactive canvases
- obsidian-cli — Command line interface for vault operations

**Cross-platform:** Works with Claude Code, Codex CLI, Gemini CLI, OpenCode. Same SKILL.md runs across all.

**Known issue:** #10 — Claude Code interprets `!` in skill markdown as Bash command. Fixed in recent versions but verify.

**Why it matters for Velorin:**
- If Velorin transitions from Google Drive to a local-first knowledge base (which the Session 006 pivot toward GitHub already signals), Obsidian is the natural substrate
- Obsidian vaults are just folders of .md files — compatible with Claude Code, CLAUDE.md patterns, MCP, and the file-over-app principle
- The Bases feature (structured data on top of notes) could replace the Google Sheets/Drive hybrid for project tracking
- JSON Canvas could replace the visual architecture planning currently done in chat
- kepano building this officially means Obsidian's roadmap includes AI agent interoperability as a first-class concern

**Velorin application:** Evaluate Obsidian as the Layer 0 knowledge substrate for Velorin post-machine-arrival. The vault would hold all bot ReadMe files, knowledge web documents, and operational logs — all readable by Claude Code natively with no boot protocol needed.