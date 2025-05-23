# Zsh options and styles
zstyle ':omz:alpha:lib:git' async-prompt no

# Disable job control messages for background tasks
# setopt no_notify
# setopt no_bg_nice

# Autosuggestions configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_USE_ASYNC=true

# Uncomment if you want to use Zsh's default readkey engine
# ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE
