#!/usr/bin/env bash
# ============================================
# 00-base.sh - Install official packages
# ============================================

set -e

echo "📦 Installing official packages..."

# Update system
echo "  ↻ Updating system..."
sudo pacman -Syu --noconfirm

# Install packages from list
echo "  📥 Installing packages from official repositories..."
sudo pacman -S --needed --noconfirm $(cat packages/official.txt | grep -v '^#' | grep -v '^$')

echo "✅ Official packages installed"
