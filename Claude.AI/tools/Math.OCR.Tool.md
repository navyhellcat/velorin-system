# Math Image OCR Tool — Equation PNG → LaTeX
**Velorin System | All Agents | Created Session 032, April 19, 2026**

Repairs ported research docs that contain inline equation images (Google Docs Equation Editor exports). OCRs each small PNG to LaTeX with pix2tex, replaces the `![](images/...)` reference with `$<latex>$` inline, then runs the standard KaTeX fix.

---

## When to Use

Any time the GDrive Port Tool's Step 5 (Image-Math Detection) flags a doc with `inline-math` count > 0. Always run BEFORE the standard KaTeX fix and BEFORE git commit.

## Prerequisites

- `pip3 install pix2tex` — pulls torch (~1GB), one-time install
- `pip3 install Pillow` — usually already present
- A doc that has been ported but not yet KaTeX-fixed or committed

## Heuristic for "math vs figure"

Default size threshold: **8KB**. Images < 8KB are equations 99% of the time. Images > 8KB are figures/diagrams. Override per-doc if needed (`SIZE_THRESHOLD` constant in script).

---

## Script

Save to `/tmp/math_ocr.py`. Edit `DOCS` list. Run.

```python
import re
from pathlib import Path
from pix2tex.cli import LatexOCR
from PIL import Image

BASE = Path("/Users/lbhunt/Desktop/velorin-system")
SIZE_THRESHOLD = 8 * 1024  # bytes

# Each entry: (markdown file relative to BASE, image folder relative to BASE)
DOCS = [
    # ("Claude.AI/Bot.Trey/Research_Complete/Trey.Research.Example.md",
    #  "Claude.AI/Bot.Trey/Research_Complete/images/Trey.Research.Example"),
]

print("Loading pix2tex model (one-time, ~10s)...")
model = LatexOCR()
print("Model loaded.")

for md_rel, img_dir_rel in DOCS:
    md_path = BASE / md_rel
    img_dir = BASE / img_dir_rel
    print(f"\n=== {md_rel} ===")
    if not md_path.exists():
        print(f"  SKIP — markdown missing")
        continue
    if not img_dir.exists():
        print(f"  SKIP — image folder missing")
        continue

    content = md_path.read_text()
    images = sorted(p for p in img_dir.iterdir() if p.is_file())
    ocr_map = {}
    for img in images:
        if img.stat().st_size > SIZE_THRESHOLD:
            print(f"  skip (figure, {img.stat().st_size:,}B): {img.name}")
            continue
        try:
            latex = model(Image.open(img))
            latex = latex.strip()
            ocr_map[img.name] = latex
            print(f"  OCR: {img.name} -> {latex[:60]}{'...' if len(latex)>60 else ''}")
        except Exception as e:
            print(f"  FAIL: {img.name} — {e}")

    # Patch: replace ![](images/<doc_slug>/<basename>) with $<latex>$
    patched = content
    for basename, latex in ocr_map.items():
        # Match the image ref regardless of relative path depth
        pattern = re.compile(r'!\[\]\([^)]*' + re.escape(basename) + r'\)')
        replacement = f"${latex}$"
        before = patched
        patched = pattern.sub(replacement, patched)
        n = len(pattern.findall(before))
        if n == 0:
            print(f"  WARN: {basename} OCR'd but not referenced in markdown")

    md_path.write_text(patched)
    print(f"  WROTE {md_path} (replaced {len(ocr_map)} image refs)")

print("\nDone. Now run KaTeX fix on the same docs to harden GitHub rendering.")
```

---

## Verification After OCR

1. **Spot-check 5-10 random equations** — open the markdown and the original image side by side. pix2tex is ~85-90% accurate on clean Google Docs equations; complex multi-line equations may need manual fix.
2. **Run KaTeX fix** — `python3 /tmp/katex_fix.py` (from `GDrive.Port.Tool.md`) on the same files. Apply Rules 1-5.
3. **GitHub render check** — push, then run the brokenCount DOM query from `GDrive.Port.Tool.md` Step 6.
4. **Optionally keep image folder** — old PNGs become orphaned but cause no harm. Delete with `git rm -r images/<doc_slug>/` only after verification passes and you're confident OCR captured everything.

---

## Known pix2tex Limitations

- **Multi-line equations** (cases, arrays, alignments) — often produces malformed LaTeX. Manual fix required.
- **Bold/italic variables in non-standard fonts** — may misread. Spot-check.
- **Greek + subscripts in same expression** — usually fine, but verify D_KL, H_E, ρ_max etc. by hand.
- **Empty / blurry images** — script catches and reports FAIL; rerun on those manually or transcribe by hand.

If a doc's OCR quality is consistently bad, escalate to Mathpix API (paid, ~95% accurate, requires account).

---

## Why This Exists

Session 032: ported `Trey.Research.AutomatedPointerRating.md`. Initial KaTeX-fix grep returned 0 `$` markers — concluded "no math." Wrong. Google Docs Equation Editor had silently exported all 56 equations as inline PNGs. The doc was load-bearing for the brain ingestion pipeline; the math was unreadable to every downstream agent. CT caught the hallucination. This tool exists so it cannot recur.

The upstream fix lives in `Bot.Trey/` and `Bot.Erdos/` instructions: every research request now mandates LaTeX text output, never Equation Editor objects. This tool is the cleanup pass for any doc that slips through.

[VELORIN.EOF]
