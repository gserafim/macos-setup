#!/usr/bin/env bash

# Shared helpers for the setup scripts
# Usage: source "$(dirname "${BASH_SOURCE[0]}")/../utils/common.sh"

UTILS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source utilities
source "$UTILS_DIR/colors.sh"
source "$UTILS_DIR/text.sh"
source "$UTILS_DIR/header.sh"

# Root of the repo, wherever it was cloned
# shellcheck disable=SC2034 # used by the scripts that source this file
DOTFILES="$(cd "$UTILS_DIR/.." && pwd)"

message() {
  printf "%b\n" "${RESET}${BOLD}$1${RESET}"
}

warn() {
  printf "%b\n" "${RESET}${YELLOW}⚠️  $1${RESET}" >&2
}

fail() {
  printf "%b\n" "${RESET}${RED}❌ ERROR: $1${RESET}" >&2
  exit 1
}

# Ctrl-C stops the whole setup, even when the interrupted program (like brew) exits normally
trap 'echo; warn "Interrupted"; exit 130' INT TERM
