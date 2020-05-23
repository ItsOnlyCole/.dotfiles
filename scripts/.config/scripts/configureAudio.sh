#!/bin/bash

unloadDevice () {
  local deviceInfo=$(pactl list short modules | grep $1)
  local deviceNum
  #echo $deviceInfo
  for (( i=0; i<${#deviceInfo}; i++)); do
    if [ "${deviceInfo:$i:1}" == 'm' ]
    then
      deviceNum="${deviceNum:0:$i-1}"
      break
    fi
    deviceNum=$deviceNum"${deviceInfo:$i:1}"
  done
  pactl unload-module $deviceNum
  echo "Unloaded Device"
}


killall -9 jackdbus
killall -9 pulseaudio
killall -9 carla
#sleep 5
jack_control start
sleep 2
pulseaudio --start
sleep 1
killall -9 pulsaudio
pulseaudio --start
sleep 5
unloadDevice SteelSeries
#unloadDevice USB_Sound_Device
unloadDevice Burr

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

alsa_in -j "SteelSeries Mic" -d hw:7 -q 2 2> /dev/null 1> /dev/null &
alsa_in -j "Mixer Master" -d hw:CODEC -q 2 2> /dev/null 1> /dev/null &
alsa_out -j "SteelSeries Out" -d hw:Wireless,1 -q 2 2> /dev/null 1> /dev/null &
#pactl load-module module-loopback source=alsa_input.usb-SteelSeries_Arctis_Pro_Wireless-00.analog-mono sink=SteelSeriesMic
#pacmd load-module module-jack-sink channels=2 sink_name=voip-out client_name=voip-out connect=false

#pacmd load-module module-jack-sink channels=2 sink_name=games-out client_name=games-out connect=false

#pacmd load-module module-jack-source channels=2 source_name=media-in client_name=media-in connect=false
#pacmd load-module module-jack-sink channels=2 sink_name=media-out client_name=media-out connect=false
sleep 2
carla ~/.config/carla/mainConfig.carxp &
