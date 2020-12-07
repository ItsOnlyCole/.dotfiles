#!/bin/bash
#dockConnect.sh
#   A series of commands to run when connecting to a TB3 Dock



# Set Monitors
xrandr --output eDP-1-1 --auto --below DP-0.3 --output DP-0.3 --auto --primary --output DP-0.2 --auto --right-of DP-0.3
# Set Wallpaper
feh --bg-center ~/.local/share/wallpapers/zeroTwoEnding.jpg
# Disable Suspend on Lid Closed
