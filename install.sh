#!/usr/bin/env bash

# Sets up this Mac with the files in this repo.
#
# Usage: bash ~/.dotfiles/install.sh [step ...]
# Without steps, runs all of them in this order:
#   links     link the dotfiles into $HOME (safe to run any time)
#   ssh       create an SSH key if there isn't one
#   ohmyzsh   install Oh My Zsh and its plugins
#   fzf-git   install fzf-git.sh
#   macos     apply the macOS preferences in macos/
#   brew      install Homebrew and everything in dotfiles/Brewfile
#   apps      configure iTerm2, Rectangle and Firefox

set -euo pipefail

# Source utilities
source "$(dirname "${BASH_SOURCE[0]}")/utils/common.sh"

ALL_STEPS="links ssh ohmyzsh fzf-git macos brew apps"

step_script() {
  case "$1" in
  links) echo "scripts/links.sh" ;;
  ssh) echo "scripts/ssh.sh" ;;
  ohmyzsh) echo "scripts/ohmyzsh.sh" ;;
  fzf-git) echo "scripts/fzf-git.sh" ;;
  macos) echo "macos/install.sh" ;;
  brew) echo "scripts/brew.sh" ;;
  apps) echo "scripts/appsConfig.sh" ;;
  *) return 1 ;;
  esac
}

STEPS="${*:-$ALL_STEPS}"

for step in $STEPS; do
  step_script "$step" >/dev/null || fail "Unknown step '$step'. Available steps: $ALL_STEPS"
done

# On a Mac that is already set up, running every step re-applies the macOS and app settings
if [ $# -eq 0 ] && [ -L "$HOME/.zshrc" ] && [ -t 0 ]; then
  warn "This Mac is already set up: running every step re-applies the macOS and app settings"
  printf 'Continue? [y/N] '
  read -r answer || answer=""
  case "$answer" in
  y | Y) ;;
  *)
    message "Nothing done. Run only the steps you need, e.g.: bash \"$DOTFILES/install.sh\" links"
    exit 0
    ;;
  esac
fi

message "${CYAN}🚀 Steps: $STEPS${RESET}"

# Keep the Mac awake until the setup ends
caffeinate -i -w "$$" >/dev/null 2>&1 &

# Ask for the administrator password once, and keep sudo alive until the end
case " $STEPS " in
*" brew "* | *" macos "*)
  message "${CYAN}🔐 Some steps need administrator rights${RESET}"
  sudo -v
  while true; do
    sudo -n true || true # Homebrew may clear sudo's saved password; keep going after that
    sleep 50
    kill -0 "$$" 2>/dev/null || exit
  done >/dev/null 2>&1 &
  SUDO_KEEPALIVE_PID=$!
  trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true' EXIT
  ;;
esac

# Run every step (with bash, so file permissions don't matter), even if an earlier one fails
FAILED=""
for step in $STEPS; do
  if ! bash "$DOTFILES/$(step_script "$step")"; then
    FAILED="$FAILED $step"
  fi
done

echo ""
if [ -n "$FAILED" ]; then
  warn "Finished with errors in:$FAILED"
  message "Fix the errors above and run only those steps again: bash \"$DOTFILES/install.sh\"$FAILED"
  exit 1
fi

message "${GREEN}✅ All done! Open a new terminal to load the new settings.${RESET}"
