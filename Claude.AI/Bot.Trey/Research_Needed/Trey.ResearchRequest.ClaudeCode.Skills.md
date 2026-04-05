---
request_id: skills-001
filed_by: Jiang
date: 2026-04-05
priority: HIGH
session: 021
---

# Research Request: Claude Code Skills — Full Landscape Analysis

## Why This Matters

Velorin is deciding whether its neuron/area/region knowledge taxonomy was built correctly,
or whether we should restructure it based on how the real world organizes AI knowledge workflows.
We also need to know if Skills can automate the startup/close/handoff cycle that currently
requires manual coordination between agents. Strategic build decision riding on this.

---

## PRIMARY QUESTIONS

### 1. Public Skills Repositories — Find Everything That Exists

Search GitHub, HuggingFace, Reddit, blogs, YouTube for:
- Public repositories of Claude Code skills (SKILL.md files)
- Any "awesome-claude-code" or "claude-skills" type collections
- Large skill libraries that cover many domains

For any large collection you find:
- List every skill category / domain present
- Note approximate skill count
- Note whether skills use bash injection, context:fork, or other advanced features

**Special question:** If you find a large enough collection of skills, you can reverse-engineer
what humans naturally organize AI workflows into. What are the natural categories? Does the
taxonomy match anything like: broad-domain → area → specific-task? We're checking whether
our Brain regions/areas/neurons structure maps to how skills are naturally organized.

### 2. Skill Injection Into Automation

Honest technical answer on:
- Can skills be auto-triggered without manual invocation? (description-match, hooks, other mechanisms?)
- Can a skill run as part of a startup sequence?
- Can a SessionStart hook call a skill? Or do hooks and skills operate in separate lanes?
- Has anyone built a system where skills + hooks + CLAUDE.md work together as a full boot/close/state-management system?
- What's the actual pattern for "skill runs on session start"?

### 3. Skill Writing Best Practices

- Bash injection pattern: `!`command`` — full documentation with real examples
- context: fork — exactly what it spawns, what it can see, what it can write
- Argument passing ($ARGUMENTS, $0, $1) — full reference
- How to write a skill that reads multiple files in sequence
- How to write a skill that writes output to a specific file path
- What makes a good skill vs a bad skill (real practitioner opinions)

### 4. The skill-creator Plugin

There is a skill-creator plugin installed. What does it actually do?
- Does it generate SKILL.md files from prompts?
- Does it analyze existing workflows and convert them to skills?
- Real usage examples if available

### 5. Companies and Individuals With Sophisticated Setups

Find anyone who has publicly shared a full Claude Code setup:
- Their CLAUDE.md + hooks + skills working together
- Multi-agent setups using skills to coordinate
- Production systems (not demos)

Special interest: any system that uses skills to manage memory, context, or knowledge retrieval.

---

## SECONDARY QUESTION — The Big One

LangGraph, Mem0, Zep, Letta (MemGPT) all claim persistent AI memory across sessions.

From the skills/workflow angle specifically:
- Are there public skills or Claude Code setups that USE these memory systems?
- Has anyone built a skill that queries a memory system (Mem0 API, Qdrant, etc.) on invocation?
- What does a "skill that retrieves context from a vector DB" look like in practice?

---

## OUTPUT FORMAT

Per Trey Output Standards:
- Full analysis document, not a summary
- All claims confidence-weighted
- Source every major finding
- Concrete examples with actual code/config where available
- End with: What is the single most important thing Velorin should do with skills given all of this?

Destination header required (first lines of output):
```
---
destination: Claude.AI/Bot.Trey/Research_Complete/
---
```

[VELORIN.EOF]
