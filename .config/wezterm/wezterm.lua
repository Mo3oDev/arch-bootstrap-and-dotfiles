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
-- NONE = no decorations at all (use Hyprland to manage windows)
-- RESIZE = invisible resize borders only, no title bar
config.window_decorations = "NONE"

-- ---- Shell ----
config.default_prog = { 'nu' }

-- ---- Wayland Backend ----
-- Force Wayland backend (critical for Hyprland)
config.enable_wayland = true

-- Disable multiplexer to avoid broken pipe issues
config.unix_domains = {}
config.default_gui_startup_args = { 'start', '--always-new-process' }

-- ---- Performance ----
-- Use OpenGL rendering (better performance than Software)
config.front_end = "OpenGL"
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

  -- Tabs
  { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab { confirm = true } },
  { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'PageDown', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'PageUp', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(-1) },

  -- Tab numbers (1-8)
  { key = '1', mods = 'ALT', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'ALT', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'ALT', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'ALT', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'ALT', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'ALT', action = wezterm.action.ActivateTab(-1) },

  -- Panes (Splits)
  { key = 'd', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'D', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'q', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = true } },

  -- Navigate between panes
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },

  -- Resize panes
  { key = 'LeftArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
  { key = 'RightArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Right', 5 } },
  { key = 'UpArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
  { key = 'DownArrow', mods = 'CTRL|SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Down', 5 } },
}

return config
