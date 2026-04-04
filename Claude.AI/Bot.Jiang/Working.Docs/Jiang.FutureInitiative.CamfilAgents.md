---
class: c-memory
type: future-initiative
created: Session 016 | April 3, 2026
origin: Christian Taylor, conversation
status: IDEA — not yet scoped or scheduled
---

# Future Initiative — Camfil-Specific Agents

## The Concept
Build dedicated AI agents that assist Christian Taylor with Camfil (work) tasks — operating from his work computer, accessing company files and systems, automating workflows specific to his role.

## The Microsoft Authentication Problem
Most Camfil systems sit behind Microsoft corporate logins (Azure Active Directory / Microsoft Entra ID). SharePoint, Teams, OneDrive, Outlook — all require corporate account authentication. Standard API access is often blocked by Conditional Access Policies enforced by corporate IT.

## Why It's More Solvable Than It Looks

### Path 1 — Browser Session Riding (Available Now)
Christian's work computer Chrome is already authenticated into his Microsoft corporate account. Claude_in_Chrome can navigate SharePoint, read documents, interact with Teams web, access Outlook web — riding on top of the existing authenticated session. No re-login. No credentials passed to the agent. IT sees normal browser traffic from a normal browser on an enrolled device.

This is not a workaround. It is the same session Christian uses manually. The agent uses it the same way.

### Path 2 — Microsoft Graph API + MCP (Near Term)
Microsoft Graph API provides full programmatic access to 365 — files, email, calendar, Teams, SharePoint, OneDrive, contacts. MCP servers for Graph API already exist. If IT will authorize an OAuth token for Christian's account (or a service account), Claude can call Graph as a native tool rather than navigating a browser.

Faster, more reliable, more powerful than browser automation. Enables background tasks that don't require the browser to be open.

Constraint: Conditional Access Policies may restrict token issuance to compliant/enrolled devices. Evaluate with IT.

### Path 3 — Local Network Architecture (Longer Term)
Camfil agents run on the local network. Work computer acts as both client and server. Files processed locally — never leave the corporate network or home network. Agent results accessible from any device on the network via the same local server pattern already demonstrated (192.168.1.3:8765 pattern).

## Local Network Discovery — Session 016
Demonstrated this session: Mac serves HTML over local network (Python HTTP server at 192.168.1.3:8765). Work computer Chrome accesses it directly via LAN. No cloud. No file transfer. No external services.

This is the foundational pattern for Camfil agents:
- Local compute (Mac or work computer) runs the agent infrastructure
- Microsoft 365 sessions provide authenticated access to company data
- Local network carries the traffic
- Nothing leaves the building

## What Camfil Agents Could Do
Speculative — needs Christian Taylor input on actual workflow pain points:
- Read and summarize SharePoint documents on request
- Search Teams conversations for specific information
- Draft email responses based on context
- Track action items across meetings
- Generate reports from OneDrive data
- Automate repetitive workflow tasks specific to Camfil role

## Key Constraint
IT policies at Camfil are unknown. Some capabilities may require IT authorization (Graph API tokens, device enrollment). Browser automation path is least likely to require IT involvement. Start there.

## Status
Idea captured. Not yet:
- Scoped
- Scheduled
- Discussed with Alexander or MA
- Prioritized relative to Velorin core build

Raise with Christian Taylor when Velorin core architecture is stable enough to run parallel tracks.

---

[VELORIN.EOF]
