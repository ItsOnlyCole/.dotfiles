#!/bin/bash

ws1=1
ws2=2
	
i3-msg "workspace $ws1; append_layout /home/itsonlycole/.layouts/Stream-OBSChat.json"

i3-msg "workspace $ws1; exec obs --profile 'GamePlayerCole (Live)' --collection 'GamePlayerCole (Live)' --scene 'Stream Starting Soon - GamePlayerCole (Live)' &"
i3-msg "workspace $ws1; exec qutebrowser -B ~/.config/qutebrowser-StreamGamePlayerCole --target window htts://mixer.com/GamePlayerCole"
sleep 1
i3-msg "workspace $ws2; append_layout /home/itsonlycole/.layouts/Stream-Dashboard.json"
i3-msg "workspace $ws2; exec qutebrowser -B ~/.config/qutebrowser-StreamGamePlayerCole --target window https://twitter.com"
i3-msg "workspace $ws2; exec qutebrowser -B ~/.config/qutebrowser-StreamGamePlayerCole --target tab https://youtube.com"
sleep 3
i3-msg "workspace $ws2; exec qutebrowser -B ~/.config/qutebrowser-StreamGamePlayerCole --target window https://streamlabs.com/dashboard#/twitch"
i3-msg "workspace $ws2; exec qutebrowser -B ~/.config/qutebrowser-StreamGamePlayerCole --target tab https://mixer.com/dashboard/channel/broadcast"
