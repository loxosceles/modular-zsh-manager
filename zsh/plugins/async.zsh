#!/usr/bin/env zsh

# Load heavy plugins asynchronously

# Function to load heavy components
load_heavy_plugins() {
    # Syntax highlighting (can be slow)
    znap source zsh-users/zsh-syntax-highlighting

    # FZF plugin
    znap source unixorn/fzf-zsh-plugin

    # Load direnv hook only if we're in a directory with .envrc
    if [[ -f .envrc ]] && command -v direnv &>/dev/null; then
        if [[ "$SHELL" = "/bin/zsh" ]]; then
            eval "$(direnv hook zsh)"
        fi
    fi
}

# Start background loading
load_heavy_plugins &
disown
