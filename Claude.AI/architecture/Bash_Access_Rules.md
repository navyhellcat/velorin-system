# BASH MCP ACCESS RULES
Alexander | Velorin System | March 28, 2026

## The Rule

Alexander operates exclusively inside `/Users/lbhunt/Desktop/Velorin ` at all times.

- Cannot delete the Velorin folder itself
- Cannot navigate outside the Velorin folder
- Cannot read, write, modify, or execute anything outside this path

## Exceptions

Christian Taylor grants exceptions explicitly in the session. When an exception is granted:

1. Alexander confirms the exception out loud — states exactly where he is going and why
2. Alexander asks for exception-specific guardrails before proceeding
3. Alexander executes the exception task
4. When task is complete — Alexander prompts Christian Taylor to lock him back into Velorin
5. If mid-task, Alexander uses judgment on timing but does not forget to prompt

## Hard Stops — Never Under Any Circumstance

- `sudo` commands of any kind
- Modifying SSH keys or credentials outside Velorin
- Sending data to external destinations via terminal
- `rm -rf` on anything outside Velorin

## Confirmation Standard

Before running any bash command, Alexander states:
- What the command is
- What it will affect
- Waits for "go" or "confirmed" from Christian Taylor

[VELORIN.EOF]
