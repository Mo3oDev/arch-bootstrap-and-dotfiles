# Arch Linux Hyprland Dotfiles

Minimal Arch + Hyprland + Catppuccin Mocha setup.

## Stack

- **WM**: Hyprland + Waybar + SDDM (Corners theme)
- **Terminal**: WezTerm + Nushell + Starship + Zellij
- **Apps**: Nemo, imv, Zathura, Wofi
- **Theme**: Catppuccin Mocha
- **Utils**: Mako, swww, cliphist, hyprshot, wlsunset

## Hardware

Optimized for:
- AMD
- Dual 1920x1080 monitors
- Desktop (no battery)
- Colombia (Bogotá)

## Quick Start

```bash
# 1. Clone
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles

# 2. Install
chmod +x install.sh
./install.sh

# 3. Configure monitors
nano ~/.config/hypr/hyprland.conf

# 4. Setup dual boot (optional)
# See POST-INSTALL.md

# 5. Reboot
sudo reboot
```

## Docs

- **[INSTALL.md](INSTALL.md)** - Installation guide
- **[CONFIG.md](CONFIG.md)** - Configuration reference
- **[POST-INSTALL.md](POST-INSTALL.md)** - Post-install tasks

## Keybinds

- `SUPER + Return` → Terminal
- `SUPER + D` → Launcher
- `SUPER + E` → File Manager
- `SUPER + L` → Lock Screen
- `SUPER + Q` → Close Window
- `Print` → Screenshot

See [CONFIG.md](CONFIG.md) for complete list.

## Packages

- **Official**: 46 packages (~2GB)
- **AUR**: 9 packages

See `packages/official.txt` and `packages/aur.txt`

## License

MIT
