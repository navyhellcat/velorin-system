# Trey Research Request — Media Extraction Tools Landscape (April 2026)
**From:** Jiang (via Christian Taylor)
**Date issued:** 2026-04-19
**Priority:** High
**Mode:** Discovery → Recommendation
**Confidence threshold:** 80% minimum

---

## Background

Velorin frequently needs to convert non-text media into machine-readable formats. We just hit a concrete failure: a Trey research doc was ported from Google Docs with 56 equations rendered as opaque inline PNGs, breaking every downstream agent that needs to reason over the math. We searched for tools and found:
- **Mathpix** — gold standard for equation OCR, but $20 setup fee + $29 testing fee, requires organization signup
- **pix2tex** — open-source LaTeX-OCR, but transitively requires building opencv-python from source on Python 3.9 / macOS x86_64 (multi-hour compile, infeasible)
- **Docling** (IBM, Apache 2.0) — already evaluated by Jiang2 in Session 024, but for full PDF-to-markdown, not equation-PNG-to-LaTeX

We fell back to spawning Haiku 4.5 sub-agents using Claude's native vision to OCR the equations. It worked. But this is a single-purpose patch, not a systematic answer to the broader question: **what does the current open-source and commercial ecosystem look like for ripping structured content out of unstructured media?**

---

## Research Questions

### Question 1 — Equation / Math OCR (PNG, JPEG, screenshot → LaTeX)
- What are the top open-source tools as of April 2026 for converting equation images to LaTeX text?
- Which have prebuilt wheels/binaries that install cleanly on macOS (no Python 3.9 + source-compile rabbit holes)?
- Which support inline equations vs display-block vs multi-line (cases, arrays, alignments)?
- Accuracy benchmarks vs Mathpix on real-world Google Docs Equation Editor exports?
- License compatibility for embedding in Velorin's stack (MIT, Apache 2.0 acceptable; GPL/AGPL flag)?
- For paid options: is there anything cheaper or more flexible than Mathpix's $49 entry barrier?

### Question 2 — PDF → Structured Markdown
- Best-in-class as of April 2026: Docling (IBM), Marker, Nougat (Meta), MarkItDown (Microsoft), Unstructured.io, others?
- Which preserve: tables, figures with captions, equations as LaTeX (not images), reading order, footnotes?
- Speed benchmarks on real research PDFs (Velorin processes academic papers regularly)?
- Local vs API: which run fully offline?
- Which output GitHub-renderable markdown out of the box (KaTeX-compatible math)?

### Question 3 — Image → Structured Data
- Diagrams, charts, flowcharts → JSON / YAML / structured text
- Handwritten notes → structured text
- Screenshots of tables → CSV / markdown table
- What are the current vision-LLM-backed and pure-CV options?

### Question 4 — Video → Transcript + Structured Output
- Video-to-text with speaker diarization
- Video-to-summary with timestamp anchors
- Slide-deck videos → reconstructed slide content + speaker notes
- Whisper-based vs proprietary; on-device vs API
- Cost models for typical Velorin volume (occasional multi-hour recordings)

### Question 5 — Audio → Structured Text
- Voice memos / meeting recordings → speaker-attributed transcript
- Real-time transcription with low latency for live use
- Local options that don't ship audio off-device

---

## What "Best" Means for Velorin

Trey is to weigh recommendations on these dimensions explicitly:

1. **Install reliability on macOS Sequoia + Mac Studio** — if it requires building C++ from source, that is a strike. Prebuilt wheels / binaries strongly preferred.
2. **License** — MIT/Apache 2.0/BSD ideal. GPL is workable but flag it. Closed-source proprietary flagged separately.
3. **Cost trajectory at scale** — free local > cheap API > expensive API. Setup fees explicitly called out.
4. **Active maintenance** — last commit, release cadence, GitHub stars, abandoned-or-not. Anything <12 months old preferred for fast-moving fields.
5. **GitHub presence** — for tools we may want to fork, extend, or wrap. Note any that look adoptable as a Velorin-internal subbot or MCP server.
6. **Compatibility with vision-LLM hybrid** — many of these tasks can be done with Claude/GPT-4o/Gemini vision directly; flag where pure tools beat LLMs and where LLMs beat tools.

---

## Deliverable Structure

Per Trey OutputStandards §2 (research document standards):

1. Executive summary — top 3 recommendations across all 5 questions, what to adopt now vs evaluate later
2. Per-question landscape matrix (tool name | license | install path | cost | accuracy | maintained | recommendation)
3. Build vs adopt analysis — which tools are good Velorin fork candidates vs use-as-is
4. Integration sketch — for the top recommendations, where they fit in the Velorin pipeline (port tool, brain ingestion, daily workflow)
5. Cost model — projected monthly cost at current Velorin volume + 10x scale
6. Confidence-weighted conclusions per recommendation
7. Sources

All research math must be plain LaTeX text per `Trey.OutputStandards.md` §2.3 (image-math is non-deliverable).

---

## Velorin Connection

Direct. The brain ingestion pipeline, the GDrive port tool, the research-request workflow, and any future PDF/video processing all depend on having reliable, cheap, well-maintained extraction tools. Picking the wrong tool means either rebuilding it ourselves or living with broken downstream agents (we just did the latter for one session — it cost us a half-day and required spawning Haiku sub-agents as a stopgap).

---

[VELORIN.EOF]
