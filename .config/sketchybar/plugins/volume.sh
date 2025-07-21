#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

# Source icons to get access to the VOLUME_ICON_MAP
source "$CONFIG_DIR/icons.sh"

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  case "$VOLUME" in
    [7-9][0-9]|100) ICON="$VOLUME_75" ;;  # 75% and above
    [5-6][0-9]) ICON="$VOLUME_50" ;;      # 50% to 74%
    [1-4][0-9]) ICON="$VOLUME_25" ;;      # 10% to 49%
    [1-9]) ICON="$VOLUME_25" ;;           # 1% to 9%
    0) ICON="$VOLUME_0" ;;                # 0% (muted)
    *) ICON="$VOLUME_0" ;;                # fallback for any other case
  esac

  sketchybar --set "$NAME" icon="$ICON"
fi
