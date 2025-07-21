#!/bin/sh

# Source icons and settings
source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/settings.sh"

# Get currently playing media using macOS MediaRemote framework (universal)
get_now_playing() {
  # Use MediaRemote framework to get now playing info and playback state
  MEDIA_INFO=$(osascript -e '
    use framework "AppKit"
    
    on run
      try
        set MediaRemote to current application'\''s NSBundle'\''s bundleWithPath:"/System/Library/PrivateFrameworks/MediaRemote.framework/"
        MediaRemote'\''s load()
        
        set MRNowPlayingRequest to current application'\''s NSClassFromString("MRNowPlayingRequest")
        
        set infoDict to MRNowPlayingRequest'\''s localNowPlayingItem()'\''s nowPlayingInfo()
        set title to (infoDict'\''s valueForKey:"kMRMediaRemoteNowPlayingInfoTitle") as text
        set playbackRate to (infoDict'\''s valueForKey:"kMRMediaRemoteNowPlayingInfoPlaybackRate") as real
        
        return title & "|" & playbackRate
      on error
        return ""
      end try
    end run
  ' 2>/dev/null)
  
  echo "$MEDIA_INFO"
}

# Add test variable for debugging
# TEST_TRACK="Test Song Name"  # Uncomment to test

# Get the currently playing track and playback state
if [ -n "$TEST_TRACK" ]; then
  CURRENT_TRACK="$TEST_TRACK"
  IS_PLAYING=1  # Assume playing for test
else
  MEDIA_DATA=$(get_now_playing)
  if [ -n "$MEDIA_DATA" ] && [ "$MEDIA_DATA" != "" ]; then
    CURRENT_TRACK=$(echo "$MEDIA_DATA" | cut -d'|' -f1)
    PLAYBACK_RATE=$(echo "$MEDIA_DATA" | cut -d'|' -f2)
    
    # Check if playing (rate = 1) or paused (rate = 0)
    # Handle both comma and period decimal separators
    if [ "$PLAYBACK_RATE" = "1" ] || [ "$PLAYBACK_RATE" = "1.0" ] || [ "$PLAYBACK_RATE" = "1,0" ]; then
      IS_PLAYING=1
    else
      IS_PLAYING=0
    fi
  else
    CURRENT_TRACK=""
    IS_PLAYING=0
  fi
fi

# Update the item
if [ -n "$CURRENT_TRACK" ] && [ "$CURRENT_TRACK" != "" ]; then
  # Choose icon based on playback state
  if [ "$IS_PLAYING" = "1" ]; then
    MEDIA_ICON="$MEDIA_PLAYING"
  else
    MEDIA_ICON="$MEDIA_PAUSED"
  fi
  
  # Truncate long track names to prevent bar overflow
  if [ ${#CURRENT_TRACK} -gt $MAX_TRACK_LENGTH ]; then
    TRUNCATE_TO=$((MAX_TRACK_LENGTH - 3))  # Account for "..." 
    CURRENT_TRACK="${CURRENT_TRACK:0:$TRUNCATE_TO}..."
  fi
  
  sketchybar --set "$NAME" icon="$MEDIA_ICON" label="$CURRENT_TRACK" icon.drawing=on drawing=on
else
  # No media playing - hide the item completely
  sketchybar --set "$NAME" drawing=off
fi 