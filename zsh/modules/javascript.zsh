# JavaScript/Node.js configuration
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH
export MANPATH="$NPM_PACKAGES/share/man:$(manpath 2>/dev/null || echo '')"

export PATH="/usr/local/bin/node:/usr/local/bin/npm:/usr/bin/npm:$PATH"
