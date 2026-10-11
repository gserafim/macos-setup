#!/usr/bin/env bash

# Installs Oh My Zsh and the plugins used in dotfiles/zshrc.sh

set -euo pipefail

# Source utilities
source "$(dirname "${BASH_SOURCE[0]}")/../utils/common.sh"

# Generate header
generate_header "⬛ Installing Oh My Zsh"

OMZ_DIR="$HOME/.oh-my-zsh"
PLUGINS_DIR="$OMZ_DIR/custom/plugins"

# Install Oh My Zsh with git: the official installer would replace ~/.zshrc with its template
if [ -f "$OMZ_DIR/oh-my-zsh.sh" ]; then
  message "${CYAN}✅ oh-my-zsh is installed${RESET}"
elif [ -e "$OMZ_DIR" ]; then
  fail "$OMZ_DIR exists but isn't a complete Oh My Zsh install. Remove it and run this step again"
else
  message "${GREEN}🏁 Installing oh-my-zsh${RESET}"
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$OMZ_DIR" ||
    fail "Couldn't install oh-my-zsh"
fi

# Install plugins
message "${CYAN}👀 Checking Plugins${RESET}"

for plugin in zsh-autosuggestions zsh-syntax-highlighting zsh-completions; do
  if [ -d "$PLUGINS_DIR/$plugin" ]; then
    message "${CYAN}✅ $plugin is installed${RESET}"
  else
    message "${GREEN}🏁 Installing $plugin${RESET}"
    git clone --depth=1 "https://github.com/zsh-users/$plugin.git" "$PLUGINS_DIR/$plugin" ||
      fail "Couldn't install $plugin"
  fi
done

message "${GREEN}✅ Oh My Zsh setup complete!${RESET}"
