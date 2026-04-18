# Cross-Platform Application-Layer Peer-to-Peer State and Input Synchronization Architecture

*Trey Research | Velorin App-Based Cross-Device Coordination*

## Executive Summary

The proposition to abandon a system-level Swift KVM bridge in favor of a cross-platform, peer-to-peer application mesh represents a valid architectural pivot that sidesteps legacy C++ protocol serialization. By moving synchronization logic into a cross-platform application shell, the architecture relies on modern decentralized transport layers, utilizing the Model Context Protocol alongside Conflict-Free Replicated Data Types for state consensus. The community has proven that combining a Rust-based backend framework with WebRTC Data Channels and libp2p routing provides sub-50ms latency for fluid hardware input injection across disparate OSes. However, the premise that an application-layer approach entirely bypasses OS friction contains a critical flaw; macOS 15 Sequoia enforces strict TCC boundaries on user-space applications identically to system daemons — the application shell must still negotiate hostile local network and accessibility gates.

---

## 1. The Architectural Pivot: Application Mesh vs. System KVM

### 1.1 Structural Analysis

**PRIOR:** The established baseline assumed that input injection and state synchronization required a native Swift application interacting directly with CGEventTap and raw TCP sockets. This path required porting the C++ Barrier protocol to maintain state, demanding exact replication of the wire protocol message format (32-bit integer payload length in network byte order followed by a 4-byte ASCII command string). Swift developers were forced to use Codable structs or UnsafeRawBufferPointer readers that strictly mirrored C++ byte alignment to prevent silent memory corruption. Furthermore, CGEventTap callbacks executed by the Core Foundation run loop triggered strict concurrency violations in Swift 5.10 and Swift 6 if the callback touched any @MainActor state without an explicit context switch, causing immediate application crashes.

**FOUND:** Shifting logic to the application layer allows the system to define its own proprietary wire protocol and state synchronization logic, entirely discarding legacy C++ Barrier/Synergy protocols. The application operates as a node in a peer-to-peer mesh rather than a strict client-server KVM bridge. In this model, the application assumes responsibility for discovering peers, negotiating transport security, serializing hardware events, and merging conflicting state changes from independent AI agents operating across the network. The community has demonstrated that application-layer mesh networks can achieve 30–50ms total latency required for natural KVM control by abandoning TCP in favor of UDP-based transports.

**UNRESOLVED:** The application-layer approach does not bypass the OS security perimeter regarding input injection. An application receiving a network payload containing a mouse coordinate must still translate that payload into a system-level hardware event. The friction is merely moved from the network transport layer to the local OS integration layer. On macOS, this still requires calling `CGEvent.post(tap:.cgSessionEventTap)`. The application shell wraps these system calls; it does not circumvent the security gates guarding them.

---

## 2. The Cross-Platform Application Shell

### 2.1 Evaluating Framework Candidates

**PRIOR:** Development was restricted to Swift and Xcode 16 to target macOS specifically, requiring entirely separate codebases for Windows or Linux extension.

**FOUND:** The community relies heavily on Tauri 2.0 for cross-platform applications requiring deep system access and low memory overhead. Electron relies on bundling a complete Chromium browser engine and Node.js runtime — base application sizes ranging from 120MB to 200MB and idle memory consumption frequently 150MB–400MB. For an application intended to run continuously in the background as a synchronization and input bridge, this memory footprint is prohibitive.

Tauri 2.0 utilizes the host OS's native web rendering engine (WKWebView on macOS, WebView2 on Windows, WebKitGTK on Linux) while employing a backend written entirely in Rust. This allows Tauri to compile to native binaries as small as 3MB–10MB, with idle memory usage typically 40MB–80MB. Tauri's Rust backend provides direct, memory-safe access to system APIs — critical for the KVM use case, as Rust crates can execute system-level mouse and keyboard injection without relying on Node.js IPC bindings. Tauri 2.0 officially supports iOS and Android, allowing the synchronization mesh to expand to mobile devices using the same core codebase.

Socket Runtime was evaluated as a secondary alternative emphasizing P2P networking capabilities out-of-the-box. However, Tauri 2.0 maintains a significant structural advantage due to Rust ecosystem maturity.

| Metric | Electron | Tauri 2.0 | Socket Runtime |
|---|---|---|---|
| Backend Language | Node.js (JavaScript/C++) | Rust | JavaScript/HTML/CSS |
| Renderer | Bundled Chromium | OS Native WebView | OS Native WebView |
| Idle Memory Footprint | 150MB–400MB | 40MB–80MB | Low |
| P2P Capability | Requires third-party libraries | Native Rust crates (libp2p) | Built-in P2P protocols |
| System Hardware Injection | High latency IPC overhead | Native Rust execution | Limited by JS bindings |

**UNRESOLVED:** The exact latency penalty incurred when bridging high-frequency mouse polling data across the Rust-to-JavaScript boundary remains a point of friction. Developers frequently report the necessity of bypassing the standard IPC bridge for continuous data streams, handling the network socket and OS injection entirely within the Rust backend.

---

## 3. The Transport Layer: Discovery and Low-Latency Streaming

### 3.1 Network Architecture: libp2p vs. WebRTC

**PRIOR:** The assumption dictated raw TCP or UDP sockets and Apple's Bonjour service for local network discovery.

**FOUND:** A dual-protocol approach is mandatory. libp2p handles decentralized discovery, peer routing, and state synchronization, while WebRTC Data Channels handle ultra-low latency streaming of mouse and keyboard coordinates.

libp2p is a highly modular P2P networking stack that removes the need for a centralized server to coordinate connections. It implements Multicast DNS (mDNS) to automatically discover other instances of the application on the same local subnet. Once peers are discovered, libp2p utilizes the GossipSub protocol for publish/subscribe routing. GossipSub v1.1 extensions introduce explicit peering agreements, allowing the application to specify a strict list of trusted peers to remain connected to, mitigating unauthorized local network intrusion risk.

**UNRESOLVED:** The fallback behavior when local network firewalls or aggressive symmetric NATs block WebRTC STUN host candidates is complex. Relying on external TURN servers routes local traffic out to the internet and back in, introducing significant latency that entirely defeats the purpose of local KVM control. The application must detect relayed connections and flag them as unsuitable for real-time input injection.

### 3.2 Ultra-Low Latency Injection via WebRTC Data Channels

WebRTC Data Channels operate using SCTP encapsulated over DTLS, further encapsulated in UDP packets. Because it utilizes UDP, WebRTC avoids the head-of-line blocking inherent to TCP. If a packet containing a mouse coordinate is lost, WebRTC does not stall the connection waiting for retransmission; it simply processes the next available coordinate. This protocol stack routinely achieves 30–50ms total latency, as evidenced by dedicated KVM hardware projects like PiKVM and JetKVM that exclusively utilize WebRTC for input streaming.

The libp2p specification includes a transport known as WebRTC Direct. Standard WebRTC requires a third-party signaling server to exchange SDP offers and answers. WebRTC Direct skips this handshake entirely by employing SDP munging, encoding the necessary cryptographic hashes and the server's TLS certificate fingerprint directly into the dialer's multiaddress. This allows two applications on a local network to establish a secure, encrypted WebRTC connection instantly without requiring an external internet connection or a signaling server.

---

## 4. State Synchronization: Conflict-Free Replicated Data Types

### 4.1 The Synchronization Problem

**PRIOR:** State synchronization was achieved by writing flat .md or .json files to a shared Google Drive directory, relying on a third-party desktop client to handle file syncing and conflict resolution.

**FOUND:** Real-time synchronization across an application mesh without a central database requires the implementation of Conflict-Free Replicated Data Types (CRDTs). Libraries such as Loro and SQLite-Sync provide the necessary mathematical guarantees to merge agent states seamlessly across a P2P network.

CRDTs are specialized data structures that allow multiple replicas of the same data to be updated independently and concurrently without requiring coordination protocols or distributed locks. When the devices eventually communicate over the libp2p GossipSub network, the CRDT algorithm guarantees that all replicas will converge to the exact same state, regardless of the order in which updates are received, due to the mathematical property of commutativity.

**UNRESOLVED:** Continuous, high-frequency CRDT updates generated by autonomous AI agents cause severe tombstone memory bloat over time. In operation-based CRDTs, every insertion and deletion must be tracked indefinitely to ensure that late-arriving updates from offline peers can be merged correctly. The mechanism for garbage-collecting deleted CRDT history across a decentralized mesh without centralized coordination remains an open computer science problem, often leading to unacceptable memory consumption in long-running agent systems.

### 4.2 Evaluating CRDT Implementations

**Loro:** A high-performance CRDT library written in Rust, specifically designed for local-first applications. Loro supports rich collaborative types, including text sequences, maps, and movable trees. Because the Tauri backend is written in Rust, Loro can be integrated directly into the application binary without requiring foreign function interfaces. Loro converts application state mutations into minimal change-sets (deltas) transmitted over the libp2p network to other devices. Loro also natively supports time-travel and versioning, allowing the system to inspect the exact state of an agent's memory at any prior point in time.

**SQLite-Sync:** For applications requiring structured relational data, SQLite-Sync extends standard SQLite databases with CRDT capabilities. It utilizes a "Block-Level Last-Write-Wins" algorithm, highly effective for synchronizing markdown files and structured AI agent memory. This allows agents to maintain memory, notes, or shared state in a standard SQLite file and sync across instances without requiring complex backend infrastructure.

---

## 5. Input Interception and Hardware Injection

### 5.1 Application-Layer Injection Mechanisms

**PRIOR:** Implementation relied on Swift 5.10 and direct interaction with the CGEventTap API on macOS, requiring careful management of the Core Foundation run loop to prevent concurrency crashes.

**FOUND:** Tauri 2.0 allows the frontend to capture user input natively through standard web events (mousemove, mousedown, keydown). These events are serialized into highly optimized binary payloads and transmitted via the established WebRTC Data Channel. On the receiving machine, the Tauri Rust backend utilizes cross-platform Rust crates to execute system-level injection:
- **macOS:** Interfaces with CoreGraphics framework to synthesize CGEvent objects via `CGEvent.post(tap:.cgSessionEventTap)` through safe Rust bindings.
- **Windows:** Executes calls to the SendInput API within user32.dll, passing hardware scan codes directly to the active window.
- **Linux:** Interfaces with X11 subsystem via XTestFakeKeyEvent or the uinput kernel module for Wayland compatibility.

**UNRESOLVED:** Keyboard layout and language-specific scan-code handling across differing operating systems remains a point of failure. Mapping a macOS Command key event to a Windows Control key event accurately, while accounting for regional keyboard layouts, requires extensive manual mapping dictionaries within the Rust application logic.

### 5.2 Optimizing the Input Pipeline

To guarantee 30–50ms target latency, the input pipeline must bypass standard framework overhead. Routing high-frequency mouse movement events from the Webview frontend through the Tauri IPC bridge to the Rust backend introduces unacceptable jitter. A highly optimized architecture establishes the WebRTC Data Channel connection directly within the Rust backend. The frontend captures the input, but rather than processing it through standard IPC, it writes the coordinate data to a shared memory buffer or utilizes a tightly packed binary protocol. The Rust backend continuously polls this buffer, ensuring the coordinates are transmitted over the UDP network immediately.

---

## 6. Operating System Friction: The macOS 15 Sequoia Security Boundary

### 6.1 The Persistent Local Network Bug

**PRIOR:** System daemons encountered severe desynchronization with macOS 15 Sequoia's Local Network TCC prompts, resulting in silent network drops.

**FOUND:** The Sequoia local network permission bug is not limited to background daemons; it aggressively affects standard user-space applications. As of macOS 15.3.1, the operating system frequently fails to persist Local Network authorizations across power cycles.

Starting with macOS 15, any application utilizing Bonjour (mDNS), unicast, or multicast connections must request explicit user permission and must declare the NSLocalNetworkUsageDescription key in its Info.plist. This directly impacts the libp2p discovery mechanism, as mDNS relies on local multicast routing. The system stores these permissions in its internal TCC database. However, extensive practitioner diagnostics reveal that the authorization grant frequently corrupts or desynchronizes. The system UI will display the toggle as "green/on" in System Settings -> Privacy & Security -> Local Network, but the underlying network extension daemon denies the socket connection. This results in a silent failure where the application believes it has network access but cannot discover peers, causing the P2P mesh to collapse.

**UNRESOLVED:** Apple has not deployed a definitive patch for the TCC database desynchronization. The requirement for manual user intervention remains a structural defect in the operating system that the application cannot programmatically override without exploiting kernel vulnerabilities. Furthermore, applications attempting to inject input must also negotiate the Accessibility and Input Monitoring TCC gates. Developers must use APIs such as `IOHIDCheckAccess(kIOHIDRequestTypeListenEvent)` to verify permissions. If the user denies the initial prompt, the application cannot re-trigger the dialogue; the user must manually navigate System Settings to grant access.

### 6.2 Validated Workarounds for the Application Mesh

The most reliable resolution involves programmatically or manually toggling the application's permission off and back on. Advanced deployments utilize an AppleScript executed via the macOS Shortcuts app at login to automate this toggle, forcing the TCC database to re-register the permission state.

Should local mDNS discovery remain blocked, the application must contain logic to temporarily fall back to an external STUN or TURN signaling server to establish the WebRTC connection. This routes traffic out to the internet and back in, introducing significant latency that degrades the KVM experience until the local network permission is restored, but prevents a total loss of agent coordination.

---

## 7. Integration into the Velorin Architecture

By moving from a localized filesystem approach to a P2P application mesh, the entire Velorin Brain becomes a distributed CRDT structure. When MarcusAurelius or Scribe updates a pointer rating or creates a new memory neuron, that markdown file is wrapped in a Loro CRDT operation and published to the libp2p GossipSub network.

This architecture allows CT to run Claude Code on the Mac Studio while simultaneously running a dashboard interface on the MacBook Air. The agents on both machines share the exact same state without requiring external synchronization scripts or encountering file-locking contention. The application shell handles the complexity of the network, allowing the agents to focus entirely on reasoning and execution.

---

## Conclusions

- **HIGH CONFIDENCE (95%):** Tauri 2.0 paired with a Rust backend represents the optimal framework for building a cross-platform KVM and state synchronization application. It provides the necessary native OS API access while maintaining a minimal memory footprint, significantly outperforming Electron in resource-constrained environments.
- **HIGH CONFIDENCE (90%):** The combination of libp2p for decentralized mesh discovery and GossipSub state routing, alongside WebRTC Data Channels for raw input streaming via SCTP over UDP, provides the exact network architecture required for instantaneous, serverless device communication.
- **MODERATE CONFIDENCE (80%):** Integrating a CRDT library such as Loro into the application backend will successfully resolve real-time AI agent memory and state synchronization across multiple devices without requiring centralized databases, though long-term tombstone memory bloat requires active monitoring.
- **CONFIRMED:** The macOS 15 Sequoia Local Network TCC permission bug persists aggressively in user-space applications. The application cannot completely bypass OS friction; it must implement robust diagnostic logging and guide the user through toggle-reset or cache-clearing workarounds when the operating system silently drops local socket connections.

## Works cited
1. Velorin KVM Bridge Research Plan
2. GitHub - hyperspaceai/agi: distributed AGI system
3. Latency in KVM systems - PiKVM Handbook
4. How do I listen for keypresses on Linux and Mac - Reddit
5. GitHub - tauri-apps/tauri
6. Tauri vs Electron in 2026: Which Should You Use for Desktop Apps? - Rustify
7. Tauri vs. Electron: performance, bundle size, and the real trade-offs - Hopp
8. Tauri 2.0 | Tauri
9. Built a desktop app with Tauri 2.0 - impressions after 6 months - Reddit
10. Socket Runtime aims to drop the cloud as a dependency - The Register
11. A new cross-platform solution for Web developers - Hacker News
12. WebRTC - libp2p
13. WebRTC with js-libp2p
14. libp2p - A modular network stack
15. libp2p implementation in Rust - GitHub
16. Built a P2P encrypted messaging app with Rust + Tauri - Reddit
17. libp2p-gossipsub - Lib.rs
18. specs/pubsub/gossipsub/gossipsub-v1.1.md - GitHub
19. Developing low latency peer to peer connection - Reddit
20. Using WebRTC data channels - MDN
21. Data channels in Elixir WebRTC - Software Mansion
22. WebRTC for Ultra-Low Latency Live Streaming - Norsk Video
23. libwertc vs libdatachannel for low latency remote desktop - Reddit
24. JetKVM - Control any computer remotely
25. js-libp2p/packages/transport-webrtc/README.md - GitHub
26. sqliteai/sqlite-sync - GitHub
27. Loro – Reimagine state management with CRDTs
28. Conflict-free replicated data type - Wikipedia
29. Beyond Offline-First: The Nightmare of Data Synchronization & CRDTs - Medium
30. Implementing CRDTs: Why Most Developers Give Up on Real-Time Editing - Velt
31. Loro Mirror: Make UI State Collaborative by Mirroring to CRDTs
32. Kalmat/PyWinCtl - GitHub
33. catid/kvm: Low-Bandwidth IP KVM using Raspberry Pi 4 - GitHub
34. Sequioa local network authorization doesn't stick - Apple Support Community
35. Local Network access on macOS 15 Sequoia - Rogue Research
36. TN3179: Understanding local network privacy - Apple Developer Documentation
37. How to check the status of the 'Input Monitoring' permission - Stack Overflow
38. Something has changed in Sequoia in regards to local network privacy settings - Reddit
39. [MEDIUM] Fix Local Network permissions in MacOS App #952 - GitHub
