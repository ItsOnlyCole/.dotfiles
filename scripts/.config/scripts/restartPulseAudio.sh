#!/bin/bash

#killall -9 pulseaudio
#pulseaudio --start

sleep 1
pacmd unload-module module-jack-sink
pacmd unload-module module-jack-source
sleep 3
pacmd load-module module-jack-source channels=2 source_name=voipCap client_name=voipCap connect=false
pacmd load-module module-jack-source channels=1 source_name=micCap client_name=micCap connect=true
pacmd load-module module-jack-source channels=2 source_name=masterCap client_name=masterCap connect=false

pacmd load-module module-jack-sink channels=2 sink_name=media client_name=media connect=true
pacmd load-module module-jack-sink channels=1 sink_name=SteelSeriesMic client_name=SteelSeriesMic connect=false
#pacmd load-module module-jack-sink channels=2 sink_name=game client_name=game connect=false
pacmd load-module module-jack-sink channels=2 sink_name=voip client_name=voip connect=false

pactl load-module module-loopback source=alsa_input.usb-SteelSeries_Arctis_Pro_Wireless-00.analog-mono sink=SteelSeriesMic
