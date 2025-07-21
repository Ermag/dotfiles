#!/bin/bash

# Volume configuration
volume_item=(
  script="$PLUGIN_DIR/volume.sh"
  click_script="$PLUGIN_DIR/volume_click.sh"
  icon.padding_left=-2
  icon.padding_right=0
  label.padding_left=0
  label.padding_right=0
  width=40
  align=center
)

# Add volume to the right side
sketchybar --add item volume right \
           --set volume "${volume_item[@]}" \
           --subscribe volume volume_change 