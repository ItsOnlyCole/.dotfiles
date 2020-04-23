#!/bin/bash
#
#
repo=$1

cd $repo
#Commits any last second changes
###Remove Deleted Files
git ls-files --deleted -z | xargs -0 git rm >/dev/null 2>&1
###Add New Files
git add . >/dev/null 2>&1
###Commit Changes
git commit -m "AutoCommmit : ""$(date)"

#Pushes Changes
git push
