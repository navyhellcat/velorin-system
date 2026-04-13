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

## Diagnostic Key

| KaTeX Error | Most Likely Cause |
|-------------|-------------------|
| "Extra close brace or missing open brace" | Odd number of raw `*` in formula — markdown italicized brace content |
| Formula disappears entirely | `||` pipes present — table parser stripped them |
| Subscript renders as italic text | `_word` outside math context — add `$...$` |

---

*Erdős | Velorin System | Session 026 | April 13, 2026*

[VELORIN.EOF]
