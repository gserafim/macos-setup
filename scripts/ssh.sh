#!/usr/bin/env bash

# Source utilities
source "$(dirname "${BASH_SOURCE[0]}")/../utils/colors.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/header.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/text.sh"


# Generate header
generate_header "🔑 Setting up SSH Keys"


# Helper functions
fail() {
  echo "${RED}ERROR: $1${RESET}"
  exit 1
}


message() {
  printf "%b\n" "${RESET}${BOLD}$1${RESET}"
}


# Check for existing SSH keys
message "${CYAN}Checking for existing SSH keys...${RESET}"

if [ -f "$HOME/.ssh/id_ed25519" ]; then
  message "${GREEN}✅ Using existing SSH key in $HOME/.ssh/id_ed25519${RESET}"
  SSH_KEY_FILE=$HOME/.ssh/id_ed25519

elif [ -f "$HOME/.ssh/id_rsa" ]; then
  message "${GREEN}✅ Using existing SSH key in $HOME/.ssh/id_rsa${RESET}"
  SSH_KEY_FILE=$HOME/.ssh/id_rsa

else
  message "${YELLOW}⚠️  No existing SSH key found${RESET}"
  message "${CYAN}🔨 Generating a new SSH key...${RESET}"

  SSH_KEY_FILE=$HOME/.ssh/id_ed25519
  ssh-keygen -f "$SSH_KEY_FILE" -t ed25519 || fail "Couldn't generate an SSH key"

  message "${GREEN}✅ New SSH key generated successfully${RESET}"
fi


# Display the public key with centered attention-grabbing format
echo ""
center_text "${YELLOW}🚨  🚨  🚨  ATTENTION  🚨  🚨  🚨${RESET}"
message ""
center_text "${CYAN}Copy your SSH public key below:${RESET}"
message ""
SSH_KEY=$(cat "${SSH_KEY_FILE}.pub")
center_text "${GREEN}${SSH_KEY}${RESET}"
echo ""


message "${GREEN}✅ SSH setup complete!${RESET}"
