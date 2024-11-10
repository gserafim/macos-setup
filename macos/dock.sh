#!/usr/bin/env bash

## More information can be found here: https://developer.apple.com/documentation/devicemanagement/dock

## If true, enables "Automatically hide and show the dock."
defaults write com.apple.dock autohide -bool true

## The behavior when the window's title bar is double-clicked.
defaults write com.apple.dock dblclickbehavior -string "maximize"

## Disable magnification).
defaults write com.apple.dock magnification -bool false

## Remove all persistent apps from the Dock.
defaults write com.apple.dock persistent-apps -array ""

## Set the tile size of icons in the Dock.
defaults write com.apple.dock tilesize -int 1

## Hide process indicators for open applications in the Dock.
defaults write com.apple.dock show-process-indicators -bool false

## Disable rearrange spaces based on most recent use.
defaults write com.apple.dock mru-spaces -bool false

## Disable automatic switching to a Space with open windows for an app.
defaults write com.apple.Dock workspaces-auto-swoosh -bool false
defaults write NSGlobalDomain AppleSpacesSwitchOnActivate -bool false

## If true, enables "Displays have separate Spaces."
## Enabled to fix the mission control when Aerospace is installed
defaults write com.apple.spaces spans-displays -bool true


## Restart the Dock to apply the changes.
killall Dock
