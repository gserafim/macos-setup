tell application "Finder"
    set homeFolderPath to (path to home folder) as alias
    set libraryPath to (path to library folder from user domain) as alias

    -- Get all folders recursively from the home folder, excluding the Library folder
    set foldersList to (every folder of entire contents of homeFolderPath) as alias list
    repeat with aFolder in foldersList
        set folderPath to (aFolder as text)
        if folderPath does not start with (libraryPath as text) then
            try
                open aFolder
                set the current view of the front Finder window to list view
                close the front Finder window
            end try
        end if
    end repeat
end tell
