#!/bin/bash

jack_control stop
pulseaudio -k
killall -9 carla
