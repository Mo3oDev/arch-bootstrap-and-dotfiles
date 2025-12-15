#!/usr/bin/env bash
# ============================================
# 01-aur.sh - Install AUR helper and packages
# ============================================

set -e

echo "📦 Installing AUR helper and packages..."

# Detect which AUR helper to use (prefer yay for libalpm 5 compatibility)
AUR_HELPER=""

if command -v yay &> /dev/null; then
    AUR_HELPER="yay"
    echo "  ✓ yay already installed"
elif command -v paru &> /dev/null; then
    AUR_HELPER="paru"
    echo "  ✓ paru already installed"
else
    # Install yay (compatible with libalpm 5.x / pacman 7+)
    echo "  🔨 Installing yay AUR helper..."

    # Remove old build directory if exists
    rm -rf /tmp/yay

    # Clone and build
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm

    # Cleanup
    cd - > /dev/null
    rm -rf /tmp/yay

    AUR_HELPER="yay"
    echo "  ✓ yay installed"
fi

# Install AUR packages
echo "  📥 Installing AUR packages..."
$AUR_HELPER -S --needed --noconfirm $(cat packages/aur.txt | grep -v '^#' | grep -v '^$' | grep -v 'paru' | grep -v 'yay')

echo "✅ AUR packages installed"
