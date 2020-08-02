#!/bin/bash

bash ~/.config/scripts/configureMonitors.sh
nitrogen --restore &
picom -Cb &
