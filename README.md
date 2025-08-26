# 🌌 VoidSpace

A minimalistic macOS development environment focused on distraction-free coding. Single fullscreen windows, keyboard-driven navigation, and clean aesthetics.

## 📸 Showcase

![macOS Ricing Setup](https://raw.githubusercontent.com/Ermag/dotfiles/refs/heads/main/showcase.png)

## 🚀 Quick Start

```bash
chmod +x ./setup.sh
./setup.sh
```

## 📦 What's Included

### Applications & Tools (22 packages)
- **Browser:** Brave
- **Terminal:** Ghostty + Fish shell + Starship prompt  
- **Editor:** Cursor (AI-powered)
- **Window Manager:** yabai + SketchyBar (with custom items)
- **Productivity:** Raycast, 1Password, Notion, Slack
- **Development:** Node.js, Go, Python, Docker, Neovim
- **Fonts:** Hack Nerd Font, Space Grotesk, SF Symbols

### System Configuration
- Dark mode + left dock (auto-hide)
- Custom keyboard shortcuts
- Spotlight disabled (replaced by Raycast)

### SketchyBar Custom Items
- **Brew Status**: Visual count of outdated packages (0-9+), click to upgrade
- **Caffeinate**: Toggle display sleep prevention  
- **Front App**: Shows current application
- **Media**: Current track with play/pause (auto-hide when stopped)
- **Volume**: Visual volume level with click controls
- **Battery**: Percentage with color-coded charge status (laptops only)
- **Clock**: Date and time display

### Dotfiles
- All configuration files in `.config/` directory
- Automatically copied to `~/.config/`

## 🛠 Individual Scripts

- `./brew.sh` - Install packages only
- `./mac.sh` - Configure macOS preferences only
- `./setup.sh` - Complete setup (runs all scripts)

## ⚠️ Prerequisites

- macOS system
- SIP disabled for yabai (interactive prompt provided)

---

**Happy ricing!** 🎨 