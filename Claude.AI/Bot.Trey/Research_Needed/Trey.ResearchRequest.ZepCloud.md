---
class: research-request
priority: LOW
assigned: Jiang
requested-by: MA + Alexander
date: 2026-03-30
---

# Research Request: Zep Cloud

## What It Is

Zep Cloud is structured agent memory with temporal validity windows. It manages per-agent and group-level memory with expiration and staleness handling built in. The MiroFish architecture uses it as the memory substrate for multi-agent simulation — each simulation agent has its own Zep memory store, and the system manages which memories are current vs expired.

## Relevance to Velorin

Two potential applications:

**Application 1: Custodian replacement / augmentation**
The Velorin brain's Problem 0 (staleness feedback loop) currently has no solution. Zep's temporal validity windows — where memories have explicit expiration and staleness flags — could automate what a Custodian agent does manually.

**Application 2: Multi-user memory isolation**
When Velorin has 3-5 outside users, each user needs an isolated brain. Managing N user brains as manually-maintained GitHub neuron graphs may not scale. Zep's per-user memory stores with group-level context could provide the infrastructure for multi-user personal intelligence at scale.

## Why It's Not Immediate

- Current memory needs served by the brain (GitHub neurons) and flat files.
- Single user (CT). Multi-user infrastructure not yet needed.
- Zep Cloud is a managed service — cost model must be evaluated before committing to it as the memory substrate.
- Becomes relevant when simulation/scenario work starts (MiroFish-style decision rehearsal) or when multi-user deployment begins.

## Research Questions for Jiang

1. Zep Cloud pricing model — what does it cost at 1, 5, 25, 100 users? Is it per-user, per-query, or flat?

2. Does Zep Cloud's schema map onto the four-layer brain architecture? Or does it require a schema migration?

3. How does Zep Cloud handle the "reasoning pattern" layer — does it support storing behavioral profiles and cognitive patterns, or only factual memories?

4. What is the migration path from the current GitHub neuron graph to Zep Cloud? Is it compatible or a full replacement?

5. Any production examples of personal intelligence (not just task memory) being stored in Zep Cloud?

## Deliverable

Short research note: `Jiang.Topic.ZepCloud.md`

Timeline: After intake test design research. Not urgent until multi-user deployment is imminent.

[VELORIN.EOF]
