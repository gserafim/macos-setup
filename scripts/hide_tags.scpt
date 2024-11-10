tell application "System Events"
    tell process "Finder"
        set frontmost to true
        keystroke "," using command down
        delay 1
        tell window 1
            tell toolbar 1
                click button "Tags"
            end tell
            delay 1
            tell group 1 of group 1
                click checkbox "Tags"
            end tell
            delay 1
            click button 1
        end tell
    end tell
end tell
