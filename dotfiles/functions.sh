preexec() { echo; }

# Search file contents recursively using regex (case insensitive)
# Skips hidden and .gitignore'd files; extra rg options can be appended
search() {
  rg --ignore-case --line-number "$@"
}

# Define functions to create .prettierrc and .editorconfig (existing files are kept)
mkprettierrc() {
  if [[ -e .prettierrc ]]; then
    echo ".prettierrc already exists" >&2
    return 1
  fi
  echo "{
\"arrowParens\": \"always\",
\"bracketSpacing\": true,
\"endOfLine\": \"auto\",
\"printWidth\": 70,
\"semi\": true,
\"singleQuote\": true,
\"tabWidth\": 2,
\"trailingComma\": \"all\",
\"useTabs\": false
}" >.prettierrc
}

mkeditorconfig() {
  if [[ -e .editorconfig ]]; then
    echo ".editorconfig already exists" >&2
    return 1
  fi
  echo "root = true

[*]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true" >.editorconfig
}

# Combine them into a single command
pc() {
  mkprettierrc
  mkeditorconfig
}

# Brewfile helpers. The Brewfile is curated by hand, so none of them rewrites it from what is installed
# Add or remove entries, e.g. brewfile-add jq, brewfile-add --cask ghostty (new entries go to the end of the file)
brewfile-add() {
  brew bundle add --file="$HOME/.dotfiles/dotfiles/Brewfile" "$@"
}

brewfile-remove() {
  brew bundle remove --file="$HOME/.dotfiles/dotfiles/Brewfile" "$@"
}

# Compare the Brewfile with what Homebrew has installed, without changing anything
brewfile-check() {
  local brewfile="$HOME/.dotfiles/dotfiles/Brewfile"
  local formulae casks installed_casks
  formulae="$(brew bundle list --file="$brewfile" --formula | sort)"
  casks="$(brew bundle list --file="$brewfile" --cask | sort)"
  installed_casks="$(brew list --cask --full-name | sort)"

  echo "In the Brewfile, not installed:"
  comm -23 <(printf '%s\n' "$formulae") <(brew list --formula --full-name | sort) | sed -e '/^$/d' -e 's/^/  /'
  comm -23 <(printf '%s\n' "$casks") <(printf '%s\n' "$installed_casks") | sed -e '/^$/d' -e 's/^/  cask /'

  echo "Installed on request, not in the Brewfile:"
  comm -13 <(printf '%s\n' "$formulae") <(brew leaves --installed-on-request | sort) | sed -e '/^$/d' -e 's/^/  /'
  comm -13 <(printf '%s\n' "$casks") <(printf '%s\n' "$installed_casks") | sed -e '/^$/d' -e 's/^/  cask /'
}
