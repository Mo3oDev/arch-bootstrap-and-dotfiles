#!/usr/bin/env bash
# ============================================
# volume.sh - Volume control with notifications
# ============================================

case "$1" in
    up)
        pamixer -i 5
        ;;
    down)
        pamixer -d 5
        ;;
    mute)
        pamixer -t
        ;;
    *)
        echo "Usage: $0 {up|down|mute}"
        exit 1
        ;;
esac

# Send notification
volume=$(pamixer --get-volume)
muted=$(pamixer --get-mute)

if [ "$muted" = "true" ]; then
    notify-send -h string:x-canonical-private-synchronous:volume -u low "Volume: Muted 🔇"
else
    notify-send -h string:x-canonical-private-synchronous:volume -u low "Volume: ${volume}% 🔊"
fi
