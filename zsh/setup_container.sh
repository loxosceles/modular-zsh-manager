#!/bin/bash

# Container setup script for zsh configuration

PROFILE="${ZSH_PROFILE:-devcontainer}"
USER_HOME="${HOME:-/home/vscode}"

echo "🚀 Setting up zsh configuration for profile: $PROFILE"

# Create necessary directories if they don't exist
mkdir -p "$USER_HOME"/{.zsh-snap,.zsh_plugins,.zsh_custom_aliases}

# Install znap if not present
if [[ ! -d "$USER_HOME/.zsh-snap" ]]; then
    echo "📦 Installing Znap..."
    git clone --depth 1 --quiet https://github.com/marlonrichert/zsh-snap.git "$USER_HOME/.zsh-snap"
fi

# Create basic custom aliases file if not present
if [[ ! -f "$USER_HOME/.zsh_custom_aliases/container.zsh" ]]; then
    cat >"$USER_HOME/.zsh_custom_aliases/container.zsh" <<'EOF'
# Container-specific aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Quick navigation
alias ..='cd ..'
alias ...='cd ../..'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
EOF
fi

# Set the profile for this session
export ZSH_PROFILE="$PROFILE"

echo "✅ Setup complete for profile: $PROFILE"
echo "💡 You can change the profile by setting: export ZSH_PROFILE=\"other-profile\""

# Show available profiles
echo ""
echo "📋 Available profiles:"
echo "  - minimal: Basic setup"
echo "  - python-dev: Python development"
echo "  - node-dev: Node.js development"
echo "  - ruby-dev: Ruby development"
echo "  - devcontainer: Auto-detect tools"
echo "  - full: Everything (default for local)"
