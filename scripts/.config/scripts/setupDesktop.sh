#!/bin/bash

bash ~/.config/scripts/configureMonitors.sh
nitrogen --restore &
picom -Cb &
# bash ~/.config/scripts/configureAudio.sh
