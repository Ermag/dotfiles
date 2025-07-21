#!/bin/bash

# Front app icon configuration
front_app_icon=(
  script="$PLUGIN_DIR/front_app.sh"
  icon.font="sketchybar-app-font:Regular:18.0"
  icon.color=$MAIN_BG_COLOR
  icon.padding_left=8
  icon.padding_right=4
  label.drawing=off
  background.color=$FRONT_APP_BG_COLOR
)

# Front app label configuration
front_app_label=(
  script="$PLUGIN_DIR/front_app.sh"
  icon.font="Hack Nerd Font:Regular:34.0"
  icon.color=$FRONT_APP_BG_COLOR
  icon.padding_left=-2
  icon.padding_right=0
  label.padding_left=6
  label.padding_right=12
  background.padding_left=-8
)

# Add front app items to the left side
sketchybar --add item front_app_icon left \
           --set front_app_icon "${front_app_icon[@]}" \
           --subscribe front_app_icon front_app_switched

sketchybar --add item front_app_label left \
           --set front_app_label "${front_app_label[@]}" \
           --subscribe front_app_label front_app_switched
