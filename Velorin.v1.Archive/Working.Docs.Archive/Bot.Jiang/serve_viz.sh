#!/bin/bash
# Velorin System Viz — Local WiFi Server
# Run this, then open the IP:8765 URL from any device on the same WiFi

PORT=8765
DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "  Velorin System Intelligence"
echo "  ─────────────────────────────────────────"
echo "  Serving: $DIR"
echo ""
echo "  Local:   http://localhost:$PORT/Jiang.SystemViz.Apr4.html"
echo ""

# Get WiFi IP
IP=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null || echo "unknown")
if [ "$IP" != "unknown" ]; then
  echo "  Network: http://$IP:$PORT/Jiang.SystemViz.Apr4.html"
fi

echo ""
echo "  Open the Network URL from any device on the same WiFi."
echo "  Ctrl+C to stop."
echo "  ─────────────────────────────────────────"
echo ""

cd "$DIR"
python3 -m http.server $PORT
