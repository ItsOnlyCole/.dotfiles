#!/bin/bash

graphicsMode=$(system76-power graphics)

if [ $graphicsMode = "nvidia" ]
then
    xrandr --setprovideroutputsource modesetting NVIDIA-0
    xrandr --output eDP-1-1 --auto

    # Re-sets the wallpaper to fit the new screen
    feh --bg-center ~/.local/share/wallpaper/zeroTwoEnding.jpg
fi
