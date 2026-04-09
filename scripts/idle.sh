#!/usr/bin/env bash
# ============================================
# idle.sh - Idle management with swayidle
# ============================================

set -euo pipefail

lock_screen() {
    if ! pgrep -x hyprlock > /dev/null; then
        hyprlock
    fi
}

hibernate_now() {
    if ! grep -qw "disk" /sys/power/state; then
        echo "Hibernate is not supported by this kernel/platform."
        command -v notify-send > /dev/null && notify-send "Idle" "Hibernate is not supported on this system"
        exit 1
    fi

    if ! swapon --noheadings --show | grep -q .; then
        echo "No active swap detected. Hibernate requires swap."
        command -v notify-send > /dev/null && notify-send "Idle" "Hibernate skipped: no active swap"
        exit 1
    fi

    # Keep display state sane before transitioning power state.
    hyprctl dispatch dpms on || true
    loginctl lock-session || true
    systemctl hibernate
}

if [ "${1:-}" = "--lock-now" ]; then
    lock_screen
    exit 0
fi

if [ "${1:-}" = "--hibernate-now" ]; then
    hibernate_now
    exit 0
fi

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
    timeout "$IDLE_LOCK_SECONDS" '~/.dotfiles/scripts/idle.sh --lock-now'
    timeout "$IDLE_DPMS_SECONDS" 'hyprctl dispatch dpms off'
    resume 'hyprctl dispatch dpms on'
    before-sleep '~/.dotfiles/scripts/idle.sh --lock-now'
    after-resume 'hyprctl dispatch dpms on'
)

if [ "$IDLE_SUSPEND_SECONDS" -gt 0 ]; then
    SWAYIDLE_CMD+=(timeout "$IDLE_SUSPEND_SECONDS" 'systemctl suspend')
fi

if [ "$IDLE_HIBERNATE_SECONDS" -gt 0 ]; then
    SWAYIDLE_CMD+=(timeout "$IDLE_HIBERNATE_SECONDS" '~/.dotfiles/scripts/idle.sh --hibernate-now')
fi

"${SWAYIDLE_CMD[@]}"
