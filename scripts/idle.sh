#!/usr/bin/env bash
# ============================================
# idle.sh - Idle management with swayidle
# ============================================

# Check if swayidle is installed
if ! command -v swayidle &> /dev/null; then
    echo "Error: swayidle not installed"
    echo "Install it with: sudo pacman -S swayidle"
    exit 1
fi

# Defaults (override with env vars in seconds)
# Example: IDLE_HIBERNATE_SECONDS=3600 ~/.dotfiles/scripts/idle.sh
IDLE_LOCK_SECONDS="${IDLE_LOCK_SECONDS:-300}"
IDLE_DPMS_SECONDS="${IDLE_DPMS_SECONDS:-600}"
IDLE_SUSPEND_SECONDS="${IDLE_SUSPEND_SECONDS:-0}"
IDLE_HIBERNATE_SECONDS="${IDLE_HIBERNATE_SECONDS:-0}"

SWAYIDLE_CMD=(
    swayidle -w
    timeout "$IDLE_LOCK_SECONDS" 'hyprlock'
    timeout "$IDLE_DPMS_SECONDS" 'hyprctl dispatch dpms off'
    resume 'hyprctl dispatch dpms on'
    before-sleep 'hyprlock'
)

if [ "$IDLE_SUSPEND_SECONDS" -gt 0 ]; then
    SWAYIDLE_CMD+=(timeout "$IDLE_SUSPEND_SECONDS" 'systemctl suspend')
fi

if [ "$IDLE_HIBERNATE_SECONDS" -gt 0 ]; then
    # If hibernate is unavailable, fall back to suspend.
    SWAYIDLE_CMD+=(timeout "$IDLE_HIBERNATE_SECONDS" 'systemctl hibernate || systemctl suspend')
fi

"${SWAYIDLE_CMD[@]}"
