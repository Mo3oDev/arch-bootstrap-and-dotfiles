#!/usr/bin/env bash
# ============================================
# Wayland/Hyprland Debug Script
# ============================================

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🔍 WAYLAND/HYPRLAND DEBUG REPORT"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ---- 1. Session Information ----
echo "📋 1. SESSION INFORMATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Current user: $USER"
echo "Current shell: $SHELL"
echo "Running in: $(tty)"
echo "Desktop session: $DESKTOP_SESSION"
echo ""

# ---- 2. Critical Environment Variables ----
echo "📋 2. ENVIRONMENT VARIABLES (Critical for Wayland)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "WAYLAND_DISPLAY = ${WAYLAND_DISPLAY:-[NOT SET]}"
echo "DISPLAY = ${DISPLAY:-[NOT SET]}"
echo "XDG_CURRENT_DESKTOP = ${XDG_CURRENT_DESKTOP:-[NOT SET]}"
echo "XDG_SESSION_TYPE = ${XDG_SESSION_TYPE:-[NOT SET]}"
echo "XDG_SESSION_DESKTOP = ${XDG_SESSION_DESKTOP:-[NOT SET]}"
echo "QT_QPA_PLATFORM = ${QT_QPA_PLATFORM:-[NOT SET]}"
echo "GDK_BACKEND = ${GDK_BACKEND:-[NOT SET]}"
echo "SDL_VIDEODRIVER = ${SDL_VIDEODRIVER:-[NOT SET]}"
echo ""

# ---- 3. Hyprland Status ----
echo "📋 3. HYPRLAND STATUS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if pgrep -x Hyprland > /dev/null; then
    echo "✅ Hyprland is running (PID: $(pgrep -x Hyprland))"
    echo ""
    echo "Hyprland version:"
    hyprctl version 2>/dev/null || echo "  ⚠️  hyprctl not available"
else
    echo "❌ Hyprland is NOT running"
fi
echo ""

# ---- 4. System Services Status ----
echo "📋 4. SYSTEM SERVICES STATUS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
systemctl is-active dbus.service && echo "✅ dbus.service: active" || echo "❌ dbus.service: inactive"
systemctl is-active seatd.service && echo "✅ seatd.service: active" || echo "❌ seatd.service: inactive"
systemctl is-active sddm.service && echo "✅ sddm.service: active" || echo "❌ sddm.service: inactive"
echo ""
echo "User groups:"
groups $USER
echo ""

# ---- 5. WezTerm Status ----
echo "📋 5. WEZTERM INFORMATION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if command -v wezterm &> /dev/null; then
    echo "✅ WezTerm is installed"
    wezterm --version
    echo ""
    echo "WezTerm config location:"
    ls -la ~/.config/wezterm/wezterm.lua 2>/dev/null && echo "  ✅ Config file exists" || echo "  ❌ Config file NOT found"
else
    echo "❌ WezTerm is NOT installed"
fi
echo ""

# ---- 6. Wayland Compositor Socket ----
echo "📋 6. WAYLAND COMPOSITOR SOCKET"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ -n "$XDG_RUNTIME_DIR" ]; then
    echo "XDG_RUNTIME_DIR = $XDG_RUNTIME_DIR"
    echo ""
    echo "Wayland sockets in runtime dir:"
    ls -la $XDG_RUNTIME_DIR/wayland-* 2>/dev/null || echo "  ❌ No wayland sockets found"
else
    echo "❌ XDG_RUNTIME_DIR is NOT SET"
fi
echo ""

# ---- 7. Test Other Wayland Terminals ----
echo "📋 7. ALTERNATIVE TERMINAL TESTS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
command -v foot &> /dev/null && echo "✅ foot is available" || echo "⚠️  foot not installed (alternative terminal)"
command -v alacritty &> /dev/null && echo "✅ alacritty is available" || echo "⚠️  alacritty not installed"
command -v kitty &> /dev/null && echo "✅ kitty is available" || echo "⚠️  kitty not installed"
echo ""

# ---- 8. Recent Hyprland Logs ----
echo "📋 8. HYPRLAND LOGS (Last 30 lines)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ -f ~/.hyprland/hyprland.log ]; then
    echo "Last 30 lines of hyprland.log:"
    tail -n 30 ~/.hyprland/hyprland.log
else
    echo "❌ ~/.hyprland/hyprland.log not found"
fi
echo ""

# ---- 9. Try Running WezTerm with Debug ----
echo "📋 9. WEZTERM DEBUG TEST"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if command -v wezterm &> /dev/null; then
    echo "Attempting to start WezTerm with debug output..."
    echo "(This will fail if WAYLAND_DISPLAY is not set)"
    echo ""
    timeout 3 wezterm start --always-new-process -- echo "WezTerm works!" 2>&1 | head -n 20
    echo ""
fi

# ---- 10. Systemd User Environment ----
echo "📋 10. SYSTEMD USER ENVIRONMENT"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
systemctl --user show-environment | grep -E "WAYLAND|DISPLAY|XDG_" || echo "No Wayland/Display variables in systemd user environment"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✅ DEBUG REPORT COMPLETE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Please share this entire output for diagnosis"
echo ""
