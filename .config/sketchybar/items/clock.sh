#!/bin/bash

# Clock configuration
clock_item=(
  script="$PLUGIN_DIR/clock.sh"
  update_freq=10
  padding_right=2
  icon.drawing=off
)

# Add clock to the right side
sketchybar --add item clock right \
           --set clock "${clock_item[@]}"
