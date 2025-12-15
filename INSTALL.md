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
git clone https://github.com/Mo3oDev/arch-bootstrap-and-dotfiles ~/.dotfiles
cd ~/.dotfiles
```

### 2. Review Package Lists

```bash
cat packages/official.txt  # 49 official packages
cat packages/aur.txt       # 9 AUR packages
```

### 3. Run Installer

```bash
chmod +x install.sh
./install.sh
```

The script will:
1. Install official packages (pacman)
2. Install yay AUR helper
3. Install AUR packages
4. Create symlinks with GNU Stow (backups to `~/.config/backup_*`)
5. Enable services (dbus, seatd, SDDM, NetworkManager, PipeWire, UFW)
6. Add user to 'seat' group (required for Wayland)

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

### AUR build fails (alpm error)
**Error**: `cannot find function 'alpm_option_set_disable_sandbox_filesystem'`

**Fix**:
```bash
# Update pacman first
sudo pacman -Sy
sudo pacman -S --needed pacman

# Then full system upgrade
sudo pacman -Syu

# Retry installation
cd ~/.dotfiles && ./install.sh
```

### Hyprland won't start / Login loop

**Symptoms**: Authentication succeeds but returns to login screen immediately.

**Causes**:
1. Missing Wayland runtime dependencies
2. SDDM not properly configured for Wayland/Hyprland

**Fix**: This is now handled automatically by the installer. The script now:
- Installs `dbus`, `seatd`, `xdg-desktop-portal`
- Enables required services
- Configures SDDM with `QT_WAYLAND_SHELL_INTEGRATION=layer-shell`
- Creates Hyprland greeter config in `/var/lib/sddm/.config/hypr/`
- Adds user to `seat` group

**If you installed before this fix**:
```bash
# Install missing packages
sudo pacman -S --needed dbus seatd xdg-desktop-portal

# Enable services
sudo systemctl enable dbus.service
sudo systemctl enable seatd.service

# Add user to seat group
sudo usermod -aG seat $USER

# Configure SDDM for Wayland
sudo mkdir -p /var/lib/sddm/.config/hypr
sudo cp ~/.dotfiles/.config/sddm/hyprland/hyprland.conf /var/lib/sddm/.config/hypr/
sudo chown -R sddm:sddm /var/lib/sddm/.config
sudo cp ~/.dotfiles/.config/sddm/sddm.conf.d/theme.conf /etc/sddm.conf.d/

# Reboot
sudo reboot
```

**Test without SDDM**: If Hyprland works from TTY but not SDDM:
```bash
# Switch to TTY (Ctrl+Alt+F2)
# Login and type: Hyprland
# If it works, the issue is SDDM configuration
```

**Debug logs**:
```bash
cat ~/.hyprland/hyprland.log
journalctl -b -u sddm
journalctl -b -u dbus
journalctl -b -u seatd
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
