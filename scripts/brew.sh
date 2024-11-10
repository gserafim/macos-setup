#!/usr/bin/env bash

# Source utilities
source "$(dirname "${BASH_SOURCE[0]}")/../utils/colors.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/header.sh"

# Generate header
generate_header "🍺 Installing Apps via BREW"

# Helper functions
fail() {
  echo "${RED}ERROR: $1${RESET}"
  exit 1
}

message() {
  printf "%b\n" "${RESET}${BOLD}$1${RESET}"
}

# Check if Homebrew is installed
if type brew &>/dev/null; then
  message "${GREEN}✅ brew is already installed at $(command -v brew)${RESET}"
else
  message "${GREEN}🏁 Installing homebrew${RESET}"

  # Install Homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || fail "Couldn't install Homebrew"

  # Configure Homebrew environment
  echo '# Set PATH, MANPATH, etc., for Homebrew.' >>~/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install packages from Brewfile
cd dotfiles

# Run brew bundle with modified output handling
brew bundle 2>&1 | while IFS= read -r line; do
  if [[ $line == *"Installing"* ]]; then
    name=$(echo "$line" | awk '{print $2}')
    message "${GREEN}📦 Installing ${CYAN}${name}${GREEN} ✓${RESET}"
  elif [[ $line == *"Using"* ]] || [[ $line == *"🔄 Skipping"* ]]; then
    name=$(echo "$line" | awk '{print $2}')
    message "${YELLOW}🔄 Skipping ${CYAN}${name}. ${GREEN}It's already installed ✓.${RESET}"
  elif [[ $line =~ ^[Ee]rror|^[Ww]arning|[Ff]ailed ]]; then
    # Show full output only for errors and warnings
    echo "$line"
  fi
done

# Start services
message "${GREEN}🚀 Starting services...${RESET}"
brew services start postgresql

message "${GREEN}✅ Brew installation complete!${RESET}"
