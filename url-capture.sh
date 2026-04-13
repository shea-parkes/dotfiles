#!/bin/bash
# Captures URLs that CLIs try to open in a browser.
# Installed as both $BROWSER and as an xdg-open shim.
URL_LOG="$HOME/browser-urls.txt"

if [[ "$1" =~ ^https?:// ]]; then
    echo "[$(date -Iseconds)] $1" >> "$URL_LOG"
    echo "URL captured to $URL_LOG:" >&2
    echo "  $1" >&2
else
    # Non-URL argument: try to pass through to the real xdg-open
    real_xdg_open=$(PATH=$(echo "$PATH" | sed "s|$HOME/.local/bin:||g") command -v xdg-open)
    if [[ -n "$real_xdg_open" ]]; then
        exec "$real_xdg_open" "$@"
    fi
fi
