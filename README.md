# Devcontainer ZSH 

This devcontainer is specifically designed to update and optimize the modular
ZSH shell configuration. The configurations are stored in a separate folder,
like this repository, and can with a few simple commands be synced into the
running zsh environment.

# Setup

After buiilding the container, you will need to run three commands to install
and activate the ZSH shell in the container. 

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