#!/usr/bin/env bash

# Installs Homebrew (if needed) and everything listed in dotfiles/Brewfile

set -euo pipefail

# Source utilities
source "$(dirname "${BASH_SOURCE[0]}")/../utils/common.sh"

# Generate header
generate_header "🍺 Installing Apps via BREW"

# Look for brew in its default locations, since it may not be on the PATH yet
find_brew() {
  local candidate
  for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [ -x "$candidate" ]; then
      echo "$candidate"
      return 0
    fi
  done
  return 1
}

# Check if Homebrew is installed
if BREW="$(find_brew)"; then
  message "${GREEN}✅ brew is already installed at $BREW${RESET}"
else
  message "${GREEN}🏁 Installing homebrew${RESET}"

  # Download it first, so a failed download isn't mistaken for a successful install
  installer="$(mktemp)"
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o "$installer" ||
    fail "Couldn't download the Homebrew installer"

  # The installer needs sudo; asking here lets it run without any prompt
  sudo -v
  NONINTERACTIVE=1 /bin/bash "$installer" || fail "Couldn't install Homebrew"
  rm -f "$installer"

  BREW="$(find_brew)" || fail "Homebrew was installed, but brew wasn't found"
fi

# Set PATH, MANPATH, etc. for this script and, once, for future login shells
eval "$("$BREW" shellenv)"
if ! grep -qs 'brew shellenv' "$HOME/.zprofile"; then
  # shellcheck disable=SC2016 # the $(...) must be written literally to ~/.zprofile
  printf '\n# Set PATH, MANPATH, etc., for Homebrew.\neval "$(%s shellenv)"\n' "$BREW" >>"$HOME/.zprofile"
  message "${GREEN}✅ Added Homebrew to ~/.zprofile${RESET}"
fi

# Install whatever is missing from the Brewfile, without upgrading what is already installed
message "${CYAN}📦 Installing the Brewfile packages${RESET}"
message "${YELLOW}⏳ Homebrew installs everything in one go and shows nothing until it ends (30-60+ min on a new Mac). It isn't stuck.${RESET}"
message "${YELLOW}🔐 It may ask for your password again for apps that need it.${RESET}"
"$BREW" bundle install --file="$DOTFILES/dotfiles/Brewfile" --no-upgrade ||
  fail "Some Brewfile entries couldn't be installed (see the messages above)"

message "${GREEN}✅ Brew installation complete!${RESET}"
