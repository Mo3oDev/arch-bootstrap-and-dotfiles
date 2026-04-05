#!/usr/bin/env bash
# ============================================
# cliphist-cleanup.sh - Wipe clipboard history on logout/shutdown
# ============================================

set -euo pipefail

DB_PATH="${XDG_CACHE_HOME:-$HOME/.cache}/cliphist/db"

if command -v cliphist > /dev/null 2>&1; then
    cliphist wipe > /dev/null 2>&1 || true
fi

# Ensure sqlite side files are removed too
rm -f "$DB_PATH" "$DB_PATH-shm" "$DB_PATH-wal" 2>/dev/null || true
