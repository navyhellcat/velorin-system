# GitHub KaTeX Rendering Rules — System Wide
**Velorin System | All Math Documents | Last updated Session 029, April 17, 2026**

Apply these rules whenever writing or fixing any `.md` file that contains LaTeX math pushed to GitHub.
Source rules were discovered across Sessions 024–028 on the Erdős corpus. They apply universally.

---

## The Five Rules

### Rule 1: Never use raw `*` in math — use `\ast`

**Wrong:** `\phi^{*}` / `\mathcal{L}^{*}` / `r^{*}`  
**Correct:** `\phi^{\ast}` / `\mathcal{L}^{\ast}` / `r^{\ast}`

**Why:** GitHub's markdown processor runs `*...*` italic detection before KaTeX. An odd number of raw `*` in a formula causes markdown to italicize brace content. KaTeX then throws "Extra close brace or missing open brace."

---

### Rule 2: Never use raw `||` for norms — use `\lVert\rVert`

**Wrong:** `||\phi||`  
**Correct:** `\lVert\phi\rVert`

**Why:** GitHub's table parser treats `||` as cell separators and strips them before KaTeX runs.

---

### Rule 3: Avoid nested `\text{}` / `\mathrm{}` inside double subscripts

**Fragile:** `\sum_{w \in C_{\mathrm{regular}}}`  
**Safe:** `\sum_{w \in C_{regular}}`

GitHub's KaTeX has issues with nested brace commands in double-subscript contexts.

---

### Rule 4: Escape underscores inside inline `$...$` — use `\_`

**Wrong:** `$\mathcal{H}_E \gg 0$` ... `$x_{\ast}$` (multiple `_` in same paragraph)  
**Correct:** `$\mathcal{H}\_E \gg 0$` ... `$x\_{\ast}$`

**Why:** GitHub pairs `_..._` as italic emphasis before extracting math. When two or more `_` appear in inline math blocks on the same paragraph, markdown injects `<em>` tags inside `$...$` spans. KaTeX sees malformed input and fails.

`\_` tells markdown "literal underscore." KaTeX still receives valid `_` for subscript semantics.

Does **not** apply inside display `$$...$$` — see Rule 5.

---

### Rule 5: Display `$$...$$` blocks must have blank lines above and below

**Wrong:**
```
...ending prose here.
$$ f(x_{\ast}) = \pi^{(q)}_u $$
We select the top...
```

**Correct:**
```
...ending prose here.

$$ f(x_{\ast}) = \pi^{(q)}_u $$

We select the top...
```

**Why:** Without blank-line isolation, markdown treats prose + display-math + prose as one paragraph and runs emphasis scanning across the `$$...$$` boundary. Blank lines make each `$$...$$` a block-level element — markdown processes it as math, not inline content.

Underscores inside `$$...$$` do **not** need escaping as long as the block has blank lines on both sides.

---

## Diagnostic Key

| Symptom | Cause |
|---------|-------|
| "Extra close brace or missing open brace" | Odd number of raw `*` — markdown italicized brace content (Rule 1) |
| Formula disappears entirely | `\|\|` pipes stripped by table parser (Rule 2) |
| `<em>` tags inside `$...$` HTML | Paired `_` in inline math — escape with `\_` (Rule 4) |
| Display math fails mid-equation | Not isolated by blank lines (Rule 5) |
| Whole paragraph renders as raw `$...$` | Paragraph wrapped in `*...*` — split or use `**bold**` |
| Subscript renders as italic text | `_word` outside math context — wrap in `$...$` |

---

## Python Fix Script (Batch — Rules 1, 2, 4, 5)

Idempotent. Safe to run on already-fixed files. Covers all automatable rules.
Rule 3 (nested subscripts) requires manual inspection — no safe regex.

```python
import re
from pathlib import Path

BASE = Path("/Users/lbhunt/Desktop/velorin-system")

FILES = [
    # Add paths relative to BASE
    # "Claude.AI/Bot.Erdos/Research_Complete/Erdos.Example.md",
]

def fix_rule1(s):
    """^{*} and ^* → ^{\ast}"""
    s = re.sub(r'\^\{\s*\*\s*\}', r'^{\\ast}', s)
    s = re.sub(r'\^(\s*)\*', r'^{\ast}', s)
    return s

def fix_rule2(s):
    """||...|| → \lVert...\rVert; leftover || → \|\|"""
    s = re.sub(r'\|\|([^|]+?)\|\|', r'\\lVert\1\\rVert', s)
    s = re.sub(r'\|\|', r'\\|\\|', s)
    return s

def fix_rule4(s):
    """Escape unescaped _ in inline math."""
    return re.sub(r'(?<!\\)_', r'\\_', s)

for f in FILES:
    p = BASE / f
    content = p.read_text()

    # 1. Fix display math (Rules 1+2 inside $$...$$), stash it
    display_blocks = []
    def stash_display(m):
        inner = m.group(0)[2:-2]
        inner = fix_rule1(inner)
        inner = fix_rule2(inner)
        display_blocks.append(f'$${inner}$$')
        return f"\x00DISP{len(display_blocks)-1}\x00"
    c2 = re.sub(r'\$\$[\s\S]*?\$\$', stash_display, content)

    # 2. Fix inline math (Rules 1+2+4 inside $...$)
    def fix_inline(m):
        inside = fix_rule4(m.group(1))
        inside = fix_rule1(inside)
        inside = fix_rule2(inside)
        return f"${inside}$"
    c3 = re.sub(r'\$([^\$\n]+?)\$', fix_inline, c2)

    # 3. Restore display math
    c4 = re.sub(r'\x00DISP(\d+)\x00', lambda m: display_blocks[int(m.group(1))], c3)

    # 4. Ensure blank lines around $$...$$ blocks (Rule 5)
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

---

## DOM Verification Query

Run in browser console on the rendered GitHub page to confirm zero broken paragraphs:

```javascript
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

`brokenCount: 0` = clean. Any value above 0 = Rule 4 or Rule 5 violation present.

---

## How to Find Math Files Needing a Fix

```bash
# Find all .md files with display math ($$) — strongest signal
grep -rl '\$\$' --include="*.md" /path/to/repo | grep -v ".git"

# Find .md files with inline math or display math (excludes shell-variable $)
grep -rl '\$\$\|\$[a-zA-Z\\{]' --include="*.md" /path/to/repo | grep -v ".git"
```

---

*Source: `Claude.AI/Bot.Erdos/Erdos.GitHubLatex.Rules.md` (original Erdős-scoped version — preserved for historical context)*  
*System-wide version created: Session 029, April 17, 2026*

[VELORIN.EOF]
