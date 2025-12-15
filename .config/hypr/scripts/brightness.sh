#!/usr/bin/env bash
# ============================================
# brightness.sh - Brightness control with notifications
# ============================================

case "$1" in
    up)
        brightnessctl set +5%
        ;;
    down)
        brightnessctl set 5%-
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac

# Send notification
brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
percentage=$((brightness * 100 / max_brightness))

notify-send -h string:x-canonical-private-synchronous:brightness -u low "Brightness: ${percentage}% ☀"
