# Zone 13 — mcp-browser-tabs
**Research date:** 2026-03-30 | **Researcher:** Jiang | **Session:** 013

---

## What It Is

`@kazuph/mcp-browser-tabs` — macOS AppleScript-based MCP server that enumerates all open Chrome tabs across all windows. Installed and live in `claude_desktop_config.json` as of 2026-03-30.

**GitHub:** https://github.com/kazuph/mcp-browser-tabs
**Install:** `npx @kazuph/mcp-browser-tabs` (auto-downloads, no setup)
**Config entry name:** `browser-tabs`

---

## Tools Exposed

| Tool | Function |
|------|----------|
| `get_tabs` | Returns all open Chrome tabs organized by window. Format: Window/Tab index, title, URL. |
| `close_tab` | Closes a specific tab by window+tab index. Start from highest index when closing multiple to avoid index shifting. |

---

## How It Works

Uses AppleScript to query Chrome's tab state directly. Requires:
- macOS only
- Chrome running
- Accessibility permissions granted to Chrome in System Settings

No Chrome extension required. Works independently of Claude in Chrome.

---

## Why We Added It

**Problem:** Claude in Chrome MCP only sees tabs it creates (its own tab group). Existing open tabs — including a booted Trey session — are invisible.

**The gap:** `anthropics/claude-code#26591` — "Allow MCP tools to access existing tabs without requiring a dedicated MCP tab group." Open feature request, not yet implemented in official extension.

**The fix:** `get_tabs` returns all Chrome tab URLs, including Trey's live conversation URL. Claude in Chrome can then navigate directly to that URL — landing inside the booted session, not the project home page.

---

## Test Result — 2026-03-30

Simulated by CT providing Trey's conversation URL directly. Navigated to:
`chatgpt.com/g/.../c/69ca25d6-...`

Result: Landed inside active boot session. Trey's last message fully loaded: "State the first task." Ready for input. **No re-boot required.**

Verdict: **Worth implementing.** The conversation URL preserves live session state.

---

## Integration Pattern — Trey Push

```
1. get_tabs → scan all Chrome tabs for chatgpt.com conversations
2. Find Trey's project URL (known GPT ID: g-p-69c38c44eee4819186a6159085b024a5)
3. Claude in Chrome → navigate to that URL in group tab
4. Land in booted Trey → type research assignment → submit
```

---

## Limitations

- **Read + close only.** No click, type, scroll, or form interaction — that requires Claude in Chrome.
- **macOS only.** AppleScript is not available on Windows/Linux.
- **Chrome only.** Does not enumerate Safari, Firefox, or other browsers.
- **No programmatic tab adoption.** Can find the URL but cannot add the existing tab to the Claude in Chrome group. Navigate to URL is the workaround.

---

## Requires Restart

New MCP entries require Claude Desktop restart to load. Restart required once before first use.

---

*Filed: Jiang | Session 013 | 2026-03-30*
