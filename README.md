# dotfiles

Arch Linux (CachyOS) · Hyprland · Catppuccin + Wallust

## Setup

| Component | Config |
|-----------|--------|
| WM | [Hyprland](https://hyprland.org/) 0.55 |
| Bar | [Waybar](https://github.com/Alexays/Waybar) 0.15 (ML4W glass-center) |
| Notifications | [SwayNC](https://github.com/ErikReider/SwayNotificationCenter) (athena glass) |
| Launcher | [Walker](https://github.com/abenz1267/walker) + [Rofi](https://github.com/lbonn/rofi) |
| Terminal | [Alacritty](https://alacritty.org/) |
| Shell | [Fish](https://fishshell.com/) + [Starship](https://starship.rs/) |
| Monitor | [Btop](https://github.com/aristocratos/btop) |
| Widgets | [Quickshell](https://github.com/quickshell/quickshell) |
| Overview | Quickshell overview (Super+Tab) |

## Theming

Dual theming: **Catppuccin** (static 4 flavors) + **Wallust** (dynamic from wallpaper).

| Key | Action |
|-----|--------|
| `Super+Shift+C` | Theme switcher (Walker menu) |
| `Super+Ctrl+S` | Sidebar with Catppuccin controls |

### Catppuccin Flavors

- `latte` — Light
- `frappe` — Dark (blueish)
- `macchiato` — Dark (warm)
- `mocha` — Dark (purple)

### Wallust (Dynamic)

Extracts colors from wallpaper → generates all app configs via templates (`~/.config/wallust/templates/`).

## Keybinds

| Key | Action |
|-----|--------|
| `Super+Enter` | Terminal |
| `Super+B` | Browser |
| `Super+E` | File manager |
| `Super+Q` | Kill window |
| `Super+F` | Fullscreen |
| `Super+T` | Toggle floating |
| `Super+Tab` | Window overview |
| `Super+Shift+C` | Theme switcher |
| `Super+PrtSc` | Screenshot menu |
| `Super+Alt+F` | Fullscreen screenshot |
| `Super+Alt+S` | Area → clipboard |
| `Super+Ctrl+L` | Lock screen |
| `Super+1-0` | Switch workspace |

Full keybinds: `Super+Ctrl+K`

## Install

```bash
git clone git@github.com:NewReno/dotfiles.git
cd dotfiles
# Symlink configs to ~/.config/
```

## Screenshots

_(add screenshots here)_
