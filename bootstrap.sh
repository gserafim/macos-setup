#!/bin/bash

# Check if Xcode Command Line Tools are already installed
if ! xcode-select -p >/dev/null 2>&1; then
    echo "Xcode Command Line Tools are not installed. Installing now..."
    
    # Start the installation of Xcode Command Line Tools
    xcode-select --install
    
    # Wait until the installation is complete
    until xcode-select -p >/dev/null 2>&1; do
        sleep 5
    done

    echo "Installation complete. Accepting license terms..."

    # Accept Xcode license agreement
    sudo xcodebuild -license accept
else
    echo "Xcode Command Line Tools are already installed."
fi

# Clone the repo into ~/.dotfiles
git clone https://github.com/gserafim/macos-setup.git ~/.dotfiles

# Change directory to the cloned repo
cd ~/.dotfiles

# Run the install script
./install.sh
