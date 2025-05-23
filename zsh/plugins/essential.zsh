#!/usr/bin/env zsh

# Load Oh My Zsh components
znap source ohmyzsh/ohmyzsh lib/{git,theme-and-appearance,spectrum,completion}.zsh
znap source ohmyzsh/ohmyzsh themes/robbyrussell.zsh-theme
znap prompt ohmyzsh/ohmyzsh robbyrussell

znap source zsh-users/zsh-syntax-highlighting

znap source zsh-users/zsh-autosuggestions

# Load vi-mode
znap source jeffreytse/zsh-vi-mode