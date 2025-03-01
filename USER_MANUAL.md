# Saveland User Manual

## Introduction

Saveland is a lightweight utility for saving and restoring window layouts across Linux desktop environments. Whether you're using Hyprland or GNOME, Saveland lets you capture and recreate your perfect desktop setup with a single command.

## Installation

To install Saveland, follow the guide at [INSTALL.md](INSTALL.md)

## Basic Usage

### Saving a Window Layout

To save your current window layout:

```bash
saveland --save
# OR
saveland -s
```

This will detect your desktop environment (Hyprland or GNOME) and save the positions, sizes, and workspace information for all open windows.

### Restoring a Window Layout

To restore a previously saved window layout:

```bash
saveland --restore
# OR
saveland -r
```

This will launch applications in their saved positions and sizes, and organize them into the correct workspaces.

### Listing Saved Layouts

To view basic information about saved layouts:

```bash
saveland --list
# OR
saveland -l
```

To see detailed information about each window in saved layouts:

```bash
saveland --list --all
# OR
saveland -l -a
```

## Configuration

Saveland is configurable through its configuration file or via the interactive configuration editor.

### Configuration File

The configuration file is located at:
```
$HOME/.config/saveland/config
```

### Interactive Configuration Editor

To modify your configuration interactively:

```bash
saveland --config
```

This will guide you through all available settings.

### Configuration Help

To see help about configuration options:

```bash
saveland --config --help
# OR
saveland --config -h
```

## Configuration Options

### Launch Delay

The time in seconds to wait between launching applications during restoration. Increase this value if you have slower applications that need more time to launch.

```
LAUNCH_DELAY=0.5
```

### Restore Delay

The time in seconds to wait for an application to start before attempting to position and resize it. Increase this value if windows aren't being positioned correctly.

```
RESTORE_DELAY=2
```

### List Format

Controls the default output format when listing saved layouts. Options are 'compact' (default) or 'detailed'.

```
LIST_FORMAT=compact
```

### Backups

Controls whether Saveland automatically creates backups of previous layouts when saving a new layout.

```
CREATE_BACKUPS=true
```

### Maximum Backups

Controls how many backup files to keep when CREATE_BACKUPS is enabled.

```
MAX_BACKUPS=5
```

## Desktop Environment Support

Saveland currently supports the following desktop environments:

1. **Hyprland** - A dynamic tiling Wayland compositor
2. **GNOME** - Using X11 (requires wmctrl and xdotool)

## Troubleshooting

### Windows Not Positioning Correctly

If windows aren't positioning correctly during restoration:

1. Increase the `RESTORE_DELAY` value in the configuration
2. Ensure required dependencies are installed (wmctrl and xdotool for GNOME)

### Applications Not Launching

If certain applications aren't launching during restoration:

1. Check that the application command is correctly detected by Saveland
2. Add special handling for the application in the source code if needed

## File Locations

- Configuration file: `$HOME/.config/saveland/config`