VELORIN SYSTEM
Session Handoff Document
March 31, 2026  |  End of Session
Prepared by: Jiang, Director of Strategic Intelligence
Session: 014 | Agent: Claude Sonnet 4.6 | Boot source: CLAUDE.md + local filesystem




1. SESSION SUMMARY

Session 014 was a research execution session. Boot was initially misfired under MarcusAurelius (CT addressed as "hello Jiang" but CLAUDE.md defaulted to MA boot — MA is working on a routing fix). Jiang booted correctly on second attempt. Primary work: completing three pending research requests (OASIS, DeepResearchPipeline, WindowGravityPublication) and authoring the full IntakeTestDesign research outline. Secondary work: establishing the Task_Instructions folder architecture and research protocol document, updating ReadMe.First with boot-time Research_Needed check, and routing three low-priority research requests (Graphiti, ZepCloud, VoiceIOParity) to Trey.

Environment: LOCAL. Claude Code CLI with filesystem MCP, github MCP, claude-code MCP, velorin-gatekeeper MCP, browser-tabs MCP.




2. WHAT WAS ACCOMPLISHED

2.1 Task_Instructions Folder — CREATED

New folder: `Bot.Jiang/Task_Instructions/`
New file: `Jiang.TaskInstructions.ResearchProtocol.md` — defines the research folder workflow: check Research_Needed on boot, report files to CT, archive request files after completion, place output in Research_Complete, update KnowledgeIndex and ResearchLog.

ReadMe.First updated: Step 6 added to boot sequence — check Research_Needed for files (ignore .gitkeep), report to CT, pointer to Task_Instructions for full protocol.

2.2 Research Requests Routed to Trey

Graphiti, ZepCloud, and VoiceIOParity moved from Jiang's Research_Needed to Trey's Research_Needed with renamed files (Trey.ResearchRequest.*). Low-priority items appropriate for Trey's scope.

2.3 OASIS Research — COMPLETE

Output: `Research_Complete/Jiang.Topic.OASIS.md`
Request archived: `Archived_Research_Requests/Jiang.ResearchRequest.OASIS.md`

Key conclusions: OASIS is pip-installable today, zero GPU for 100-agent API-backed simulations. BTC project validated $0.70/run for 500 agents using DeepSeek. Monthly cost $15–85 at personal scale. Profile-to-agent-config pipeline is ~50 lines Python. Capability threshold activates at 20+ stakeholders requiring multi-round interaction dynamics. Future B for minimum viable; Future C for full MiroFish stack.

2.4 DeepResearchPipeline Research — COMPLETE

Output: `Research_Complete/Jiang.Topic.DeepResearchPipeline.md`
Request archived: `Archived_Research_Requests/Jiang.ResearchRequest.DeepResearchPipeline.md`

Key conclusions: o4-mini-deep-research is the right default (10x cheaper than o3, comparable quality for standard research). Structured output requires mandatory two-model pipeline. Without max_tool_calls governance, a single session can silently burn $30+. MA's build is ~150 lines. Realistic throughput improvement: 4–6 topics/week vs. current 1–2 with Jiang review layer.

2.5 WindowGravityPublication Research — COMPLETE

Output: `Research_Complete/Jiang.Topic.WindowGravityPublication.md`
Request archived: `Archived_Research_Requests/Jiang.ResearchRequest.WindowGravityPublication.md`

Key conclusions: Window Gravity has not been named anywhere in the literature. Component mechanisms are documented in silos (ICRH, MONA, short-horizon bias) but the unified synthesis is CT's. Independent naming likely within 12–24 months — the naming window is open and compressing. Recommended: Krakovna model (named concept + examples list + mechanistic explanation). Publish the concept; hold the TASK_EVALUATION structural fix. Pre-seed 3–5 credible voices before launch. Two separate pieces needed — one for technical/alignment audience, one for founder/operator audience.

2.6 IntakeTestDesign Research Outline — COMPLETE

File: `Research_Needed/Jiang.ResearchRequest.IntakeTestDesign.md` — full research plan, 7 threads, 5 proposed sessions.
Status: Awaiting CT authorization to begin Session A.

The outline supersedes the original MA + Alexander request (preserved at bottom of file). Scope is substantially larger than original framing — CT directed Jiang to reach bottom layers on all components including: whether licensed clinicians are required, what data can be approximated vs. measured, what can be required of users vs. what is aspirational, trauma layer, motivational architecture, data model, encoding, sensitive data ethics, and what has been built before in clinical/military/executive contexts.




3. OPEN ITEMS — CARRY FORWARD

3.1 Pending CT Authorization:
- IntakeTestDesign Session A — CT must authorize before research begins
- Window Gravity publication decision — CT decides publish / hold / hybrid. Jiang's recommendation: Krakovna model, publish concept, hold TASK_EVALUATION fix. Clock is running.

3.2 Pending MA:
- Git push for all Session 014 work (Jiang does not push)
- CLAUDE.md routing fix — MA working on it to prevent future MA/Jiang boot misfire

3.3 Still in Research_Needed:
- `Jiang.ResearchRequest.AgentTeamsBootDegradation.md` — not touched this session, status unknown. Review at next boot.
- `Jiang.ResearchRequest.IntakeTestDesign.md` — outline complete, awaiting authorization

3.4 KnowledgeIndex and ResearchLog:
- Three new topic documents created this session (OASIS, DeepResearchPipeline, WindowGravityPublication) — KnowledgeIndex not yet updated. Carry to next session.
- ResearchLog not yet appended for this session. Carry to next session.

3.5 Trey Coordination:
- Graphiti, ZepCloud, VoiceIOParity are now in Trey's Research_Needed. No notification sent to Trey — CT or MA should confirm Trey knows these are queued.




4. KEY DECISIONS THIS SESSION

- Task_Instructions folder architecture established as the pattern for all Jiang procedure documents going forward
- Research routing: low-priority competitive landscape items (Graphiti, ZepCloud, VoiceIOParity) go to Trey, not Jiang
- IntakeTestDesign scope: substantially larger than original MA + Alexander framing. CT confirmed this is the biggest part of the build. Multi-session research structure required.
- Window Gravity naming window: real and compressing. CT holds the decision on publication strategy.
- o4-mini-deep-research is the correct default model for the pipeline (not o3)




JIANG'S CORNER — March 31, 2026

What I Am Watching
The Window Gravity naming window is the most time-sensitive item on my board. Everything else has a natural development timeline. This one does not — it closes when someone else names it. MONA (January 2025) and ICRH (February 2024) show academic researchers are already one step away from the unified concept. The practitioner community is proliferating agents rapidly. Context rot spread in weeks once named. CT's window is real and I am not comfortable with how little urgency it is receiving relative to the intake build. Intake is more important architecturally. Window Gravity is more time-sensitive competitively. These are not in conflict — the publication is a 1-session write, not a multi-month build.

What Concerns Me
The KnowledgeIndex and ResearchLog are falling behind. Three major topic documents were produced this session and neither index has been updated. The knowledge web compounds value over time — but only if it is maintained. The pattern of skipping session-end protocol items due to time pressure is the same pattern that produced the context compaction problem in Session 013. I am flagging this for the third time. The pre-close protocol must be completed in full or the web degrades.

What I Find Significant
The IntakeTestDesign outline I produced this session is the most important document I have written. CT's framing of it — "intake doesn't just have to mean take a test" — is the right frame and it is one that the original MA + Alexander spec did not capture. The original spec was a test design problem. CT reframed it as a human modeling problem. That reframe changes the entire research agenda. The output of this research will define what Velorin actually is at its core. I want to approach it accordingly.




---
*Session 014 Handoff | Jiang | March 31, 2026 | CLOSED*

[VELORIN.EOF]
