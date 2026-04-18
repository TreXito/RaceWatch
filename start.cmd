@echo off
:: ──────────────────────────────────────────────────────
:: RaceWatch Dashboard – Start Server (Windows)
:: Serves the dashboard on http://localhost:9999
:: ──────────────────────────────────────────────────────

set PORT=9999
set "DIR=%~dp0"

echo.
echo   🏁  RaceWatch Dashboard
echo   ────────────────────────────────────────
echo   Serving from: %DIR%
echo   Open in your browser:
echo.
echo       http://localhost:%PORT%
echo.
echo   Press Ctrl+C to stop the server.
echo   ────────────────────────────────────────
echo.

:: Try Python 3 first
where python >nul 2>nul
if %ERRORLEVEL% equ 0 (
    python -m http.server %PORT% --directory "%DIR%" --bind 127.0.0.1
    goto :eof
)

:: Try Python via py launcher
where py >nul 2>nul
if %ERRORLEVEL% equ 0 (
    py -3 -m http.server %PORT% --directory "%DIR%" --bind 127.0.0.1
    goto :eof
)

:: Try PHP
where php >nul 2>nul
if %ERRORLEVEL% equ 0 (
    php -S 127.0.0.1:%PORT% -t "%DIR%"
    goto :eof
)

:: Try npx (Node.js)
where npx >nul 2>nul
if %ERRORLEVEL% equ 0 (
    npx -y http-server "%DIR%" -p %PORT% -a 127.0.0.1 -c-1
    goto :eof
)

echo ERROR: No suitable HTTP server found.
echo Please install one of: Python 3, PHP, or Node.js (npx).
pause
