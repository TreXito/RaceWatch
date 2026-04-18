#!/usr/bin/env bash
# ──────────────────────────────────────────────────────
# RaceWatch Dashboard – Start Server (Linux / macOS)
# Serves the dashboard on http://localhost:9999
# ──────────────────────────────────────────────────────
set -euo pipefail

PORT=9999
DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "  🏁  RaceWatch Dashboard"
echo "  ────────────────────────────────────────"
echo "  Serving from: $DIR"
echo "  Open in your browser:"
echo ""
echo "      http://localhost:$PORT"
echo ""
echo "  Press Ctrl+C to stop the server."
echo "  ────────────────────────────────────────"
echo ""

# Try Python 3 first, then Python 2, then php, then npx
if command -v python3 &>/dev/null; then
    python3 -m http.server "$PORT" --directory "$DIR" --bind 127.0.0.1
elif command -v python &>/dev/null; then
    # Python 2 fallback (cd required, no --directory flag)
    cd "$DIR"
    python -m SimpleHTTPServer "$PORT"
elif command -v php &>/dev/null; then
    php -S "127.0.0.1:$PORT" -t "$DIR"
elif command -v npx &>/dev/null; then
    npx -y http-server "$DIR" -p "$PORT" -a 127.0.0.1 -c-1
else
    echo "ERROR: No suitable HTTP server found."
    echo "Please install one of: python3, php, or Node.js (npx)."
    exit 1
fi
