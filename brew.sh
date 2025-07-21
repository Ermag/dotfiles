#!/bin/bash

# Package definitions: package_name -> description
declare -A PACKAGES=(
    # Web Browsers
    ["--cask brave-browser"]="Brave Browser (Privacy-focused web browser)"
    
    # Terminal & Shell Tools
    ["--cask ghostty"]="Ghostty (Modern terminal emulator)"
    ["fish"]="Fish Shell (User-friendly command-line shell)"
    ["starship"]="Starship (Cross-shell prompt)"
    ["neovim"]="Neovim (Modern Vim-based text editor)"
    ["fastfetch"]="Fastfetch (System information tool)"
    
    # Fonts
    ["--cask font-space-grotesk"]="Space Grotesk Font (Modern geometric typeface)"
    ["--cask sf-symbols"]="SF Symbols (Apple's icon library)"
    ["--cask font-hack-nerd-font"]="Hack Nerd Font (Monospace font with icons)"
    ["--cask font-sketchybar-app-font"]="SketchyBar App Font (Icon font for SketchyBar)"
    
    # Productivity Tools
    ["--cask raycast"]="Raycast (Spotlight replacement with superpowers)"
    
    # Window Manager
    ["koekeishiya/formulae/yabai"]="yabai (Tiling window manager)"
    
    # Development Tools
    ["--cask cursor"]="Cursor (AI-powered code editor)"
    ["--cask insomnia"]="Insomnia (API testing tool)"
    
    # Containerization
    ["docker"]="Docker (Container platform)"
    ["docker-compose"]="Docker Compose (Multi-container Docker applications)"
    
    # Programming Languages & Runtimes
    ["node"]="Node.js (JavaScript runtime)"
    ["go"]="Go (Programming language)"
    ["python"]="Python (Programming language)"
    
    # Security & Utilities
    ["--cask 1password"]="1Password (Password manager)"
    
    # Office Suite
    ["--cask libreoffice"]="LibreOffice (Free office suite)"
    
    # Productivity & Communication
    ["--cask notion"]="Notion (All-in-one workspace)"
    ["--cask slack"]="Slack (Team communication)"
)

# Check and install Homebrew if needed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew
echo "Updating Homebrew..."
brew update

# Install all packages
echo "Installing packages..."
for package in "${!PACKAGES[@]}"; do
    echo "Installing: ${PACKAGES[$package]}"
    brew install "$package"
done

echo "Done!"
