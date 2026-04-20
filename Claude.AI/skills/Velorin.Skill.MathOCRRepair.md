# Velorin Skill — Math OCR Repair
**Velorin System | Internal Skill | Created Session 032, April 19, 2026**

Callable procedure for any Velorin agent to repair markdown documents containing inline math rendered as opaque PNG images (the Google Docs Equation Editor failure mode). Walks from detection through GitHub-render verification.

This file is the canonical Velorin specification. The Claude Code Skill at `~/.claude/skills/velorin-math-ocr-repair/SKILL.md` is the executable wrapper that MarcusAurelius and Jiang can invoke via `Skill` tool. Both stay in sync — when this file changes, update the Claude Code skill.

---

## 1. WHEN TO INVOKE

Trigger conditions (any one is sufficient):
1. A markdown doc was just ported from Google Docs, Word, or any rich-text source
2. User says "fix the math," "repair the equations," "the math is broken on GitHub," or equivalent
3. Audit found `![](images/...)` references mid-sentence in a research doc
4. After running the inline-math detection from `tools/GDrive.Port.Tool.md` Step 5, count > 0

Do NOT invoke for: full-page figures, charts, diagrams, screenshots of UI. Those are legitimate images. Use the 8KB size heuristic — images <8KB are math equations, >8KB are figures.

---

## 2. WHO CAN INVOKE

- **MarcusAurelius**: directly, via `Skill` tool with name `velorin-math-ocr-repair` (Claude Code session)
- **Jiang** (Code tab): can read this file and execute the procedure manually, using native Read/Bash/Agent tools
- **Alexander, Erdős, Trey**: cannot invoke directly. Must request via the Chairman or escalate to MarcusAurelius / Jiang
- **Sub-agents**: are the workers, not the invokers

---

## 3. PROCEDURE

### Step 3.1 — Detect

```bash
cd <repo>/Claude.AI/Bot.<Agent>/Research_Complete
for f in *.md; do
  inline=$(grep -oE '[a-z][^.\n]{0,30}!\[\]\(images/[^)]+\)[^.\n]{0,30}[a-z]' "$f" | wc -l | tr -d ' ')
  [ "$inline" -gt 0 ] && echo "$f: $inline inline-math refs"
done
```

For each damaged doc, identify the math PNGs (small images):
```bash
find images/<doc_slug> -type f -size -8k
```

Report findings to Chairman. Stop. Wait for go/no-go.

### Step 3.2 — Spawn Sonnet sub-agents

One per damaged doc. **Always Sonnet 4.6, never Haiku.** Validated Session 032 — Haiku hallucinates plausible-but-wrong LaTeX when it cannot read images clearly. Sonnet reads accurately.

Sub-agent prompt template:
```
You are a math OCR worker. Each image below is a LaTeX equation rendered as a tiny PNG by Google Docs Equation Editor. Read each one with the Read tool and transcribe to LaTeX text.

Folder: <absolute path>
Images: <list of png filenames>

Rules:
- Read each image. Transcribe literally. Do NOT invent.
- Domain hint: <doc topic> — expect symbols like <Greek letters, operators, etc>
- Output LaTeX only, no $ delimiters in values, no markdown wrapping
- KaTeX-safe: \ast not *, \lVert\rVert not ||
- If genuinely unreadable, return UNREADABLE for that key. Do NOT invent.

Output: single JSON object, nothing else:
{"<full filename.png>": "<latex>", ...}
```

Spawn with `run_in_background: true` and `model: "sonnet"`. Wait for completion notifications.

### Step 3.3 — Patch (CRITICAL — `re.sub` backslash trap)

Build a Python script with OCR maps inlined as Python dicts. **MUST use a lambda for the replacement, never a string template:**

```python
import re, html
# CORRECT — lambda bypasses Python's re.sub template parsing
patched = pattern.sub(lambda _m: f"${html.unescape(latex)}$", patched)
# WRONG — re.sub interprets \r → CR, \a → BEL, \n → newline, \1 → backref
# patched = pattern.sub(f"${latex}$", patched)
```

The wrong form silently corrupts every backslash sequence that happens to be a Python escape. `\rho` becomes literal `\n` + `ho`. `\ast` becomes literal `\x07` + `st`. The bytes look like normal text in `cat` output but render as garbage on GitHub. This bug ate 30 minutes in Session 032.

Also always `html.unescape()` — sub-agents may emit `&gt;` `&lt;` `&amp;`.

### Step 3.4 — KaTeX fix

Run the standard fix script implementing the 5 rules from `Bot.Erdos/Erdos.GitHubLatex.Rules.md`:
- Rule 1: `^*` → `^{\ast}`
- Rule 2: `||` → `\lVert\rVert`
- Rule 3: avoid nested `\text{}` inside double subscripts (manual)
- Rule 4: escape `_` to `\_` in inline math (display blocks untouched)
- Rule 5: blank lines around `$$` display blocks

Reference implementation: `tools/Math.OCR.Tool.md`.

### Step 3.5 — Push and verify on GitHub

```bash
git add <patched docs>
git commit -m "OCR repair: convert N inline equation PNGs to LaTeX across M docs (Sonnet sub-agents)"
git push
```

For each doc, open in Chrome MCP at the GitHub blob URL and run:
```javascript
const article = document.querySelector('article');
const r = article ? article.querySelectorAll('math-renderer').length : 0;
const broken = article ? [...article.querySelectorAll('p, li, td')].filter(p => {
  const h = p.innerHTML;
  return h.includes('$') && /\$[^\$<]*<em>|<\/em>[^\$>]*\$/.test(h);
}).length : 0;
JSON.stringify({mathRenderers: r, broken});
```

Pass: `broken === 0` AND `mathRenderers > 0`.

If `broken > 0`: identify the broken passage, fix in source, repush, re-verify.

If `mathRenderers` count is much lower than the patched count: KaTeX may have skipped wrapping single-character math like `$X$`. This is normal GitHub behavior, not a failure.

### Step 3.6 — Report to Chairman

Single table:
| Doc | Math renderers | Broken | OCR cost |
| ---- | ---- | ---- | ---- |

Note any docs where OCR confidence was low (sub-agent returned `UNREADABLE` for any image — those need manual transcription).

Leave the original PNG folders in `images/` alone unless Chairman explicitly approves deletion. They are orphaned but harmless.

---

## 4. COST EXPECTATIONS

- Sonnet 4.6 sub-agent: ~$0.10 per 50 small equation images (vision-bound)
- Typical full repair across 4-5 damaged docs: $0.20 – $1.00
- Wall time: 1-2 minutes per sub-agent, all parallel

If estimated cost exceeds $5: stop, escalate to Chairman before spending.

---

## 5. ANTI-PATTERNS

| Don't | Why |
|-------|-----|
| Use Haiku for OCR | Hallucinates plausible-wrong LaTeX. Session 032 verified. |
| Use pix2tex | Pulls opencv-python source build on Py3.9/macOS x86_64. Hours. |
| Use Mathpix without checking | $20 setup + $29 testing minimum (April 2026), org signup required |
| Pass LaTeX to `re.sub` as string | Backslash escapes silently corrupt the output |
| Skip the GitHub verify | Local markdown ≠ GitHub render |
| Delete PNG folders | Orphaned but harmless. One-way door — get Chairman approval first |
| Re-request from Trey | Deep research is non-replayable. Each run is unique synthesis. |

---

## 6. RELATED FILES

- `Claude.AI/tools/Math.OCR.Tool.md` — full script + headless fallback paths
- `Claude.AI/tools/GDrive.Port.Tool.md` — upstream porting workflow with Step 5 image-math detection
- `Claude.AI/Bot.Erdos/Erdos.GitHubLatex.Rules.md` — the 5 KaTeX rules
- `Claude.AI/Bot.Trey/Trey.OutputStandards.md` §2.3 — upstream rule preventing future image-math
- `Claude.AI/Bot.Erdos/Erdos.Gem.Instructions.md` OUTPUT FORMAT — Erdős equivalent
- `~/.claude/skills/velorin-math-ocr-repair/SKILL.md` — Claude Code Skill wrapper (mirrors this spec)

---

## 7. PROVENANCE

Created Session 032 (2026-04-19) by Jiang under Chairman direction. Triggered by porting `Trey.Research.AutomatedPointerRating.md` and discovering 56 equations had been silently exported as inline PNGs. Validated end-to-end on 137 equations across 5 docs:

| Doc | Patched | Math renderers | Broken |
|---|---|---|---|
| AutomatedPointerRating | 56 | 56 | 0 |
| Epistemodynamics.NoveltyCheck | 48 | 46 | 0 |
| EmotionalMemorySalience.Measurement | 25 | 25 | 0 |
| SemanticMemoryOrganization.Neuroscience | 6 | 6 | 0 |
| SkillsTaxonomyEmergence | 2 | 2 | 0 |
| **Total** | **137** | **135** | **0** |

Total Sonnet cost: ~$0.50. Total wall time: ~5 minutes including sub-agent fan-out.

Discovered the `re.sub` backslash trap on first run — fixed before commit.

[VELORIN.EOF]
