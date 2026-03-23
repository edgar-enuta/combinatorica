#!/bin/bash
# Run luacheck across all Combinatorica mods.
# Usage: ./utils/lint.sh [mod_name]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GAME_DIR="$(dirname "$SCRIPT_DIR")"

if ! command -v luacheck &> /dev/null; then
    echo "Error: luacheck not found. Install with: luarocks install luacheck"
    exit 1
fi

if [ -n "$1" ]; then
    # Lint a specific mod
    MOD_PATH="$GAME_DIR/mods/$1"
    if [ ! -d "$MOD_PATH" ]; then
        echo "Error: mod '$1' not found at $MOD_PATH"
        exit 1
    fi
    echo "Linting mod: $1"
    luacheck "$MOD_PATH" --config "$GAME_DIR/.luacheckrc"
else
    # Lint all mods
    echo "Linting all mods in $GAME_DIR/mods/"
    luacheck "$GAME_DIR/mods/" --config "$GAME_DIR/.luacheckrc"
fi

echo "Done."
