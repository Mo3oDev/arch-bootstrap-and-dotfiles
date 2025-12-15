# Post-Installation Guide

## Systemd-boot (Dual Boot)

### 1. Install systemd-boot
```bash
# Mount ESP partition (usually /dev/nvme0n1p1 or /dev/sda1)
sudo mount /dev/nvme0n1p1 /boot  # Adjust device name

# Install bootloader
sudo bootctl install
```

### 2. Copy Boot Configs
```bash
# Copy loader configuration
sudo cp ~/.dotfiles/boot/loader/loader.conf /boot/loader/

# Copy boot entries
sudo cp ~/.dotfiles/boot/loader/entries/*.conf /boot/loader/entries/
```

### 3. Get PARTUUID
```bash
lsblk -o NAME,PARTUUID
# Note your root partition PARTUUID
```

### 4. Edit Boot Entry
```bash
sudo nano /boot/loader/entries/arch.conf

# Replace XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
# with your actual root PARTUUID
```

### 5. Update Bootloader
```bash
sudo bootctl update
```

### 6. Verify
```bash
sudo bootctl status
sudo bootctl list
```

### Troubleshooting

**Windows entry not showing:**
```bash
ls /boot/EFI/Microsoft/Boot/bootmgfw.efi
# If path differs, edit /boot/loader/entries/windows.conf
```

**Arch won't boot:**
- Double-check PARTUUID in arch.conf
- Try fallback entry
- Check: `pacman -Q amd-ucode` (or intel-ucode)

## UFW Firewall

Already enabled during installation with:
- Deny all incoming
- Allow all outgoing

### Check Status
```bash
sudo ufw status verbose
sudo systemctl status ufw
```

### Common Rules
```bash
# Allow SSH (if needed)
sudo ufw allow 22/tcp

# Allow from local network (SMB, printing)
sudo ufw allow from 192.168.1.0/24

# Delete rule
sudo ufw status numbered
sudo ufw delete 3
```

### Quick Reference
```bash
sudo ufw status
sudo ufw enable
sudo ufw disable
sudo ufw reload
```

## Common Issues

### Hyprland Won't Start
```bash
# Check logs
cat ~/.hyprland/hyprland.log
journalctl -b -u sddm

# Verify GPU driver
lsmod | grep amdgpu  # or nvidia

# Reload config
hyprctl reload
```

### No Sound
```bash
# Check PipeWire status
systemctl --user status pipewire pipewire-pulse wireplumber

# Restart audio
systemctl --user restart pipewire pipewire-pulse wireplumber

# Test
speaker-test -c 2
```

### Monitor Not Detected
```bash
# List monitors
hyprctl monitors

# Try auto-detect first
nano ~/.config/hypr/hyprland.conf
# Change to: monitor=,preferred,auto,1

# Then reload
hyprctl reload
```

### GTK Theme Not Applied
```bash
# Install theme
paru -S catppuccin-gtk-theme-mocha

# Apply
gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha-Standard-Mauve-Dark"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice"
```

### Clipboard Not Working
```bash
# Check if running
pgrep wl-paste

# Restart Hyprland
hyprctl reload
```

## Debugging

```bash
# System logs
journalctl -b          # Current boot
journalctl -b -1       # Previous boot
journalctl -p err      # Errors only

# Hyprland logs
cat ~/.hyprland/hyprland.log

# Hardware info
inxi -Fxz
lspci | grep VGA
```

## Maintenance

```bash
# Update system
paru -Syu

# Clean cache
paru -Sc

# Update dotfiles
cd ~/.dotfiles
git pull
stow --restow .
```

## Resources

- Arch Wiki: https://wiki.archlinux.org/
- Hyprland Wiki: https://wiki.hyprland.org/
- Catppuccin: https://github.com/catppuccin/catppuccin
