# ============================================
# NUSHELL ENVIRONMENT - MINIMAL
# ============================================

# ---- PATH ----
$env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend $"($env.HOME)/.local/bin"
    | prepend $"($env.HOME)/.cargo/bin"
)

# ---- Editor ----
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

# ---- XDG Directories ----
$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.XDG_DATA_HOME = $"($env.HOME)/.local/share"
$env.XDG_CACHE_HOME = $"($env.HOME)/.cache"

# ---- Wayland ----
$env.XDG_SESSION_TYPE = "wayland"
$env.QT_QPA_PLATFORM = "wayland"
$env.GDK_BACKEND = "wayland"
$env.MOZ_ENABLE_WAYLAND = "1"

# ---- Theme ----
$env.GTK_THEME = "Catppuccin-Mocha-Standard-Mauve-Dark"
$env.XCURSOR_THEME = "Bibata-Modern-Ice"
$env.XCURSOR_SIZE = "24"

# ---- Less ----
$env.LESS = "-R"

# ---- FZF Colors (Catppuccin Mocha) ----
$env.FZF_DEFAULT_OPTS = "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# ---- Carapace Completion ----
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/nushell
carapace _carapace nushell | save --force ~/.cache/nushell/carapace.nu
