#!/usr/bin/env bash
# ============================================
# 03-services.sh - Enable system services
# ============================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "⚙️  Enabling services..."

# Enable essential system services
echo "  🔧 Enabling system services..."
sudo systemctl enable dbus.service 2>/dev/null || echo "    ✓ dbus already enabled"
sudo systemctl enable seatd.service 2>/dev/null || echo "    ✓ seatd already enabled"
sudo systemctl enable sddm.service 2>/dev/null || echo "    ✓ sddm already enabled"
sudo systemctl enable NetworkManager.service 2>/dev/null || echo "    ✓ NetworkManager already enabled"

# Add user to seat group (required for seatd/Wayland)
echo "  👤 Adding user to 'seat' group..."
sudo usermod -aG seat "$USER"
echo "    ✓ User added to seat group"

# Configure SDDM
echo "  🎨 Configuring SDDM (Corners theme)..."
sudo mkdir -p /etc/sddm.conf.d
sudo cp "$DOTFILES_DIR/.config/sddm/sddm.conf.d/theme.conf" /etc/sddm.conf.d/

# Configure SDDM greeter Hyprland config (CRITICAL for Wayland)
echo "  🎨 Configuring SDDM Wayland greeter..."
sudo mkdir -p /var/lib/sddm/.config/hypr
sudo cp "$DOTFILES_DIR/.config/sddm/hyprland/hyprland.conf" /var/lib/sddm/.config/hypr/
sudo chown -R sddm:sddm /var/lib/sddm/.config
echo "    ✓ SDDM Wayland greeter configured"

# Copy custom theme config if corners theme is installed
if [ -d "/usr/share/sddm/themes/corners" ]; then
    sudo cp "$DOTFILES_DIR/.config/sddm/themes/corners/theme.conf.user" /usr/share/sddm/themes/corners/
    echo "    ✓ Corners theme configured with Catppuccin Mocha"
else
    echo "    ⚠️  Corners theme will be configured after paru installs it"
fi

# Enable user services
echo "  🔧 Enabling user services..."
systemctl --user enable pipewire.service 2>/dev/null || echo "    ✓ pipewire already enabled"
systemctl --user enable pipewire-pulse.service 2>/dev/null || echo "    ✓ pipewire-pulse already enabled"
systemctl --user enable wireplumber.service 2>/dev/null || echo "    ✓ wireplumber already enabled"

# Setup atuin if installed
if command -v atuin &> /dev/null; then
    echo "  🔧 Setting up atuin..."
    mkdir -p ~/.config/nushell
    # Initialize atuin for nushell
    atuin init nu > ~/.config/nushell/atuin.nu 2>/dev/null || true
fi

# Setup starship cache
echo "  🔧 Setting up starship..."
mkdir -p ~/.cache/starship

# Set GTK theme
echo "  🎨 Configuring GTK theme..."
gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha-Standard-Mauve-Dark" 2>/dev/null || echo "    ⚠ GTK settings not available yet (run after first login)"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark" 2>/dev/null || true
gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice" 2>/dev/null || true

# Configure UFW Firewall
echo "  🔥 Configuring UFW firewall..."
sudo ufw --force enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo systemctl enable ufw.service
echo "    ✓ UFW firewall enabled"

echo "✅ Services enabled"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ⚠️  MANUAL STEPS REQUIRED:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  1. Edit ~/.config/hypr/hyprland.conf:"
echo "     - Set your monitor configuration"
echo "     - Update wlsunset coordinates (latitude/longitude)"
echo "     - Customize keybinds if needed"
echo ""
echo "  2. Edit ~/.config/waybar/config:"
echo "     - Enable/disable modules for your hardware"
echo ""
echo "  3. Reboot your system:"
echo "     sudo reboot"
echo ""
echo "  4. Select Hyprland in SDDM login screen"
echo ""
echo "  5. UFW Firewall is enabled:"
echo "     - Check status: sudo ufw status"
echo "     - See docs/UFW-SETUP.md for configuration"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
