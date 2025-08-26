#!/bin/bash

# Brew packages button configuration
brew_button=(
  script="$PLUGIN_DIR/brew.sh"
  click_script="$PLUGIN_DIR/brew_click.sh"
  update_freq=60
  padding_left=2
  icon.font="Hack Nerd Font:Bold:18.0"
  icon.color=$MAIN_BG_COLOR
  label.drawing=off
  icon.padding_left=9
  icon.padding_right=8
  background.drawing=on
  background.color=$BREW_INACTIVE_COLOR
  background.corner_radius=8
  background.height=30
)

# Add brew button to the left side
sketchybar --add item brew left \
           --set brew "${brew_button[@]}"
