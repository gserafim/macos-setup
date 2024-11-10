#!/usr/bin/env bash

# Source utils
source "$(dirname "${BASH_SOURCE[0]}")/colors.sh"
source "$(dirname "${BASH_SOURCE[0]}")/text.sh"

generate_header() {
    local text="$1"
    local pattern=""
    local dash="-"
    local term_width=$(tput cols)

    # Create alternating pattern for the full terminal width
    for i in $(seq 1 $term_width); do
        if ((i % 2 == 0)); then
            pattern+="${BLACK}${dash}"
        else
            pattern+="${YELLOW}${dash}"
        fi
    done

    echo -e "\n${pattern}"
    echo -e "${CYAN}$(center_text "$text")"
    echo -e "${pattern}${RESET}\n"
}
