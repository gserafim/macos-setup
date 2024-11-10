#!/usr/bin/env bash

# Source utilities
source "$(dirname "${BASH_SOURCE[0]}")/../utils/colors.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/header.sh"

fail() {
  echo "ERROR: $RED$1"
  exit 1
}

generate_header "🍏 Setting up MACOS preferences"

# Close any open System Preferences panes, to prevent them from overriding
# settings we're about to change
osascript -e 'tell application "System Preferences" to quit'
sudo -v

# Close any open System Preferences panes, to prevent them from overriding
# settings we're about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
# sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

## Call oher scrips under macos folder
cd macos
SCRIPTS="$(command ls -1)"

removeFromArray=install.sh
SCRIPTS=${SCRIPTS[*]/$removeFromArray/}

regex="\..*$"
replaceWith=""

for script in $SCRIPTS; do
  echo -e "${GREEN}📝 Setting up ${CYAN}$script${RESET}"
  ./$script
done
