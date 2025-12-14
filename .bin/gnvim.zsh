#!/bin/bash

# Fixed global socket
SOCKET="/tmp/godothost"

# Godot passes: file line column (plus sometimes project, but we ignore extras)
FILE="$1"
LINE="$2"
COL="$3"

if [ -z "$FILE" ] || [ -z "$LINE" ] || [ -z "$COL" ]; then
  echo "Usage: $0 <file> <line> <col>"
  exit 1
fi

# If socket exists, send remote command to existing Neovim instance
if [ -S "$SOCKET" ]; then
  nvim --server "$SOCKET" --remote-send "<C-\><C-N>:n +call\ cursor($LINE,$COL) $FILE<CR>"
else
  # No server: launch new Neovim instance listening on the socket
  # Adjust your terminal emulator if needed (e.g., alacritty, kitty, wezterm)
  # For no new terminal (if Godot launches in background), use direct launch:
  nvim --listen "$SOCKET" "+call cursor($LINE,$COL)" "$FILE"
  
  # Alternative: Open in new terminal window (uncomment if preferred)
  # alacritty -e nvim --listen "$SOCKET" "+call cursor($LINE,$COL)" "$FILE"
fi
