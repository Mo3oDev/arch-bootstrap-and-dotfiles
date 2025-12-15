# Configuration Guide

## Monitor Setup

### Find Monitor Names
```bash
hyprctl monitors
```

### Edit Configuration
File: `~/.config/hypr/hyprland.conf`

**Two monitors side-by-side:**
```conf
monitor=DP-1,1920x1080@60,0x0,1        # Left
monitor=DP-2,1920x1080@60,1920x0,1     # Right
```

**Vertical stacked:**
```conf
monitor=DP-1,1920x1080@60,0x0,1        # Top
monitor=DP-2,1920x1080@60,0x1080,1     # Bottom
```

**Different resolutions:**
```conf
monitor=DP-1,2560x1440@144,0x0,1       # 1440p 144Hz
monitor=DP-2,1920x1080@60,2560x0,1     # 1080p 60Hz
```

### Apply Changes
```bash
hyprctl reload
```

## Location (wlsunset)

Edit `~/.config/hypr/hyprland.conf`:
```conf
exec-once = wlsunset -l 4.7110 -L -74.0721  # Bogotá
# exec-once = wlsunset -l 6.2442 -L -75.5812  # Medellín
# exec-once = wlsunset -l YOUR_LAT -L YOUR_LONG
```

Get coordinates: https://www.latlong.net/

## Keybindings

### Applications
- `SUPER + Return` → Terminal (WezTerm)
- `SUPER + D` → Launcher (Wofi)
- `SUPER + E` → File Manager (Nemo)
- `SUPER + L` → Lock Screen

### Window Management
- `SUPER + Q` → Close window
- `SUPER + V` → Toggle floating
- `SUPER + F` → Fullscreen
- `SUPER + h/j/k/l` → Move focus (vim-style)
- `SUPER + SHIFT + h/j/k/l` → Move window
- `SUPER + CTRL + h/j/k/l` → Resize window

### Workspaces
- `SUPER + 1-9` → Switch to workspace
- `SUPER + SHIFT + 1-9` → Move window to workspace

### Utilities
- `Print` → Screenshot (region)
- `SHIFT + Print` → Screenshot (window)
- `CTRL + Print` → Screenshot (full screen)
- `SUPER + C` → Clipboard history
- `SUPER + SHIFT + P` → Color picker

## File Structure

```
~/.dotfiles/
├── .config/
│   ├── hypr/          # Hyprland config + keybinds
│   ├── waybar/        # Status bar modules + style
│   ├── wezterm/       # Terminal config
│   ├── nushell/       # Shell config
│   ├── sddm/          # SDDM Corners theme
│   └── starship.toml  # Prompt
├── scripts/
│   ├── idle.sh        # Auto-lock (swayidle)
│   └── wallpaper.sh   # Random wallpaper
├── install/           # Installation scripts
├── packages/          # Package lists
└── install.sh         # Main installer
```

## Theme Colors (Catppuccin Mocha)

Edit these files to customize colors:
- `~/.config/hypr/mocha.conf` - Hyprland colors
- `~/.config/waybar/style.css` - Bar colors
- `~/.config/mako/config` - Notification colors

## SDDM Theme

Config already set to Corners theme with Catppuccin Mocha.

To customize: `~/.dotfiles/.config/sddm/themes/corners/theme.conf.user`

Apply changes:
```bash
sudo cp ~/.dotfiles/.config/sddm/themes/corners/theme.conf.user /usr/share/sddm/themes/corners/
sudo systemctl restart sddm
```

## Wallpapers (Optional)

```bash
mkdir -p ~/Pictures/Wallpapers
# Add wallpapers to this directory

# Set random wallpaper
~/.dotfiles/scripts/wallpaper.sh

# Or set specific in hyprland.conf:
# exec-once = swww img ~/Pictures/wallpaper.jpg
```

## Manage Dotfiles with Stow

```bash
cd ~/.dotfiles

# Re-apply symlinks
stow --restow .

# Remove symlinks
stow --delete .

# Preview changes (dry-run)
stow --no .
```
