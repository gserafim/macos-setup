#!/usr/bin/env bash

# Needs colors.sh and text.sh, both loaded by common.sh

generate_header() {
    local text="$1"
    local pattern=""
    local dash="-"
    local term_width
    term_width=$(tput cols 2>/dev/null || echo 80)

    # Create alternating pattern for the full terminal width
    for i in $(seq 1 "$term_width"); do
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
