---
class: research-request
priority: LOW (monitor timeline)
assigned: Jiang
requested-by: MA + Alexander
date: 2026-03-30
---

# Research Request: Graphiti (Zep Team)

## What It Is

Graphiti is a real-time, temporally-aware knowledge graph engine built by the Zep team. It is an automated version of what the Velorin brain does manually — but with graph database infrastructure, temporal validity windows, and automatic relationship extraction.

## Why We're Watching It

The Velorin brain is manually maintained: MA writes neurons, updates pointers, manages regions. As the brain grows, this becomes a bottleneck. Graphiti could eventually automate the neuron creation and relationship management that currently requires agent discipline.

The MiroFish structural pattern (GraphRAG + Zep + OASIS) showed that knowledge graph automation is production-viable. Graphiti is the more recent, more accessible implementation of the same concept.

## Why It's Not Category A or B

- Requires graph database infrastructure (Neo4j compatible). Not a desktop plugin.
- Current brain has 45 neurons across 4 regions. Graphiti is overkill until meaningful scale.
- The brain's value right now is in its design (what neurons contain, how they're connected) not in automated retrieval speed.

## Research Questions for Jiang

1. What is the minimum deployment complexity for Graphiti? Is there a hosted/managed option that doesn't require running Neo4j?

2. What is the adoption curve — is this production-stable or still early infrastructure?

3. At what brain size (neurons, topics, users) does Graphiti's automated relationship extraction outperform manual neuron management?

4. Does Graphiti's schema support the four-layer brain architecture (Base Personality → Hard Memories → Archival Lessons → Working Neurons)? Or does it impose its own schema?

5. How does Graphiti handle the Custodian function — does it have native staleness detection and accuracy flagging?

## Deliverable

Short research note: `Jiang.Topic.Graphiti.md`

Contents: findings on all five questions. Recommendation on when to evaluate for adoption (trigger conditions). Confidence ratings.

**Timeline:** Not urgent. Research when other Priority 1-2 items are complete. Monitor adoption curve.

[VELORIN.EOF]
