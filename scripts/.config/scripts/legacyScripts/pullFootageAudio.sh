#!/bin/bash

originalVideo=$1
videoName=${originalVideo::-4}
audioFolder=$videoName
mkdir $audioFolder
ffmpeg -i $originalVideo -map 0:a:0 -f flac $audioFolder/masterAudio.flac -map 0:a:1 -f flac $audioFolder/micAudio.flac -map 0:a:2 -f flac $audioFolder/voipAudio.flac -map 0:a:3 -f flac $audioFolder/gameAudio.flac -map 0:a:4 -f flac $audioFolder/mediaAudio.flac
mv $originalVideo $audioFolder/$originalVideo
