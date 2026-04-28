# URL Port Tool — External Web Article → Repo Markdown
**Velorin System | All Agents | Created Session 040, April 28, 2026 (Jiang1)**

Sibling to `GDrive.Port.Tool.md`. Ports any open-web article (HTML page, PDF) into the repo as markdown + extracted figures. Zero content routes through Claude's Write tool or context window during fetch/extract.

---

## When to Use

When CT or any agent needs an external paper, blog post, or doc read by Trey, Erdős, or any other Velorin agent. Putting it in the repo means:
- Trey/Erdős read it from GitHub (their normal source-of-truth path) instead of consuming Claude's browser tokens
- It's reproducible across sessions and across vendors
- Figures stay accessible as PNGs/JPEGs

Replaces the Claude-browser path (~30K+ tokens per page render) with a local pipeline (~17K tokens spot-check on Claude side, the rest is local CPU).

---

## ⚠️ Tool Transition Note — Read First

**The current implementation uses PyMuPDF (`fitz`) — this is the INTERIM tool.**

The build guide (`Claude.AI/New Build/05_InfrastructureAndTools.md`, `06_BuildSequence.md` Stage 1 Step 5) specifies **OpenDataLoader PDF v2.0** as the canonical PDF parser for Velorin. OpenDataLoader provides:
- XY-Cut++ reading order (solves the figure-overlay-text-flattening problem PyMuPDF has)
- Formula Extraction AI (LaTeX inline preservation)
- JSON bbox per element → enables `source_coords` neuron field for citation-level provenance
- 0.907 accuracy across 200 scientific papers

**At Mac Studio Stage 1 build, this tool will be rewritten on top of OpenDataLoader.** The `port_url.py` script below is a working stopgap that runs on any Mac with Python 3.9+ and `pip install pymupdf` (no Homebrew dependency chain). When OpenDataLoader is installed and forked into `tools-and-research/opendataloader/`, replace the extraction step in this tool — the surrounding pipeline (fetch, line filter, KaTeX fix, repo placement) stays the same.

Until then: PyMuPDF works for body-text extraction. The known limitation is that figure-panel overlays (axis labels, P-values inside subplots) get flattened into single 4000+ char lines. The interim filter (drop lines >500 chars, replace with `<!-- figure panel text removed -->` marker) preserves figure context while removing garbage. Figure images themselves are extracted cleanly.

---

## Prerequisites

- Python 3.9+
- `pip install pymupdf` (~10 seconds; pulls only the PyMuPDF wheel, no native compile)
- Optional fallback: `brew install pandoc poppler` for HTML-with-MathML papers (rare)

---

## How to Run

1. Identify the article URL.
2. Fetch HTML and probe for math/structure (Step A below).
3. If the article has math as MathML (rare for most journals — Nature does not, despite displaying MathJax on render), use `pandoc --from html --to gfm --mathjax`.
4. Otherwise, fetch the PDF (Step B) — most journal sites expose `<url>.pdf` directly.
5. Run `port_url.py` (Step C) — extracts text + images.
6. Run the filter step (Step D) — removes figure-overlay garbage lines.
7. Run the standard KaTeX fix (`Claude.AI/tools/GDrive.Port.Tool.md` Step 5) IF the document contains `$...$` math markers. (Most non-physics journals have no display math; skip if grep returns zero `$`.)
8. Place under `Claude.AI/External/<slug>.md` with figures in `Claude.AI/External/images/<slug>/`.
9. Commit and push with a single commit covering doc + images.
10. Reference by GitHub path in any agent prompt that needs the article.

---

## Step A — Probe HTML

```bash
curl -sL -A "Mozilla/5.0" "<URL>" -o /tmp/article.html
wc -c /tmp/article.html
grep -oE '<title>[^<]+</title>' /tmp/article.html | head -1
grep -oE '<math[^>]*>' /tmp/article.html | wc -l    # MathML count
grep -ic "subscribe\|paywall\|access denied" /tmp/article.html
```

If MathML count > 0: try the pandoc HTML path. Otherwise: PDF path (Step B).

---

## Step B — Fetch PDF

```bash
# Most journal articles expose a PDF at <article-url>.pdf
curl -sL -A "Mozilla/5.0" "<URL>.pdf" -o /tmp/article.pdf
file /tmp/article.pdf      # confirm: "PDF document, version 1.4..."
wc -c /tmp/article.pdf
```

If the PDF is paywalled or returns HTML: stop. Article requires a different path (Sci-Hub, institutional access, manual download, etc) — out of scope for this tool.

---

## Step C — Extract (PyMuPDF — INTERIM)

Save to `/tmp/port_url.py`:

```python
#!/usr/bin/env python3
"""URL Port — INTERIM (PyMuPDF). Replace with OpenDataLoader at Stage 1."""
import fitz  # pip install pymupdf
from pathlib import Path

PDF = Path("/tmp/article.pdf")            # ← edit
OUT_DIR = Path("/tmp/port_out")           # ← edit
SLUG = "Author.Year.ShortTitle"           # ← edit (used for image filenames)

OUT_DIR.mkdir(exist_ok=True)
IMG_DIR = OUT_DIR / "images"
IMG_DIR.mkdir(exist_ok=True)

doc = fitz.open(PDF)
md = [
    f"# {doc.metadata.get('title') or SLUG}\n",
    f"**Source:** <URL>\n",
    f"**Authors (PDF metadata):** {doc.metadata.get('author','(none)')}\n",
    f"**Pages:** {doc.page_count}\n\n---\n",
]

img_count = 0
for pno in range(doc.page_count):
    page = doc.load_page(pno)
    md.append(f"\n## Page {pno+1}\n")
    md.append(page.get_text("text", sort=True))
    for img_idx, img in enumerate(page.get_images(full=True)):
        xref = img[0]
        try:
            base = doc.extract_image(xref)
            ext = base.get("ext", "png")
            data = base.get("image")
            if data and len(data) > 1024:        # skip <1KB icons
                fname = f"page{pno+1:02d}_img{img_idx:02d}.{ext}"
                (IMG_DIR / fname).write_bytes(data)
                md.append(f"\n![Figure on page {pno+1}](images/{fname})\n")
                img_count += 1
        except Exception as e:
            print(f"  page {pno+1} img {img_idx}: {e}")
doc.close()

md_path = OUT_DIR / f"{SLUG}.md"
md_path.write_text("".join(md), encoding="utf-8")
print(f"Wrote {md_path} ({md_path.stat().st_size:,} B); {img_count} images")
```

Run: `python3 /tmp/port_url.py`

---

## Step D — Filter Figure-Overlay Garbage

PyMuPDF's `sort=True` flattens figure-internal text (axis labels, panel letters, P-values) onto single 4000+ char lines. These are unreadable and corrupt the markdown. Drop them — figure context is preserved by the corresponding image reference.

```python
import re
from pathlib import Path

src = Path("/tmp/port_out/<SLUG>.md")
content = src.read_text()
lines = content.splitlines(keepends=False)

cleaned = []
for line in lines:
    if len(line) > 500:
        cleaned.append(f"<!-- [figure panel text removed: {len(line)} chars; see corresponding image] -->")
    else:
        cleaned.append(line)
out = re.sub(r'\n{3,}', '\n\n', "\n".join(cleaned))
Path(str(src).replace(".md", ".clean.md")).write_text(out, encoding="utf-8")
```

The 500-char threshold is empirical — real prose lines never exceed it; figure overlays always do. Tune per-paper if a legitimate dense table is being clipped.

When OpenDataLoader replaces this step, the filter goes away — XY-Cut++ produces correct reading order at parse time.

---

## Step E — Verify Math (if applicable)

```bash
# How many math markers survived?
grep -c '\$' /tmp/port_out/<SLUG>.clean.md
# Any image-math (rare in non-equation-editor sources)?
grep -cE '!\[\]\(images/' /tmp/port_out/<SLUG>.clean.md
```

If `$` count > 0: run the KaTeX fix script from `GDrive.Port.Tool.md` Step 5 on the cleaned file.

If image-math is suspected (small images embedded mid-sentence): run `Claude.AI/tools/Math.OCR.Tool.md` pipeline.

For most non-physics journal papers neither step is needed — math comes through as plain Unicode text.

---

## Step F — Place in Repo

Naming convention: `<LeadAuthor>.<Year>.<ShortTitle>` — consistent with academic citation style.

```bash
cd /Users/lbhunt/Desktop/velorin-system
mkdir -p "Claude.AI/External/images/<SLUG>"
cp /tmp/port_out/<SLUG>.clean.md "Claude.AI/External/<SLUG>.md"
cp /tmp/port_out/images/* "Claude.AI/External/images/<SLUG>/"
```

---

## Step G — Commit and Push

```bash
git add "Claude.AI/External/<SLUG>.md" "Claude.AI/External/images/<SLUG>/"
git commit -m "Port external article: <Author> <Year> — <Short Title>"
git push
```

---

## How to Reference in Agent Prompts

Single line that goes into Trey/Erdős prompts (replaces the bare URL):

```
Claude.AI/External/<SLUG>.md (extracted from <URL>; figures in images/<SLUG>/)
```

The agent reads it from GitHub the same way they read any other Velorin file. No browser tokens consumed.

---

## Token Cost Reference

Validated Session 040 against Tafazoli et al. 2025 (Nature, 36 pages, 57 figures):

| Phase | Claude tokens |
|---|---|
| HTML probe | ~1K |
| PDF extraction (local Python) | 0 |
| Reading extraction output | ~3K |
| Math/figure spot-check grep | ~12K |
| Cleanup + verification | ~1K |
| **Total** | **~17K** |

Vs. Claude browser baseline: 30K+ for initial render alone. **~45% reduction** plus a permanent local artifact and 57 reusable figure files.

---

## Limitations (PyMuPDF interim — fixed by OpenDataLoader replacement)

| Limitation | Workaround | Permanent fix |
|---|---|---|
| Figure-overlay text flattens to single 4000+ char lines | Step D 500-char filter | OpenDataLoader XY-Cut++ reading order |
| No formula extraction (image-math in physics/math papers becomes orphan PNGs) | `Math.OCR.Tool.md` pipeline (pix2tex) | OpenDataLoader Formula Extraction AI |
| No bbox metadata per element | None — figures lose source-coord granularity | OpenDataLoader JSON bbox per element → neuron `source_coords` |
| Headers/footers not always stripped | Manual edit | OpenDataLoader element classification |
| Tables flatten poorly | Manual reformatting | OpenDataLoader table-aware extraction |

Despite the limitations, body text quality on tested papers is high enough for Trey/Erdős consumption — confirmed Session 040.

---

## Related Files

- `Claude.AI/tools/GDrive.Port.Tool.md` — sibling tool for Google Drive sources
- `Claude.AI/tools/Math.OCR.Tool.md` — image-math OCR fallback (pix2tex)
- `Claude.AI/Skills and Hooks Pending Development/GitHub.KaTeX.Rules.md` — math rendering rules
- `Claude.AI/New Build/05_InfrastructureAndTools.md` (Media Extraction Tools section) — OpenDataLoader as the canonical replacement
- `Claude.AI/New Build/06_BuildSequence.md` Stage 1 Step 5 — OpenDataLoader installation step

---

## Provenance

Created Session 040 (2026-04-28) by Jiang1 under Chairman direction. Triggered by need to port Tafazoli et al. 2025 Nature paper (`Building compositional tasks with shared neural subspaces`) into the repo for Trey + Erdős consumption without burning Claude browser tokens. First port completed: `Claude.AI/External/Tafazoli.2025.CompositionalSubspaces.md` + 57 figures.

[VELORIN.EOF]
