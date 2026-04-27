# Bash Access Rules — System-Wide Governance

*Velorin System | Active | Pairs with `~/.claude/settings.local.json`*

This document is the source-of-truth for what bash commands any agent operating in the Velorin system is pre-approved to run vs what requires Chairman approval. The actual permission boundary is enforced by `~/.claude/settings.local.json`; this document explains the policy behind those settings.

---

## The Default

All tools and bash commands are permanently allowed via the `Bash(*)` wildcard in `~/.claude/settings.local.json`. Permissions are PERMANENT — never reduce.

## Hard Stops — Always Require Chairman Approval

These commands are explicitly denied at the settings level and require interactive Chairman approval each time:

- `rm` — file deletion
- `rmdir` — directory removal
- `trash` — soft-delete via macOS trash
- `sudo` — elevated privileges

If approval is granted in a session, it applies only to the specific command and scope; not to future commands of the same kind. The Chairman must approve each instance.

When `rm` is needed but unavailable, agents may use `mv [path] /tmp/[descriptive-name]` as a soft-delete that satisfies the intent (removing from the active working location) without needing approval.

## Soft Constraints — Use Judgment

These are technically allowed but require care:

- Modifying SSH keys or credentials anywhere on the system
- Sending data to external destinations via terminal (`curl`/`wget` POST, `scp` outbound)
- `git push --force` to main/master
- `git reset --hard`
- Modifying `~/.claude/settings.local.json` itself (changes to permissions)
- Operations on `/Users/lbhunt/Desktop/Velorin/Velorin Code/` — security-isolated repo, hands-off unless explicitly asked

## Working Directory Discipline

Default working directory is `/Users/lbhunt/Desktop/velorin-system/`. Agents may operate in subpaths freely. Operations outside this directory require either:
- An explicit Chairman instruction in the current session, or
- A documented standing exception (e.g., `~/.claude/` for settings, `/Users/lbhunt/CLAUDE.md` for top-level boot file, `/tmp/` for soft-deletes)

## Multi-Vendor Note (v2 Mac Studio Transition)

When the system transitions to multi-vendor cowork on Mac Studio, each vendor's bash surface needs its own subsection here. Codex, Claude Code, Gemini CLI, and other tooling that exposes shell access have different default permissions and different risks. This file expands at that point — additions land below this line, not as a rewrite.

## Source Files

- Permission enforcement: `~/.claude/settings.local.json`
- Restoration if lost: `Claude.AI/STARTUP.md` (Permissions section)
- Historical reference (pre-v2 Alexander-specific original): `Velorin.v1.Archive/Bash_Access_Rules.original.md`

[VELORIN.EOF]
