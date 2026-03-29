VELORIN — TOOLS, PLATFORMS & URLS
Master Reference | Layer 0 | All Agents
Last updated: March 26, 2026


★ = Currently active and in use
No marker = Identified for future use / under evaluation


Color note: In Google Docs, active tools (★) should be formatted green manually. Bots read ★ as the active marker.


---


SECTION 1 — AI AGENTS & PLATFORMS


★ Claude Desktop (Alexander — CEO)
Primary operating environment for Alexander. MCP-connected. GitHub MCP, velorin-gdrive MCP, Claude in Chrome all run from here. Always on Mac unless Christian Taylor states otherwise.
Platform: Anthropic | Access: Pro/Max subscription


★ Claude.ai Browser (Jiang — browser-based agent)
Browser-based Claude sessions. Separate machine from Desktop. No MCP access. Projects provide boot context. Running on Sonnet 4.6 by default.
Platform: Anthropic | URL: https://claude.ai


★ ChatGPT / Trey (browser-based permanent consultant)
OpenAI GPT. External consultant. Browser session on separate machine. Files delivered manually by Christian Taylor via upload.
Platform: OpenAI | URL: https://chatgpt.com
Trey Velorin project: https://chatgpt.com/g/g-p-69c38c44eee4819186a6159085b024a5-trey-consultant-velorin-c-suite-access


★ Replit / Susan (browser-based consultant)
Turing Vault codebase. External to Velorin system. Files delivered manually by Christian Taylor via upload.
Platform: Replit | URL: https://replit.com
Turing Vault live: https://turingvault.replit.app
Replit scraping tool: https://af2b5e3b-bab6-43c7-b64a-cc69e1a526d9-00-2rg5ckyf921m0.picard.replit.dev/jobs/new


★ Claude Code v2.1.84
Agentic CLI coding tool. Installed on Mac. Authenticated as ctcamardella@gmail.com. Available when terminal is open.
Platform: Anthropic


Claude Cowork
Desktop agent. Scheduled recurring tasks, local filesystem access, MCP connectors. Evaluate for EndOfDay protocol automation — may replace custom build.
Platform: Anthropic | Available: All paid plans


Claude in Chrome
Browser automation extension. Alexander uses for inter-agent communication. Operational on Mac Desktop.
Platform: Anthropic | Supported: Chrome and Edge only


Claude for Excel / Claude for PowerPoint
Microsoft Office add-ins. Low priority for current phase.
Platform: Anthropic


MODEL SELECTION POLICY:
Alexander (CEO): Sonnet 4.6 default. Opus for high-stakes reasoning only.
Jiang: Opus 4.6 for deep research. Sonnet for operational sessions.
Haiku 4.5: Use for high-volume automation workflows, n8n-triggered API calls.
Cost reference: Opus $5/$25 per MTok in/out. Sonnet $3/$15. Haiku $1/$5.
Sonnet with prompt caching: approximately $0.20-0.60 per orchestrated session.


---


SECTION 2 — DEVELOPMENT & HOSTING


★ GitHub — velorin-gdrive-mcp (private repo)
Version control for MCP server. GitHub MCP connected to Desktop.
URL: https://github.com/navyhellcat/velorin-gdrive-mcp
Auth: PAT in claude_desktop_config.json


★ Google Cloud Console
OAuth credentials for velorin-gdrive MCP. Project: core-craft-437617-m5
Client ID: 165643400314-fatf832u60e0mqu3lctf9uv5s56bsiln
URL: https://console.cloud.google.com


★ Replit
Turing Vault hosting and development environment. Susan's workspace.
URL: https://replit.com


n8n
Core automation backbone. Native MCP support — Claude Desktop builds/triggers workflows via natural language using n8n-MCP npm package. Not yet installed. First task in Phase 4.
Options: Cloud $20/mo or self-hosted free | URL: https://n8n.io


Claude Agent SDK
Production SDK for autonomous agents. Python and TypeScript. Primary Path 3 runtime. Next major build target.
Docs: https://docs.anthropic.com/en/docs/claude-code/sdk


---


SECTION 3 — ANALYTICS & TRACKING


★ PostHog
Product analytics. Funnel analysis, session replay, A/B testing. Account live March 26, 2026.
URL: https://us.posthog.com/project/358346
Project Token: phc_wW4QsJRrcmS0WRhFpRDxpICArX4S8FJyed77DTgOXMz
Project ID: 358346 | Cost: Free (1M events/mo)
Status: Account created. Install snippet pending (Susan).


Google Analytics 4
Traffic attribution and SEO conversion tracking. Install alongside PostHog.
URL: https://analytics.google.com | Cost: Free


Google Search Console
SEO monitoring, keyword data, sitemap submission. Install Day 1. MCP connector available.
URL: https://search.google.com/search-console | Cost: Free


Microsoft Clarity
Free heatmaps and session recordings.
URL: https://clarity.microsoft.com | Cost: Free


Metricool
Unified social analytics dashboard.
URL: https://metricool.com | Cost: Free / $22/mo


Semrush
Keyword research, competitor analysis. Start after first content exists.
URL: https://semrush.com | Cost: $130/mo


Surfer SEO
On-page content optimization.
URL: https://surferseo.com | Cost: $89/mo


Otterly AI
GEO monitoring — tracks mentions in ChatGPT, Perplexity, Claude.
URL: https://otterly.ai | Cost: ~$49/mo


---


SECTION 4 — EMAIL, DOMAINS & INFRASTRUCTURE


★ Resend
Email delivery. Verified domain: generalatomics.us. Sender: noreply@generalatomics.us.
URL: https://resend.com | Auth: Gmail login


★ Cloudflare
DNS for generalatomics.us.
URL: https://dash.cloudflare.com | Auth: Gmail login


★ generalatomics.us
Active domain. Turing Vault email infrastructure. Org name used consistently across platforms (PostHog, Stripe, etc).


beehiiv
Newsletter platform. Email list growth. Connect to Turing Vault completion screen for email capture.
URL: https://beehiiv.com | Cost: Free to 2,500 subs / $42/mo


---


SECTION 5 — PAYMENT & FINANCIAL


★ Stripe
Payment processing. Account: Turing_Vault. $2.71 product configured.
URL: https://dashboard.stripe.com | Auth: Gmail login
Live product ID: prod_UDL06Zvkotayuy


★ Square
Active account.
URL: https://squareup.com | Auth: Gmail login


---


SECTION 6 — SOCIAL MEDIA & SCHEDULING


Typefully
X, LinkedIn, Threads, Bluesky scheduler. API → n8n integration for draft queue.
URL: https://typefully.com | Cost: $12/mo


Buffer
Multi-platform video scheduling fallback.
URL: https://buffer.com | Cost: $6/channel/mo


Repurpose.io
Auto cross-post TikTok → Reels → Shorts → LinkedIn Video → Twitter Video.
URL: https://repurpose.io | Cost: $25/mo


Platform priorities (register all as @TuringVault):
X/Twitter — HIGHEST | TikTok — HIGH | Instagram Reels — MEDIUM
YouTube Shorts — MEDIUM | LinkedIn — MEDIUM | Bluesky/Threads — LOW (auto)
Reddit — HIGH but manual only, zero automation


---


SECTION 7 — VIDEO & CONTENT CREATION


OpusClip
Long video → short clips with virality scoring.
URL: https://opus.pro | Cost: Free / $15/mo


AutoShorts.ai
Fully automated faceless short video.
URL: https://autoshorts.ai | Cost: ~$29/mo


CapCut
Free video editing, AI captions, noise removal.
URL: https://capcut.com | Cost: Free


Canva
Branded templates, stat cards, OG images. MCP connector in beta.
URL: https://canva.com | Cost: Free / $15/mo


---


SECTION 8 — OUTREACH & CRM


Clay
Creator and newsletter list building. MCP connector available.
URL: https://clay.com | Cost: $149/mo


Apollo
B2B contacts. Phase 3 only.
URL: https://apollo.io | Cost: $99/mo


Instantly
Cold email sequencing. Activate after first paid offer proven.
URL: https://instantly.ai | Cost: $37/mo


SparkLoop
Newsletter referral network. Activate after 1,000 subscribers.
URL: https://sparkloop.app


---


SECTION 9 — MCP SERVERS


★ velorin-gdrive-mcp v1.3.1 (custom, operational)
Drive read/write from Desktop. 8 tools live.
Repo: https://github.com/navyhellcat/velorin-gdrive-mcp
Mac path: /Users/lbhunt/Desktop/Velorin /Velorin Code/velorin-gdrive-mcp/
Config: ~/Library/Application Support/Claude/claude_desktop_config.json


★ GitHub MCP (operational)
Connected via @modelcontextprotocol/server-github (npx). Read/write to GitHub repos from Desktop.


n8n-MCP (planned — Phase 4)
Connects Desktop to n8n. Package: czlonkowski/n8n-mcp


Jiang v1.3.2 (planned — next build)
Adds: gdrive_create_folder, gdrive_move_folder, MCP keepalive, Google Sheets and Apps Script scopes.


Google Search Console MCP (available)
Pull GSC data directly into Alexander sessions.


Canva MCP (available, beta)
Design operations from Desktop.


Clay MCP (available)
Outreach list building from Desktop.


---


SECTION 10 — VELORIN ACTIVE PROJECT URLS


Google Drive root folder (Claude.AI):
https://drive.google.com/drive/u/0/folders/1WLkeuV8Jb2rhN3v9zAlbO0-Xi0xQlmy1


Bot.Alexander:
https://drive.google.com/drive/u/0/folders/1kEodNFJ88Ktfyv_hGxTiVd9Sv9obhljC


Bot.Jiang:
https://drive.google.com/drive/u/0/folders/1V_rvRMtex4bQgYrEJE-jm9qaDp9W_omp


Bot.Trey:
https://drive.google.com/drive/u/0/folders/1liF-zNu_zya5W58OmBLPyMWnc_pKJyjs


Bot.Replit (Turing Vault home):
https://drive.google.com/drive/u/0/folders/1kPBIj2LaD4T9YnfJ0zQq0ZDjLFBdar6D


GitHub — velorin-gdrive-mcp:
https://github.com/navyhellcat/velorin-gdrive-mcp


Turing Vault live site:
https://turingvault.replit.app


PostHog dashboard:
https://us.posthog.com/project/358346


Stripe dashboard:
https://dashboard.stripe.com


Cloudflare:
https://dash.cloudflare.com


Google Cloud Console (MCP OAuth):
https://console.cloud.google.com


Resend:
https://resend.com


Square:
https://squareup.com


[VELORIN.EOF]


Velorin.Tools.And.URLs | Layer 0 | All Agents | March 26, 2026
