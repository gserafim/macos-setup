#!/usr/bin/env bash

# Dracula Theme Colors (left empty when the output is not a terminal)
if [ -t 1 ] && tput setaf 1 >/dev/null 2>&1; then
  BLACK="$(tput setaf 17)"        # Dark background #282a36
  GRAY="$(tput setaf 147)"        # Current line/selection #44475a
  WHITE="$(tput setaf 253)"       # Normal text #f8f8f2
  BLUE="$(tput setaf 61)"         # Comments #6272a4
  CYAN="$(tput setaf 117)"        # Cyan #8be9fd
  GREEN="$(tput setaf 84)"        # Green #50fa7b
  ORANGE="$(tput setaf 215)"      # Orange #ffb86c
  PINK="$(tput setaf 212)"        # Pink #ff79c6
  PURPLE="$(tput setaf 141)"      # Purple #bd93f9
  RED="$(tput setaf 203)"         # Red #ff5555
  YELLOW="$(tput setaf 228)"      # Yellow #f1fa8c

  # Reset
  RESET="$(tput sgr0)"
  BOLD="$(tput bold)"
else
  BLACK="" GRAY="" WHITE="" BLUE="" CYAN="" GREEN="" ORANGE="" PINK="" PURPLE="" RED="" YELLOW=""
  RESET="" BOLD=""
fi
export BLACK GRAY WHITE BLUE CYAN GREEN ORANGE PINK PURPLE RED YELLOW RESET BOLD

# Helper function for colorized messages
colorize() {
    echo -e "${RESET}${BOLD}$1${RESET}"
}
