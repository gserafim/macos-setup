#!/usr/bin/env bash

# Dracula Theme Colors
export BLACK="$(tput setaf 17)"        # Dark background #282a36
export GRAY="$(tput setaf 147)"        # Current line/selection #44475a
export WHITE="$(tput setaf 253)"       # Normal text #f8f8f2
export BLUE="$(tput setaf 61)"         # Comments #6272a4
export CYAN="$(tput setaf 117)"        # Cyan #8be9fd
export GREEN="$(tput setaf 84)"        # Green #50fa7b
export ORANGE="$(tput setaf 215)"      # Orange #ffb86c
export PINK="$(tput setaf 212)"        # Pink #ff79c6
export PURPLE="$(tput setaf 141)"      # Purple #bd93f9
export RED="$(tput setaf 203)"         # Red #ff5555
export YELLOW="$(tput setaf 228)"      # Yellow #f1fa8c

# Reset
export RESET="$(tput sgr0)"
export BOLD="$(tput bold)"

# Helper function for colorized messages
colorize() {
    echo -e "${RESET}${BOLD}$1${RESET}"
}
