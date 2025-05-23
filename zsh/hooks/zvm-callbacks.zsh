# Zsh-vi-mode plugin callbacks
# This function is automatically called by zsh-vi-mode after it initializes

function zvm_after_init() {
    # Set up autosuggestions keybinding after vi-mode is ready
    bindkey '^ ' autosuggest-accept

    # Load FZF after vi-mode is initialized to avoid conflicts
    export FZF_PATH=${HOME}/.fzf
    [[ -f ${FZF_PATH}/fzf.zsh ]] && source ${FZF_PATH}/fzf.zsh
}

# Add other zsh-vi-mode callbacks here if needed
# function zvm_before_init() {
#   # Code to run before zsh-vi-mode initializes
# }

# function zvm_after_lazy_keybindings() {
#   # Code to run after lazy keybindings are set
# }
