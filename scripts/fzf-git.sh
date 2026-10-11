#!/usr/bin/env bash

# Installs fzf-git.sh (git key bindings for fzf), loaded by dotfiles/fzf.sh

set -euo pipefail

# Source utilities
source "$(dirname "${BASH_SOURCE[0]}")/../utils/common.sh"

# Generate header
generate_header "⬛ Installing Fzf-Git"

# Install fzf-git.sh for fzf integration
if [ -d "$HOME/.fzf-git" ]; then
  message "${CYAN}✅ fzf-git.sh is installed${RESET}"
else
  message "${GREEN}🏁 Installing fzf-git.sh${RESET}"
  git clone --depth=1 https://github.com/junegunn/fzf-git.sh.git "$HOME/.fzf-git" ||
    fail "Couldn't install fzf-git.sh"
fi
