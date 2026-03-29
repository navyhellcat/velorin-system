velorin-gdrive-mcp — Code Review Package
Version 1.3.0  |  Velorin System  |  March 2026
FOR REVIEW ONLY. Do not copy-paste code from this document — formatting will corrupt it. Canonical files live in GitHub: github.com/navyhellcat/velorin-gdrive-mcp
What Changed vs Prior Branches (Trey / Alexander)
Fixed over Trey:
• drive.files.export now passes { responseType: 'text' } as second arg. Trey's String() cast was a symptom fix. This is the root fix.
• SHARED_DRIVE_FOLDER and SHARED_DRIVE_SEARCH are now separate constants. corpora: 'allDrives' is only on search operations — not folder listings. Spraying it on every list call can trigger incompleteSearch on large corpora.
• try/catch added around server.connect(transport). Missing from both branches.
• withRetry() added for 429/503 rate limiting. Neither branch handled transient Google API failures.
Dropped from Trey:
• open package removed. Review decision was printed URL baseline. No auto-open dependency.
Added over both branches:
• gdrive_overwrite_doc — replace all doc content. Append-only was a gap.
• gdrive_move_file — move files between folders. Common Velorin operation missing from both branches.
• gdrive_trash_file — reversible removal. Permanent delete has no place in Velorin operations.
• Better 401 detection in extractError() — hints at re-auth path rather than raw status code.
FILE 1 — package.json
Pinned exact versions. open package removed. zod included per MCP SDK requirement.
{
  "name": "velorin-gdrive-mcp",
  "version": "1.3.0",
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
    "zod": "3.25.76"
  }
}

FILE 2 — auth.js
OAuth flow. Printed URL baseline. CSRF state. Redirect URI discovered from credentials file. Both installed/web formats handled. No auto-open dependency.
/**
 * auth.js — Velorin MCP OAuth flow
 *
 * Decisions vs prior branches:
 *  - Dropped `open` package entirely (review consensus: printed URL baseline, no auto-open dep)
 *  - Redirect URI discovered from credentials file, not hardcoded
 *  - CSRF state parameter added
 *  - Both installed/web credential formats handled automatically
 *  - Startup validation before any network operation
 *  - Port derived from redirect URI, not hardcoded
 */

import { OAuth2Client } from 'google-auth-library';
import { createServer } from 'http';
import { readFileSync, writeFileSync, existsSync } from 'fs';
import { URL } from 'url';
import { randomBytes } from 'crypto';

const CREDENTIALS_PATH = process.env.GDRIVE_OAUTH_PATH || './gcp-oauth.keys.json';
const TOKEN_PATH       = process.env.GDRIVE_TOKEN_PATH || './tokens.json';

// ── Startup validation ────────────────────────────────────────────────────────

if (!existsSync(CREDENTIALS_PATH)) {
  console.error(`ERROR: Credentials file not found: ${CREDENTIALS_PATH}`);
  console.error('Download your OAuth client credentials from Google Cloud Console and place them here.');
  process.exit(1);
}

const keys = JSON.parse(readFileSync(CREDENTIALS_PATH, 'utf8'));
const creds = keys.installed || keys.web;

if (!creds?.client_id || !creds?.client_secret) {
  console.error('ERROR: Invalid credentials file. Expected "installed" or "web" OAuth credentials.');
  process.exit(1);
}

// Discover redirect URI from credentials file. Fall back to localhost:3000.
const FALLBACK_REDIRECT = 'http://localhost:3000/oauth2callback';
const redirectUri =
  creds.redirect_uris?.find((u) => u.startsWith('http://localhost')) ||
  FALLBACK_REDIRECT;

const parsedRedirect = new URL(redirectUri);
const PORT          = Number(parsedRedirect.port || 80);
const CALLBACK_PATH = parsedRedirect.pathname || '/oauth2callback';

// ── OAuth client ──────────────────────────────────────────────────────────────

const oauth2Client = new OAuth2Client({
  clientId:     creds.client_id,
  clientSecret: creds.client_secret,
  redirectUri,
});

// ACTIVE_SCOPES: only what current tools use. Re-auth required if you add tools
// with new scope requirements.
const ACTIVE_SCOPES = [
  'https://www.googleapis.com/auth/drive',
  'https://www.googleapis.com/auth/documents',
];

// RESERVED_SCOPES: future tools. Not requested now. Listed here so they are not
// forgotten when new tools are added.
// const RESERVED_SCOPES = [
//   'https://www.googleapis.com/auth/spreadsheets',
//   'https://www.googleapis.com/auth/gmail.modify',
//   'https://www.googleapis.com/auth/gmail.send',
//   'https://www.googleapis.com/auth/calendar',
//   'https://www.googleapis.com/auth/contacts',
//   'https://www.googleapis.com/auth/tasks',
//   'https://www.googleapis.com/auth/forms',
// ];

// CSRF state — verified on callback to prevent redirect hijacking
const state = randomBytes(16).toString('hex');

const authUrl = oauth2Client.generateAuthUrl({
  access_type: 'offline',
  scope:       ACTIVE_SCOPES,
  prompt:      'consent',
  state,
});

// ── Callback server ───────────────────────────────────────────────────────────

const server = createServer(async (req, res) => {
  try {
    const url = new URL(req.url, `http://localhost:${PORT}`);

    if (url.pathname !== CALLBACK_PATH) {
      res.writeHead(404);
      res.end('Not found');
      return;
    }

    const code          = url.searchParams.get('code');
    const error         = url.searchParams.get('error');
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

    // CSRF check
    if (returnedState !== state) {
      res.writeHead(400);
      res.end('State mismatch. Possible CSRF attempt.');
      console.error('ERROR: OAuth state mismatch.');
      server.close();
      process.exit(1);
    }

    const { tokens } = await oauth2Client.getToken(code);
    oauth2Client.setCredentials(tokens);
    writeFileSync(TOKEN_PATH, JSON.stringify(tokens, null, 2));

    res.writeHead(200);
    res.end('Authorization successful. Close this window and return to Terminal.');
    server.close();

    console.log(`\nSuccess. Tokens saved to ${TOKEN_PATH}`);
    console.log('Start the MCP server: node server.js');
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
    console.error(`ERROR: Port ${PORT} already in use. Close any process using it and retry.`);
  } else {
    console.error('Server error:', err?.message || String(err));
  }
  process.exit(1);
});

server.listen(PORT, () => {
  console.log('\n=== VELORIN MCP AUTHORIZATION ===');
  console.log(`Using redirect URI: ${redirectUri}`);
  console.log('\nOpen this URL in your browser:\n');
  console.log(authUrl);
  console.log('\nWaiting for authorization...\n');
});

FILE 3 — server.js
Main MCP server. All tools, retry logic, shared drive handling, token refresh, startup validation.
#!/usr/bin/env node

/**
 * server.js — Velorin Google Drive MCP Server v1.3.0
 *
 * Merge decisions vs prior branches (Trey/Alexander):
 *
 *  KEPT from Trey:
 *   - validateId() on all Drive/Doc IDs before use
 *   - escapeQuery() on all search text before interpolation
 *   - endOfSegmentLocation: {} for doc append (not inferred index math)
 *   - Actual parent fetch before removeParents on folder moves (not hardcoded 'root')
 *   - Token refresh listener + immediate write to disk
 *   - OAuth2Client constructed with clientId + clientSecret (fixes auto-refresh)
 *   - aggregateFiles() for bounded pagination
 *   - resource_key support on read
 *   - Rich Google API error extraction (err?.response?.data)
 *   - Startup validation with hard exit before server init
 *   - unhandledRejection + uncaughtException handlers
 *   - ACTIVE_SCOPES / RESERVED_SCOPES split
 *
 *  FIXED over Trey:
 *   - drive.files.export now passes { responseType: 'text' } as second arg.
 *     Without this, googleapis may return an axios response object instead of
 *     a string depending on internal response handling. Trey's String() cast
 *     was a symptom fix, not a root fix.
 *   - SHARED_DRIVE_FOLDER and SHARED_DRIVE_SEARCH are now separate constants.
 *     corpora: 'allDrives' is only on SHARED_DRIVE_SEARCH (broad search).
 *     Folder listings use supportsAllDrives + includeItemsFromAllDrives only.
 *     Review doc was correct: spraying corpora: 'allDrives' on every list call
 *     can trigger incompleteSearch behavior on large corpora.
 *   - try/catch added around server.connect(transport) with fatal stderr log.
 *   - withRetry() wrapper added for 429/503 transient Google API failures.
 *     Neither branch handled rate limiting at all.
 *
 *  ADDED over both branches:
 *   - gdrive_overwrite_doc: replace all doc content (distinct from append).
 *     Uses deleteContentRange + insertText. Index math is unavoidable here —
 *     no API-native "clear all" abstraction exists. Document is fetched fresh
 *     immediately before use to ensure endIndex accuracy.
 *   - gdrive_move_file: move a file between folders. Fetches actual parents
 *     before removal (same pattern as create_doc folder move).
 *   - gdrive_trash_file: move a file to trash (reversible). Safer than delete.
 */

import { Server }               from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
  CallToolRequestSchema,
  ListToolsRequestSchema,
} from '@modelcontextprotocol/sdk/types.js';
import { OAuth2Client }          from 'google-auth-library';
import { google }                from 'googleapis';
import { readFileSync, writeFileSync, existsSync } from 'fs';

// ── Logging (stderr only — stdout is reserved for MCP protocol) ───────────────

const log = (...args) =>
  process.stderr.write(`[velorin-mcp] ${args.join(' ')}\n`);

// ── Config ────────────────────────────────────────────────────────────────────

const CREDENTIALS_PATH = process.env.GDRIVE_OAUTH_PATH || './gcp-oauth.keys.json';
const TOKEN_PATH       = process.env.GDRIVE_TOKEN_PATH || './tokens.json';

// ── Helpers ───────────────────────────────────────────────────────────────────

/**
 * Validate Drive/Doc file and folder IDs.
 * Rejects anything that could inject into a query string.
 */
function validateId(id, label = 'ID') {
  if (!id || typeof id !== 'string') {
    throw new Error(`Invalid ${label}: must be a non-empty string`);
  }
  if (!/^[a-zA-Z0-9_-]+$/.test(id)) {
    throw new Error(`Invalid ${label} format: ${id}`);
  }
  return id;
}

/**
 * Escape apostrophes and backslashes in Drive query strings.
 * Unescaped apostrophes break the query string silently.
 */
function escapeQuery(text) {
  return String(text)
    .replace(/\\/g, '\\\\')
    .replace(/'/g, "\\'");
}

/** Wrap text result for MCP response. */
function asText(text) {
  return { content: [{ type: 'text', text: String(text) }] };
}

/** Wrap JSON result for MCP response. */
function asJson(data) {
  return { content: [{ type: 'text', text: JSON.stringify(data, null, 2) }] };
}

/**
 * Build resource key header options for link-shared files.
 * Pass caller-provided key; fall back to metadata key if present.
 */
function resourceKeyOptions(fileId, resourceKey) {
  if (!resourceKey) return {};
  return {
    headers: { 'X-Goog-Drive-Resource-Keys': `${fileId}/${resourceKey}` },
  };
}

/**
 * Retry wrapper for Google API calls.
 * Handles 429 (rate limit) and 503 (service unavailable) with exponential backoff.
 * Neither Trey nor Alexander handled transient failures — this fills that gap.
 */
async function withRetry(fn, maxAttempts = 3) {
  for (let attempt = 1; attempt <= maxAttempts; attempt++) {
    try {
      return await fn();
    } catch (err) {
      const status = err?.response?.status || err?.code;
      if ((status === 429 || status === 503) && attempt < maxAttempts) {
        const delay = Math.pow(2, attempt) * 1000 + Math.random() * 500;
        log(`Rate limited (${status}). Retry ${attempt}/${maxAttempts - 1} in ${Math.round(delay)}ms`);
        await new Promise((r) => setTimeout(r, delay));
        continue;
      }
      throw err;
    }
  }
}

/**
 * Paginate through Drive file listings with bounded aggregation.
 * Caps each page request to avoid overshooting maxResults.
 */
async function aggregateFiles(listFn, baseParams, maxResults = 100) {
  const files = [];
  let pageToken = baseParams.pageToken;

  while (files.length < maxResults) {
    const pageSize = Math.min(100, maxResults - files.length);

    const res = await withRetry(() =>
      listFn({ ...baseParams, pageSize, pageToken })
    );

    files.push(...(res.data.files || []));

    if (!res.data.nextPageToken || files.length >= maxResults) {
      return { files, nextPageToken: res.data.nextPageToken || null };
    }

    pageToken = res.data.nextPageToken;
  }

  return { files, nextPageToken: pageToken || null };
}

/**
 * Extract a useful error message from a Google API error.
 * err.message alone is often useless for Drive API failures.
 */
function extractError(err) {
  if (err?.response?.data) {
    return JSON.stringify(err.response.data, null, 2);
  }
  // 401 hint: token likely expired and auto-refresh failed
  if (err?.response?.status === 401) {
    return `401 Unauthorized. Token may be invalid or revoked. Run: node auth.js`;
  }
  return err?.message || String(err);
}

// ── Shared Drive parameter sets ───────────────────────────────────────────────
//
// Two separate constants — not one. Review doc was correct:
// corpora: 'allDrives' on folder listings can produce incompleteSearch behavior
// on large corpora. It belongs only on broad cross-Drive search operations.

/** For specific folder listings where a folderId is the scope. */
const SHARED_DRIVE_FOLDER = {
  supportsAllDrives:        true,
  includeItemsFromAllDrives: true,
};

/** For broad search operations where we want results across all drives. */
const SHARED_DRIVE_SEARCH = {
  supportsAllDrives:        true,
  includeItemsFromAllDrives: true,
  corpora:                   'allDrives',
};

/** For single file get/update operations. */
const SHARED_DRIVE_FILE = {
  supportsAllDrives: true,
};

// ── Credential and token loading ──────────────────────────────────────────────

if (!existsSync(CREDENTIALS_PATH)) {
  log(`ERROR: Credentials file not found: ${CREDENTIALS_PATH}`);
  process.exit(1);
}

const keys  = JSON.parse(readFileSync(CREDENTIALS_PATH, 'utf8'));
const creds = keys.installed || keys.web;

if (!creds?.client_id || !creds?.client_secret) {
  log('ERROR: Invalid credentials file. Expected valid "installed" or "web" OAuth credentials.');
  process.exit(1);
}

const redirectUri =
  creds.redirect_uris?.find((u) => u.startsWith('http://localhost')) ||
  'http://localhost:3000/oauth2callback';

// Passing clientId + clientSecret to OAuth2Client is mandatory for auto-refresh.
// Omitting them is the primary failure mode of all reference gdrive MCP servers.
const oauth2Client = new OAuth2Client({
  clientId:     creds.client_id,
  clientSecret: creds.client_secret,
  redirectUri,
});

if (!existsSync(TOKEN_PATH)) {
  log(`ERROR: No tokens found at ${TOKEN_PATH}. Run: node auth.js`);
  process.exit(1);
}

let savedTokens = JSON.parse(readFileSync(TOKEN_PATH, 'utf8'));
oauth2Client.setCredentials(savedTokens);

// Write refreshed tokens immediately on every refresh event.
// Without this listener, tokens expire after 1 hour and the server silently fails.
oauth2Client.on('tokens', (newTokens) => {
  savedTokens = { ...savedTokens, ...newTokens };
  writeFileSync(TOKEN_PATH, JSON.stringify(savedTokens, null, 2));
  log('Tokens refreshed and persisted.');
});

// ── Google API clients ────────────────────────────────────────────────────────

const drive = google.drive({ version: 'v3', auth: oauth2Client });
const docs  = google.docs({  version: 'v1', auth: oauth2Client });

// ── MCP Server ────────────────────────────────────────────────────────────────

log('Velorin MCP server starting...');

const server = new Server(
  { name: 'velorin-gdrive', version: '1.3.0' },
  { capabilities: { tools: {} } }
);

// ── Tool definitions ──────────────────────────────────────────────────────────

server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [
    {
      name: 'gdrive_list_folder',
      description:
        'List files in a Google Drive folder by folder ID. ' +
        'Supports deterministic pagination via page_token or bounded aggregation via max_results.',
      inputSchema: {
        type: 'object',
        properties: {
          folder_id:   { type: 'string', description: 'Google Drive folder ID' },
          page_token:  { type: 'string', description: 'Optional. Returns single page and next token.' },
          max_results: { type: 'number', description: 'Max files to return when aggregating. Default 100, max 500.' },
        },
        required: ['folder_id'],
      },
    },
    {
      name: 'gdrive_read_file',
      description:
        'Read full text content of a Google Doc by file ID. ' +
        'Returns complete plain text. Non-Doc files return metadata only.',
      inputSchema: {
        type: 'object',
        properties: {
          file_id:      { type: 'string', description: 'Google Drive file ID' },
          resource_key: { type: 'string', description: 'Optional resource key for link-shared files.' },
        },
        required: ['file_id'],
      },
    },
    {
      name: 'gdrive_create_doc',
      description: 'Create a new Google Doc with title and content, optionally in a specified folder.',
      inputSchema: {
        type: 'object',
        properties: {
          title:     { type: 'string', description: 'Document title' },
          content:   { type: 'string', description: 'Document content' },
          folder_id: { type: 'string', description: 'Optional folder ID to place the doc in.' },
        },
        required: ['title', 'content'],
      },
    },
    {
      name: 'gdrive_update_doc',
      description: 'Append text to the end of an existing Google Doc.',
      inputSchema: {
        type: 'object',
        properties: {
          file_id: { type: 'string', description: 'Google Drive file ID' },
          content: { type: 'string', description: 'Text to append' },
        },
        required: ['file_id', 'content'],
      },
    },
    {
      name: 'gdrive_overwrite_doc',
      description:
        'Replace all content in an existing Google Doc with new content. ' +
        'Distinct from gdrive_update_doc which appends. ' +
        'Use when the full document needs to be rewritten.',
      inputSchema: {
        type: 'object',
        properties: {
          file_id: { type: 'string', description: 'Google Drive file ID' },
          content: { type: 'string', description: 'Replacement content for the entire document' },
        },
        required: ['file_id', 'content'],
      },
    },
    {
      name: 'gdrive_search',
      description:
        'Search Google Drive by name or full text. ' +
        'Supports deterministic pagination via page_token or bounded aggregation via max_results.',
      inputSchema: {
        type: 'object',
        properties: {
          query:       { type: 'string', description: 'Search query' },
          folder_id:   { type: 'string', description: 'Optional folder ID to scope search to direct children.' },
          page_token:  { type: 'string', description: 'Optional. Returns single page and next token.' },
          max_results: { type: 'number', description: 'Max files to return when aggregating. Default 50, max 200.' },
        },
        required: ['query'],
      },
    },
    {
      name: 'gdrive_move_file',
      description:
        'Move a file from its current folder(s) to a new folder. ' +
        'Fetches actual parents before removal — does not assume file is in root.',
      inputSchema: {
        type: 'object',
        properties: {
          file_id:          { type: 'string', description: 'Google Drive file ID to move' },
          target_folder_id: { type: 'string', description: 'Destination folder ID' },
        },
        required: ['file_id', 'target_folder_id'],
      },
    },
    {
      name: 'gdrive_trash_file',
      description:
        'Move a file to trash. Reversible. Prefer over permanent delete for all Velorin operations.',
      inputSchema: {
        type: 'object',
        properties: {
          file_id: { type: 'string', description: 'Google Drive file ID to trash' },
        },
        required: ['file_id'],
      },
    },
  ],
}));

// ── Tool handlers ─────────────────────────────────────────────────────────────

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args = {} } = request.params;

  log(`Tool called: ${name}`);

  try {

    // ── gdrive_list_folder ──────────────────────────────────────────────────

    if (name === 'gdrive_list_folder') {
      const folderId   = validateId(args.folder_id, 'folder_id');
      const maxResults = Math.min(Math.max(Number(args.max_results || 100), 1), 500);

      const baseParams = {
        q:       `'${folderId}' in parents and trashed = false`,
        orderBy: 'folder,name_natural',
        fields:  'nextPageToken, files(id, name, mimeType, modifiedTime, webViewLink, resourceKey, driveId, parents)',
        ...SHARED_DRIVE_FOLDER,
      };

      if (args.page_token) {
        const res = await withRetry(() =>
          drive.files.list({
            ...baseParams,
            pageSize:  Math.min(maxResults, 100),
            pageToken: String(args.page_token),
          })
        );
        return asJson({
          files:           res.data.files || [],
          next_page_token: res.data.nextPageToken || null,
        });
      }

      const result = await aggregateFiles(
        (params) => drive.files.list(params),
        baseParams,
        maxResults
      );

      return asJson({ files: result.files, next_page_token: result.nextPageToken });
    }

    // ── gdrive_read_file ────────────────────────────────────────────────────

    if (name === 'gdrive_read_file') {
      const fileId      = validateId(args.file_id, 'file_id');
      const resourceKey = args.resource_key ? String(args.resource_key) : null;
      const reqOptions  = resourceKeyOptions(fileId, resourceKey);

      const meta = await withRetry(() =>
        drive.files.get(
          { fileId, fields: 'id, name, mimeType, webViewLink, resourceKey', ...SHARED_DRIVE_FILE },
          reqOptions
        )
      );

      if (meta.data.mimeType !== 'application/vnd.google-apps.document') {
        return asText(
          `File: ${meta.data.name} (${meta.data.mimeType})\nNot a Google Doc. ` +
          `This tool reads Google Docs as plain text only.`
        );
      }

      // responseType: 'text' is required here. Without it, googleapis may return
      // an axios response object instead of a string depending on internal handling.
      // Trey's branch used String() as a cast — this is the root fix.
      const exported = await withRetry(() =>
        drive.files.export(
          { fileId, mimeType: 'text/plain', ...SHARED_DRIVE_FILE },
          { ...reqOptions, responseType: 'text' }
        )
      );

      return asText(exported.data);
    }

    // ── gdrive_create_doc ───────────────────────────────────────────────────

    if (name === 'gdrive_create_doc') {
      const title    = String(args.title);
      const content  = String(args.content);
      const folderId = args.folder_id ? validateId(args.folder_id, 'folder_id') : null;

      const createRes = await withRetry(() =>
        docs.documents.create({ requestBody: { title } })
      );

      const docId = createRes.data.documentId;
      if (!docId) throw new Error('Google Docs API did not return a documentId.');

      if (content.length > 0) {
        await withRetry(() =>
          docs.documents.batchUpdate({
            documentId:  docId,
            requestBody: {
              requests: [{ insertText: { location: { index: 1 }, text: content } }],
            },
          })
        );
      }

      if (folderId) {
        // Fetch actual parents before removal. Never hardcode removeParents: 'root'.
        // Files are not always in root — hardcoding causes silent data loss.
        const fileMeta = await withRetry(() =>
          drive.files.get({
            fileId: docId,
            fields: 'id, parents',
            ...SHARED_DRIVE_FILE,
          })
        );

        const existingParents = (fileMeta.data.parents || []).join(',');

        await withRetry(() =>
          drive.files.update({
            fileId:       docId,
            addParents:   folderId,
            removeParents: existingParents || undefined,
            fields:       'id, parents',
            ...SHARED_DRIVE_FILE,
          })
        );
      }

      return asText(
        `Created: ${title}\nID: ${docId}\nURL: https://docs.google.com/document/d/${docId}/edit`
      );
    }

    // ── gdrive_update_doc (append) ──────────────────────────────────────────

    if (name === 'gdrive_update_doc') {
      const fileId  = validateId(args.file_id, 'file_id');
      const content = String(args.content);

      // endOfSegmentLocation: {} is the API-native abstraction for end-of-document.
      // Do not infer endIndex from body.content — that is brittle.
      await withRetry(() =>
        docs.documents.batchUpdate({
          documentId:  fileId,
          requestBody: {
            requests: [{
              insertText: { endOfSegmentLocation: {}, text: content },
            }],
          },
        })
      );

      return asText(`Appended to document ${fileId}`);
    }

    // ── gdrive_overwrite_doc ────────────────────────────────────────────────

    if (name === 'gdrive_overwrite_doc') {
      const fileId  = validateId(args.file_id, 'file_id');
      const content = String(args.content);

      // No API-native "clear all content" abstraction exists.
      // Index math is unavoidable here. Document is fetched fresh immediately
      // before use so endIndex is accurate. This is distinct from the append
      // gotcha — that was inserting at a stale calculated index, not deleting
      // a freshly-read range.
      const docRes  = await withRetry(() => docs.documents.get({ documentId: fileId }));
      const lastEl  = docRes.data.body.content.at(-1);
      const endIdx  = lastEl?.endIndex;

      if (!endIdx || typeof endIdx !== 'number') {
        throw new Error('Could not determine document end index from API response.');
      }

      // Delete from 1 to endIndex - 1 (the -1 preserves the trailing newline
      // that Google Docs always maintains at the end of a document body).
      const requests = [];
      if (endIdx > 2) {
        requests.push({
          deleteContentRange: {
            range: { startIndex: 1, endIndex: endIdx - 1 },
          },
        });
      }
      if (content.length > 0) {
        requests.push({
          insertText: { location: { index: 1 }, text: content },
        });
      }

      if (requests.length > 0) {
        await withRetry(() =>
          docs.documents.batchUpdate({
            documentId:  fileId,
            requestBody: { requests },
          })
        );
      }

      return asText(`Overwrote document ${fileId}`);
    }

    // ── gdrive_search ───────────────────────────────────────────────────────

    if (name === 'gdrive_search') {
      const query      = escapeQuery(args.query);
      const maxResults = Math.min(Math.max(Number(args.max_results || 50), 1), 200);

      // Search on both name and fullText — more useful for automation than fullText only.
      let q = `(name contains '${query}' or fullText contains '${query}') and trashed = false`;

      if (args.folder_id) {
        const folderId = validateId(args.folder_id, 'folder_id');
        q += ` and '${folderId}' in parents`;
      }

      const baseParams = {
        q,
        orderBy: 'modifiedTime desc',
        fields:  'nextPageToken, files(id, name, mimeType, modifiedTime, webViewLink, resourceKey, driveId, parents)',
        ...SHARED_DRIVE_SEARCH,
      };

      if (args.page_token) {
        const res = await withRetry(() =>
          drive.files.list({
            ...baseParams,
            pageSize:  Math.min(maxResults, 100),
            pageToken: String(args.page_token),
          })
        );
        return asJson({
          files:           res.data.files || [],
          next_page_token: res.data.nextPageToken || null,
        });
      }

      const result = await aggregateFiles(
        (params) => drive.files.list(params),
        baseParams,
        maxResults
      );

      return asJson({ files: result.files, next_page_token: result.nextPageToken });
    }

    // ── gdrive_move_file ────────────────────────────────────────────────────

    if (name === 'gdrive_move_file') {
      const fileId         = validateId(args.file_id, 'file_id');
      const targetFolderId = validateId(args.target_folder_id, 'target_folder_id');

      // Fetch actual parents before removal. Same pattern as gdrive_create_doc.
      const meta = await withRetry(() =>
        drive.files.get({
          fileId,
          fields: 'id, name, parents',
          ...SHARED_DRIVE_FILE,
        })
      );

      const existingParents = (meta.data.parents || []).join(',');

      await withRetry(() =>
        drive.files.update({
          fileId,
          addParents:    targetFolderId,
          removeParents: existingParents || undefined,
          fields:        'id, name, parents',
          ...SHARED_DRIVE_FILE,
        })
      );

      return asText(`Moved "${meta.data.name}" (${fileId}) to folder ${targetFolderId}`);
    }

    // ── gdrive_trash_file ───────────────────────────────────────────────────

    if (name === 'gdrive_trash_file') {
      const fileId = validateId(args.file_id, 'file_id');

      const meta = await withRetry(() =>
        drive.files.get({
          fileId,
          fields: 'id, name',
          ...SHARED_DRIVE_FILE,
        })
      );

      await withRetry(() =>
        drive.files.update({
          fileId,
          requestBody: { trashed: true },
          fields:      'id, trashed',
          ...SHARED_DRIVE_FILE,
        })
      );

      return asText(`Trashed "${meta.data.name}" (${fileId}). Recoverable from Drive trash.`);
    }

    // ── Unknown tool ────────────────────────────────────────────────────────

    return asText(`Unknown tool: ${name}`);

  } catch (err) {
    const message = extractError(err);
    log(`Tool error (${name}):`, message);
    return {
      content: [{ type: 'text', text: `Error: ${message}` }],
      isError: true,
    };
  }
});

// ── Process stability handlers ────────────────────────────────────────────────

process.on('unhandledRejection', (err) => {
  log('Unhandled rejection:', err?.stack || err?.message || String(err));
});

process.on('uncaughtException', (err) => {
  log('Uncaught exception:', err?.stack || err?.message || String(err));
  process.exit(1);
});

// ── Connect ───────────────────────────────────────────────────────────────────

// try/catch here catches fatal transport errors (e.g. stdin already closed).
// Without this, failures at connect() produce untrapped rejections.
try {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  log('Velorin MCP server connected.');
} catch (err) {
  log('FATAL: Failed to connect MCP server:', err?.message || String(err));
  process.exit(1);
}