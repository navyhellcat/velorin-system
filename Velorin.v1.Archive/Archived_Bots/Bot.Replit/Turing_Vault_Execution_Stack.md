TURING VAULT
Revenue, Distribution, and External Tools
Execution Stack Research Guide
Prepared for Christian Taylor  |  March 26, 2026




CORRECTION
	The previous guide over-indexed on research products. This version is about execution tools and operating systems for distribution, monetization, outreach, instrumentation, and iteration.








1. What Turing Vault Actually Is Right Now
Based on the March 26 codebase snapshot, Turing Vault is currently:
* A public human-vs-AI text classification challenge
* A scoreable game with standard / hard / adversarial modes
* A leaderboard and sharable ego object
* A corpus-building engine that stores response labels, confidence, rationale, timing, and visitor/session data
* A future benchmark / eval dataset seed
* A site with two micro-payment hooks, both priced at $2.71
* A product whose payment flow is NOT commercially ready — Stripe links are still placeholders and webhook verification is not implemented


IMMEDIATE TRUTH
	The current business is not the $2.71 gimmicks. The current business is: (1) attention capture, (2) data capture, (3) proof-of-interest by audience segment, (4) eventual sellable benchmark, report, or private challenge layer.








2. Commercial Ranking


TIER
	REVENUE OPPORTUNITIES
	Tier 1 — Near-term
	Sponsored / creator-backed challenge drops. Private leaderboard / team challenge offer. Newsletter-backed traffic funnel into low-ticket offers. B2B benchmark report or "how your team performed" package.
	Tier 2 — Medium-term
	Education / writing / newsroom challenge bundles. Recruiting / hiring-team eval angle. Agency / content-team workshops. Paid benchmark access or recurring benchmark report.
	Tier 3 — Long-term
	Licensable response dataset. Synthetic-vs-human evaluation corpus. Benchmark API / enterprise eval product. White-labeled challenge installs for other brands.
	Low-ceiling / skip
	The vault troll purchase alone. The adversarial unlock as a standalone. Generic display ads. Trying to become a broad SaaS before the audience exists.








3. The Product Must Be Pitched From Multiple Angles at Once
Do not use one monolithic message. Different pushers push the same asset from different story frames.


ANGLE
	HOOK
	BEST FOR
	GOAL
	A — Ego/Challenge
	"You think you can still tell? Prove it."
	X, TikTok, Reels, Shorts, creators, meme pages, AI-curious consumers
	Raw traffic, screenshots, controversy
	B — Writers
	"The line is breaking. Can you still spot the machine?"
	Substack, newsletters, writing communities, educators, journalism
	Qualified trust traffic, future bundle customers
	C — Anti-Slop
	"Everyone says they can spot AI slop. Most are lying."
	Argument-driven X posters, opinion creators, podcasts
	Debate, reposts, earned reach
	D — Builder/Eval
	"This is not just a quiz. It is a live human-judgment dataset."
	AI builders, evals people, labs, startups, safety/evals communities
	B2B credibility, licensing path
	E — Team/Workplace
	"Put your team on the board."
	Startups, agencies, writing teams, newsletters, classrooms
	Paid private leaderboards, challenge packages
	F — Creator
	"Run your audience through it and show the score spread."
	Creators with email + social + audience trust
	Borrowed distribution, sponsor-backed drops








4. Immediate Constraint: Fix These Before Scaling Traffic
WARNING
	Do not push paid traffic hard before these are fixed. Without them, you are buying attention into a leaky pipe.


1. Real Stripe links — replace all # placeholders with hosted checkout URLs
2. Webhook verification — verify Stripe signatures on every inbound webhook
3. Event tracking — instrument every funnel step
4. Email capture — add opt-in at completion screen
5. Referral prompt — add share / challenge prompt after completion
6. Post-completion CTA — obvious "what do I do next?" action
7. UTM tracking — tag all links before distributing
8. Simple privacy / terms language — cover data capture and export








5. External Tools by Objective
These are execution tools, not research tools.


5.1  Ship Changes Faster




TOOL
	USE
	Claude Code
	Stripe fix, referral prompt, email capture, campaign-specific landing pages, sponsor pages, export cleanup — fastest way to make real code changes in the existing codebase
	Replit Agent
	New pages, visual experiments, landing variants, admin additions, creator-specific entry pages — fast iteration inside the current build environment
	PostHog
	Event analytics, funnels, experiments, session replay in one place — see where people drop, which mode gets picked, whether users hit purchase
	Microsoft Clarity
	Free heatmaps and session recordings — quick diagnosis of confusion, CTA blindness, mobile friction, hover/tap failures




WHY IT MATTERS
	Until you can measure: visit → start → finish → leaderboard submit → email opt-in → purchase click → success — you do not know which audience is worth funding.


5.2  Multi-Platform Organic Distribution




TOOL
	USE
	Buffer
	Broad scheduling, repurposing, engagement, and cross-platform publishing
	Typefully
	Strongest fit when X + LinkedIn + Threads + Bluesky are central channels
	Metricool
	Calendar + analytics + ad management visibility in one place
	OpusClip
	Turn talking-head explanations, screen recordings, or walkthroughs into many short clips quickly
	Repurpose.io
	Automate cross-posting of video/audio assets to multiple destinations
	Zapier
	Low-friction automations between forms, sheets, social tools, email tools, and the site
	n8n
	Stronger technical option for durable, customizable, multi-step automations with agent logic


Recommended stack: Do not automate low-quality spam posting into communities. Automate formatting and scheduling. Keep the social voice and channel judgment human.


5.3  Build and Monetize an Owned Audience




TOOL
	USE
	beehiiv
	Fastest owned audience + growth + monetization stack. Use for: challenge updates, weekly score reports, audience segmentation by angle, sponsor inventory later
	SparkLoop
	Newsletter growth and paid/free recommendation network. Use after there is real email momentum.
	Kit
	Strong alternative if the play becomes more creator-network-centric than media-brand-centric




5.4  Creator Seeding and Media Seeding




TOOL
	USE
	Clay
	Build and enrich lists: Substack writers covering AI/writing/education/slop, podcasters who thrive on argument content, AI startup founders and eval people
	Apollo
	Structured B2B account and contact targeting: startup founders, AI labs, eval/product/ML contacts, newsroom product leads, education buyers
	PhantomBuster
	Platform-level extraction and outreach workflows. Use carefully on small, specific lists only. Not for scale spam.
	Instantly
	Outbound sequencing once you have a clean list and clean offer: sponsor outreach, private team challenge outreach, benchmark-report outreach, dataset buyer validation


Recommended stack: Do not blast cold spam at creators or buyers. This product is controversy-friendly but credibility-fragile. Sloppy outreach will damage the brand fast.


5.5  Make the Data Asset Real




TOOL
	USE
	PostHog
	Instrument every funnel event
	n8n
	Export clean CSVs on schedule. Create recurring mode-level, channel-level, audience-segment, and creator-campaign summaries
	Claude Code
	Classify response text and rationale at scale later
	Clay (later)
	Buyer research and enrichment once the dataset is ready to license




WHAT THIS REQUIRES
	The dataset becomes enterprise-sellable only after you can say: who came, from where, what framing converted them, how they performed, what they believed before the test, which audience segments systematically fail or overperform. Right now the skeleton exists. The commercial proof layer does not.


5.6  Sell Something Bigger Than $2.71
Best near-term paid offers:


OFFER
	DESCRIPTION
	Private Team Challenge
	One company, creator, class, or community. Branded leaderboard. Score report. Optional debrief. Easy to explain and sell.
	Sponsored Challenge Drop
	Creator or newsletter runs audience through Turing Vault. You provide custom landing page and reporting. Sponsor gets unique angle and bragging rights.
	Benchmark Report
	"We ran X audience through the challenge; here is what happened." Sell to media, creators, B2B buyers, or use as lead magnet.
	Data-Backed Workshop
	For writing teams, newsrooms, creators, schools, agencies.








6. Channel Playbooks


6.1  X
Best use: argument, ego, screenshots, short challenges, creator seeding.
* Direct challenge posts
* "Most of you cannot tell anymore" posts
* Screenshot of surprising score distributions
* Creator quote-tweets and leaderboard callouts
* Adversarial-mode clips and anti-slop arguments
Stack: Typefully or Buffer. OpusClip for video derivatives. Metricool for comparative analytics. Zapier/n8n for back-end tracking.
RULE
	Post opinion, not announcements. Show score distributions and surprising outcomes. Reply under larger AI/writing threads with proof hooks. Use the site as an argument weapon, not a product brochure.


6.2  Reddit
Best use: targeted traffic and trust if done carefully.
DO NOT AUTOMATE
	Use Reddit manually. No scheduling tools. No bulk posting.


Best subreddit types: AI discussion, writing/editing, education/teachers, journalism/media, productivity/knowledge work, anti-slop/internet culture, niche creator communities.
* "I built this because everyone claims they can still tell"
* "Here are the score distributions so far"
* "Adversarial mode broke people more than expected"
* "Teachers/editors: are you seeing the same thing?"


6.3  TikTok / Reels / Shorts
Best use: raw top-of-funnel reach.
* "Guess with me" clips
* Reaction clips to strong passages
* Score reveal clips
* "I thought this was human/AI and I was wrong" clips
* Creator duet/react formats
* Anti-AI-slop cultural takes
Stack: OpusClip. Repurpose.io. Buffer/Metricool for scheduling.
RULE
	High volume matters here. Do not overpolish.


6.4  LinkedIn
Best use: workplace, hiring, newsroom, education, and B2B benchmark angle.
* "Your team is probably overconfident about AI detection"
* "Human judgment data is becoming valuable again"
* "What a live classification challenge teaches about hiring / writing / evaluation"
* "This is becoming a benchmark problem, not just a meme"
Stack: Typefully or Buffer. Clay + Apollo for outreach into likely buyers. Instantly only after clear offer exists.


6.5  Newsletters
Best use: highest-quality organic distribution after creator seeding.
Target types: AI newsletters, creator-economy newsletters, writing newsletters, media/journalism newsletters, education newsletters, internet culture newsletters.
OFFER TEMPLATE
	Custom challenge page + unique tracking link + "how your audience scored" report after the drop.


6.6  Podcasts / Creators / YouTube
Best use: borrowed trust and better conversion than most small paid ads.
* "Run your audience through this and we will show what happened."
* "I think your audience will be overconfident on adversarial mode."
* "This works as a segment, not just an ad."
Creator targets: AI commentators, anti-slop/internet culture creators, writing and education creators, productivity/knowledge work creators, startup and product creators.








7. $75/Week Paid Plan
START CONDITION
	Do not start paid traffic until instrumentation and landing flow are fixed. Without both, you are measuring noise.


7.1  Week 1 Test Structure
BUDGET
	CHANNEL / CREATIVE
	$30
	Reddit ads to highest-fit discussion audiences or boosted posts to challenge-style creative
	$25
	X promoted post testing direct-challenge hooks
	$20
	Retargeting / second-touch or whichever creative/channel shows strongest start rate


7.2  What to Test
* Challenge framing vs anti-slop framing
* Consumer challenge vs writer/editor framing
* Static screenshot vs talking-head clip
* "Prove it" vs "most people fail" vs "your team is overconfident"


7.3  Success Metrics
Track cost per — not raw clicks:
* Cost per test start
* Cost per test completion
* Cost per leaderboard submission
* Cost per email capture
* Cost per purchase click
* Completion rate by source
* Best-performing audience framing


7.4  Stop Conditions
Kill any paid test that produces:
* Lots of clicks and no starts
* Starts and no completions
* Completions and no downstream action
* Traffic from an audience that clearly does not care enough to argue, share, or return








8. Tool Stack by Phase


PHASE
	TOOLS
	Phase 1 — Right Now
	Claude Code. Replit Agent. PostHog. Microsoft Clarity. Buffer OR Typefully. OpusClip. Zapier OR n8n.
	Phase 2 — Once Traffic Starts
	beehiiv. SparkLoop. Clay. Apollo.
	Phase 3 — Once a Real Offer Exists
	Instantly. Selective PhantomBuster usage. Sponsor ops and benchmark reporting workflows.








9. Inside Velorin vs Outside Tools


BUILD INSIDE VELORIN
	BUY FROM OUTSIDE
	Core site and scoring logic
Dataset creation and benchmark logic
Sponsor landing pages
Reporting logic specific to this product
Proprietary segmentation and packaging
Long-term data asset
	Analytics and heatmaps / session replay
Social scheduling
Clip generation / repurposing
Newsletter growth infrastructure
Outreach list building and sequencing
Basic workflow automation


TRADEOFF
	Do not waste founder hours rebuilding commodity infrastructure while the audience is still missing.








10. 30 / 60 / 90 Day Operating Plan


Next 7 Days
9. Fix Stripe links
10. Implement webhook verification
11. Install PostHog
12. Install Microsoft Clarity
13. Add email capture
14. Add referral / share prompt after completion
15. Create 3 landing-page variants: (a) ego challenge, (b) writers/editors, (c) teams/workplace
16. Create first 20 short-form content assets from 2–3 source videos
17. Choose one scheduler: Buffer or Typefully


Days 8–30
18. Post daily on X
19. Publish short clips across TikTok / Reels / Shorts
20. Seed 25–50 creators / newsletter operators manually and through controlled outreach
21. Start newsletter
22. Run one sponsor-style or creator-style custom page test
23. Measure everything
24. Do not widen feature scope unless it improves distribution or monetization


Days 31–60
25. Push hardest on the winning angle
26. Start SparkLoop only if the newsletter has real traction
27. Build private team challenge offer
28. Outreach to agencies, writing teams, startups, newsletters, educators
29. Publish the first score report or benchmark memo


Days 61–90
Decide whether the better business is:
* Media + sponsor-backed challenge
* Team / org challenge product
* Benchmark / report product
* Data asset / B2B eval product
Then narrow hard.








13. Bottom Line
The correct move is not "market the site harder" in the abstract.


30. Fix the payment and measurement holes
31. Push the asset through multiple frames at once
32. Use outside tools for scheduling, analytics, clipping, newsletter growth, and outreach
33. Find the first paid wrapper around the challenge
34. Only then decide whether the real company is media, team challenges, benchmark reports, or the dataset


BOX 2 PATH
	That is the path.








[VELORIN.EOF]
