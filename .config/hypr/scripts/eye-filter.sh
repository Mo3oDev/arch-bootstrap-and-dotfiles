#!/usr/bin/env bash
# ============================================
# eye-filter.sh - Toggle wlsunset profiles
# ============================================

set -euo pipefail

LAT="${WLSUNSET_LAT:-4.7110}"
LON="${WLSUNSET_LON:--74.0721}"
MODE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/wlsunset-mode"

start_wlsunset() {
    local low_temp="$1"
    local high_temp="$2"
    local gamma="$3"

    pkill -x wlsunset 2>/dev/null || true
    nohup wlsunset -l "$LAT" -L "$LON" -t "$low_temp" -T "$high_temp" -g "$gamma" >/dev/null 2>&1 &
}

notify_mode() {
    local text="$1"
    if command -v notify-send >/dev/null 2>&1; then
        notify-send -u low "Eye Filter" "$text"
    fi
}

set_mode() {
    local mode="$1"
    mkdir -p "$(dirname "$MODE_FILE")"

    case "$mode" in
        normal)
            start_wlsunset 4000 6500 1.0
            echo "normal" > "$MODE_FILE"
            notify_mode "Normal profile (4000K-6500K)"
            ;;
        focus)
            start_wlsunset 2800 4200 0.90
            echo "focus" > "$MODE_FILE"
            notify_mode "Focus profile (2800K-4200K, gamma 0.90)"
            ;;
        off)
            pkill -x wlsunset 2>/dev/null || true
            echo "off" > "$MODE_FILE"
            notify_mode "Disabled"
            ;;
        *)
            echo "Usage: $0 {toggle|normal|focus|off}"
            exit 1
            ;;
    esac
}

case "${1:-toggle}" in
    toggle)
        current_mode="normal"
        if [ -f "$MODE_FILE" ]; then
            current_mode="$(cat "$MODE_FILE" 2>/dev/null || echo normal)"
        fi

        if [ "$current_mode" = "focus" ]; then
            set_mode normal
        else
            set_mode focus
        fi
        ;;
    normal|focus|off)
        set_mode "$1"
        ;;
    *)
        echo "Usage: $0 {toggle|normal|focus|off}"
        exit 1
        ;;
esac
