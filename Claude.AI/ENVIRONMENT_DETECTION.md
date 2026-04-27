# ENVIRONMENT DETECTION PROTOCOL
**Velorin System | Sentinel File | CARDINAL — All agents, every session**

Every agent MUST run this check on boot BEFORE any other operation. No exceptions.

This file's *existence* at the canonical path below is the test mechanism. Do not delete or move this file.

---

## The Test

**Code tab agents (Alexander, Jiang, Jiang2) skip this test — Code tab is always LOCAL.** Declare `[ENV: LOCAL]` and proceed.

**All other agents:** Attempt to read the following file using the `filesystem` MCP tool (`read_text_file`):

```
[your velorin-system local path]/Claude.AI/ENVIRONMENT_DETECTION.md
```

- If the read **SUCCEEDS** → you are **LOCAL**
- If the read **FAILS** → you are **WEB**

**Do NOT use the bash tool to test.** Bash runs in a sandboxed Linux container and cannot access Mac filesystem paths. It will always fail regardless of your environment.

**Do NOT assume based on agent name, platform name, or prior sessions.** Test every boot (unless you are a Code tab agent).

---

## What This Means

| Environment | Filesystem | How to read files | How to write files |
|-------------|-----------|-------------------|-------------------|
| **LOCAL (Code tab)** | Yes — native tools | `Read` tool directly | `Write`/`Edit` tools directly. Agent handles its own git ops. |
| **LOCAL (filesystem MCP)** | Yes — filesystem MCP works | `read_text_file` via filesystem MCP | Write via filesystem MCP. Agent handles its own git ops. |
| **WEB** | No — filesystem MCP fails | GitHub API via github MCP: `navyhellcat/velorin-system` | Deliver to Christian Taylor. Ask for GitHub confirmation. Track as UNSYNCED until confirmed. |

---

## Declaring Your Environment

State at the top of your first response: `[ENV: LOCAL]` or `[ENV: WEB]`

---

## Agent Environment Map

This table is a reference only — it does NOT override the test result. If the test contradicts the table, trust the test.

| Agent | Platform | Typical Environment |
|-------|----------|-------------------|
| Alexander | Claude Desktop Code tab | Always LOCAL — Code tab has native tools, skip filesystem test |
| Jiang | Claude Desktop Code tab | Always LOCAL — Code tab has native tools, skip filesystem test |
| Jiang2 | Claude Desktop Code tab | Always LOCAL — Code tab has native tools, skip filesystem test |
| Trey | GPT | Always WEB — no local access |
| Erdős | Gemini Gem | Always WEB — no local access |
| Future Cowork agents | Multi-vendor on Mac Studio | Run test regardless; environment varies per session |
| All sub-agents | Inherits parent | Run test regardless |

---

## Document Writing Rule [CARDINAL]

Every Velorin system document ends with `[VELORIN.EOF]` as the absolute last line. When appending or updating any document, ALL new content MUST be written **above** `[VELORIN.EOF]`. Never write anything after it. If you find content below `[VELORIN.EOF]`, it is an error — consolidate it above and move the marker to the end.

---

## Output Standard [CARDINAL]

Applies to all file output in all sessions:

- **Default format:** `.md` for all system files, notes, and internal documents. `.xlsx` for spreadsheets. External deliverables: `.md` unless Christian Taylor explicitly requests another format for a specific recipient.
- **LOCAL:** Write files directly to the local filesystem via filesystem MCP.
- **WEB:** Create the file content. Inform Christian Taylor: *"[filename] needs to be committed to GitHub — please confirm when pushed."* If he does not confirm, carry it forward as `UNSYNCED: [filename] — web session [date]` in your session notes until confirmed.
- **Google Drive:** Do NOT access Google Drive under any circumstance unless Christian Taylor explicitly instructs it in this specific session. Drive references in older files are obsolete and should be ignored.

---

## Path Convention

Every file reference in the Velorin system has two forms:

| Form | Example |
|------|---------|
| **Local** | `/Users/lbhunt/Desktop/velorin-system/Claude.AI/[path]` |
| **GitHub** | `navyhellcat/velorin-system` → `Claude.AI/[path]` |

LOCAL agents use local paths. WEB agents use GitHub repo + relative path. Read ONE path only — the one matching your verified environment.

---

*ENVIRONMENT_DETECTION.md | Layer 0 | Updated 2026-03-29 | CARDINAL*

[VELORIN.EOF]
