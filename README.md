# Declarative Auto‑Rice Bootstrapping Script (DARBS)
My current suckless NixOS configuration, built with flakes, Home Manager and Stylix.

Designed for a responsive, minimal, keyboard-driven Linux environment.

Loosely inspired by [LARBS](https://github.com/LukeSmithxyz/LARBS), but fully declarative and reproducible.

---

## Software Overview

| Type                 | Program           |
| -------------------- | ----------------- |
| Window Manager       | DWM with a highly customised source|
| Status Bar           | dwmblocks-async   |
| Application Launcher | dmenu_run         |
| Session Manager      | ly                |
| Screen Locker        | slock             |
| Terminal Emulator    | st                |
| Shell                | zsh               |
| Editor               | Neovim (AstroVim) |
| File Manager         | Thunar            |
| Image Viewer         | nsxiv             |
| Media Player         | mpv               |
| Notifications        | dunst             |
| Theming              | Stylix            |
| Fonts                | Nerd Font (Mono)  |
| System Monitoring    | htop              |
| Networking (TUI)     | nmtui             |
| Bluetooth (TUI)      | bluetui           |
| Audio Processing     | EasyEffects       |

---

## File Structure
- flake.nix     # Entry point
- hosts/        # Device specific configurations
- modules/
  - core/       # Core nix modules
    - suckless/ # DWM, dmenu, dwmblocks
  - home/       # Home Manager options 

---

## DWM

This system uses a highly modified fork of [DWM](https://github.com/dexter-latcham/dwm).

### Patches and Features
- Custom multi-monitor workflow
  - Monitors share a single global tagset
  - Switching to an occupied tag moves focus to the owning monitor before displaying the tag

- Scratchpads: toggleable floating windows for terminal, Bluetooth, network manager, and system monitor.
- Autostart: launches bar on DWM startup.
- Bar padding: visual padding bordering the status bar
- Systray: system tray integrated to the bar
- Status2D: enables status bar formatting
- StatusCmd: clickable status bar
- Xresources: colours read from xresources dynamically
- Hide vacant tags: only show active tags
- Swallowing: GUI applications temporarily replace the terminal they are launched from
- Vanity gaps: configurable gaps between clients

Default keybindings are loosely based on LARBS, with personal modifications.

---

## Status Bar

[dwmblocks-async](https://github.com/UtkarshVerma/dwmblocks-async) is used for the status bar.

Unlike dwmblocks, this fork allows multiple blocks to update concurrently without blocking each other.

In the standard DWM status bar, every block on the bar is revaluated at a regular interval.
Dwmblocks allows us to instead use block specific event driven updates.

### Blocks
- Wi-Fi block updates via a NetworkManager dispatcher script
- Power block updates through a udev rule when AC state changes
- Time updates once per minute

---

## Inspiration & Credits
- [Luke Smith - LARBS](https://github.com/LukeSmithxyz/LARBS)
  Introduction to Arch Linux, Suckless software and bootstrapping a system

- [dwmblocks-async]( https://github.com/UtkarshVerma/dwmblocks-async)
  Async dwmblocks fork

- [EasyEffects plugin reference](https://gist.github.com/jtrv/47542c8be6345951802eebcf9dc7da31)

- [donovanglover/nix-config](https://github.com/donovanglover/nix-config/)
  First NixOS configuration reference

- [Frost-Phoenix/nix-config](https://github.com/Frost-Phoenix/nixos-config)
  Inspiration for the layout/ structure of this repository
