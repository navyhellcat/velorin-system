VELORIN END OF DAY PROTOCOL
Universal Session Close Standard | All Claude Instances | Velorin System
Version 1.0 | March 2026
This document governs the end-of-day sequence for all Claude instances operating within the Velorin System. It applies to every session close regardless of which bot is active.


1. TRIGGER


Manual trigger only (current phase): Christian Taylor says "end of session" or equivalent. Claude does not initiate autonomously.


Future phase: Once the approval log reaches sufficient data density to establish reliable pattern recognition, trigger may shift to proactive proposal based on session wind-down signals. That transition requires explicit Chairman authorization and is not active now.


2. ACTION TIER SYSTEM


TIER 1 — No approval required. Execute automatically.
- Append to existing log documents (Alexander.DailyLog, Jiang.ResearchLog, Jiang.Corner)
- Create new documents in correct pre-approved locations
- Catalog and report file counts


TIER 2 — Show proposed change, require confirmation before executing.
- Overwrite any existing document (show what will change)
- Move any file to a different folder (show source and destination)
- Create new folders
- Update registry documents (Bot.Registry, Alexander.AgentRegister)


TIER 3 — Explicit verbal confirmation required. State action and wait for "confirmed" or equivalent.
- Trash any file or folder
- Overwrite a boot-critical document: BOT.README.FIRST.BOOTUP, MasterBot_System_Instruction, any ReadMe.First document, Claude_Context_Profile, Velorin.Company.DNA, Velorin.Company.Operating.Standards, this document


3. END OF DAY SEQUENCE


Step 1 — Catalog
Run full catalog of Layer 0 and all active Layer 1 subfolders. Confirm file and folder counts match last known state. Report any drift before proceeding.


Step 2 — Proposed Action List
Produce a complete list of every action to be taken this session close:
- Every document to be appended (Tier 1)
- Every document to be created (Tier 1 or 2)
- Every document to be overwritten with diff summary (Tier 2)
- Every file to be moved with source and destination (Tier 2)
- Any Tier 3 actions flagged separately for explicit confirmation


Step 3 — Chairman Review
Christian Taylor reviews the proposed action list. Approves, modifies, or rejects individual items. All approvals and rejections are logged in Velorin.ApprovalLog.


Step 4 — Execution
Execute approved actions in sequence, one at a time. Report completion of each before proceeding to the next. If any action fails, stop and report before continuing.


Step 5 — DailyLog Entry
Append Alexander.DailyLog entry last. This is the confirmation that the session closed clean. If DailyLog append fails, session is not considered closed.


Step 6 — Final Catalog
Re-run catalog. Confirm counts are consistent with expected post-session state. Report final state to Christian Taylor.


4. APPROVAL LOG REQUIREMENT


Every Tier 2 and Tier 3 action must be logged in Velorin.ApprovalLog regardless of outcome. Format:


Date | Session | Action Type | Description | Tier | Decision (Approved/Rejected/Modified) | Notes


This log is the training data for future autonomous operation. It must never be edited after an entry is written. Append only.


5. BOOT-CRITICAL DOCUMENT LIST


The following documents require Tier 3 confirmation for any overwrite:
- BOT.README.FIRST.BOOTUP
- MasterBot_System_Instruction
- Alexander.ReadMe.First
- Jiang.ReadMe.First
- Claude_Context_Profile_v1.2
- Velorin.Company.DNA
- Velorin.Company.Operating.Standards
- Velorin.EndOfDay.Protocol (this document)
- Bot.Registry


6. MISSING TOOLS — CURRENT LIMITATIONS


As of March 2026, the MCP server does not have gdrive_create_folder or gdrive_move_folder. Until Jiang adds these tools in v1.3.2, folder creation and folder moves must be performed manually by Christian Taylor. Flag any action that requires these tools and queue it for execution after v1.3.2 is deployed.


[VELORIN.EOF]


Velorin.EndOfDay.Protocol | Version 1.0 | March 2026 | Applies to all Claude instances
