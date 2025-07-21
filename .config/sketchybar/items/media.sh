#!/bin/bash

# Media configuration
media_item=(
  script="$PLUGIN_DIR/media.sh"
  click_script="$PLUGIN_DIR/media_click.sh"
  update_freq=3
  label.color=$MAIN_TEXT_COLOR
  icon.padding_right=6
  label.padding_left=0
  padding_right=15
)

# Add media to the right side
sketchybar --add item media right \
           --set media "${media_item[@]}" 