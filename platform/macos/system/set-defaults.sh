#!/usr/bin/env bash
# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Run ./set-defaults.sh and you'll be good to go.

set -e

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Run the screensaver if we're in the bottom-left hot corner.
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Safari's preferences can be protected by macOS privacy permissions. Stop at
# the first failed Safari write, but let the rest of setup continue.
set_safari_defaults () {
  # Hide the favorites bar and show link URLs on mouseover.
  defaults write com.apple.Safari ShowFavoritesBar -bool false &&
  defaults write com.apple.Safari ShowOverlayStatusBar -bool true &&
  # Set up Safari for development.
  defaults write com.apple.Safari.SandboxBroker ShowDevelopMenu -bool true &&
  defaults write com.apple.Safari IncludeDevelopMenu -bool true &&
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true &&
  defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
}

if safari_output=$(set_safari_defaults 2>&1); then
  :
else
  printf '%s\n' '[WARN] Safari preferences were not fully applied; continuing setup.' >&2
  printf '%s\n' "$safari_output" >&2
  printf '%s\n' 'For permission errors, grant the app running this script Full Disk Access in System Settings > Privacy & Security, restart that app, and rerun set-defaults. You can also adjust Safari settings manually.' >&2
fi

defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
