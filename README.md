# Devcontainer ZSH 

## Why would I want to use this?

This zsh configuration is designed to provide a modular and efficient ZSH shell
experience across different development environments, including VSCode
devcontainers. The latter is particularly useful for loading only specific
ZSH configurations based on the development profile you choose, such as Python,
Node.js, or Ruby development via setting the `ZSH_PROFILE` environment variable.
In this way, a development project with a specific language can be pre-configued
to load the necessary ZSH configurations and plugins, making it easier to work
in a consistent, non-bloated environment. To further enhance the quick startup
times, the ZSH manager supports lazy-loading of plugins and configurations, as
well as asynchronous loading of "heavy" plugins.

## Setup for Development

This devcontainer is specifically designed to update and optimize the modular
ZSH shell configuration. The configurations are stored in a separate folder,
like this repository, and can with a few simple commands be synced into the
running zsh environment.

This configuration is containerized to allow for easy customization and testing
of the ZSH shell setup. Build the devcontainer using the provided Dockerfile and
run three commands to install and activate the ZSH shell in the container. 

```bash
    # Creates a symlink default location $HOME/.zshrc to the config file in the
    # devcontainer. It backs up the existing .zshrc file if it exists and
    # replaces it with the symlink so our .zshrc file takes precedence.
    # It also cleans the plugins directory since these sometimes get stuck
    # in a weird state and prevent the new environment from using or cloning
    # them. Once they are cleaned, the plugins will automatically be reinstalled.
    sync-configs --install
    # This command will sync our zsh configuration files into the ~/.config/zsh
    # folder where they will be used by the ZSH shell, so this amounts to the
    # activation step. 
    sync-configs --sync
    # Reloads the ZSH shell so that it picks up the new configuration files. You
    # can also simply start a new shell.
    exec zsh
```

## Activating on any Host machine

Clone this repository into `$HOME/.config/zsh` , backup your existing `.zshrc`,
then create a symlink to the `.zshrc` in your `$HOME` directory pointing to the
`.config/zsh/.zshrc` file.

**Note:** The setup is untested on Windows, as it is primarily designed for
Linux and macOS environments.


## ZSH Configuration Profiles

### Available Profiles

Set via environment variable: `export ZSH_PROFILE="profile-name"`

#### `full` (default)

- Most suitable for local development
- Everything loaded
- All modules and async plugins
- Good for: Local development machine

#### `minimal`

- Basic aliases only
- Fastest startup
- Good for: Simple containers, CI/CD

#### `python-dev`

- Aliases + Git overrides + Tmux
- Lazy-loaded Pyenv (if available)
- Good for: Python development containers

#### `node-dev`

- Aliases + Git overrides + Tmux + JavaScript config
- Lazy-loaded NVM (if available)
- Good for: Node.js development containers

#### `ruby-dev`

- Aliases + Git overrides + Tmux + Ruby config
- Good for: Ruby development containers

#### `devcontainer`

- Auto-detects available tools
- Loads appropriate language configs
- Good for: Multi-language containers


## Usage in VSCode devcontainers

devcontainer.json

```json
{
  "mounts": [
    "source=${localWorkspaceFolder}/.config/zsh,target=/home/vscode/.config/zsh,type=bind"
  ],
  "containerEnv": {
    "ZSH_PROFILE": "python-dev"
  }
}
```