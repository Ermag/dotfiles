#!/bin/sh

# Set CONFIG_DIR if not already set
CONFIG_DIR=${CONFIG_DIR:-"$HOME/.config/sketchybar"}

# Source the icons and colors
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

# Check for outdated packages first
OUTDATED_COUNT=$(brew outdated --quiet | wc -l | tr -d ' ')

if [ "$OUTDATED_COUNT" -gt 0 ]; then
    # Only run update if there are outdated packages
    # Run brew update in background and update display
    (
        brew upgrade
        # After update, refresh the brew item by running the main script
        "$CONFIG_DIR/plugins/brew.sh"
    ) &
    
    # Immediately update icon to show we're working (use a different icon to indicate activity)
    sketchybar --set brew icon="$BREW_PACKAGE_UPDATING" background.color="$BREW_ACTIVE_COLOR"
else
    # No updates available, just refresh the display
    sketchybar --set brew icon="$BREW_PACKAGE_0" background.color="$BREW_INACTIVE_COLOR"
fi
