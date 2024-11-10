#!/usr/bin/env bash

# Center text function
center_text() {
  local text="$1"
  local term_width=$(tput cols)
  local padding=$(( (term_width - ${#text}) / 2 ))
  printf "%${padding}s%s%${padding}s\n" "" "$text" ""
}