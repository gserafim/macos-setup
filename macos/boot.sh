#!/usr/bin/env bash

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Show language menu in the top right corner of the boot screen
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

## --- SOUND
defaults write com.apple.systemsound com.apple.sound.beep.volume -float 0