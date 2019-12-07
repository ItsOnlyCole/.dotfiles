#!/bin/bash

##Workspace currently set to home (f001)
ws=

i3-msg "workspace $ws; append_layout /home/itsonlycole/.layouts/workspaceMedia.json"

if pgrep -x "oogle" >/dev/null
then
    i3-msg "workspace $ws; exec gpmdp &"
    #exec gpmdp &
fi

#if pgrep -x "Discord" >/dev/null
#then
#    i3-msg "workspace $ws; exec discord &"
#fi

#i3-msg "workspce $ws; exec urxvt -e bash -c 'showTime'"
