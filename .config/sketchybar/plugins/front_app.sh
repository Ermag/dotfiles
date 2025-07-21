#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

# Source icons to get access to the get_app_icon function
source "$CONFIG_DIR/icons.sh"

if [ "$SENDER" = "front_app_switched" ]; then
  APP_ICON=$(get_app_icon "$INFO")
  
  # Check if we should use SF Symbols font
  if [[ "$APP_ICON" == SF_SYMBOLS:* ]]; then
    # Extract the symbol name (everything after "SF_SYMBOLS:")
    SYMBOL="${APP_ICON#SF_SYMBOLS:}"
    sketchybar --set front_app_icon icon="$SYMBOL" icon.font="SF Pro:Semibold:18.0"
  else
    # Use sketchybar-app-font
    sketchybar --set front_app_icon icon="$APP_ICON" icon.font="sketchybar-app-font:Regular:18.0"
  fi
  
  sketchybar --set front_app_label label="$INFO" icon=""
fi
