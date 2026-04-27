# SECTION 4 — PERIPHERALS: MACHINE 1 (MAC MINI COCKPIT)

**Purpose:** Input and display for the Mac mini daily workstation. Two monitors, keyboard, mouse, and dock for port management.

---

## Monitors

**Count:** 2 monitors assigned to Machine 1
**Source:** Pull from existing inventory (you have 2 good existing monitors)

**Compatibility check:** The Mac mini M4 drives displays via:
- 1x HDMI 2.1 (supports up to 4K 144Hz or 8K 60Hz)
- 2x Thunderbolt 4 rear ports (supports DisplayPort Alt Mode — requires USB-C to DisplayPort cable or USB-C monitor)

If your existing monitors use HDMI, plug one into the HDMI port directly. For the second, either:
- Use a USB-C to HDMI adapter (works, minor cost)
- Use the Thunderbolt dock (see below) which provides additional HDMI/DisplayPort outputs

**Note on existing monitors not being gaming spec:** That's fine for Machine 1. This machine does no gaming. 60Hz, 1080p, or 1440p — all appropriate for Claude Desktop, browser, code work.

---

## Thunderbolt Dock

**Recommended:** CalDigit TS4 Thunderbolt 4 Dock
**Price:** ~$250–300
**Why:** Provides additional USB-A/C ports, card reader, audio out, and extra display outputs from a single Thunderbolt cable to the Mac mini. Clean desk setup. Eliminates reaching behind the Mac mini for every peripheral connection.

**Budget alternative:** Anker 777 Thunderbolt 4 Dock (~$150). Fewer ports but covers the basics.

**What the dock provides that the Mac mini alone doesn't:**
- Additional USB-A ports (Mac mini has none on the base body — only USB-C)
- SD/microSD card reader
- Ethernet passthrough (if needed for the dock rather than direct cable)
- Additional display output if needed

---

## Keyboard

**Recommendation:** Research needed on preference.

Options frequently recommended for Mac setups:
- **Keychron K2 or K8 (wireless, mechanical)** — ~$90–100. Popular Mac-compatible layout, solid build, available in multiple switch types.
- **Apple Magic Keyboard** — ~$99 for standard, ~$129 with Touch ID. Seamless macOS integration, Touch ID for password/auth, compact. No mechanical feel.
- **Logitech MX Keys** — ~$110. Quiet, backlit, pairs with multiple devices via Bluetooth, good for multi-machine switching.

**For a two-machine setup:** A keyboard that supports Bluetooth multi-device pairing (Logitech MX Keys or Keychron) lets you toggle between Machine 1 and Machine 2 without a physical KVM switch.

---

## Mouse

**Recommendation:** Research needed on preference.

Options:
- **Logitech MX Master 3S** — ~$100. The consensus recommendation for productivity + Mac. Precise, ergonomic, multi-device pairing, works on glass. Good for long sessions.
- **Apple Magic Mouse** — ~$79. Native macOS gesture support. Ergonomics are controversial — flat design is uncomfortable for extended use for many people.
- **Logitech G Pro X Superlight 2** — ~$160. If gaming sometimes happens on Machine 1 (not planned but possible), this is a top-tier option.

---

## Cables Summary

| Cable | Use |
|---|---|
| USB-C to HDMI (or HDMI cable) | Monitor 1 connection |
| USB-C to DisplayPort (or adapter) | Monitor 2 connection |
| Thunderbolt 4 cable (1m) | Mac mini to dock |
| Cat6a Ethernet | Mac mini to network switch |

[VELORIN.EOF]
