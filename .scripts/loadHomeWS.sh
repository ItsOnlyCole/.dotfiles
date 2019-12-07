#!/bin/bash

##Workspace currently set to home (f015)
ws=

while [ $(pidof pulseaudio | wc -w) != 1 ]
do
    sleep 1
done

#Sleep is to give time for Pulseaudio to fully start
sleep 2

i3-msg "workspace $ws; append_layout /home/itsonlycole/.layouts/workspaceHome.json"

i3-msg "workspace $ws; exec qutebrowser &"
i3-msg "workspace $ws; exec urxvt -e bash -c 'cava && bash'"
sleep 1
i3-msg "workspace $ws; exec urxvt"
