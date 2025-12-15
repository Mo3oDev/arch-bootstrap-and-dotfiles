#!/usr/bin/env bash
# ============================================
# ARCH LINUX DOTFILES - MINIMAL INSTALLATION
# ============================================

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🟪 Arch Linux Dotfiles - Minimal Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ---- Check if running on Arch ----
if [ ! -f /etc/arch-release ]; then
    echo "❌ Error: This script is for Arch Linux only"
    exit 1
fi

# ---- Ensure we're in the dotfiles directory ----
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo "📂 Dotfiles directory: $DOTFILES_DIR"
echo ""

# ---- Run installation scripts in order ----
for script in install/*.sh; do
    if [ -f "$script" ]; then
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "▶️  Running: $(basename $script)"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        bash "$script"
        echo ""
    fi
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✅ Installation Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Next steps:"
echo "  1. Review and edit configuration files (see install/03-services.sh output)"
echo "  2. Reboot your system: sudo reboot"
echo "  3. Select Hyprland in SDDM"
echo "  4. Press SUPER+Return to open terminal"
echo ""
echo "📖 For more info, see README.md"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
