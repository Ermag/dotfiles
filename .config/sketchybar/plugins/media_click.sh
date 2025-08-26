#!/bin/sh

# Toggle play/pause when media item is clicked using MediaRemote framework
osascript -e '
use framework "AppKit"

property togglePlayPause : 2

on run
  -- Load MediaRemote classes into the ObjC runtime
  set MediaRemote to current application'\''s NSBundle'\''s bundleWithPath:"/System/Library/PrivateFrameworks/MediaRemote.framework/"
  MediaRemote'\''s load()
  
  -- Send toggle play/pause command
  my sendCommand(togglePlayPause)
end run

-- Sends a media command to the local player (i.e. your computer, not an external device)
on sendCommand(theCommand)
  set MRNowPlayingController to current application'\''s NSClassFromString("MRNowPlayingController")
  set commandOptions to current application'\''s NSDictionary'\''s alloc()'\''s init()
  set controller to MRNowPlayingController'\''s localRouteController()
  controller'\''s sendCommand:theCommand options:commandOptions completion:(missing value)
  
  -- Add a small delay to ensure the command processes properly
  delay 0.1
end sendCommand
' 2>/dev/null

# Force media update to reflect the change immediately
sketchybar --update
