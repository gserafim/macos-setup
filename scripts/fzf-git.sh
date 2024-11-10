#!/usr/bin/env bash

# Source utilities
source "$(dirname "${BASH_SOURCE[0]}")/../utils/colors.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/header.sh"


# Generate header
generate_header "⬛ Installing Fzf-Git"


# Helper functions
fail() {
  echo "${RED}ERROR: $1${RESET}"
  exit 1
}


message() {
  printf "%b\n" "${RESET}${BOLD}$1${RESET}"
}


# Install fzf-git.sh for fzf integration
if [ -d ~/.fzf-git ]; then
  message "${CYAN}✅ fzf-git.sh is installed${RESET}"
else
  message "${GREEN}🏁 Installing fzf-git.sh${RESET}"

  git clone https://github.com/junegunn/fzf-git.sh.git ~/.fzf-git || \
    fail "Couldn't install fzf-git.sh"
fi