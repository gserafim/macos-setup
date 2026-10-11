#!/usr/bin/env bash

# Creates an SSH key (if there isn't one yet) and lets the macOS keychain remember its passphrase

set -euo pipefail

# Source utilities
source "$(dirname "${BASH_SOURCE[0]}")/../utils/common.sh"

# Generate header
generate_header "🔑 Setting up SSH Keys"

# Check for existing SSH keys
message "${CYAN}Checking for existing SSH keys...${RESET}"

if [ -f "$HOME/.ssh/id_ed25519" ]; then
  SSH_KEY_FILE="$HOME/.ssh/id_ed25519"
  message "${GREEN}✅ Using existing SSH key in $SSH_KEY_FILE${RESET}"
elif [ -f "$HOME/.ssh/id_rsa" ]; then
  SSH_KEY_FILE="$HOME/.ssh/id_rsa"
  message "${GREEN}✅ Using existing SSH key in $SSH_KEY_FILE${RESET}"
else
  message "${YELLOW}⚠️  No existing SSH key found${RESET}"

  # Without a terminal, ssh-keygen can't ask for a passphrase and creates an unprotected key
  if ! (: </dev/tty) 2>/dev/null; then
    fail "Run this step from a terminal, so you can set the key's passphrase"
  fi

  message "${CYAN}🔨 Generating a new SSH key...${RESET}"
  SSH_KEY_FILE="$HOME/.ssh/id_ed25519"
  ssh-keygen -t ed25519 -C "$(whoami)@$(scutil --get LocalHostName 2>/dev/null || hostname -s)" -f "$SSH_KEY_FILE" ||
    fail "Couldn't generate an SSH key"

  message "${GREEN}✅ New SSH key generated successfully${RESET}"
fi

[ -f "$SSH_KEY_FILE.pub" ] || fail "The public key $SSH_KEY_FILE.pub is missing"

# Keep the passphrase in the macOS keychain and load the key into the agent on first use
if ! grep -qs 'UseKeychain' "$HOME/.ssh/config"; then
  printf '\nHost *\n  IgnoreUnknown UseKeychain\n  AddKeysToAgent yes\n  UseKeychain yes\n' >>"$HOME/.ssh/config"
  chmod 600 "$HOME/.ssh/config"
  message "${GREEN}✅ Added the keychain settings to ~/.ssh/config${RESET}"
fi

# Display the public key (also copied to the clipboard)
pbcopy <"$SSH_KEY_FILE.pub" 2>/dev/null || true
echo ""
message "${YELLOW}🚨 Your SSH public key (already copied to the clipboard):${RESET}"
echo ""
message "${GREEN}$(cat "$SSH_KEY_FILE.pub")${RESET}"
echo ""

message "${GREEN}✅ SSH setup complete!${RESET}"
