#!/bin/bash
#
#
repo=$1
cd $repo
# Remove Deleted Files
git ls-files --deleted -z | xargs -0 git rm >/dev/null 2>&1
# Add new Files
git add . >/dev/null 2>&1
# Commit Changes
git commit -m "Autocommit : ""$(date)"
