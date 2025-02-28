# Installing Saveland

There are several ways to install Saveland on your system.

## Option 1: From Source (Manual Installation)

1. Clone the repository:
```bash
git clone https://github.com/MAX-786/saveland.git
```

2. Change to the directory:
```bash
cd saveland
```

3. Install using make:
```bash
sudo make install
```

This will install the `saveland` command to `/usr/local/bin`.

To uninstall:
```bash
sudo make uninstall
```

## Option 2: Debian/Ubuntu Package

If you're using Debian, Ubuntu, or a derivative:

1. Download the latest `.deb` package from the releases page.

2. Install it:
```bash
sudo apt install ./saveland_1.0.0_all.deb
```

Alternatively, build the package yourself:

1. Clone the repository:
```bash
git clone https://github.com/MAX-786/saveland.git
```

2. Navigate to the directory:
```bash
cd saveland
```

3. Build the package:
```bash
dpkg-buildpackage -us -uc -b
```

4. Install the package:
```bash
sudo apt install ../saveland_1.0.0_all.deb
```

## Option 3: Arch Linux (AUR)

If you're using Arch Linux or a derivative, you can install Saveland from the AUR:

```bash
# Using an AUR helper like yay
yay -S saveland

# Or manually
git clone https://aur.archlinux.org/saveland.git
cd saveland
makepkg -si
```

## Dependencies

### Core Dependencies:
- Bash (4.0+)
- jq

### For GNOME Support:
- wmctrl
- xdotool

Install these on Debian/Ubuntu with:
```bash
sudo apt install wmctrl xdotool
```

Install these on Arch Linux with:
```bash
sudo pacman -S wmctrl xdotool
```

## Testing the Installation

After installation, verify that Saveland is working:

```bash
saveland --version
```

This should display the version information.

## Additional Configuration

The first time you run Saveland, it will create a configuration directory at `~/.config/saveland/`. All saved window layouts will be stored in this directory.