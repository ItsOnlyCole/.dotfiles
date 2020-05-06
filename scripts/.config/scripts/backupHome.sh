#!/bin/bash

cd /backups

DATE=`date +"%y%m%d"`
FILENAME=${DATE}_homeBackup

tar cjvf $FILENAME.tar.gz /home/itsonlycole/.config \
    /home/itsonlycole/.dotfiles \
    /home/itsonlycole/.emacs.d \
    /home/itsonlycole/.local \
    /home/itsonlycole/.ssh \
    /home/itsonlycole/3dPrinting \
    /home/itsonlycole/Documents \
    /home/itsonlycole/Games \
    /home/itsonlycole/Notes \
    /home/itsonlycole/Pictures \
    /home/itsonlycole/Programming \
    /home/itsonlycole/Tabletop \
    /home/itsonlycole/.gitconfig \
    /home/itsonlycole/.xinitrc
