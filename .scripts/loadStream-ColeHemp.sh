#!/bin/bash

##Workspace currently set to home (f121)
ws1=1
ws2=2
	
i3-msg "workspace $ws1; append_layout /home/itsonlycole/.layouts/Stream-OBSChat.json"

i3-msg "workspace $ws1; exec obs --profile 'ColeHemp (Live)' --collection 'ColeHemp (Live)' --scene 'Stream Starting Soon - ColeHemp (Live)' &"
i3-msg "workspace $ws1; exec qutebrowser -B ~/.config/qutebrowser-StreamColeHemp --target window https://www.twitch.tv/popout/ColeHemp/chat?popout="

sleep 1
i3-msg "workspace $ws2; append_layout /home/itsonlycole/.layouts/Stream-Dashboard.json"
i3-msg "workspace $ws2; exec qutebrowser -B ~/.config/qutebrowser-StreamColeHemp --target window https://www.twitch.tv/ColeHemp/dashboard/live"
sleep 1
i3-msg "workspace $ws2; exec qutebrowser -B ~/.config/qutebrowser-StreamColeHemp --target window https://streamlabs.com/dashboard#/twitch"
i3-msg "workspace $ws2; exec qutebrowser -B ~/.config/qutebrowser-StreamColeHemp --target tab https://twitter.com"
i3-msg "workspace $ws2; exec qutebrowser -B ~/.config/qutebrowser-StreamColeHemp --target tab https://youtube.com"
