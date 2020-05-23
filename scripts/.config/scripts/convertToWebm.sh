#!/usr/bin/env bash

originalFile=$1
newFile=${originalFile%.*}.webm

ffmpeg -i $originalFile -c:v libvpx-vp9 $newFile
