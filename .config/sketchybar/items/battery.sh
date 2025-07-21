#!/bin/bash

# Check if device has a battery before adding the item
BATTERY_INFO="$(pmset -g batt 2>/dev/null | grep -E "InternalBattery|Battery")"

# For testing on desktop - uncomment the next line to force battery item to show
# BATTERY_INFO="testing"

if [ -n "$BATTERY_INFO" ]; then
  # Battery configuration
  battery_item=(
    script="$PLUGIN_DIR/battery.sh"
    update_freq=120
    icon.color=$MAIN_TEXT_COLOR
    label.color=$MAIN_TEXT_COLOR
    icon.padding_right=0
  )

  # Add battery to the right side only if battery exists
  sketchybar --add item battery right \
             --set battery "${battery_item[@]}" \
             --subscribe battery system_woke power_source_change
fi
