# Saveland

Saveland is a collection of bash scripts designed to save and restore window layouts across Linux desktop environments. Whether you're using Hyprland or GNOME, Saveland lets you capture and recreate your perfect desktop setup with ease.

## Features

- Save positions, sizes, and workspace information for all open GUI applications
- Support for multiple instances of the same application
- Works with both Hyprland and GNOME (X11) environments
- Preserves window attributes across restarts
- Simple command-line interface

## Installation

### Prerequisites

#### For Hyprland users:
No additional dependencies required.

#### For GNOME users:
```bash
sudo apt install wmctrl xdotool
```

### Setup

1. Clone the repository:
```bash
git clone https://github.com/MAX-786/saveland.git
```

2. Make the scripts executable:
```bash
cd saveland
chmod +x *.sh
```

3. Optionally, add the scripts to your PATH for easier access.

## Usage

### For Hyprland users:

#### Save your current window layout:
```bash
./save-windows-hyprland.sh
```
This saves all window information to `~/.saved_windows`.

#### Restore your window layout:
```bash
./load-windows-hyprland.sh
```

### For GNOME users:

#### Save your current window layout:
```bash
./save-windows-gnore.sh
```
This saves all window information to `~/.saved_windows_ubuntu`.

#### Restore your window layout:
```bash
./load-windows-gnome.sh
```

## How It Works

### Hyprland Scripts

#### saveworkspaces.sh
- Uses `hyprctl` to get window information in JSON format
- Extracts class, position, size, and workspace data for each window
- Stores data in a structured format in `~/.saved_windows`

#### loadworkspaces.sh
- Reads the saved window configurations
- Switches to appropriate workspaces
- Launches applications with the correct size and position

### GNOME Scripts

#### save-windows.sh
- Uses `wmctrl` and `xdotool` to gather window information
- Collects window ID, workspace, position, size, class, title, and launch command
- Saves data to `~/.saved_windows_ubuntu`

#### load-windows.sh
- Reads window configurations from the save file
- Switches to the correct workspace for each window
- Launches applications and repositions/resizes them

## Limitations

- The GNOME scripts work best with X11 and may have limited functionality with Wayland
- Some applications may not restore perfectly if they manage their own window placement
- Command detection might need tweaking for specific applications
- The scripts currently don't handle window states like minimized/maximized

## Contributing

Contributions are welcome! Please check out our [Contributing Guide](CONTRIBUTING.md) for details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by an original script for saving Kitty terminal windows in Hyprland (found that somewhere in reddit)