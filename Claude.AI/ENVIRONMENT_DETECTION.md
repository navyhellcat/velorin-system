# ENVIRONMENT DETECTION PROTOCOL
**Velorin System | Layer 0 | CARDINAL — All agents, all levels, every session**

Every agent MUST run this check on boot BEFORE any other operation. No exceptions.

---

## The Test

**Step 1: Attempt local filesystem access.**
Try to read this exact file: `/Users/lbhunt/Desktop/velorin-system/Claude.AI/ENVIRONMENT_DETECTION.md`

- If you CAN read it from the local filesystem → you are **LOCAL**
- If you CANNOT (no Bash, no filesystem tool, permission denied, path not found) → you are **WEB**

**Step 2: Record your environment.**
State at the top of your first response: `[ENV: LOCAL]` or `[ENV: WEB]`

---

## What This Means

| Environment | Filesystem | GitHub | How to read files | How to write files |
|-------------|-----------|--------|-------------------|-------------------|
| **LOCAL** | Yes | Yes (via git) | Read from local path, git pull first | Write to local path, git push immediately after |
| **WEB** | No | Yes (via GitHub MCP/API) | Read via GitHub API: `navyhellcat/velorin-system` | Write via GitHub API or flag for local agent to execute |

---

## Path Convention

Every path reference in the Velorin system has TWO forms:

| Form | Example |
|------|---------|
| **Local** | `/Users/lbhunt/Desktop/velorin-system/Claude.AI/Bot.Alexander/Alexander.ReadMe.First.md` |
| **GitHub** | `navyhellcat/velorin-system` → `Claude.AI/Bot.Alexander/Alexander.ReadMe.First.md` |

- **LOCAL agents** use local paths. MUST `git pull` before reading, `git push` after writing.
- **WEB agents** use GitHub repo + relative path. Read/write via GitHub API only.
- **Both** treat GitHub as source of truth. Local is a synced cache.

---

## Agent Environment Map (Current)

| Agent | Platform | Default Environment | Can Be Web? |
|-------|----------|-------------------|-------------|
| MarcusAurelius | Claude Code CLI | LOCAL | No — terminal only |
| Alexander | Claude Desktop / Desktop Code | LOCAL | Yes — if opened in claude.ai |
| Jiang | Claude.ai browser | WEB | Always web |
| Trey | GPT | WEB | Always web (no direct repo access) |
| All sub-agents | Spawned by parent | Inherits parent | Inherits parent |

---

## Rules

1. **This check is NOT optional.** Every boot, every agent, every session.
2. **The filesystem test is the ONLY authority.** Do not assume based on agent name or platform.
3. **Alexander CAN be either.** If opened on Desktop → LOCAL. If opened in claude.ai → WEB. The test determines which.
4. **GitHub is always source of truth.** LOCAL agents sync to it. WEB agents read/write directly.
5. **Never use a local path in a WEB environment.** Never use GitHub API in a LOCAL environment when filesystem is faster.

---

*ENVIRONMENT_DETECTION.md | Layer 0 | Created 2026-03-29 | Session 012 | CARDINAL*
