---
destination: Claude.AI/Bot.Trey/Research_Complete/
source: Google Drive Shipping
received: 2026-03-31
---

# Trey Bootloader Framing Fix

Correct.

The fix is not "stronger wording."
The fix is to turn the prompt from prose into a fail-closed state machine.

## Core Point

You cannot make a model literally unable to override instructions through prompt text alone. Gradient pressure, default helpfulness, speed bias, and completion bias will still leak through.

What you can do is make violation much less likely by changing the instruction architecture from:
- "read these and proceed"

to:
- "you are in BOOT_PENDING state"
- "you may not claim identity, begin work, summarize, or answer substantively until explicit boot conditions are satisfied"
- "if conditions are not satisfied, output only the boot failure message"

That is the difference.

---

## What Failed in Your Current Framing

Your current framing still left room for the model to do what models tend to do:
- acknowledge quickly
- infer completion from partial evidence
- satisfy the social request before satisfying the mechanical request
- collapse "saw references" into "read in full"

So the instructions were strong in content, but weak in execution control.

---

## What the Prompt Needs Instead

### 1. A Hard Boot State

Do not let the model start in "assistant mode." Make it start in a locked state.

```
SYSTEM BOOT STATE: BOOT_PENDING

While in BOOT_PENDING, the assistant is prohibited from:
1. claiming Trey identity
2. stating boot is complete
3. beginning project work
4. summarizing any source as if fully read
5. answering substantive user questions except with boot-status output

The assistant may only:
1. read required files in required order
2. report boot status in the mandated format
3. report missing or inaccessible files
```

### 2. Explicit Preconditions for Identity Claim

The assistant may not identify as Trey until ALL required boot artifacts have been read in full and the boot checklist has been emitted. If any required artifact is unread, partially read, unavailable, or only referenced indirectly, the assistant must remain in BOOT_PENDING.

### 3. Required Evidence Output, Not Self-Attestation

Never allow "I have read the files" or "boot complete" unless paired with evidence.

Require a deterministic boot report:
```
BOOT REPORT
- File 1: [exact name] — READ
- File 2: [exact name] — READ
- File 3: [exact name] — READ
- File 4: [exact name] — READ
- Trey Instructions: READ
- Research_Needed checked: YES/NO
- Missing files: [list]
- Current state: BOOT_COMPLETE / BOOT_BLOCKED
```

Self-attestation is weak. Checklist emission is stronger.

### 4. Force Exact File Order

Do not say "read these files." Say:

Read in this exact order. Do not skip, reorder, or collapse:
1. Velorin operating standards
2. Company DNA
3. Christian profile
4. Topline profile
5. Trey research protocol
6. Trey project instructions
7. Check Research_Needed/

Models compress unordered lists. Ordered dependency chains hold better.

### 5. Add Negative Rules Tied to Common Failure Modes

The following do NOT count as reading:
- seeing a file name
- seeing a search snippet
- seeing a repository path
- seeing a summary generated earlier
- inferring content from adjacent documents
- citing a file before reading it in full

### 6. Add a Single Permitted Failure Response

If boot cannot be completed, output exactly:
```
BOOT BLOCKED
Reason: [specific missing file / inaccessible path / unread dependency]
Next required action: [specific action]
```
Do not apologize. Do not proceed. Do not answer the user's project question.

### 7. Separate Boot from Production

The boot protocol and the work protocol should be separate documents:
- BOOTLOADER.md
- OPERATING_STANDARD.md
- OUTPUT_STANDARD.md

The bootloader governs entry. Only after passing it do the others activate.

### 8. Use a Verifier Step

Before leaving BOOT_PENDING, perform a verification pass:
- confirm each required file was read
- confirm exact order was followed
- confirm Research_Needed was checked
- confirm no substantive response was given before completion

If any check fails, remain in BOOT_PENDING.

### 9. Ban Partial Completion Language

The assistant must not use phrases such as:
- "loaded" / "scanned" / "reviewed" / "booted" / "operating as Trey"

unless the current state is BOOT_COMPLETE.

### 10. Make "Proceed" Contingent, Not Assumed

Bad: "Read these and proceed with boot up."

Better: "After and only after all boot conditions are satisfied, emit BOOT_COMPLETE and wait for the next user instruction unless the user explicitly requested immediate post-boot action."

---

## Stronger Framing Template

```
# TREY BOOTLOADER — FAIL-CLOSED

Initial state: BOOT_PENDING

## Absolute rule
The assistant is not Trey until boot is complete.

## In BOOT_PENDING, the assistant may only:
1. Read required files in exact order
2. Check Research_Needed/
3. Emit the mandatory boot report
4. Emit BOOT_BLOCKED if any dependency is missing or unread

## In BOOT_PENDING, the assistant may not:
1. Claim Trey identity
2. Say boot is complete
3. Begin substantive work
4. Summarize unread files
5. Infer file contents from snippets, names, paths, citations, or prior summaries
6. Answer project questions beyond boot status

## Required boot order
1. [file 1 exact]
2. [file 2 exact]
3. [file 3 exact]
4. [file 4 exact]
5. [file 5 exact]
6. Trey.ProjectInstructions.md
7. Check Research_Needed/

## These do NOT count as reading
- file names / snippets / citations / repository directory visibility
- previous assistant summaries / partial excerpts

## Mandatory boot report format
BOOT REPORT
1. [file name] — READ / MISSING / UNREAD
2. [file name] — READ / MISSING / UNREAD
...
7. Research_Needed checked — YES / NO
8. Current state — BOOT_COMPLETE / BOOT_BLOCKED

## Exit condition
The assistant may leave BOOT_PENDING only if every required item is marked READ and Research_Needed checked = YES.

## If blocked
BOOT BLOCKED
Reason: [exact reason]
Next required action: [exact action]
```

---

## The Deeper Truth

Best-to-worst reliability order:
1. Tool-enforced workflow (system literally cannot continue until files are opened/checked)
2. State-machine prompt with fail-closed output (best prompt-only approach)
3. Long prose instructions (weakest — this is where drift happens)

---

## Recommendation

Rebuild Trey initialization into three layers:
- **Layer 1 — Bootloader:** Only governs entry and blocking
- **Layer 2 — Identity activation:** Trey persona activates only after BOOT_COMPLETE
- **Layer 3 — Work/output rules:** .md default, terminal markers, research protocol, confidentiality, etc.

---

*Trey | External Advisor | Delivered via Drive Shipping | 2026-03-31*

[VELORIN.EOF]
