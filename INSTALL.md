# Installation Guide

## Prerequisites

- Fresh Arch Linux installation with internet connection
- User account with sudo privileges
- System updated: `sudo pacman -Syu`

### Hardware

This config is optimized for:
- AMD + RX
- Dual 1920x1080 monitors
- Colombia (Bogotá)

**For different hardware:**
- NVIDIA GPU: Edit `packages/official.txt`, replace AMD packages with `nvidia nvidia-utils`
- Intel CPU: Replace `amd-ucode` with `intel-ucode`
- Laptop: Edit `.config/waybar/config` to enable battery module

## Installation

### 1. Clone Repository

```bash
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
```

### 2. Review Package Lists

```bash
cat packages/official.txt  # 46 official packages
cat packages/aur.txt       # 9 AUR packages
```

### 3. Run Installer

```bash
chmod +x install.sh
./install.sh
```

The script will:
1. Install official packages (pacman)
2. Install Paru AUR helper
3. Install AUR packages
4. Create symlinks with GNU Stow (backups to `~/.config/backup_*`)
5. Enable services (SDDM, NetworkManager, PipeWire, UFW)

## Post-Install Required

1. Edit `~/.config/hypr/hyprland.conf`:
   - Monitor configuration (see CONFIG.md)
   - wlsunset coordinates if not in Bogotá

2. If dual boot: Configure systemd-boot (see POST-INSTALL.md)

3. Get your root PARTUUID:
   ```bash
   lsblk -o NAME,PARTUUID
   ```

4. Edit boot entry:
   ```bash
   sudo nano /boot/loader/entries/arch.conf
   # Replace XXXXXXXX... with your PARTUUID
   ```

5. Reboot:
   ```bash
   sudo reboot
   ```

6. Select **Hyprland** in SDDM login screen

## Troubleshooting

### Hyprland won't start
```bash
cat ~/.hyprland/hyprland.log
journalctl -b -u sddm
```

### Stow conflicts
```bash
cd ~/.dotfiles
stow --adopt .  # Adopt existing files
git restore .   # Restore dotfiles
```

### No internet
```bash
sudo systemctl enable --now NetworkManager
nmcli device status
```
