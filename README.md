# saveland
bash scripts for Hyprland/GNOME to save names &amp; locations of opened GUI applications (clients) and restore script.

Here's an explanation of how they work:

### save-windows.sh

1. Uses `wmctrl` and `xdotool` to gather information about all open windows
2. For each window, collects:
   - Window ID
   - Workspace ID
   - X and Y position
   - Width and height
   - Window class
   - Window title
   - The command that launched the window (when possible)
3. Saves all this information to `~/.saved_windows_ubuntu` in a structured format
4. Skips windows with no class information (like the desktop itself)

### load-windows.sh

1. Reads window configurations from the save file
2. For each window:
   - Switches to the correct workspace
   - Launches the application using the saved command
   - Tries to identify the new window using its title or class
   - Moves and resizes the window to match the saved position and dimensions
3. Includes delays to ensure operations complete properly
4. Provides feedback about the restoration process

### Installation Prerequisites:

Before using these scripts, you'll need to install the required tools:

```bash
sudo apt install wmctrl xdotool
```

### Important Notes:

1. Ubuntu/GNOME window management is different from Hyprland - these scripts use tools like wmctrl that work with X Window System

2. The script tries multiple strategies to identify the correct window after launching an application, but this can sometimes be tricky if applications don't consistently set their window properties

3. You might need to modify the command detection logic for specific applications

4. These scripts will work best on standard Ubuntu installations running GNOME with X11. If you're using Wayland (default in newer Ubuntu versions), you might need additional tools or modifications
