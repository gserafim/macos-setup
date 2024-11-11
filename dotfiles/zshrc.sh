# Add plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# source exports and settings
source $HOME/.exports.sh

# Load the Oh My Zsh library
source $ZSH/oh-my-zsh.sh

# source aliases
source $HOME/.aliases.sh

# source functions
source $HOME/.functions.sh

source $HOME/.fzf

# Set the theme
ZSH_THEME="robbyrussell"

# Enable automatic file permission correction for Zsh command completion
ZSH_DISABLE_COMPFIX=false

# Add Visual Studio Code (code)
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# improves the cd command by adding directory bookmarks
eval "$(zoxide init zsh)"

# fzf key bindings
eval "$(fzf --zsh)"

#Set Encript to UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

HISTSIZE=5000
HISTFILE=$HOME/.zhistory
SAVEHIST=$HISTSIZE
HISTDUPE=erase
setopt append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_expire_dups_first
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

PATH=~/.console-ninja/.bin:$PATH

#initialize starship. Keep at the bottom of this file or above FIG if installed.
eval "$(starship init zsh)"
