#!/usr/bin/env bash

# Applies the app settings kept in appsConfig/ (apps that aren't installed are skipped)

set -euo pipefail

# Source utilities
source "$(dirname "${BASH_SOURCE[0]}")/../utils/common.sh"

# Generate header
generate_header "🎚️ Configuring APPs"

errors=0

# iTerm2 Configuration
if [ -d "/Applications/iTerm.app" ]; then
  message "${PURPLE}✅ iterm2${RESET}"
  mkdir -p "$HOME/Library/Preferences"
  if ! cp "$DOTFILES/appsConfig/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/"; then
    warn "Couldn't copy the iTerm2 config"
    errors=$((errors + 1))
  fi
else
  message "${YELLOW}⏭️  iTerm2 isn't installed, skipping${RESET}"
fi

# Rectangle Configuration: Rectangle imports this file the next time it starts
if [ -d "/Applications/Rectangle.app" ]; then
  message "${PURPLE}✅ Rectangle${RESET}"
  RECTANGLE_DIR="$HOME/Library/Application Support/Rectangle"
  mkdir -p "$RECTANGLE_DIR"
  if cp "$DOTFILES/appsConfig/RectangleConfig.json" "$RECTANGLE_DIR/"; then
    # Restart Rectangle so it imports the configuration now
    killall Rectangle >/dev/null 2>&1 || true
    sleep 1
    if ! open -a Rectangle; then
      warn "Couldn't open Rectangle"
      errors=$((errors + 1))
    fi
  else
    warn "Couldn't copy the Rectangle config"
    errors=$((errors + 1))
  fi
else
  message "${YELLOW}⏭️  Rectangle isn't installed, skipping${RESET}"
fi

# Firefox Configuration: asks macOS to make it the default browser (macOS shows a confirmation)
if [ -d "/Applications/Firefox.app" ]; then
  message "${PURPLE}✅ Firefox${RESET}"
  if ! open -a Firefox --args --setDefaultBrowser; then
    warn "Couldn't open Firefox"
    errors=$((errors + 1))
  fi
else
  message "${YELLOW}⏭️  Firefox isn't installed, skipping${RESET}"
fi

[ "$errors" -eq 0 ] || fail "$errors app(s) couldn't be configured"

message "${GREEN}✅ Apps configuration complete.${RESET}"
