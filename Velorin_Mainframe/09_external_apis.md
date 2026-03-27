# SECTION 9 — EXTERNAL APIS

**Purpose:** All external services called over the internet from the Velorin system. Each is an API call, not a local install. No local GPU needed for these.

---

## Anthropic Claude API

**Status:** Active
**Access:** Via API key in claude_desktop_config.json and orchestration scripts
**Models in use:** claude-sonnet-4-6 (primary), claude-opus-4-6 (heavy reasoning tasks)
**Cost model:** Per-token pricing. With prompt caching enabled, session costs run approximately $0.20–$0.60/session vs prior estimates of $3–24.
**Documentation:** docs.anthropic.com

No setup needed — already operational.

---

## ElevenLabs — Voice Generation

**Status:** Not yet subscribed. Setup required.
**Access:** ElevenLabs API (separate from standard UI subscription)
**Purpose:** Text-to-speech, voice cloning, voice agents. For Velorin: output layer for any voice interface components, content creation, or audio-based agent communication.

**Pricing structure (as of March 2026):**
- Free tier: 10,000 characters/month (~10 min audio). No commercial rights. No voice cloning. Limited API access.
- Starter tier: ~$5/month. 30,000 characters. Commercial rights. Instant voice cloning. API access included.
- Creator tier: ~$22/month. 100,000 characters. Professional voice cloning. 192 kbps audio output.

**API is separate from UI subscription:** The standard plans above cover the web interface. Programmatic API access (for integration into Velorin scripts) is available starting at Starter tier for light use. For heavier programmatic use, a dedicated API plan exists: API Pro at $99/month for 100 API credits.

**Recommendation for initial build:** Start with Starter at $5/month. Covers commercial use, basic voice cloning, and API access sufficient for initial Velorin integrations. Upgrade when usage demands it.

**Supported capabilities:**
- Text to Speech (TTS): text → audio file
- Speech to Text: audio → text
- Voice Cloning: create custom voice from audio sample
- Voice Agents: interactive AI voice conversations
- Official Python and TypeScript SDKs available

---

## Video Generation API — CRITICAL STATUS UPDATE

**⚠️ Sora 2 API was shut down on March 24, 2026 (3 days ago).**

OpenAI confirmed the complete discontinuation of Sora including the iOS app, sora.com, and the API endpoint. The Sora 2 model remains accessible via ChatGPT interface for Plus/Pro subscribers, but **programmatic API access no longer exists as of this date.**

**Alternative video generation APIs (confirmed working, March 2026):**

| Service | Quality | Price | API Available |
|---|---|---|---|
| Runway Gen-4.5 | Best quality | ~$0.05/sec | Yes |
| Kling 3.0 | Best value, supports long video | ~$0.01–0.03/sec | Yes |
| Pika | Good for short clips | Varies | Yes |

**Recommendation:** Runway Gen-4.5 for quality-priority video. Kling 3.0 for cost-efficient or long-format video. Both have stable APIs. Sora should be removed from the architecture plan entirely until OpenAI releases a successor with API access.

---

## Google Workspace APIs

**Status:** Accessible via the new Google Workspace CLI (gws) — installed on Machine 1.

**Services accessible:**
- Gmail (read, send, search, manage)
- Google Drive (read, write, create, organize)
- Google Calendar (read, create, modify events)
- Google Docs / Sheets / Slides (read, write)
- Google Chat

**Setup required:**
1. Install gws: `npm install -g @googleworkspace/cli`
2. Run `gws auth setup` — initiates OAuth browser flow
3. Run `gws mcp -s drive,gmail,calendar` — starts local MCP server exposing Workspace as Claude tools
4. Add gws MCP server entry to claude_desktop_config.json

**Google Cloud project required:** Create a project at console.cloud.google.com, enable relevant APIs (Gmail API, Calendar API, Drive API), download OAuth client credentials JSON.

**Important:** Set the Google Cloud project to "Production" status (not "Testing") before extended use. Testing mode OAuth tokens expire every 7 days, requiring re-authentication. Production mode tokens persist indefinitely.

---

## GitHub API

**Status:** Connected via GitHub MCP (operational as of Session 005)
**Access:** Via GitHub PAT stored in claude_desktop_config.json
**Purpose:** Read/write GitHub repos, manage issues, automate code commits from Claude
**Cost:** Free tier is sufficient for current Velorin usage
**Action required:** Rotate the PAT if it has been exposed in any session logs — this key was referenced in plain text in Session 005.

---

## Resend (Email)

**Status:** Active. generalatomics.us domain verified.
**Purpose:** Transactional email from Velorin systems (Turing Vault, future SaaS products)
**Cost:** Free tier covers 3,000 emails/month
**Access:** API key in relevant application configs

---

## OpenAI API (Optional / Selective)

**Status:** Not required for core Velorin architecture. Claude is the primary model.
**Potential use cases:** Accessing specific OpenAI-only capabilities (Whisper for transcription, DALL-E for images, GPT-4o for cross-model comparison)
**Note:** Sora 2 API shutdown reduces the dependency on OpenAI significantly. Reassess when OpenAI releases a video generation API successor.

---

## API Key Management Protocol

All API keys must be stored in environment variables or config files that are:
1. Never committed to GitHub (add to .gitignore)
2. Stored locally on each machine in appropriate config locations
3. Rotated on any suspected exposure

Velorin has no secrets manager yet. Until one is built, maintain a private local document listing which keys are stored where.
