#!/bin/bash

#while $(pidof pulseaudio | wc -w) != 1
while [ $(pidof pulseaudio | wc -w) != 1 ]
do
    echo "Not active"
done
echo "Active"
