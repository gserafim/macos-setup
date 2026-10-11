#!/bin/bash

# Sets up a new Mac: installs the Xcode Command Line Tools (which bring git),
# clones this repo into ~/.dotfiles and runs install.sh
#
# Usage: /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/gserafim/macos-setup/main/bootstrap.sh)"

set -euo pipefail

REPO_URL="https://github.com/gserafim/macos-setup.git"
DOTFILES="$HOME/.dotfiles"

# The Command Line Tools are installed when their folder has git
clt_installed() {
  local dir
  dir="$(xcode-select -p 2>/dev/null)" && [ -x "$dir/usr/bin/git" ]
}

# Check if Xcode Command Line Tools are already installed
if clt_installed; then
  echo "Xcode Command Line Tools are already installed."
else
  echo "Xcode Command Line Tools are not installed. Installing now (confirm the dialog that opens)..."
  xcode-select --install || true

  # Wait until the installation is complete (up to 1 hour)
  waited=0
  until clt_installed; do
    if [ "$waited" -ge 3600 ]; then
      echo "Timed out waiting for the Command Line Tools. Install them and run this script again." >&2
      exit 1
    fi
    sleep 5
    waited=$((waited + 5))
    if [ $((waited % 60)) -eq 0 ]; then
      echo "Still waiting for the Command Line Tools ($((waited / 60)) min). If the dialog was closed, run: xcode-select --install"
    fi
  done

  echo "Installation complete."
fi

# A full Xcode that was never opened blocks git until its license is accepted
case "$(xcode-select -p 2>/dev/null)" in
*.app/*)
  if ! git --version >/dev/null 2>&1; then
    echo "Accepting the Xcode license (asks for your password)..."
    sudo xcodebuild -license accept
  fi
  ;;
esac

# Clone the repo into ~/.dotfiles, or use the existing clone
if [ -d "$DOTFILES/.git" ]; then
  echo "Using the existing clone in $DOTFILES"
else
  git clone "$REPO_URL" "$DOTFILES"
fi

# Run the install script (with bash, so it works even if the file isn't executable)
exec /bin/bash "$DOTFILES/install.sh" "$@"
