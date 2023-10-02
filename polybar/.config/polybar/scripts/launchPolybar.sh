#!/usr/bin/env sh

#Sets which bar for a specific device is used
arg=$1

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar -r mainBar
