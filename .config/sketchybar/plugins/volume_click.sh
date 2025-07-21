#!/bin/sh

# Toggle mute/unmute when volume item is clicked
CURRENT_VOLUME=$(osascript -e "output volume of (get volume settings)")
MUTED=$(osascript -e "output muted of (get volume settings)")

if [ "$MUTED" = "true" ]; then
  # Currently muted, unmute and restore previous volume
  # We'll unmute and set to a reasonable volume if it was 0
  if [ "$CURRENT_VOLUME" -eq 0 ]; then
    osascript -e "set volume output volume 50"
  else
    osascript -e "set volume output muted false"
  fi
else
  # Currently not muted, mute it
  osascript -e "set volume output muted true"
fi

# Force volume update to reflect the change immediately
sketchybar --trigger volume_change 