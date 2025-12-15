#!/usr/bin/env bash
# ============================================
# 02-dotfiles.sh - Create symlinks with GNU Stow
# ============================================

set -e

echo "🔗 Creating symlinks with GNU Stow..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.config/backup_$(date +%Y%m%d_%H%M%S)"

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo "❌ Error: GNU Stow is not installed"
    echo "   Install it with: sudo pacman -S stow"
    exit 1
fi

# Backup existing configs
echo "  💾 Backing up existing configs to $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

for dir in hypr waybar wezterm nushell zellij mako zathura gtk-3.0; do
    if [ -d "$HOME/.config/$dir" ] && [ ! -L "$HOME/.config/$dir" ]; then
        echo "    ↻ Backing up ~/.config/$dir"
        mv "$HOME/.config/$dir" "$BACKUP_DIR/"
    fi
done

# Backup starship.toml if exists and is not a symlink
if [ -f "$HOME/.config/starship.toml" ] && [ ! -L "$HOME/.config/starship.toml" ]; then
    echo "    ↻ Backing up ~/.config/starship.toml"
    mv "$HOME/.config/starship.toml" "$BACKUP_DIR/"
fi

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Use GNU Stow to create symlinks
echo "  🔗 Creating symlinks with stow..."
cd "$DOTFILES_DIR"

# Stow will create symlinks for .config and scripts directories
stow -v --restow --target="$HOME" .

# Make scripts executable
echo "  🔐 Making scripts executable..."
chmod +x "$DOTFILES_DIR/scripts/"*.sh 2>/dev/null || true
chmod +x "$DOTFILES_DIR/.config/hypr/scripts/"*.sh 2>/dev/null || true

echo "✅ Symlinks created successfully with GNU Stow"
echo "  💡 Old configs backed up to: $BACKUP_DIR"
echo ""
echo "  ℹ️  To manually manage dotfiles:"
echo "     cd ~/.dotfiles"
echo "     stow --restow .     # Re-create all symlinks"
echo "     stow --delete .     # Remove all symlinks"
