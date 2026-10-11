#!/usr/bin/env bash

# Links the dotfiles into $HOME. Safe to run any time:
# anything already in the way is kept as <name>.backup.<date>, never deleted.

set -euo pipefail

# Source utilities
source "$(dirname "${BASH_SOURCE[0]}")/../utils/common.sh"

# Generate header
generate_header "🔗 Linking dotfiles"

# File in the repo              Link in $HOME
LINKS="
dotfiles/zshrc.sh               .zshrc
dotfiles/exports.sh             .exports.sh
dotfiles/aliases.sh             .aliases.sh
dotfiles/functions.sh           .functions.sh
dotfiles/fzf.sh                 .fzf
dotfiles/gitconfig              .gitconfig
dotfiles/starship.toml          .config/starship.toml
"

# Folders to create in $HOME
FOLDERS="
Documents/workspace
"

link() {
  local src="$DOTFILES/$1"
  local dst="$HOME/$2"

  [ -e "$src" ] || fail "$1 doesn't exist in the repo"

  # Already linked to the repo (also when the link reaches it through another path)
  if [ -L "$dst" ] && [ "$dst" -ef "$src" ]; then
    message "${GREEN}✅ ~/$2${RESET}"
    return
  fi

  mkdir -p "$(dirname "$dst")"

  # Keep whatever is in the way (file, folder or another link) as a backup
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    local backup
    backup="$2.backup.$(date +%Y%m%d-%H%M%S)"
    mv "$dst" "$HOME/$backup"
    message "${YELLOW}📦 Moved the existing ~/$2 to ~/$backup${RESET}"
  fi

  ln -s "$src" "$dst"
  message "${GREEN}🔗 ~/$2 -> $1${RESET}"
}

# Remove broken links that still point into the repo (e.g. after a file was renamed)
clean_broken_links() {
  local dir="$1"
  local entry target

  for entry in "$dir"/.* "$dir"/*; do
    if [ -L "$entry" ] && [ ! -e "$entry" ]; then
      target="$(readlink "$entry")"
      case "$target" in
      "$DOTFILES"/*)
        rm "$entry"
        message "${YELLOW}🧹 Removed the broken link ~${entry#"$HOME"} (it pointed to ${target#"$DOTFILES"/})${RESET}"
        ;;
      esac
    fi
  done
}

while read -r src dst; do
  if [ -n "$src" ]; then
    link "$src" "$dst"
  fi
done <<<"$LINKS"

clean_broken_links "$HOME"
clean_broken_links "$HOME/.config"

while read -r folder; do
  if [ -n "$folder" ]; then
    # macOS may ask whether Terminal can access the folder (e.g. Documents); a "no" shouldn't stop the setup
    mkdir -p "$HOME/$folder" ||
      warn "Couldn't create ~/$folder. Allow Terminal in System Settings > Privacy & Security > Files and Folders and run the links step again"
  fi
done <<<"$FOLDERS"

message "${GREEN}✅ Dotfiles linked!${RESET}"
