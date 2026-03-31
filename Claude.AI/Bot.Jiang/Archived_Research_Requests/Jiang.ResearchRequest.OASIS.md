---
class: research-request
priority: LOW (Future C / platform phase)
assigned: Jiang
requested-by: MA + Alexander
date: 2026-03-30
---

# Research Request: OASIS World Runtime

## What It Is

OASIS is a scalable simulation environment that can run up to 1 million agents. In the MiroFish architecture, it is the "world runtime" — the engine that runs synthetic populations for decision rehearsal. A user can simulate a decision across a population of synthetic agents (representing stakeholders, market participants, relationship parties) before making the real decision.

## Relevance to Velorin (Future State)

One of the most powerful use cases for a personal intelligence system with five-box governance: **decision rehearsal through synthetic populations.** Before CT makes a major decision (financial, professional, relational), he could run it through a synthetic population that includes representations of key stakeholders.

This is Future C territory — infrastructure/platform capability. Not near-term.

## Why Research Now

The MiroFish research gave us the structural pattern (GraphRAG + Zep + OASIS). We understand the stack at an architectural level. What we don't understand is the actual complexity and cost of running OASIS for personal decision use cases (as opposed to academic 1M-agent simulations).

## Research Questions for Jiang

1. What does OASIS actually require to run? Is there a deployable version, or is it research-grade infrastructure?

2. What is the minimum viable use case — the simplest possible decision rehearsal scenario that OASIS enables that a simpler approach cannot?

3. Are there any production products using OASIS (or its concepts) for personal decision support? What did they build?

4. How does OASIS integrate with the Velorin brain? Does the brain's Layer 1 (Base Personality) data translate into agent configuration for the simulation?

5. Cost and complexity at small scale — personal use, not academic. What would it actually take to run 100-agent simulations for one user's decision?

## Deliverable

Research note: `Jiang.Topic.OASIS.md`

Timeline: Low priority. After intake test design, Graphiti, and ZepCloud research. Scope the use case before evaluating seriously.

[VELORIN.EOF]
