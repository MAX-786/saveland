#!/bin/bash
# saveworkspaces.sh - Saves the position and size of all GUI windows across all workspaces

# Get all clients/windows from hyprctl in JSON format
all_windows=$(hyprctl -j clients)

# Create a temporary file to store the window data
temp_file=$(mktemp)

# Process the JSON data to extract relevant information
echo "$all_windows" | jq -r '.[] | {
    class: .class,
    title: .title,
    workspace: .workspace.id,
    at: .at,
    size: .size
}' | jq -s '.' > "$temp_file"

# Check if we got any windows
window_count=$(jq 'length' "$temp_file")

if [ "$window_count" -gt 0 ]; then
    # Create the save file
    save_file="$HOME/.saved_windows"
    
    # Process the data into a format that can be used to restore windows
    jq -r '.[] | "workspace=\(.workspace) class=\(.class) title=\(.title|@sh) move=\(.at[0]),\(.at[1]) size=\(.size[0]),\(.size[1])"' "$temp_file" > "$save_file"
    
    echo "Saved $window_count windows to $save_file"
else
    echo "No windows found to save"
fi

# Clean up
rm "$temp_file"