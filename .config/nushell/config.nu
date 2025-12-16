# ============================================
# NUSHELL CONFIGURATION - MINIMAL
# ============================================

# ---- Core Config ----
$env.config = {
    show_banner: false
    edit_mode: vi

    # History
    history: {
        max_size: 100000
        sync_on_enter: true
        file_format: "sqlite"
    }

    # Completions
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"
    }

    # Shell behavior
    rm: {
        always_trash: false
    }

    # Table display
    table: {
        mode: rounded
        index_mode: always
        show_empty: true
    }
}

# ---- Starship Prompt ----
# Initialize starship prompt
const starship_cache = "~/.cache/starship"
const starship_init = "~/.cache/starship/init.nu"

if not ($starship_cache | path expand | path exists) {
    mkdir ($starship_cache | path expand)
}
if not ($starship_init | path expand | path exists) {
    starship init nu | save -f ($starship_init | path expand)
}
source $starship_init

# ---- Carapace Completion ----
# Load carapace completions if available
try {
    source ~/.cache/nushell/carapace.nu
} catch {
    print "Warning: Carapace completions not found. They will be generated on next shell start."
}

# ---- Atuin (History) ----
# Uncomment if atuin is installed
# source ~/.config/nushell/atuin.nu

# ---- Aliases ----
alias l = ls
alias ll = ls -l
alias la = ls -a
alias lla = ls -la

# Better alternatives (if installed)
alias cat = bat
alias ls = lsd
alias ll = lsd -l
alias la = lsd -a
alias lla = lsd -la
alias tree = lsd --tree

alias grep = rg
alias find = fd

# ---- Custom Commands ----

# Quick cd to common directories
def --env dev [] {
    cd ~/dev
}

def --env dots [] {
    cd ~/.dotfiles
}

def --env conf [] {
    cd ~/.config
}

# System update
def update [] {
    yay -Syu
}

# Clean package cache
def clean [] {
    yay -Sc
}
