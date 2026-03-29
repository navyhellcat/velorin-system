TURING VAULT — CYCLE AUDIT
Velorin Code Review | Consultant Layer | March 25, 2026
Purpose: Three-pass audit of CODEBASE_SNAPSHOT.md, separating low-level inconsistencies, exploit/bug surfaces, and larger architectural/process failures.


EXECUTIVE SUMMARY
This audit is based on the code snapshot document, not a live repository checkout. Several issues are fully confirmed from the snapshot itself, while a smaller set are high-confidence risks inferred from omissions. The strongest pattern is not a single bug — it is split-brain state: split config, split truth, split audit status. The 'production-ready' label coexists with multiple ship-blocking items. That is the core problem.


1. WHAT IS CORRECT AND SHOULD BE KEPT
1.1 CONFIRMED — Precomputed session_passages
Keep the decision to precompute ordered passage lists at session creation. That stabilizes the test experience, makes results reproducible, and avoids mid-session drift.


1.2 CONFIRMED — Server-side truncation as source of truth
Keep truncateTo70Words() on the server side. The client should not be trusted to enforce passage exposure limits.


1.3 CONFIRMED — Hashed IP instead of raw IP storage
Keep the privacy posture. Hashing IP before storage is the correct default for this product type.


1.4 CONFIRMED — Silent bot classification
Keep the decision to avoid exposing bot classification to the user in real time. Exposed anti-bot labels are training data for attackers.


2. CYCLE 1 — Low-Level Inconsistencies
2.1 CONFIRMED — Email recipient truth is split across three places
What is wrong: settings.admin_email, email.ts send-to, and the UI display string all disagree on the recipient address.
Why it matters: config, runtime behavior, and operator feedback disagree. Not just cosmetic.
Fix: one source of truth — env var as startup default, settings table as runtime override, UI displays recipient returned by API after send.


2.2 CONFIRMED — Stripe links are still placeholders
STRIPE_LINK = '#' and VAULT_STRIPE_LINK = '#' are still present. Dead paths in the UI. Replace with real URLs or remove affordance until payment is live.


2.3 CONFIRMED — TOC anchor strings look malformed
Anchors appear auto-generated or hand-edited incorrectly. Internal navigation is likely broken. Regenerate TOC from actual headings.


2.4 CONTEXT NOTE — Package manager flag does not apply here
Trey flags pnpm vs the Velorin npm standard. The Velorin CodingStandards npm rule applies to MCP builds. Turing Vault is a separate pnpm monorepo product. This is not a drift problem. Do not change it.


2.5 HIGH CONFIDENCE — crypto.ts vs hash-ip.ts naming drift
Both files exist in the monorepo but hashIp() is described as living in crypto.ts. One of the two is dead or redundant. Susan should grep for hashIp( and delete the unused file.


2.6 HIGH CONFIDENCE — Route inventory is incomplete
/adversarial-unlocked and the adversarial webhook route are referenced in behavior descriptions but not listed in the monorepo inventory. Either the snapshot is incomplete or the route list is not trustworthy. Generate route inventory automatically.


2.7 CONTEXT NOTE — FBII is intentional product tone
'FBII HANDLER NOTIFIED' is an intentional joke element in the results UI. Not a typo. Lock it and move on.


3. CYCLE 2 — Bugs, Exploit Paths, and Abuse Cases
3.1 CONFIRMED — Stripe webhook verification is missing
Exploit path: anyone who can hit the endpoint can potentially grant themselves adversarial access if the server trusts the payload without signature verification.
Fix: verify Stripe signature on every webhook, check event type explicitly, verify checkout session status server-side, store webhook event IDs for idempotency, add unique constraint on stripe_session_id.


3.2 CONFIRMED — Admin password fallback is hardcoded
process.env.ADMIN_PASSWORD || 'turingvault2024' — if env config is missing, the fallback becomes the password.
Fix: fail closed at startup. Refuse to boot admin auth without ADMIN_PASSWORD present.


3.3 CONFIRMED — No rate limit on POST /sessions
Exploit path: cheap automated corpus scraping, passage pool exhaustion, increased DB churn.
Fix: layered rate limiting on session creation — hashed IP, visitor token, user-agent bucket, optional burst + daily cap.


3.4 HIGH CONFIDENCE — Likely IDOR risk on /sessions/:id/* routes
The snapshot does not confirm that visitor ownership is verified on session routes. If session ID alone is accepted, an attacker can enumerate IDs and access another user's session.
Fix: on every session route, require session.visitor_id === currentVisitor.id. Susan must verify this is already enforced. Not confirmed from snapshot alone.


3.5 HIGH CONFIDENCE — Adversarial unlock bound to IP is fragile
Shared IP or NAT means one buyer may unlock for multiple people. IP churn means a legitimate buyer loses access when their IP changes. Mobile or corporate networks cause inconsistent access.
Fix: bind unlocks to visitor_token, not IP. Keep hashed IP only as a secondary fraud signal.


4. CYCLE 3 — Architectural and Process Failures
4.1 CONFIRMED — Split-truth problem
Config, runtime, and operator feedback repeatedly disagree across the codebase. One email address in the settings table, another in the mailer, a third in the UI display string.
Fix: three classes of truth with no overlap — startup truth (env vars), runtime truth (DB settings), computed truth (values returned from APIs rendered directly in UI). No value exists in more than one class without an explicit precedence rule.


4.2 CONFIRMED — 'Production-ready' used without release gates
The snapshot contains unresolved payment verification, hardcoded admin fallback, missing rate limits, and an export path that can fail under load. Those are release gates, not future nice-to-haves.
Fix: define release status as a state machine — prototype, internal-demo, beta, production-candidate, production. Define explicit blockers for each state.


4.3 HIGH CONFIDENCE — Snapshot-based audits give false closure
Several risks arise precisely from what the snapshot omits — ownership checks, idempotency behavior, exact route inventory, exact Stripe handler behavior.
Fix: two-surface audit rule. Surface A: operator snapshot for intent and architecture. Surface B: generated evidence from the live repo (route inventory, env var inventory, dead-config scan, auth matrix per endpoint, grep for hardcoded values, schema diff). No audit is complete unless both surfaces agree.


4.4 CONFIRMED — Bot detection is conceptually weak
Elapsed time threshold is easy to game and easy to false-positive. Valid long-term concern. Not the current priority at 12 sessions in the DB.
Future fix: multi-signal scoring — answer latency, focus/blur behavior, copy/paste events, repeat navigation patterns, confidence variance, answer streak anomalies.


4.5 CONFIRMED — Payment access is bolted on instead of modeled as a lifecycle
Entitlements should be a first-class concept with explicit states: checkout created, checkout completed, webhook received, payment verified, entitlement granted, entitlement expired, entitlement revoked.


4.6 CONFIRMED — Resilience work is in the hot path
Monitor, export, email, and purge are tightly coupled. Under pressure, emergency behavior runs through the same service, same DB, and same memory constraints already under stress.
Future fix: exports should stream off-thread or off-process. Alerts should be cheap and non-blocking. Purge should happen only after durable backup confirmation.


4.7 HIGH CONFIDENCE — Single-instance assumptions acceptable for now
In-memory admin sessions and alert cooldowns are fine for one Replit instance. Valid long-term concern. Acceptable for current deployment shape.
Label each subsystem explicitly: single-instance safe, multi-instance unsafe, or migration-ready.


5. PRIORITIZED ACTIONS
5.1 Immediate
1. Remove hardcoded admin password fallback
2. Verify Stripe webhook signatures before payment goes live
3. Replace IP-based entitlement with visitor-token-bound entitlement
4. Add POST /sessions rate limiting
5. Collapse email recipient configuration to one source of truth


5.2 Next
6. Verify IDOR ownership check on all session routes
7. Move timing state from session-level to passage-level
8. Replace offset export batching with keyset pagination
9. Generate route inventory automatically from code


5.3 Before any 'Production' label
10. Endpoint auth matrix completed
11. Payment entitlement lifecycle implemented
12. Release gate checklist signed off
13. Snapshot and live repo audit outputs reconciled


6. CONFIDENCE STATEMENT
* Cycle 1 findings: HIGH CONFIDENCE overall
* Cycle 2 findings: HIGH CONFIDENCE overall, with two explicit omission-based risks marked
* Cycle 3 conclusions: HIGH CONFIDENCE on process diagnosis, MODERATE-to-HIGH on design inferences where snapshot omits code-level proof


[VELORIN.EOF]