# 🏁 RaceWatch Dashboard

A self-contained race watch dashboard that lets you monitor a main YouTube livestream, multiple onboard cameras, and live timing — all in one browser window with automatic scaling.

## Features

- **Main livestream** — embed any YouTube live stream as the primary view
- **Onboard cameras** — add as many onboard streams as you want, side by side
- **Live timing** — embed live timing pages (e.g. `https://livetiming.azurewebsites.net/event=50`)
- **Edit on the fly** — change any URL or label without removing the panel
- **Responsive grid** — panels auto-scale to fit the browser window
- **Layout modes** — choose between *Auto Grid* and *Main + Side* layouts
- **Fullscreen per panel** — expand any panel to fill the screen (press `Esc` to exit)
- **Persistent state** — your layout is saved in the browser's localStorage
- **Zero dependencies** — single HTML file, no build step

## Quick Start

### Linux / macOS

```bash
./start.sh
```

### Windows

```cmd
start.cmd
```

Both scripts start an HTTP server on **http://localhost:9999** using the first available tool: Python 3, PHP, or Node.js (`npx`).

Open **http://localhost:9999** in your browser and start adding panels.

## Requirements

One of the following must be installed to serve the files:

| Runtime | Linux/macOS | Windows |
|---------|-------------|---------|
| Python 3 | `python3` | `python` or `py` |
| PHP | `php` | `php` |
| Node.js | `npx` | `npx` |

## Usage

1. Click **+ Stream** to add a main YouTube livestream (e.g. `https://youtu.be/9FJKUkAVz1U`)
2. Click **+ Onboard** to add onboard camera feeds
3. Click **+ Timing** to add a live timing iframe
4. Use the **Layout** dropdown to switch between grid modes
5. Click the ✎ button on any panel to edit its URL or label
6. Click the ⛶ button to toggle fullscreen on a panel
7. Click × to remove a panel, or **Clear All** to reset
