#!/bin/bash
# load-windows.sh - Restores windows based on saved configurations for Ubuntu/GNOME

# Check if needed dependencies are installed
if ! command -v wmctrl &> /dev/null; then
    echo "wmctrl is not installed. Please install it with: sudo apt install wmctrl"
    exit 1
fi

if ! command -v xdotool &> /dev/null; then
    echo "xdotool is not installed. Please install it with: sudo apt install xdotool"
    exit 1
fi

save_file="$HOME/.saved_windows_ubuntu"

if [ ! -f "$save_file" ]; then
    echo "No saved window configuration found at $save_file"
    exit 1
fi

# Function to switch to a specific workspace
switch_workspace() {
    local workspace=$1
    
    # Skip invalid workspace values
    if [[ "$workspace" == "-1" ]]; then
        echo "Skipping invalid workspace -1"
        return
    fi
    
    # Get number of workspaces
    local num_workspaces=$(wmctrl -d | wc -l)
    
    # Verify workspace is valid
    if (( workspace >= 0 && workspace < num_workspaces )); then
        wmctrl -s "$workspace"
        sleep 0.5  # Allow time for the workspace switch
    else
        echo "Warning: Workspace $workspace is out of range (0-$((num_workspaces-1)))"
        # Default to workspace 0
        wmctrl -s 0
        sleep 0.5
    fi
}

# Function to launch an application with special handling for certain apps
launch_application() {
    local command="$1"
    local class="$2"
    
    # Special handling for common applications
    if [[ "$class" == "Gnome-terminal" ]]; then
        gnome-terminal &
        return $!
    elif [[ "$class" == "Firefox" || "$class" == "firefox" ]]; then
        firefox &
        return $!
    elif [[ "$class" == "Brave" || "$class" == "brave-browser" ]]; then
        brave &
        return $!
    elif [[ "$class" == "Nautilus" || "$class" == "Files" ]]; then
        nautilus &
        return $!
    fi
    
    # Default launching method
    if [[ "$command" == *"/"* ]]; then
        # It's a path, execute directly
        eval "$command" &
    else
        # Try to launch the command
        $command &
    fi
    
    return $!
}

# Read each line from the save file
while IFS= read -r line; do
    # Extract the components
    workspace=$(echo "$line" | grep -o 'workspace=[^ ]*' | cut -d= -f2)
    class=$(echo "$line" | grep -o 'class=[^ ]*' | cut -d= -f2)
    title_raw=$(echo "$line" | grep -o 'title=.*command=' | sed 's/title=//; s/ command=$//')
    title=$(eval echo "$title_raw") # Unescape the title
    command_raw=$(echo "$line" | grep -o 'command=.*position=' | sed 's/command=//; s/ position=$//')
    command=$(eval echo "$command_raw") # Unescape the command
    position=$(echo "$line" | grep -o 'position=[^ ]*' | cut -d= -f2)
    size=$(echo "$line" | grep -o 'size=[^ ]*' | cut -d= -f2)
    
    # Extract X, Y coordinates and width, height
    pos_x=$(echo "$position" | cut -d, -f1)
    pos_y=$(echo "$position" | cut -d, -f2)
    width=$(echo "$size" | cut -d, -f1)
    height=$(echo "$size" | cut -d, -f2)

    # Fix workspace if invalid
    if [[ "$workspace" == "-1" ]]; then
        workspace=0
    fi

    # Switch to the workspace first
    switch_workspace "$workspace"
    
    # Launch the application using our special function
    launch_application "$command" "$class"
    app_pid=$?
    
    # Wait for the application to start
    sleep 2
    
    # Try to find the window by title and/or class
    window_id=""
    
    # First try by class
    for attempt in {1..5}; do
        window_id=$(xdotool search --class "$class" 2>/dev/null | head -n 1)
        
        if [ -n "$window_id" ]; then
            break
        fi
        
        # If we can't find by class, try by title (partial match)
        window_id=$(wmctrl -l | grep -i "$title" | head -n 1 | awk '{print $1}')
        
        if [ -n "$window_id" ]; then
            break
        fi
        
        sleep 1
    done
    
    # If we found a window, move and resize it
    if [ -n "$window_id" ]; then
        # Use xdotool for more reliable window manipulation
        xdotool windowsize "$window_id" "$width" "$height"
        xdotool windowmove "$window_id" "$pos_x" "$pos_y"
        
        # Activate the window (bring to front)
        wmctrl -i -a "$window_id"
        
        echo "Restored window: $class ($title) to workspace $workspace at position $pos_x,$pos_y with size $width×$height"
    else
        echo "Could not find window for $class ($title) after launch"
    fi
    
    # Small delay between launching applications
    sleep 1
    
done < "$save_file"

echo "Window restoration complete"
