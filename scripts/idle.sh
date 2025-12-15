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

# Run swayidle
swayidle -w \
    timeout 300 'hyprlock' \
    timeout 600 'hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on' \
    before-sleep 'hyprlock'
