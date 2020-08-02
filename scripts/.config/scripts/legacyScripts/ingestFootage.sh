#!/bin/bash

importToProject=$1

#Function to check if originalVideo was inputted
function checkForOriginalVideo () {
    if [[ -z $originalVideo ]]
    then
        echo "Error: No Original Video Inputted!"
        exit 1
    fi
}

#Assigns arguments to variables based on if importToProject is true or not.
#Creates or sets up projectDirectories
if [[ $importToProject == "true" ]] || [[ $importToProject == "True" ]] \
    || [[ $importToProject == "t" ]] || [[ $importToProject == "T" ]]
then
    echo "Import to Project: $2"
    projectDir="/home/itsonlycole/ContentCreation/Projects/Active/$2"
    echo "Project Directory set to $projectDir"
    originalVideo=$3
    renameVideo=$4
    checkForOriginalVideo
else
    #Sets OriginalVideo and Rename Video based on if false or nothing is put
    if [[ $importToProject == "false" ]] || [[ $importToProject == "False" ]] \
        || [[ $importToProject == "f" ]] || [[ $importToProject == "F" ]]
    then
        originalVideo=$2
        renameVideo=$3
    else
        originalVideo=$1
        renameVideo=$2
    fi

    checkForOriginalVideo
    #Sets the projectDir based on if video is getting renamed or not
    if [[ -z $renameVideo ]] #True if $renameVideo is NULL
    then
        projectDir="/home/itsonlycole/ContentCreation/Projects/Active/${originalVideo%.*}"
    else
        projectDir="/home/itsonlycole/ContentCreation/Projects/Active/${renameVideo%.*}"
    fi
    echo "Creating New Project"
    echo "Set Project Directory to $projectDir"
    echo "Creating Project Directories"
    #Generates Project Directory and Sub-Directories
    mkdir $projectDir
    mkdir $projectDir/project
    mkdir $projectDir/video
    mkdir $projectDir/audio
    mkdir $projectDir/notes
    mkdir $projectDir/images
    mkdir $projectDir/graphics
    mkdir $projectDir/renders
fi

#Copies over sourceFile
echo "Copying $originalVideo to $projectDir/video"
cp $originalVideo "$projectDir/video/$originalVideo"

#Renames orginalVideo if rename isn't null / sets vars for videopath, convertedvideo, and audioDir
if [[ ! -z $renameVideo ]]
then
    echo "Renaming $originalVideo to $renameVideo"
    mv "$projectDir/video/$originalVideo" "$projectDir/video/$renameVideo"
    videoPath="$projectDir/video/$renameVideo"
    convertedVideo="${videoPath%.*}.mp4"
    audioDir="$projectDir/audio/$renameVideo"
    mkdir $audioDir
else
    videoPath="$projectDir/video/$originalVideo"
    convertedVideo="${videoPath%.*}.mp4"
    audioDir="$projectDir/audio/$originalVideo"
    mkdir $audioDir
fi

#Extracts multi-track audio into seperate audio files
echo "Extracting Audio"
ffmpeg -i "$videoPath" -map 0:a:0 -f wav "$audioDir/masterAudio.wav" -map 0:a:1 -f wav "$audioDir/micAudio.wav" -map 0:a:2 -f wav "$audioDir/voipAudio.wav" -map 0:a:3 -f wav "$audioDir/gameAudio.wav" -map 0:a:4 -f wav "$audioDir/mediaAudio.wav"

#Converts the source video to format useable by Adobe Premiere
echo "Converting Video to MP4"
HandBrakeCLI -i "$videoPath" \
    -o "$convertedVideo" --encoder mpeg4 --vfr --quality 1 --two-pass --turbo --vb 6000

echo "Ingesting Footage Finished"
