#!/bin/bash
# loadworkspaces.sh - Restores windows based on saved configurations

save_file="$HOME/.saved_windows"

if [ ! -f "$save_file" ]; then
    echo "No saved window configuration found at $save_file"
    exit 1
fi

# Function to sanitize window titles for the command line
sanitize_title() {
    echo "$1" | sed 's/"/\\"/g'
}

# Read each line from the save file
while IFS= read -r line; do
    # Extract the components
    workspace=$(echo "$line" | grep -o 'workspace=[0-9]*' | cut -d= -f2)
    class=$(echo "$line" | grep -o 'class=[^ ]*' | cut -d= -f2)
    title_raw=$(echo "$line" | grep -o 'title=.*move=' | sed 's/title=//; s/ move=$//')
    title=$(eval echo "$title_raw") # Unescape the title
    position=$(echo "$line" | grep -o 'move=[^ ]*' | cut -d= -f2)
    size=$(echo "$line" | grep -o 'size=[^ ]*' | cut -d= -f2)
    
    # Switch to the workspace first
    hyprctl dispatch workspace "$workspace"
    
    # Wait a moment to ensure the workspace switch completes
    sleep 0.1
    
    # Launch the application with its class, position, and size
    # Note: This assumes the application can be launched by its class name (lowercase)
    # You might need to customize this for specific applications
    app_name=$(echo "$class" | tr '[:upper:]' '[:lower:]')
    
    # Create a sanitized title for matching
    sanitized_title=$(sanitize_title "$title")
    
    # Launch the application with specific position and size
    hyprctl dispatch exec "[workspace $workspace;move $position;size $size] $app_name"
    
    echo "Launched $class on workspace $workspace with position $position and size $size"
    
    # Small delay between launching applications to prevent overwhelming the system
    sleep 0.5
    
done < "$save_file"

echo "Window restoration complete"