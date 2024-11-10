#!/usr/bin/env bash

## More information can be found here: https://developer.apple.com/documentation/devicemanagement/finder

## Hide external hard drives on the desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false

## Hide removable media on the desktop.
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

## Disable warning when emptying the trash.
defaults write com.apple.finder WarnOnEmptyTrash -bool false

## Show the ~/Library folder by removing the hidden flag and Finder-specific metadata.
chflags nohidden ~/Library
xattr -d com.apple.FinderInfo ~/Library 2>/dev/null || true

## Show the /Volumes folder by removing the hidden flag with administrator privileges.
sudo chflags nohidden /Volumes

## show new folders conrtent as list
defaults write com.apple.finder FXPreferredViewStyle Nlsv

#Hide recent tags from sidebar
defaults delete com.apple.sidebarlists favoriteTagNames 2>/dev/null || true
defaults write com.apple.sidebarlists systemitems -dict-add ShowRecentTags -bool false

# osascript ~/.dotfiles/scripts/hide_tags.scpt
# osascript ~/.dotfiles/scripts/set_list_view.scpt

killall Finder
