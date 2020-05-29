#!/usr/bin/env bash
#
# shutdown.sh
#
# A custom shutdown script to run
# before shutdown/reboot commands
#

#If set to true, system reboots instead of shutting down.
#If set to -c, cancel's shutdown
arg=$1

#If scheduled shutdown needs to be canceled
if [ $arg = -c ]
then
    shutdown -c
    exit 1
fi

##############
#  Shutdown  #
#  Scripts   #
##############
#Copies a blank copy of playback.json for Google Play Music
cp /home/itsonlycole/.config/Google\ Play\ Music\ Desktop\ Player/json_store/freshBoot.json /home/itsonlycole/.config/Google\ Play\ Music\ Desktop\ Player/json_store/playback.json
# Push all Org Note Commits
bash /home/itsonlycole/.config/scripts/gitAutoPush.sh /home/itsonlycole/Notes

##############
#  Shutdown  #
#    CMD     #
##############

if [ $arg = true ]
then
    shutdown -r 0
elif [ $arg = True ]
then
    shutdown -r 0
else
    shutdown 0
fi
