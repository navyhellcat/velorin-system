MCP Google Workspace Server Review
Summary of Findings, Disagreements, and Merge Direction
Prepared as a handoff document for final coding-agent implementation
1. Executive Summary
Two parallel review branches were developed: Trey's branch prioritized portability, authentication correctness, broader agent utility, and safer Google Drive / Docs behavior; Alexander's branch emphasized MCP runtime discipline, explicit validation, and operational clarity. The final consensus was not to preserve either branch intact, but to merge the strongest parts of both into a low-level MCP server that remains easy to extend later.
The highest-confidence conclusions were: use end-of-document insertion via endOfSegmentLocation rather than inferred index math; fetch actual parents before removeParents when moving newly created docs; keep shared-drive support; preserve a full future-permissions inventory in source while requesting only the active scopes needed now; add explicit stderr logging and startup hardening; and support caller-provided resource keys with metadata fallback.
2. What Trey Argued For
* Cross-platform and less brittle OAuth behavior. Trey objected to shelling out to macOS-only open and preferred either a portable opener or a printed-URL baseline.
* Automatic handling of both credential formats via keys.installed || keys.web without pushing configuration questions back to the user.
* Safer Google Drive behavior: actual-parent fetching before folder move, richer list/search metadata, and resource-key-aware flows.
* Google Docs append safety: use endOfSegmentLocation instead of reading the last body element and subtracting one from endIndex.
* Pagination and agent ergonomics: support bounded aggregation and deterministic page-token continuation.
* Full visibility into future automation goals, but without requesting unnecessary live scopes before corresponding tools exist.
3. What Alexander Argued For
* MCP runtime hygiene: stderr-only operational logging, better startup checks, and defensive handling around server.connect().
* Explicit input hardening, especially validateId()-style checks on Drive file IDs and folder IDs.
* Operational simplicity for first install: printed authorization URL baseline and fewer moving parts.
* Clearer debugging surfaces, including per-tool invocation logging and better error surfacing from Google API responses.
* Retention of the broader permission inventory in source so future tool additions would not be forgotten.
4. Key Findings and Decisions
Auth launcher: Initial code used exec(`open ...`), which is macOS-specific and fragile. Consensus shifted away from mandatory auto-open. Final direction: printed URL baseline; redirect URI discovered from credentials file; OAuth state retained.
Credential format handling: No user-side question should be required about installed vs web. The code should support both automatically with keys.installed || keys.web.
Scope handling: This was the largest policy disagreement. Trey reduced live scopes to Drive + Docs only, while Alexander objected that future scopes would be forgotten. Final resolution: keep ACTIVE_SCOPES for the current implementation and keep RESERVED_SCOPES in source comments or a dedicated constant so future inventory remains visible without triggering unnecessary permission blast radius.
Shared-drive handling: Both agents agreed shared-drive blindness was a real issue. supportsAllDrives and includeItemsFromAllDrives should be added where relevant. Trey later refined the point that corpora: 'allDrives' should not be sprayed onto every list call; it belongs on broad cross-Drive search, not automatically on all folder listings.
Drive query safety: Folder IDs and file IDs should be validated. Search query strings should escape apostrophes and backslashes.
Resource keys: A major improvement area. Final direction: accept caller-provided resource_key and fall back to meta.data.resourceKey when available. This preserves agent chaining and improves link-shared file handling.
Doc append behavior: Trey argued repeatedly that inferred endIndex math is brittle. Alexander agreed after comparison. Final direction: use endOfSegmentLocation: {}.
Folder move behavior: Alexander's earlier removeParents: 'root' approach was rejected. Final direction: fetch actual parents first, then remove only those.
Search behavior: Trey broadened search to name contains OR fullText contains. This was accepted as more useful for automation than fullText-only search.
Pagination: A limitation in early versions was silent truncation. Final direction: allow both page_token-driven deterministic pagination and max_results bounded aggregation.
Error reporting: Generic err.message is often insufficient for Google APIs. Final direction: prefer err?.response?.data when available.
Runtime stability: Unhandled rejection and uncaught exception handlers should be present. Alexander's push for try/catch around server.connect() and per-tool stderr logging was accepted.
5. Main Disagreements and How They Were Resolved
Issue
	Disagreement
	Resolution
	Permissions
	Trey initially removed future scopes from the live auth list; Alexander argued this would create memory burden for future development.
	Keep only active scopes in the running auth flow, but preserve the full reserved scope inventory in source for later expansion.
	Auth UX
	Trey initially supported a cross-platform open package; Alexander preferred no auto-open dependency at all.
	Printed URL baseline won. Auto-open was deferred rather than made mandatory.
	corpora usage
	Alexander's summary proposed corpora: 'allDrives' on all list calls. Trey later objected that this is over-broad and can reduce efficiency or produce incompleteSearch behavior.
	Use shared-drive flags broadly, but apply corpora: 'allDrives' only where a broad cross-Drive search genuinely needs it.
	Alexander code baseline
	Some Alexander code/spec iterations still hardcoded redirect URIs, used removeParents: 'root', and inferred append indexes.
	Those parts were explicitly rejected in favor of the merged behavior.
	Code appendices
	The user requested the last code from each side. Later Alexander messages in this exchange were specifications rather than full code listings.
	This document appends Trey's last complete code and the last complete Alexander code text available in the supplied materials.
	6. Final Recommended Direction for the Coding Agent
* Keep the low-level Server approach for now; reassess higher-level MCP abstractions later.
* Use printed-URL auth with OAuth state, redirect URI discovery from credentials, and automatic installed/web support.
* Preserve ACTIVE_SCOPES versus RESERVED_SCOPES structure.
* Retain shared-drive flags, but use corpora: 'allDrives' selectively rather than universally.
* Use endOfSegmentLocation for doc appends.
* Use actual-parent discovery before removeParents.
* Support both page_token and max_results for list/search tools.
* Support caller-provided resource_key with metadata fallback.
* Keep stderr logging, startup/connect hardening, and rich Google API error extraction.
* Keep zod in package.json if staying aligned with current MCP SDK expectations.
7. Notes for the Finalizer
The two appended code blocks are comparison artifacts. They are not both final. Trey's appended code is the last full merged code he wrote in this exchange. Alexander's appended code is the last complete code text available in the supplied materials for this document; later Alexander responses available in chat were specifications and critiques rather than a fresh full code listing.
________________


Appendix A. Trey — Last Complete Code Written in This Exchange
package.json
{
  "name": "velorin-gdrive-mcp",
  "version": "1.2.0",
  "description": "Velorin Google Drive MCP Server",
  "main": "server.js",
  "type": "module",
  "scripts": {
    "auth": "node auth.js",
    "start": "node server.js"
  },
  "dependencies": {
    "@modelcontextprotocol/sdk": "1.27.1",
    "google-auth-library": "10.3.0",
    "googleapis": "159.0.0",
    "open": "10.2.0",
    "zod": "3.25.76"
  }
}
auth.js
import { OAuth2Client } from 'google-auth-library';
import { createServer } from 'http';
import { readFileSync, writeFileSync, existsSync } from 'fs';
import { URL } from 'url';
import { randomBytes } from 'crypto';
import open from 'open';


const CREDENTIALS_PATH = process.env.GDRIVE_OAUTH_PATH || './gcp-oauth.keys.json';
const TOKEN_PATH = process.env.GDRIVE_TOKEN_PATH || './tokens.json';


if (!existsSync(CREDENTIALS_PATH)) {
  console.error(`ERROR: Credentials file not found at: ${CREDENTIALS_PATH}`);
  console.error('Place your downloaded gcp-oauth.keys.json in this directory.');
  process.exit(1);
}


const keys = JSON.parse(readFileSync(CREDENTIALS_PATH, 'utf8'));
const creds = keys.installed || keys.web;


if (!creds?.client_id || !creds?.client_secret) {
  console.error('ERROR: Invalid credentials file. Expected valid "installed" or "web" OAuth credentials.');
  process.exit(1);
}


const fallbackRedirectUri = 'http://localhost:3000/oauth2callback';
const redirectUri =
  creds.redirect_uris?.find((uri) => uri.startsWith('http://localhost')) ||
  fallbackRedirectUri;


const redirectUrl = new URL(redirectUri);
const PORT = Number(redirectUrl.port || 80);
const CALLBACK_PATH = redirectUrl.pathname || '/oauth2callback';


const oauth2Client = new OAuth2Client({
  clientId: creds.client_id,
  clientSecret: creds.client_secret,
  redirectUri
});


// Only request scopes for tools that are actually implemented.
const SCOPES = [
  'https://www.googleapis.com/auth/drive',
  'https://www.googleapis.com/auth/documents'
];


const state = randomBytes(16).toString('hex');


const authUrl = oauth2Client.generateAuthUrl({
  access_type: 'offline',
  scope: SCOPES,
  prompt: 'consent',
  state
});


const server = createServer(async (req, res) => {
  try {
    const url = new URL(req.url, `http://localhost:${PORT}`);


    if (url.pathname !== CALLBACK_PATH) {
      res.writeHead(404);
      res.end('Not found');
      return;
    }


    const code = url.searchParams.get('code');
    const error = url.searchParams.get('error');
    const returnedState = url.searchParams.get('state');


    if (error) {
      res.writeHead(400);
      res.end(`Authorization denied: ${error}`);
      console.error(`Authorization denied: ${error}`);
      server.close();
      process.exit(1);
    }


    if (!code) {
      res.writeHead(400);
      res.end('Missing authorization code.');
      server.close();
      process.exit(1);
    }


    if (returnedState !== state) {
      res.writeHead(400);
      res.end('State mismatch.');
      console.error('ERROR: OAuth state mismatch.');
      server.close();
      process.exit(1);
    }


    const { tokens } = await oauth2Client.getToken(code);
    oauth2Client.setCredentials(tokens);
    writeFileSync(TOKEN_PATH, JSON.stringify(tokens, null, 2));


    res.writeHead(200);
    res.end('Authorization successful. You can close this window and return to Terminal.');
    server.close();


    console.log(`\nSuccess. Tokens saved to ${TOKEN_PATH}`);
    console.log('Run the MCP server with: node server.js');
    process.exit(0);
  } catch (err) {
    console.error('Auth error:', err?.message || String(err));
    res.writeHead(500);
    res.end(`Authorization failed: ${err?.message || String(err)}`);
    server.close();
    process.exit(1);
  }
});


server.on('error', (err) => {
  if (err.code === 'EADDRINUSE') {
    console.error(`ERROR: Port ${PORT} is already in use. Close any other running processes and try again.`);
  } else {
    console.error('Server error:', err?.message || String(err));
  }
  process.exit(1);
});


server.listen(PORT, async () => {
  console.log('\n=== VELORIN MCP AUTHORIZATION ===');
  console.log(`Using redirect URI: ${redirectUri}`);
  console.log('\nOpen this URL in your browser:\n');
  console.log(authUrl);
  console.log('\nWaiting for authorization...');


  try {
    const child = await open(authUrl, { wait: false });
    child?.unref?.();
  } catch {
    console.error('Browser did not auto-open. Copy the URL above manually.');
  }
});
server.js
#!/usr/bin/env node


import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import { CallToolRequestSchema, ListToolsRequestSchema } from '@modelcontextprotocol/sdk/types.js';
import { OAuth2Client } from 'google-auth-library';
import { google } from 'googleapis';
import { readFileSync, writeFileSync, existsSync } from 'fs';


const log = (...args) => process.stderr.write(`[velorin-mcp] ${args.join(' ')}\n`);


const CREDENTIALS_PATH = process.env.GDRIVE_OAUTH_PATH || './gcp-oauth.keys.json';
const TOKEN_PATH = process.env.GDRIVE_TOKEN_PATH || './tokens.json';


function validateId(id, label = 'ID') {
  if (!id || typeof id !== 'string') {
    throw new Error(`Invalid ${label}: must be a non-empty string`);
  }
  if (!/^[a-zA-Z0-9_-]+$/.test(id)) {
    throw new Error(`Invalid ${label} format: ${id}`);
  }
  return id;
}


function escapeQuery(text) {
  return String(text).replace(/\\/g, '\\\\').replace(/'/g, "\\'");
}


function asText(text) {
  return {
    content: [{ type: 'text', text }]
  };
}


function asJson(data) {
  return {
    content: [{ type: 'text', text: JSON.stringify(data, null, 2) }]
  };
}


function getResourceKeyOptions(fileId, resourceKey) {
  if (!resourceKey) return {};
  return {
    headers: {
      'X-Goog-Drive-Resource-Keys': `${fileId}/${resourceKey}`
    }
  };
}


async function aggregateFiles(listFn, initialParams, maxResults = 100) {
  const files = [];
  let pageToken = initialParams.pageToken;


  while (files.length < maxResults) {
    const pageSize = Math.min(100, maxResults - files.length);


    const res = await listFn({
      ...initialParams,
      pageSize,
      pageToken
    });


    files.push(...(res.data.files || []));


    if (!res.data.nextPageToken || files.length >= maxResults) {
      return {
        files,
        nextPageToken: res.data.nextPageToken || null
      };
    }


    pageToken = res.data.nextPageToken;
  }


  return {
    files,
    nextPageToken: pageToken || null
  };
}


if (!existsSync(CREDENTIALS_PATH)) {
  log(`ERROR: Credentials file not found: ${CREDENTIALS_PATH}`);
  process.exit(1);
}


const keys = JSON.parse(readFileSync(CREDENTIALS_PATH, 'utf8'));
const creds = keys.installed || keys.web;


if (!creds?.client_id || !creds?.client_secret) {
  log('ERROR: Invalid credentials file. Expected valid "installed" or "web" OAuth credentials.');
  process.exit(1);
}


const redirectUri =
  creds.redirect_uris?.find((uri) => uri.startsWith('http://localhost')) ||
  'http://localhost:3000/oauth2callback';


const oauth2Client = new OAuth2Client({
  clientId: creds.client_id,
  clientSecret: creds.client_secret,
  redirectUri
});


if (!existsSync(TOKEN_PATH)) {
  log(`ERROR: No tokens found at ${TOKEN_PATH}. Run: node auth.js`);
  process.exit(1);
}


let savedTokens = JSON.parse(readFileSync(TOKEN_PATH, 'utf8'));
oauth2Client.setCredentials(savedTokens);


oauth2Client.on('tokens', (newTokens) => {
  savedTokens = { ...savedTokens, ...newTokens };
  writeFileSync(TOKEN_PATH, JSON.stringify(savedTokens, null, 2));
  log('Tokens refreshed and saved.');
});


const drive = google.drive({ version: 'v3', auth: oauth2Client });
const docs = google.docs({ version: 'v1', auth: oauth2Client });


const SHARED_DRIVE_LIST = {
  corpora: 'allDrives',
  includeItemsFromAllDrives: true,
  supportsAllDrives: true
};


const SHARED_DRIVE_FILE = {
  supportsAllDrives: true
};


log('Velorin MCP server starting...');


const server = new Server(
  { name: 'velorin-gdrive', version: '1.2.0' },
  { capabilities: { tools: {} } }
);


server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [
    {
      name: 'gdrive_list_folder',
      description: 'List files in a Google Drive folder by folder ID. Supports deterministic pagination or bounded aggregation.',
      inputSchema: {
        type: 'object',
        properties: {
          folder_id: {
            type: 'string',
            description: 'Google Drive folder ID'
          },
          page_token: {
            type: 'string',
            description: 'Optional page token. If provided, returns a single page and the next page token.'
          },
          max_results: {
            type: 'number',
            description: 'Maximum files to return when aggregating pages. Default 100, max 500.'
          }
        },
        required: ['folder_id']
      }
    },
    {
      name: 'gdrive_read_file',
      description: 'Read full text content of a Google Doc by file ID. Returns complete plain text for Google Docs.',
      inputSchema: {
        type: 'object',
        properties: {
          file_id: {
            type: 'string',
            description: 'Google Drive file ID'
          },
          resource_key: {
            type: 'string',
            description: 'Optional resource key for certain link-shared files'
          }
        },
        required: ['file_id']
      }
    },
    {
      name: 'gdrive_create_doc',
      description: 'Create a new Google Doc with title and content, optionally in a specified folder.',
      inputSchema: {
        type: 'object',
        properties: {
          title: {
            type: 'string',
            description: 'Document title'
          },
          content: {
            type: 'string',
            description: 'Document content'
          },
          folder_id: {
            type: 'string',
            description: 'Folder ID to place the doc in'
          }
        },
        required: ['title', 'content']
      }
    },
    {
      name: 'gdrive_update_doc',
      description: 'Append text to the end of an existing Google Doc.',
      inputSchema: {
        type: 'object',
        properties: {
          file_id: {
            type: 'string',
            description: 'Google Drive file ID'
          },
          content: {
            type: 'string',
            description: 'Text to append'
          }
        },
        required: ['file_id', 'content']
      }
    },
    {
      name: 'gdrive_search',
      description: 'Search Google Drive files by name or full text. Supports deterministic pagination or bounded aggregation.',
      inputSchema: {
        type: 'object',
        properties: {
          query: {
            type: 'string',
            description: 'Search query'
          },
          folder_id: {
            type: 'string',
            description: 'Optional folder ID to limit search to direct children of that folder'
          },
          page_token: {
            type: 'string',
            description: 'Optional page token. If provided, returns a single page and the next page token.'
          },
          max_results: {
            type: 'number',
            description: 'Maximum files to return when aggregating pages. Default 50, max 200.'
          }
        },
        required: ['query']
      }
    }
  ]
}));


server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args = {} } = request.params;


  try {
    if (name === 'gdrive_list_folder') {
      const folderId = validateId(args.folder_id, 'folder_id');
      const maxResults = Math.min(Math.max(Number(args.max_results || 100), 1), 500);


      const baseParams = {
        q: `'${folderId}' in parents and trashed = false`,
        orderBy: 'folder,name_natural',
        fields: 'nextPageToken, files(id, name, mimeType, modifiedTime, webViewLink, resourceKey, driveId, parents)',
        ...SHARED_DRIVE_LIST
      };


      if (args.page_token) {
        const res = await drive.files.list({
          ...baseParams,
          pageSize: Math.min(maxResults, 100),
          pageToken: String(args.page_token)
        });


        return asJson({
          files: res.data.files || [],
          next_page_token: res.data.nextPageToken || null
        });
      }


      const result = await aggregateFiles(
        (params) => drive.files.list(params),
        baseParams,
        maxResults
      );


      return asJson({
        files: result.files,
        next_page_token: result.nextPageToken
      });
    }


    if (name === 'gdrive_read_file') {
      const fileId = validateId(args.file_id, 'file_id');
      const resourceKey = args.resource_key ? validateId(args.resource_key, 'resource_key') : null;
      const requestOptions = getResourceKeyOptions(fileId, resourceKey);


      const meta = await drive.files.get(
        {
          fileId,
          fields: 'id, name, mimeType, webViewLink, resourceKey',
          ...SHARED_DRIVE_FILE
        },
        requestOptions
      );


      if (meta.data.mimeType !== 'application/vnd.google-apps.document') {
        return asText(
          `File: ${meta.data.name} (${meta.data.mimeType})\nNot a Google Doc. This tool currently reads Google Docs as text only.`
        );
      }


      const exported = await drive.files.export(
        {
          fileId,
          mimeType: 'text/plain'
        },
        requestOptions
      );


      return asText(typeof exported.data === 'string' ? exported.data : String(exported.data));
    }


    if (name === 'gdrive_create_doc') {
      const title = String(args.title);
      const content = String(args.content);
      const folderId = args.folder_id ? validateId(args.folder_id, 'folder_id') : null;


      const createRes = await docs.documents.create({
        requestBody: { title }
      });


      const docId = createRes.data.documentId;
      if (!docId) {
        throw new Error('Google Docs API did not return a documentId.');
      }


      if (content.length > 0) {
        await docs.documents.batchUpdate({
          documentId: docId,
          requestBody: {
            requests: [
              {
                insertText: {
                  location: { index: 1 },
                  text: content
                }
              }
            ]
          }
        });
      }


      if (folderId) {
        const fileMeta = await drive.files.get({
          fileId: docId,
          fields: 'id, parents',
          ...SHARED_DRIVE_FILE
        });


        const existingParents = (fileMeta.data.parents || []).join(',');


        await drive.files.update({
          fileId: docId,
          addParents: folderId,
          removeParents: existingParents || undefined,
          fields: 'id, parents',
          ...SHARED_DRIVE_FILE
        });
      }


      return asText(`Created: ${title}\nID: ${docId}\nURL: https://docs.google.com/document/d/${docId}/edit`);
    }


    if (name === 'gdrive_update_doc') {
      const fileId = validateId(args.file_id, 'file_id');
      const content = String(args.content);


      await docs.documents.batchUpdate({
        documentId: fileId,
        requestBody: {
          requests: [
            {
              insertText: {
                endOfSegmentLocation: {},
                text: content
              }
            }
          ]
        }
      });


      return asText(`Updated document ${fileId}`);
    }


    if (name === 'gdrive_search') {
      const query = escapeQuery(args.query);
      const maxResults = Math.min(Math.max(Number(args.max_results || 50), 1), 200);


      let q = `(name contains '${query}' or fullText contains '${query}') and trashed = false`;


      if (args.folder_id) {
        const folderId = validateId(args.folder_id, 'folder_id');
        q += ` and '${folderId}' in parents`;
      }


      const baseParams = {
        q,
        orderBy: 'modifiedTime desc',
        fields: 'nextPageToken, files(id, name, mimeType, modifiedTime, webViewLink, resourceKey, driveId, parents)',
        ...SHARED_DRIVE_LIST
      };


      if (args.page_token) {
        const res = await drive.files.list({
          ...baseParams,
          pageSize: Math.min(maxResults, 100),
          pageToken: String(args.page_token)
        });


        return asJson({
          files: res.data.files || [],
          next_page_token: res.data.nextPageToken || null
        });
      }


      const result = await aggregateFiles(
        (params) => drive.files.list(params),
        baseParams,
        maxResults
      );


      return asJson({
        files: result.files,
        next_page_token: result.nextPageToken
      });
    }


    return asText(`Unknown tool: ${name}`);
  } catch (err) {
    const message = err?.response?.data
      ? JSON.stringify(err.response.data, null, 2)
      : err?.message || String(err);


    return {
      content: [{ type: 'text', text: `Error: ${message}` }],
      isError: true
    };
  }
});


process.on('unhandledRejection', (err) => {
  log('Unhandled rejection:', err?.stack || err?.message || String(err));
});


process.on('uncaughtException', (err) => {
  log('Uncaught exception:', err?.stack || err?.message || String(err));
  process.exit(1);
});


const transport = new StdioServerTransport();
await server.connect(transport);
log('Velorin MCP server connected.');
________________


Appendix B. Alexander — Last Complete Code Available in the Supplied Materials
package.json
{
  "name": "velorin-gdrive-mcp",
  "version": "1.0.0",
  "description": "Velorin Google Drive MCP Server",
  "main": "server.js",
  "type": "module",
  "scripts": {
    "auth": "node auth.js",
    "start": "node server.js"
  },
  "dependencies": {
    "@modelcontextprotocol/sdk": "^1.0.0",
    "googleapis": "^144.0.0",
    "google-auth-library": "^9.0.0"
  }
}
auth.js
import { OAuth2Client } from 'google-auth-library';
import { createServer } from 'http';
import { readFileSync, writeFileSync } from 'fs';
import { URL } from 'url';
import { exec } from 'child_process';


const CREDENTIALS_PATH = process.env.GDRIVE_OAUTH_PATH || './gcp-oauth.keys.json';
const TOKEN_PATH = process.env.GDRIVE_TOKEN_PATH || './tokens.json';
const PORT = 3000;


const keys = JSON.parse(readFileSync(CREDENTIALS_PATH, 'utf8'));
const creds = keys.installed || keys.web;


const oauth2Client = new OAuth2Client(
  creds.client_id,
  creds.client_secret,
  `http://localhost:${PORT}/oauth2callback`
);


const SCOPES = [
  'https://www.googleapis.com/auth/drive',
  'https://www.googleapis.com/auth/documents',
  'https://www.googleapis.com/auth/spreadsheets',
  'https://www.googleapis.com/auth/gmail.modify',
  'https://www.googleapis.com/auth/gmail.send',
  'https://www.googleapis.com/auth/calendar',
  'https://www.googleapis.com/auth/contacts',
  'https://www.googleapis.com/auth/tasks',
  'https://www.googleapis.com/auth/forms'
];


const authUrl = oauth2Client.generateAuthUrl({
  access_type: 'offline',
  scope: SCOPES,
  prompt: 'consent'
});


const server = createServer(async (req, res) => {
  const url = new URL(req.url, `http://localhost:${PORT}`);
  if (url.pathname === '/oauth2callback') {
    const code = url.searchParams.get('code');
    const { tokens } = await oauth2Client.getToken(code);
    oauth2Client.setCredentials(tokens);
    writeFileSync(TOKEN_PATH, JSON.stringify(tokens, null, 2));
    res.end('Authorization successful. You can close this window.');
    server.close();
    console.log('Tokens saved to', TOKEN_PATH);
    process.exit(0);
  }
});


server.listen(PORT, () => {
  console.log('Opening browser for authorization...');
  exec(`open "${authUrl}"`);
});
server.js
import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import { CallToolRequestSchema, ListToolsRequestSchema } from '@modelcontextprotocol/sdk/types.js';
import { OAuth2Client } from 'google-auth-library';
import { google } from 'googleapis';
import { readFileSync, writeFileSync, existsSync } from 'fs';


const CREDENTIALS_PATH = process.env.GDRIVE_OAUTH_PATH || './gcp-oauth.keys.json';
const TOKEN_PATH = process.env.GDRIVE_TOKEN_PATH || './tokens.json';


// Load credentials and tokens
const keys = JSON.parse(readFileSync(CREDENTIALS_PATH, 'utf8'));
const creds = keys.installed || keys.web;


// FIX: pass client_id and client_secret — this is what fixes auto-refresh
const oauth2Client = new OAuth2Client(
  creds.client_id,
  creds.client_secret,
  'http://localhost:3000/oauth2callback'
);


if (!existsSync(TOKEN_PATH)) {
  console.error('No tokens found. Run: node auth.js');
  process.exit(1);
}


const tokens = JSON.parse(readFileSync(TOKEN_PATH, 'utf8'));
oauth2Client.setCredentials(tokens);


// Auto-save refreshed tokens
oauth2Client.on('tokens', (newTokens) => {
  const updated = { ...tokens, ...newTokens };
  writeFileSync(TOKEN_PATH, JSON.stringify(updated, null, 2));
});


const drive = google.drive({ version: 'v3', auth: oauth2Client });
const docs = google.docs({ version: 'v1', auth: oauth2Client });
const sheets = google.sheets({ version: 'v4', auth: oauth2Client });


// MCP Server
const server = new Server(
  { name: 'velorin-gdrive', version: '1.0.0' },
  { capabilities: { tools: {} } }
);


server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [
    {
      name: 'gdrive_list_folder',
      description: 'List all files in a Google Drive folder by folder ID',
      inputSchema: {
        type: 'object',
        properties: {
          folder_id: { type: 'string', description: 'Google Drive folder ID' }
        },
        required: ['folder_id']
      }
    },
    {
      name: 'gdrive_read_file',
      description: 'Read full text content of a Google Doc by file ID. Returns complete document text.',
      inputSchema: {
        type: 'object',
        properties: {
          file_id: { type: 'string', description: 'Google Drive file ID' }
        },
        required: ['file_id']
      }
    },
    {
      name: 'gdrive_create_doc',
      description: 'Create a new Google Doc with given title and content',
      inputSchema: {
        type: 'object',
        properties: {
          title: { type: 'string', description: 'Document title' },
          content: { type: 'string', description: 'Document content' },
          folder_id: { type: 'string', description: 'Folder ID to create doc in (optional)' }
        },
        required: ['title', 'content']
      }
    },
    {
      name: 'gdrive_update_doc',
      description: 'Append text to an existing Google Doc',
      inputSchema: {
        type: 'object',
        properties: {
          file_id: { type: 'string', description: 'Google Drive file ID' },
          content: { type: 'string', description: 'Text to append' }
        },
        required: ['file_id', 'content']
      }
    },
    {
      name: 'gdrive_search',
      description: 'Search for files in Google Drive by name or content',
      inputSchema: {
        type: 'object',
        properties: {
          query: { type: 'string', description: 'Search query' },
          folder_id: { type: 'string', description: 'Limit search to this folder (optional)' }
        },
        required: ['query']
      }
    }
  ]
}));


server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request.params;


  try {
    if (name === 'gdrive_list_folder') {
      const res = await drive.files.list({
        q: `'${args.folder_id}' in parents and trashed = false`,
        fields: 'files(id, name, mimeType, modifiedTime)',
        pageSize: 100
      });
      return {
        content: [{
          type: 'text',
          text: JSON.stringify(res.data.files, null, 2)
        }]
      };
    }


    if (name === 'gdrive_read_file') {
      // Get file metadata first to check type
      const meta = await drive.files.get({
        fileId: args.file_id,
        fields: 'mimeType, name'
      });


      let text = '';


      if (meta.data.mimeType === 'application/vnd.google-apps.document') {
        // Export as plain text — gets FULL content reliably
        const res = await drive.files.export({
          fileId: args.file_id,
          mimeType: 'text/plain'
        });
        text = res.data;
      } else {
        text = `File: ${meta.data.name} (${meta.data.mimeType}) — not a Google Doc, cannot read as text`;
      }


      return {
        content: [{ type: 'text', text }]
      };
    }


    if (name === 'gdrive_create_doc') {
      // Create the doc
      const createRes = await docs.documents.create({
        requestBody: { title: args.title }
      });
      const docId = createRes.data.documentId;


      // Insert content
      await docs.documents.batchUpdate({
        documentId: docId,
        requestBody: {
          requests: [{
            insertText: {
              location: { index: 1 },
              text: args.content
            }
          }]
        }
      });


      // Move to folder if specified
      if (args.folder_id) {
        await drive.files.update({
          fileId: docId,
          addParents: args.folder_id,
          removeParents: 'root',
          fields: 'id, parents'
        });
      }


      return {
        content: [{
          type: 'text',
          text: `Created: ${args.title}\nID: ${docId}\nURL: https://docs.google.com/document/d/${docId}/edit`
        }]
      };
    }


    if (name === 'gdrive_update_doc') {
      // Get current doc end index
      const docRes = await docs.documents.get({ documentId: args.file_id });
      const endIndex = docRes.data.body.content.at(-1).endIndex - 1;


      await docs.documents.batchUpdate({
        documentId: args.file_id,
        requestBody: {
          requests: [{
            insertText: {
              location: { index: endIndex },
              text: '\n' + args.content
            }
          }]
        }
      });


      return {
        content: [{ type: 'text', text: `Updated document ${args.file_id}` }]
      };
    }


    if (name === 'gdrive_search') {
      let q = `fullText contains '${args.query}' and trashed = false`;
      if (args.folder_id) {
        q += ` and '${args.folder_id}' in parents`;
      }
      const res = await drive.files.list({
        q,
        fields: 'files(id, name, mimeType, modifiedTime)',
        pageSize: 20
      });
      return {
        content: [{
          type: 'text',
          text: JSON.stringify(res.data.files, null, 2)
        }]
      };
    }


    return { content: [{ type: 'text', text: `Unknown tool: ${name}` }] };


  } catch (err) {
    return {
      content: [{ type: 'text', text: `Error: ${err.message}` }],
      isError: true
    };
  }
});


const transport = new StdioServerTransport();
await server.connect(transport);