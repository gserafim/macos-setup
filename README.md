# 🖥️ macOS Configuration Project

This repository provides a project designed to streamline macOS configuration using Homebrew and other utilities.

By using this project, you can quickly and efficiently configure your macOS environment to meet your preferences and needs.

Everything is plain Bash (the version that ships with macOS), so the setup needs nothing besides git, which comes with the Xcode Command Line Tools that the bootstrap installs.

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

Needs an Apple Silicon Mac (Homebrew no longer installs on Intel Macs).

What to expect:

1. Confirm the Command Line Tools dialog and wait for it to finish (5-20 min).
2. Type your password and, if a new SSH key is created, its passphrase. macOS may also ask whether Terminal can access the Documents folder.
3. Homebrew installs everything in one go (30-60+ min) and may ask for the password again for apps that need it.
4. At the end, confirm the dialog Firefox opens to become the default browser, then open a new terminal.

<br/>

## 🔁 Running parts of the setup

`install.sh` runs every step by default. Pass step names to run only those (this works from any folder):

```bash
bash ~/.dotfiles/install.sh links          # re-link the dotfiles (safe to run any time)
bash ~/.dotfiles/install.sh brew macos     # only Homebrew and the macOS preferences
```

Steps, in the order they run: `links`, `ssh`, `ohmyzsh`, `fzf-git`, `macos`, `brew`, `apps`. If a step fails, the others still run and the failed ones are listed at the end. Ctrl-C stops everything.

On a Mac that is already set up, run only the steps you need: running all of them again reverts macOS preferences you changed since, restarts the Dock, Finder and menu bar, and overwrites app settings (`install.sh` asks before doing that).

Existing files are never deleted: anything in the way of a link is renamed to `<name>.backup.<date>`.

Machine-specific shell settings (like the lines some installers ask you to add to `~/.zshrc`) go in `~/.zshrc.local`, which is loaded at the end of `.zshrc` and isn't part of the repo.

<br/>

## 📝 Maintaining the Brewfile

`dotfiles/Brewfile` lists the work setup and is curated by hand (personal apps stay out of it). These shell functions edit or check it without rewriting it:

```bash
brewfile-add jq               # add a formula (new entries go to the end of the file)
brewfile-add --cask ghostty   # add an app
brewfile-remove jq            # remove an entry
brewfile-check                # compare the Brewfile with what is installed (changes nothing)
```

<br/>

## 📄 License

This project is released under the MIT License, which grants you the freedom to use, modify, and distribute this software without restriction.

For more information about the MIT License, please refer to the `LICENSE` file in the repository.
