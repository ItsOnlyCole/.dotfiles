#!/usr/bin/env sh

#If set to mainAlt, launches polybar mainALT
arg=$1

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
if [ $arg = "mainAlt" ]
then
  polybar -r mainALT &
else
  polybar -r main &
fi
