#!/usr/bin/env zsh

# Profile management and debugging tools

# Show current profile info
zsh-profile-info() {
    echo "🔧 ZSH Configuration Info"
    echo "========================"
    echo "Profile: ${ZSH_PROFILE:-full}"
    echo "Container: $([[ -f /.dockerenv ]] && echo "Yes" || echo "No")"
    echo "User: $(whoami)"
    echo "Shell: $SHELL"
    echo ""

    echo "📦 Loaded Modules:"
    echo "=================="
    # Check which modules are loaded by looking for their functions/aliases

    # Check core
    echo "✅ Core (always loaded)"

    # Check modules
    [[ $(type -w startmux 2>/dev/null) ]] && echo "✅ Tmux module"
    [[ $(type -w git 2>/dev/null) =~ "function" ]] && echo "✅ Git overrides"
    [[ $(type -w ssh-context 2>/dev/null) ]] && echo "✅ SSH context manager"
    [[ -n "$NPM_PACKAGES" ]] && echo "✅ JavaScript/Node module"
    [[ -n "$GEM_HOME" ]] && echo "✅ Ruby module"

    # Check lazy-loaded tools
    echo ""
    echo "🔄 Lazy-loaded Tools:"
    echo "===================="
    [[ $(type -w pyenv 2>/dev/null) =~ "function" ]] && echo "🔄 Pyenv (lazy)"
    [[ $(type -w nvm 2>/dev/null) =~ "function" ]] && echo "🔄 NVM (lazy)"
    [[ $(type -w conda 2>/dev/null) =~ "function" ]] && echo "🔄 Conda (lazy)"

    # Check plugins
    echo ""
    echo "🔌 Plugins:"
    echo "==========="
    [[ -n "$ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE" ]] && echo "✅ Autosuggestions"
    bindkey | grep -q "vi-" && echo "✅ Vi-mode" || echo "❌ Vi-mode"
    [[ $(type -w _fzf_compgen_path 2>/dev/null) ]] && echo "✅ FZF"

    echo ""
    echo "📊 Performance:"
    echo "==============="
    echo "Startup time: Run 'zsh-profile-benchmark' to test"
}

# List available profiles
zsh-profile-list() {
    echo "📋 Available ZSH Profiles:"
    echo "=========================="
    echo ""
    echo "🔹 minimal      - Basic aliases only (fastest)"
    echo "🔹 python-dev   - Python development tools"
    echo "🔹 node-dev     - Node.js development tools"
    echo "🔹 ruby-dev     - Ruby development tools"
    echo "🔹 devcontainer - Auto-detect available tools"
    echo "🔹 full         - Everything (default for local)"
    echo ""
    echo "💡 Current profile: ${ZSH_PROFILE:-full}"
    echo "💡 Switch with: zsh-profile-switch <profile-name>"
}

# Switch profiles interactively
zsh-profile-switch() {
    if [[ -z "$1" ]]; then
        echo "Usage: zsh-profile-switch <profile-name>"
        echo ""
        zsh-profile-list
        return 1
    fi

    local new_profile="$1"
    echo "🔄 Switching from '${ZSH_PROFILE:-full}' to '$new_profile'"

    export ZSH_PROFILE="$new_profile"
    echo "✅ Profile set to: $new_profile"
    echo "🔃 Reload shell with: exec zsh"
}

# Load additional module on demand
zsh-profile-load() {
    if [[ -z "$1" ]]; then
        echo "Usage: zsh-profile-load <module-name>"
        echo ""
        echo "Available modules:"
        for module in ~/.config/zsh/modules/*.zsh; do
            [[ -f "$module" ]] && echo "  - $(basename "$module" .zsh)"
        done
        return 1
    fi

    local module="$1"
    local module_path="$HOME/.config/zsh/modules/${module}.zsh"

    if [[ -f "$module_path" ]]; then
        echo "📦 Loading module: $module"
        source "$module_path"
        echo "✅ Module loaded: $module"
    else
        echo "❌ Module not found: $module"
        echo "Available modules:"
        for mod in ~/.config/zsh/modules/*.zsh; do
            [[ -f "$mod" ]] && echo "  - $(basename "$mod" .zsh)"
        done
    fi
}

# Benchmark startup time
zsh-profile-benchmark() {
    local profile="${1:-$ZSH_PROFILE}"
    echo "⏱️  Benchmarking profile: $profile"
    echo "Running 5 tests..."

    for i in {1..5}; do
        echo -n "  Run $i: "
        # Use a different approach for timing
        local start_time=$(date +%s.%N)
        ZSH_PROFILE="$profile" zsh -i -c 'exit' >/dev/null 2>&1
        local end_time=$(date +%s.%N)

        # Calculate duration (works on both macOS and Linux)
        if command -v bc >/dev/null 2>&1; then
            local duration=$(echo "$end_time - $start_time" | bc)
            echo "${duration}s"
        else
            echo "~$(printf "%.3f" $((end_time - start_time)))s"
        fi
    done

    echo "✅ Benchmark complete"
}
