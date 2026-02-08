# kitty-tips

A command-line tool that displays tips and tricks for the [Kitty terminal emulator](https://sw.kovidgoyal.net/kitty/). Discover shortcuts, configuration options, and advanced features — one tip at a time.

## Features

- **65+ curated tips** across 7 categories
- **Tip of the day** — a fresh tip every day
- **Search** — find tips by keyword
- **Bookmarks** — save your favorite tips
- **What's New** — check the latest Kitty release changes
- **Beautiful output** — color-coded categories with box-drawing UI
- **Zero dependencies** — single Bash script, works everywhere
- **Cross-shell** — works in Fish, Bash, and Zsh with tab completions

## Installation

### Quick Install (recommended)

```bash
git clone https://github.com/thanhnguyen/kitty-tips.git
cd kitty-tips
./install.sh
```

The installer copies the binary to `~/.local/bin/` and sets up shell completions for your current shell.

### Manual Install

```bash
# Copy the binary
cp bin/kitty-tips ~/.local/bin/
chmod +x ~/.local/bin/kitty-tips

# (Optional) Install Fish completions
cp completions/kitty-tips.fish ~/.config/fish/completions/

# (Optional) Install Bash completions
cp completions/kitty-tips.bash ~/.local/share/bash-completion/completions/kitty-tips

# (Optional) Install Zsh completions
cp completions/_kitty-tips ~/.zsh/completions/  # must be in your $fpath
```

Make sure `~/.local/bin` is in your PATH.

## Usage

```bash
# Show a random tip
kitty-tips

# Tip of the day
kitty-tips daily

# Search tips
kitty-tips search "font"
kitty-tips search "split"

# List all tips (or filter by category)
kitty-tips list
kitty-tips list -c Shortcuts
kitty-tips list -c Config

# Show categories
kitty-tips categories

# Bookmark management
kitty-tips bookmark add 001
kitty-tips bookmark list
kitty-tips bookmark rm 001

# Check what's new in Kitty
kitty-tips whatsnew

# Help & version
kitty-tips --help
kitty-tips --version
```

## Categories

| Category | Description |
|---|---|
| Shortcuts | Keyboard shortcuts and key bindings |
| Config | kitty.conf settings and configuration |
| Appearance | Themes, fonts, colors, and visual customization |
| Layouts | Window and tab management |
| Advanced | SSH kitten, remote control, scripting |
| Performance | Speed, rendering, and GPU settings |
| Integration | Shell integration, clipboard, images, tools |

## Staying Up to Date

### Updating kitty-tips

```bash
cd kitty-tips
git pull
./install.sh
```

### Updating Kitty Terminal

kitty-tips includes a `whatsnew` command that shows information about the latest Kitty release. You can also:

- Check your version: `kitty --version`
- Update Kitty: `curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin`
- Set `update_check_interval 24` in `kitty.conf` for automatic update notifications
- Follow releases: https://github.com/kovidgoyal/kitty/releases

## Configuration

User data is stored in `~/.config/kitty-tips/`:
- `bookmarks` — your saved tip IDs
- `daily_history` — tracks daily tips shown

## Uninstall

```bash
rm ~/.local/bin/kitty-tips
rm -rf ~/.config/kitty-tips
# Remove completions for your shell:
rm ~/.config/fish/completions/kitty-tips.fish
rm ~/.local/share/bash-completion/completions/kitty-tips
# For zsh, remove _kitty-tips from your fpath
```

## License

MIT
