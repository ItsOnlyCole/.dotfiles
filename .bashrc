#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


#Aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfilesconfig/ --work-tree=$HOME'
alias cp='cp -i' # Confirms before overwriting
alias free='free -m' # Shows memory in MB
alias updateFonts='fc-cache -f -v'
alias clearme='cd ~ && clear && bash'
alias please='sudo'

###Runs with Bash Cmd
neofetch
