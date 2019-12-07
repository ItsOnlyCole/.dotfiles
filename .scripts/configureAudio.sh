#!/bin/bash

jack_control start
sleep 2
pulseaudio --start
sleep 5
carla ~/.scripts/carla/mainConfig.carxp &
