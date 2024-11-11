# Add plugins
# Enable Oh My Zsh plugins for Git, autosuggestions, and syntax highlighting
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Source exports and settings
# Load custom exports and environment variable settings from .exports.sh
source $HOME/.exports.sh

# Load the Oh My Zsh library
# Load the main Oh My Zsh script, which sets up plugins, themes, and configurations
source $ZSH/oh-my-zsh.sh

# Source aliases
# Load custom alias definitions from .aliases.sh
source $HOME/.aliases.sh

# Source functions
# Load custom functions from .functions.sh
source $HOME/.functions.sh

# Source fzf configuration
source $HOME/.fzf

# Set the theme
# Set the Oh My Zsh theme to "robbyrussell"
ZSH_THEME="robbyrussell"

# Enable automatic file permission correction for Zsh command completion
# Allow Zsh to attempt to fix file permissions issues with completion scripts
ZSH_DISABLE_COMPFIX=false

# Add Visual Studio Code (code) integration
# Load VS Code-specific Zsh integration if in the VS Code terminal
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# Improves the cd command by adding directory bookmarks
# Initialize zoxide, a tool to improve `cd` by allowing directory bookmarks
eval "$(zoxide init --cmd cd zsh)"

# fzf key bindings
# Initialize fzf (fuzzy finder) key bindings for quick search in the terminal
eval "$(fzf --zsh)"

# Set Encoding to UTF-8
# Set the default language and encoding to US English UTF-8
export LANG=en_US.UTF-8
# Set the locale to use UTF-8 encoding
export LC_ALL=en_US.UTF-8

# Configure Zsh history
# Set the maximum number of commands to save in the shell history
HISTSIZE=5000
# Set the file where Zsh history is stored
HISTFILE=$HOME/.zhistory
# Set the number of commands to save in the history file
SAVEHIST=$HISTSIZE
# Erase duplicate commands in history
HISTDUPE=erase

# Zsh history settings
# Append to the history file instead of overwriting it
setopt append_history
# Share history across all sessions
setopt share_history
# Ignore commands that start with a space in the history
setopt hist_ignore_space
# Ignore consecutive duplicate entries
setopt hist_ignore_dups
# Erase earlier duplicates and keep only the most recent
setopt hist_ignore_all_dups
# Do not save duplicate commands in the history
setopt hist_save_no_dups
# Prevent duplicate results during history search
setopt hist_find_no_dups
# Expire duplicate entries first when trimming history
setopt hist_expire_dups_first
# Edit history commands before running them when recalled
setopt hist_verify

# Completion using arrow keys (based on history)
# Bind the up arrow to search backward in history for commands starting with the typed characters
bindkey '^[[A' history-search-backward
# Bind the down arrow to search forward in history for commands starting with the typed characters
bindkey '^[[B' history-search-forward

# Configure nvm (Node Version Manager)
# Set the directory for nvm
export NVM_DIR="$HOME/.nvm"

# Load nvm if available
# Source nvm script to enable Node.js version management
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Load nvm bash completion if available
# Source nvm bash completion for command autocompletion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Add Console Ninja tools to the PATH
# Prepend Console Ninja tools to the PATH for command-line access
PATH=~/.console-ninja/.bin:$PATH

# Initialize Starship prompt (put at bottom for compatibility)
# Initialize the Starship prompt, a customizable and fast prompt for any shell
eval "$(starship init zsh)"
