#!/bin/sh

# Source icons and colors
source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

# Test variables - uncomment and modify these to test different battery states
# TEST_PERCENTAGE=9    # Test percentage (0-100)
# TEST_CHARGING=false    # true = charging, false = not charging

# Use test values if defined, otherwise get real battery data
if [ -n "$TEST_PERCENTAGE" ]; then
  PERCENTAGE="$TEST_PERCENTAGE"
else
  PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
fi

if [ -n "$TEST_CHARGING" ] && [ "$TEST_CHARGING" = "true" ]; then
  CHARGING="AC Power"
else
  if [ -z "$TEST_CHARGING" ]; then
    CHARGING="$(pmset -g batt | grep 'AC Power')"
  else
    CHARGING=""
  fi
fi

if [ "$PERCENTAGE" = "" ] && [ -z "$TEST_PERCENTAGE" ]; then
  exit 0
fi

# Determine icon based on percentage and charging status
if [[ "$CHARGING" != "" ]]; then
  # Charging - use charging icon and green color
  ICON="$BATTERY_CHARGING"
  COLOR="$BATTERY_COLOR_CHARGING"
else
  # Not charging - choose icon and color based on percentage
  case "${PERCENTAGE}" in
    [8-9][0-9]|100) 
      ICON="$BATTERY_100"
      COLOR="$MAIN_TEXT_COLOR"
      ;;
    [6-7][0-9]) 
      ICON="$BATTERY_75"
      COLOR="$MAIN_TEXT_COLOR"
      ;;
    [4-5][0-9]) 
      ICON="$BATTERY_50"
      COLOR="$MAIN_TEXT_COLOR"
      ;;
    [2-3][0-9]) 
      ICON="$BATTERY_25"
      COLOR="$MAIN_TEXT_COLOR"
      ;;
    [1][0-9]) 
      ICON="$BATTERY_25"
      COLOR="$BATTERY_COLOR_LOW"      # Orange for 10-19%
      ;;
    [1-9]) 
      ICON="$BATTERY_0"
      COLOR="$BATTERY_COLOR_CRITICAL" # Red for 1-9%
      ;;
    0) 
      ICON="$BATTERY_0"
      COLOR="$BATTERY_COLOR_CRITICAL" # Red for 0%
      ;;
    *) 
      ICON="$BATTERY_0"
      COLOR="$BATTERY_COLOR_CRITICAL"
      ;;
  esac
  
  # Apply additional orange color for <25% (if not already critical)
  if [ "$PERCENTAGE" -lt 25 ] && [ "$PERCENTAGE" -ge 10 ]; then
    COLOR="$BATTERY_COLOR_LOW"
  fi
fi

# Update the item with icon, color, and label
sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%"
