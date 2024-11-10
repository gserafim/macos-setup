#!/usr/bin/env bash

# Source utilities
source "$(dirname "${BASH_SOURCE[0]}")/../utils/colors.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/header.sh"


# Generate header
generate_header "⬛ Installing Oh My Zsh"


# Set ZSH custom directory
export ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}


# Helper functions
fail() {
  echo "${RED}ERROR: $1${RESET}"
  exit 1
}


message() {
  printf "%b\n" "${RESET}${BOLD}$1${RESET}"
}


# Install Oh My Zsh
if [ -d ~/.oh-my-zsh ]; then
  message "${CYAN}✅ oh-my-zsh is installed${RESET}"
else
  message "${GREEN}🏁 Installing oh-my-zsh${RESET}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || \
    fail "Couldn't install oh-my-zsh"
fi


# Set permissions
message "${CYAN}🔑 Setting permissions on .oh-my-zsh/plugins/ folder${RESET}"
chmod +x ~/.oh-my-zsh/custom/*


# Install plugins
message "${CYAN}👀 Checking Plugins${RESET}"


# Install zsh-autosuggestions
if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  message "${CYAN}✅ zsh-autosuggestions is installed${RESET}"
else
  message "${GREEN}🏁 Installing zsh-autosuggestions${RESET}"
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions || \
    fail "Couldn't install zsh-autosuggestions"
fi


# Install zsh-syntax-highlighting
if [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  message "${CYAN}✅ zsh-syntax-highlighting is installed${RESET}"
else
  message "${GREEN}🏁 Installing zsh-syntax-highlighting${RESET}"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting || \
    fail "Couldn't install zsh-syntax-highlighting"
fi


message "${GREEN}✅ Oh My Zsh setup complete!${RESET}"
