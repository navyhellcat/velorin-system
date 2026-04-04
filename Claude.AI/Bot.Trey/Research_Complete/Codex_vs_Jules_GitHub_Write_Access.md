# Codex vs Jules — GitHub Write Access: Browser and Desktop
**Research Date:** April 4, 2026
**Researcher:** Jiang (synthesized from background agent findings)
**Purpose:** Determine which platform delivers GitHub write access from browser AND desktop

---

## PRIMARY QUESTION: Browser AND Desktop GitHub Write Access

These are two separate questions — both answered below.

---

## CODEX (ChatGPT Pro exclusive)

### Browser Write Access
- **Works officially.** Creates PRs, pushes branches from the ChatGPT browser interface
- **Reliability: C+** — Persistent private-repo OAuth failures in active community threads. Silent auth failures. 40-60% task success rate on private repos in practice
- Community threads with unresolved reports of private repo write failures are numerous as of April 2026

### Desktop Write Access
- **Has a real native macOS desktop app** (launched February 2026) and Windows (March 2026)
- Uses the same OAuth layer as the browser — same failures follow it to desktop
- Reliability: Same C+ as browser. The desktop app doesn't fix the auth problems

### Access Requirements
- Codex requires ChatGPT Pro ($200/month) — not available at Plus ($25)
- **Update from Cursor research:** Codex IS available at ChatGPT Plus via Cursor/IDE integration. The standalone Codex product (not IDE-integrated) requires Pro

---

## JULES (Google AI Ultra)

### Browser Write Access
- **Works.** Creates PRs, pushes branches from the browser interface
- **Reliability: B+** — Design-constrained to PR-only (never direct push to main). This constraint makes it stable. Changelog shows 2/3 failure reduction in GitHub sync
- Cleaner execution model than Codex

### Desktop Write Access
- **No official native desktop GUI.** The "desktop app" floating around is an unofficial Electron wrapper — not a Google product
- **BUT:** Official non-browser access paths exist and work:
  - **Jules Tools CLI** — official Google product, launched 2026, full GitHub write capability (PR creation, branch push)
  - **GitHub Action** — Jules as a GitHub Action, triggered from any context
  - **Gemini CLI extension** — Jules integrated into CLI workflow
- These are genuine non-browser paths, not workarounds

### Access Requirements
- Jules included in Google AI Ultra ($249.99/month)

---

## GEMMA 4 (released April 2, 2026)
- Open-source base model — free regardless of subscription
- Does NOT add GitHub agent capability
- Does NOT change the Codex vs Jules decision
- Relevant for local model hosting on Mac Studio, not for this question

---

## VERDICT

**For GitHub write access from browser:** Both work. Jules is more reliable (B+ vs C+).

**For GitHub write access from desktop GUI:** Codex has the prettier story (native macOS app). But the same OAuth failures follow it. Jules has no desktop GUI — the CLI and GitHub Action fill that role reliably.

**Overall winner: Jules (Google AI Ultra)**
More reliable despite no desktop GUI. Codex's desktop advantage is real on paper, broken in practice for private repos.

**Scenario where neither works:** Both are GitHub-only (no GitLab/Bitbucket). Both use PR-only model (no direct push to main). Both fail on complex iterative multi-branch work. Fallback: Claude Code (local) + GitHub CLI — the most reliable path.

**Confidence: 78%**

[VELORIN.EOF]
