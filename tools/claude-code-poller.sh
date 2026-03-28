#!/bin/bash
# VELORIN COMMAND BUS POLLER
# Drop this in terminal and leave it running.
# Alexander writes instructions to GitHub. This picks them up and runs them via Claude Code.

REPO="navyhellcat/velorin-system"
FILE="tools/command-bus.md"

echo "[POLLER] Started. Polling every 30 seconds."
echo "[POLLER] $(date -u +%Y-%m-%dT%H:%M:%SZ) — Ready."

while true; do
  RESPONSE=$(curl -s "https://api.github.com/repos/$REPO/contents/$FILE" \
    -H "Authorization: token $(git config --global github.token 2>/dev/null || cat ~/.git-credentials 2>/dev/null | grep -o 'ghp_[^@]*' | head -1)")

  SHA=$(echo "$RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['sha'])" 2>/dev/null)
  CONTENT=$(echo "$RESPONSE" | python3 -c "import sys,json,base64; print(base64.b64decode(json.load(sys.stdin)['content']).decode())" 2>/dev/null)
  STATUS=$(echo "$CONTENT" | grep -A1 "^## STATUS" | tail -1 | tr -d '[:space:]')

  if [[ "$STATUS" == sent.* ]]; then
    TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)
    echo "[POLLER] $TIMESTAMP — Executing."
    INSTRUCTION=$(echo "$CONTENT" | awk '/^## NEW INSTRUCTION/{found=1; next} /^## RESULTS/{found=0} found && NF')
    RESULT=$(echo "$INSTRUCTION" | claude -p 2>&1)
    echo "[POLLER] Result: $RESULT"

    NEW_CONTENT=$(echo "$CONTENT" \
      | sed "s/^sent\..*/received.$TIMESTAMP/" \
      | awk -v r="$RESULT" -v ts="$TIMESTAMP" '
        /^## RESULTS/{print; print r; next}
        /^## LOG/{print; print ts " — Executed"; next}
        {print}')

    ENCODED=$(echo "$NEW_CONTENT" | base64)
    curl -s -X PUT "https://api.github.com/repos/$REPO/contents/$FILE" \
      -H "Authorization: token $(git config --global github.token 2>/dev/null || cat ~/.git-credentials 2>/dev/null | grep -o 'ghp_[^@]*' | head -1)" \
      -H "Content-Type: application/json" \
      -d "{\"message\":\"result $TIMESTAMP\",\"content\":\"$ENCODED\",\"sha\":\"$SHA\"}" > /dev/null

    echo "[POLLER] Done. Waiting."
  fi

  sleep 30
done
