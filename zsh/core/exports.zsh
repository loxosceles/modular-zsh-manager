# Profile detection and setup
detect_environment() {
    # If profile is already set, use it
    [[ -n "$ZSH_PROFILE" ]] && return

    # Auto-detect container environment
    if [[ -f /.dockerenv ]] || [[ -n "$DEVCONTAINER" ]] || [[ -n "$CODESPACES" ]]; then
        # Check what tools are available and set appropriate profile
        if command -v python3 &>/dev/null && [[ ! -f /usr/bin/node ]]; then
            export ZSH_PROFILE="python-dev"
        elif command -v node &>/dev/null && [[ ! -f /usr/bin/python3 ]]; then
            export ZSH_PROFILE="node-dev"
        elif command -v ruby &>/dev/null && [[ ! -f /usr/bin/python3 ]] && [[ ! -f /usr/bin/node ]]; then
            export ZSH_PROFILE="ruby-dev"
        else
            export ZSH_PROFILE="devcontainer"
        fi
    else
        # Local machine - load everything
        export ZSH_PROFILE="full"
    fi
}

# Detect environment if profile not set
detect_environment

# Essential environment variables
export SHELL=/bin/zsh
export LANG=en_US.UTF-8
export MANPATH="/usr/local/man:$MANPATH"

# Editor setup
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    if command -v nvim &>/dev/null; then
        export EDITOR='nvim'
    else
        export EDITOR='vim'
        echo "Your EDITOR should be set to nvim but it is not installed."
    fi
fi

# Essential PATH modifications
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Python environment
export PIPENV_VENV_IN_PROJECT="enabled"

# Direnv (only load hook when .envrc exists in current directory)
export DIRENV_LOG_FORMAT=
