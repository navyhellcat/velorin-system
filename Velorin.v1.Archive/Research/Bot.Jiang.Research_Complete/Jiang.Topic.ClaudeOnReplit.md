---
title: Claude Code in Replit Shell — Feasibility, Architecture, and Velorin Applications
author: Jiang (Deep Research Agent)
session: Research Task — Single Session
date: 2026-03-31
status: COMPLETE
confidence_floor: 75%
sources: Replit official docs, Anthropic Claude Code docs, GitHub issues, community reports
---

# Claude Code in Replit Shell — Velorin Applications

## EXECUTIVE SUMMARY

Replit-hosted Claude Code is technically viable for specific Velorin use cases but is not a solution to the timer persistence problem and is not cost-competitive for always-on workloads at Velorin's current scale. The most viable application is the Deep Research Pipeline wrapper. The least viable is Session Monitor T009. The single highest-signal, lowest-risk first experiment is a Replit Scheduled Deployment running a 60-line bash wrapper that polls a GitHub directory for research requests and fires `claude --bare -p` — no always-on infrastructure required, costs under $2/month on top of Replit Core.

---

## THREAD 1 — FEASIBILITY AND CONSTRAINTS

### Q1: Exact steps to install and authenticate Claude Code CLI in a Replit shell — what authentication options exist?

**Installation (confirmed, 87% confidence)**

Replit runs Ubuntu 20.04+ under the hood with a Bash shell, which satisfies Claude Code's system requirements (Ubuntu 20.04+, 4 GB RAM, Bash). The install path:

```bash
# Step 1: Run the native installer in Replit shell
curl -fsSL https://claude.ai/install.sh | bash

# Step 2: Add to PATH (required — npm global path problem on Alpine/Nix envs)
export PATH="$HOME/.local/bin:$PATH"

# Step 3: Persist PATH across restarts via .replit config
# In .replit file:
# [run.env]
# PATH = "/home/runner/.local/bin:/usr/bin:/bin"

# Step 4: Verify
claude --version
```

The Replit community forum confirms this works (reference: Added Claude Code to Replit through Shell, now what? — replit.discourse.group). The critical gotcha: PATH must be persisted in the `.replit` configuration file or `replit.nix`, not just `.bashrc`, because Replit's container may not source `.bashrc` on every restart.

**Authentication options (confirmed, 95% confidence from primary source — code.claude.com/docs/en/authentication)**

Four methods exist. Only two are viable in headless Replit:

| Method | Replit-viable? | Requires | Notes |
|--------|---------------|----------|-------|
| `ANTHROPIC_API_KEY` env var | YES | API key from console.anthropic.com | Pay-per-token billing. Set in Replit Secrets. Works in `--bare` mode. Highest precedence after cloud providers. |
| `CLAUDE_CODE_OAUTH_TOKEN` | YES | Claude Pro or Max subscription | Run `claude setup-token` locally first — generates 1-year OAuth token. Set as Replit Secret. Does NOT require browser on Replit. |
| Browser OAuth (`claude` interactive) | NO | Browser GUI | Fails headless. Unavoidable onboarding wizard if this is the only method. |
| Cloud provider (Bedrock/Vertex/Foundry) | CONDITIONAL | AWS/GCP/Azure org | Viable but introduces cloud dependency. Not appropriate for personal Velorin use. |

**Recommended pattern for Replit:**

```bash
# In Replit Secrets pane: add ANTHROPIC_API_KEY
# In shell or .replit run command:
claude --bare -p "your prompt" --allowedTools "Read,Bash,Edit"
```

`--bare` mode is critical for Replit. From the official docs: "Bare mode skips OAuth and keychain reads. Anthropic authentication must come from ANTHROPIC_API_KEY or an apiKeyHelper in the JSON passed to --settings." This eliminates all interactive auth requirements.

**OAuth token alternative (preferred for Max subscribers):**

Generate locally: `claude setup-token` → copies a `sk-ant-oat01-...` token to clipboard. Store in Replit Secrets as `CLAUDE_CODE_OAUTH_TOKEN`. Set in environment before running claude. This uses subscription billing rather than API credits — important cost consideration.

**Known issue:** The community gist documents that `~/.claude.json` must contain `hasCompletedOnboarding: true` and `oauthAccount` object or the onboarding wizard fires even with the token set. For a Replit deployment, write this file via `onBoot` command in `.replit`:

```bash
onBoot = """
echo '{"hasCompletedOnboarding":true,"lastOnboardingVersion":"2.1.29","oauthAccount":{"accountUuid":"YOUR_UUID","emailAddress":"YOUR_EMAIL","organizationUuid":"YOUR_ORG_UUID"}}' > ~/.claude.json
"""
```

---

### Q2: What Replit plan is required for always-on execution? Cost tiers?

**Confirmed tiers (93% confidence — docs.replit.com/billing/deployment-pricing + pricing page)**

| Plan | Monthly Cost | Always-On Available | Included Credits |
|------|-------------|--------------------|--------------------|
| Starter (Free) | $0 | No — repls sleep | None meaningful |
| Core | $20/mo (annual) or $25/mo | Yes — Reserved VM Deployments | $25/month |
| Pro | $95/mo (annual) or $100/mo | Yes + more powerful models | $100/month |
| Enterprise | Custom | Yes + SLA | Custom |

**Deployment types and costs:**

| Type | Cost | Always-On? | Best for |
|------|------|-----------|----------|
| Reserved VM — Shared Medium | $20/month | YES — 0.5 vCPU / 2 GB RAM | Lightweight polling agents |
| Reserved VM — Dedicated Small | $40/month | YES — 1 vCPU / 4 GB RAM | Moderate subprocess load |
| Reserved VM — Dedicated Medium | $80/month | YES — 2 vCPU / 8 GB RAM | Heavy processing |
| Scheduled Deployment | ~$1/month base + $0.000061/sec compute | No — fires on schedule | Cron-style tasks |
| Autoscale | $1/month base + usage | No — sleeps between requests | Web apps |

**For Velorin's use case:** The cheapest always-on option is Shared Medium Reserved VM at $20/month. A Scheduled Deployment at ~$1-3/month total is appropriate for research pipeline tasks that don't need real-time responsiveness.

**Credits caveat:** The $25/month Core credits cover Replit Agent and Replit's AI tooling — they do NOT cover Claude API calls made by a `claude --bare -p` subprocess. Those bill directly to the Anthropic account behind `ANTHROPIC_API_KEY`. Credits only offset Replit's own infra and AI features.

**Total cost for always-on Claude Code agent on Replit (conservative estimate):**
- Replit Core: $20-25/month
- Reserved VM Shared Medium: $20/month (drawn from credits or billed separately)
- Anthropic API calls: depends on task volume (see Thread 2 cost breakdown)
- **Floor estimate: ~$40-45/month for always-on infrastructure alone, before API usage**

---

### Q3: CPU/memory/disk constraints on Replit Repls affecting Claude Code subprocess execution

**Confirmed specs (88% confidence — from pricing docs + community reports)**

| Tier | vCPU | RAM | Storage | Network |
|------|------|-----|---------|---------|
| Free workspace | Shared/throttled | 512 MB–1 GB | ~1 GB | Limited |
| Core workspace | Up to 4 vCPU (shared) | 8 GiB | 50 GiB | 100 GiB/month |
| Reserved VM Shared Medium (deployed) | 0.5 vCPU | 2 GB | Plan-allocated | Included |
| Reserved VM Dedicated Small (deployed) | 1 vCPU | 4 GB | Plan-allocated | Included |

**Claude Code subprocess requirements (from official docs):** Minimum 4 GB RAM for interactive mode. `--bare -p` mode has lower overhead — no MCP server loading, no hooks, no CLAUDE.md reads. In practice, `claude --bare -p "short task"` requires approximately 500 MB–1.5 GB RAM depending on context window usage.

**Implication for Replit:** The Shared Medium Reserved VM (2 GB RAM, 0.5 vCPU) is at the minimum viable threshold. A single `claude --bare -p` call for a small task will work. Running multiple concurrent subprocesses or tasks with large context windows risks OOM kills. Dedicated Small (1 vCPU / 4 GB RAM) at $40/month is the safer choice for any real workload.

**Known failure mode:** Community reports confirm SIGKILL on RAM limit breach. The Always On feature does not protect against OOM crashes — it only prevents the Repl from sleeping. OOM crashes require manual restart or a supervisor process.

---

### Q4: Can a Replit Repl authenticate to a private GitHub repo via PAT and perform git pull/push reliably?

**Verdict: YES, with caveats (85% confidence)**

The pattern is confirmed and documented:

```bash
# In Replit Secrets: GITHUB_PAT = "ghp_your_token"

# Clone private repo (in onBoot or run command):
git clone https://${GITHUB_USER}:${GITHUB_PAT}@github.com/navyhellcat/velorin-system.git

# OR configure credential helper for existing clone:
git config credential.helper "!f() { echo username=navyhellcat; echo password=${GITHUB_PAT}; }; f"
```

**Reliability issues (important):**

1. **April 2023 GitHub credentials exposure incident:** Replit confirmed a vulnerability where imported repos stored GitHub auth tokens in git reflog files. Scope was <0.01% of users, but the vulnerability class (tokens in reflog) is architectural. Replit patched this. The fix: never use Replit's native GitHub import for credential-sensitive repos. Manual PAT via Secrets is the safer path.

2. **Concurrent push conflicts:** If both a Replit agent and local MA push to the same branch simultaneously, standard git merge conflict behavior applies. No Replit-specific protection. See Thread 4 for conflict avoidance workflow.

3. **PAT visibility to collaborators:** Any Replit collaborator with owner-level access to the Repl can see the PAT value by printing environment variables. This is acceptable for a single-user system with no collaborators, which matches Velorin's current profile.

4. **Push/pull from shell (not Replit's Git pane):** Manual git commands in shell using PAT work reliably. Replit's built-in Git pane uses OAuth for the connected GitHub account — this is a separate mechanism and may interfere with PAT-based credentials. Use shell commands only for agent git operations.

---

### Q5: Replit uptime SLA, restart behavior, crashes, cold starts

**Summary (80% confidence — community reports + official docs; no published SLA found)**

| Behavior | Free | Reserved VM (paid) |
|----------|------|-------------------|
| Sleep after inactivity | Yes — ~5 min | No |
| Cold start delay | 2-5 seconds | Not applicable (always warm) |
| OOM crash recovery | Manual restart required | Manual restart required |
| VM preemption | Yes (preemptible VMs) | No (dedicated allocation) |
| Published uptime SLA | None found | Enterprise tier only |
| Actual uptime (community reports) | Highly variable | ~99.9% reported by some users |

**Key finding:** Replit does NOT publish an uptime SLA for Core or Pro plans. Enterprise tier mentions dedicated support and SLA but terms are not public. Community reports for Reserved VM deployments show ~99.9% uptime in normal conditions, with incidents documented on status.replit.com. There have been cases of Reserved VM nodes crashing and going offline without automatic recovery.

**Crash behavior:** Replit does not have a built-in supervisor/watchdog for processes running in Reserved VM deployments. If the process crashes (OOM, exception, network failure), it does not automatically restart. Mitigation:

```bash
# Wrapper supervisor pattern in .replit run command:
run = """
while true; do
  python3 /path/to/agent_loop.py
  sleep 5
done
"""
```

This is a common community workaround. It handles crashes but not VM-level incidents.

**Cold start context for Velorin:** If using Scheduled Deployments (not Reserved VM), each scheduled run is a cold start. The Claude Code binary must be in the environment (handled by `.replit` config), but the deployment environment boots fresh. State must live in GitHub, not in-memory.

---

## THREAD 2 — VELORIN-SPECIFIC APPLICATIONS

### Q6: Which Velorin pain points does Replit-hosted Claude solve?

#### Terry (T007) — Shipping/Receiving Monitor

**Verdict: CONDITIONAL**

Terry currently runs as a CronCreate timer (15-minute polling, reads email/shipping data). The pain point: dies on session close.

Replit-hosted Terry would:
- Run as a Scheduled Deployment (fire every 15 minutes, $1-3/month base + minimal compute)
- No always-on Reserved VM needed — short-lived execution matches Scheduled Deployment model
- Read shipping data via GitHub (if MA writes incoming data there) or via an API call
- Write results back to GitHub via git push

**What Replit solves:** Persistence across MA session close. Terry keeps running regardless of MA's session state.

**What Replit does NOT solve:** Terry currently requires access to email or shipping systems. If those are local (e.g., local IMAP, local network resources), Replit cannot reach them. If Terry polls a public API or reads from GitHub state files that MA writes, this is fully viable.

**Dependency check:** The current Terry implementation needs review. If it reads from local files or local network resources, the Replit version would need those sources to be GitHub-mediated or API-accessible. This is a conditional blocker.

---

#### Scribe Escalation Processor

**Verdict: NOT VIABLE for Replit**

Scribe is a PostToolUse hook that fires when MA writes a memory file. The trigger is local filesystem event → hook fires → subprocess launches. This entire mechanism is local-machine-dependent:

- The hook fires via `~/.claude/settings.local.json` on MA's local machine
- The subprocess spawned is a local `claude --print` call
- Scribe reads `~/.claude/projects/-Users-lbhunt/memory/` — local path

Moving Scribe to Replit would require:
1. Eliminating the local PostToolUse hook trigger (would need GitHub webhook or polling instead)
2. Rewriting Scribe to pull memory files from GitHub rather than reading local paths
3. Rewriting Scribe's write path to push neurons to GitHub directly

This is a significant rewrite, not a migration. The local Scribe architecture is correct for what it does. The right fix for Scribe's persistence is launchd (true OS-level persistence for the escalation check) + the existing hook mechanism for the subprocess trigger. Replit adds complexity without solving the actual problem.

---

#### Deep Research Pipeline Wrapper

**Verdict: VIABLE — highest fit of all four**

The research pipeline wrapper (described in CompanyAlignment1 P1 items) is ~100-150 lines Python that:
1. Reads `Research_Needed/` directory for unprocessed `.md` files
2. Calls a research API (o4-mini-deep-research or `claude --bare -p` with research prompt)
3. Writes results to `Research_Needed/drafts/` or `Research_Complete/`
4. git commit + push

This is a near-perfect fit for Replit Scheduled Deployment:
- No local filesystem dependency — operates entirely on GitHub clone
- No real-time trigger needed — polling every 30-60 minutes is sufficient
- Scheduled Deployment cost: ~$1-3/month base + Claude API usage per task
- Fully stateless — each run: `git pull` → check for new requests → process → `git push`
- No Reserved VM required

**Velorin integration path:**
```
Jiang writes Research_Needed/ file → MA pushes to GitHub → Replit wakes on schedule →
git pull → detects new .md → fires claude --bare -p with research prompt →
writes to Research_Complete/ → git push → MA pulls on next session open
```

This increases throughput from 1-2 topics/week to the 4-6 topics/week documented in the Deep Research Pipeline research topic, without requiring MA's session to be open.

**Cost estimate for this specific use case:**
- Replit Core: $20/month (required for deployments)
- Scheduled Deployment: $1/month base + ~$0.50-2/month compute (fires hourly, short runs)
- Claude API per research task: $0.50-3.00 per task at typical topic length
- At 4-6 tasks/week: ~$10-20/month in API costs
- **Total: ~$30-45/month for the research pipeline specifically**

---

#### Session Monitor T009

**Verdict: NOT VIABLE**

T009 monitors the context window percentage of an active local Claude Code session. It operates by:
- Running as a CronCreate timer inside MA's active session
- Reading context % from the session state
- Alerting MA when threshold reached

There is no Replit analog for this. T009 requires:
1. Access to the active local Claude Code process state
2. An in-session CronCreate timer (session-scoped by design per official docs)
3. The ability to interrupt and alert the active session

Replit cannot access a local process's internal state. T009 is not a portability candidate. It must remain as session-scoped CronCreate. This is the correct architecture for it — the problem is not where it runs but that CronCreate dies on session close. T009 should be the last timer to migrate, and it may never have a migration path because its value is entirely dependent on being inside the session it's monitoring.

---

### Q7: Minimum viable Replit setup to replace the 4 dead timer agents (T001-T004)

**Dead timer inventory from CompanyAlignment1:**
- T001: Neuron Boss — designed, never deployed (brain structure management)
- T002: Custodian — designed, never deployed (file maintenance)
- T003: Mobility — designed, never deployed (cross-platform state sync)
- T004: Scribe daily clean — wired, not restarted (memory file housekeeping)

**Assessment per agent:**

| Agent | Replit viable? | Reason |
|-------|---------------|--------|
| T001 Neuron Boss | YES — Scheduled | Read GitHub brain, identify stale neurons, write correction suggestions. Fully GitHub-mediated. |
| T002 Custodian | CONDITIONAL | Depends on what "file maintenance" means. If local files: no. If GitHub repo cleanup: yes. |
| T003 Mobility | CONDITIONAL | Cross-platform sync requires defining what is being synced. If it's GitHub ↔ GitHub: yes. If local disk involved: no. |
| T004 Scribe daily clean | CONDITIONAL | Memory file cleanup. Currently local. Could be redefined as GitHub memory dir cleanup. |

**Minimum viable Replit setup to unblock all four:**

```
One Replit project with Scheduled Deployment
One Python script: velorin_agent_loop.py
One GitHub PAT in Replit Secrets
One ANTHROPIC_API_KEY in Replit Secrets
Schedule: every 30 minutes
```

```python
# velorin_agent_loop.py — skeleton
import subprocess, os

GITHUB_REPO = "navyhellcat/velorin-system"
VELORIN_ROOT = "/home/runner/velorin-system"

def sync_github():
    subprocess.run(["git", "-C", VELORIN_ROOT, "pull"], check=True)

def run_task(name, prompt, tools="Read,Bash,Edit"):
    result = subprocess.run(
        ["claude", "--bare", "-p", prompt, "--allowedTools", tools,
         "--output-format", "json"],
        capture_output=True, text=True, cwd=VELORIN_ROOT
    )
    return result.stdout

def push_results():
    subprocess.run(["git", "-C", VELORIN_ROOT, "add", "-A"], check=True)
    subprocess.run(["git", "-C", VELORIN_ROOT, "commit", "-m", "agent: scheduled maintenance run"], check=True)
    subprocess.run(["git", "-C", VELORIN_ROOT, "push"], check=True)

if __name__ == "__main__":
    sync_github()
    run_task("neuron_boss", "Review all neurons in Velorin_Brain/_index.md for staleness. Write a report to Claude.AI/Bot.MarcusAurelius/NeuronBossReport.md")
    run_task("custodian", "Check Claude.AI/Bot.Scribe/escalation.md for unprocessed entries. Write a summary to Claude.AI/Bot.Scribe/escalation_summary.md")
    push_results()
```

**Cost for this setup:** Scheduled Deployment at $1/month base + approximately $0.20-0.50 per run × 48 runs/day = $10-24/month in API costs at low task complexity. The infrastructure cost is minimal. The API cost scales with task complexity.

---

### Q8: Can a Replit-hosted Claude agent read/write the velorin-system GitHub repo as its persistent state layer?

**Verdict: YES — this is the correct pattern (92% confidence)**

This is the highest-confidence finding in this research. The GitHub-as-filesystem pattern is:

1. Replit Scheduled Deployment boots fresh each run
2. `onBoot` or first step: `git clone` or `git pull` from velorin-system
3. All reads and writes operate on the local clone (VELORIN_ROOT = the cloned repo)
4. End of run: `git add -A && git commit && git push`
5. Next run: `git pull` picks up any changes MA pushed locally

**This is architecturally sound because:**
- GitHub is already Velorin's source of truth (per MEMORY.md: "GitHub is source of truth — pull before every read")
- The pattern is explicitly how Velorin's cross-platform portability was designed to work
- No in-memory state needed between runs — all state lives in the repo
- Conflict resolution is handled by standard git (see Thread 4 for workflow)

**The `$VELORIN_ROOT` abstraction answer (Q14 preview):** YES. If Replit's environment sets `VELORIN_ROOT=/home/runner/velorin-system` and MA's local environment sets `VELORIN_ROOT=/Users/lbhunt/Desktop/velorin-system`, any script that uses `$VELORIN_ROOT` instead of hardcoded paths works on both. This is the portability fix for cloud agents specifically.

---

## THREAD 3 — ARCHITECTURE IMPLICATIONS

### Q9: If Replit becomes always-on infrastructure, what changes in the boot sequence?

**MA boot sequence changes (if Replit handles persistent agents):**

Current STARTUP.md reconstruction burden: Terry (T007), Scribe escalation check, any other CronCreate timers — all must be manually recreated each session.

With Replit handling Terry and T001-T004:

```
CURRENT BOOT:
1. Read files (done)
2. Run startup checklist → recreate timers (T007, escalation check, etc.)
3. Check agent states (Alexander, Jiang)
4. Begin work

REPLIT-AUGMENTED BOOT:
1. Read files (done)
2. git pull velorin-system (Replit may have pending writes from overnight runs)
3. Check Replit agent output files (NeuronBossReport, escalation_summary, etc.)
4. Check agent states (Alexander, Jiang)
5. Begin work (no timer recreation needed for Replit-managed agents)
```

**Session Monitor T009 remains session-scoped CronCreate.** No change there.

**The critical difference:** MA's boot goes from "reconstruct the world" to "pull and read what Replit did while you were offline." This is a meaningful reduction in boot burden if Replit agents are reliably running.

**Caveat:** This only holds if Replit doesn't crash silently. MA must verify Replit output freshness at boot. A stale timestamp on Replit output files signals a crash or stoppage.

---

### Q10: IPC pattern between Replit-hosted agent and local Claude Code CLI session

**Three viable patterns, ranked by reliability:**

**Pattern A: File-based via GitHub (recommended)**

```
MA (local) → write file → git push → [GitHub] → Replit polls on schedule → git pull → reads file → processes → writes result → git push → [GitHub] → MA pulls at next session open
```

- Latency: minutes to hours (matches Scheduled Deployment minimum 1-hour cloud tasks, or 1-minute Scheduled Deployment if set up on Replit nix)
- Reliability: high — git is the transport, no socket dependencies
- Conflict risk: low with proper branch/file design (see Thread 4)
- Already the pattern Velorin uses — zero new infrastructure

**Pattern B: Direct API call from MA to Replit-hosted endpoint**

```
MA (local) → HTTP POST to Replit Reserved VM HTTP server → Replit agent processes → returns response
```

- Latency: seconds
- Requires: Reserved VM with HTTP server running
- Reliability: depends on Replit uptime; Reserved VM is ~99.9%
- Use case: if MA needs a synchronous response (e.g., "run this research task now and return result")
- Cost: Reserved VM required ($20-40/month additional)

**Pattern C: Webhook trigger**

```
MA (local) → git push to GitHub → GitHub webhook → Replit receives event → agent fires
```

- Latency: seconds after push
- Requires: Replit web server endpoint + GitHub webhook config
- More complex setup, not materially better than Pattern A for Velorin's use case

**Recommendation:** Pattern A (file-based via GitHub) for all non-real-time tasks. Pattern B only if CT needs a synchronous agent call pattern, which is not currently a Velorin requirement.

---

### Q11: Does Claude Code on Replit expose the same Agent Teams IPC bugs?

**Verdict: YES — all three bugs are platform-agnostic (97% confidence)**

Detailed analysis from primary GitHub issues:

**Issue #23415 (inbox polling never activates):** CLOSED NOT_PLANNED. Root cause is in the team messaging layer initialization — not OS or tmux specific. A commenter notes the ENV variable initialization timing is the trigger, which affects any shell environment. Running in Replit would reproduce this bug identically. The inbox files are written to `~/.claude/teams/{name}/inboxes/` — a path that exists in any environment.

**Issue #25135 (SendMessage silent success with wrong recipient):** CLOSED NOT_PLANNED, LOCKED March 31, 2026. Root cause is in `validateInput()` — pure application logic, fully platform-agnostic. Would reproduce on Replit, Windows, macOS, any environment running Claude Code. Platform is irrelevant.

**Issue #23620 (team config lost on context compaction):** OPEN. Root cause is in context compaction logic — the team state is not persisted through the compaction event. This is a Claude Code core issue, not an OS issue. Would affect Replit if running long sessions (though Replit Scheduled Deployment runs are short, so this is less likely to trigger).

**Key insight:** Running Claude Code as headless subprocesses (`claude --bare -p`) with no Agent Teams (`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` not set) sidesteps all three bugs entirely. The bugs only manifest when using the Agent Teams feature. Velorin's Replit pattern should use standalone `claude --bare -p` calls, not Agent Teams. This is not a limitation — it is the correct architecture for a Replit-hosted agent that coordinates via GitHub files rather than in-process messaging.

---

### Q12: Security implications of storing Anthropic API key + GitHub PAT in Replit Secrets

**Risk assessment (82% confidence)**

**Replit Secrets encryption:** AES-256 at rest, TLS in transit. Comparable to standard cloud secret management.

**Access model risks:**

| Risk | Severity | Likelihood | Mitigation |
|------|----------|-----------|-----------|
| Collaborator sees secret values | HIGH if collaborators exist | Low (no collaborators on Velorin Replit) | Keep Repl private, zero collaborators |
| Replit employee access | LOW-MEDIUM | Low (requires breach or insider) | Use fine-grained PAT with minimal scopes |
| PAT in git reflog (2023 vulnerability) | HIGH | Low (patched) | Never use Replit's native GitHub import; use manual PAT via Secrets |
| API key leaked via public Repl | HIGH | Low (keep Repl private) | Repl must remain private, not published |
| Shai-Hulud style worm (scans for keys) | MEDIUM | Low but nonzero | Rotate keys quarterly; fine-grained scopes |
| Replit account compromise | HIGH | Low with strong 2FA | Enable 2FA on Replit account |

**GitHub PAT recommendations for Velorin:**
- Use a **fine-grained PAT** scoped to `navyhellcat/velorin-system` only (not all repos)
- Grant: `Contents: read/write`, `Metadata: read`
- Set expiration: 90 days with rotation reminder
- This limits blast radius to the velorin-system repo if the token is compromised

**Anthropic API key recommendations:**
- Use a key from the Claude Console with spending limits set
- Set a monthly budget cap (e.g., $50/month) to prevent runaway spend
- Rotate if anything suspicious is observed on the Console usage dashboard

**Overall verdict:** Acceptable risk for a personal operating system with no collaborators, private Repl, fine-grained PATs, and 2FA on Replit account. Not appropriate for multi-user deployment without a proper secrets manager (Vault, AWS Secrets Manager, etc.).

---

### Q13: Could Replit-hosted Claude serve as the always-on orchestrator for Path 3 before the Claude Agent SDK build?

**Verdict: CONDITIONAL — viable as a stopgap, not as a destination (78% confidence)**

Path 3 is defined as: Alexander spawning Jiang as a subagent via Claude Agent SDK. That full path requires the SDK build (4-7 sessions per CompanyAlignment1).

A Replit-hosted orchestrator could approximate Path 3's function:

```
Current: MA manually tasks Jiang → Jiang runs → MA pulls results (manual, session-dependent)

Replit stopgap: MA writes task to GitHub task queue → Replit orchestrator polls →
fires claude --bare -p with Jiang-style research prompt → writes results to GitHub →
MA reads on next session open
```

**What this achieves:**
- Research tasks execute without CT or MA being present
- Results accumulate in GitHub between sessions
- Latency: hours (acceptable for research tasks)
- No Agent SDK required

**What this does NOT achieve:**
- True dynamic tasking (Jiang's judgment about what to research next)
- Bidirectional real-time communication (Alexander ↔ Jiang)
- Agent specialization (the Replit agent is a generic `claude --bare -p`, not a full Jiang persona)

**Architectural verdict:** Use as a stopgap for the Deep Research Pipeline and T001 Neuron Boss. Do not mistake it for Path 3. Path 3 requires the Agent SDK because the value is in programmatic orchestration with dynamic task decomposition, not just scheduled subprocess execution.

---

## THREAD 4 — PORTABILITY

### Q14: Does `$VELORIN_ROOT` pointing to a cloned GitHub repo solve the portability problem for cloud-hosted agents?

**Verdict: YES for cloud agents, partially for local agents (90% confidence)**

The `$VELORIN_ROOT` abstraction:

```bash
# Local MA (.bashrc or STARTUP.md):
export VELORIN_ROOT="/Users/lbhunt/Desktop/velorin-system"

# Replit agent (.replit or onBoot):
export VELORIN_ROOT="/home/runner/velorin-system"

# Any future second user:
export VELORIN_ROOT="/home/someuser/velorin-system"
```

Any script using `$VELORIN_ROOT` instead of `/Users/lbhunt/Desktop/velorin-system` becomes portable.

**What this solves:**
- Cloud agents (Replit, GitHub Actions, any future cloud host) — fully solved
- New local users — fully solved (set `$VELORIN_ROOT` to their path, run installer)
- The portability problem documented in Root Problem 4 of CompanyAlignment1 — directly addressed

**What this does NOT solve:**
- MCP server configs that hardcode paths in `~/.claude/settings.local.json` — those need separate abstraction
- Launchd plists that hardcode paths — need regeneration via installer script
- The brain neurons themselves if they contain hardcoded paths (spot check recommended)

**Implementation path (minimal):**
1. MA adds `export VELORIN_ROOT="/Users/lbhunt/Desktop/velorin-system"` to local `.bashrc`
2. All new scripts use `$VELORIN_ROOT` (existing scripts can be migrated opportunistically)
3. Replit's `.replit` sets `VELORIN_ROOT=/home/runner/velorin-system` in `[run.env]`
4. No installer script needed for MVP — this is 2 lines of configuration

---

### Q15: Git workflow for a Replit agent that reads state, processes, and writes results without conflicting with local MA pushes

**The conflict risk:** Both MA (local) and Replit agent push to `main` branch. Standard git conflict on concurrent pushes.

**Recommended workflow: branch-based with merge (87% confidence)**

```
main branch: source of truth — MA owns push rights
replit/agent-output branch: Replit-only writes

Replit workflow per run:
1. git clone/pull main
2. git checkout -b replit/agent-output (or git checkout replit/agent-output if exists)
3. git merge main (get latest)
4. do work (read from repo, process, write output files)
5. git add output files only
6. git commit -m "replit: [task name] [timestamp]"
7. git push origin replit/agent-output

MA workflow:
- git fetch --all on session open
- git merge replit/agent-output (or cherry-pick specific commits)
- Review and accept Replit outputs
- Push to main
```

**Alternative: file-namespace approach (simpler, no branching)**

Designate specific output directories as Replit-owned. MA never writes to these directories. Replit never writes to MA-owned directories.

```
MA writes to: Claude.AI/Bot.MarcusAurelius/, Brain/, memory/
Replit writes to: Claude.AI/Bot.Replit_Agent/, Research_Complete/ (output only, not input)
Task queue: Claude.AI/Bot.Replit_Agent/task_queue/ (MA writes tasks here, Replit reads+deletes)
```

This eliminates merge conflicts by ownership. No branch management required. The tradeoff is looser coupling — MA must check Replit's output directory, not `main`.

**Recommended approach for Velorin MVP:** File-namespace approach. Simpler, matches Velorin's existing GitHub-as-filesystem pattern, no branching overhead. Implement branch-based workflow only if multiple Replit agents are deployed concurrently.

**Conflict resolution fallback:** If a conflict does occur, `git pull --rebase` on Replit handles most cases since output files are agent-generated (no human edits to conflict with). Configure Replit's git with:
```bash
git config pull.rebase true
git config user.email "replit-agent@velorin.internal"
git config user.name "Velorin Replit Agent"
```

---

## REQUIRED DELIVERABLES

### Feasibility Verdicts — Thread 2 Applications

| Application | Verdict | Confidence | Reason |
|-------------|---------|-----------|--------|
| Terry (T007) shipping/receiving monitor | CONDITIONAL | 80% | Viable if Terry's data sources are API/GitHub-accessible. Not viable if Terry requires local network or local filesystem reads. Needs source audit before migration. |
| Scribe escalation processor | NOT VIABLE | 88% | Scribe's value is in PostToolUse hook → local subprocess chain. Moving to Replit requires architectural rewrite, not migration. Local launchd is the correct fix. |
| Deep Research Pipeline wrapper | VIABLE | 91% | Near-perfect architectural fit for Replit Scheduled Deployment. All I/O is GitHub-mediated. No local dependencies. Directly addresses Jiang's throughput bottleneck. |
| Session Monitor T009 | NOT VIABLE | 95% | T009 monitors local MA session state by design. No Replit analog exists. Must remain session-scoped CronCreate. Cannot be migrated. |

---

### Text-Based Architectural Diagram: Replit Agent ↔ GitHub ↔ Local MA Data Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                     GITHUB (navyhellcat/velorin-system)          │
│                                                                   │
│  main branch (MA owns writes)                                    │
│    ├── Claude.AI/Bot.Replit_Agent/task_queue/       ←── MA writes│
│    ├── Claude.AI/Bot.Replit_Agent/output/           ──→ MA reads │
│    ├── Research_Needed/                             ←── MA writes│
│    ├── Research_Complete/                           ──→ MA reads │
│    └── Velorin_Brain/ (neurons)                     ←→ both      │
│                                                                   │
└──────────────┬────────────────────────────────┬─────────────────┘
               │ git pull/push                  │ git pull/push
               │                                │
               ▼                                ▼
┌──────────────────────┐            ┌──────────────────────────┐
│  REPLIT AGENT        │            │  LOCAL MA (macOS)         │
│  (Scheduled Deploy)  │            │  (Claude Code CLI)        │
│                      │            │                           │
│  Schedule: */30 * *  │            │  Session-scoped (manual)  │
│                      │            │                           │
│  1. git pull main    │            │  1. git pull (boot)       │
│  2. scan task_queue/ │            │  2. read Replit outputs   │
│  3. claude --bare -p │            │  3. write task_queue/     │
│  4. write output/    │            │  4. push to main          │
│  5. git push         │            │                           │
│                      │            │  Timers: T007, T009,      │
│  Auth:               │            │  Scribe hook (local)      │
│  ANTHROPIC_API_KEY   │            │                           │
│  GITHUB_PAT          │            │                           │
│  (Replit Secrets)    │            │                           │
└──────────────────────┘            └──────────────────────────┘

IPC channel: file-based via GitHub (async, minutes-to-hours latency)
No direct socket connection between Replit and local MA.
GitHub is the message bus, the state store, and the audit log.

FAILURE MODES:
- Replit crashes → task_queue accumulates unprocessed → MA processes on next boot
- GitHub unreachable → both agents queue locally, sync on reconnect (standard git behavior)
- Concurrent push conflict → file-namespace design prevents; branch-based as fallback
```

---

### Cost Estimate for Always-On Replit Running Claude Code at Current Velorin Task Volume

**Current Velorin task volume (estimated from CompanyAlignment1):**
- Research tasks: 2-4 per week (Research_Needed/ queue)
- Timer checks (T007 equivalent): 96 runs/day at 15-min intervals
- Neuron maintenance (T001 equivalent): 1-2 runs/day
- Escalation checks (T004 equivalent): 48 runs/day at 30-min intervals

**Scenario A: Scheduled Deployment only (recommended for MVP)**

| Component | Cost |
|-----------|------|
| Replit Core subscription | $20/month |
| Scheduled Deployment base | $1/month |
| Compute (short runs, ~30 min total/day) | ~$1-3/month |
| Anthropic API — research tasks (4/week avg, $1-2/task) | ~$16-32/month |
| Anthropic API — maintenance tasks (lightweight, ~$0.05/run × 100 runs/week) | ~$20/month |
| **Total** | **~$58-76/month** |

**Scenario B: Reserved VM Shared Medium (always-on, real-time)**

| Component | Cost |
|-----------|------|
| Replit Core subscription | $20/month |
| Reserved VM Shared Medium | $20/month |
| Anthropic API — same task volume | ~$36-52/month |
| **Total** | **~$76-92/month** |

**Comparison to current cost:** Current MA session runs on CT's Claude Max subscription (fixed monthly). Adding Replit adds $58-92/month depending on architecture. For the Deep Research Pipeline specifically (Scenario A, research tasks only): ~$35-55/month all-in — roughly what a single researcher hour costs.

**Cost-reduction lever:** Use `CLAUDE_CODE_OAUTH_TOKEN` (Max subscription auth) instead of `ANTHROPIC_API_KEY` if CT's Max subscription covers API usage for subprocesses. This would reduce or eliminate the per-task API cost, leaving only Replit infrastructure (~$21-23/month). Verify with Anthropic docs whether Max subscription OAuth token usage is usage-capped or unlimited in headless mode.

---

### Single Recommended First Experiment

**Experiment: Replit Scheduled Deployment — Research Pipeline Smoke Test**

**Goal:** Validate the full Replit → GitHub → MA data flow with a real research task. Zero risk to existing Velorin infrastructure.

**What to build (one session, ~2 hours):**

1. Create a new private Replit (Node.js or Python template)
2. Add two Secrets: `ANTHROPIC_API_KEY`, `GITHUB_PAT`
3. Write `onBoot` command in `.replit`:
   ```
   git clone https://navyhellcat:${GITHUB_PAT}@github.com/navyhellcat/velorin-system.git /home/runner/repo
   curl -fsSL https://claude.ai/install.sh | bash
   echo '{"hasCompletedOnboarding":true,...}' > ~/.claude.json
   ```
4. Write a 30-line `research_runner.py`:
   - `git pull` the repo
   - Check `Claude.AI/Bot.Replit_Agent/task_queue/` for any `.md` files
   - If found: run `claude --bare -p "$(cat task.md)" --allowedTools Read --output-format json > output.json`
   - Write output to `Claude.AI/Bot.Replit_Agent/output/[taskname]_result.md`
   - `git commit && git push`
5. Deploy as Scheduled Deployment (hourly trigger)
6. From local MA: write a simple test task to `Claude.AI/Bot.Replit_Agent/task_queue/test_task.md`
7. Push to GitHub
8. Wait for Replit's next scheduled run
9. Pull and read the output

**Why this experiment:**
- Cost: ~$2-3 total for one day of testing (no Reserved VM, Scheduled Deployment only)
- Risk: zero — entirely isolated from existing Velorin infrastructure; uses a separate output directory
- Signal: proves or disproves the full data flow in one session
- Rollback: delete the Replit project; no local changes needed
- If it works: immediately applicable to Deep Research Pipeline
- If it fails: identifies the exact failure point (install, auth, git, or task execution) with minimal investment

---

## CONFIDENCE SUMMARY

| Finding | Confidence | Source Quality |
|---------|-----------|---------------|
| Install procedure | 87% | Official docs + community forum confirmation |
| Auth methods (API key, OAuth token) | 95% | Primary source: code.claude.com/docs |
| `--bare` mode for headless | 93% | Primary source: code.claude.com/docs/en/headless |
| Replit plan tiers and costs | 88% | Official pricing docs + third-party analysis |
| Reserved VM specs (0.5 vCPU / 2 GB base) | 85% | Official billing docs |
| GitHub PAT auth via Replit Secrets | 85% | Official docs + community validation |
| No Replit uptime SLA (Core/Pro) | 80% | Absence of published SLA confirmed |
| IPC bugs platform-agnostic | 97% | Primary GitHub issues with root cause analysis |
| Scribe NOT viable for Replit | 88% | Architecture analysis against local hook dependency |
| Deep Research Pipeline viable | 91% | Architecture analysis — no local dependencies |
| T009 NOT viable for Replit | 95% | Structural dependency on local session state |
| `$VELORIN_ROOT` solves cloud portability | 90% | Direct path abstraction analysis |
| File-namespace conflict avoidance | 87% | Standard git practice + Velorin architecture fit |
| Security assessment (acceptable for solo use) | 82% | Incident history + access model analysis |

---

## ADDENDUM — CT CLARIFICATION (March 31, 2026)

CT's original intent was the inverse of what this research document covers.

**What CT meant:** Use Claude's shell (Bash tool) to issue commands to Replit, offloading compute-heavy tasks to Replit's infrastructure without burning tokens inside Claude's context window. Claude triggers the work, Replit runs it, Claude reads back results. The token cost to Claude is only the command and the result — not the computation itself.

**What this research covered:** Running Claude Code CLI inside a Replit shell as a cloud-hosted agent.

Both patterns are valid and complementary. The clarified pattern is simpler and more directly achievable.

### The Clarified Pattern — Claude Shell → Replit Compute

**Interface options:**
- **Replit CLI** (`replit` command) — callable from Claude's Bash tool, triggers Repl execution on Replit infrastructure
- **Replit REST API** — Claude calls API endpoints via `curl` or Python to start, stop, and read output from Repls
- **GitHub as data layer** — Claude writes task inputs to GitHub, Replit polls and processes, Claude reads outputs back. No real-time dependency, no polling overhead, no new infrastructure.

**Token-saving mechanism:** Computationally expensive tasks (data processing, script execution, bulk operations) run on Replit's clock rather than inside MA's context window. The Claude API is billed per token — work that happens outside the context window is free from that perspective. Replit's compute runs on its own pricing tier.

**What the original research adds to this pattern:** The `ANTHROPIC_API_KEY` + `claude --bare -p` subprocess pattern means Replit can also handle AI-reasoning tasks that don't need to live in MA's window. Two complementary modes:
1. Replit as pure compute substrate (no AI, just script execution) — token cost to Claude: near zero
2. Replit as Claude subprocess runner (AI tasks offloaded from MA's session) — token cost billed to Replit's API key, not MA's session budget

**First experiment still valid:** 30-line Python script, Replit Scheduled Deployment, reads task file from GitHub, processes, writes result back. Confirms the full loop. Cost: ~$2-3 for one day of testing.

[VELORIN.EOF]
