# Jiang Session 028 Handoff — April 17, 2026

**Status:** Terminated early by Chairman due to context waste. Work unfinished.
**Reason for termination:** Burned ~2 full context windows on what was a 40-line Python fix plus verification. Inexcusable. Rules captured below to prevent repeat.

---

## WHAT WAS COMPLETED THIS SESSION

1. **Ignition Protocol file — FULLY FIXED and rendering on GitHub.**
   Path: `Claude.AI/Bot.Erdos/Research_Complete/Erdos.FutureTheory.IgnitionProtocol.DarkMatter.md`
   - Renamed from bad filename (no .md, bad chars) → proper `.md`
   - Escaped all `_` inside inline `$...$` to `\_`
   - Added blank lines before/after all display `$$...$$` blocks
   - Removed `*...*` paragraph-wide italic wrap on line 7
   - Verified rendering visually on GitHub — 83 math-renderer elements, 0 broken
   - Final commit: `e859d15`

2. **Rules doc updated — `Erdos.GitHubLatex.Rules.md` now has Rule 4 and Rule 5.**
   - **Rule 4:** Escape underscores in inline math (`\_` instead of `_`) to block markdown's `_..._` italic pairing across `$...$` spans.
   - **Rule 5:** Display math `$$...$$` MUST have blank lines before and after — otherwise markdown scans emphasis across the block boundary and breaks the math.
   - Diagnostic key expanded with new symptom patterns.

3. **Jiang2 build guide prompt delivered** (earlier in session, approved by Chairman).

---

## WHAT REMAINS — PICK UP NEXT SESSION

**Apply the same fix to the other 9 Erdős math docs.** All of them have the `_`-pairing bug even after earlier Session 026 fixes (those only addressed Rule 1, not Rules 4/5).

Files:
1. `Erdos.DimensionalGeology.Theoretical.md`
2. `Erdos.Initial.Synthesis.Stage1.md`
3. `Erdos.Novelties.BrainArchitecture.md`
4. `Erdos.Royal.Society.Paper.md` ← confirmed broken this session
5. `Erdos.Solution.SynapticPruning.md`
6. `Erdos.Stage2.Problem.Solving.md`
7. `Erdos.Thermodynamics.Emistemological.Time.Future.Consideration.md`
8. `Erdos.Unification.Stage3.md`
9. `Erdos_Layer_Math_v1_FULL_With_Hypothetical.md`

### The exact Python fix (idempotent — safe to run)

```python
import re, sys
from pathlib import Path

FILES = [
    "Claude.AI/Bot.Erdos/Research_Complete/Erdos.DimensionalGeology.Theoretical.md",
    "Claude.AI/Bot.Erdos/Research_Complete/Erdos.Initial.Synthesis.Stage1.md",
    "Claude.AI/Bot.Erdos/Research_Complete/Erdos.Novelties.BrainArchitecture.md",
    "Claude.AI/Bot.Erdos/Research_Complete/Erdos.Royal.Society.Paper.md",
    "Claude.AI/Bot.Erdos/Research_Complete/Erdos.Solution.SynapticPruning.md",
    "Claude.AI/Bot.Erdos/Research_Complete/Erdos.Stage2.Problem.Solving.md",
    "Claude.AI/Bot.Erdos/Research_Complete/Erdos.Thermodynamics.Emistemological.Time.Future.Consideration.md",
    "Claude.AI/Bot.Erdos/Research_Complete/Erdos.Unification.Stage3.md",
    "Claude.AI/Bot.Erdos/Research_Complete/Erdos_Layer_Math_v1_FULL_With_Hypothetical.md",
]

for f in FILES:
    p = Path(f)
    content = p.read_text()

    # 1. Protect display math
    display = []
    def stash(m):
        display.append(m.group(0))
        return f"\x00DISP{len(display)-1}\x00"
    c2 = re.sub(r'\$\$[\s\S]*?\$\$', stash, content)

    # 2. Escape _ inside inline $...$ (skip already-escaped \_)
    def esc(m):
        inside = re.sub(r'(?<!\\)_', r'\\_', m.group(1))
        return f"${inside}$"
    c3 = re.sub(r'\$([^\$\n]+?)\$', esc, c2)

    # 3. Restore display math
    c4 = re.sub(r'\x00DISP(\d+)\x00', lambda m: display[int(m.group(1))], c3)

    # 4. Ensure blank lines around $$...$$ blocks
    lines = c4.splitlines(keepends=True)
    out = []
    for i, line in enumerate(lines):
        s = line.strip()
        is_disp = s.startswith('$$') and s.endswith('$$') and len(s) > 4
        if is_disp:
            if out and out[-1].strip() != '':
                out.append('\n')
            out.append(line)
            if i + 1 < len(lines) and lines[i+1].strip() != '':
                out.append('\n')
        else:
            out.append(line)
    p.write_text(''.join(out))
    print(f"fixed {f}")
```

### Verification steps

1. Run script, commit, push (single commit is fine — these are all the same fix).
2. Spot-check 2-3 random files on GitHub via authenticated browser.
3. Query DOM: `document.querySelectorAll('math-renderer').length` should be high; `<em>` tags inside `$...$` should be zero.
4. Done.

Estimated time: 10-15 minutes. Should fit in a small fraction of one context window.

---

## CRITICAL FAILURE MODE — DO NOT REPEAT

**What happened this session:** Burned ~2 full context windows. Chairman terminated early.

**Root causes:**
1. **Guessed instead of verified.** Tried backtick-wrapping `` $`...`$ `` without checking GitHub docs first — didn't work — wasted a commit cycle.
2. **Trusted hallucinated WebFetch output.** Private repo → WebFetch hit login page → hallucinated content → I treated it as ground truth for a minute.
3. **Piecemeal tool loading.** Loaded Chrome MCP tools one at a time via ToolSearch instead of loading the set needed up front.
4. **Over-verbose diagnostics.** Repeated screenshots, repeated JS DOM queries, re-reading files already in context.
5. **Session-reset amnesia.** Earlier context had the files loaded; I re-read them.

**The actual work was a 40-line Python script plus one commit plus one visual verification.** Should have been one diagnostic pass, one script, one push, one verify. Not iterative test-driven fumbling.

### Rules locked in for future sessions

- **Identify root cause BEFORE patching.** One diagnostic pass — get DOM state, inspect HTML, find pattern — THEN write the fix. Don't test-fix-push-verify in a loop.
- **For private repos, skip WebFetch entirely.** Go straight to authenticated Chrome MCP or local file read. WebFetch on github.com private URLs returns login-page hallucinations.
- **Load the full toolset needed at the start of a task.** If the task needs Chrome MCP, load navigate + javascript_tool + computer all at once via one ToolSearch call.
- **One script, one commit, one verify.** If the fix pattern is identical across N files, apply to all N in one commit — don't do one-at-a-time as "tests."
- **Stop taking screenshots to "visually confirm" what DOM queries already confirmed.** A query returning `{brokenCount: 0, mathRenderers: 83}` is the answer. Don't also screenshot.

---

## REFERENCE — exact diagnostic pattern for future KaTeX rendering bugs

```javascript
// Run in browser console on the rendered GitHub page
const article = document.querySelector('article');
const paragraphs = [...article.querySelectorAll('p, li, td')];
const broken = paragraphs.filter(p => {
  const html = p.innerHTML;
  return html.includes('$') && /\$[^\$<]*<em>|<\/em>[^\$>]*\$/.test(html);
});
({
  totalMathRenderers: article.querySelectorAll('math-renderer').length,
  brokenCount: broken.length,
  samples: broken.slice(0, 3).map(p => p.innerHTML.substring(0, 300))
})
```

If `brokenCount > 0`, you have the `_`-pairing bug. Apply the Python fix above.

---

[VELORIN.EOF]
