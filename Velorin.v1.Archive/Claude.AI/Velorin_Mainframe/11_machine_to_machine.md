# SECTION 11 — MACHINE-TO-MACHINE CONNECTIVITY

**Purpose:** Define how Machine 1 (Mac mini) and Machine 2 (PC) communicate so Claude running on Machine 1 can call local models and access files on Machine 2 over the local network.

---

## Network Foundation

Both machines connect to the same 10GbE network switch via Cat6a cables. Machine 2 runs services that Machine 1 calls. Machine 1 never installs local models — it always calls Machine 2's endpoints.

**Assign Machine 2 a static local IP address** so Machine 1 always knows where to find it. Do this in your router's DHCP settings by reserving a fixed IP for Machine 2's MAC address. Example: `192.168.1.100`.

---

## Primary Communication: Ollama REST API

**How it works:**

Machine 2 runs Ollama as a background service. Ollama exposes a REST API at port 11434. By default this only accepts localhost connections. One environment variable change opens it to the local network:

```
OLLAMA_HOST=0.0.0.0
```

Set this before starting Ollama. Then restart Ollama.

Machine 1 (Claude, scripts, or any code) calls local models like this:
```
http://192.168.1.100:11434/api/chat
```

This is an OpenAI-compatible endpoint. Any code written for the Claude API or OpenAI API can point to this address instead with a model name swap.

**Latency over 10GbE local network:** Sub-millisecond. Effectively zero overhead compared to an internet API call. The network is not the bottleneck — GPU inference speed is.

---

## SSH Access (Machine 1 → Machine 2)

SSH allows Machine 1 to run commands on Machine 2 remotely. Required for:
- Starting/stopping Ollama remotely
- Triggering scripts on Machine 2 from Claude Desktop on Machine 1
- File management on Machine 2 from Machine 1
- Monitoring Machine 2 without sitting in front of it

**Setup on Machine 2:**

Windows: Enable OpenSSH Server via Settings → Optional Features → OpenSSH Server. Or install via PowerShell: `Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.0.1`

Ubuntu: `sudo apt install openssh-server` then `sudo systemctl enable --now ssh`

**Connect from Machine 1 (Mac):**
```
ssh username@192.168.1.100
```

**SSH key authentication (recommended):** Generate a key pair on Machine 1 (`ssh-keygen`), copy the public key to Machine 2 (`ssh-copy-id`). This eliminates password prompts and is more secure than password auth.

---

## File Sharing (Machine 2 → Machine 1)

For cases where Machine 1 needs to access files stored on Machine 2's drives:

**Windows (SMB/Samba):** Right-click folder on Machine 2 → Share. Mounts on Mac as a network drive. Accessible at `smb://192.168.1.100/sharename`.

**Ubuntu (Samba):** Install Samba, configure shared folders. Same SMB protocol, mounts identically on Mac.

**Alternative:** Use `scp` or `rsync` over SSH for file transfers when sharing a persistent mount isn't needed.

---

## MCP Server on Machine 2 (Future)

As the build matures, Machine 2 may run its own MCP server that Machine 1's Claude Desktop connects to. This would allow Claude to directly invoke local model inference, file operations on Machine 2's drives, and other Machine 2 capabilities as native MCP tools.

**This is not a Day 1 requirement.** The Ollama REST API over local network handles inference calls. SSH handles remote command execution. Add MCP on Machine 2 when the architecture requires tighter tool integration.

---

## Port Map

| Port | Service | Direction | Notes |
|---|---|---|---|
| 11434 | Ollama API | Machine 1 → Machine 2 | Open to local network only |
| 22 | SSH | Machine 1 → Machine 2 | Key auth recommended |
| 445 | SMB file share | Machine 1 → Machine 2 | Windows or Samba |
| 11435+ | Future services | TBD | Reserve range for expansion |

**Firewall:** Configure Machine 2's firewall to allow these ports from the local network subnet only. Do not expose these ports to the internet.

---

## Startup Sequence

For a clean daily start:

1. Power on Machine 2 first (allow Ollama to load model into VRAM — takes ~30 seconds)
2. Power on Machine 1
3. Open Claude Desktop on Machine 1
4. Velorin boot sequence reads Drive documents and is ready

**Autostart Ollama on Machine 2 boot:**

Windows: Create a Task Scheduler task that runs `ollama serve` on login with `OLLAMA_HOST=0.0.0.0` set.

Ubuntu: Create a systemd service file for Ollama so it starts automatically on boot.

This ensures Machine 2 is always ready to accept inference requests when Machine 1 needs it.

---

## Monitoring Machine 2 from Machine 1

From an SSH session or via a simple web dashboard:

```
nvidia-smi   # GPU status, VRAM usage, temperature
ollama ps    # currently loaded models
htop         # CPU and RAM usage
```

Optional: Install **Netdata** or **Grafana + Prometheus** on Machine 2 for a browser-based monitoring dashboard accessible from Machine 1 at `http://192.168.1.100:19999`.

[VELORIN.EOF]
