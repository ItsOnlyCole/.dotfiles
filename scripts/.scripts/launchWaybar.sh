#!/usr/bin/env sh
# Teminates already running instances of waybar
killall -q waybar

# Waits until the processes have been shut down
while pgrep -u $UID -x waybar >/dev/null; do sleep 1; done

waybar
