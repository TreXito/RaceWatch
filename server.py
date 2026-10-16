#!/usr/bin/env python3
"""RaceWatch dashboard server.

Serves the dashboard for EVERY path. Python's stock `python -m http.server`
answers unknown paths (typos like /racewarch, stale bookmarks) with its
"404 - Message: File not found." page; this handler instead falls back to
index.html, so the dashboard always loads.

Usage:  python3 server.py [PORT] [BIND]
"""

import os
import sys
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer

ROOT = os.path.dirname(os.path.abspath(__file__))


class DashboardHandler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=ROOT, **kwargs)

    def send_head(self):
        path = self.translate_path(self.path)
        if path.endswith("favicon.ico") and not os.path.exists(path):
            # no favicon on purpose: answer quietly instead of a 404 in the log
            self.send_response(204)
            self.end_headers()
            return None
        if not os.path.exists(path):
            # unknown path (typo, bookmark, trailing junk) -> serve the app
            self.path = "/index.html"
        return super().send_head()

    def end_headers(self):
        self.send_header("Cache-Control", "no-store")
        super().end_headers()


def main():
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 9999
    bind = sys.argv[2] if len(sys.argv) > 2 else "127.0.0.1"
    print("")
    print("  RaceWatch Dashboard")
    print("  Serving from: " + ROOT)
    print("  Open in your browser:")
    print("")
    print("      http://localhost:%d" % port)
    print("")
    print("  Every path serves the dashboard (no 404 pages).")
    print("  Press Ctrl+C to stop the server.")
    print("")
    ThreadingHTTPServer((bind, port), DashboardHandler).serve_forever()


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nServer stopped.")
