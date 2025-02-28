# Saveland

Saveland is a lightweight utility for saving and restoring window layouts across Linux desktop environments. Whether you're using Hyprland or GNOME, Saveland lets you capture and recreate your perfect desktop setup with a single command.

## Features

- Save positions, sizes, and workspace information for all open GUI applications
- Support for multiple instances of the same application
- Works with both Hyprland and GNOME (X11) environments
- Preserves window attributes across restarts
- Automatic desktop environment detection
- Simple command-line interface

## Installation

See [INSTALL.md](INSTALL.md) for detailed installation instructions for different Linux distributions.

### Quick Install

#### From source:
```bash
sudo make install
```

#### For Debian/Ubuntu:
```bash
sudo apt install ./saveland_1.0.0_all.deb
```

#### For Arch Linux:
```bash
yay -S saveland
```

## Usage

Saveland automatically detects your desktop environment and applies the appropriate method.

### Save your current window layout:
```bash
saveland --save
```

### Restore your saved window layout:
```bash
saveland --load
```

### List saved layouts:
```bash
saveland --list
```

### Show help:
```bash
saveland --help
```

## How It Works

Saveland detects your desktop environment and uses the appropriate method to save and restore windows:

### For Hyprland:
- Uses the `hyprctl` JSON interface to get and set window information
- Saves workspace ID, window class, position, and size

### For GNOME (X11):
- Uses `wmctrl` and `xdotool` to manage windows
- Captures window class, title, command, workspace, position, and size
- Handles special cases for common applications

## Limitations

- GNOME support works best with X11 and may have limited functionality with Wayland
- Some applications may not restore perfectly if they manage their own window placement
- The script cannot save/restore window states like minimized/maximized

## Contributing

Contributions are welcome! Please check out our [Contributing Guide](CONTRIBUTING.md) for details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by an original script for saving Kitty terminal windows in Hyprland (found that somewhere in reddit)