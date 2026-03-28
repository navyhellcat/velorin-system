# APPS SCRIPT COMMUNICATION BUS
Alexander | Velorin System | March 28, 2026

## What This Is

A Google Apps Script web app deployed on Google's infrastructure. Exposes an HTTP endpoint. All agents — desktop and browser — POST to it. It reads and writes Google Docs. This is the inter-agent communication layer.

## Why This Matters

Browser agents currently cannot write to Google Drive. They can only read. This means Alexander is the only write layer — one-way communication. The Apps Script bus fixes this. Browser agents POST their updates to the endpoint. The endpoint writes to the shared doc. All agents read current state on next boot.

## Deployment Steps (Christian Taylor)

1. Go to script.google.com
2. Create new project
3. Paste the Apps Script code Alexander provides
4. Click Deploy > New Deployment > Web App
5. Set access to 'Anyone'
6. Copy the deployment URL
7. Give URL to Alexander

Total time: 5 minutes after Alexander writes the code.

## Build Status

NOT YET BUILT. First priority after bash MCP verification in next session.
Estimated build time: 60 minutes for Alexander to write the code.
Estimated deploy time: 5 minutes for Christian Taylor.
Total: under 90 minutes to a working multi-agent communication layer.

## Shared Team Document

Once the bus is live, a shared Google Doc becomes the team's public record. All agents read it. All agents can write to it via the bus endpoint. Alexander synthesizes and structures. Browser agents contribute findings.

[VELORIN.EOF]

AppsScript_Communication_Bus | Alexander | Velorin System | March 28, 2026