#!/bin/sh

# Set CONFIG_DIR if not already set
CONFIG_DIR=${CONFIG_DIR:-"$HOME/.config/sketchybar"}

# Source the icons and colors
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

# Check if caffeinate is running
CAFFEINATE_PID=$(pgrep -f "caffeinate -d")

if [ -n "$CAFFEINATE_PID" ]; then
    # Caffeinate is active - coffee mug icon with orange background
    ICON="$CAFFEINATE_ACTIVE_ICON"
    BG_COLOR="$CAFFEINATE_ACTIVE_COLOR"
else
    # Caffeinate is inactive - moon icon with transparent background
    ICON="$CAFFEINATE_INACTIVE_ICON"
    BG_COLOR="$CAFFEINATE_INACTIVE_COLOR"
fi

# Update the display - change background color, keep icon color white
sketchybar --set "$NAME" icon="$ICON" background.color="$BG_COLOR"
