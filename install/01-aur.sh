#!/usr/bin/env bash
# ============================================
# 01-aur.sh - Install AUR helper and packages
# ============================================

set -e

echo "📦 Installing AUR helper and packages..."

# Install paru if not present
if ! command -v paru &> /dev/null; then
    echo "  🔨 Installing paru AUR helper..."

    # Remove old build directory if exists
    rm -rf /tmp/paru

    # Clone and build
    cd /tmp
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm

    # Cleanup
    cd - > /dev/null
    rm -rf /tmp/paru

    echo "  ✓ paru installed"
else
    echo "  ✓ paru already installed"
fi

# Install AUR packages
echo "  📥 Installing AUR packages..."
paru -S --needed --noconfirm $(cat packages/aur.txt | grep -v '^#' | grep -v '^$' | grep -v 'paru')

echo "✅ AUR packages installed"
