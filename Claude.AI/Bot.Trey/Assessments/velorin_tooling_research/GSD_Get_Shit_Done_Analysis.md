# GSD_Get_Shit_Done_Analysis

**Date:** March 28, 2026  
**Purpose:** Analyze GSD (Get Shit Done), what it actually is, how it works, and whether it is relevant to Velorin.

## Executive Summary

GSD is not a product in the normal SaaS sense. It is a **meta-prompting / context-engineering / spec-driven development system** built to make coding agents behave more consistently over long sessions. The repo has moved from `glittercowboy/get-shit-done` lineage to the current `gsd-build/get-shit-done` location. Its core claim is simple: reduce **context rot** and increase end-to-end execution quality.

For Velorin, GSD matters less as a thing to adopt wholesale and more as a signal:
- the market is moving from "prompt better" to **engineer context and workflow**, and
- successful agent stacks now rely on **lightweight structure + selective loading + repeatable commands**, not giant static instruction blobs.

The main value to Velorin is conceptual. GSD reinforces that your agents should not load everything, say everything, or improvise workflow every time.

## What It Is

The repository describes GSD as:
- a **light-weight and powerful meta-prompting, context engineering and spec-driven development system**,
- designed for **Claude Code, OpenCode, Gemini CLI, Codex, Copilot, Cursor, Windsurf, and Antigravity**,
- explicitly aimed at solving **context rot**.

The installer exposes runtime selection and can be installed globally or locally. The project frames itself as minimal user workflow wrapped around heavier behind-the-scenes orchestration.

## Why It Exists

The repo author is arguing against:
- bloated process theater,
- too much manual prompt babysitting,
- poor long-session consistency.

Instead, the system emphasizes:
- state management,
- subagent orchestration,
- structured commands,
- progressive context loading,
- repeatable build flows.

## Strategic Relevance to Velorin

### What it proves
GSD is strong evidence that the winning pattern in 2026 is:
1. **small stable core instructions,**
2. **progressive disclosure of context,**
3. **explicit workflows,**
4. **tool-aware execution.**

That lines up with what your company agents have been missing.

### What your agents have likely been doing wrong
- stuffing too much doctrine into one static prompt,
- failing to separate stable rules from situational context,
- not using reusable workflow packages,
- not surfacing tool availability as part of task architecture,
- not explicitly managing context budget.

## Fit Assessment

### Good fit for Velorin
- As a design reference for agent workflow structure
- As proof that context engineering is now a first-class operating discipline
- As a benchmark for "how lean can an agent operating system feel while still being structured"

### Bad fit for Velorin
- Blindly importing its workflow without adaptation
- Treating a coding-agent workflow as a whole-company operating model
- Overfitting company process to a repo-specific command layer

## What Velorin should copy conceptually

### 1. Progressive disclosure
Do not dump all files and all rules into every session. Load what is relevant when relevant.

### 2. Explicit workflows
Each repeated company motion should have a named pattern:
- research pass,
- source validation pass,
- build recommendation pass,
- output packaging pass.

### 3. Stable command surfaces
Agents need a consistent way to express:
- what tools are available,
- what external systems are connected,
- what can be read,
- what can be acted on,
- what remains blocked.

### 4. Context hygiene
Old, irrelevant context should not linger because it degrades reasoning quality and execution discipline.

## Recommendation

Do **not** adopt GSD as company doctrine verbatim.

Do:
- study its context-engineering posture,
- borrow the selective-loading and workflow patterns,
- build a Velorin-native equivalent for research, orchestration, and execution work.

## Bottom Line

GSD is valuable because it confirms that agent quality now depends on **context architecture**, not just better prompts. Velorin should internalize that lesson immediately.

## Sources
- https://github.com/gsd-build/get-shit-done
- https://github.com/gsd-build/get-shit-done/releases
- https://github.com/glittercowboy/get-shit-done/issues/243