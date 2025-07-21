#!/bin/bash

# Caffeinate button configuration
caffeinate_button=(
  script="$PLUGIN_DIR/caffeinate.sh"
  click_script="$PLUGIN_DIR/caffeinate_click.sh"
  update_freq=5
  padding_left=2
  icon.font="Hack Nerd Font:Bold:18.0"
  icon.color=$MAIN_BG_COLOR
  label.drawing=off
  icon.padding_left=9
  icon.padding_right=8
  background.drawing=on
  background.color=$CAFFEINATE_INACTIVE_COLOR
  background.corner_radius=8
  background.height=30
)

# Add caffeinate button to the left side
sketchybar --add item caffeinate left \
           --set caffeinate "${caffeinate_button[@]}"
