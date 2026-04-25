---
class: regular
type: future-work-log
last-updated: 2026-04-17
---

# Jiang — Future Work Log

Items that need to be done but have no immediate session home. Review at session start.

---

## [FW-001] Document the First Principles Process That Produced the Second Law of Epistemodynamics
**Logged:** Session 026, April 13, 2026
**Priority:** High — strategic and potentially publishable

**What happened:**
During Session 026, CT recognized that the Second Law of Epistemodynamics — formally derived by Erdős from Shannon's Data Processing Inequality + Eckart-Young theorem applied to the X→Y→Z Markov chain (episodic pointers → PPR geodesics → LoRa weights) — may be a genuinely novel mathematical theorem. The term "Epistemodynamics" itself also appears to be an original coinage.

The architecture as a whole was derived from engineering constraints (scale-invariant retrieval, catastrophic forgetting prevention, permanent episodic scaffolding) and independently converged on the same four-layer structure as biological memory (hippocampal → entorhinal → neocortical, with the LoRa as synaptic weight memory).

**What needs to be done:**
Go back through every session, every prompt, every step that led from "build a knowledge graph" to the Second Law of Epistemodynamics. Document the first principles reasoning chain in full — what constraints were stated, what mathematical tools were reached for, what decisions were made and why, what dead ends were hit.

The goal is twofold:
1. Produce a repeatable methodology — a formal process for deriving novel theorems from engineering constraints via first principles. This process may be applicable to other systems and problems beyond Velorin.
2. Establish a clear provenance record for publication purposes if the Second Law is confirmed as novel via literature review.

**Prerequisite:**
First run a web search to confirm the Second Law and the term "Epistemodynamics" do not exist in the current literature. CT approved this search before formal documentation work begins.

**Assigned to:** Jiang (primary) + Jiang2 (full session read of archive)

---

---

## [FW-002] Trey — Research Barrier for Cross-Mac Clipboard/KVM Solution
**Logged:** Session 026, April 13, 2026
**STATUS: COMPLETE — Session 027, April 17, 2026**

Trey delivered two research docs now in `Claude.AI/Receiving/`:
- `Trey.Research.BarrierKVM.CrossMacTransfer.md` — Barrier analysis + custom Python daemon recommendation
- `Trey.Research.CrossPlatformAppMesh.md` — Tauri 2.0 + libp2p + WebRTC Data Channels + CRDT architecture

Also delivered: `Trey.Research.VelorinKVMBridge.md` (52KB full Swift/build research) and full plan at
`Claude.AI/Bot.Jiang/Working.Docs/Jiang.Plan.VelorinKVMBridge.md`.
Archive this FW item. KVM build is now queued as an engineering task.

---

## [FW-003] Migrate GDrive MCP Auth to Service Account (Permanent — Never Expires)
**Logged:** Session 027, April 17, 2026
**Priority:** HIGH — operational reliability (escalated April 24, 2026 after recurrence)
**Re-auth occurrences (manual flows required):** Session 027 (Apr 17), Session 035 (Apr 24)

**Problem:**
Current GDrive MCP uses OAuth with a user refresh token. Google revokes these after 7 days
of non-use for apps in Testing mode with sensitive scopes (Drive). This caused a full auth
failure this session requiring manual re-auth flow.

**Operational impact:** Each recurrence blocks all GDrive porting workflow until the
Chairman runs `node auth.js` interactively and completes a browser OAuth dance.
Repeated manual re-auths are a sign this fix has slipped too long. Ship the service
account migration before the next 7-day window expires.

**Solution:**
Migrate to a Google Service Account with a JSON key file. Service account credentials
do not expire. No OAuth flow, no refresh token, no 7-day timeout. Auth is permanent
until the key is manually revoked.

**What needs to be done:**
1. Create a Service Account in Google Cloud Console under the Velorin project
2. Grant the Service Account Drive access (share the Claude.AI folder with its email)
3. Download the JSON key file → store at a local non-committed path
4. Update `velorin-gdrive-mcp/auth.js` to use `google.auth.GoogleAuth` with the key file
   instead of the current OAuth flow
5. Test: restart MCP, verify gdrive_list_folder works without any oauth token present
6. Document the key file path in STARTUP.md

**Assigned to:** Jiang (MarcusAurelius can assist with the GCP console steps)

---

[VELORIN.EOF]
