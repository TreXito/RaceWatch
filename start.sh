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

# Prefer server.py: it serves the dashboard for ANY path, so a typo or a
# stale bookmark gets the app instead of a "404 - File not found" page.
if command -v python3 &>/dev/null && [[ -f "$DIR/server.py" ]]; then
    python3 "$DIR/server.py" "$PORT" "127.0.0.1"
elif command -v python3 &>/dev/null; then
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
