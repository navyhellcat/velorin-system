# Architectural Failure of SMB Event Propagation vs TCP Socket Reliability

---

## Scenario 1: Shared Network Folder (SMB) + Watchdog

```mermaid
flowchart LR
    A["**Mac A**\nWrites file to shared folder"] -->|SMB| B["**Mac B Disk**\nFile modified on disk layer"]
    B -->|fsevents Fail ❌| C["**Python Watchdog**\nNo interrupt.\nForced into polling loop."]

    style C fill:#fdd,stroke:#c00
```

---

## Scenario 2: Direct TCP Socket Connection

```mermaid
flowchart LR
    A["**Mac A**\nSends payload via Python"] -->|TCP Port 5000| B["**Python Daemon**\nReceives directly in memory"]
    B -->|Direct Push ✓| C["**pbcopy**\nExecuted instantly\nwith payload"]

    style C fill:#dfd,stroke:#080
```

---

## Why

macOS `fsevents` APIs rely on local disk interrupts. When a file is written over an **SMB** network mount, the receiving kernel does not generate an interrupt, forcing the watchdog into an inefficient polling loop.

A direct **TCP socket** bypasses the filesystem entirely, writing straight to the target's memory and triggering the native `pbcopy` binary instantly.

---

## Data Sources

- [Watchdog — GitHub](https://github.com/gorakhargosh/watchdog)
- [FSEvents — Medium](https://medium.com)
- [Parcel — GitHub](https://github.com/nicowillis/parcel)

[VELORIN.EOF]
