TURING VAULT — GROWTH ARCHITECTURE
Social Media  ·  SEO  ·  Automation  ·  Distribution  ·  Agent Stack
Velorin System — Bot.Alexander  |  March 27, 2026  |  For: Christian Taylor
Read with Turing_Vault_Execution_Stack as companion document.


PHASE 0 — PREREQUISITES
Do not scale traffic until all items in this phase are complete. Every dollar spent on traffic before this layer is done goes into a leaky pipe. Payment does not work. Tracking does not exist. There is no email list. Fix the pipe first.


0.1 Stripe Payment Infrastructure — URGENT
Replace all placeholder payment links with live Stripe hosted checkout URLs. Implement webhook signature verification on every inbound Stripe event. Without this, the $2.71 IQ Vault payment cannot process.
* Tools: Stripe Dashboard, Claude Code, Replit Agent (Susan)


0.2 Analytics and Event Tracking — URGENT
Install PostHog AND Google Analytics 4 in parallel. PostHog for product funnel analysis (session replay, funnels, A/B testing). GA4 for SEO traffic attribution and Google Search Console integration. Without tracking, you cannot know which channel works.
* Tools: PostHog, Google Analytics 4, Google Search Console, Microsoft Clarity (free heatmaps)
Events to instrument immediately
* page_load → mode_select → test_start → question_answered → test_complete → score_viewed → leaderboard_submit → email_opt_in → payment_click → payment_success
UTM parameter structure
* Tag every external link: utm_source (platform), utm_medium (organic/paid/creator), utm_campaign (angle), utm_content (specific post ID)


0.3 Email Capture on Completion Screen — URGENT
Add opt-in prompt at test completion screen before score reveal OR as part of leaderboard submission. This is the owned audience entry point. Without it, all traffic is anonymous and unreturnable.
* Tools: beehiiv, Claude Code / Replit


0.4 Share / Challenge Prompt After Completion
Single 'Challenge a friend' or 'Post your score' button with pre-filled text and a URL to the site. This is the primary viral loop mechanism. Every person who completes becomes a potential distributor.


0.5 Basic Legal / Privacy Language
Privacy policy covering data capture, response storage, and session data. Required before running paid ads or collecting email addresses. Template-generated and adapted is acceptable.


PHASE 1 — SEO FOUNDATION
Weeks 1-3. Long-term compounding traffic layer. Turing Vault has a significant programmatic SEO opportunity using live score data as proprietary seed content. SEO is the only channel that compounds without ongoing spend.


1.1 Technical SEO Setup
Meta tags + Open Graph for all pages
Every page needs: title tag (50-60 chars), meta description (150-160 chars), og:title, og:description, og:image (1200x630 branded card). The og:image should pull in live score distribution numbers dynamically.
* Tools: Claude Code, Replit
Schema Markup (JSON-LD)
Add WebApplication schema with ratings. Add FAQPage schema. Add HowTo schema for challenge mechanics. These trigger Google rich results and AI Overview citations.
* Tools: Claude Code, Schema.org
Sitemap.xml + Robots.txt
Dynamically generated sitemap submitted to Google Search Console. Block admin routes. Allow all content pages and challenge modes.
Page Speed — Core Web Vitals
Google uses LCP, FID, and CLS as ranking signals. Run PageSpeed Insights. Target LCP under 2.5s on mobile. Replit infrastructure needs evaluation here.
* Tools: PageSpeed Insights (free), Google Search Console
Canonical URLs
Every page needs a canonical URL to prevent duplicate content penalties as landing page variants are built out.


1.2 Programmatic SEO — The Score Data Asset
Turing Vault has real, live, proprietary human judgment data. This is the foundation for programmatic SEO pages that cannot be replicated by competitors.
Keyword Architecture
Target keyword clusters: 'can you tell AI from human writing' / 'AI detection test' / 'spot AI writing quiz' / 'human vs AI writing challenge' / 'AI detection accuracy' / 'adversarial AI prompts' / 'does AI writing fool you' / 'AI slop detector'.
* Tools: Semrush ($130/mo), Ahrefs ($99/mo), Google Keyword Planner (free)
Programmatic Page Types to Build
* Mode-specific landing pages: /challenge/standard, /challenge/hard, /challenge/adversarial — each with live score distributions, average accuracy rates, mode description, and SEO-optimized copy.
* Score report pages: /results/score-distribution, /results/by-mode, /results/leaderboard — live aggregate stats updated continuously. Proprietary data that Google trusts.
* Comparison pages: /vs/gpt4, /vs/claude, /vs/gemini — 'How well can humans detect [model] output?' Captures long-tail queries from researchers and journalists.
* Use-case landing pages: /for/writers, /for/teachers, /for/recruiters, /for/journalists — distinct keyword targets per audience.
Content SEO — Blog Layer
3-5 long-form articles targeting high-volume informational keywords. Topics: 'How to spot AI-written content in 2026' / 'AI detection accuracy rates by model' / 'Why humans are getting worse at identifying AI text' / 'The anti-slop guide for editors'.
* Tools: Surfer SEO ($89/mo), Claude for content drafts, Alexander for content briefs


1.3 GEO — Generative Engine Optimization
In 2026, ChatGPT, Perplexity, Claude, and Google AI Overviews are answering queries before users click. Turing Vault needs to appear in these answers. Key tactics: structured data schema, authoritative content that AI models cite, presence in AI evaluation communities.
* Tools: Semrush AI Visibility tracker, Otterly AI (tracks AI citations, ~$49/mo)


1.4 Backlink Strategy — Earned Only
Turing Vault's best backlinks are earned through controversy and newsworthiness. Tactics: Product Hunt submission, mention in AI newsletter roundups, quoted in journalism about AI detection, reach AI safety community (LessWrong, Alignment Forum).
* Tools: Product Hunt (free), Hacker News Show HN, Clay (journalist outreach list)


1.5 SEO Monitoring Stack
* Google Search Console — free — install day 1
* GA4 — free — install day 1
* Semrush Position Tracking — $130/mo — start after content exists
* n8n workflow: weekly GSC API pull → Drive report → Alexander summary
* Google Search Console MCP connector available for Claude Desktop


PHASE 2 — SOCIAL MEDIA PLATFORM INFRASTRUCTURE
Week 1. Set up all accounts and profile standards before posting anything.


Platform Setup — Accounts and Priorities
Platform
	Priority
	Content Type
	Cadence
	X (Twitter) — @TuringVault
	HIGHEST
	Argument posts, score distributions, anti-slop hot takes
	1-2x daily
	TikTok — @TuringVault
	HIGH
	Guess with me clips, score reveals, faceless video OK
	1x daily
	Instagram Reels — @TuringVault
	MEDIUM
	TikTok cross-post via Repurpose.io
	1x daily (auto)
	YouTube Shorts — @TuringVault
	MEDIUM
	TikTok cross-post via Repurpose.io
	1x daily (auto)
	LinkedIn — Turing Vault Company
	MEDIUM
	Benchmark data, workplace angle, thought leadership
	3x weekly
	Bluesky / Threads — @turingvault
	LOW
	X posts auto-crossposted via Typefully
	Auto
	Reddit — Manual only
	HIGH (targeted)
	Genuine participation — no automation
	1-2x weekly
	beehiiv Newsletter
	HIGH (owned)
	Weekly score digest, surprising results, anti-slop analysis
	1x weekly


PHASE 3 — CONTENT CREATION PIPELINE
Week 2+. Production pipeline: Source Material → Long-Form Asset → AI Clip Extraction → Format for Platform → Caption + Tags → Schedule + Distribute → Track + Iterate.


3.1 Video Production
OpusClip — Long Video to Short Clips (Primary)
Record one 10-30 minute screen walkthrough or talking head video weekly. OpusClip extracts 10-20 viral clip candidates with virality scores, captions, and vertical framing. One recording session generates a week of content. Cost: free tier available, Pro from $15/mo.
AutoShorts.ai — Fully Automated Faceless Video
Provide a topic or script. AutoShorts generates, edits, and schedules faceless TikTok/Shorts content on autopilot. Use for 'AI writing sample #47 — human or AI?' style content. No camera, no editing required. Alternative: quso.ai.
CapCut — Free Editing
Mobile and desktop. Free AI auto-captions, remove filler words, background noise removal. Use for quick edits of screen recordings or reaction videos.
Repurpose.io — Cross-Platform Distribution
Post one video to TikTok, auto-cropped and reformatted for Reels, Shorts, LinkedIn Video, Twitter Video simultaneously. Eliminates manual re-upload workflow. Cost: $25/mo.


3.2 Static Image and Graphic Content
Canva Magic Studio — Primary Design Tool
Create branded templates for: score announcement graphics, stat cards, leaderboard screenshots, challenge result cards. Once templates are built, content generation is 5 minutes per post. Free tier sufficient to start.
Dynamic OG Images — Build Inside Velorin
Build a serverless endpoint generating a unique Open Graph image for each score result page. When anyone shares a result link, it previews with their personal score card. This is a viral loop mechanism. Build with Claude Code using Satori or Puppeteer.


3.3 Text and Caption Generation
Claude — Primary Content Writing
Use Claude directly for: X posts in the anti-slop/argument voice, LinkedIn thought leadership, newsletter content, caption variants, SEO article drafts, Reddit posts. No additional cost.
Typefully — Scheduler for Text Platforms
Write posts in bulk, schedule, and publish across X, LinkedIn, Threads, and Bluesky from one interface. AI writing assist built in. Cost: $12/mo.
n8n Workflow: Trend Monitor → Content Draft → Queue (Automated)
n8n pulls Google Trends daily for target keywords. If trending topic threshold is met, triggers Claude API to draft 3 post variants. Pushes drafts to Typefully queue for human review before publish. Human approval step is required — never fully automated posting without review.
* Tools: n8n, Google Trends API, Claude API, Typefully API


3.4 Content Calendar and Volume Targets
Platform
	Format
	Frequency
	Production Method
	X
	Text post / thread
	1-2x daily
	Claude → Typefully queue
	TikTok
	Short video (15-60s)
	1x daily
	AutoShorts (faceless) + OpusClip clips
	Instagram Reels
	Short video
	1x daily
	Repurpose.io from TikTok
	YouTube Shorts
	Short video
	1x daily
	Repurpose.io from TikTok
	LinkedIn
	Long text post + graphic
	3x weekly
	Claude + Canva → Buffer
	Bluesky / Threads
	Text post
	Auto-crosspost
	Typefully sync
	beehiiv Newsletter
	Long-form email
	1x weekly
	Claude draft → human edit
	Reddit
	Text post
	1-2x weekly
	Manual — no automation
	SEO Blog
	Long-form article
	1x weekly
	Claude + Surfer SEO optimization


PHASE 4 — AUTOMATION STACK
Weeks 2-4. n8n now has native MCP support. Claude Desktop connects to an n8n instance and builds/triggers workflows via natural language. Alexander can architect new marketing automation workflows without Claude Code builds.


4.1 n8n Setup — Core Infrastructure
Install n8n (Docker on VPS or n8n Cloud $20/mo). Connect to Claude Desktop via n8n-MCP npm package (czlonkowski/n8n-mcp). Add to claude_desktop_config.json. Once connected, Alexander describes workflows in natural language and n8n deploys them.


n8n Workflows to Build
Workflow 1: Daily Trend Monitor → Content Draft Queue
Trigger: 6 AM daily. Pull Google Trends for target keywords. If trending topic threshold met, call Claude API to generate 3 post variants. Push to Typefully drafts for human review. Log to Google Sheets.
Workflow 2: Score Distribution Report (Weekly)
Trigger: every Monday 9 AM. Pull PostHog/Replit database for weekly score data. Generate summary stats (avg scores, mode breakdown, completion rates). Push to Drive. Trigger newsletter draft in beehiiv.
Workflow 3: New Leaderboard High Score → Social Post
Trigger: webhook from site when new leaderboard top-10 entry. Pull score data. Claude API generates personalized congratulation post. Push to Typefully as scheduled post. Optionally notify user via email.
Workflow 4: SEO Performance Weekly Report
Trigger: weekly. Pull Google Search Console API for impressions, clicks, position for target keywords. Compare to prior week. Generate summary. Push to Drive as Alexander-readable report.
* Tools: Google Search Console MCP, n8n GSC node
Workflow 5: Viral Post Detection → Amplify
Trigger: hourly check on X post engagement. If any post crosses threshold (1000 impressions, 50 engagements), alert Christian Taylor. Generate 3 follow-up variants via Claude. Queue for human selection.
Workflow 6: Creator Mention Monitor
Continuous monitoring of X/social for mentions of Turing Vault or relevant keywords. Route significant mentions to Christian Taylor. Generate suggested reply text via Claude. Hold for human approval before sending.


4.2 Scheduling Infrastructure
* Typefully ($12/mo) — X, LinkedIn, Threads, Bluesky. API connects to n8n for programmatic draft queue.
* Buffer ($6/channel/mo) — Video and multi-platform fallback. Buffer API → n8n.
* Repurpose.io ($25/mo) — Auto cross-post TikTok→Reels→Shorts→LinkedIn Video. Pure automation.


4.3 Analytics Automation
* PostHog → n8n → Drive → Alexander Report: weekly automated funnel report with channel attribution by UTM source. Alexander reads on session open without manual report pulls.
* Metricool (free / $22/mo) — unified social analytics dashboard across all platforms.


PHASE 5 — CREATOR AND NEWSLETTER SEEDING
Weeks 3-6. Highest ROI distribution channel at this stage. Do not mass-blast outreach. Each creator outreach is a personal pitch. Automate list-building and enrichment — not the sending.


5.1 Target List Construction
Five lists: (1) AI/tech newsletter operators 5k-100k subscribers, (2) Writing/editing community creators, (3) Teachers/educators discussing AI in classrooms, (4) AI safety/evaluation researchers, (5) Podcasters covering AI controversy and anti-slop themes.
* Tools: Clay ($149/mo), Apollo ($99/mo), Substack Search (free — manual)


5.2 Creator Offer Structure
Frame around the audience's outcome: 'Run your audience through Turing Vault. We'll give you a custom landing page, a unique tracking link, and a full score breakdown report showing how your audience performed. You get unique data for a post or episode. We get traffic.'
Creator-specific landing pages — Build
Dynamic route: /challenge/[creator-slug] showing creator name, profile image, and custom intro copy. Tracks all traffic through that slug. Build with Claude Code / Replit Agent.
Creator score report generator — Build
After a creator drops their link, auto-generate a report: average score by mode, percentile vs general population, best and worst question types. Alexander generates from PostHog data.


5.3 Immediate High-Priority Organic Seeding Targets
Product Hunt Launch
Submit on Tuesday or Wednesday for maximum exposure. Generates 500-2000 early users in 24 hours, backlinks from PH and tech press. Prepare: a hunter with an existing following, a compelling demo GIF, clear hook copy.
Hacker News Show HN
Post: 'Show HN: I built a live human vs AI text classification challenge — the data is surprising.' HN front page = 10,000+ visits in a day. Key: show data, not product.
AI Newsletter Roundups — Manual First Contact
Personal email to: TLDR AI, The Rundown AI, Ben's Bites, Superhuman newsletter, The Neuron. Short pitch: 'I have data on how well humans actually detect AI text in 2026. Willing to share the raw numbers for a mention.' Lead with the data, not the product.


PHASE 6 — COMPLETE TOOL REGISTRY


Tool
	Category
	Role
	Cost
	MCP Integration
	Phase
	Google Search Console
	SEO
	Index monitoring, keyword performance
	Free
	MCP connector available
	Now
	Google Analytics 4
	Analytics
	Traffic attribution, conversion tracking
	Free
	GA4 API → n8n
	Now
	PostHog
	Product Analytics
	Funnel analysis, session replay, A/B testing
	Free (1M events/mo)
	PostHog API → n8n
	Now
	Microsoft Clarity
	Analytics
	Free heatmaps and session recordings
	Free
	None needed
	Now
	Typefully
	Social Scheduling
	X, LinkedIn, Threads, Bluesky
	$12/mo
	Typefully API → n8n
	Now
	Buffer
	Social Scheduling
	Video and multi-platform fallback
	$6/channel/mo
	Buffer API → n8n
	Now
	Repurpose.io
	Distribution
	Auto cross-post video across platforms
	$25/mo
	Webhook triggers
	Now
	CapCut
	Video Editing
	Quick edit, auto-captions, noise removal
	Free
	None needed
	Now
	Canva
	Graphic Design
	Branded templates, stat cards, social graphics
	Free / $15/mo
	Canva MCP (in beta)
	Now
	beehiiv
	Newsletter
	Email list, newsletter platform, audience growth
	Free to 2500 subs / $42/mo
	beehiiv API → n8n
	Now
	OpusClip
	Video
	Long video → short viral clips
	Free / $15/mo
	Manual upload
	Week 2
	AutoShorts.ai
	Video
	Fully automated faceless short video generation
	~$29/mo
	API for topic injection
	Week 2
	n8n
	Automation
	Core workflow automation backbone
	$20/mo cloud or free self-hosted
	Native MCP support — Claude Desktop direct
	Week 2
	n8n-MCP
	MCP Connector
	Connects Claude Desktop to n8n for AI workflow creation
	Free (npm)
	Add to claude_desktop_config.json
	Week 2
	Metricool
	Analytics
	Unified social media analytics dashboard
	Free / $22/mo
	API available
	Week 2
	Semrush
	SEO
	Keyword research, competitor analysis, tracking
	$130/mo
	Semrush API → n8n
	Week 2
	Surfer SEO
	SEO / Content
	On-page content optimization
	$89/mo
	None needed
	Week 2-3
	Clay
	Outreach
	Creator and newsletter list building
	$149/mo
	Clay MCP connector available
	Week 3+
	Apollo
	B2B Outreach
	B2B contacts for team challenge sales
	$99/mo
	Apollo API → n8n
	Phase 3 only
	Instantly
	Email Sequences
	Cold email sequencing after offer is proven
	$37/mo
	None initially
	Phase 3 only
	SparkLoop
	Newsletter Growth
	Newsletter referral network
	Free-ish
	beehiiv integration
	After 1k subs
	Otterly AI
	GEO / AI Search
	Track mentions in ChatGPT, Perplexity, Claude
	~$49/mo
	API available
	Optional


PHASE 7 — VELORIN AGENT INTEGRATION


Agent
	Turing Vault Function
	Data Sources
	Output
	Alexander (CEO)
	Weekly Turing Vault performance review. Reads all funnel data, social analytics, SEO report. Surfaces what is working and what needs intervention.
	PostHog API report via n8n → Drive, Metricool weekly export, GSC weekly report
	Weekly growth brief in Alexander.DailyLog. Action items surfaced at session open.
	Jiang (Intelligence)
	Competitive landscape monitoring. Track other AI detection products. Monitor AI news for viral hook opportunities. Quarterly audience behavior research.
	Web research, competitor analysis, trend data
	Jiang.Topic.TuringVaultCompetitive (to be created). Quarterly competitive brief.
	Trey (External GPT)
	Content review and editorial pass on longer-form posts, newsletter issues, and SEO articles. Second opinion on angle selection.
	Drafts from Claude, shared via Drive
	Reviewed content. Risk flags on tone or positioning.
	n8n Workflows
	Trend monitoring, report generation, content draft queuing, score distribution reports, creator tracking, SEO performance pulls.
	Google Trends, PostHog, GSC, Metricool, social APIs
	Daily/weekly automated reports to Drive. Content drafts to Typefully queue. Alerts to Christian Taylor.


PHASE 8 — EXECUTION TIMELINE


Phase
	Timeframe
	Actions
	Fix the Pipe
	Days 1-3
	Fix Stripe links and webhook verification → Install PostHog and GA4 → Set up Google Search Console and submit sitemap → Add email capture at completion → Add share/challenge prompt → Register all social handles (do not post yet)
	SEO Foundation
	Days 4-7
	Add meta tags and OG tags to all pages → Add schema markup → Generate sitemap.xml → Fix Core Web Vitals issues → Build first 3 programmatic SEO pages → Install Microsoft Clarity
	Turn On the Machine
	Week 2
	Set up Typefully and Buffer → Create Canva brand kit and first 5 templates → Record first screen walkthrough video → Run through OpusClip → Schedule first 20 posts across X, TikTok, LinkedIn → Set up Repurpose.io → Write first beehiiv newsletter → Install n8n and connect to Claude Desktop via n8n-MCP
	Build the Workflows
	Weeks 3-4
	Build n8n Workflows 1-4 → Set up Clay creator list → Build creator-specific landing page template → Manual outreach to 10 newsletter operators → Product Hunt prep and scheduling → Hacker News Show HN post
	Scale What Works
	Days 31-60
	Analyze which platform drives completions (not just traffic) → Double down on winning channel → Run first creator drop → Publish first SEO long-form article → Start $75/week paid test if organic is proven → Build score report generator for creators → Activate SparkLoop if newsletter hit 500 subs
	Monetize
	Days 61-90
	First private team challenge sale → First sponsored creator drop → First paid benchmark report → Evaluate product direction: media product, team tool, or data asset. Activate Apollo/Instantly only after first paid offer proof.


MINIMUM VIABLE STACK COST


Tool
	Monthly Cost
	Phase
	Skip-able?
	PostHog + GA4 + GSC + Clarity
	$0
	Now
	No
	beehiiv
	$0 (to 2500 subs)
	Now
	No
	Canva
	$0 (free tier)
	Now
	No
	CapCut
	$0
	Now
	No
	Typefully
	$12
	Week 1
	No
	Buffer
	$12 (2 channels)
	Week 1
	Replaceable by Typefully
	Repurpose.io
	$25
	Week 2
	Yes — skip if low video volume
	n8n Cloud
	$20
	Week 2
	No — core automation
	OpusClip
	$15
	Week 2
	Yes — use free tier to test
	AutoShorts.ai
	$29
	Week 2
	Yes — skip if recording own video
	Semrush
	$130
	Week 2-3
	Yes — use GSC to start
	MINIMUM (first 30 days)
	~$84/mo




	FULL STACK (Phase 1-3)
	~$320/mo






[VELORIN.EOF]
Turing_Vault_Growth_Architecture  |  Alexander, CEO  |  Velorin  |  March 27, 2026