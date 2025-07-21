#!/bin/bash

# macOS System Preferences Configuration

# Dark Mode
defaults write NSGlobalDomain AppleInterfaceStyle -string 'Dark'

# Dock Configuration
defaults write com.apple.dock orientation -string 'left'
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0

# Hot Corner - Bottom Right Desktop
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

# Keyboard Shortcuts
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '<dict><key>enabled</key><false/></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 27 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>9</integer><integer>48</integer><integer>524288</integer></array><key>type</key><string>standard</string></dict></dict>'

# Restart services to apply changes
killall Dock
killall SystemUIServer
