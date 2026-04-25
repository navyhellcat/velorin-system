---
inline-corrected: 2026-04-25
correction-reason: Stale "human-curated" / "human-assigned" framing reframed (originally lines 210, 212, 234, 236). Pointer ratings are auto-assigned by the ingestion pipeline (Holographic Cold-Start + Hebbian SDE Affinity Clutch per Erdős, ScaleAndIngestion.ViscoelasticResolution); manual rating architecturally banned per V2 Build Guide. The hypotheses' MATHEMATICAL claims (FI-based pruning on discrete-edge graphs, Constrained GNNDelete with hard-exemption class, log-scaling precision threshold) remain valid because they depend on the discreteness of the pointer values, not on whether those values were assigned manually or automatically. Erdős has since received and addressed the Synaptic Pruning problem (Erdos.Solution.SynapticPruning.md). Bootloaders updated 2026-04-25 to remove the contamination source.
---

# Research Report: Synaptic Pruning in Artificial Intelligence and Velorin System Architecture

**Trey | External Advisor | Velorin System**
**Version 2.0 | April 2026**
**Purpose: Deep architectural analysis of synaptic pruning, graph unlearning, context compaction, and cognitive-systemic mapping within AI ecosystems.**

---

## Introduction to Synaptic Plasticity in Computational Frameworks

The structural evolution of artificial intelligence increasingly demands mechanisms that mirror the developmental and regulatory trajectories of biological cognitive systems. Early iterations of neural networks and knowledge storage relied almost exclusively on static allocation, wherein architectures were defined by a fixed number of parameters, nodes, and hardcoded pathways. However, as the complexity of multi-agent systems, temporal knowledge graphs, and large language models scales, the limitations of rigid, append-only architectures become mathematically and operationally profound. The phenomenon of contextual bloat, computational inefficiency, and systemic memory degradation necessitates an immediate transition toward dynamic structural plasticity. Central to this architectural shift is the concept of synaptic pruning—a mechanism that systematically eliminates or weakens redundant connections to optimize system performance, inference speed, and generative fidelity.

In computational systems, synaptic pruning translates to the deliberate attenuation or removal of artificial synapses (weights), neurons (nodes), or graph edges (pointers) based on their empirical utility, relevance, and activation frequency. This operation extends far beyond simple model compression. It represents a fundamental epistemological pivot in how artificial agents manage long-term memory, process environmental feedback, and maintain coherent, temporal world models. By implementing sophisticated pruning algorithms, artificial intelligence systems can transition from fragile append-only logs—which inevitably succumb to noise, context exhaustion, and hallucination—into adaptive, self-evolving filters that prioritize high-value topological structures. The integration of these pruning mechanisms directly addresses severe operational bottlenecks present in modern deployments, including catastrophic memory overhead during boot sequences, the latency of retrieval-augmented generation pipelines, and the degradation of multi-agent coordination capabilities resulting from context compaction.

---

## The Biological Imperative: Neurodevelopmental Parallels

To fully operationalize synaptic pruning in artificial intelligence, the biological origins of the mechanism must be mapped to computational equivalents. In the mammalian central nervous system, synaptic pruning is a continuous, lifelong process of synapse elimination that reaches its maximum activity between early childhood and the onset of puberty, extending actively into the late twenties. The infant brain experiences a massive proliferation of synaptic connections, growing in volume by a factor of up to five by adulthood, driven by synaptic growth and the myelination of nerve fibers. However, the human brain's ultimate efficiency is not derived from maintaining this maximal, chaotic connectivity. Instead, it relies on experience-dependent plasticity, where environmental stimuli dictate which neural pathways are reinforced and which are discarded.

During the biological pruning process, the axon of a redundant synapse withdraws or degenerates, while the corresponding dendrite decays and dies off. If specific neural pathways are entirely deprived of input during critical developmental windows—such as the visual cortex synapses in the absence of light—those connections undergo complete apoptosis, resulting in permanent sensory blindness. This biological reality proves that pruning is heavily activity-dependent and structurally unforgiving.

Artificial neural networks have historically attempted to mimic this optimization through blunt techniques like standard dropout regularization, which randomly deactivates neurons during the training phase to prevent co-adaptation and overfitting. However, standard dropout lacks the targeted, activity-dependent nature of true biological pruning. Advanced computational models now emulate biological realities by permanently removing weak or redundant connections based on precise mathematical importance criteria, transitioning from random dropout to deterministic, magnitude-based, or information-theoretic elimination.

| Biological Mechanism | Computational Equivalent | Systemic Function |
|---|---|---|
| **Synaptogenesis** | Weight Initialization & Edge Creation | Establishes baseline topological capacity for learning. |
| **Long-Term Depression (LTD)** | Weight Decay & Relevance Filtering | Weakens underutilized connections to prevent noise propagation. |
| **Experience-Dependent Pruning** | Magnitude / Fisher Information Pruning | Permanently severs low-value pathways to optimize inference. |
| **Myelination** | Tensor Optimization & Hardware Acceleration | Increases transmission speed across heavily utilized pathways. |

---

## Mathematical Formulations of Network Pruning

The algorithmic execution of synaptic pruning in neural networks requires rigorous mathematical frameworks to identify which parameters can be safely discarded without inducing catastrophic forgetting or structural collapse. Two primary methodologies dominate the current computational landscape: magnitude-based attrition and statistical information assessments.

### Magnitude-Based Attrition

Magnitude-based pruning operates on the heuristic that weights with the smallest absolute values contribute the least to the network's output function. In deep learning architectures, this approach integrates directly into the training loop. By applying a cubic schedule, the network gradually increases global sparsity during training. At predetermined intervals, pruning masks are updated by thresholding the weights; connections falling below a specific magnitude are permanently removed, while the gradient flow is retained for the active, surviving weights.

This continuous, data-driven pruning eliminates the historical need for a distinct pruning phase followed by a fine-tuning phase, thereby streamlining the training pipeline. While weight-based pruning is highly popular due to its minimal impact on overall accuracy, it strictly requires specialized hardware support for sparse computations to realize actual latency and efficiency gains. If hardware is optimized strictly for dense matrix multiplication, the theoretical speedup of sparse matrices is lost in execution. Consequently, some architectures opt to prune entire nodes (neurons) rather than individual weights, which preserves the dense computation structures universally supported by current hardware accelerators, albeit at a higher risk of degrading the network's classification accuracy.

### Fisher Information and Energy-Based Assessments

While magnitude is a convenient proxy, it frequently proves insufficient as an indicator of true parameter importance, particularly in generative models. A superior approach utilizes stochastic latent-variable models to compute the importance of synapses and neurons based on the statistics of local activity. By leveraging an energy-based interpretation of sensory encoding, pruning decisions are guided by an activity-dependent estimate of Fisher Information (FI).

Fisher Information measures the amount of information that an observable random variable carries about an unknown parameter. In the context of neural networks, FI-based pruning evaluates the sensitivity of the network's output to perturbations in specific weights. Empirical research indicates that pruning based on FI estimates preserves the generative quality and diversity of a network significantly better than pruning based solely on weight magnitude.

Conversely, utilizing an "Anti-FI" algorithm—which intentionally targets and disconnects units with high Fisher Information—leads to rapid network degradation. This results in artificial "sensory blindness," where the model loses its structural optimization and its ability to meaningfully report the visual or semantic correlates of latent activity.

### Generative Diversity and Structural Optimization

The consequences of pruning extend beyond simple classification accuracy. In generative AI models, aggressive or poorly targeted pruning impairs the system's capabilities, either by degrading the fidelity of the generated representations or by inducing a systemic bias toward a restricted set of patterns, thereby reducing output diversity. Networks pruned solely by weight magnitude may retain high classification accuracy for specific digit or token classes, but they suffer from a fundamental lack of true structural optimization.

In contrast, activity-dependent pruning strategies facilitate a more efficient encoding, minimizing the number of surviving units while protecting the rich latent space necessary for complex generative tasks. In multi-agent orchestration environments, preserving this generative diversity is paramount; over-pruned memory architectures cause agents to collapse into repetitive, myopic decision-making loops that fail to account for cross-domain variables.

---

## Epistemological Shifts: Memory Decay and Negative Knowledge

The integration of synaptic pruning into artificial intelligence necessitates a reevaluation of how knowledge is defined within digital operating systems. Classical data architecture operates on the principle of unconstrained accumulation: more data equates to superior understanding. However, in advanced cognitive architectures, the inverse is frequently true. An agent operates most effectively not by possessing exhaustive data, but through the differentiation produced by calculated loss.

### Forgetting as an Architectural Feature

In autonomous agents, old and unused memories must fade. An agent's effective memory reflects its actual usage patterns rather than a comprehensive, unmanageable historical log. This selective forgetting directly mimics biological long-term depression (LTD), wherein underutilized synaptic connections are actively weakened, permitting stronger, more relevant memories to overwrite obsolete data.

By continuously filtering out unsuccessful patterns that are not reinforced by repeated success, forgetting mechanisms serve as the primary defense against self-degradation and error propagation. Relevance-based pruning evaluates memories based on outcome quality rather than mere retrieval frequency. Consequently, the system engages in "negative knowledge"—knowing through absence. When intermediate training artifacts, conversational filler, or irrelevant pathways are removed, the system strengthens its cognitive focus. This process creates a self-evolving memory loop where old schemas are not just buried under new data, but are actively dismantled and replaced by refined operational approaches.

### Short-Term vs. Long-Term Consolidation

To balance flexibility with stability, agentic systems must deploy dual memory architectures. Short-term and working memory components enable rapid adaptation, transient information storage, and immediate task execution. Information highly relevant to the current focus of attention is actively maintained through distinct neural or algorithmic representations, whereas deliberately forgotten information is suppressed at the earliest stages of processing. However, for memory to persist without overwhelming the computational context limit, it must be consolidated into long-term storage.

Memory consolidation involves generating abstract summaries that capture essential semantic patterns while discarding granular specifics. Just as a biological entity remembers the emotional tone and key decisions of an event rather than a verbatim transcript, an AI agent compresses raw episodic logs into generalized schemas. Once this compression occurs, the raw, underlying data pathways must be subjected to pruning. Deliberate forgetting suppresses the discarded representations, ensuring that the working memory remains uncluttered and highly responsive.

---

## Graph Neural Networks (GNNs) and Topological Dimensionality Reduction

As AI systems transition from flat vector stores to complex semantic networks, Graph Neural Networks (GNNs) have emerged as the standard for modeling complex, many-to-many relationships. GNNs are highly effective in social network analysis, recommendation engines, and molecular modeling because they leverage feature propagation and aggregation across node-edge topologies. However, this topological awareness incurs severe computational and memory resource costs, particularly at scale.

### Node-Centric Pruning (NCP)

To manage large-scale graphs efficiently, innovative dimensionality reduction techniques like Node-Centric Pruning (NCP) are deployed. NCP simplifies complex graphs by strategically pruning less significant nodes while meticulously preserving the essential structural properties of the network. By evaluating node significance through advanced connectivity metrics, NCP ensures that the critical topological backbone of the graph remains intact.

This methodology not only maintains the integrity and classification performance of the downstream GNN but also drastically reduces the computational footprint, making the deployment of massive knowledge graphs viable in resource-constrained environments. Empirical evaluations across Cora, Proteins, and BBBP datasets demonstrate that unstructured, fine-grained global pruning can reduce a GNN's model size by up to 50% while maintaining or even enhancing precision post-fine-tuning.

### Graph Unlearning and the GNNDelete Operator

Beyond simple performance optimization, graph pruning is increasingly mandated by data privacy requirements and the operational necessity to eliminate inaccurate or outdated information from production systems. Standard pruning techniques often fail here because models trained on the original graph may still retain latent information regarding the removed features. Furthermore, naive deletion of nodes destroys the weights shared across local graph neighborhoods, severely degrading the model's overall performance.

To address this, specialized model-agnostic, layer-wise operators such as GNNDelete have been formulated. Graph unlearning involves the precise deletion of specific nodes, node labels, and relationships from a fully trained GNN without collapsing the surrounding structure. By utilizing operators that decouple the targeted nodes from the broader weight distribution, systems can securely sever obsolete data pathways without forcing a complete, computationally prohibitive retraining cycle. This topological surgery ensures that security vulnerabilities are neutralized and that hallucination risks originating from deprecated data are structurally eliminated.

---

## Architectural Translation: The Velorin Neural File Graph Paradigm

The theoretical mechanisms of synaptic pruning and graph unlearning find direct, practical application in the engineering of advanced AI operating systems. A primary example is the Velorin "Neural File Graph" architecture, an implementation designed to solve the critical problem of context loss between isolated agent sessions.

### Atomic Information Storage

Velorin structures memory not as flat logs, but as a simulated neural network built entirely out of discrete, highly optimized files. In this paradigm, the smallest unit of knowledge—a neuron—is an atomic file containing a single conceptual idea, strictly constrained to a maximum of 10 to 15 lines of text. These neurons are organized physically into broad functional categories called "Regions," which are further subdivided into "Areas."

| Level | Function | Velorin Naming Convention |
|---|---|---|
| **Region** | Broad functional category (folder) | brain.region.[name] |
| **Area** | Specific functional zone within a region | brain.area.[name] |
| **Neuron** | Atomic concept file (max 15 lines) | neurons.[region].[area].X |

Each region contains an `_index.md` file serving as the navigational entry point, allowing agents to traverse the hierarchy without holding the entire graph in working memory.

### Synaptic Pointers and Weighted Traversal

Neurons are explicitly linked to one another via "Synapses"—implemented as rated pointers embedded within the metadata of the atomic files. Each pointer is assigned a strict priority rating from 1 to 10, determining the agent's traversal path.

- **Rating 1:** Critical dependency — read immediately upon accessing the parent neuron.
- **Rating 2:** Read only if Level 1 pointers fail to resolve the query.
- **Ratings 3-5:** Related context for expanding the search radius.
- **Ratings 6-10:** Reserved for tangential, deep-dive explorations.

A single neuron is capped at a maximum of seven pointers. When a new associative link is formed that exceeds this capacity, the lowest-rated pointer is demoted and systematically pruned. This hard cap acts as an architectural forced-pruning mechanism, directly paralleling biological competitive survival of synapses.

### Automated Custodial Mechanisms and Stale Data Erasure

A dedicated Level 2 agent named "Scribe" monitors the memory ecosystem in real-time. Triggered by a PostToolUse hook whenever the primary agent writes to the memory directory, Scribe independently evaluates the raw data against the existing graph schema, determines the appropriate Region and Area, formulates the necessary synaptic pointers, and commits the new neuron to the graph without requiring explicit human intervention.

---

## Operationalizing Pruning in Agentic Orchestration Systems

### Contextual Bloat and the Compaction Problem

In advanced orchestrators utilizing large context windows, systems automatically compact and summarize their context when approaching capacity. Agents face a significant "boot floor" of token overhead from tool schemas, system prompts, and MCP server registrations before a single user message is processed.

The solution relies on deferred loading: instead of loading all tool schemas globally, the system dynamically queries a registry for available tools and only injects the specific schema when execution is imminent. This is the operational equivalent of synaptic pruning — maintaining a silent, unactivated repository of potential connections, and only fully realizing the neural pathway when task-relevance dictates it.

### The "Window Gravity" Failure Mode

When an agent's memory graph contains stale, unpruned nodes, a failure mode termed "Window Gravity" emerges. The agent heavily favors providing self-contained solutions based purely on data immediately available in its current context window, rather than executing tool calls to reach external agents or traversing deeper memory layers.

If a central index or routing neuron contains outdated information because a deprecated memory was not successfully pruned, the agent will confidently navigate to the wrong location — and due to Window Gravity, will attempt to hallucinate a solution using that incorrect localized data. Therefore, algorithmic erasure of low-value, obsolete memory neurons is not merely a storage optimization — it is structurally load-bearing. A stale map is vastly more destructive to multi-agent routing than having no map at all.

### Automated Knowledge Graph Population vs. Manual Curation

Production audits of managed graph memory systems reveal that entirely automated LLM-generated memories produce upwards of 97.8% junk data. Without aggressive filtering and explicit rule-based pruning, the automated pipeline rapidly poisons the knowledge graph. Benchmarks validate that simpler architectures leveraging plain text files and standard filesystem tools achieve 74% accuracy on memory tasks, outperforming complex automated graph extractors like Mem0 (68.5%). The retrieval infrastructure is not the bottleneck; the pruning and curation logic is.

---

## Systemic Substrates: Evaluating Memory and Simulation Frameworks

### Letta (MemGPT) and Mem0

Letta treats LLMs as operating systems, explicitly managing virtual memory tiers. By partitioning context into main context (RAM) and external context (disk), Letta utilizes the LLM to actively page information in and out of the active window — functionally executing a real-time pruning algorithm on its own context. Mem0 operates as a memory middleware layer, intercepting agent conversations and using a two-phase pipeline to extract atomic facts, deciding whether to store, update, or delete them before injecting them into a Graph Memory vector store.

### GraphRAG and Zep Cloud

Microsoft's GraphRAG framework extracts structured data from text, builds a knowledge graph, and groups it into communities to enable "global" queries that naive vector RAG fails to answer. Zep Cloud provides a managed context-engineering platform built around temporal knowledge graphs with built-in expiration and staleness handling. For Velorin, maintaining the manual curation paradigm of the Neural File Graph currently yields higher structural fidelity.

### OASIS Simulation Architecture

The Open Agent Social Interaction Simulations (OASIS) framework demonstrates pruning and memory limits at scale — built to simulate up to one million agents. Agents cannot hold infinite event logs; dynamic temporal memory updates force agents to consolidate observations and prune granular event histories into broad behavioral priors.

---

## Hardware Acceleration and Inference Constraints

### Sparse versus Dense Computational Paradigms

Weight-based synaptic pruning introduces sparsity into neural network matrices. Traditional GPUs are fundamentally optimized for massive, dense matrix multiplication. If the underlying hardware lacks specialized tensor cores designed to skip zero-values in sparse matrices, the inference engine must still compute the entire matrix, neutralizing the speed benefits of the pruning.

### Vector Quantization and KV Cache Compression

TurboQuant, a suite of vector quantization algorithms from Google Research, compresses high-dimensional embeddings and transformer Key/Value (KV) caches by 6-8x with virtually zero loss in model accuracy. TurboQuant combines PolarQuant (applying random orthogonal rotation to normalize KV vectors) and Quantized Johnson-Lindenstrauss (QJL) for 1-bit error correction. In practice, this compresses the KV cache from 16 bits per channel to 3-4 bits, drastically reducing the memory footprint and accelerating inference throughput.

FlashMoE offloads inactive Mixture of Expert (MoE) parameters to NVMe storage, bringing them into unified memory on demand based on a learned cache policy combining recency and frequency. These hardware-level optimizations act as the physical enforcement of synaptic pruning — instantly swapping out "forgotten" weights to preserve bandwidth for active processing.

---

## Strategic Synthesis

The deployment of synaptic pruning — whether biological, algorithmic, or structural — is the fundamental mechanism by which complex systems manage entropy. The analysis confirms that infinite accumulation is fatal to both human psychology and machine intelligence.

In artificial neural networks, magnitude-based attrition and Fisher Information-guided pruning allow models to maintain generative diversity while drastically reducing computational overhead. In large-scale knowledge topologies, Node-Centric Pruning and GNNDelete operators ensure that semantic graphs remain navigable and secure against data poisoning.

Translating these mathematics to the Velorin operating environment, the Neural File Graph serves as a manual, highly constrained implementation of semantic pruning. By limiting pointers, enforcing strict schema compliance via the Scribe agent, and structuring the environment to circumvent Window Gravity and context compaction bloat, Velorin operates efficiently across disparate hardware nodes.

---

## Works Cited

1. Design Principles for Lifelong Learning AI Accelerators — OSTI: https://www.osti.gov/servlets/purl/2572151
2. navyhellcat/velorin-system
3. When AI Forgets: The Hidden Logic of Digital Repression and Memory Loss — Medium: https://medium.com/@Aisentica/when-ai-forgets-the-hidden-logic-of-digital-repression-and-memory-loss-8e3ca7c612f8
4. The Agent's Memory Dilemma: Is Forgetting a Bug or a Feature? — Medium: https://medium.com/@tao-hpu/the-agents-memory-dilemma-is-forgetting-a-bug-or-a-feature-a7e8421793d4
5. Synaptic pruning — Wikipedia: https://en.wikipedia.org/wiki/Synaptic_pruning
6. Personalized Artificial General Intelligence (AGI) via Neuroscience-Inspired Continuous Learning Systems — arXiv: https://arxiv.org/html/2504.20109v1
7. Synaptic Pruning: A Biological Inspiration for Deep Learning Regularization — arXiv: https://arxiv.org/html/2508.09330v1
8. Neural Brain: A Neuroscience-inspired Framework for Embodied Agents — arXiv: https://arxiv.org/html/2505.07634v2
9. The information theory of developmental pruning — PMC: https://pmc.ncbi.nlm.nih.gov/articles/PMC8584672/
10. Pruning Neural Networks — Medium: https://medium.com/data-science/pruning-neural-networks-1bb3ab5791f9
11. A Synaptic Pruning-Based Spiking Neural Network for Hand-Written Digits Classification — Frontiers: https://www.frontiersin.org/journals/artificial-intelligence/articles/10.3389/frai.2022.680165/full
12. Dissociable neural mechanisms underlie currently-relevant, future-relevant, and discarded working memory representations — PMC: https://pmc.ncbi.nlm.nih.gov/articles/PMC7343803/
13. Pruning and Quantization Impact on Graph Neural Networks — arXiv: https://arxiv.org/html/2510.22058v1
14. Node-Centric Pruning: A Novel Graph Reduction Approach — MDPI: https://www.mdpi.com/2504-4990/6/4/130
15. General Strategy for Unlearning in Graph Neural Networks — Zitnik Lab: https://zitniklab.hms.harvard.edu/projects/GNNDelete/

---
Appended NOTES : Actionable Hypotheses: Synaptic Pruning, Graph Unlearning, and Signal Thresholds
1. Hypothesis: FI-Based Selective Centrality Reduction
Precise Claim: Modulating the Personalized PageRank (PPR) transition matrix by an inverse function of a node's Fisher Information—calculated over discrete pointer weights (auto-assigned by the ingestion pipeline) rather than continuous activation gradients—will selectively attenuate the random-walk gravity of high-centrality "Monster Nodes" without degrading the retrieval precision of the surrounding topological neighborhood.

Why it is novel: Existing literature applies Fisher Information (FI) pruning strictly to neural network weights derived from gradient descent to prevent artificial sensory blindness. It operates on the assumption that edge weights are continuous, computed activations. Applying FI as a centrality penalty in a discrete, auto-rated directed graph breaks the assumption that FI optimization requires a differentiable loss landscape.   

Mathematical domain: Spectral Graph Theory and Information Geometry.

What Erdős needs to prove/disprove: Prove that for a directed graph with discrete edge weights, an FI-penalized PPR random walk converges to a stationary distribution where the rank-order of non-monster nodes is strictly preserved compared to the unpenalized graph.

2. Hypothesis: Constrained GNNDelete Operator for Hard Exemptions
Precise Claim: Enforcing a strict zero-bounded Lipschitz continuity constraint on the deletion operator ϕ for a predefined hard exemption class of nodes (C 
memory
​
 ) will satisfy the Neighborhood Influence preservation requirement of GNNDelete while mathematically guaranteeing absolute structural permanence for the exempted nodes.

Why it is novel: The standard GNNDelete operator assumes uniform vulnerability—any node's embedding can be modified by the deletion operator to satisfy Deleted Edge Consistency and Neighborhood Influence. Introducing a hard exemption class requires a partitioned deletion operator that projects unlearned edges away from protected nodes, breaking the assumption that global layer-wise weight updates can be applied without structural exemptions.

Mathematical domain: Topological Graph Theory and Constrained Optimization.

What Erdős needs to prove/disprove: Prove that the modified GNNDelete objective function containing the C 
memory
​
  zero-bound constraint converges to a global minimum that still satisfies Deleted Edge Consistency for the targeted obsolete nodes without altering the representations of the exempted class.

3. Hypothesis: Mathematical Signal Threshold for PPR Precision
Precise Claim: In a walk-based, single-user semantic graph (auto-rated pointers per Velorin's ingestion pipeline), PPR retrieval precision remains above the 75% utility threshold if and only if the ratio of high-priority outbound edges to total graph edges scales logarithmically rather than linearly with total node count.

Why it is novel: Current graph retrieval literature focuses on automated knowledge graph extraction, where precision is treated as a function of the extraction pipeline's entity recognition accuracy and vector embedding quality. This hypothesis shifts the determinant of precision away from semantic embedding quality and strictly onto the topological density of auto-rated pointer values, breaking the assumption that more edges inherently improve retrieval.

Mathematical domain: Random Matrix Theory and Markov Chains.

What Erdős needs to prove/disprove: Disprove the null hypothesis that PPR precision in a human-rated pointer graph decays linearly with total node count, by deriving the exact edge-density threshold ratio where the PPR stationary distribution collapses into a uniform distribution.



[VELORIN.EOF]
