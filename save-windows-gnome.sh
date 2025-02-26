#!/bin/bash
# save-windows.sh - Saves the position and size of all GUI windows in Ubuntu/GNOME

# Check if needed dependencies are installed
if ! command -v wmctrl &> /dev/null; then
    echo "wmctrl is not installed. Please install it with: sudo apt install wmctrl"
    exit 1
fi

if ! command -v xdotool &> /dev/null; then
    echo "xdotool is not installed. Please install it with: sudo apt install xdotool"
    exit 1
fi

# Create the save file
save_file="$HOME/.saved_windows_ubuntu"
> "$save_file"  # Clear file contents

# Get current workspace
current_workspace=$(wmctrl -d | grep '*' | cut -d ' ' -f1)

# Get all windows
window_list=$(wmctrl -l -G)

# Process each window
while read -r window_line; do
    window_id=$(echo "$window_line" | awk '{print $1}')
    workspace_id=$(echo "$window_line" | awk '{print $2}')
    pos_x=$(echo "$window_line" | awk '{print $3}')
    pos_y=$(echo "$window_line" | awk '{print $4}')
    width=$(echo "$window_line" | awk '{print $5}')
    height=$(echo "$window_line" | awk '{print $6}')
    window_class=$(xprop -id "$window_id" WM_CLASS 2>/dev/null | sed 's/.*"\(.*\)".*/\1/')
    window_title=$(echo "$window_line" | cut -d ' ' -f8-)
    
    # Skip windows with no class (like the desktop)
    if [ -z "$window_class" ]; then
        continue
    fi
    
    # Get the command that started this window (best effort)
    pid=$(xdotool getwindowpid "$window_id" 2>/dev/null)
    cmd=""
    if [ -n "$pid" ]; then
        cmd=$(ps -p "$pid" -o cmd= 2>/dev/null || echo "")
    fi
    
    # If we couldn't get the command, use the class as a fallback
    if [ -z "$cmd" ]; then
        cmd=$(echo "$window_class" | tr '[:upper:]' '[:lower:]')
    fi
    
    # Write to save file
    echo "workspace=$workspace_id class=$window_class title=$(printf '%q' "$window_title") command=$(printf '%q' "$cmd") position=$pos_x,$pos_y size=$width,$height" >> "$save_file"
    
done <<< "$window_list"

# Count saved windows
window_count=$(wc -l < "$save_file")

echo "Saved $window_count windows to $save_file"
