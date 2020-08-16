#!/bin/bash

#Set up for StarTech 7.1 USB sound card

#Sets Jack to use Alsa
jack_control ds alsa
#Sets device to usb soundcard
#	Use "cat /proc/asound/cards" to list sound devices
jack_control dps device hw:2
#Sets Audio Sampling Rate
jack_control dps rate 48000
#Sets nperiods (2 for PCIe, 3 for USB)
jack_control dps nperiods 3
#Sets buffer size
jack_control dps period 128

### To check latency or other issues. Use Cadence for stats
