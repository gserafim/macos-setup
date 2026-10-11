#!/usr/bin/env bash

# Center text function
center_text() {
  local text="$1"
  local term_width
  term_width=$(tput cols 2>/dev/null || echo 80)
  local padding=$(( (term_width - ${#text}) / 2 ))
  [ "$padding" -gt 0 ] || padding=0
  printf "%${padding}s%s%${padding}s\n" "" "$text" ""
}
