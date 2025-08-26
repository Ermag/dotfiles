#!/bin/sh

# Set CONFIG_DIR if not already set
CONFIG_DIR=${CONFIG_DIR:-"$HOME/.config/sketchybar"}

# Source the icons and colors
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

# Check for outdated packages (this might take a moment)
OUTDATED_COUNT=$(brew outdated --quiet | wc -l | tr -d ' ')

if [ "$OUTDATED_COUNT" -gt 0 ]; then
    # There are outdated packages - show active state with appropriate icon
    BG_COLOR="$BREW_ACTIVE_COLOR"
    
    # Select icon based on number of outdated packages
    if [ "$OUTDATED_COUNT" -eq 1 ]; then
        ICON="$BREW_PACKAGE_1"
    elif [ "$OUTDATED_COUNT" -eq 2 ]; then
        ICON="$BREW_PACKAGE_2"
    elif [ "$OUTDATED_COUNT" -eq 3 ]; then
        ICON="$BREW_PACKAGE_3"
    elif [ "$OUTDATED_COUNT" -eq 4 ]; then
        ICON="$BREW_PACKAGE_4"
    elif [ "$OUTDATED_COUNT" -eq 5 ]; then
        ICON="$BREW_PACKAGE_5"
    elif [ "$OUTDATED_COUNT" -eq 6 ]; then
        ICON="$BREW_PACKAGE_6"
    elif [ "$OUTDATED_COUNT" -eq 7 ]; then
        ICON="$BREW_PACKAGE_7"
    elif [ "$OUTDATED_COUNT" -eq 8 ]; then
        ICON="$BREW_PACKAGE_8"
    elif [ "$OUTDATED_COUNT" -eq 9 ]; then
        ICON="$BREW_PACKAGE_9"
    else
        # 10 or more packages
        ICON="$BREW_PACKAGE_9Plus"
    fi
else
    # No outdated packages - show inactive state with zero packages icon
    ICON="$BREW_PACKAGE_0"
    BG_COLOR="$BREW_INACTIVE_COLOR"
fi

# Update the display - change background color based on status
sketchybar --set "$NAME" icon="$ICON" background.color="$BG_COLOR"
