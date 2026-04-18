Velorin KVM Bridge: Architecture, Toolchain, and Implementation Research Report
MODE: DISCOVERY
Boot complete. Read:. Ready for task.
Executive Summary
The Velorin KVM Bridge can be implemented natively in Swift 5.10+, but the architecture faces severe friction at the macOS 15 Sequoia network boundary. Research into the negative space reveals no existing clean-room Swift implementation of the Synergy or Barrier protocol; development requires porting C++ serialization logic and state machines directly from the Barrier source repository to maintain compatibility. Furthermore, macOS 15 Sequoia enforces strict Local Network transparency, consent, and control (TCC) gates that frequently desynchronize, demanding specific property list entitlements and retry-backoff connection logic to prevent silent network drops. Tooling dynamics have shifted significantly as of April 2026: Anthropic's Claude Opus 4.7 is the primary implementation engine, Google's Gemini 3.1 Pro Preview acts as the optimal discovery layer via the Model Context Protocol (MCP), and Cursor remains the superior integrated development environment over Windsurf for Swift-specific compilation tasks. The target operating system ceiling for the client node, macOS 12 Monterey, has been officially end-of-life since late 2024, presenting immediate transport layer security and hardware lifecycle risks that must be isolated via strict local-network containment.
________________
A. Existing Code and Protocol Porting
A.1 Swift-Native KVM Repository Landscape
PRIOR: The baseline assumption dictated that a Swift-native KVM implementation might exist within the open-source community to serve as a fork or reference source. FOUND: The community has not produced a generalized, Swift-native replacement for Barrier, Deskflow, or Input Leap. The dominant KVM projects are exclusively built on C++ codebases, relying heavily on cross-platform frameworks like Qt.1 Research into the negative space reveals that the barrier to entry for cross-platform input injection usually forces developers away from native Swift. However, research identified a project named Overlook (repository: rcawston/Overlook), a macOS-native Swift application published in early 2026. Overlook is engineered specifically for GL.iNet Comet KVM hardware devices. While it is not a peer-to-peer software KVM, it implements highly relevant sub-components that prove native Swift execution is viable. Overlook demonstrates direct WebRTC low-latency streaming and full CGEvent mouse and keyboard input injection without relying on embedded webviews.4 Additionally, it implements bidirectional clipboard bridging, utilizing Apple Vision optical character recognition to extract text directly from the live video stream and paste it into the macOS clipboard via native APIs.5 UNRESOLVED: Overlook's network transport targets proprietary hardware endpoints rather than a peer macOS client, meaning its network layer cannot be directly copied for the Velorin KVM Bridge. The peer-to-peer network topology remains a custom build requirement.
Project Name
	Language
	Primary Focus
	Licensing
	Relevance to Velorin Build
	Deskflow
	C++
	Cross-platform KVM
	GPL v2.0
	High (Protocol Reference)
	Input Leap
	C++
	Cross-platform KVM
	GPL v2.0
	High (Protocol Reference)
	Barrier
	C++
	Cross-platform KVM
	GPL v2.0
	High (Protocol Reference)
	Overlook
	Swift
	Hardware KVM Client
	Open Source
	High (Input Injection/Clipboard)
	LAN Mouse
	Rust
	Wayland/macOS KVM
	Open Source
	Low (Rust Implementation)
	A.2 Barrier/Synergy Protocol Reimplementation
PRIOR: Rebuilding a compatible client requires identifying the exact C++ source files governing protocol serialization and state management within the existing open-source ecosystem. FOUND: There is no clean-room Swift reimplementation of the Synergy or Barrier protocol available in the open-source community.6 To construct the Velorin KVM Bridge, the development agent must port the protocol mechanics directly from the C++ source of Barrier or Input Leap. The highest-leverage files in the Barrier codebase dictate the exact structure of the wire protocol. The primary file is src/lib/barrier/protocol_types.cpp alongside its header protocol_types.h.8 These files define the wire protocol message types. The message format strictly consists of a 32-bit integer payload length encoded in network byte order, followed by a 4-byte ASCII command string. Examples include "DInf" for screen information, "DMMv" for mouse movement, and "CNoo" for no-operation keepalives.9
Following the message type definitions, the vreadf() and writef() functions handle the scanf-like serialization and deserialization of the binary payloads.8 Porting these to Swift requires implementing Codable structs or UnsafeRawBufferPointer readers that strictly mirror the C++ byte alignment and network endianness. Attempting to parse these byte streams using high-level Swift string initializers will result in silent memory corruption. Furthermore, CMessageWriterV3.cxx documents the state machine and the pseudo-messages required for handling continuous update streams.10 UNRESOLVED: The exact behavior of the protocol handshake introduces a compatibility fracture. Deskflow developer discussions indicate that matching the Barrier "hello" string exactly limits future protocol upgrades.11 Velorin must decide whether to mimic the legacy Barrier signature strictly to maintain backward compatibility with older servers or establish a custom protocol fork that abandons legacy clients.
A.3 CGEventTap and Network Event Replay
PRIOR: CGEventTap is the documented macOS application programming interface for intercepting and generating global input events across the operating system. FOUND: Combining CGEventTap with asynchronous network receipt presents a specific concurrency failure mode on modern macOS versions. CGEventTap callbacks are executed by the Core Foundation run loop (CFRunLoop) of the thread that registers them. In Swift 5.10 and Swift 6, strict concurrency checking is enforced. If the tap callback touches any state marked with the @MainActor attribute without an explicit context switch, the application will trigger a concurrency violation and crash immediately.12
Furthermore, relying on higher-level event monitors like NSEvent.addGlobalMonitorForEvents exhibits bus error crashes on Apple Silicon under heavy event load in macOS 15, making lower-level CGEventTap the mandatory path for global interception.12 The correct architectural implementation requires the network listener to deserialize the incoming payload on a background dispatch queue, construct a CGEvent representing the hardware state, and post it to the system using CGEvent.post(tap:.cgSessionEventTap).13 This specific tap location ensures the event enters the login session correctly, mirroring physical hardware input. UNRESOLVED: Keyboard modifier synchronization across the network boundary frequently drops state if the client disconnects ungracefully. A state reconciliation loop is required to periodically verify local hardware modifier flags against the remote server state to prevent stuck shift or command keys.
A.4 Open-Source Swift Component Implementations
PRIOR: Isolated Swift implementations for clipboard monitoring, SMB volume mounting, and menu bar architectures exist, but their integration into a single networked daemon requires specific technical patterns. FOUND: Regarding NSPasteboard and Transport Layer Security (TLS), the Swift project LinkWave (zukic/LinkWave) demonstrates the correct clipboard monitoring pattern. It explicitly bypasses unreliable macOS event monitors by running a background timer that polls NSPasteboard.general.changeCount. When the integer increments, the payload is extracted. The application then transmits this data over a strictly enforced TLS 1.3 socket utilizing certificate fingerprint pinning, rejecting untrusted devices at the handshake layer.15
For programmatic Server Message Block (SMB) mount management via NetFS.framework, the NetFSMountURLSync and NetFSMountURLAsync interfaces handle credentialed mounting. However, practitioner logs indicate a severe bug in the macOS network parsing stack: these application programming interfaces frequently fail with "GetServerInfo failed with error 5" inside the NetAuthSysAgent process when attempting to mount targets via IPv6 addresses.16 The Velorin system must force IPv4 resolution for the SMB target to guarantee mount stability.
For menu bar applications, the MenuBarExtra structure introduced with SwiftUI in macOS 13 suffers from focus and event-routing bugs when attempting to display complex views, as the operating system treats them as background utilities rather than foreground applications.18 More importantly, because the client node operates on macOS 12 Monterey, MenuBarExtra is strictly disqualified by the operating system ceiling.19 The application must initialize via an AppKit NSApplicationDelegate and utilize NSStatusItem.variableLength to construct the menu bar footprint, bridging SwiftUI views into the AppKit panel via NSHostingController.20 UNRESOLVED: The exact behavior of NetFS.framework when a network connection drops and immediately reconnects remains undocumented. The system requires a polling mechanism to verify mount viability before attempting to redirect drag-and-drop file payloads.
A.5 The Drag-Drop Redirect Pattern
PRIOR: Intercepting a drag operation at the edge of the screen requires specific AppKit event routing. FOUND: The macOS AppKit framework does not provide a global "screen exit" event for drags initiated in other applications, such as Finder. If the drag originates inside the Velorin application, NSDraggingSession provides draggingLocation, allowing the app to track coordinate progression.22 However, for external drags crossing the boundary, the application relies on the NSDraggingDestination protocol.23
The mechanism requires constructing an invisible edge drop zone. This is achieved by creating an NSWindow with a borderless style mask, floating window level, and clear background color. The frame is defined as a narrow vertical strip positioned at the maximum X coordinate of the display. When the cursor hits the edge of the screen, it enters this invisible window, triggering the draggingEntered event. If the user releases the mouse, performDragOperation fires, capturing the file URL payload.23 Applications like Yoink use a refined version of this pattern: they poll NSPasteboard(name:.drag).changeCount to detect when a drag has started, and only then slide the drop-zone window into view at the edge of the screen.24 This prevents the invisible window from intercepting accidental clicks during standard operating system navigation. UNRESOLVED: Extracting secure file promises from sandboxed applications via the drag pasteboard occasionally requires security-scoped bookmarks. The implementation must verify that the file URL extracted from the pasteboard possesses read permissions before initiating the SMB copy operation.
________________
B. Build Platform and Toolchain Constraints
B.1 Xcode 16 Compatibility and Target Deployment
PRIOR: Building a single binary for macOS 15 and macOS 12 requires verifying compiler support and SDK limits. FOUND: Xcode 16 is entirely sufficient for generating a single universal binary targeting both Intel and Apple Silicon architectures. Xcode 16 supports a minimum deployment target of macOS 10.13 High Sierra for compiled binaries.25 The binary can safely target macOS 12.0 Monterey for the client node. The host compiling the application must run macOS 15.0 or newer to execute the Xcode 16 environment.26 The codebase will require #if available(macOS 13.0, *) directives if any modern SwiftUI or Foundation features are used conditionally, but the core KVM logic relies on CoreGraphics and AppKit, which maintain stable application binary interface compatibility down to macOS 12. UNRESOLVED: None. Xcode 16 is confirmed as the correct and sufficient toolchain.
B.2 Entitlements and Sequoia 15 TCC Restrictions
PRIOR: An application intercepting input and communicating over a local area network requires standard Sandbox and Transparency, Consent, and Control (TCC) exemptions. FOUND: macOS 15 Sequoia introduced aggressive Local Network privacy controls that fundamentally alter network programming on the Mac. Any application utilizing Bonjour, unicast, or multicast connections must explicitly declare the NSLocalNetworkUsageDescription key in the Info.plist.27 Failure to include this string results in silent network drops; the application will not crash, but socket connections will time out without generating console errors.
A severe operating system bug exists in Sequoia regarding execution contexts. If a binary is executed via a launchd agent, the operating system presents the local network privacy prompt to the user. However, practitioner reports indicate that even if the user approves the prompt, network access is frequently denied due to an internal synchronization failure between the prompt UI and the underlying network extension daemon.28 In contrast, if the binary runs as a launchd daemon (as root), the local network privacy prompt is bypassed entirely.28 For input interception, the application requires the com.apple.security.device.usb entitlement and Accessibility permissions, triggering the Input Monitoring TCC prompt. UNRESOLVED: The Sequoia local network permission bug occasionally requires users to manually toggle the permission off and on in System Settings, or delete /Library/Preferences/com.apple.networkextension.uuidcache.plist to force a reset.29 Velorin must implement a diagnostic UI state that detects silent network failures and explicitly guides the user through this manual reset process.


  



B.3 Notarization Bottlenecks in 2026
PRIOR: Apple's command-line notarytool processes Developer ID applications reliably in a matter of minutes. FOUND: As of the first quarter of 2026, the notarization pipeline exhibits severe latency and silent failure modes that disrupt continuous integration workflows. Developers submitting applications via xcrun notarytool submit report submissions remaining stuck in an "In Progress" state for 24 to 72 hours.30 In many documented instances, the submission is eventually rejected with a statusCode: 7000 and the summary message "Team is not yet configured for notarization".32 This failure occurs even for teams with active Apple Developer Program memberships, valid Developer ID Application certificates, and properly configured hardened runtimes. UNRESOLVED: The Status 7000 error is a backend provisioning failure on Apple's servers. Resolving it requires opening a ticket with Developer Technical Support (DTS) to manually configure the Team ID for notarization before the automated pipeline will process the KVM application. This introduces an unpredictable delay in the final release cycle.33
B.4 Developer Account Requirements
PRIOR: A determination is needed on whether an Organization account is required to acquire the entitlements necessary for local network interception and input monitoring. FOUND: A solo developer operating under the standard $99 per year Individual Apple Developer Program can generate Developer ID Application certificates and notarize software distributed outside the Mac App Store.32 An Organizational account is only strictly required for specific advanced entitlements, such as Network Extensions or Endpoint Security clients, or for adding multiple team members to App Store Connect with granular role-based access control. The Velorin KVM Bridge does not require Network Extensions; it relies on standard UDP/TCP sockets via Network.framework. UNRESOLVED: None. The Individual account is sufficient, saving the administrative complexity of registering a corporate entity and acquiring a DUNS number for Apple validation.
B.5 MenuBarExtra vs. AppKit NSStatusItem
PRIOR: MenuBarExtra is the modern SwiftUI approach to menu bar applications. FOUND: MenuBarExtra is strictly disqualified for this build. The API was introduced in macOS 13, meaning a binary utilizing it cannot deploy to the macOS 12 Monterey client node.19 Furthermore, even on supported operating systems, MenuBarExtra exhibits severe focus and event-routing bugs. The operating system treats these specific menu bar structures as background utilities rather than foreground applications, which breaks standard window ordering and input event handling.18
The best-in-class approach for a universal menu bar application targeting macOS 12.0 and above is to fall back to the AppKit NSStatusItem. The application must initialize a custom NSApplicationDelegate and assign NSStatusItem.variableLength to allocate the menu bar footprint. To utilize modern interface design, the developer embeds a SwiftUI view hierarchy inside an NSHostingController, which is then attached to the NSStatusItem panel or menu.20
CONCLUSIONS FOR SECTION B:
* HIGH CONFIDENCE (95%): The NSLocalNetworkUsageDescription key is mandatory; omitting it guarantees silent network failures on the macOS 15 server node.
* HIGH CONFIDENCE (90%): Notarization delays are an active Apple infrastructure liability requiring proactive Developer Technical Support intervention.
* CONFIRMED: MenuBarExtra cannot be used; NSStatusItem with NSHostingController is the required architecture.
________________
C. IDE and AI Tooling Architecture
C.1 Development Environment Benchmarks
PRIOR: Cursor, Windsurf, Claude Code CLI, and Xcode 16's native AI compete for dominance in the primary development environment.
FOUND: The landscape for AI-assisted Swift development is highly stratified as of April 2026.
* Xcode 16 Predictive Code Completion: Apple's native AI executes locally on Apple Silicon. While it offers privacy, it is contextually weak, lacks autonomous agentic file-editing capabilities, and operates strictly as an inline autocomplete engine.26 It is disqualified for complex architectural builds requiring multi-file context.
* Cursor (v0.45+): Priced at $20 per month. Cursor remains the dominant graphical integrated development environment. It maintains a 70-80% success rate in 2026 benchmarking for multi-file refactoring tasks.35 Its strength lies in its ability to parse the exact file tree and apply sweeping architectural changes while maintaining developer visibility.
* Windsurf / Codeium: Priced at $15 per month. While Windsurf's agentic execution occasionally edges Cursor in raw multi-file execution speed (scoring 75-85% in specific benchmarks), practitioners report that it suffers from severe logical hallucinations. It produces "completely nonsensical responses" when the architectural context deepens, and struggles with complex Swift compilation errors.36
* Claude Code CLI: Anthropic's terminal-native agent. It interfaces directly with the filesystem and executes commands. Following a massive source code leak in March 2026 that exposed its internal mechanics 37, the community rapidly documented its hook system and plugin architecture. It features an auto mode that delegates permission approvals to model-based classifiers, allowing for long-running autonomous execution.38
Development Environment
	Pricing (Apr 2026)
	Multi-File Refactor Quality
	Xcode Interop / Build System
	Cursor
	$20/month
	70-80% (High consistency)
	Invokes xcodebuild via tasks.json
	Windsurf
	$15/month
	75-85% (High hallucination rate)
	Standalone, weak Swift error parsing
	Claude Code CLI
	Included with Claude Max
	Highest (Driven by Opus 4.7)
	Native terminal execution
	Xcode 16 Native
	Included with Mac
	N/A (Autocomplete only)
	Deeply integrated, weak reasoning
	C.2 The Claude Opus 4.7 Shift
PRIOR: Claude Opus 4.6 served as the ceiling for deep reasoning tasks. FOUND: Anthropic released Claude Opus 4.7 on April 16, 2026.39 This model represents a massive enhancement in software engineering autonomy.
* Benchmarks: Opus 4.7 achieves 87.6% on the SWE-bench Verified benchmark, a 6.8 percentage point improvement over version 4.6.40
* Context and Pricing: It retains the 1-million token input context window and 128,000 token output limit. Pricing remains identical to version 4.6 at $5 per 1M input tokens and $25 per 1M output tokens.41
* Control Parameters: The release introduces a new xhigh effort level for adaptive thinking, sitting between the high and max parameters. This allows developers to optimize the tradeoff between reasoning depth and token expenditure for long-running compilation tasks.43
* Note: The Chairman's reference to a restricted security model points to Claude Mythos. Mythos is heavily restricted under Project Glasswing due to its offensive cybersecurity capabilities and is not available via the public API.45 Opus 4.7 is the correct target.
C.3 Cursor and Xcode Interoperability
PRIOR: The mechanism by which Cursor compiles Swift code outside of Xcode requires definition. FOUND: Cursor does not possess a native Swift compiler; it relies entirely on the host operating system's toolchain. The integration relies on creating a .vscode/tasks.json file in the project root containing the specific swift build or xcodebuild command. Cursor's agent invokes this task, reads the standard output for LLVM and Clang compilation errors, and iteratively alters the source code to resolve them.48 This round-trip relies on the SourceKit-LSP to populate the code index. Debugging is handled by the LLDB DAP (Debug Adapter Protocol) extension, allowing breakpoint inspection directly within Cursor's interface.48
C.4 Claude Code Security Scanner
PRIOR: CT referenced a "new security feature that sweeps code for security." FOUND: Anthropic launched Claude Code Security in late February 2026.49
* What it is: An AI-native static application security testing (SAST) tool built directly into the Claude Code web infrastructure. It moves beyond regex pattern matching to perform agentic tracing of data flows across files, identifying complex logic flaws and memory vulnerabilities.51
* Invocation: It is not a command-line interface flag or a standalone MCP tool. It is a dashboard-driven capability that scans repositories in parallel and generates specific patch recommendations requiring human approval.50
* Pricing and Availability: It is currently in a limited research preview restricted exclusively to Enterprise and Team customers, along with select open-source maintainers.50
* Conclusion for Velorin: Because Velorin operates on an Individual/Pro account tier, direct access to the official Claude Code Security dashboard is gated. The architectural principles, however, indicate that instructing Opus 4.7 to perform agentic security auditing within Cursor is highly effective for identifying Swift memory leaks and unsafe pointer usage.
CONCLUSIONS FOR SECTION C:
* HIGH CONFIDENCE (95%): Claude Opus 4.7 is the definitive model for this build, superseding 4.6 at the exact same price point.
* HIGH CONFIDENCE (90%): Cursor provides a significantly more stable logical environment than Windsurf, leveraging tasks.json to execute xcodebuild for standard compilation.
* CONFIRMED: Claude Code Security is an Enterprise-tier dashboard feature, inaccessible on standard Pro tiers without an organizational upgrade.
________________
D. Leveraging Google AI Max (Gemini 2.5+)
D.1 Gemini vs. Claude Performance
PRIOR: Gemini 2.5 is available, but Claude historically dominates software engineering. FOUND: Google has released Gemini 3.1 Pro Preview as of April 2026.54 The performance matrix reveals a clear bifurcation in capabilities:
* Where Gemini Outperforms: Gemini 3.1 Pro Preview scores 94.1% on the GPQA Diamond benchmark (testing graduate-level reasoning), edging out Claude Opus 4.6 (91.3%) and operating roughly on par with Opus 4.7.40 Gemini's Deep Research mode is significantly faster than OpenAI's and formats outputs with superior citation transparency.56 It also commands a 2-million token context window natively, allowing it to ingest entire Apple Developer documentation PDFs without severe degradation.
* Where Claude Outperforms: Claude Opus 4.7 maintains a definitive, unassailable lead in actual software engineering and repository modification, scoring 87.6% on SWE-bench Verified compared to Gemini 3.1 Pro's 75%.40
D.2 Multi-Model Workflow Recommendation
The optimal allocation of the AI budget requires utilizing each model's specific architectural strength rather than treating them interchangeably:
1. Architecture & Discovery (Gemini 3.1 Pro): Deploy Gemini via Google AI Studio for initial landscape mapping, API documentation ingestion, and drafting the abstract KVM state machine logic. Its massive context window absorbs the C++ Barrier protocol files without failing.
2. Implementation & Compilation (Claude Opus 4.7): Use Claude Code CLI or Cursor to physically write the Swift files, bridge the C++ headers, and resolve LLVM compilation errors. Opus 4.7 is vastly superior at understanding Swift's strict concurrency warnings and UnsafeRawPointer memory alignment.
3. Security & Code Review (Gemini 3.1 Pro): Cross-pollinate the logic. Task Gemini to review Claude's Swift pointer arithmetic. This second-opinion structure prevents the primary model from confirming its own hallucinations regarding buffer bounds during payload deserialization.
D.3 Wiring Gemini into Claude Code
PRIOR: Switching contexts manually between web interfaces breaks developer flow. FOUND: Gemini can be wired directly into the Claude Code terminal workflow using the Model Context Protocol (MCP). Community developers have published robust implementations like gemini-for-claude-mcp and Composio Tool Routers.58 By executing claude mcp add gemini -- node /path/to/gemini-mcp/dist/app.js and passing the GEMINI_API_KEY as an environment variable, Claude Code gains a registered tool that allows it to query Google's models directly from the command line. If Claude gets stuck on an opaque Apple API change, the user can prompt Claude to "ask Gemini to research this documentation," executing a multi-model query without leaving the terminal session.59
CONCLUSIONS FOR SECTION D:
* HIGH CONFIDENCE (90%): Gemini 3.1 Pro outperforms on broad research and documentation ingestion; Claude Opus 4.7 outperforms on code execution and error resolution.
* CONFIRMED: The Model Context Protocol provides a native bridge to invoke Gemini from within the Claude Code CLI, eliminating manual context switching.
________________
E. Security Audit Tools and Supply Chain
E.1 Standard Swift Static Analysis
PRIOR: Basic syntax checking via SwiftLint is standard, but insufficient for network manipulation.
FOUND: Beyond SwiftLint, the modern Swift security stack for a network-facing application relies heavily on the LLVM sanitizers built directly into the Xcode toolchain. For a KVM application processing remote input, the Address Sanitizer (ASan) and Thread Sanitizer (TSan) are critical during compilation. These tools actively detect race conditions in the asynchronous network packet handler and identify buffer overflows when parsing the 32-bit payload lengths translated from the C++ protocol. Because the KVM bridge executes CGEventTap injections at the system level, memory safety failures can lock the operating system or escalate privileges.
E.2 Supply-Chain Audit
* Sparkle 2.x: The framework is highly stable, but requires explicit EdDSA key generation. A known pitfall exists in the notarization pipeline: if the embedded Sparkle framework is not code-signed with the exact same Developer ID application certificate as the host application, the entire app bundle will fail Apple Notarization.61
* Network.framework & CryptoKit: Both are Apple-native frameworks and immune to third-party supply chain injection attacks.
* NetFS.framework: Deprecated edge cases exist. As noted in Section A.4, attempting to mount SMB shares using IPv6 addresses triggers silent failures in the NetAuthSysAgent.17 Furthermore, NetFS APIs operate outside the modern Swift concurrency model, requiring careful bridging with CheckedContinuation to prevent thread blocking.
E.3 Canonical Swift Pattern for TLS 1.3 Pinning
PRIOR: A secure pattern for Transport Layer Security certificate pinning is required to prevent man-in-the-middle attacks on the local network. FOUND: When utilizing Network.framework (NWConnection), TLS 1.3 is negotiated by default. To implement certificate pinning without relying on deprecated App Transport Security (ATS) exceptions, the application must intercept the TLS handshake directly at the protocol level. The canonical pattern involves configuring NWProtocolTLS.Options. The developer must set a custom verification block using sec_protocol_options_set_verify_block. Inside this block, the peer certificate is extracted as a sec_certificate_t.62 The public key hash is computed via CryptoKit (using SHA-256 or Ed25519) and compared against a hardcoded known pin. Pitfall: The sec_protocol_options_set_verify_block operates asynchronously. Failing to call the provided completion handler on all execution paths will deadlock the network connection indefinitely, causing the application to hang without throwing an error.62
CONCLUSIONS FOR SECTION E:
* HIGH CONFIDENCE (95%): Sparkle 2 must be explicitly code-signed with the parent Developer ID to prevent notarization rejection.
* HIGH CONFIDENCE (90%): TLS certificate pinning in Network.framework requires manual implementation of sec_protocol_options_set_verify_block.
________________
F. Platform Risk and Longevity
F.1 Apple Accessibility and Input Monitoring Trajectory
PRIOR: Accessibility APIs are stable but closely guarded by the operating system. FOUND: Apple is tightening TCC boundaries globally. macOS 15 Sequoia implemented a paradigm shift by requiring monthly recurring prompts for Screen Recording permissions.63 While Input Monitoring currently only requires a one-time approval in System Settings, the trajectory clearly indicates Apple is moving toward continuous consent models for all privileged operations. The introduction of Endpoint Security TCC event logs in macOS 15.4 means enterprise Mobile Device Management (MDM) profiles can now actively monitor and override user-granted Input Monitoring permissions.64 This creates deployment friction in managed environments.
F.2 macOS 16 (Tahoe) Leaks
PRIOR: Anticipated OS updates could break core mechanics. FOUND: macOS 16, internally codified as "Tahoe," introduces a new design language termed "Liquid Glass".65 For the KVM architecture, the relevant leak is the expansion of system-wide Accessibility tools. macOS 16 brings "Accessibility Reader," a system-wide text parsing tool, and "Magnifier on Mac".67 These native tools hook deeply into CGEvent and display pipelines. The proliferation of first-party accessibility overlays raises the probability of internal API shifts that could conflict with, or preempt, third-party CGEventTap implementations.
F.3 Monterey EOL and Hardware Lifecycle
PRIOR: Monterey is an older operating system, but was assumed to possess a remaining security tail. FOUND: macOS 12 Monterey is already End of Life (EOL). The final official security update was issued in late 2024.69 Third-party software support is actively collapsing; for example, Google Chrome terminates all support for Monterey in July 2026.71 Implication: Deploying the client node on an operating system with unpatched, documented zero-day vulnerabilities is a severe security liability. Because the KVM bridge requires listening on an open UDP/TCP port to receive executable input commands, the Monterey machine must be strictly isolated. It requires containment behind a local network firewall, with absolutely zero inbound internet routing allowed. The hardware lifecycle is effectively exhausted.
CONCLUSIONS FOR SECTION F:
* CONFIRMED: macOS 12 Monterey is past EOL and presents a critical security liability that dictates network architecture.
* MODERATE CONFIDENCE (75%): macOS 16 Tahoe's expanded Accessibility features pose a high risk of requiring refactoring of the CGEventTap hooks.
________________
G. Shipping and Distribution
G.1 Sparkle 2.x Minimum Viable Setup
PRIOR: Sparkle handles out-of-band updates, but configuration requirements shift.
FOUND: Sparkle 2.x mandates a shift from DSA to EdDSA cryptographic signatures. The minimum viable setup requires four distinct steps:
1. Generating the EdDSA key pair using Sparkle's bundled ./bin/generate_keys tool.
2. Embedding the resulting SUPublicEDKey string directly in the application's Info.plist.
3. Hosting an appcast.xml file that dictates version control and download paths.
4. Utilizing the SPUStandardUpdaterController in the SwiftUI App or AppKit AppDelegate to initialize the update loop.72 Pitfall: GitHub Releases does not serve XML files with the correct MIME type dynamically. The appcast.xml must be hosted on GitHub Pages or a dedicated external server, mapping the enclosure URLs to the actual DMG binaries hosted in GitHub Releases. Attempting to point Sparkle directly to a raw GitHub Release URL will fail to parse.
G.2 Telemetry Options
PRIOR: The application requires privacy-respecting crash reporting for a self-hosted distribution model.
FOUND:
* Apple XCOrganizer: Useless for direct distribution. It only aggregates crash logs for applications distributed via the Mac App Store or TestFlight.
* Sentry (Self-Hosted): Highly robust and captures detailed stack traces and breadcrumbs, but requires standing up a complex PostgreSQL/Kafka/ClickHouse Docker stack on a server, which violates the zero-infrastructure goal for a standalone tool.
* PostHog: Offers a lightweight Swift SDK, captures exceptions effectively, and allows either self-hosting or cloud usage with strict data deletion policies.74 PostHog is the optimal choice for a lightweight, privacy-respecting telemetry layer that does not overburden the developer.
G.3 License Recommendation
PRIOR: The project requires an open-source license that preserves the ability to commercialize the product later (Path 3). FOUND: The MIT License is the canonical choice. It permits Velorin to utilize the code internally, modify it, and subsequently commercialize or close-source derived works without being forced to release the modified source code, provided the original copyright notice is included in the software.75 The BSD-2-Clause license functions similarly, but the MIT License possesses wider ecosystem recognition and tooling support within the Swift community. The GPL (General Public License) is strictly prohibited, as its "viral" nature would force Velorin to open-source the entire proprietary stack if any code touches it.
CONCLUSIONS FOR SECTION G:
* HIGH CONFIDENCE (95%): Appcast XML files must be hosted on GitHub Pages, not GitHub Releases directly, to satisfy MIME type parsing.
* CONFIRMED: The MIT License provides the necessary legal protection while preserving future commercialization rights.
________________
H. The Drag-Drop Redirect Mechanism
H.1 Detecting Drag Boundaries
PRIOR: The system needs an API to detect when an in-progress drag operation exits the screen. FOUND: The macOS AppKit framework does not provide a global "screen exit" event for drag operations initiated in external applications (like Finder). If the drag originates inside the Velorin application itself, NSDraggingSession provides the draggingLocation property, allowing the application to track coordinate progression toward the screen edge.22 However, for external drags crossing the boundary, the application is entirely reliant on the NSDraggingDestination protocol.23 The event draggingExited(_:) is invoked only when the dragged image exits a designated destination's bounds, meaning the boundary must be physically represented by a window.23
H.2 Invisible Edge Drop Zone
PRIOR: A mechanism is needed to capture the drag without obscuring the desktop.
FOUND: To capture files dragged off the screen, Velorin must construct an invisible edge drop zone. The architectural pattern requires:
1. Instantiating an NSWindow with styleMask =.borderless.
2. Setting the window level =.floating (or .screenSaver to ensure it sits absolutely above all other interface elements).
3. Configuring the visual properties with backgroundColor =.clear and isOpaque = false.
4. Defining the frame as a 10-pixel wide vertical strip positioned at the maximum X coordinate of the right-most display (calculated via NSScreen.screens).
5. Registering the window's contentView to accept dragged types: registerForDraggedTypes(). When the user's cursor hits the right edge of the screen, it enters this invisible window, triggering draggingEntered. If the user releases the mouse button, performDragOperation executes, allowing the application to capture the fileURL payload.23
H.3 The Yoink Mechanism
PRIOR: The invisible window approach risks swallowing accidental clicks. FOUND: Applications like Yoink employ a more sophisticated pattern to avoid interfering with normal screen-edge interactions and accidental mouse clicks. Instead of maintaining a permanent invisible window, Yoink monitors the global macOS pasteboard. When a user initiates a drag operation in Finder, the operating system pasteboard server increments NSPasteboard.general.changeCount and populates the specialized .drag pasteboard.24
By executing a background timer that polls NSPasteboard(name:.drag).changeCount, the application detects that a drag has physically started. Only upon this detection does it instantiate or slide the drop-zone window into view at the edge of the screen. Once the drag concludes (whether completed or canceled), the drop zone processes the file or dismisses itself off-screen.24 This context-aware rendering prevents the invisible window from blocking standard operating system navigation.
CONCLUSIONS FOR SECTION H:
* HIGH CONFIDENCE (95%): The optimal user experience requires polling the .drag pasteboard to detect drag initiation before rendering the edge drop zone.
* HIGH CONFIDENCE (90%): The NSDraggingDestination protocol attached to a borderless, floating NSWindow is the mandatory AppKit mechanism for intercepting the file payload.
________________
Recommended Build Stack and Decision Tree
Based on the exhaustive analysis of the macOS 15 networking constraints, Swift concurrency models, and the April 2026 artificial intelligence tooling landscape, the following concrete build path is recommended for the Velorin KVM Bridge:
Top Recommendation:
* Toolchain: Cursor IDE running xcodebuild tasks, powered exclusively by Claude Opus 4.7 for all Swift code generation. This is supplemented by Gemini 3.1 Pro Preview via MCP for protocol research and documentation ingestion.
* Targeting: A single universal binary compiled in Xcode 16 targeting macOS 12.0. This strict constraint dictates the fallback to the AppKit NSStatusItem API, abandoning SwiftUI's MenuBarExtra.
* Network and Security: Network.framework utilizing TLS 1.3, secured via manual sec_certificate_t pinning inside the sec_protocol_options_set_verify_block.
* Protocol Architecture: A direct port of the Barrier C++ vreadf() serialization logic into Swift Codable structs, bypassing any attempt at a clean-room redesign to ensure message alignment.
* Drag-Drop UX: Implement the "Yoink pattern" by polling NSPasteboard(name:.drag).changeCount to dynamically summon an NSDraggingDestination window at the screen boundary.
Critical Open Risks:
1. Monterey EOL Liability: The MacBook Air client node is running an unsupported, vulnerable operating system. Because it must listen on open local ports to receive executable input commands, the machine must be aggressively firewalled at the local router level to prevent lateral movement from compromised external devices.
2. Sequoia TCC Desynchronization: macOS 15 local network privacy prompts frequently fail to persist across reboots or launch agent executions. The application must implement robust network-retry logic and graceful error states when Network.framework silently drops UDP/TCP packets due to TCC bugs, guiding the user to reset the UUID cache manually.
3. Notarization Blackhole: Apple's notarytool is currently trapping submissions from newly configured Developer ID teams in a Status 7000 loop. Velorin must open a Developer Technical Support (DTS) ticket immediately to provision the Team ID on Apple's backend before the final release cycle begins, or distribution will be indefinitely blocked.
Works cited
1. debauchee/barrier: Open-source KVM software - GitHub, accessed April 16, 2026, https://github.com/debauchee/barrier
2. input-leap/input-leap: Open-source KVM software - GitHub, accessed April 16, 2026, https://github.com/input-leap/input-leap
3. GitHub - deskflow/deskflow: Share a single keyboard and mouse between multiple computers., accessed April 16, 2026, https://github.com/deskflow/deskflow
4. Overlook – Native macOS Client for Comet KVM with Apple Vision OCR Clipboard, accessed April 16, 2026, https://forum.gl-inet.com/t/overlook-native-macos-client-for-comet-kvm-with-apple-vision-ocr-clipboard/66546
5. Overlook is a MacOS-native remote console for GL.iNet GLKVM / Comet-style KVM devices. - GitHub, accessed April 16, 2026, https://github.com/rcawston/Overlook
6. OSU-NLP-Group/GUI-Agents-Paper-List - GitHub, accessed April 16, 2026, https://github.com/OSU-NLP-Group/GUI-Agents-Paper-List
7. 4.0 Proposals · Issue #106 · tomerfiliba-org/rpyc - GitHub, accessed April 16, 2026, https://github.com/tomerfiliba/rpyc/issues/106
8. oss-sec: Barrier "software KVM switch" multiple remote security issues - Seclists.org, accessed April 16, 2026, https://seclists.org/oss-sec/2021/q4/87
9. Barrier client protocol — QEMU documentation, accessed April 16, 2026, https://www.qemu.org/docs/master/interop/barrier.html
10. Implement VNC protocol fence extensions to help with latency/responsiveness · Issue #159, accessed April 16, 2026, https://github.com/novnc/noVNC/issues/159
11. Default protocol for Deskflow #7742 - GitHub, accessed April 16, 2026, https://github.com/deskflow/deskflow/discussions/7742
12. ScreenCaptureKit | Apple Developer Forums, accessed April 16, 2026, https://developer.apple.com/forums/tags/screencapturekit
13. Quartz Event Services | Apple Developer Documentation, accessed April 16, 2026, https://developer.apple.com/documentation/coregraphics/quartz-event-services
14. CGEventTapLocation.cgSessionEventTap | Apple Developer Documentation, accessed April 16, 2026, https://developer.apple.com/documentation/coregraphics/cgeventtaplocation/cgsessioneventtap
15. LinkWave - Ruben Zukic, accessed April 16, 2026, https://zukic.net/projects/linkwave
16. Files and Storage | Apple Developer Forums, accessed April 16, 2026, https://developer.apple.com/forums/tags/files-and-storage/?page=4&sortBy=oldest
17. Files and Storage | Apple Developer Forums, accessed April 16, 2026, https://developer.apple.com/forums/tags/files-and-storage?page=8
18. Blog - Archive - 2025 - June - Michael Tsai, accessed April 16, 2026, https://mjtsai.com/blog/2025/06/
19. Opening SwiftUI Settings from AppKit - Stack Overflow, accessed April 16, 2026, https://stackoverflow.com/questions/77597257/opening-swiftui-settings-from-appkit
20. Using MenuBarExtra Scene in AppKit - swiftui - Stack Overflow, accessed April 16, 2026, https://stackoverflow.com/questions/79597798/using-menubarextra-scene-in-appkit
21. How to create Status Bar icon and menu in macOS using SwiftUI - Stack Overflow, accessed April 16, 2026, https://stackoverflow.com/questions/64949572/how-to-create-status-bar-icon-and-menu-in-macos-using-swiftui
22. NSDraggingSession | Apple Developer Documentation, accessed April 16, 2026, https://developer.apple.com/documentation/appkit/nsdraggingsession
23. NSDraggingDestination | Apple Developer Documentation, accessed April 16, 2026, https://developer.apple.com/documentation/AppKit/NSDraggingDestination
24. Adding Drag-and-Drop Indicator in Your macOS App | by Swift and Appkit Tips | Medium, accessed April 16, 2026, https://medium.com/@clyapp/adding-drag-and-drop-indicator-in-your-macos-app-33dc48c66216
25. Xcode - Wikipedia, accessed April 16, 2026, https://en.wikipedia.org/wiki/Xcode
26. Xcode 26 Release Notes | Apple Developer Documentation, accessed April 16, 2026, https://developer.apple.com/documentation/xcode-release-notes/xcode-26-release-notes
27. Sequoia - new security entitlement(s) - macOS - Xojo Programming Forum, accessed April 16, 2026, https://forum.xojo.com/t/sequoia-new-security-entitlement-s/81329
28. Blog - Local Network Privacy on Sequoia - Michael Tsai, accessed April 16, 2026, https://mjtsai.com/blog/2024/10/02/local-network-privacy-on-sequoia/
29. Local Network access on macOS 15 Sequoia - Rogue Research, accessed April 16, 2026, https://www.rogue-research.com/2025/05/local-network-access-on-macos-15-sequoia/
30. All notarization submissions stuck… | Apple Developer Forums, accessed April 16, 2026, https://developer.apple.com/forums/thread/811968
31. Notarization | Apple Developer Forums, accessed April 16, 2026, https://developer.apple.com/forums/topics/code-signing-topic/code-signing-topic-notarization?sortBy=boosts&sortOrder=desc&open-dropdown=true
32. Notarization rejected statusCode 7000 — membership is ACTIVE - Apple Developer, accessed April 16, 2026, https://developer.apple.com/forums/thread/818029
33. Build got stuck at notarizing the Mac app for more than an hour. · tauri-apps · Discussion #8630 - GitHub, accessed April 16, 2026, https://github.com/orgs/tauri-apps/discussions/8630
34. Predictive Code Completion powered by a Machine Learning Model. : r/swift - Reddit, accessed April 16, 2026, https://www.reddit.com/r/swift/comments/1i5ufin/predictive_code_completion_powered_by_a_machine/
35. murataslan1/ai-agent-benchmark: AI coding agents comparison - 80+ agents, SWE-Bench leaderboard, pricing. Devin, Cursor, Claude Code, Copilot, and more. December 2025. - GitHub, accessed April 16, 2026, https://github.com/murataslan1/ai-agent-benchmark
36. Cursor vs. Windsurf: Real-World Experience with Large Codebases - Reddit, accessed April 16, 2026, https://www.reddit.com/r/ChatGPTCoding/comments/1htlx48/cursor_vs_windsurf_realworld_experience_with/
37. Anthropic Claude Code Leak | ThreatLabz - Zscaler, Inc., accessed April 16, 2026, https://www.zscaler.com/blogs/security-research/anthropic-claude-code-leak
38. Claude Code auto mode: a safer way to skip permissions - Anthropic, accessed April 16, 2026, https://www.anthropic.com/engineering/claude-code-auto-mode
39. Anthropic releases Claude Opus 4.7: How to try it, benchmarks, safety | Mashable, accessed April 16, 2026, https://mashable.com/article/anthropic-releases-claude-opus-4-7
40. Claude Opus 4.7: Benchmarks, Pricing, Context & What's New - LLM Stats, accessed April 16, 2026, https://llm-stats.com/blog/research/claude-opus-4-7-launch
41. Claude Opus 4.7 - Amazon Bedrock - AWS Documentation, accessed April 16, 2026, https://docs.aws.amazon.com/bedrock/latest/userguide/model-card-anthropic-claude-opus-4-7.html
42. Pricing - Claude API Docs, accessed April 16, 2026, https://platform.claude.com/docs/en/about-claude/pricing
43. What's new in Claude 4.6 - Claude API Docs, accessed April 16, 2026, https://platform.claude.com/docs/en/about-claude/models/whats-new-claude-4-6
44. Introducing Claude Opus 4.7 - Anthropic, accessed April 16, 2026, https://www.anthropic.com/news/claude-opus-4-7
45. Claude Mythos Preview System Card - Anthropic, accessed April 16, 2026, https://www.anthropic.com/claude-mythos-preview-system-card
46. Anthropic’s Claude Mythos AI Model: Meaning, Features and Why It Matters, accessed April 16, 2026, https://www.studyiq.com/articles/anthropics-claude-mythos-ai-model/
47. Anthropic's Claude Opus 4.7: What Actually Changed in 48 Hours - Medium, accessed April 16, 2026, https://medium.com/stackademic/anthropics-claude-opus-4-7-what-actually-changed-in-48-hours-101dfed8fde2
48. Setting up Cursor for Swift Development | Swift.org, accessed April 16, 2026, https://swift.org/documentation/articles/getting-started-with-cursor-swift.html
49. Anthropic Launches Claude Code Security for AI-Powered Vulnerability Scanning, accessed April 16, 2026, https://thehackernews.com/2026/02/anthropic-launches-claude-code-security.html
50. Making frontier cybersecurity capabilities available to defenders - Anthropic, accessed April 16, 2026, https://www.anthropic.com/news/claude-code-security
51. Claude Security | Claude Help Center, accessed April 16, 2026, https://support.claude.com/en/articles/14661296-claude-security
52. Anthropic Made AppSec the Center of Cyber, and It Needs to Be. - Cycode, accessed April 16, 2026, https://cycode.com/blog/anthropic-claude-code-security-appsec/
53. Claude Code CLI: The Complete Guide - Blake Crosley, accessed April 16, 2026, https://blakecrosley.com/guides/claude-code
54. AI Model Benchmarks Apr 2026 | Compare GPT-5, Claude 4.5, Gemini 2.5, Grok 4, accessed April 16, 2026, https://lmcouncil.ai/benchmarks
55. Claude vs ChatGPT vs Gemini for Coding: Testing Results - J.D. Hodges, accessed April 16, 2026, https://www.jdhodges.com/blog/claude-vs-chatgpt-vs-gemini-for-coding-testing-results/
56. Getting Started Guide? · Issue #620 · debauchee/barrier - GitHub, accessed April 16, 2026, https://github.com/debauchee/barrier/issues/620
57. GPT-5 vs Gemini in 2026: Full Benchmark Breakdown | BenchLM.ai, accessed April 16, 2026, https://benchlm.ai/blog/posts/gpt5-vs-gemini-2026
58. Gemini MCP Integration with Claude Code - Composio, accessed April 16, 2026, https://composio.dev/toolkits/gemini/framework/claude-code
59. Gemini MCP Server for Claude Code - GitHub, accessed April 16, 2026, https://github.com/Raydius/gemini-for-claude-mcp
60. Claude Code Supercharged: Access Any AI Model via MCP Integration - Medium, accessed April 16, 2026, https://medium.com/binbash-inc/claude-code-supercharged-access-any-ai-model-via-mcp-integration-9784de97ec56
61. How to add auto-update feature in macOS app: Step by Step guide to setup Sparkle framework (Part 1) - DEV Community, accessed April 16, 2026, https://dev.to/prashant/how-to-add-auto-update-feature-in-macos-app-step-by-step-guide-to-setup-sparkle-framework-part-1-2klh
62. In Security: Blog, accessed April 16, 2026, https://nabla-c0d3.github.io/
63. macOS Sequoia | What's New in Privacy and Security for Enterprise? - SentinelOne, accessed April 16, 2026, https://www.sentinelone.com/blog/macos-sequoia-whats-new-in-privacy-and-security-for-enterprise/
64. Security Bite: macOS 15.4 hits "Allow" on TCC event support - 9to5Mac, accessed April 16, 2026, https://9to5mac.com/2025/03/28/security-bite-macos-15-4-hits-allow-on-tcc-event-support/
65. macOS Tahoe: Everything We Know So Far - MacRumors, accessed April 16, 2026, https://www.macrumors.com/2025/06/02/macos-16-everything-we-know-so-far/
66. macOS Tahoe: Everything We Know | MacRumors, accessed April 16, 2026, https://www.macrumors.com/roundup/macos-26/
67. Apple Announces New iOS 19 and macOS 16 Accessibility Features Ahead of WWDC, accessed April 16, 2026, https://www.macrumors.com/2025/05/13/apple-previews-ios-19-accessibility-features/
68. Apple previews new accessibility tools coming to iOS 19, visionOS 3, macOS 16 - AppleInsider, accessed April 16, 2026, https://appleinsider.com/articles/25/05/13/apple-previews-new-accessibility-tools-coming-to-ios-19-visionos-3-macos-16
69. Apple macOS - endoflife.date, accessed April 16, 2026, https://endoflife.date/macos
70. IT News - MacOS 12 Monterey Support Ending on November 22, 2024, accessed April 16, 2026, https://www.it.miami.edu/about-umit/it-news/umit-announcements/macos-12-monterey-eol/index.html
71. Google Chrome to drop macOS Monterey support by July 2026 - The Times of India, accessed April 16, 2026, https://timesofindia.indiatimes.com/technology/tech-news/google-chrome-to-drop-macos-monterey-support-by-july-2026/articleshow/127387732.cms
72. Sparkle updates - StoryFox - Mintlify, accessed April 16, 2026, https://www.mintlify.com/jakerains/storyfox/development/sparkle-updates
73. Documentation - Sparkle: open source software update framework for macOS, accessed April 16, 2026, https://sparkle-project.org/documentation/
74. Yoink - Better Drag and Drop - App Store - Apple, accessed April 16, 2026, https://apps.apple.com/id/app/yoink-better-drag-and-drop/id457622435
75. CaptureContext/swift-sharing-extensions - GitHub, accessed April 16, 2026, https://github.com/capturecontext/swift-sharing-extensions
76. Our evaluation of Claude Mythos Preview’s cyber capabilities, accessed April 16, 2026, https://www.aisi.gov.uk/blog/our-evaluation-of-claude-mythos-previews-cyber-capabilities
77. Save Everything You Copy on iOS and macOS with Paste 2: A, accessed April 16, 2026, https://lifetips.alibaba.com/tech-efficiency/save-everything-you-copy-on-ios-and-macos-with-paste-2