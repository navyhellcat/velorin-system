Jiang Research Request — Close Protocol Optimization
Prepared by: Jiang | March 31, 2026 | Priority: Medium
Status: Placeholder — design task, not web research


PROBLEM

Session 015 close protocol cost 12,000 tokens. That is unsustainable at session frequency. Root causes identified:

1. KnowledgeIndex entries written as paragraphs — one entry per topic is ~6-8 lines of prose. Should be 2-3 lines max.
2. ResearchLog entries written as paragraphs — same problem. Full conclusions restated verbosely.
3. Handoff document is narrative (~1,500 words). Reads well but costs heavily.
4. Jiang reads KnowledgeIndex and ResearchLog in full to find the [VELORIN.EOF] insertion point — paying to read the entire prior history every session close.


PROPOSED FIXES

KnowledgeIndex — Tighter Entry Format
Current: 6-8 lines per topic with prose summary, full connection descriptions.
Target: 3 lines per topic — name, one-sentence summary, confidence/status, connected-to list. Connection map entries: one line, no explanation.
Estimated savings: 60-70% on index write tokens.

ResearchLog — Tighter Entry Format
Current: Full paragraph per section (topics, conclusions, open questions, confirmed, disproven, updates).
Target: Bullet list only. Conclusions = one line each with %. Open questions = one line each. No prose framing.
Estimated savings: 50-60% on log write tokens.

Handoff Document — Checklist Format
Current: Narrative sections (~1,500 words).
Target: Structured checklist. What completed (file name + one-line summary). What's open (item + owner). Key decisions (one line each). No Jiang's Corner — move that to a separate lightweight file if CT wants it preserved.
Estimated savings: 60% on handoff write tokens.

[VELORIN.EOF] Insertion
Current: Jiang reads entire KnowledgeIndex and ResearchLog to find insertion point.
Target: Grep for [VELORIN.EOF] — one tool call, no full file read needed.
Estimated savings: 200-400 lines of read tokens per session close.


TASK

Design the new format templates for:
1. KnowledgeIndex entry (compact)
2. ResearchLog entry (compact)
3. Handoff document (checklist)

Write them as fill-in templates with example entries. File the templates in Task_Instructions/ for Jiang to use every session going forward.

This is a design task — no web research required. Can be executed by Jiang or MA directly.

[VELORIN.EOF]
