# Alias for listing files and directories in a single column without additional details
alias ls='eza --icons=always -1'

# Alias for listing all files (including hidden ones) in a single column without additional details
alias lsa='eza --icons=always -a -1'

# Alias for listing files with detailed information (permissions, sizes, etc.) in a single column
alias lsf='eza --icons=always -l'

# Alias for listing all files (including hidden ones) with detailed information
alias lsfa='eza --icons=always -la'

# Alias for showing the directory structure as a tree
alias lst='eza --icons=always --tree'

# Set alias to remove node_modules from tokei
alias tokei="tokei --exclude dotbot --exclude node_modules"

# Restart Bluetooth driver
alias bt-restart="
blueutil --power 0 && \
sleep 1 && \
blueutil --power 1 &&"

# Search using regex (case insensitive)
alias search="find . -type f -not -path '*/\.*' -exec grep -iE \"$@\" {} + | sort"

# Updates the Brewfile and removes VSCode
alias brewfile-update="(OLDPWD=$(pwd) && \
brew autoremove && \
brew cleanup && \
cd ~/.dotfiles/dotfiles && \
brew bundle dump --force && \
sed -i '' '/^vscode/d' Brewfile && \
cd $OLDPWD)"
