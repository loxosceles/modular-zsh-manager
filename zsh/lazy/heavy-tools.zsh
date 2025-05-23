#!/usr/bin/env zsh

# Lazy load heavy development tools

# === PYENV LAZY LOADING ===
lazy_load_pyenv() {
    unset -f python python3 pip pip3 pyenv
    if command -v pyenv &>/dev/null; then
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
    fi
}

# Only create placeholders if pyenv exists
if [[ -d "$HOME/.pyenv" ]]; then
    python() {
        lazy_load_pyenv
        python "$@"
    }
    python3() {
        lazy_load_pyenv
        python3 "$@"
    }
    pip() {
        lazy_load_pyenv
        pip "$@"
    }
    pip3() {
        lazy_load_pyenv
        pip3 "$@"
    }
    pyenv() {
        lazy_load_pyenv
        pyenv "$@"
    }
fi

# === NVM LAZY LOADING ===
lazy_load_nvm() {
    unset -f node npm npx nvm
    export NVM_DIR="$HOME/.nvm"
    [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
}

# Only create placeholders if NVM exists (and don't load immediately)
if [[ -d "$HOME/.nvm" ]]; then
    node() {
        lazy_load_nvm
        node "$@"
    }
    npm() {
        lazy_load_nvm
        npm "$@"
    }
    npx() {
        lazy_load_nvm
        npx "$@"
    }
    nvm() {
        lazy_load_nvm
        nvm "$@"
    }
fi

# === CONDA LAZY LOADING ===
lazy_load_conda() {
    unset -f conda
    if [[ -f "/opt/anaconda3/bin/conda" ]]; then
        __conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
        if [[ $? -eq 0 ]]; then
            eval "$__conda_setup"
        else
            if [[ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]]; then
                source "/opt/anaconda3/etc/profile.d/conda.sh"
            else
                export PATH="/opt/anaconda3/bin:$PATH"
            fi
        fi
        unset __conda_setup
    fi
}

# Only if conda exists
[[ -f "/opt/anaconda3/bin/conda" ]] && conda() {
    lazy_load_conda
    conda "$@"
}

# === ASYNC COMPLETIONS ===
# Load these in background after shell starts
load_completions_async() {
    # Docker completions
    if command -v docker &>/dev/null; then
        fpath=("${HOME}/.docker/completions" "${fpath[@]}")
        autoload -Uz compinit && compinit
    fi
}

# Start async loading (proper zsh syntax)
load_completions_async &
disown
