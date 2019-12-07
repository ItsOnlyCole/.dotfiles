#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


#Aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfilesconfig/ --work-tree=$HOME'
