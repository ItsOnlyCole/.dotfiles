#!/bin/bash
originalVideo=$1
convertedVideo="${originalVideo%.*}.mp4"
#Converts the source video to format useable by Adobe Premiere
echo "Converting Video to MP4"
HandBrakeCLI -i "$originalVideo" \
    -o "$convertedVideo" --encoder mpeg4 --vfr --quality 1 --two-pass --turbo --vb 12000

echo "Ingesting Footage Finished"
