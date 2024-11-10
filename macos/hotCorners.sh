#!/usr/bin/env bash

#List of VALUES
# 0: None
# 2: Mission Control
# 3: Show Desktop (keeping the current window)
# 4: Show Desktop
# 5: Start Screen Saver
# 6: Disable Screen Saver
# 7: Put Display to Sleep
# 10: Show Application Windows
# 11: Dashboard

#List of modifiers keys
# 0: None (No key needed to be pressed to activate the hotcorner action)
# 131072: Shift
# 262144: Control
# 524288: Option (Alt)
# 1048576: Command

# Top-left corner
defaults write com.apple.dock wvous-tl-corner -int 4
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top-right corner
defaults write com.apple.dock wvous-tr-corner -int 2
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom-left corner
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom-right corner
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

killall Dock
