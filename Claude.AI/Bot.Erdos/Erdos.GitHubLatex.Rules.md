# GitHub KaTeX Rendering Rules
**Bot.Erdos | Formatting Reference | Discovered Session 026**

When pushing LaTeX math documents to GitHub, follow these rules to prevent rendering failures.

---

## Rule 1: Never use raw `*` in math formulas — use `\ast`

**Wrong:** `\phi^{*}` / `\mathcal{L}^{*}` / `r^{*}`
**Correct:** `\phi^{\ast}` / `\mathcal{L}^{\ast}` / `r^{\ast}`

**Why:** GitHub's markdown processor runs `*...*` italic detection **before** KaTeX. If a formula contains an odd number of raw `*` characters, markdown italicizes content between the 1st and 2nd `*`, garbling brace structure. KaTeX then throws "Extra close brace or missing open brace."

Theorem 4 in the Royal Society paper had 3 asterisks (`L^{*}`, `φ^{*}`, `φ^{*}`). GitHub italicized `}(\phi^{` between the 1st and 2nd `*`. This was the root cause of 8 failed fix attempts across Session 024.

`\ast` is a LaTeX math command (letters only, no `*` character) — markdown cannot touch it.

---

## Rule 2: Never use raw `||` for norms — use `\lVert\rVert`

**Wrong:** `||\phi||`
**Correct:** `\lVert\phi\rVert`

**Why:** GitHub's table parser treats `||` as table cell separators, stripping them before KaTeX runs. `\lVert` and `\rVert` are pure LaTeX commands — no pipe characters involved.

---

## Rule 3: Avoid nested `\text{}` or `\mathrm{}` inside subscripts of subscripts

**Fragile:** `\sum_{w \in C_{\mathrm{regular}}}`
**Safe:** `\sum_{w \in C_{regular}}`

GitHub's KaTeX rendering has issues with nested brace commands inside double-subscript contexts. Use plain letter strings for subscripts when possible.

---

## Rule 4: Escape underscores in inline math — use `\_`

**Wrong:** `$\mathcal{H}_E \gg 0$` ... `$x_{\ast}$` (on same line or paragraph)
**Correct:** `$\mathcal{H}\_E \gg 0$` ... `$x\_{\ast}$`

**Why:** GitHub's markdown parser pairs `_..._` characters as italic emphasis **before** the math extractor runs. When two or more `_` characters appear in inline math on the same paragraph, markdown pairs them and injects `<em>...</em>` tags **inside** the `$...$` span. KaTeX then sees malformed input like `$\mathcal{H}<em>E \gg 0$` and refuses to render.

The `\_` escape tells markdown "this is a literal underscore, not an emphasis marker." KaTeX still receives a valid `_` for subscript semantics because markdown's backslash-escape is processed inline.

Session 028 root cause: The Ignition Protocol file had ~80 inline `$...$` spans. Lines with multiple underscores across math blocks broke rendering. Escape all underscores inside inline `$...$` (NOT inside display `$$...$$` — see Rule 5).

---

## Rule 5: Display math `$$...$$` must have blank lines above and below

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

**Why:** Without blank-line separation, markdown treats the prose + display-math + prose as one paragraph. Emphasis scanning runs across the `$$...$$` boundary. Any `_` chars inside the display math pair with `_` in prose and inject `<em>` tags that break the math.

With blank lines, each `$$...$$` becomes its own block-level element. Markdown processes it as math, not as inline content with pairable emphasis.

You do **not** need to escape underscores inside `$$...$$` as long as the block is properly isolated by blank lines.

---

## Diagnostic Key

| KaTeX Error / Symptom | Most Likely Cause |
|-----------------------|-------------------|
| "Extra close brace or missing open brace" | Odd number of raw `*` in formula — markdown italicized brace content (Rule 1) |
| Formula disappears entirely | `||` pipes present — table parser stripped them (Rule 2) |
| Subscript renders as italic text | `_word` outside math context — add `$...$` |
| `<em>` tags visible inside `$...$` HTML | Paired `_` chars in inline math — escape with `\_` (Rule 4) |
| Display math fails mid-equation | Not isolated by blank lines — add them (Rule 5) |
| Whole paragraph renders as raw `$...$` | Paragraph wrapped in `*...*` italic — use `**bold**` or split |

---

*Erdős | Velorin System | Rules updated Session 028 | April 17, 2026*

---

**System-wide version (includes Python fix script + DOM verification query):**  
`Claude.AI/tools/GitHub.KaTeX.Rules.md`

[VELORIN.EOF]
