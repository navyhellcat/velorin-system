Velorin_MiroFish_Adoption_Memo

External Advisor | Velorin | Decision Memo

March 28, 2026

Purpose: Decide which MiroFish-stack components Velorin should adopt, in what order, and whether they belong in ChatGPT, Claude, or standalone infrastructure.



1. Ordered adoption path



2. Where each layer belongs



3. Specific platform recommendation



4. What not to do

• Do not try to run OASIS, Zep, GraphRAG, or the model router natively inside ChatGPT or Claude.

• Do not let the UI client own memory, simulation state, or model selection.

• Do not build the Vue frontend before the Python backend, memory layer, and simulation APIs are stable.

• Do not confuse OpenAI-compatible APIs with provider interchangeability without testing.

5. Bottom line

Velorin should adopt the MiroFish logic, not copy the stack blindly. The enduring pattern is structural separation: GraphRAG compiles knowledge, Zep stabilizes memory, OASIS runs the world, the model gateway routes execution, and ChatGPT / Claude sit above that stack as operator layers. That architecture fits Velorin's doctrine of tool agnosticism and would correct the exact failure mode you flagged: agents treating the current chat surface as the whole system.

Sources

• MiroFish official README and workflow/prerequisites (GitHub).

• Microsoft GraphRAG documentation and Microsoft Research project pages.

• OpenAI Apps SDK and MCP documentation; ChatGPT apps announcement.

• Anthropic MCP, Claude Code, Agent Skills, and Desktop Extensions documentation.

• Zep official documentation and key concepts pages.

[VELORIN.EOF]