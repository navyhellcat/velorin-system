---
file: Velorin.Vocabulary.md
purpose: Running vocabulary reference — terms CT needs to own
format: Numbered A1, A2... B1, B2... Categories added later by bot
last_updated: 2026-04-05 Session 021
note: DO NOT reorganize numbering manually — a bot will restructure when categories are assigned
---

# Velorin Vocabulary

## Uncategorized (pending category assignment)

**A1 — Knowledge Graph Ingestion Pipeline** (also: Document-to-Graph ETL)
The system that takes raw content (markdown files, session transcripts, documents) and converts it into structured knowledge graph nodes and edges. Has four components: a parser that strips the raw content, an entity extractor that identifies the things (people, concepts, systems, decisions), a relation extractor that finds how those things connect, and a graph writer that commits them as neurons and pointers. This is the pipeline that turns "CT wrote a session note" into actual Brain neurons. Without this pipeline, every neuron must be written by hand.

**A2 — Semantic Compression / Context Distillation**
The process of summarizing meaning rather than reducing bytes. Unlike lossless compression (which keeps everything, just smaller), semantic compression decides what to throw away. Every algorithm that does this makes a bet about what is safe to discard — and that bet is a design decision, not a technical one. For Velorin, this means every compression step needs an explicit rule: "we keep decisions, we keep pointer ratings, we discard conversational filler." If you don't specify the bet, the algorithm makes it for you silently.

**A3 — Automated Knowledge Graph Population (KGP) / Information Extraction (IE)**
The technical name for automatically creating neurons from raw content. Uses several sub-techniques: Named Entity Recognition (NER) identifies things by name, Relation Extraction finds how they connect, Coreference Resolution figures out that "he," "CT," and "the Chairman" are the same person, Entity Linking connects extracted entities to existing neurons rather than creating duplicates. The most consequential decision in KGP is the neuron schema — because the schema defines what the extractor looks for. Schema first, pipeline second, always.

**A4 — Relation Extraction vs Link Prediction**
Two types of memory connections. Relation Extraction finds connections that are explicitly stated in the source text ("Jiang reports to MA" — stated directly). Link Prediction infers connections that aren't stated anywhere, based on patterns in the graph ("Jiang and Alexander both work on research tasks therefore they probably share some skills" — inferred). Velorin's pointer rating system (1–10) maps directly to what graph ML calls edge weight or edge confidence score. Stated connections start with higher confidence. Inferred connections start lower and get promoted as they're validated.

**A5 — Custom Graph RAG Pipeline / Knowledge-Augmented Generation (KAG) System**
The full combination of A1 through A4 built and owned by one team. RAG = Retrieval-Augmented Generation (the agent retrieves relevant neurons before generating a response). Graph RAG = the retrieval uses a knowledge graph rather than flat vector search, so it follows relationships rather than just finding similar embeddings. KAG = the knowledge graph actively augments what the model generates, not just what it retrieves. Building this custom means Velorin controls every bet the system makes about what is important — rather than inheriting someone else's assumptions. That control is the entire point.

---
[END — next entry: A6]
