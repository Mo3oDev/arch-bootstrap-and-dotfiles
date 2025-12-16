# Installation Guide

## Prerequisites

- Fresh Arch Linux installation
- Internet connection
- User with sudo privileges
- Updated system: `sudo pacman -Syu`

## Hardware Notes

Optimized for:
- AMD CPU/GPU (RX series)
- Dual 1920x1080 monitors
- Desktop (no battery)
- Colombia timezone (Bogotá)

**Different hardware:**
- NVIDIA: Edit `packages/official.txt`, replace AMD packages with `nvidia nvidia-utils`
- Intel CPU: Replace `amd-ucode` with `intel-ucode`
- Laptop: Enable battery module in `.config/waybar/config`

## Installation Steps

### 1. Clone repo
```bash
git clone https://github.com/Mo3oDev/arch-bootstrap-and-dotfiles ~/.dotfiles
cd ~/.dotfiles
```

### 2. Review packages (optional)
```bash
cat packages/official.txt  # 49 packages
cat packages/aur.txt       # 9 packages
```

### 3. Run installer
```bash
chmod +x install.sh
./install.sh
```

The script installs packages, creates symlinks, and enables services automatically.

### 4. Configure monitors
```bash
# Find your monitors
hyprctl monitors

# Edit config
nano ~/.config/hypr/hyprland.conf
# Update monitor= lines with your monitor names
```

**Monitor examples:**
```conf
# Side by side
monitor=DP-1,1920x1080@60,0x0,1        # Left
monitor=DP-2,1920x1080@60,1920x0,1     # Right

# Different resolutions
monitor=DP-1,2560x1440@144,0x0,1       # Primary
monitor=DP-2,1920x1080@60,2560x0,1     # Secondary
```

### 5. Dual boot (optional)

If you have dual boot with Windows:

```bash
# Get your root partition PARTUUID
lsblk -o NAME,PARTUUID

# Edit boot entry
sudo nano /boot/loader/entries/arch.conf
# Replace PARTUUID placeholder with your actual PARTUUID

# Copy boot configs
sudo cp ~/.dotfiles/boot/loader/loader.conf /boot/loader/
sudo cp ~/.dotfiles/boot/loader/entries/*.conf /boot/loader/entries/

# Update bootloader
sudo bootctl update
```

### 6. Reboot
```bash
sudo reboot
```

Select **Hyprland** in SDDM login screen.

## Customization

**Location (sunset/sunrise color temp):**
```bash
nano ~/.config/hypr/hyprland.conf
# Find: exec-once = wlsunset -l 4.7110 -L -74.0721
# Replace with your coordinates
```

**Wallpapers:**
```bash
mkdir -p ~/Pictures/Wallpapers
# Add images, then press SUPER+SHIFT+W to cycle
```

## Package Info

- **Official**: 49 packages (~2GB)
- **AUR**: 9 packages
- Lists in `packages/official.txt` and `packages/aur.txt`
