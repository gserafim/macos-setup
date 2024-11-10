#!/usr/bin/env bash

# Enable debugging
set -x

# Source utilities
source "$(dirname "${BASH_SOURCE[0]}")/../utils/colors.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../utils/header.sh"

# Generate header
generate_header "🚀 Installing Dotfiles"

# Helper functions
fail() {
  echo "${RED}ERROR: $1${RESET}" >&2
  exit 1
}

message() {
  printf "%b\n" "${RESET}${BOLD}$1${RESET}"
}

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Directories to process
DIRECTORIES=("macos" "scripts")

# Process each directory
for dir in "${DIRECTORIES[@]}"; do
  # Check if directory exists
  if [[ -d "${SCRIPT_DIR}/${dir}" ]]; then
    message "${CYAN}📂 Processing directory: ${dir}${RESET}"

    # Change to the directory
    cd "${SCRIPT_DIR}/${dir}" || fail "Failed to change directory to ${dir}"

    # Find and execute all .sh files excluding 'install.sh'
    find . -maxdepth 1 -type f -name '*.sh' ! -name 'install.sh' -exec bash {} \;
  else
    message "${YELLOW}🚨  Directory ${dir} does not exist${RESET}"
  fi
done

# Return to the original directory
cd "$SCRIPT_DIR" || fail "Failed to return to original directory"

message "${GREEN}✅ Installation complete!${RESET}"