# ZONE 6 — UI/UX PRO MAX SKILL (nextlevelbuilder/ui-ux-pro-max-skill)

**What it is:** AI skill that provides design intelligence for building professional UI/UX across platforms. 49.7k stars. v2.1.1. Auto-generates complete design systems from project requirements. MIT license.

**Install:** `/plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill` then `/plugin install ui-ux-pro-max@ui-ux-pro-max-skill`

Or CLI: `npm install -g uipro-cli` then `uipro init --ai claude`

**What it contains:**
- 50+ UI styles (glassmorphism, minimalism, brutalism, neumorphism, bento grid, etc.)
- 161 color palettes by product type
- 57 font pairings with Google Fonts imports
- 161 product type recommendations with reasoning rules
- 99 UX guidelines and anti-patterns
- 25 chart types across 10 technology stacks
- Searchable BM25 + regex hybrid search engine

**Supported stacks:** HTML/Tailwind (default), React, Next.js, Vue, Nuxt.js, Nuxt UI, Svelte, ShadCN, Flutter, SwiftUI, React Native, Jetpack Compose

**How it works:**
1. You describe what you want ("Build a landing page for my SaaS product")
2. Skill auto-activates. Generates complete design system using reasoning engine
3. Searches databases for best matching styles, colors, typography
4. Implements UI with proper colors, fonts, spacing, best practices
5. Validates against common UI/UX anti-patterns before delivery

**Search domains:** product, style, typography, color, landing, chart, ux, brand, design-system, ui-styling, google-fonts

**Known issue:** Skill loading bug in Claude Code (#123) — folder structure mismatch. Fixed in v2.1.1 but verify after install.

**Why it matters for Velorin:**
- Turing Vault's landing page and results page could be designed using this skill instead of manual CSS work
- The design system generator produces consistent brand-aligned output — maps to Velorin's locked palette
- When Velorin productizes, every customer-facing interface benefits from this skill
- Susan (Replit) could use this via Claude Code for design decisions instead of building from scratch

**Velorin application:** Install on Claude Code. Use for all future front-end work including Turing Vault Phase 2, Velorin marketing site, and any customer-facing product UI.