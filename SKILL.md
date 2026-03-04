## 1. Project Goal

Complete the `clawd-saas` Evolution Blueprint (Phase 3-5) with 100% quality and deliver production-ready systems, including:
-   Phase 1-2: OpenClaw Core, Chat UX, i18n, Worker sync, Domain.
-   Phase 3+: Appointments, Multi-Staff, Products, Orders, Payments, RBAC, Themes.
-   EzServe standalone landing page (multi-language, SEO, Footer, Legal).
-   Knowledge Chat JSON display bug fix, auto-sync.
-   Telegram `/start` parameter lead source tracking.

## 2. Current Progress

### Done
-   All Phase 1-2 features merged.
-   All Phase 3+ features implemented.
-   Telegram bot "Sorry, I could not process that right now" error fix for new users.
-   EzServe standalone landing page with 5-language support, comprehensive SEO, Footer, Legal pages.
-   Telegram `/start` parameter lead source tracking.
-   Knowledge Chat JSON display bug — fully fixed (nested JSON unwrapping + DB cleanup).
-   Knowledge Chat save auto-sync to agents.knowledge_md.
-   `defaultModel` set to `google/gemini-2.5-flash` globally.
-   Comprehensive `README.md` for new VPS deployment.
-   All code pushed to GitHub `main` branch.

### In Progress


## 3. Constraints & Preferences (CRITICAL)

-   **Development/QA tasks**: Use Claude Code CLI with `--agents` (user's Max 5x subscription, saves OpenClaw tokens).
-   **Non-dev tasks (research/analysis/messaging)**: Use `sessions_spawn` (OpenClaw).
-   **SOP Rule**: Use `sessions_spawn` only when Claude Code is unavailable; continue with Claude Code when it works.
-   **Simple 1-2 line hotfixes**: PM can fix directly.
-   **ALL code changes must go through sub-agents** (PM must not write code, must stay responsive to user).
-   **Must use `--agents` Agent Teams** for all Claude Code tasks.
-   **Dev + QA must be ONE dispatch** — never split into two.
-   **NEVER set timeout on exec** — causes SIGKILL, `run-claude.sh` notification won't fire.
-   **PM must proactively report** on every System: Exec completed/failed.
-   **`run-claude.sh` auto-notifies user via Telegram** (`sudo openclaw message send --channel telegram --target 844871116`).
-   **Always rebuild + restart after Claude Code completes**.
-   **Verify Nginx config after Claude Code tasks**.
-   **Shell quoting for Claude Code tasks**: Complex task descriptions should use `cat /tmp/taskfile.txt` pattern.
-   **5th language is Tamil (ta), NOT Japanese (ja)**.
-   **`paginatedResponse` returns `items` key**: Frontend must always try `data.items || data.orders || data.data || []`.
-   **API snake_case → Frontend camelCase mapping**.
-   **Web search priority**: `web_fetch` first (free), `web_search` (Brave) only as last resort.
-   **`config.patch agents.list` is destructive**: Use Python script to modify `openclaw.json` directly instead.
-   **Workspace paths must use colon format**: `saas:tenantId:agentId` (matches Worker sync output).
-   **Slim instructions for Gemini Flash**: Total system context <7KB (AGENTS.md, SOUL.md, IDENTITY.md).
-   **SIGKILL on Claude Code exec = silent failure**: PM must monitor for exec failures and proactively report/re-dispatch.
-   **Playwright causes OOM on 8GB server**: Avoid Playwright for screenshots, use `curl`/API tests instead.
-   **`shadcn <SelectItem value="">` causes white screen crash**: Must use non-empty value like `"all"` for "All" options.
-   **Telegram media: don't store locally**.
-   **`contacts.phone` must be nullable**.
-   **Table name is `conversation_messages` not `messages`**.
-   **Frontend contacts page uses `/tenant/customers` not `/tenant/contacts`**.
-   **Gemini Flash truncates long strings in tool calls**: Use shell variables (`$API`, `$TOKEN`, `$TENANT`, `$AGENT`).
-   **OpenClaw Gateway sends "No response from OpenClaw." fallback**: Agent must always reply with actual text.
-   **Knowledge updates must go through DB → Worker → workspace flow**.
-   **Never expose internal IPs in knowledge**.
-   **Never delete sessions/data without asking user first**.
-   **Don't ask user when reference image is provided**.
-   **LLM returns nested JSON in Knowledge Chat**: Must unwrap nested JSON before extracting reply text.
-   **Knowledge Chat messages stored in `agent_setup_messages` table**.
-   **Knowledge Chat save must sync to `agents.knowledge_md`**.
-   **Telegram bot connect must auto-enable `webhook_enabled`**.
-   **PM2 fresh start (`pm2 delete` + `pm2 start`) over `pm2 restart`** for compiled code changes.
-   **Landing page must be view-only (no backend)** for standalone version.
-   **Must support 5 languages**: en, zh-CN, zh-TW, ms, ta.
-   **Git repo must use `main` branch** (not `master`).
-   **For AI-CS update**: preserve login button + purchase flow + 5-language switcher.
-   **Visual consistency**: Use direct Tailwind colors instead of CSS variables.
-   **PM role is PM (project manager), not developer**.
-   **Solve problems autonomously** ("有問題就解決問題").

## 4. Key Decisions

-   **Use Claude Haiku 4.5**: For `sessions_spawn` sub-agents (cost control).
-   **Claude Code CLI for Dev/QA**: Saves OpenClaw tokens, uses user's Max 5x subscription.
-   **SOP: Claude Code vs. `sessions_spawn`**: Use `sessions_spawn` only when Claude Code is unavailable.
-   **ALL code changes via sub-agents**: PM must never write code directly.
-   **Smart SSH Detection**: Auto-detect local vs. remote.
-   **Domain Strategy**: Use `ai-cs.mytsh.cloud` subdomain (now placeholder `your-public-domain.com`).
-   **Knowledge via `memory/` not `KNOWLEDGE.md`**: OpenClaw only reads fixed filenames.
-   **Appointment webhook over MCP tools**: Agent uses `exec` + `curl`.
-   **Per-category knowledge files**: Multiple knowledge files by category.
-   **`VITE_API_URL=/api`**: Must use relative path for production.
-   **Always update `TOOLS.md` with ALL operations**.
-   **Recurring PG date fix pattern**: Always use `.split('T')[0]` for `<input type="date">`.
-   **Step-by-step Claude Code for large tasks**: Break into smaller chunks to avoid SIGKILL.
-   **Must use Agent Teams `--agents`**.
-   **Skip OpenSpec for direct implementation**.
-   **Knowledge Page 3-tab structure**: 知识列表 | 对话 | 权限.
-   **LLM JSON fallback for OpenClaw Gateway**: Gateway ignores `response_format: json_object`.
-   **Dev + QA in ONE dispatch**.
-   **NEVER set exec timeout**.
-   **Auto Telegram notification**.
-   **Google Calendar timezone**: Must use tenant timezone from `appointment_settings.timezone`.
-   **Worker auto-appends to AGENTS.md**.
-   **Availability checks Working Schedule + Block Dates**.
-   **`openclawWorkspaceId` must be passed to enqueue**.
-   **Customer lookup uses `contacts` table not `customers` table**.
-   **`TOOLS.md` must have real gateway token**.
-   **Agent silent retry on lookup failure**.
-   **Always rebuild + restart after Claude Code**.
-   **Verify Nginx after Claude Code**.
-   **RBAC split into Backend + Frontend**.
-   **30% net profit share**.
-   **Gemini 2.5 Flash for production AI CS**.
-   **Model Routing for cost optimization**.
-   **Gemini Free Tier viable for early stage**.
-   **OpenClaw JSONL usage at `entry.message.usage`**.
-   **`sessions.json` maps `sessionKey`→`UUID sessionId`**.
-   **Admin-only for token/cost data**.
-   **Revenue in RM, costs in USD**.
-   **Dashboard shows total profit, not personal 30% split**.
-   **Landing Page RM pricing**.
-   **Webhook Hub 3-layer architecture**.
-   **Webhook dual trigger modes**.
-   **Event triggers are fire-and-forget**.
-   **Shell quoting for large tasks**.
-   **API error detail propagation**.
-   **Inline errors in dialogs instead of toasts**.
-   **Multi-Staff Scheduling: Least-loaded default**.
-   **Staff can reject/reassign appointments**.
-   **Customer can request specific staff**.
-   **Google Calendar per-staff, fallback to system schedule**.
-   **Staff without personal Google Calendar = available**.
-   **Product name: EzServe**.
-   **Voice messages deferred**.
-   **Billing/subscription deferred**.
-   **Email notifications deferred**.
-   **Product + Order management is next priority**.
-   **AI Integration merged into Order Management task**.
-   **Order search uses `/tenant/customers` not `/tenant/contacts`**.
-   **`paginatedResponse` standard returns `items` key**.
-   **Order `contactId` removed from frontend**.
-   **AI must query product catalog before knowledge base**.
-   **Worker auto-generates Product Search + Order Creation in `TOOLS.md`**.
-   **Payment module with Malaysia-specific methods**.
-   **Lucide icons instead of emoji**.
-   **Always `parseFloat` API amounts**.
-   **`web_fetch` over `web_search`**.
-   **Brave Search Free Plan = 1,000 queries/month**.
-   **`config.patch agents.list` is destructive**.
-   **Least-loaded tiebreaker must be random**.
-   **RBAC enforcement pattern**: 179 `requireTenantPermission` calls.
-   **Workspace paths must use colon format**.
-   **Slim instructions for Gemini Flash**.
-   **Customer Lookup must be STEP 1**.
-   **Setup chats inject knowledge content**.
-   **Conversation history patterns override system instructions**.
-   **Default templates must be plug-and-play**.
-   **Double `/api/api/` in webhook URLs is correct**.
-   **SIGKILL on Claude Code is silent**.
-   **UI Theme = CSS variables + conditional layout**.
-   **Theme switching is "换壳不换芯"**.
-   **Calendar tab defaults to System Calendar when not connected**.
-   **Per-user calendar endpoints**.
-   **`run-claude.sh` saves output to `/tmp/claude-tasks/`**.
-   **Theme colors + layout both changeable**.
-   **Avoid Playwright on production server**.
-   **Telegram per-agent bot via `clawd-saas`**.
-   **Telegram manual-message channel detection**.
-   **Telegram and WhatsApp feature parity**.
-   **`AGENTS.md` must reference `KNOWLEDGE.md` explicitly**.
-   **Conversation polling: silent + smart diff**.
-   **Frontend contacts page uses `/tenant/customers` not `/tenant/contacts`**.
-   **`TOOLS.md` uses shell variables for long IDs**.
-   **Product Search supports GET + POST**.
-   **`knowledge-synthesized.md` is redundant**.
-   **`KNOWLEDGE.md` can be deleted if `knowledge-public.md` covers same content**.
-   **Token usage already tracked in `conversation_messages`**.
-   **Retry on empty OpenClaw response**.
-   **Standalone repo architecture**.
-   **CSS theme variables**.
-   **Force push to `main`**.
-   **PM2 for preview**.
-   **Visual Standardization**.
-   **Contact Channels**: WhatsApp and Telegram as equal primary contact methods.
-   **EzServe domain is `ezserve.com.my`**.
-   **Telegram official brand color is `#229ED9`**.
-   **Knowledge updates through DB not workspace files**.
-   **BullMQ + Redis for Worker job queue**.
-   **Worker merges `knowledge_md` into `AGENTS.md`**.
-   **Telegram `/start` deep linking for lead tracking**.
-   **WhatsApp text pre-fill for lead identification**.
-   **Plan ID mismatch pattern**: Frontend `plans.ts` defines IDs; API checkout validates IDs separately; must keep in sync — no shared constant.
-   **Knowledge Chat save must auto-sync**.
-   **Telegram bot connect auto-enables webhook**.
-   **PM2 fresh start over `pm2 restart`** for code changes.

## 5. PM Agent Workflow & Responsibilities

### 5.1 Core Identity
I am **Alex (PM - 项目经理)**, not a developer. My vibe is analytical, autonomous, quality-focused, and coordination-oriented. My emoji is 🦾.

### 5.2 Core Responsibilities (✅ DO)
1.  **Analyze Problems**: Diagnose root causes, plan solutions.
2.  **Dispatch Development Tasks**:
    *   **Dev/QA tasks**: Use `exec` + Claude Code CLI (via `~/.claude/run-claude.sh` wrapped script, `su - ubuntu -c '...'`). This uses the user's Max subscription, saving OpenClaw tokens.
    *   **Non-dev tasks** (research/analysis/ops): Use `sessions_spawn` (OpenClaw).
3.  **Dispatch QA Verification**: After development, run QA via Claude Code.
4.  **Iterative Fixes**: If QA fails, dispatch Dev to fix, then re-QA until 100% PASS.
5.  **Basic Acceptance**: Final check (not deep, trust QA results).
6.  **Deliver Results**: Confirm everything is correct, then deliver to the user.

### 5.3 Prohibited Actions (❌ DON'T)
-   **Never skip QA directly deliver major features** (violation of SOP).
-   **Never set `exec` timeout** (causes SIGKILL, `run-claude.sh` notification won't fire).
-   **Never receive System notifications and not proactively report** (must immediately notify user).
-   **Never dispatch Dev and QA separately** (must combine into one Claude Code task).
-   **Never write substantial code myself** (1-2 line hotfixes are exceptions, large features *must* be dispatched).

### 5.4 Hotfix Permissions
-   **Simple 1-2 line bug fixes** can be done directly by me, without spawning a Sub-Agent.
-   Examples: SQL typo, missing symbol, date format, CSS/scroll fixes.
-   **Standard**: Changes are clear, small scope, no architectural decisions needed.
-   **Complex features/multi-file changes** must still follow the full SOP (Dev → QA → Deliver).

### 5.5 Claude Code Development Workflow

**Dev + QA combined into one Claude Code dispatch (saves tokens + time):**

My standard workflow for dispatching Claude Code tasks, including auto-notifications and metrics collection, is encapsulated in the `run-claude.sh` script.

**Refer to the `run-claude.sh` file in this skill's directory for the full script.**

```bash
# Example usage:
su - ubuntu -c 'cd /root/clawd-saas && CLAUDE_TASK_NAME="task-name" ~/.claude/run-claude.sh "TASK" \
  --agents '"'"'{"dev":{"description":"...","prompt":"..."},"qa":{"description":"QA tester","prompt":"..."}}'"'"' \
  2>&1'
```

**⚠️ Mandatory Rules for Claude Code:**
-   **Dev + QA Combined**: One dispatch for both development and testing.
-   **No OpenSpec**: Pipe mode doesn't support multi-turn interaction; direct implementation is faster and more stable.
-   **Must use `su - ubuntu -c`**: `root` user is not allowed to bypass permissions.
-   **Must use `~/.claude/run-claude.sh`**: Automatically sends Telegram notifications to the user upon completion.
-   **Must use `--agents` Agent Teams**: User mandated for parallel processing.
-   **Absolutely NO timeout**: Use `background: true`, no `timeout` parameter. Violating this leads to SIGKILL.
-   **`pm2 restart` is manual**: `ubuntu` user lacks permissions for PM2 management.

**📐 Task Description Template (Mandatory Adherence):**
```
Implement directly. Do not use openspec.

## Task: [One-line Goal]

### Context
- Project: /root/clawd-saas
- [Relevant file paths]
- DB: postgresql://clawd:clawd@localhost:5433/clawd_saas
- i18n: apps/web/src/lib/i18n.ts (5 languages: en, zh, zhTW, ms, ta)

### Known Bug Patterns (MUST AVOID)
- CRITICAL: NEVER use `<SelectItem value="">` in shadcn — causes white screen crash. Use `value="all"` instead, and add `&& value !== 'all'` in filter logic.
- CRITICAL: Before adding new API routes, search existing routes with `grep "app.get\|app.post" | grep "route-path"` to avoid Fastify duplicate route crash.
- CRITICAL: Frontend API response — always use `data.items || data.data || []` to handle both key formats.

### Step-by-step (Dev)
1. READ [specific file] to understand current code
2. CREATE/ALTER DB tables via Bash (node + pg)
3. ADD API endpoints
4. UPDATE frontend
5. ADD i18n keys for all 5 languages
6. RUN: cd apps/api && npm run build (0 errors)
7. RUN: cd apps/web && npx vite build (0 errors)

### QA Tests (must run ALL, report PASS/FAIL)
Test 1: [API test]
Test 2: [Frontend verification]
Test 3: [Playwright E2E screenshot] (Note: Avoid Playwright on 8GB server if OOM occurs; use curl/API tests instead)
Test N: [Build verification]
Final: X/N PASS
```

### 5.6 QA Verification & Iteration

**Mandatory Checklist for QA Testing:**
-   **DB Verification**: Schema/Migration/data integrity.
-   **API Testing**: `curl` to verify functionality, edge cases, status codes.
-   **Log Analysis**: `grep` for error patterns, verify PM2/service logs.
-   **Code Review**: Minimal changes, no hardcoding, backward compatibility.
-   **Regression Testing**: Related endpoints/features unaffected.
-   **Build Verification**: `npm run build` & service status (0 errors).
-   **Evidence Required**: API returns 200 ✅, logs no Error ✅, build passes ✅, Playwright E2E 100% PASS ✅ (if applicable).

### 5.7 Mandatory Checklist Before Reporting "Done"

**Before reporting "completed"/"delivered"/"ready for test" to the user, ensure ALL of the following:**
-   [ ] Dev Sub-Agent completed development?
-   [ ] I (PM) reviewed the code/changes?
-   [ ] I dispatched an independent QA Sub-Agent?
-   [ ] QA report received?
-   [ ] QA report is 100% PASS?
-   [ ] If FAIL, I dispatched Dev to fix and re-QA?

**If ANY item is NO → DO NOT report "completed" to the user.**
**Violation of this rule = severe dereliction of duty.**

### 5.8 Proactive Communication

-   **CRITICAL**: Upon receiving any `System: Exec completed/failed` notification → **immediately and proactively inform the user** of the status + next steps. Never wait for the user to ask.
-   If SIGKILL/failure → immediately inform the user + explain cause + take corrective action.
-   I am a proactive communicator, not a passive one.

## 6. Knowledge Management & Sync Pipeline

This describes the journey of knowledge from creation in the UI to being understood by the AI agent.

### Workflow:
1.  **User creates/edits knowledge** in `clawd-saas` Admin UI ("Knowledge Chat" feature).
2.  **Knowledge is saved**:
    *   `agent_knowledge_notes` table is updated (draft_content → content).
    *   `agents.knowledge_md` column in the `agents` table is updated with the combined knowledge.
    *   An `openclaw.sync.agent` job is enqueued in BullMQ (via `@clawd/shared` `enqueue()` function).
3.  **Worker processes `openclaw.sync.agent` job**:
    *   Reads `agents.knowledge_md` from the database.
    *   **Writes `AGENTS.md` to agent's OpenClaw workspace**: This file now contains:
        *   Core agent workflow instructions.
        *   **CRITICAL**: Knowledge Base Instructions explicitly stating that knowledge is *within this file* and in `MEMORY.md`, and that the bot should *directly answer* from it (NEVER say "产品目录正在更新中").
        *   The actual knowledge content is appended to `AGENTS.md`.
    *   **Writes `memory/knowledge-{key}.md` files**: For categorization of knowledge in the `memory/` subdirectory.
    *   **Writes `MEMORY.md` to agent's OpenClaw workspace**: This is a combined version of all knowledge, serving as the primary index for OpenClaw's `memory_search` tool.
    *   **Clears all existing sessions** for that agent: Deletes `*.jsonl` files and resets `sessions.json` to `{}`. This ensures the agent creates a fresh session and loads the newly updated `AGENTS.md` and `MEMORY.md`.
    *   Updates `agents.sync_status` to `'synced'` in the database.
4.  **Bot receives new message**:
    *   A new session is created.
    *   OpenClaw loads the updated `AGENTS.md`, `SOUL.md`, `IDENTITY.md`, and `MEMORY.md` into the system prompt.
    *   The bot (Gemini Flash by default) now has all the knowledge embedded directly in its context and explicit instructions to use it.
    *   If `memory_search` is still performed (e.g., for very specific, long-tail queries), it will now find content in `MEMORY.md`.

### CRITICAL RULES for Knowledge:
-   **DO NOT say "产品目录正在更新中"** or similar phrases. The bot *always* has the latest information.
-   **Answer directly from provided knowledge**.
-   Knowledge updates **MUST** go through the DB → Worker → workspace flow. Direct file edits are unreliable.

## 7. OpenClaw Gateway & Model Configuration

-   **OpenClaw Gateway**: The central hub for all `clawd-saas` agent communication.
    *   Must be running (`openclaw gateway status`).
    *   `OPENCLAW_GATEWAY_URL` and `OPENCLAW_GATEWAY_TOKEN` in `.env` connect the Worker to it.
-   **Default LLM Model**: Globally configured to `google/gemini-2.5-flash` in `~/.openclaw/openclaw.json` at `agents.defaults.model.primary` to optimize costs.
    *   Ensure `google/gemini-2.5-flash` is also listed under `agents.defaults.models` with an alias (`gemini-flash`).
    *   API keys for Google (and Anthropic for fallbacks, if configured) must be set via `openclaw auth set ...`.
-   **Session Clearing on Sync**: Essential to ensure model configuration changes are picked up by agents.

## 8. Troubleshooting Guide

-   **"No API key found for provider \'anthropic\'"**:
    1.  Ensure `agents.defaults.model.primary` in `~/.openclaw/openclaw.json` is `google/gemini-2.5-flash`.
    2.  Ensure Google auth is configured (`openclaw auth set google ...`).
    3.  If Anthropic is used as a fallback, ensure `ANTHROPIC_API_KEY` is present in `.env` and `openclaw auth set anthropic ...` is configured.
-   **Bot says "产品目录正在更新中"**: This indicates knowledge is not being read.
    1.  Verify `MEMORY.md` and `memory/knowledge-*.md` exist in the agent\'s workspace (`~/.openclaw/workspaces/saas:tenantId:agentId/`).
    2.  Ensure `clawd-saas-worker` is running and syncing correctly (check `pm2 logs clawd-saas-worker` for `openclaw_agent_synced`).
    3.  Verify agent\'s `AGENTS.md` instructions correctly point to internal knowledge (e.g., \"Knowledge Base is in THIS FILE\" instead of \"use memory_search\").
-   **No response from bot (Telegram/WhatsApp)**:
    1.  Check `clawd-saas-api` logs for incoming webhook requests (`pm2 logs clawd-saas-api`).
    2.  Verify Nginx routing for `/telegram/webhook` or `/whatsapp/webhook`.
    3.  Ensure `webhook_enabled = true` for the agent in the database (this should be automated on bot connection).
    4.  Check `openclaw gateway status` and `openclaw status`.
-   **Gateway restart overwrites `openclaw.json`**:
    1.  Manually verify `~/.openclaw/openclaw.json` after Gateway restarts.
    2.  If it reverts, re-apply the changes (using direct JSON edit or `openclaw config set agents.defaults.model.primary ...`) and investigate why it\'s reverting (e.g., permissions, automated config restore).
-   **PM Agent unresponsive during Compaction**: Normal behavior. Agent is busy processing history.

