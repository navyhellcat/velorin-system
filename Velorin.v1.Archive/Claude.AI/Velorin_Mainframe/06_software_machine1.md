# SECTION 6 — SOFTWARE: MACHINE 1 (MAC MINI)

**Purpose:** Everything needed to run the Claude orchestration layer, MCP tools, development environment, and external connections from the Mac mini.

---

## Operating System

**macOS Sequoia (included)**
No action required. Ships with the Mac mini. Keep updated.

---

## Claude Desktop

**Source:** anthropic.com/download
**Cost:** Free
**Purpose:** Primary interface for Claude sessions. Houses MCP server connections. Runs the Velorin boot protocol.

**Configuration file location:** `~/Library/Application Support/Claude/claude_desktop_config.json`
This file defines all MCP server connections. The Velorin MCP server (velorin-gdrive-mcp) entry lives here.

---

## Velorin MCP Server (velorin-gdrive-mcp)

**Source:** github.com/navyhellcat/velorin-gdrive-mcp
**Current version:** v1.3.1 (operational as of Session 004)
**Purpose:** Gives Claude Desktop read/write access to Google Drive. Core Velorin boot infrastructure.

**Status:** Already built, deployed, and operational. Do not reinstall from scratch — pull latest from GitHub.

---

## Node.js LTS

**Source:** nodejs.org
**Cost:** Free
**Purpose:** Runtime for the MCP server and any Node-based orchestration scripts.
**Install:** Always use the LTS (Long Term Support) version. Do not install via Homebrew unless you have a specific reason — direct download from nodejs.org is more stable.

---

## Google Drive Desktop Sync

**Source:** drive.google.com/drive/downloads
**Cost:** Free (included with Google account)
**Purpose:** Keeps Velorin Drive documents synced locally for fast access and offline reference.

---

## Cursor IDE

**Source:** cursor.com
**Cost:** Free tier available; Pro ~$20/month
**Purpose:** Primary code editor. AI-assisted coding, integrated terminal, connects to Claude and other models. Replaces VS Code for this setup.

**Note on Claude Code:** Claude Code is a separate terminal-based tool (not the same as Cursor). It is installed and operational on this machine already from Session 005. It runs via terminal and allows Claude to write, execute, and manage code autonomously. Cursor provides the visual IDE layer on top.

---

## Chrome Browser

**Source:** google.com/chrome
**Cost:** Free
**Purpose:** Primary browser. Used for Google Drive access, API dashboards, Claude in Chrome (browser automation), and general web use.

---

## Claude Code

**Source:** npm install -g @anthropic-ai/claude-code (or via Anthropic docs)
**Version:** v2.1.84 (installed in Session 005)
**Purpose:** Terminal-based agentic coding tool. Claude writes and runs code, manages files, executes tasks autonomously from terminal.
**Status:** Already installed and authenticated.

---

## GitHub Desktop (or CLI)

**Source:** desktop.github.com or via brew install gh
**Cost:** Free
**Purpose:** Version control for Velorin codebase. The velorin-gdrive-mcp repo and future orchestration repos live here.
**GitHub MCP:** Connected to Claude Desktop as of Session 005. GitHub PAT stored in claude_desktop_config.json — rotate this token if it may have been exposed.

---

## Python 3 (LTS)

**Source:** python.org or via Homebrew
**Cost:** Free
**Purpose:** Some orchestration scripts and Google API integrations are Python-based. Install latest Python 3.x LTS.

---

## Google Workspace CLI (gws) — NEW, Critical

**Source:** npm install -g @googleworkspace/cli
**Released:** March 2026
**Cost:** Free (developer sample from Google)
**Purpose:** Single CLI for all Google Workspace APIs. Provides native MCP server mode — run `gws mcp -s drive,gmail,calendar` to expose Gmail, Drive, and Calendar as MCP tools that Claude Desktop can call directly.

**Why this matters:** Previously, connecting Claude to Gmail and Calendar required custom OAuth scripts and separate API clients per service. gws unifies this into one tool with built-in MCP support. Claude Desktop can now read Gmail, check Calendar, and manage Drive without custom middleware.

**Important caveat:** This is a Google developer sample, not an officially supported Google product. No SLA or stability guarantee. Back up any workflows that depend on it.

---

## Software Install Order on First Setup

1. macOS Sequoia (factory installed)
2. Chrome
3. Node.js LTS
4. Claude Desktop
5. Google Drive Desktop Sync
6. Python 3
7. Cursor
8. GitHub CLI (`gh`)
9. Clone velorin-gdrive-mcp from GitHub
10. Configure claude_desktop_config.json with MCP server entry
11. Install gws (`npm install -g @googleworkspace/cli`)
12. Run `gws auth setup` to authenticate Workspace
13. Claude Code (install last — requires Node.js)

[VELORIN.EOF]
