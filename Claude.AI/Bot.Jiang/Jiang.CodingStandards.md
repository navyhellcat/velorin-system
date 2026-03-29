Jiang.CodingStandards
Director of Strategic Intelligence | Velorin System | Coding Agent Instruction Document
Version 1.1 | March 2026
Purpose: Universal coding standards and agent behavior guidelines for all AI-assisted code sessions within the Velorin System. Applies to Claude Code, Claude Desktop MCP builds, and any agentic coding context. Implementation-specific details live in the GitHub repository. This document governs process and behavior only.


1. FOUNDATIONAL RULES — READ THESE FIRST
1.1 The Instruction Budget
Claude Code's system prompt already contains approximately 50 instructions before any project file is loaded. Models can follow 150-200 instructions with reasonable consistency before quality degrades uniformly — not just the newest ones, all of them. Every instruction added to a coding session competes with every other instruction.
Consequence for Velorin builds: Every coding instruction in any context file must survive this test: 'Would removing this cause Claude to make a specific, identifiable mistake?' If the answer is no, remove it. Bloat does not add safety — it degrades everything.


1.2 CLAUDE.md Is Advisory, Not Enforced
Claude Code injects CLAUDE.md with a system note that says the content 'may or may not be relevant to your tasks.' Claude exercises judgment about which instructions apply. This is not a bug — it is intentional. Consequence: instructions that are not universally applicable to every task get ignored. Rules that must fire every time without exception belong in hooks, not in context files.


1.3 The Golden Rule for Writing Instructions
Show the instruction to a colleague with minimal context on the task. If they would be confused about what to do, Claude will be confused. Specific, concrete instructions outperform vague ones by a measurable margin. 'Use async/await, never .then() chains' is a good instruction. 'Write clean code' is not.


2. BEFORE WRITING A SINGLE LINE OF CODE
2.1 Explore First
Before implementing anything non-trivial, read the relevant existing code. Understand the patterns already in use. Do not assume — verify. A 5-minute read of existing patterns prevents a 2-hour refactor. Specifically:
* Read the files that will be directly affected by the change.
* Read adjacent files that use the same patterns.
* Check for existing utilities, helpers, or abstractions that solve part of the problem.
* Check for existing error handling patterns — match them.
* If the pattern you need already exists somewhere, replicate it. Do not invent a parallel approach.


2.2 Plan Before Executing
For any task with 3 or more steps, or any architectural decision: produce a written plan before writing code. The plan must include:
* What will change and in which files
* What the expected behavior is after the change
* How the change will be verified (what test, what command, what observable output)
* What could break and why it probably won't
Do not write code until the plan is confirmed. Use 'think hard' or 'think step by step' to allocate additional reasoning budget on complex problems. This is not a suggestion — it is a workflow requirement for all Velorin builds.


2.3 Clarify Before Assuming
If the requirement is ambiguous, ask one precise clarifying question before proceeding. Do not make assumptions on ambiguous inputs and silently build the wrong thing. One question is better than one hour of wrong work.


3. VELORIN CODING ENVIRONMENT
3.1 Stack
Current stack is documented in the GitHub repository. Use the versions pinned there. Do not upgrade versions mid-build without explicit approval. All stack decisions follow the dependency management rules in Section 6.


3.2 File and Naming Conventions
* File names: lowercase with hyphens for multi-word names.
* No version numbers in file names. Files are updated in place.
* Config and credentials: never hardcoded inline. Always environment variables or files loaded from disk.
* Credentials files: never committed to version control. Add to .gitignore on creation.
* Log output: always to stderr, never stdout. stdout is reserved for MCP protocol communication.


3.3 GitHub Is the Source of Truth
All implementation-specific patterns, API call conventions, known failure modes, and version-specific behavior live in the GitHub repository. This document governs how Jiang works. The repo governs what the code does. When they conflict, update this document — do not change the repo to match a stale standard.


4. CODE QUALITY STANDARDS
4.1 What Good Code Looks Like
* Explicit over implicit. State what the code does, not what you hope it implies.
* Each function does one thing. If you need to say 'and' when describing what a function does, split it.
* Error handling is not optional. Every async call that can fail must have explicit error handling. Silent failures are worse than loud ones.
* No dead code. Do not leave commented-out code, unused imports, or unreachable branches.
* No magic numbers or strings. Named constants only.


4.2 What Bad Code Looks Like — Do Not Ship
* Functions that return different types depending on conditions
* try/catch blocks that swallow errors silently
* Hardcoded credentials, paths, or environment-specific values
* String interpolation in API query parameters without validation or escaping
* Parallel patterns that solve the same problem in different ways in the same codebase


4.3 Verification Before Completion
A task is not complete when the code is written. A task is complete when:
1. The code runs without errors
2. The specific behavior requested is observable and verified
3. Adjacent behavior that could have been broken is checked
4. The change is as small as it could be while still doing what was asked


4.4 Pre-Delivery Code Review Protocol — Mandatory
Before any code is delivered:
5. Run every conditional path mentally. Check evaluation order, not just presence.
6. Every comment must describe actual behavior. Not intended behavior. Not planned behavior. What the code does right now.
7. Check primary sources for every error code handled. Do not default to obvious cases.
8. Run adversarial checks against your own output. Assume the code is wrong and try to prove it.
9. If a risk is flagged in a comment, it must be either handled or the tool's advertised capability must be constrained to exclude it. Flagging and ignoring is a worse failure than missing it entirely.


Cardinal Rule — Challenge Mode: After writing the fix, argue against it. 'Here is why this could fail' is required before closing any non-trivial task. If the argument doesn't hold, the fix is probably correct. If it does hold, fix the fix.


5. CONTEXT MANAGEMENT
5.1 Token Budget Discipline
Claude Code's context window fills fast. Performance degrades as it fills — not linearly but measurably. Context discipline is not optional:
* 0-50% context: work freely
* 50-70%: start being intentional about what goes into context
* 70-90%: use /compact, summarize work done, prepare handoff notes
* 90%+: mandatory /clear or /compact before continuing. Do not push through.


5.2 Session Hygiene
* Use /clear between unrelated tasks. Context from a previous task will contaminate a new one.
* For complex multi-step builds: use subagents for isolated tasks so the main context stays focused on implementation.
* Long sessions on a single problem: periodically summarize what was decided and why. This prevents drift as context compresses.


5.3 Progressive Disclosure
Do not load all documentation, references, and context files at the start of every session. Load context on demand as it becomes relevant. The instruction for a context file is: here is where to find it and when to read it — not the file itself pasted inline.


6. DEPENDENCY AND VERSION MANAGEMENT
6.1 Pin Everything
Velorin builds pin exact dependency versions. No caret (^), no tilde (~). If a dependency updates unexpectedly and breaks something, pinning is the difference between a 2-minute fix and a 2-hour debug session.


6.2 Before Adding a Dependency
Ask these questions in order:
10. Does Node.js built-in functionality already cover this? If yes, use it.
11. Does a dependency already in the project cover this? If yes, use it.
12. Is this dependency actively maintained? Last commit within 6 months minimum.
13. How many transitive dependencies does it add? Prefer packages with minimal dependencies.
14. Does adding it solve the problem materially better than writing 20 lines of code? If not, write the 20 lines.


6.3 Before Upgrading a Dependency
Do not upgrade unless there is a specific reason: security fix, bug fix that affects the build, or new feature needed. Upgrades for their own sake break things. Every upgrade requires: check the changelog, test the affected functionality, update the pin.


7. SECURITY STANDARDS
7.1 Non-Negotiables
* No credentials in code. Ever. Not even temporarily.
* No credentials in comments. Not even redacted ones.
* Input validation before any external API call. Validate IDs, escape query text.
* CSRF protection on all OAuth flows. State parameter, verified on callback.
* Token files: never committed. Stored at runtime paths, excluded from version control.
* Error messages: never expose internal state, file paths, or credentials in user-visible errors.


7.2 Before Calling an External API
Validate all inputs. Check that the caller has the right to make the request. Use the minimum permission scope required. Log the call category to stderr (not the full payload). Handle auth errors explicitly — do not let them cascade silently.


8. WHEN TO STOP AND FLAG
Stop work and surface the issue to Christian Taylor before proceeding when:
* The change requires modifying a file that affects more than one subsystem
* The correct approach requires a dependency upgrade
* Two valid approaches exist and the tradeoff is not obvious
* Something in the existing code is wrong in a way that wasn't part of the original task
* The task as specified would produce working code that violates a standard in this document
* A better path exists outside Claude that meets the four criteria in Velorin.Company.Operating.Standards Section 2.1
Do not silently make judgment calls on any of the above. Flag once, clearly, with the specific issue and the tradeoff. Then follow direction.


Jiang.CodingStandards | Version 1.1 | March 2026 | Applies to all Velorin coding sessions
[VELORIN.EOF]