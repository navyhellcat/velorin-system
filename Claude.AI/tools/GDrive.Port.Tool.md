# GDrive → GitHub Port Tool
**Velorin System | All Agents | Created Session 029, April 17, 2026**

Ports Google Drive research docs (with embedded images, charts, tables, flowcharts) to the local repo as markdown. Images are extracted and committed alongside the `.md` file. Zero content routes through Claude's Write tool or context window.

---

## When to Use

Any time a Trey (or other agent) research doc lands in Google Drive and needs to move to `Research_Complete/` or any local repo folder. Handles docs with embedded charts, diagrams, tables, screenshots — anything Google Docs can contain.

## Prerequisites

- OAuth token active: `/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gdrive-mcp/tokens.json`
- Python libs: `requests`, `beautifulsoup4`, `html2text` (install: `pip3 install html2text beautifulsoup4 requests`)
- The file ID of the Google Doc (visible in its Drive URL: `docs.google.com/document/d/FILE_ID/edit`)

---

## How to Run

1. Copy the script below to `/tmp/gdrive_port.py`
2. Edit the `DOCS` list — set `file_id` and `filename` for each doc
3. Set `DEST` to the target folder in the repo
4. Run: `python3 /tmp/gdrive_port.py`
5. Run the KaTeX fix on any doc that contains math — `python3 /tmp/katex_fix.py` (see script below)
6. Verify on GitHub: DOM query `brokenCount` must be 0 before moving on
7. `git mv` the corresponding request file from `Research_Needed/` to `Archived_Research_Requests/`
8. Git add + commit + push (single commit covering doc, images, and archive move)

---

## Script

```python
import json, os, re, zipfile, io, base64, requests, html2text
from pathlib import Path
from bs4 import BeautifulSoup

TOKEN_PATH = "/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gdrive-mcp/tokens.json"
OAUTH_KEYS_PATH = "/Users/lbhunt/Desktop/Velorin/Velorin Code/velorin-gdrive-mcp/gcp-oauth.keys.json"

# ── CONFIGURE THESE ──────────────────────────────────────────────────────────
DEST = Path("/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Trey/Research_Complete")

DOCS = [
    {
        "file_id": "GOOGLE_FILE_ID_HERE",
        "filename": "Trey.Research.TopicName.md",
    },
]
# ─────────────────────────────────────────────────────────────────────────────


def get_access_token():
    tokens = json.loads(Path(TOKEN_PATH).read_text())
    access_token = tokens["access_token"]
    r = requests.get(
        "https://www.googleapis.com/drive/v3/about?fields=user",
        headers={"Authorization": f"Bearer {access_token}"},
        timeout=10,
    )
    if r.status_code == 401:
        keys = json.loads(Path(OAUTH_KEYS_PATH).read_text())
        creds = keys.get("installed") or keys.get("web")
        refresh_r = requests.post(
            "https://oauth2.googleapis.com/token",
            data={
                "client_id": creds["client_id"],
                "client_secret": creds["client_secret"],
                "refresh_token": tokens["refresh_token"],
                "grant_type": "refresh_token",
            },
            timeout=10,
        )
        refresh_r.raise_for_status()
        new_tokens = refresh_r.json()
        tokens["access_token"] = new_tokens["access_token"]
        Path(TOKEN_PATH).write_text(json.dumps(tokens, indent=2))
        access_token = new_tokens["access_token"]
        print("Token refreshed.")
    else:
        r.raise_for_status()
    return access_token


def export_doc(file_id, access_token):
    """Export Google Doc as HTML. Returns (html_bytes, images_dict {name: bytes})."""
    url = f"https://www.googleapis.com/drive/v3/files/{file_id}/export"
    r = requests.get(
        url,
        params={"mimeType": "text/html"},
        headers={"Authorization": f"Bearer {access_token}"},
        timeout=60,
    )
    r.raise_for_status()
    images = {}
    if "zip" in r.headers.get("Content-Type", "") or r.content[:2] == b"PK":
        with zipfile.ZipFile(io.BytesIO(r.content)) as zf:
            html_bytes = None
            for name in zf.namelist():
                if name.endswith(".html"):
                    html_bytes = zf.read(name)
                elif re.match(r"images/", name) and not name.endswith("/"):
                    images[os.path.basename(name)] = zf.read(name)
            if html_bytes is None:
                raise ValueError("No HTML in zip export")
    else:
        html_bytes = r.content
    return html_bytes, images


def extract_base64_images(soup, images_dir, doc_slug):
    count = 0
    for img in soup.find_all("img"):
        src = img.get("src", "")
        if src.startswith("data:image/"):
            match = re.match(r"data:image/(\w+);base64,(.+)", src, re.DOTALL)
            if match:
                ext, data = match.group(1), base64.b64decode(match.group(2))
                name = f"{doc_slug}_img{count:03d}.{ext}"
                (images_dir / name).write_bytes(data)
                img["src"] = f"images/{doc_slug}/{name}"
                count += 1
    return count


def html_to_markdown(html_bytes, images_dir, doc_slug, named_images):
    soup = BeautifulSoup(html_bytes, "html.parser")
    for tag in soup.find_all(["style", "meta", "script"]):
        tag.decompose()
    if named_images:
        for name, data in named_images.items():
            (images_dir / name).write_bytes(data)
        for img in soup.find_all("img"):
            basename = os.path.basename(img.get("src", ""))
            if basename in named_images:
                img["src"] = f"images/{doc_slug}/{basename}"
    n = extract_base64_images(soup, images_dir, doc_slug)
    if n:
        print(f"  Extracted {n} base64 images")
    h = html2text.HTML2Text()
    h.ignore_links = False
    h.ignore_images = False
    h.body_width = 0
    h.unicode_snob = True
    h.ul_item_mark = "-"
    body = soup.find("body") or soup
    md = h.handle(str(body))
    md = re.sub(r'\n{4,}', '\n\n\n', md).strip()
    return md


def port_doc(doc_info, access_token):
    file_id, filename = doc_info["file_id"], doc_info["filename"]
    doc_slug = filename.replace(".md", "")
    print(f"\nPorting: {filename}")
    images_dir = DEST / "images" / doc_slug
    images_dir.mkdir(parents=True, exist_ok=True)
    print("  Downloading HTML export...")
    html_bytes, named_images = export_doc(file_id, access_token)
    print(f"  HTML: {len(html_bytes):,} bytes, zip images: {len(named_images)}")
    md = html_to_markdown(html_bytes, images_dir, doc_slug, named_images)
    (DEST / filename).write_text(md, encoding="utf-8")
    print(f"  Written: {DEST / filename} ({len(md):,} chars)")
    imgs = list(images_dir.iterdir())
    if not imgs:
        images_dir.rmdir()
        print("  No images.")
    else:
        print(f"  Saved {len(imgs)} images to images/{doc_slug}/")


access_token = get_access_token()
print("Token OK.")
for doc in DOCS:
    port_doc(doc, access_token)
print("\nDone. Run: git add . && git commit -m '...' && git push")
```

---

## KaTeX Fix Script (Step 5 — run on any doc with math)

Edit `FILES` to point at the ported `.md` file(s). Idempotent — safe to run twice.

```python
import re
from pathlib import Path

BASE = Path("/Users/lbhunt/Desktop/velorin-system")
FILES = [
    # "Claude.AI/Bot.Trey/Research_Complete/Trey.Research.Example.md",
]

def fix_rule1(s):
    s = re.sub(r'\^\{\s*\*\s*\}', r'^{\\ast}', s)
    s = re.sub(r'\^(\s*)\*', r'^{\ast}', s)
    return s

def fix_rule2(s):
    s = re.sub(r'\|\|([^|]+?)\|\|', r'\\lVert\1\\rVert', s)
    s = re.sub(r'\|\|', r'\\|\\|', s)
    return s

def fix_rule4(s):
    return re.sub(r'(?<!\\)_', r'\\_', s)

for f in FILES:
    p = BASE / f
    content = p.read_text()
    display_blocks = []
    def stash(m):
        inner = fix_rule1(fix_rule2(m.group(0)[2:-2]))
        display_blocks.append(f'$${inner}$$')
        return f"\x00DISP{len(display_blocks)-1}\x00"
    c2 = re.sub(r'\$\$[\s\S]*?\$\$', stash, content)
    def fix_inline(m):
        i = fix_rule4(fix_rule1(fix_rule2(m.group(1))))
        return f"${i}$"
    c3 = re.sub(r'\$([^\$\n]+?)\$', fix_inline, c2)
    c4 = re.sub(r'\x00DISP(\d+)\x00', lambda m: display_blocks[int(m.group(1))], c3)
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

## GitHub Verify (Step 6 — run in browser console on rendered page)

```javascript
const article = document.querySelector('article');
const broken = [...article.querySelectorAll('p, li, td')].filter(p => {
  const h = p.innerHTML;
  return h.includes('$') && /\$[^\$<]*<em>|<\/em>[^\$>]*\$/.test(h);
});
({ mathRenderers: article.querySelectorAll('math-renderer').length, brokenCount: broken.length })
```

`brokenCount: 0` = good to go.

---

## Git Push Note

If push fails with HTTP 400 (binary files), run once:
```bash
git config http.postBuffer 524288000
```
Then push again. Setting persists.

---

## How to Find a File ID

From any Google Drive URL:
`https://docs.google.com/document/d/**1abc123XYZ**/edit` — the bold part is the file ID.

Or use the `gdrive_search` MCP tool:
```
mcp__velorin-gdrive__gdrive_search(query="Doc name here")
```

---

*Created from Session 029 port of 2 Trey research docs. Verified: 8 images committed, all rendered on GitHub.*

[VELORIN.EOF]
