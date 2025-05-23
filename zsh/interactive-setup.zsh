#!/usr/bin/env zsh

# Interactive profile setup for containers

zsh-container-setup() {
    echo "🚀 ZSH Container Setup"
    echo "====================="
    echo ""

    # Show current status
    zsh-profile-info
    echo ""

    # Ask if they want to add anything
    echo "🤔 Want to load additional modules?"
    echo "Common additions for containers:"
    echo ""
    echo "1. ssh         - SSH context manager"
    echo "2. ruby        - Ruby development tools"
    echo "3. javascript  - Node.js/NPM configuration"
    echo "4. async       - Heavy plugins (syntax highlighting, etc.)"
    echo ""

    read "module?Enter module name (or 'none'): "

    if [[ "$module" != "none" && "$module" != "" ]]; then
        zsh-profile-load "$module"
    fi

    echo ""
    echo "✅ Setup complete!"
    echo "💡 Available commands:"
    echo "   - zsh-profile-info     : Show what's loaded"
    echo "   - zsh-profile-list     : List available profiles"
    echo "   - zsh-profile-load     : Load additional modules"
    echo "   - zsh-profile-switch   : Switch profiles"
    echo "   - zsh-profile-diff     : See what's missing"
}

# Auto-run setup in new containers
if [[ -f /.dockerenv ]] && [[ ! -f ~/.zsh-container-setup-done ]]; then
    echo ""
    echo "🎉 Welcome to your containerized development environment!"
    echo "ℹ️  Run 'zsh-container-setup' for interactive configuration"
    echo ""

    # Mark as done
    touch ~/.zsh-container-setup-done
fi
