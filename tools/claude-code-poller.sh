#!/bin/bash
# VELORIN COMMAND BUS POLLER
# Claude Code runs this. Polls GitHub every 30 seconds.
# When Alexander writes a new instruction (STATUS = sent), this executes it and reports back.

REPO="navyhellcat/velorin-system"
FILE="tools/command-bus.md"
RAW_URL="https://raw.githubusercontent.com/$REPO/main/$FILE"
PAT="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"

echo "[POLLER] Claude Code command bus started. Polling every 30 seconds."
echo "[POLLER] $(date -u +%Y-%m-%dT%H:%M:%SZ) — Ready."

while true; do
  # Fetch current bus file
  CONTENT=$(curl -s -H "Authorization: token $PAT" \
    "https://api.github.com/repos/$REPO/contents/$FILE" \
    | python3 -c "import sys,json,base64; d=json.load(sys.stdin); print(base64.b64decode(d['content']).decode())")

  SHA=$(curl -s -H "Authorization: token $PAT" \
    "https://api.github.com/repos/$REPO/contents/$FILE" \
    | python3 -c "import sys,json; print(json.load(sys.stdin)['sha'])")

  STATUS=$(echo "$CONTENT" | grep "^## STATUS" -A1 | tail -1)

  if [[ "$STATUS" == sent.* ]]; then
    TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)
    echo "[POLLER] $TIMESTAMP — New instruction detected. Executing."

    # Extract instruction
    INSTRUCTION=$(echo "$CONTENT" | awk '/^## NEW INSTRUCTION/{found=1; next} /^## RESULTS/{found=0} found && NF')

    # Execute instruction via Claude Code
    RESULT=$(claude -p "$INSTRUCTION" 2>&1)

    # Write results back to bus
    NEW_CONTENT=$(echo "$CONTENT" \
      | sed "s/^sent\..*/received.$TIMESTAMP/" \
      | awk -v result="$RESULT" -v ts="$TIMESTAMP" '
        /^## RESULTS/{print; print result; next}
        /^## LOG/{print; print ts " — Executed by Claude Code"; next}
        {print}
      ')

    # Push updated file to GitHub
    ENCODED=$(echo "$NEW_CONTENT" | base64)
    curl -s -X PUT \
      -H "Authorization: token $PAT" \
      -H "Content-Type: application/json" \
      -d "{\"message\":\"Claude Code: instruction received $TIMESTAMP\",\"content\":\"$ENCODED\",\"sha\":\"$SHA\"}" \
      "https://api.github.com/repos/$REPO/contents/$FILE" > /dev/null

    echo "[POLLER] $TIMESTAMP — Results written. Waiting for next instruction."
  fi

  sleep 30
done
