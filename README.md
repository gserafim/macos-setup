# 🖥️ macOS Configuration Project

This repository provides a project designed to streamline macOS configuration using Homebrew and other utilities.

By using this project, you can quickly and efficiently configure your macOS environment to meet your preferences and needs.

This project uses [Dotbot](https://github.com/anishathalye/dotbot) for managing dotfiles installation and symlinks, making it easy to bootstrap your configuration on a new machine.

The setup process involves:

1. 📦 Installing applications and tools using [Homebrew](https://brew.sh). The list below shows some of the key tools included:
   - [bat](https://github.com/sharkdp/bat) - A cat clone with syntax highlighting and Git integration
   - [exa](https://the.exa.website) - Modern replacement for ls with color and Git integration
   - [ripgrep](https://github.com/BurntSushi/ripgrep) - Extremely fast alternative to grep that respects .gitignore
   - [jq](https://stedolan.github.io/jq/) - Lightweight command-line JSON processor for filtering and transforming data
   - [fd](https://github.com/sharkdp/fd) - Simple, fast and user-friendly alternative to 'find'
   - [htop](https://htop.dev) - Interactive process viewer and system monitor with detailed CPU/memory stats
   - [tldr](https://tldr.sh) - Simplified and community-driven man pages with practical examples
   - [gh](https://cli.github.com) - GitHub's official command line tool for pull requests, issues, and repos
   - [delta](https://github.com/dandavison/delta) - Syntax-highlighting pager for git and diff output
   - [tree](http://mama.indstate.edu/users/ice/tree/) - Directory listing as a depth-indented tree

> ⚠️ Note: The above tools are just examples. Please review the `dotfiles/Brewfile` carefully before installation to ensure it matches your needs. Feel free to modify the Brewfile to add or remove tools according to your preferences.

1. ⚙️ Applying macOS settings specified in the `macos` folder.
2. 🐚 Sets up [Oh My Zsh](https://ohmyz.sh) with plugins for an enhanced terminal experience.
   - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
   - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
3. 🔍 Sets up [FZF](https://github.com/junegunn/fzf) and [FZF-git](https://github.com/junegunn/fzf-git.sh) for powerful fuzzy finding capabilities:
   - Quick file and directory navigation
   - Interactive command history search
   - Enhanced git operations (branch switching, commit browsing)
   - List of bindings:
     - `CTRL-G CTRL-F` - Files
     - `CTRL-G CTRL-B` - Branches
     - `CTRL-G CTRL-T` - Tags
     - `CTRL-G CTRL-R` - Remotes
     - `CTRL-G CTRL-H` - commit Hashes
     - `CTRL-G CTRL-S` - Stashes
     - `CTRL-G CTRL-L` - Reflogs
     - `CTRL-G CTRL-W` - Worktrees
     - `CTRL-G CTRL-E` - Each ref (git for-each-ref)
4. 🚀 Configures the [Starship](https://starship.rs) prompt to customize the terminal appearance.
5. 📁 Creating symbolic links for
   - `.gitconfig` - Configuration for Git, a version control system.
   - `starship.toml` - Configuration for Starship.
   - `.zshrc` - Configuration for the Zsh shell.
   - `.exports.sh` - Exports environment variables that are set when the shell is started.
   - `.functions.sh` - Functions that can be used in the shell.
   - `.aliases.sh` - File containing shortcuts (aliases) for commonly used shell.
   - `.fzf` - Configuration for FZF (Fuzzy Finder) functionality.
6. 🔑 Creating an SSH key, or listing the existing key if it's already available.

<br/>

## ❗ Important
   This script was developed to fit my specific needs, and it's highly likely that your preferences and requirements may differ. Please take a deep look into all the files and configurations before installing, as you may need to adjust the script to suit your personal setup.

<br/>


<br/>

## 🛠️ Installing
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/gserafim/macos-setup/main/bootstrap.sh)"
```

<br/>

## 📝 Create/Update Brewfile

This project creates an alias to keep the brew file up to date as applications and tools are installed or removed.

```bash
brewfile-update
```

<br/>

## 📄 License

This project is released under the MIT License, which grants you the freedom to use, modify, and distribute this software without restriction.

For more information about the MIT License, please refer to the `LICENSE` file in the repository.
