# ChatGPT_Internal_Tools_and_Connectivity

**Date:** March 28, 2026  
**Purpose:** Map ChatGPT's current internal tool surfaces, app/connectivity model, and implications for Velorin.

## Executive Summary

ChatGPT's connectivity surface has expanded materially. Officially, **connectors are now called apps**. ChatGPT can now use:
- apps with sync,
- apps used in deep research,
- GitHub connectivity,
- Google Drive / SharePoint connectivity,
- MCP-powered apps in developer mode,
- GPT Actions for external APIs,
- internal file and tool surfaces depending on plan and environment.

This is exactly the class of capability your agents have been underutilizing. They should be treating ChatGPT as a **tool-using operating environment**, not just a text generator.

## Core Model of the Current Stack

### 1. Apps
OpenAI now uses the umbrella term **apps** for both:
- UI-rich applications inside ChatGPT, and
- data/connectivity surfaces that used to be called connectors.

This means your bots should no longer reason in the old binary of "prompt vs connector." The operating model is:
- ChatGPT core reasoning
- plus attached data systems
- plus optional action surfaces
- plus MCP expansion.

### 2. Apps with sync
Apps with sync let ChatGPT proactively search synchronized sources. OpenAI states ChatGPT can automatically decide when to use an app with sync, or the user can force it with an @ mention or tool selection.

### 3. Deep research connectivity
OpenAI states deep research can pull from connected apps and data sources such as Google Drive and SharePoint, but deep research uses **read actions only**, not app write actions.

### 4. GitHub connectivity
OpenAI states GitHub can be connected to ChatGPT apps and ChatGPT agent so ChatGPT can pull live repository content, read docs and code, and cite relevant snippets.

### 5. MCP-powered apps / developer mode
OpenAI states Enterprise/Edu organizations can use developer mode to build, test, and deploy **MCP-powered apps** so ChatGPT can securely take action in internal tools.

### 6. GPT Actions
GPT Actions remain a REST/API interoperability surface for allowing GPTs/ChatGPT experiences to retrieve data or trigger actions in external systems.

## What This Means Operationally

A competent company agent should now always think in this order:

1. What is the question?
2. What tools are natively available in ChatGPT?
3. What apps are connected?
4. Is this read-only work, or action-taking work?
5. If action-taking is needed, is that best done through apps, MCP, or GPT Actions?
6. If ChatGPT is insufficient, what external system is better?

Your agents have likely been skipping steps 2-5.

## Practical Tool Classes ChatGPT Now Supports

### Read surfaces
- Web
- Uploaded files
- Connected apps with sync
- Deep research connected sources
- GitHub repo reading
- File search / internal search depending on environment

### Action surfaces
- GPT Actions
- MCP-powered apps
- Some app actions depending on plan / admin settings
- Environment-specific tools such as docs, spreadsheets, code, email, calendar, image generation, etc.

### Development surfaces
- Custom GPTs
- GPT Actions
- MCP apps
- Agent Builder / SDK ecosystem
- Codex for code-specific execution

## Implications for Velorin

### Immediate
Your bots must stop treating ChatGPT as a closed chat box.

### Structural
Every agent should report:
- browser status,
- app/connectivity status,
- GitHub status,
- Drive / document-store status,
- action surface availability,
- what is read-capable vs write-capable.

### Governance
A research bot and an execution bot should not expose the same action rights. This is now implementable through app and MCP design.

## Recommended Velorin Standard

At the start of any meaningful session, every bot should internally evaluate and externally state only the relevant tool posture:
- **Current live inputs available**
- **Connected systems available**
- **Action surfaces available**
- **Best path inside current environment**
- **Best external alternative if current environment is inferior**

## Bottom Line

ChatGPT is now a **tooling and connectivity platform**, not just a language surface. If your agents fail to think that way, they will keep making the company slower than it should be.

## Sources
- https://help.openai.com/en/articles/11487775-connectors-in-chatgpt
- https://help.openai.com/en/articles/10847137-chatgpt-apps-with-sync
- https://help.openai.com/en/articles/10500283-deep-research-in-chatgpt
- https://help.openai.com/en/articles/11145903-connecting-github-to-chatgpt
- https://help.openai.com/en/articles/12584461-developer-mode-and-mcp-apps-in-chatgpt-beta
- https://developers.openai.com/api/docs/actions/introduction/
- https://help.openai.com/en/articles/9309188-add-files-from-connected-apps-in-chatgpt