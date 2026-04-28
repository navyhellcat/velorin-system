---
file: CT.HowToBuildThis.md
purpose: Step-by-step human instructions for Christian Taylor to get the 3D commercial and learning guide built
tone: Direct. No AI voice. Written for CT specifically.
---

# How to Build the Velorin Presentation — Step by Step

Christian, here's the honest assessment and the actual path.

---

## WHAT YOU HAVE

Two production-ready prompt documents:
1. **Velorin.3D.Commercial.Prompt.md** — full cinematic spec, 5 acts, every visual described
2. **Velorin.LearningGuide.md** — complete math explainer, machine-readable, any bot can consume it

These are INPUT DOCUMENTS. They tell a builder what to make. They are not the thing itself.

---

## WHAT YOU WANT

Two outputs:
1. A **3D animated presentation** (video or interactive web experience)
2. A **polished learning guide** (web page or PDF, visual, navigable)

---

## THE HONEST ASSESSMENT

**Replit cannot one-shot a 3D cinematic.** Replit is good for web apps, APIs, and simple frontends. A full 3D animated commercial with the aesthetic you want (I-Robot × Fallout, E₈ crystals, vacuum tubes, particle systems) is beyond what any single-prompt code generation will produce. The cinematic video version requires either a video generation model (Veo, Sora) or a 3D artist with Blender/Unreal.

**However — an INTERACTIVE WEB VERSION is absolutely buildable.** And that might actually be better than a video for your purposes. A web experience that someone can click through, rotate the Brain, watch the PPR walk, toggle belief states — that's a product demo, not just a commercial.

---

## PATH A — The Interactive Web Experience (RECOMMENDED)

This is the one you can actually build with the tools you have.

### Step 1: Open Google AI Studio (you have Google AI Ultra)

Go to `aistudio.google.com`. Use Gemini 2.5 Pro or whatever the current strongest model is. This is your builder.

### Step 2: Give it the commercial prompt + a web constraint

Paste the ENTIRE `Velorin.3D.Commercial.Prompt.md` into a Gemini session. Then add this instruction at the top:

```
Build this as a single-page interactive web experience using Three.js 
(React Three Fiber) and vanilla CSS. The page should have 5 sections 
corresponding to the 5 acts. Each section scrolls into view with the 
visual described. Use WebGL for the 3D elements:

- The E₈ crystal as a rotating polytope (use the 4_21 projection)
- The PPR walk as animated particles following edges
- The vacuum tubes as glowing cylinders with internal text
- The beetle swarm as simple animated geometry on the surface
- Nixie tube counters as CSS-styled number displays
- The oscilloscope as a canvas-based line chart

Art deco color palette: amber (#D4A853), chrome (#C0C0C0), 
CRT green (#33FF33), deep brown (#3E2723), clinical blue (#B0BEC5).
Fallout typography: use Google Fonts "Playfair Display" for headers, 
"JetBrains Mono" for code/formulas.

Output a single HTML file with embedded CSS and JavaScript. 
Include Three.js via CDN. Make it work when opened directly in a browser.
```

### Step 3: Iterate

Gemini will produce a first draft. It won't be perfect. Copy the HTML, open it in Chrome, see what works. Go back to Gemini with screenshots and say "fix this section" or "the crystal needs to rotate" or "add the particle walk."

Expect 3-5 iterations to get something presentable. Each iteration: paste the current HTML back, describe what to change, get the updated version.

### Step 4: Host it

Once you have a working HTML file:

**Option A — GitHub Pages (free, 2 minutes):**
1. Create a new repo: `navyhellcat/velorin-presentation`
2. Push the HTML file as `index.html`
3. Go to Settings → Pages → Deploy from main branch
4. Your presentation is live at `navyhellcat.github.io/velorin-presentation`

**Option B — Replit (you already have it):**
1. Create a new Replit project, HTML/CSS/JS template
2. Paste the HTML as `index.html`
3. Click Run
4. Share the Replit URL

---

## PATH B — The Video Commercial (Higher Quality, More Effort)

### Option 1: Google Veo 3

If you have access to Veo 3 (through Google AI Ultra or AI Studio):

1. Break the commercial prompt into 15-30 second segments (one per scene)
2. For each segment, write a Veo prompt using the scene description from the commercial doc
3. Add these keywords to every prompt: "art deco chrome neural architecture, vacuum tube knowledge graph, 1950s retro-futurism, cinematic macro cinematography, volumetric lighting, dark background"
4. Generate each segment separately
5. Stitch them together in any video editor (iMovie works, CapCut is free)
6. Add voiceover (record yourself reading the voiceover lines, or use ElevenLabs for a 1950s announcer voice)
7. Add music (use Suno or Udio to generate "atomic age jazz noir meets electronic ambient" — give it the music brief from the commercial doc)

### Option 2: Sora (OpenAI)

Same process as Veo but through ChatGPT Pro. Sora handles text-to-video. Same segment-by-segment approach.

### Option 3: Hire a 3D artist

If you want the FULL vision (E₈ polytopes, proper Blender renders, Unreal Engine quality):
- Fiverr: search "3D motion graphics" or "sci-fi product visualization" — budget $500-2,000
- Give them the commercial prompt doc as the creative brief
- They'll need 2-4 weeks

---

## PATH C — The Learning Guide as a Web Page

### Step 1: Use the LearningGuide.md directly

The learning guide is already structured for web consumption. Each chapter has headers, tables, and formulas.

### Step 2: Convert to a web page

**Fastest path — Google Sites:**
1. Go to `sites.google.com` (you have the full Google suite)
2. Create a new site: "Velorin Learning Guide"
3. Copy each chapter from the .md file as a separate page
4. Google Sites handles basic formatting
5. For math formulas, use screenshots or MathJax (paste the LaTeX into an HTML embed)

**Better path — Markdown to HTML:**
1. Open a Claude Code session
2. Say: "Convert Velorin.LearningGuide.md to a styled HTML page with MathJax for LaTeX rendering, art deco color scheme (amber #D4A853, CRT green #33FF33, dark brown #3E2723), Playfair Display headers, JetBrains Mono for code"
3. Claude will produce an HTML file
4. Host it on GitHub Pages or Replit

**Best path — Notion or Obsidian publish:**
1. If you use Notion: import the .md file directly. Notion renders markdown natively.
2. If you set up Obsidian (which is in the build plan anyway): Obsidian Publish ($8/month) gives you a beautiful navigable site from markdown files.

---

## WHAT I RECOMMEND YOU DO FIRST

**Tomorrow, in one sitting, ~2 hours:**

1. Open Google AI Studio
2. Paste the commercial prompt with the web constraint from Step 2 above
3. Get a first-draft interactive HTML
4. Iterate 2-3 times
5. Push to GitHub Pages

You'll have a live, shareable, interactive Velorin presentation by end of day. Not perfect — but REAL. Something you can show someone and say "this is what I'm building."

The video version and the polished learning guide can come after. Get the interactive web version first. It's the fastest path to something tangible.

---

## TOOLS SUMMARY

| What | Tool | Cost | Time |
|---|---|---|---|
| Interactive web presentation | Gemini AI Studio → Three.js HTML → GitHub Pages | Free (you have Ultra) | 2-4 hours |
| Video commercial (segments) | Veo 3 or Sora + iMovie + ElevenLabs/Suno | Free-$50 | 1-2 days |
| Video commercial (pro) | Fiverr 3D artist | $500-2,000 | 2-4 weeks |
| Learning guide web page | Claude Code → HTML + MathJax → GitHub Pages | Free | 1-2 hours |
| Learning guide (quick) | Google Sites or Notion import | Free | 30 min |

---

## ONE MORE THING

The commercial prompt and learning guide are designed to be consumed by OTHER AI MODELS — not just humans. If you paste the commercial prompt into Veo, Sora, Gemini, Claude, or any future model, it has enough detail to produce meaningful output. That's by design. The documents are machine-language prompts wearing a human-readable suit.

When you sit down to build, pick ONE path. Don't try to do all three at once. Interactive web first. Video second. Polish third.

[VELORIN.EOF]
