#!/usr/bin/env zsh
#
# Performance tracking (uncomment for debugging)
# zmodload zsh/zprof

# Znap setup
if [[ ! -d "${HOME}/.zsh-snap" ]]; then
    echo "Installing Znap..."
    git clone --depth 1 --quiet https://github.com/marlonrichert/zsh-snap.git ${HOME}/.zsh-snap 
fi

source ${HOME}/.zsh-snap/znap.zsh 2>/dev/null
zstyle ':znap:*' repos-dir ${HOME}/.config/zsh/plugins-data


# Create plugin directory if it doesn't exist
if [[ ! -d "${HOME}/.config/zsh/plugins-data" ]]; then
    mkdir -p "${HOME}/.config/zsh/plugins-data"
    znap clone \
        git@github.com:jeffreytse/zsh-vi-mode.git \
        git@github.com:unixorn/fzf-zsh-plugin.git \
        2>/dev/null
fi

# Load core configuration (always loaded)
for core in ~/.config/zsh/core/*.zsh; do
    [[ -f "$core" ]] && source "$core"
done

# Load plugin callbacks/hooks (always loaded)
for hook in ~/.config/zsh/hooks/*.zsh; do
    [[ -f "$hook" ]] && source "$hook"
done

# Load essential plugins (always loaded)
source ~/.config/zsh/plugins/essential.zsh

# Profile-based loading
echo "Loading ZSH profile: ${ZSH_PROFILE:-full}"

case "$ZSH_PROFILE" in
"minimal")
    # Minimal setup - just aliases
    source ~/.config/zsh/modules/aliases.zsh
    ;;

"python-dev")
    # Python development setup
    source ~/.config/zsh/modules/aliases.zsh
    source ~/.config/zsh/modules/git-overrides.zsh
    source ~/.config/zsh/modules/tmux.zsh

    # Only load pyenv if it exists
    if [[ -d "$HOME/.pyenv" ]] || command -v pyenv &>/dev/null; then
        source ~/.config/zsh/lazy/heavy-tools.zsh
    fi
    ;;

"node-dev")
    # Node.js development setup
    source ~/.config/zsh/modules/aliases.zsh
    source ~/.config/zsh/modules/git-overrides.zsh
    source ~/.config/zsh/modules/javascript.zsh
    source ~/.config/zsh/modules/tmux.zsh

    # Only load nvm if it exists
    if [[ -d "$HOME/.nvm" ]] || command -v node &>/dev/null; then
        source ~/.config/zsh/lazy/heavy-tools.zsh
    fi
    ;;

"ruby-dev")
    # Ruby development setup
    source ~/.config/zsh/modules/aliases.zsh
    source ~/.config/zsh/modules/git-overrides.zsh
    source ~/.config/zsh/modules/ruby.zsh
    source ~/.config/zsh/modules/tmux.zsh
    ;;

"devcontainer")
    # Generic devcontainer setup - auto-detect tools
    source ~/.config/zsh/modules/aliases.zsh 
    source ~/.config/zsh/modules/git-overrides.zsh
    source ~/.config/zsh/modules/tmux.zsh

    # Load language-specific configs based on what's available
    command -v python3 &>/dev/null && source ~/.config/zsh/lazy/heavy-tools.zsh
    command -v node &>/dev/null && source ~/.config/zsh/modules/javascript.zsh
    command -v ruby &>/dev/null && source ~/.config/zsh/modules/ruby.zsh
    ;;

"full" | *)
    # Full setup (default for local machine)
    for module in ~/.config/zsh/modules/*.zsh; do
        [[ -f "$module" ]] && source "$module"
    done
    source ~/.config/zsh/lazy/heavy-tools.zsh
    source ~/.config/zsh/plugins/async.zsh
    ;;
esac

# ALWAYS load profile tools (for debugging and switching)
source ~/.config/zsh/modules/profile-tools.zsh

# Load interactive setup (for containers)
[[ -f ~/.config/zsh/interactive-setup.zsh ]] && source ~/.config/zsh/interactive-setup.zsh

# Local overrides
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local

# Performance report (uncomment for debugging)
# zprof
