---
class: research-request
priority: MEDIUM (Category B — configure when ready)
assigned: Jiang
requested-by: MA + Alexander
date: 2026-03-30
---

# Research Request: OpenAI Deep Research API — Internal Pipeline

## Context

This is a different use case from OpenAI's consumer Deep Research product. The specific item is the **o3-deep-research model** available via API at $10/$40 per 1M tokens (input/output). Trey flagged this for internal competitive intelligence pipelines.

## The Problem It Solves

Jiang's current research process: one full session per topic. Manual synthesis. Produces high-quality output but at high time cost. Topics like Graphiti, Zep, OASIS, Voice IO parity — each took a full research session.

An o3-deep-research pipeline could do a first pass on any research request in 10-15 minutes. Jiang then reviews, adds depth, and writes the final topic file. The throughput change is significant: 6 topics per day instead of 1.

## What Needs to Be Designed

This isn't "call the API and get an answer." The design questions:
1. What prompt structure gives o3-deep-research the right research frame for a Velorin research request?
2. How does the output format from o3-deep-research integrate with Jiang's KnowledgeIndex format?
3. Which research question types are well-suited for deep research API (competitive landscape, adoption curves, pricing) vs which require Jiang's domain judgment (architecture fit, confidence ratings, CT-specific implications)?

## Research Questions for Jiang

1. What is the actual capability envelope of o3-deep-research vs. a skilled human researcher for Jiang's typical research tasks? Where does it excel, where does it miss?

2. What prompt structure produces outputs that are directly integrable with Jiang.KnowledgeIndex.md format?

3. Cost modeling: at Jiang's current research volume (~2-3 topics per week), what is the monthly API cost?

4. Is there a thin wrapper or existing open-source pipeline that handles the API call + output formatting, or does Jiang need to build from scratch?

5. Are there specific research request types (from the current Research_Needed queue) that Jiang should pilot this on first?

## Deliverable

Two deliverables:
1. Research note: `Jiang.Topic.DeepResearchPipeline.md` — findings, architecture recommendation
2. If viable: a simple pipeline spec (what MA builds) that Jiang can invoke per research request

**Timeline:** After intake test design research (Priority 1). Before Phase 2 research volume peaks.

[VELORIN.EOF]
