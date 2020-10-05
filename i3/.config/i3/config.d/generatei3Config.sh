#!/bin/bash


i3Dir=$HOME/.config/i3
configD=$i3Dir/config.d
deviceConfig=$configD/deviceSpecific/$HOSTNAME

# Generates deviceConfigFile if it doesn't exist
if [ -f "$deviceConfig" ]; then
	echo "$deviceConfig exists"
else
	touch $deviceConfig
	echo "$deviceConfig Created"
fi

cat $configD/systemConfig $configD/autoStartApps $configD/appShortcuts $configD/appRestrictions $configD/workspaces $deviceConfig > $i3Dir/config
echo "Generated i3 config"

echo "Reloading i3"
i3-msg restart
