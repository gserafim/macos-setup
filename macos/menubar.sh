#!/usr/bin/env bash

# Show sound control icon on the menu bar
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Volume.menu"

# Show bluetooth icon on the menu bar
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"

# Show battery icon on the menu bar
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Battery.menu"

#Restart SystemUIServer
killall SystemUIServer