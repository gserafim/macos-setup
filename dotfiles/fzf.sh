# FZF (Fuzzy Finder) Configuration

# Initialize fzf with zsh integration
eval "$(fzf --zsh)"

# Theme Configuration (Dracula-inspired colors)
fg="#F8F8F2"           # Main text color
bg="#22212C"           # Main background
bg_highlight="#44475A" # Selected item background
purple="#BD93F9"       # Highlighted text
blue="#6272A4"         # Secondary text/info
cyan="#8BE9FD"         # Interactive elements

# Apply color scheme to fzf
export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# Set fd as the default source for fzf
# --hidden: Include hidden files
# --strip-cwd-prefix: Remove ./ prefix from results
# --exclude .git: Ignore git directory
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"

# Use the same command for CTRL+T search
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Use similar command for directory search with ALT+C
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Custom path completion using fd
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Custom directory completion using fd
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/.fzf-git/fzf-git.sh

# Define preview command based on item type:
# - For directories: show tree view using eza
# - For files: show content using bat
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

# Configure preview for CTRL+T (file search)
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"

# Configure preview for ALT+C (directory search)
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Customize preview based on the command being completed
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
  # Directory preview
  cd) fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;

  # Environment variable preview
  export | unset) fzf --preview "eval 'echo \${}'" "$@" ;;

  # DNS lookup for SSH hosts
  ssh) fzf --preview 'dig {}' "$@" ;;

  # Default preview
  *) fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}
