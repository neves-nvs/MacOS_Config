#!/bin/sh

# https://macos-defaults.com/

# Boot

# Disable the sound effects on boot
if [ ! "$( nvram -p | grep StartupMute | awk '{print $2}' )" = '%01' ]; then
    echo "Disabling the sound effects on boot"
    sudo nvram StartupMute=%01
fi

# MENU BAR

# Display Battery Percentage in Battery Icon
# defaults writeocom.apple.menuextra.battery ShowPercent -string "YES"
menuReload=false

defaults -currentHost write com.apple.controlcenter.plist BatteryShowPercentage -bool true

if [ $menuReload = true ]; then
    echo "Reloading Menu Bar"
    killall SystemUIServer
fi

# DOCK
dockReload=false

# Set Dock Icons
# TODO

if [ $dockReload = true ]; then
    echo "Reloading Dock"
    killall Dock
fi

# Finder
finderReload=false

# Default View Style (Nlsv - List View | icnv - Icon View | clmv - Column View | Flwv - Cover Flow View)
# defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# show hidden files
if [ ! "$(defaults read com.apple.finder "AppleShowAllFiles")" -eq 1 ]; then
    echo "Enabling Finder to show hidden files"
    defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
    finderReload=true
fi

defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/Downloads" # TODO Not working

defaults write com.apple.finder _FXShowPosixPathInTitle -bool false
defaults write com.apple.finder ShowPathbar -bool true # ShowPathbar apparently does not exist at first, only after togling on manually

finderReload=true

if [ $finderReload = true ]; then
    echo "Reloading Finder"
    killall Finder
fi

# Messages

# Enable Messages via iCloud
# TODO

# Select which e-mails are usable for iMessage 
# TODO

# Screenshots

# Disable shadow when capturing a window
defaults write com.apple.screencapture "disable-shadow" -bool "false"

# Non Macos Apps

# Mos

# reverse the mouse wheel scroll direction
default write com.caldis.Mos reverse 1

# disable smooth scrolling
default write com.caldis.Mos smooth 0

# AlDente
# Disable dock icon

# iTerm2
# Enable Nerd Font
# Set iTerm2 to start fullscreen
