#!/bin/bash
# Claude Code wrapper with auto-notification to user via Telegram
# 
# SETUP:
#   1. cp this file to ~/.claude/run-claude.sh
#   2. chmod +x ~/.claude/run-claude.sh
#   3. Set NOTIFY_TELEGRAM_ID below (or export it as env var)
#
# USAGE:
#   CLAUDE_TASK_NAME="my-task" ~/.claude/run-claude.sh "Task description" --agents '{"dev":{...}}'

# ━━━ Configuration ━━━
NOTIFY_CHANNEL="${NOTIFY_CHANNEL:-telegram}"
NOTIFY_TELEGRAM_ID="${NOTIFY_TELEGRAM_ID:-844871116}"  # Set your Telegram user ID here

# ━━━ Task setup ━━━
TASK="$1"
shift

TASK_NAME="${CLAUDE_TASK_NAME:-$(echo "$TASK" | head -c 50 | tr -d '\n')}"
START_TIME=$(date +%s)

# ━━━ Run Claude Code ━━━
OUTPUT=$(echo "$TASK" | claude \
  --output-format text \
  --permission-mode bypassPermissions \
  --allowedTools "Read,Edit,Write,Bash" \
  "$@" 2>&1)

EXIT_CODE=$?
END_TIME=$(date +%s)
DURATION_SEC=$((END_TIME - START_TIME))
DURATION_MIN=$((DURATION_SEC / 60))
DURATION_REMAINDER=$((DURATION_SEC % 60))

# ━━━ Collect metrics ━━━
CHANGED_FILES=$(git diff --name-only HEAD 2>/dev/null | wc -l || echo "?")

# Extract QA results if present
QA_SUMMARY=""
if echo "$OUTPUT" | grep -q "PASS\|FAIL"; then
  PASS_COUNT=$(echo "$OUTPUT" | grep -c "PASS" || echo "0")
  FAIL_COUNT=$(echo "$OUTPUT" | grep -c "FAIL" || echo "0")
  QA_SUMMARY="🧪 QA: ${PASS_COUNT} PASS / ${FAIL_COUNT} FAIL"
fi

# Extract summary (last 400 chars)
SUMMARY=$(echo "$OUTPUT" | tail -c 400)

# ━━━ Build notification message ━━━
if [ $EXIT_CODE -eq 0 ]; then
  MSG="📋 任务完成报告
━━━━━━━━━━━━━
🏷 任务: ${TASK_NAME}
✅ 状态: 完成
⏱ 耗时: ${DURATION_MIN}m${DURATION_REMAINDER}s
📁 文件变更: ${CHANGED_FILES}
${QA_SUMMARY:+${QA_SUMMARY}
}
📝 摘要:
${SUMMARY:0:300}"
else
  SIGNAL=$(kill -l $EXIT_CODE 2>/dev/null || echo "exit=$EXIT_CODE")
  MSG="📋 任务失败报告
━━━━━━━━━━━━━
🏷 任务: ${TASK_NAME}
❌ 状态: 失败 (${SIGNAL})
⏱ 耗时: ${DURATION_MIN}m${DURATION_REMAINDER}s
📁 文件变更: ${CHANGED_FILES}

📝 错误摘要:
${SUMMARY:0:300}"
fi

# ━━━ Send notification ━━━
# Use sudo to run as root (ubuntu user has no openclaw config)
if [ -n "$NOTIFY_TELEGRAM_ID" ] && command -v openclaw &>/dev/null; then
  sudo openclaw message send --channel "$NOTIFY_CHANNEL" --target "$NOTIFY_TELEGRAM_ID" --message "$MSG" 2>/dev/null || \
  openclaw message send --channel "$NOTIFY_CHANNEL" --target "$NOTIFY_TELEGRAM_ID" --message "$MSG" 2>/dev/null || \
  true
fi

# ━━━ Save output to file for dashboard monitoring ━━━
OUTPUT_DIR="/tmp/claude-tasks"
mkdir -p "$OUTPUT_DIR"
OUTPUT_FILE="$OUTPUT_DIR/${TASK_NAME}.log"
echo "$OUTPUT" > "$OUTPUT_FILE"

# Also save metadata
cat > "$OUTPUT_DIR/${TASK_NAME}.meta.json" <<METAEOF
{
  "taskName": "${TASK_NAME}",
  "exitCode": ${EXIT_CODE},
  "startTime": ${START_TIME},
  "endTime": ${END_TIME},
  "durationSec": ${DURATION_SEC},
  "changedFiles": ${CHANGED_FILES},
  "status": "$([ $EXIT_CODE -eq 0 ] && echo 'completed' || echo 'failed')"
}
METAEOF

echo "$OUTPUT"
exit $EXIT_CODE
