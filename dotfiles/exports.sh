# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH=$PATH:/Applications/Google\ Chrome.app/Contents/MacOS
export PATH="/opt/homebrew/opt/python@3.11/bin/:$PATH"

#exports n settings
export N_PREFIX=$HOME/.n
export STARSHIP_CONFIG=~/.config/starship.toml

#exports the nvm variables
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

#Homebrew
# Set the path for the homebrew binaries
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

#Adds the option to disable the macOS gatekeeper for casks installation
export HOMEBREW_CASK_OPTS="--no-quarantine"

#Enable the cleanup of the homebrew installation
export HOMEBREW_NO_INSTALL_CLEANUP=0


#Set the theme for bat
export BAT_THEME=Dracula

# Set the manpager to bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
