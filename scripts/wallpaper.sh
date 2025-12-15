#!/usr/bin/env bash
# ============================================
# wallpaper.sh - Set random wallpaper with swww
# ============================================

set -e

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Check if wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Wallpaper directory not found: $WALLPAPER_DIR"
    echo "Create it and add some wallpapers:"
    echo "  mkdir -p $WALLPAPER_DIR"
    exit 1
fi

# Check if swww daemon is running
if ! pgrep -x swww-daemon > /dev/null; then
    echo "Starting swww daemon..."
    swww-daemon &
    sleep 1
fi

# Get random wallpaper
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)

if [ -z "$WALLPAPER" ]; then
    echo "Error: No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Set wallpaper with swww
echo "Setting wallpaper: $(basename "$WALLPAPER")"
swww img "$WALLPAPER" --transition-type fade --transition-duration 2

# Send notification
notify-send -u low "Wallpaper Changed" "$(basename "$WALLPAPER")"
