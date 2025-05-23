FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

# Install rsync for sync script
RUN apt-get update && apt-get install -y rsync && rm -rf /var/lib/apt/lists/*

# Copy everything from project root's zsh folder
COPY zsh /workspace/zsh

# Install sync script
COPY sync-configs /usr/local/bin/
RUN chmod +x /usr/local/bin/sync-configs

# Set default user (already exists in base image)
USER vscode