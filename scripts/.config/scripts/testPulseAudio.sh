#!/bin/bash

pulseaudio --start

pacmd load-module module-null-sink sink_name=Media sink_properties=device.description=Media
pacmd load-module module-null-sink sink_name=Music sink_properties=device.description=Music
pacmd load-module module-null-sink sink_name=Game sink_properties=device.description=Game
pacmd load-module module-null-sink sink_name=Voip sink_properties=device.description=Voip



pacmd load-module module-loopback source=Media.monitor
pacmd load-module module-loopback source=Music.monitor
pacmd load-module module-loopback source=Game.monitor
pacmd load-module module-loopback source=Voip.monitor
