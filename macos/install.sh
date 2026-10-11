#!/usr/bin/env bash

# Applies the macOS preferences: runs every other script in this folder

set -euo pipefail

# Source utilities
source "$(dirname "${BASH_SOURCE[0]}")/../utils/common.sh"

generate_header "🍏 Setting up MACOS preferences"

# Close System Settings, to prevent it from overriding settings we're about to change
if pgrep -x "System Settings" >/dev/null; then
  osascript -e 'tell application "System Settings" to quit' || true
fi

# Run the other scripts and report the ones with a failed command (lines ending in "|| true" don't count).
# A failed command doesn't stop its script, so the remaining settings are still applied.
failed=""
for script in "$DOTFILES"/macos/*.sh; do
  name="$(basename "$script")"
  if [ "$name" != "install.sh" ]; then
    message "${GREEN}📝 Setting up ${CYAN}$name${RESET}"
    # shellcheck disable=SC2016 # $1 and $rc belong to the inner bash
    bash -c 'rc=0; trap "rc=1" ERR; . "$1"; exit $rc' _ "$script" || failed="$failed $name"
  fi
done

[ -z "$failed" ] || fail "These scripts reported errors:$failed"

message "${GREEN}✅ macOS preferences applied. Some of them only take effect after you log out and back in.${RESET}"
