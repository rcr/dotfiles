#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

stty -ixon

set -o vi
bind -m vi-insert '"jj": vi-movement-mode'
bind -m vi-insert '"\C-l": clear-screen'
bind -x '"\C-t":"urxvtc &> /dev/null &"'

if [ $(id -u) -eq 0 ];
	then PS1='root > \W/ '
	else PS1='> \W/ '
fi

eval $(dircolors -b)

export GREP_COLORS="fn=36:ln=36:mt=32"
export LESSHISTFILE=/dev/null

alias sudo='sudo '
alias ..='cd ..'
alias e="exit"
alias v="vim -O"
alias vs="vim -S ~/.vim/session.vim"
alias ls='ls --color=auto --group-directories-first'
alias grep='grep -n --color=auto'
alias mkdir='mkdir -p -v'
alias feh="feh --fullscreen"
alias todo="vim ~/.todo"

alias reboot="sudo shutdown -r now"
alias shutdown="sudo shutdown -h now"
alias mount="sudo mount -o uid=rcr,gid=users,fmask=113,dmask=002"
alias umount="sudo umount"
