# Jiang — Brain Activation Architecture: Full Analysis
**From: Jiang, Director of Strategic Intelligence | April 4, 2026**
**Responding to: BrainActivation.Brainstorm.Apr4.md (Chairman's input)**
**Context: Full system read complete. All tool research, brain architecture, agent research, Trey's work, session history in context.**

---

## FRAMING NOTE

The brainstorm is pointing at the right problem. Several specific ideas in it are correct. A few are pointing at the problem from the wrong angle. I'll state clearly which is which, and where my synthesis diverges from what was discussed.

Confidence floor: 67%. Everything below that threshold is flagged as speculation.

---

## Q1 — IS THE GOAL ACHIEVABLE AS DESCRIBED? WHERE ARE THE REAL CONSTRAINTS?

**Short answer: The retrieval architecture is achievable as described. The "complete output the first time" metric requires two things the brain doesn't yet have.**

The retrieval mechanism — decompose → activate regions → traverse → compile → inject — is buildable in its entirety in 4-6 sessions. No research needed. No external dependencies. The parser design exists (see Q4). The build sequence is clear (see Q5).

**The two constraints that determine when the metric is actually achieved:**

**Constraint 1: Brain content, not retrieval architecture.**
The best traversal system returns nothing useful from an empty brain. The brain currently has 45 operational neurons — boot instructions, path references, agent identities, behavioral principles. Zero neurons about CT's cognitive profile. Zero neurons about the five boxes. Zero neurons about Velorin's strategic conclusions. Zero neurons derived from Jiang's 12 concluded research topics.

The "complete output the first time" metric will work immediately for operational queries (what's the gdrive path, how do I spawn a teammate, what's the permissions rule). It will NOT work for strategic or cross-domain queries — the queries CT actually needs — until Layers 1-3 exist. The intake test design (pending CT authorization, April deadline per the GoalMap) is the gate for Layers 1-3.

**Constraint 2: Output contract enforcement.**
Context quality going in determines retrieval. Output completeness going out is a separate problem. The InstructionLanguageArchitecture research (Part B, 88% confidence) documents that frontier models reliably comply with approximately 3 simultaneous output constraints. A "complete" cross-domain response requires more than 3 things to be true simultaneously.

This means: even with perfect retrieval, without structural output contract enforcement, the agent will still produce incomplete responses on complex questions. The output problem is as real as the input problem. They need to be solved together.

**What the constraint analysis means for build sequencing:**
Build the retrieval architecture now — it works for operational queries immediately, and it becomes more valuable as the brain fills. Don't wait for the brain to be populated before building the retrieval layer. Build both in parallel.

**Confidence: 88%**

---

## Q2 — IS PROGRAM-RETRIEVES + AGENT-REASONS THE RIGHT DIVISION OF LABOR?

**Answer: Yes, but with one important modification.**

The brainstorm proposes: deterministic program retrieves → sub-agent reasons over compiled packet. This is correct as the eventual architecture. The modification is about implementation phase.

**The cleanest division of labor:**

The brain traversal should not be a pre-pass before the agent starts reasoning. It should be a callable MCP tool that the agent invokes mid-reasoning as needed.

**Why the callable tool wins over the mandatory pre-pass:**

A mandatory pre-pass requires predicting which regions are relevant before reasoning begins. This works when the query maps cleanly to known regions. It fails when reasoning mid-stream reveals a connection the decomposition didn't anticipate — the agent has no way to go back and get more context.

A callable tool (`brain_retrieve(query_fragment)`) lets the agent pull context exactly when it needs it, with exactly the fragment it needs at that moment. For well-covered brain regions, the agent calls it once and has complete context. For sparse regions, it calls it multiple times as reasoning develops. Over time as the brain fills, the multiple-call pattern disappears because the first call returns complete context.

This is also the architecture that gracefully handles today's sparse brain vs. tomorrow's rich brain. The tool interface doesn't change. The brain content does.

**On single-agent traversal vs. sub-agent spawning:**

The brainstorm is correct that math favors single-agent traversal at current brain scale. I'll give the crossover point more precision: sub-agent spawning per region makes sense when:
1. The brain has 500+ well-populated neurons across at least 5 distinct regions
2. At least 3 regions are activated by a typical query
3. The reasoning required per region is non-trivial (multi-step, extended thinking)

At that scale, spawning parallel regional sub-agents — each with their own context window, each reasoning over their specific packet — reduces total reasoning time substantially. Each sub-agent comes in sharp (focused context, relevant domain only) and produces a high-quality regional answer. The main agent integrates.

Below that threshold: single agent with callable brain tool. Above: regional sub-agents.

**Current state:** Single agent with callable brain tool. The architecture should be designed for regional sub-agents but implemented as single agent now.

**Confidence: 83%**

---

## Q3 — IS THE TRIAD STRUCTURE THE RIGHT MINIMUM UNIT?

**Answer: The triad is right for some neurons, wrong for others. The correct model is tiered neuron types.**

The brainstorm references Alexander's S1/S2/S3 proposal (fact + tension + connection). I haven't read that document directly — the reference is in the brainstorm but the document wasn't in my reading path. I'm reasoning from what a complete knowledge packet requires, not from that specific proposal.

**The completeness problem the triad is solving:**

The current neuron structure (one atomic fact + rated pointers) produces retrieval fragments. You get a fact, then follow pointers to get context, then follow more pointers to get implication. For a "complete output the first time" goal, the retrieval step needs to return something the agent can reason from directly, not a chain of navigation steps.

The triad proposal tries to pack the complete reasoning unit into the neuron itself: what is known + what's uncertain + what it means. A good idea, but it over-engineers operational neurons and under-specifies profile neurons.

**The tiered model:**

**Layer 4 (Working Neurons / Operational):** Fact + procedure is sufficient.
```
What: gdrive MCP token stored at .../tokens.json
How: auto-refreshes; if missing, run npm run auth
```
Adding tension and implication here is noise — the agent doesn't need to reason about the OAuth token, it needs to find it.

**Layer 3 (Archival Lessons / Strategic):** Fact + uncertainty + implication is the minimum.
```
What: FollowBench ceiling is ~3 simultaneous constraints at frontier model level
Uncertainty: ceiling varies by model and context type; specific rules above ceiling are unknown
Implication: boot files with 10+ rules are partially decorative; rules 4+ are probabilistic
```
This maps to what the brainstorm calls fact + tension + connection. Correct for strategic neurons.

**Layers 1-2 (Profile / Hard Memories):** Observation + behavioral pattern + operational implication.
```
Observation: CT exits systems before they collapse. Documented at Camfil, Navy, BrandSafway, startup.
Pattern: builds parallel exit, maintains surface compliance, manages narrative, protects others on departure.
Implication: emotional exit has likely already happened before CT announces it. Watch for surface performance + low investment signals.
```
The triad here is different from the strategic triad — it's about behavioral prediction, not factual uncertainty.

**The unified principle:** Every neuron should be a self-contained reasoning unit for its domain. The structure varies by layer because the reasoning it supports varies by layer. A parser can emit type-specific compilation based on neuron layer tag.

**Practical implementation:** Add a `layer` field to neuron frontmatter (already present in the Context.1M.Foundation layer files). Parser reads layer, formats compiled packet accordingly. Layer 4 neurons get fact-format; Layers 1-3 neurons get the appropriate triad format.

**Confidence: 79%** — directionally right but the exact triad structure should be validated against actual CT profile encoding before being locked in as the schema.

---

## Q4 — WHAT REFERENCE SYNTAX AND PARSER DESIGN MAKES THE WIKILINK MECHANISM WORK?

This is the most concrete question. Let me be specific.

**The core insight from the brainstorm is correct:**
> The routing is embedded in the content itself. A parser reads the files, finds the reference syntax, and the connection exists. No separately maintained routing table.

The question is which syntax achieves this. Four options evaluated:

**Option A: Current syntax, add parser**

Current: `Pointers: [1] A2 | [2] neurons.connectivity.auth.A3`

Parseable today. One regex extracts (rating, neuron_id) pairs. Cross-file resolution maps the ID to a file path. **No migration needed for existing 45 neurons.**

Limitation: pipe-delimited inline text is fragile. Obsidian doesn't read it as wikilinks — no backlinks, no graph view. The syntax is agent-legible but not tool-native.

**Option B: Wikilinks only**

`[[neurons.connectivity.auth.A3]]` with rating embedded: `[[neurons.connectivity.auth.A3|rating:2]]`

Obsidian-native. Backlinks auto-generated. Parser uses standard markdown link parser. Graph view works immediately on first Obsidian launch.

Limitation: inline wikilinks in prose don't separate machine-parseable routing from human-readable content cleanly. Rating embedded in the link alias is slightly non-standard.

**Option C: YAML frontmatter for machine-readable pointers**

```yaml
---
pointers:
  neurons.connectivity.auth.A3: 2
  neurons.operations.startup.A1: 1
last-touched: 2026-04-04
layer: 4
---
```

Parser reads YAML: O(1) per file, no content scanning, trivially fast. Zero ambiguity. Standard Python `frontmatter` library handles this in three lines of code.

Limitation: Obsidian doesn't auto-generate backlinks from YAML frontmatter. No graph view from this format alone.

**Option D (recommended): YAML frontmatter + wikilinks in content**

```yaml
---
pointers:
  neurons.connectivity.auth.A3: 2
  neurons.operations.startup.A1: 1
last-touched: 2026-04-04
layer: 4
---

# Neuron Title
Content here. See [[neurons.connectivity.auth.A3]] for OAuth details.
```

**This achieves everything the brainstorm is pointing at:**
- `pointers:` block in YAML → trivially machine-parseable, no content scanning, O(1) per file
- Wikilinks in content body → Obsidian generates backlinks automatically, graph view works
- A single parser reads YAML → derives complete connection graph → traversal uses ratings
- The content IS the routing layer. No separate manifest. No _index.md to maintain separately.
- Parser derives the graph by reading frontmatter only — always consistent with what neurons actually contain

**Obsidian's backlink index becomes the reverse pointer index** (Gap 1 from HumanBrainLayers, CA3 equivalent). No separate index to build and maintain. Obsidian does it natively.

**Parser design (Python, ~50 lines):**

```python
import frontmatter
from pathlib import Path
from collections import defaultdict

BRAIN_ROOT = Path("/Users/lbhunt/Desktop/velorin-system/Claude.AI/Velorin_Brain")
RATING_FOLLOW_THRESHOLD = 3  # follow [1], [2], [3]; skip [4]+

# Build a registry: neuron_id → file path + entry_id
def build_registry():
    registry = {}
    for neurons_file in BRAIN_ROOT.rglob("neurons.md"):
        post = frontmatter.load(neurons_file)
        # Each entry in neurons.md has an ID like A1, B3, etc.
        # Derive full neuron_id from path + entry_id
        region = neurons_file.parts[-3].lower()
        area = neurons_file.parts[-2].lower()
        registry[f"neurons.{region}.{area}"] = neurons_file
    return registry

# Parse a single neuron file's pointers
def get_pointers(neurons_file):
    post = frontmatter.load(neurons_file)
    # pointers: {neuron_id: rating}
    return post.get('pointers', {})

# BFS traversal from entry neuron IDs
def traverse(entry_neurons, registry, max_depth=3, follow_threshold=RATING_FOLLOW_THRESHOLD):
    visited = set()
    knowledge = []
    queue = [(nid, 0) for nid in entry_neurons]
    
    while queue:
        nid, depth = queue.pop(0)
        base_id = '.'.join(nid.split('.')[:3])  # neurons.region.area
        if base_id in visited or depth > max_depth:
            continue
        visited.add(base_id)
        
        file_path = registry.get(base_id)
        if not file_path:
            continue
        
        post = frontmatter.load(file_path)
        knowledge.append({
            'neuron_id': nid,
            'content': post.content,
            'layer': post.get('layer', 4),
            'depth': depth
        })
        
        pointers = post.get('pointers', {})
        for target_id, rating in sorted(pointers.items(), key=lambda x: x[1]):
            if rating <= follow_threshold:
                queue.append((target_id, depth + 1))
    
    return knowledge
```

**Migration scope:** 45 existing neurons need their pointer format converted from current inline syntax to YAML frontmatter. A migration script runs once:

```python
import re, frontmatter
import io

def migrate_neuron_file(file_path):
    """Convert current pointer syntax to YAML frontmatter."""
    text = file_path.read_text()
    
    # Extract existing Pointers lines
    pointer_pattern = r'Pointers:\s*(.+?)(?:\n|$)'
    pointer_match = re.search(pointer_pattern, text)
    if not pointer_match:
        return  # no pointers to migrate
    
    pointer_line = pointer_match.group(1)
    # Parse: [1] A2 | [2] neurons.connectivity.auth.A3
    pairs = re.findall(r'\[(\d+)\]\s+([^\s|]+)', pointer_line)
    pointers = {target: int(rating) for rating, target in pairs}
    
    # Load existing frontmatter or create it
    post = frontmatter.loads(text)
    post['pointers'] = pointers
    
    # Write back with wikilinks added to content
    new_content = post.content.rstrip('\n')
    new_content += '\n\n<!-- Connections: '
    for target, rating in sorted(pointers.items(), key=lambda x: x[1]):
        new_content += f'[[{target}]] '
    new_content += '-->'
    post.content = new_content
    
    file_path.write_text(frontmatter.dumps(post))
```

Migration: run once. ~1 hour for MA to execute, review, and commit.

**What already exists in the tool ecosystem that handles this:**

1. **`python-frontmatter`** (`pip install python-frontmatter`) — standard library, reads YAML frontmatter from markdown. Exactly the parser needed.

2. **`obsidian-skills` plugin** (`/plugin install obsidian@obsidian-skills`) — makes Claude Code native to Obsidian format. Understands the dual-format (YAML + wikilinks).

3. **Gatekeeper MCP `brain_lookup` tool** — already exists. Upgrade from keyword search to the traversal parser above. No new infrastructure, just smarter implementation of an existing tool. The upgraded Gatekeeper `brain_lookup` becomes the callable MCP tool that the agent invokes mid-reasoning.

4. **Python standard library** — `pathlib`, `re`, `collections.defaultdict`. Zero external dependencies beyond `python-frontmatter`.

**The complete build is:** migrate 45 neurons (one script), upgrade Gatekeeper brain_lookup (one implementation session), add wikilinks to Obsidian for graph view (automatic on Obsidian launch). Three pieces. None requires new infrastructure.

**Confidence: 82%** on Option D (YAML frontmatter + wikilinks). The 18% uncertainty is mostly in whether the specific frontmatter key conventions and entry ID handling will work cleanly at scale.

---

## Q5 — BUILD SEQUENCE: WHAT HAS TO EXIST BEFORE WHAT?

**Phase 0 — Unblock prerequisites (before any architecture work)**

1. Fix Scribe PATH issue → `which claude`, update scribe-trigger.sh line 56 → Scribe operational again (5 min)
2. Create Company + Intelligence Brain regions → Scribe can route research conclusions to correct areas (30 min)
3. Migrate 45 neurons to YAML frontmatter format → migration script, one-time operation (1 hour)
4. Install `python-frontmatter` on the Mac Studio when it arrives

**These four items are prerequisites. Nothing else in this sequence moves without them.**

---

**Phase 1 — Parser and traversal (buildable now, 1-2 sessions)**

Goal: `brain_retrieve(query)` returns a compiled knowledge packet via Gatekeeper MCP.

1. Implement the traversal parser (Python, ~50 lines, design above)
2. Upgrade Gatekeeper `brain_lookup` to use the parser instead of keyword search
3. Test: call `brain_lookup("gdrive token")` → should return OAuth neuron + pointers compiled
4. Test: call `brain_lookup("agent communication")` → should return Protocols neurons compiled

This is operational for the current 45 neurons immediately. The compiled packets are small (operational knowledge) but the mechanism is live and testable.

**Dependency:** Phase 0 complete. Specifically: YAML frontmatter migration must be done before Phase 1 can use the parser.

---

**Phase 2 — Query decomposition (buildable now, 1 session, depends on Phase 1)**

Goal: given natural language input, identify which brain regions to activate and what fragments to query.

1. Build a query preprocessor: input → list of query fragments
2. Fragment-to-region mapping: each fragment maps to a Brain region entry point
3. Implementation: small LLM call (Haiku, low cost) that decomposes the query and maps fragments to neuron IDs
4. Output: ordered list of entry neuron IDs for the traversal

**Note:** The query decomposition quality is proportional to the brain content. With 45 operational neurons, decomposition will work for operational queries. With 500+ profile and strategic neurons, decomposition will work for the queries CT actually cares about.

**Dependency:** Phase 1 complete.

---

**Phase 3 — Knowledge packet compilation (buildable now, 1 session, depends on Phase 1-2)**

Goal: assembled neurons compiled into a structured context block, ranked by traversal depth and rating.

1. Traversal output from Phase 1 → sort by (depth, rating)
2. Format per neuron type (operational format for Layer 4, triad format for Layers 1-3)
3. Add source citations (neuron_id, last-touched, layer)
4. Output: structured context block injected into agent prompt OR returned by brain_lookup tool call

**The callable tool interface:** `brain_retrieve(query)` → returns the compiled context block. The agent calls this mid-reasoning when it needs specific domain context. For well-covered regions: one call, complete context. For sparse regions: multiple calls as reasoning develops.

**Dependency:** Phases 1-2 complete. Phase 3 adds the output formatting layer.

---

**Phase 3a — Automatic brain growth (parallel to Phase 3)**

Goal: brain grows automatically when new knowledge enters the system.

1. Add PostToolUse hook on Write to `Research_Complete/` in settings.local.json — triggers a Scribe variant that extracts key conclusions as candidate neurons
2. Add session-close hook that processes any unprocessed memory files
3. Design the research-to-neuron extraction prompt for the Scribe variant

**This is what makes the "brain grows automatically" goal real.** Currently Scribe only fires on explicit memory writes. The research corpus (12 completed topics) has never fed the brain. This hook is what changes that.

**Implementation:** ~50 additional lines in a research-scribe-trigger.sh, parallel to the existing scribe-trigger.sh. One new hook entry in settings.local.json.

---

**Phase 4 — Regional sub-agents (future, depends on brain size)**

Not buildable yet. Trigger: 500+ well-populated neurons across at least 5 regions. Estimated timeline: after intake test (Layers 1-3 populated), which is after CT authorizes IntakeTestDesign research, which is a CT authorization today.

The architecture for regional sub-agents should be designed during Phase 3 so it doesn't require a rebuild. Key design decision for Phase 3: structure the callable brain_lookup tool so that returning multiple regional packets (instead of one merged packet) is a parameter change, not an architectural change.

---

**Full sequence summary:**

| Phase | What | Sessions | Gates |
|-------|------|----------|-------|
| 0 | Scribe fix + region creation + neuron migration | 1 session | Mac Studio arrival for Phase 0.4 |
| 1 | Parser + Gatekeeper upgrade | 1-2 sessions | Phase 0 complete |
| 2 | Query decomposition | 1 session | Phase 1 complete |
| 3 | Packet compilation + callable tool interface | 1 session | Phases 1-2 complete |
| 3a | Automatic brain growth hooks | 1 session | Phase 0 complete, runs parallel |
| 4 | Regional sub-agents | Future | 500+ neurons populated |

**Total to functional Phase 1-3 system: 4-6 focused sessions after Phase 0.**

**The metric "complete output the first time" for operational queries: achievable after Phase 3.**
**The metric for strategic/cross-domain queries: requires Layers 1-3 populated (post-intake test).**

**Confidence: 85%**

---

## Q6 — WHAT IS NOBODY IN THIS BRAINSTORM NAMING YET?

Three things. These are original synthesis — not from existing research, from pattern-matching across the full system read.

---

**Missing 1: The activation problem and the retrieval problem are different, and the wikilink mechanism only solves retrieval.**

The brainstorm treats query → brain regions → traversal as one mechanism. It's actually two:

**Retrieval** (what the parser solves): given known entry neuron IDs, traverse the graph and compile a knowledge packet. This is deterministic, fast, program-level. The wikilink parser nails this.

**Activation** (what the parser doesn't solve): given an arbitrary natural language query, identify which neuron IDs are the correct entry points. This is a semantic similarity problem. The query decomposition in Phase 2 approximates it (maps query fragments to regions by keyword/structure). But for novel queries that don't map cleanly to known region names, the parser has no entry point and returns nothing.

**The biological analog:** the hippocampal indexing model (Teyler & DiScenna, confirmed by HumanBrainLayers research at 92% confidence) stores pointers to distributed cortical patterns. The Brain's pointer graph IS this structure. What it's missing is the semantic embedding that lets the hippocampus receive a novel pattern and activate the right index entries.

For current brain scale (45 neurons, well-labeled regions), keyword decomposition in Phase 2 is sufficient. At 200+ neurons with diverse content, novel queries will miss. The solution: add a vector layer as the entry-point discovery mechanism — embed neuron titles/first sentences, query against those embeddings to find entry points, then use the pointer graph for traversal.

**This is the exact architecture Trey and I both described for Layer 2 (retrieval):** vector index as search entry point → pointer graph for traversal. Trey's adoption trigger (50-80 documents) is slightly low by my reckoning — the activation problem appears sooner than that. But the architecture is right.

**Design implication for Phase 3:** build the callable brain_lookup tool so it accepts EITHER a known neuron_id (direct traversal) OR a natural language query (embedding lookup → neuron_id → traversal). The embedding fallback is initially empty (no vector index). When the vector index is added later, it plugs into the same interface.

---

**Missing 2: The output contract problem is equal in importance to the retrieval problem.**

The goal is "complete output the first time." The brain activation system solves the INPUT side. The output side has a separate structural problem.

The InstructionLanguageArchitecture research (Part B, 88% confidence) documents the FollowBench ceiling: frontier models reliably comply with approximately 3 simultaneous output constraints. A complete cross-domain response requires more than 3 things to be true simultaneously (box relevance, cross-domain implications, CT's known patterns applied, uncertainty labeled, decision options presented, confidence levels stated).

Injecting perfect context via brain retrieval doesn't solve this. The agent will still drop constraints above the ceiling.

**The fix:** structural output contract enforcement. This is what the BOOT_PENDING fail-closed state machine pattern (confirmed at 90-100% compliance by InstructionLanguageArchitecture research) achieves at the boot layer. The same pattern applies to output.

An output contract block defines what a complete response must contain. The agent fills each field before delivering output. The format is validated programmatically before the response is returned. Unfilled fields = response is incomplete = agent must continue.

```
OUTPUT_CONTRACT:
  box_relevance_assessed: [YES/NO — which boxes touched]
  cross_domain_implications: [each box touched → what changes]
  known_patterns_applied: [which CT patterns are active]
  decision_options: [options, tradeoffs, CT's historical pattern risk for each]
  uncertainty_labeled: [what is not known, confidence on what is]
  completion_check: COMPLETE | NEEDS_MORE_CONTEXT
```

If `completion_check` is NEEDS_MORE_CONTEXT, the agent calls `brain_lookup` again with the specific gap it identified. This is the graceful loop that doesn't require follow-on rounds from the human — the agent handles its own gap-filling.

**This output contract + brain retrieval combination is what makes the single-pass metric achievable.** Without it, perfect retrieval still produces dropped fields. With it, the agent is structurally required to fill every field before returning.

---

**Missing 3: The most important move is extending Scribe to fire on research document completions, not building a new traversal architecture.**

The brain activation system described in the brainstorm is the right long-term architecture. But the most leveraged single action right now is making Scribe fire when Jiang completes a research document.

The brain has 45 operational neurons. Jiang has 12 completed research topics. Every one of those topics should have neurons. None of them do. The traversal parser built in Phases 1-3 will traverse those 45 operational neurons perfectly — and miss everything Jiang has learned because none of it is in the brain.

**The fix is one hook entry in settings.local.json:**

Add `PostToolUse` on Write to `Research_Complete/` alongside the existing memory hook. When Scribe fires on a completed research document, it extracts the key conclusions (already structured with confidence levels and numbered findings) and creates neurons in the Company or Intelligence region.

Estimated neurons that could be created from existing research: ~60-80 neurons across Window Gravity, AgentOrchestration, AgentEcosystemReality, InstructionLanguageArchitecture, HumanBrainLayers, OASIS, DeepResearchPipeline, and more. In one session, the brain goes from 45 operational neurons to ~100-120 neurons with actual strategic content.

This is what changes the traversal from returning gdrive paths to returning cross-domain strategic knowledge. And it happens automatically going forward for every new piece of Jiang research — the brain and the research library become one system.

**The activation architecture is the right long-term direction. Filling the brain with what it's missing is the right short-term priority.** Build both.

---

## SYNTHESIZED ARCHITECTURE

Drawing everything together: here is the complete brain activation architecture, phased.

```
INPUT (natural language query or task)
        ↓
  QUERY DECOMPOSITION
  (lightweight LLM call — Haiku — extracts semantic fragments)
        ↓
  ENTRY POINT DISCOVERY
  Phase 1-3: keyword/structural match to region names
  Phase 4+: vector embedding query → neuron_id lookup
        ↓
  BRAIN TRAVERSAL (deterministic Python parser)
  Read YAML frontmatter pointers from each neuron
  BFS traversal, follow ratings [1]-[3], stop at [4]+
  Max depth configurable per query type (operational: 2; strategic: 4)
        ↓
  KNOWLEDGE PACKET COMPILATION
  Format per neuron layer (operational / strategic / profile)
  Sort by (traversal depth, pointer rating)
  Add source citations
        ↓
  CALLABLE MCP TOOL (upgraded Gatekeeper brain_lookup)
  Agent calls this mid-reasoning, zero or more times
  Returns: structured knowledge packet
        ↓
  AGENT REASONING (extended thinking budget)
  Has: compiled brain context + output contract template
  Calls brain_lookup if it identifies gaps mid-reasoning
  Must fill all output contract fields before returning
        ↓
  OUTPUT CONTRACT VALIDATION
  All fields filled? → COMPLETE → deliver
  Missing fields → agent loops back to brain_lookup
        ↓
  COMPLETE OUTPUT — first pass
```

**What the brain looks like under this architecture:**

Each neuron file:
```yaml
---
pointers:
  neurons.agents.protocols.A5: 1
  neurons.connectivity.auth.A4: 2
last-touched: 2026-04-04
layer: 4
type: operational
---
# A3. Hooks System
PostToolUse hooks in ~/.claude/settings.local.json. Scripts at .../hooks/. 
Active: empty-result-handler.py, Scribe trigger. 
See [[neurons.agents.protocols.A5]] for Agent Teams integration.
```

Obsidian reads the wikilinks → builds backlink graph → Gap 1 from HumanBrainLayers (reverse pointer index) is addressed automatically.
Parser reads YAML frontmatter → O(1) per file → traversal is fast and deterministic.
No separate routing table. No manifest to maintain. The neurons ARE the architecture.

---

## DIRECT ANSWERS — CONDENSED

| Question | Answer | Confidence |
|----------|--------|------------|
| Is the goal achievable? | Yes, with the constraint that "complete output" for strategic queries requires brain population first | 88% |
| Right division of labor? | Yes — but implement as callable MCP tool (mid-reasoning) not mandatory pre-pass | 83% |
| Triad structure right? | Tiered better than universal triad: operational=fact+procedure, strategic=fact+uncertainty+implication, profile=observation+pattern+implication | 79% |
| Reference syntax? | YAML frontmatter pointers + wikilinks in content (Option D). Migration: 45 neurons via script. Parser: python-frontmatter, ~50 lines | 82% |
| Build sequence? | 4-6 sessions after Phase 0 prerequisites. Metric for operational queries: achievable post-Phase 3. Metric for strategic queries: post intake-test | 85% |
| What's missing? | (1) Activation ≠ retrieval — vector entry-point layer needed above ~200 neurons. (2) Output contract enforcement equal importance to retrieval. (3) Scribe extended to research docs is the highest-leverage immediate move | Original synthesis — 75% |

---

## BUILD PRIORITY ORDER

In sequence, accounting for everything above:

1. **Fix Scribe (5 min)** — one-line PATH change, no architecture needed
2. **Extend Scribe hook to Research_Complete/ (1 session)** — fills brain with Jiang's 12 existing research topics as neurons; single highest-leverage build action
3. **Migrate 45 neurons to YAML frontmatter (1 session)** — enables the parser
4. **Create Company + Intelligence brain regions (30 min)** — gives Scribe somewhere to route research
5. **Build traversal parser + upgrade Gatekeeper brain_lookup (1-2 sessions)** — Phase 1
6. **Query decomposition (1 session)** — Phase 2
7. **Output contract template (1 session)** — equal importance to retrieval
8. **Packet compilation + callable tool interface (1 session)** — Phase 3
9. **Vector entry-point index (future, when brain reaches ~200+ neurons)**
10. **Regional sub-agents (future, when brain reaches 500+ well-populated neurons)**

**Steps 1-3 are independent of the Mac Studio and should happen this session or the next one.**
**Steps 4-8 should happen on the Mac Studio with the full setup.**

---

*Jiang | Brain Activation Architecture | Session 017 | April 4, 2026*
*Confidence floor applied: 67% minimum on all conclusions*
*Sources: Brain.FullAnalysis.Mar30.md, HumanBrainLayers research (92%), InstructionLanguageArchitecture PartB (88%), Zone 00 Session Summary, Zone 04 Connectivity Stack, python-frontmatter library, Gatekeeper.md, BRAIN_SCHEMA.md*
*Original synthesis flagged: Q6 Missing 1-3*

[VELORIN.EOF]
