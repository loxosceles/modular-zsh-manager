# ZSH Configuration Profiles

## Available Profiles

Set via environment variable: `export ZSH_PROFILE="profile-name"`

### `minimal`

- Basic aliases only
- Fastest startup
- Good for: Simple containers, CI/CD

### `python-dev`

- Aliases + Git overrides + Tmux
- Lazy-loaded Pyenv (if available)
- Good for: Python development containers

### `node-dev`

- Aliases + Git overrides + Tmux + JavaScript config
- Lazy-loaded NVM (if available)
- Good for: Node.js development containers

### `ruby-dev`

- Aliases + Git overrides + Tmux + Ruby config
- Good for: Ruby development containers

### `devcontainer`

- Auto-detects available tools
- Loads appropriate language configs
- Good for: Multi-language containers

### `full` (default)

- Everything loaded
- All modules and async plugins
- Good for: Local development machine

## Usage in Containers

### devcontainer.json

```json
{
  "mounts": [
    "source=${localWorkspaceFolder}/.config/zsh,target=/home/vscode/.config/zsh,type=bind"
  ],
  "containerEnv": {
    "ZSH_PROFILE": "python-dev"
  }
}
