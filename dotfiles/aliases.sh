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
alias tokei="tokei --exclude node_modules"

# Set alias to use bat instead of cat
alias cat="bat"

# Restart Bluetooth driver
alias btr="blueutil --power 0 && sleep 1 && blueutil --power 1"
