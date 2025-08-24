#!/bin/bash

# Package definitions using parallel arrays (compatible with bash 3.2+)
PACKAGES=(
    # Web Browsers
    "--cask brave-browser"
    
    # Terminal & Shell Tools
    "--cask ghostty"
    "fish"
    "starship"
    "neovim"
    "fastfetch"
    
    # Fonts
    "--cask font-space-grotesk"
    "--cask sf-symbols"
    "--cask font-hack-nerd-font"
    "--cask font-sketchybar-app-font"
    
    # Productivity Tools
    "--cask raycast"
    
    # Window Manager
    "koekeishiya/formulae/yabai"
    "FelixKratz/formulae/sketchybar"
    
    # Development Tools
    "--cask cursor"
    "--cask insomnia"
    
    # Containerization
    "--cask docker"
    
    # Programming Languages & Runtimes
    "node"
    "go"
    "python"
    
    # Security & Utilities
    "--cask 1password"
    
    # Office Suite
    "--cask libreoffice"
    
    # Productivity & Communication
    "--cask notion"
    "--cask slack"
)

# Package descriptions (parallel array)
DESCRIPTIONS=(
    # Web Browsers
    "Brave Browser (Privacy-focused web browser)"
    
    # Terminal & Shell Tools
    "Ghostty (Modern terminal emulator)"
    "Fish Shell (User-friendly command-line shell)"
    "Starship (Cross-shell prompt)"
    "Neovim (Modern Vim-based text editor)"
    "Fastfetch (System information tool)"
    
    # Fonts
    "Space Grotesk Font (Modern geometric typeface)"
    "SF Symbols (Apple's icon library)"
    "Hack Nerd Font (Monospace font with icons)"
    "SketchyBar App Font (Icon font for SketchyBar)"
    
    # Productivity Tools
    "Raycast (Spotlight replacement with superpowers)"
    
    # Window Manager
    "yabai (Tiling window manager)"
    "SketchyBar (Highly customizable macOS status bar)"
    
    # Development Tools
    "Cursor (AI-powered code editor)"
    "Insomnia (API testing tool)"
    
    # Containerization
    "Docker (Container platform)"
    "Docker Compose (Multi-container Docker applications)"
    
    # Programming Languages & Runtimes
    "Node.js (JavaScript runtime)"
    "Go (Programming language)"
    "Python (Programming language)"
    
    # Security & Utilities
    "1Password (Password manager)"
    
    # Office Suite
    "LibreOffice (Free office suite)"
    
    # Productivity & Communication
    "Notion (All-in-one workspace)"
    "Slack (Team communication)"
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
echo "Found ${#PACKAGES[@]} packages to install..."

# Install packages using array indices
for i in "${!PACKAGES[@]}"; do
    package="${PACKAGES[$i]}"
    description="${DESCRIPTIONS[$i]}"
    
    echo ""
    echo "📦 Installing: $package"
    echo "   Description: $description"
    
    if brew install $package; then
        echo "✅ Successfully installed: $package"
    else
        echo "❌ Failed to install: $package"
        echo "   Continuing with next package..."
    fi
done

echo "Done!"
