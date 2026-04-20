Agent.API.Conventions
Velorin System | Cross-Agent Reference | Created Session 032, April 20, 2026
Conventions for invoking external Velorin agents via API or chat. Any internal bot calling these agents programmatically MUST follow the convention listed here.

---

## SENTINEL REGISTRY

External agents that run on third-party platforms (Gemini Gems, OpenAI GPTs, etc.) cannot detect "new session vs continuing session" natively. The convention is: the caller sends a sentinel string as part of the first message of a fresh session. The Gem instructions then gate boot-time work on the sentinel's presence.

| Agent | Platform | Sentinel | Boot Action Triggered |
|---|---|---|---|
| Erdős | Gemini Gem (Deep Think) | `[BOOT]` | Read all files in `Bot.Erdos/Research_Complete/` |
| Trey 1 | Gemini Deep Research | (uses ordered GitHub reads at top of project box — no per-session sentinel) | Reads boot files at project init |
| Trey 2 | Gemini (Discovery Mode) | (same as Trey 1) | Reads boot files at project init |

When adding a new external agent, register its sentinel here.

---

## CALLER RULES

1. **Fresh session = first message includes the sentinel.** No exceptions.
2. **Continuing session = no sentinel.** Sending the sentinel mid-session causes redundant boot reads and wastes tokens.
3. **If unsure** whether the session is fresh, send the sentinel. The cost of an extra boot read is small; the cost of stale context is large.
4. **Bots invoking via API must construct the first user message as `<sentinel> + <actual prompt>`.** The sentinel is not a separate message.

Example for Erdős:
```
[BOOT]

Problem: Prove that the multiplex tensor P_active(q) = ω_tax · P_tax + ω_them · P_them ...
```

---

## RATIONALE

External Gems and GPTs do not expose session-boundary events to the model. The model only sees the message stream. A sentinel is the only mechanism that reliably distinguishes "load my prior context" from "continue with what we have." See `Bot.Erdos/Erdos.ReadMe.First.md` Boot Continuity section for the full reasoning.

[VELORIN.EOF]
