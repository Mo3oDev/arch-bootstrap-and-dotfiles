-- ============================================
-- WEZTERM CONFIGURATION - MINIMAL
-- ============================================

local wezterm = require 'wezterm'
local config = {}

-- ---- Appearance ----
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font 'JetBrains Mono Nerd Font'
config.font_size = 11.0

-- ---- Window ----
config.enable_tab_bar = false
config.window_padding = {
  left = 12,
  right = 12,
  top = 12,
  bottom = 12,
}

config.window_background_opacity = 0.95
config.window_decorations = "RESIZE"

-- ---- Shell ----
config.default_prog = { 'nu' }

-- ---- Wayland Backend ----
-- Force Wayland backend (critical for Hyprland)
config.enable_wayland = true

-- ---- Performance ----
-- Use Software rendering (most compatible, slower but reliable)
config.front_end = "Software"
config.max_fps = 60

-- ---- Keybinds ----
config.keys = {
  -- Copy/Paste
  { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },

  -- Font size
  { key = '+', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
}

return config
