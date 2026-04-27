# SECTION 2 — MACHINE 2: HARDWARE (LOCAL AI SERVER / GAMING RIG)

**Purpose:** Runs local AI models, stores proprietary data and model weights, handles gaming via secondary GPU, runs orchestration scripts 24/7. Connected to Machine 1 over local network.

---

## Primary GPU

**Recommended:** NVIDIA RTX 4090
**VRAM:** 24GB GDDR6X
**Memory bandwidth:** 1,008 GB/s
**Performance:** ~128 tok/s on 8B models, ~52 tok/s on 70B Q4 (fits in 24GB at aggressive quantization)
**Gaming:** 4K at 100+ FPS in most titles
**TDP:** 450W
**Price:** ~$1,599–$2,000

**Budget alternative:** NVIDIA RTX 3090 (used, verified condition)
- Same 24GB VRAM — loads identical model sizes
- ~80% of 4090 inference speed
- Memory bandwidth (936 GB/s) actually exceeds the RTX 4080 Super (717 GB/s)
- Price: ~$700–$900 used
- Risk: no warranty; verify not from mining rig before purchase

**Do not buy:** RTX 4080 Super. It costs ~$999 with only 20GB VRAM — dominated on value by a used 3090 and on performance by the 4090.

**VRAM determines which models load fully into GPU. If model exceeds VRAM, it overflows to system RAM and runs 10–20x slower. 24GB is the correct tier for this architecture.**

---

## Secondary GPU (Owned — GTX 1070 Ti)

**Role:** Secondary display card only. Drives monitors 3 and 4. Handles light gaming on secondary display if needed.

**What it cannot do:** Run in parallel with the primary GPU for AI inference. SLI is dead and was never supported for AI workloads. The 1070 Ti's 8GB VRAM is insufficient for any useful local model.

**Install:** Second PCIe slot. Connect displays 3 and 4 to its outputs. Primary GPU handles all compute.

---

## CPU

**Recommended:** AMD Ryzen 9 9950X3D (if available) or AMD Ryzen 9 7950X3D
**Socket:** AM5
**Cores:** 16 cores / 32 threads
**Architecture:** Zen 5 (9950X3D) or Zen 4 (7950X3D)
**Feature:** AMD 3D V-Cache — significantly improves gaming performance and cache-sensitive AI workloads
**TDP:** ~120W (power-capped to protect V-Cache die)
**Price:** 9950X3D ~$600–700 | 7950X3D ~$400–500

**Why AMD over Intel:** Intel 13th/14th gen had documented instability issues. AM5 has confirmed long-term support roadmap through at least 2028. AMD dominates in gaming benchmarks with X3D chips. Community consensus strongly favors AMD for AI + gaming hybrid builds.

**Board compatibility note:** Avoid ASRock motherboards with X3D CPUs until socket-burn reports are fully resolved. Use ASUS, MSI, or Gigabyte.

---

## Motherboard

**Recommended:** ASUS ProArt X870E-Creator WiFi
**Chipset:** X870E (AM5)
**Price:** ~$450–550

Key specs:
- Dual PCIe 5.0 x16 slots (drops to x8/x8 with both GPUs populated — acceptable for inference)
- 4x M.2 NVMe slots (2x PCIe 5.0, 2x PCIe 4.0) — no lane conflicts with dual GPU
- 10GbE + 2.5GbE onboard — critical for fast local network
- USB4 (40 Gbps) x2
- Wi-Fi 7
- DDR5 up to 8000 MT/s

**Why this board:** 10GbE is native (eliminates separate NIC), 4 M.2 slots eliminates storage vs GPU lane conflicts, proven in dual-GPU AI builds.

**Budget alternative:** MSI MPG X670E Carbon WiFi (~$300–400) + separate 10GbE NIC (~$60). Same functional result, slightly more complex.

**Do not use B650 boards for this build.** They drop the second GPU slot to x4, which is insufficient.

---

## RAM

**Recommended:** 64GB DDR5-6000 (2x 32GB kit)
**Speed:** DDR5-6000 CL30
**Brand options:** G.Skill Trident Z5 RGB, Corsair Dominator Titanium, Kingston Fury Beast
**Price:** ~$150–200 for a 64GB kit

**Why 64GB:** Model orchestration, preprocessing pipelines, OS overhead, and gaming all compete for system RAM. 64GB ensures the GPU is never waiting for data. If a 70B model overflows VRAM, system RAM is the fallback — more RAM = more usable overflow space. The AI hardware consensus is 64GB as the minimum serious AI workstation configuration.

**Why DDR5-6000:** Sweet spot for AM5. Going above 6000 MT/s produces diminishing returns. Going below reduces memory bandwidth meaningfully. Enable EXPO profile in BIOS after installation.

---

## Storage

### Drive 1 — OS and Active Files
**Recommended:** Samsung 990 Pro 2TB (with heatsink)
**Interface:** PCIe 4.0 M.2 NVMe
**Speed:** 7,450 MB/s read / 6,900 MB/s write
**Price:** ~$165
**Use:** Windows 11 / Ubuntu dual boot, applications, active project files, orchestration scripts

### Drive 2 — Model Weights and AI Files
**Recommended:** WD Black SN850X 4TB
**Interface:** PCIe 4.0 M.2 NVMe
**Speed:** 7,300 MB/s read / 6,600 MB/s write
**Price:** ~$280
**Use:** Local model weight files (.gguf), Ollama model cache, Velorin file architecture, GitHub repos

**Why SN850X for model storage:** 4TB in a single drive keeps model library organized in one location. Model loading speed from NVMe to VRAM is fast enough that drive speed is not the bottleneck — capacity and organization matter more here.

### Drive 3 — Archive and Backup
**Recommended:** 4TB–8TB HDD (Seagate Barracuda or WD Blue)
**Interface:** SATA
**Price:** ~$80–120
**Use:** Long-term archives, backup copies of model weights, large dataset storage

**Note:** Requires SATA port on motherboard and a SATA cable. All three drives populate different slots — no bandwidth conflicts on the ProArt X870E.

---

## PSU

**Recommended:** Seasonic Vertex GX-1200W (ATX 3.0, 80+ Gold)
**Price:** ~$180–220
**Warranty:** 12 years

**Why 1200W:** RTX 4090 (450W) + Ryzen 9 9950X3D (120W) + GTX 1070 Ti (150W) + motherboard, fans, drives (~150W) = ~870W at full load. 1200W provides meaningful headroom for transient spikes (the 4090 can spike well above its rated TDP for milliseconds). Running a PSU at 70–80% of rated capacity improves efficiency and longevity.

**ATX 3.0 requirement:** The RTX 4090 uses a 12VHPWR connector. ATX 3.0 PSUs include this natively, avoiding the adapter cables that ship with the GPU (which have a documented bending/burning risk if not managed carefully).

**Alternatives:** Corsair RM1200e (ATX 3.0, 80+ Gold, 10-year warranty) at similar price. Either is correct.

**If using RTX 3090 instead of 4090:** 1000W is sufficient, but 1200W remains a clean choice.

---

## Case

**Recommended:** Fractal Design Meshify 2 XL or NZXT H9 Flow
**Form factor:** Full Tower ATX
**Price:** ~$140–200

Requirements for this build:
- Minimum 8 expansion slots (dual 3-slot GPU cards need room)
- Strong airflow — dual high-end GPUs generate significant heat
- 360mm AIO radiator support for CPU cooling
- Full ATX motherboard support

**Fractal Meshify 2 XL:** Exceptional airflow via dust-filtered mesh front, spacious interior for dual GPUs, supports 420mm front radiator, no RGB, pure function-focused design. Community-validated as one of the best thermal performers for high-load builds.

**NZXT H9 Flow:** Dual-chamber design separates PSU/cables from components, panoramic glass panels, strong airflow, strong community reputation for dual-GPU AI builds.

**Both are correct choices.** Meshify 2 XL for maximum airflow and function. H9 Flow for cleaner aesthetic with comparable thermals.

---

## CPU Cooler

**Recommended:** 360mm AIO liquid cooler
**Options:** Arctic Liquid Freezer III 360, Corsair iCUE H150i Elite, NZXT Kraken 360
**Price:** ~$100–150

**Why 360mm AIO:** The 9950X3D/7950X3D runs at 120W TDP but benefits from headroom for sustained all-core workloads. A 360mm radiator provides comfortable thermal margin. Air cooling is viable (Noctua NH-D15 at ~$100) but a 360mm AIO is the cleaner choice for a dual-GPU build where case airflow is already being managed around GPU heat.

---

## Case Fans

**Recommended:** 3x intake (front) + 2x exhaust (top/rear) minimum
**Brand:** Noctua NF-A12x25 or Arctic P12 PWM
**Price:** ~$15–30 per fan

Enable positive pressure (slightly more intake than exhaust) to minimize dust accumulation on drives and motherboard.

---

## Thermal Paste

**Any quality brand:** Noctua NT-H1, Arctic MX-6, Thermal Grizzly Kryonaut
**Price:** ~$8–12

---

## Build Notes

- Install CPU and RAM before putting motherboard in case
- Install CPU cooler before GPU (access is blocked afterward in tight cases)
- The 1070 Ti goes in the second PCIe x16 slot. Connect displays 3/4 to its outputs
- Enable EXPO memory profile in BIOS on first boot
- Update BIOS before installing CPU if board predates the CPU (critical for X3D chips)

[VELORIN.EOF]
