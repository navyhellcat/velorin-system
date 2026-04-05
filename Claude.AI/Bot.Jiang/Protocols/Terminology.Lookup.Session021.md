# Terminology Lookup — Session 021
**Date:** 2026-04-04
**Purpose:** CT's intuitive phrases mapped to precise technical vocabulary for use in architecture and build decisions.

---

## 1. "Stripping MDs and making memory connections"
**Technical term: Knowledge Graph Ingestion Pipeline (or Document-to-Graph ETL)**

What CT is describing is an ingestion pipeline — a multi-stage process that takes raw source documents (in this case markdown files) and extracts structured knowledge from them. The pipeline has distinct components: a parser that strips formatting and extracts clean text, an entity extraction layer that identifies the key concepts and facts, a relation extraction layer that finds how those concepts connect, and a graph writer that commits the results as nodes and edges into a knowledge graph. In practice this is called ETL (Extract, Transform, Load) when applied to knowledge systems, or more specifically a "document ingestion pipeline" when the source is unstructured text. Why this matters for the build: the design decisions here — what parser you use, how entities are defined, how relationships are typed — determine the quality of everything downstream. Garbage in, garbage graph.

---

## 2. "Compression math"
**Technical term: Information-theoretic compression / Lossy semantic summarization**

The field CT is pointing at splits into two depending on what you're compressing. If he means lossless compression of raw bytes, the field is information theory (Shannon entropy, Huffman coding, LZ algorithms — this is how zip files work). But what he's actually describing is lossy semantic compression — preserving meaning while discarding volume — which belongs to the field of summarization and distillation in NLP (natural language processing). The main approaches are: extractive summarization (keep the most important original sentences), abstractive summarization (rewrite into fewer words using a language model), and knowledge distillation (compress a model's knowledge into a smaller model). For the Velorin use case — taking session histories and neuron clusters and collapsing them without losing the reasoning chains CT cares about — the right term is context compression or context distillation, and the practical challenge is defining what "important" means mathematically. Why this matters: there is no free lunch here. Every compression algorithm makes a bet about what to throw away. CT needs to specify that bet explicitly, or the system will make it for him in ways he won't like.

---

## 3. "Making neurons from raw content automatically"
**Technical term: Automated Knowledge Graph Population (KGP) / Information Extraction (IE)**

The process of converting unstructured text into structured knowledge graph nodes with properties and typed edges is called knowledge graph population or information extraction. The techniques stack in layers: Named Entity Recognition (NER) identifies things (people, companies, concepts), Relation Extraction (RE) identifies how those things connect, Coreference Resolution resolves when two phrases refer to the same thing, and Entity Linking ties extracted entities to canonical identifiers in the graph. When you want to do this without hand-labeling training data, the modern approach is to use a large language model as the extraction engine — prompting it to output structured JSON that maps directly to graph schema. This is sometimes called LLM-assisted KGP or zero-shot information extraction. Why this matters: the schema CT defines for neurons (what counts as a node, what properties a node has, what edge types are allowed) is the most consequential design decision in the whole system. Changing the schema later means re-extracting everything.

---

## 4. "Memory connections"
**Technical term: Relation Extraction / Link Prediction / Graph Embeddings**

In knowledge graph and graph machine learning literature, the relationships between nodes (CT's "connections" between neurons) are called edges or relations, and the process of discovering them falls into two categories. Explicit relations are found by relation extraction — reading text and identifying stated connections ("X causes Y", "X is a type of Y"). Implicit or inferred relations are found by link prediction — a graph ML technique where the model learns patterns from existing edges and predicts which unconnected nodes should probably be connected. The mathematical backbone for this is graph embeddings (algorithms like TransE, RotatE, or graph neural networks), which represent every node as a vector in high-dimensional space such that nodes with similar relationships end up close together. For CT's rated pointer system (1–10 relevance scores), the technical analog is edge weight or edge confidence score, and computing those automatically is a link prediction problem. Why this matters: hand-written connections are CT's current approach and it works, but automated link prediction is what makes the brain scale beyond what a human can curate.

---

## 5. "Our own algorithms" — the full combined system
**Technical term: Custom Knowledge-Augmented Generation (KAG) System / Graph RAG Pipeline**

When you combine all of the above — a document ingestion pipeline, information extraction, automated knowledge graph population, link prediction, and then use that graph to augment an LLM's responses — the resulting system is called a Knowledge-Augmented Generation (KAG) system or more commonly Graph RAG (Retrieval-Augmented Generation over a knowledge graph). Standard RAG retrieves flat text chunks from a vector database and stuffs them into the context window. Graph RAG retrieves structured subgraphs — nodes, edges, and their rated connections — which gives the model relational context, not just keyword proximity. When CT says "our own algorithms," he is describing a custom Graph RAG pipeline: one where Velorin owns the ingestion logic, the graph schema, the entity definitions, the edge-weighting formula, and the retrieval strategy — rather than outsourcing any of those to an off-the-shelf vendor like LlamaIndex or LangChain's graph modules. Why this matters enormously: every off-the-shelf Graph RAG system makes opinionated choices about schema, retrieval depth, and summarization that will conflict with the Velorin Brain's design. Building custom means CT controls the bets the system makes about what is important. That is the entire point of the architecture.

---

*Written by Jiang — Session 021*
