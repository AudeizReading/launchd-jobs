#!/bin/sh

# Get the number of files in the Trash
file_count=$(osascript -e 'tell application "Finder" to count items in trash')

# Check if the Trash is already empty
if [[ "$file_count" -eq 0 ]]; then
    osascript -e 'display dialog "Trash is already empty." buttons {"OK"} default button "OK" with title "Weekly Empty Trash" with icon success'
    exit 0
fi

# Get the list of files in the Trash
file_list=$(osascript -e 'tell application "Finder" to name of every item in trash' | sed 's/, /\n* /g')

# Display a dialog to ask the user if they really want to empty the Trash
response=$(osascript -e "display dialog \"There are ${file_count} files into Trash folder :\n\n$file_list\n\nWould you really erase them definitively ?\" buttons {\"Cancel\", \"Yes\"} default button \"Cancel\" with title \"Weekly Empty Trash\" with icon caution")

# Check the user's response
if [[ "$response" == "button returned:Yes" ]]; then
    # Empty the Trash and display a notification
    osascript -e 'tell application "Finder" to empty trash'
    osascript -e 'display notification "Trash has just been emptied" with title "Trash has been emptied"'
else
	# Display a notification to inform the user that the Trash has not been emptied
    osascript -e 'display notification "Empty Trash has just been canceled" with title "Trash has been canceled"'
	# Sleep for 60 seconds and then run the script again, let the time to user to restore the files that they want to keep (has to be done manually, do not find a way to do it with AppleScript)
	sleep 60

	file_count=$(osascript -e 'tell application "Finder" to count items in trash')
	if [[ "$file_count" -ne 0 ]]; then
		# If the Trash is not empty, run the script again
		$0
	fi
fi