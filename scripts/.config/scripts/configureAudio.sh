#!/bin/bash

#PT1 Unloads devices from Pulse Audio to Load into Jack (Extra Devices Only)
# Example: unloadDevice Burr
# Example2: unloadDevice SteelSeries
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

jack_control stop
killall -9 jackdbus
killall -9 pulseaudio
killall -9 carla
killall -9 non-mixer
killall -9 a2jmidid
killall -9 mididings
killall -9 pa-applet

sleep 2
jack_control start
non-mixer --osc-port=15159 ~/.config/nonMixerConfig/ > /dev/null 2>&1 &
sleep 2
pulseaudio --start

pacmd unload-module module-jack-sink
pacmd unload-module module-jack-source
sleep 3
pacmd load-module module-jack-sink channels=2 sink_name=voip client_name=voip connect=false
pacmd load-module module-jack-sink channels=2 sink_name=media client_name=media connect=false
pacmd load-module module-jack-sink channels=2 sink_name=game client_name=game connect=false
pacmd load-module module-jack-source channels=2 source_name=masterCap client_name=masterCap connect=false
pacmd load-module module-jack-source channels=2 source_name=micCap client_name=micCap connect=false

#PT2 Loads in extra devices into Jack
#alsa_in -j "SteelSeries Mic" -d hw:7 -q 2 2> /dev/null 1> /dev/null &
#alsa_in -j "Mixer Master" -d hw:CODEC -q 2 2> /dev/null 1> /dev/null &
#alsa_out -j "SteelSeries Out" -d hw:Wireless,1 -q 2 2> /dev/null 1> /dev/null &

sleep 2
mididings -f .config/scripts/midi-nanoKontrol2.py > /dev/null 2>&1 &
a2jmidid -e > /dev/null 2>&1 &
carla ~/.config/carla/mainConfig.carxp > /dev/null 2>&1 &
pa-applet > /dev/null 2>&1 &
