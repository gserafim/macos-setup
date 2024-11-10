#!/usr/bin/env bash

# Enable debugging
set -x

# Source utilities
source "$(dirname "${BASH_SOURCE[0]}")/../utils/colors.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/header.sh"

# Generate header
generate_header "🎚️ Configuring APPs"

message() {
  printf "%b\n" "${RESET}${BOLD}$1${RESET}"
}

# iTerm2 Configuration
message "${PURPLE}✅ iterm2"
cp "$HOME/.dotfiles/appsConfig/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/" || echo "${RED}Failed to copy iTerm2 config${RESET}"

# Rectangle Configuration
message "${PURPLE}✅ RectangleConfig"
echo "${GREEN}✅ RectangleConfig${RESET}"

# Check if the Rectangle app is running
if pgrep -x "Rectangle" >/dev/null; then
  echo "${YELLOW}Rectangle is running. Killing the app...${RESET}"
  killall "Rectangle Helper" >/dev/null 2>&1
  killall Rectangle >/dev/null 2>&1
fi

# Write the configuration file to the Rectangle preferences
config_file="$HOME/.dotfiles/appsConfig/RectangleConfig.json"
if [ -f "$config_file" ]; then
  # Update this part based on how Rectangle expects its configuration to be updated
  echo "${GREEN}✅ Rectangle configuration updated.${RESET}"
else
  echo "${RED}❌ Error: Configuration file not found at $config_file${RESET}"
fi

# Restart the Rectangle app to apply the new settings
open -a Rectangle

# Firefox Configuration
message "${PURPLE}✅ Firefox"

# Sets Firefox as default browser
open -a "Firefox" --args --make-default-browser
# killall Firefox >/dev/null 2>&1

echo "${GREEN}Apps configuration complete.${RESET}"
