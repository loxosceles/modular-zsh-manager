# Ruby configuration
if [[ -d "$HOME/.rvm" ]] || command -v ruby &>/dev/null; then
    export PATH="$PATH:$HOME/.rvm/bin"
    export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"
    export GEM_HOME=$HOME/.gem
    export PATH="$GEM_HOME/bin:$PATH"
fi
