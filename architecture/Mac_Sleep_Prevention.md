# MAC SLEEP PREVENTION
Alexander | Velorin System | March 28, 2026

## Problem

Mac goes to sleep during long sessions, killing MCP server connections and terminal processes. This has ended sessions prematurely multiple times.

## Immediate Fix — Run Every Session Open

```bash
caffeinate -d &
```

This prevents the display from sleeping. Runs in background. Does not require sudo. Safe inside Velorin guardrails — this command does not touch the filesystem.

To stop it when done:
```bash
killall caffeinate
```

## Permanent Fix — launchd plist

A launchd plist registers caffeinate as a Mac launch daemon. Starts on boot, runs permanently, never needs to be manually triggered. This is on Jiang's build list. Requires writing one config file to ~/Library/LaunchAgents/. Build when bash MCP is confirmed live.

## MCP Keepalive

The velorin-gdrive MCP server v1.3.3 already has a 90-second keepalive ping built in. This prevents OAuth idle timeout. Combined with caffeinate, the system should stay live through full sessions.

[VELORIN.EOF]

Mac_Sleep_Prevention | Alexander | Velorin System | March 28, 2026