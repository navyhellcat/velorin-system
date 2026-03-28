#!/bin/bash
# VELORIN COMMAND BUS POLLER
# Run once in terminal. Polls GitHub every 30 seconds.
# Alexander writes instructions to command-bus.md. This executes them. Results go back to GitHub.
# PAT must be set as environment variable: export GITHUB_PAT="your_token"

REPO="navyhellcat/velorin-system"
FILE="tools/command-bus.md"
PAT="${GITHUB_PAT}"

if [ -z "$PAT" ]; then
  echo "[ERROR] GITHUB_PAT environment variable not set. Run: export GITHUB_PAT=your_token"
  exit 1
fi

echo "[POLLER] Command bus started. Polling every 30 seconds."
echo "[POLLER] $(date -u +%Y-%m-%dT%H:%M:%SZ) — Ready."

while true; do
  RESPONSE=$(curl -s -H "Authorization: token $PAT" \
    "https://api.github.com/repos/$REPO/contents/$FILE")

  SHA=$(echo "$RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['sha'])" 2>/dev/null)
  CONTENT=$(echo "$RESPONSE" | python3 -c "import sys,json,base64; print(base64.b64decode(json.load(sys.stdin)['content']).decode())" 2>/dev/null)

  STATUS=$(echo "$CONTENT" | grep -A1 "^## STATUS" | tail -1 | tr -d '[:space:]')

  if [[ "$STATUS" == sent.* ]]; then
    TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)
    echo "[POLLER] $TIMESTAMP — Instruction received. Executing."

    INSTRUCTION=$(echo "$CONTENT" | awk '/^## NEW INSTRUCTION/{found=1; next} /^## RESULTS/{found=0} found && NF')

    RESULT=$(echo "$INSTRUCTION" | claude -p 2>&1)

    NEW_CONTENT=$(echo "$CONTENT" \
      | sed "s/^sent\..*/received.$TIMESTAMP/" \
      | awk -v result="$RESULT" -v ts="$TIMESTAMP" '
        /^## RESULTS/{print; print result; next}
        /^## LOG/{print; print ts " — Executed"; next}
        {print}
      ')

    ENCODED=$(echo "$NEW_CONTENT" | base64)
    curl -s -X PUT \
      -H "Authorization: token $PAT" \
      -H "Content-Type: application/json" \
      -d "{\"message\":\"Claude Code result $TIMESTAMP\",\"content\":\"$ENCODED\",\"sha\":\"$SHA\"}" \
      "https://api.github.com/repos/$REPO/contents/$FILE" > /dev/null

    echo "[POLLER] $TIMESTAMP — Done. Waiting."
  fi

  sleep 30
done
