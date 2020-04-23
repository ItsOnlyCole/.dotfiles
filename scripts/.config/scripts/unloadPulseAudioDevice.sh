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

unloadDevice $1
