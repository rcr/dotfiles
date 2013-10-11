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

export GREP_COLOR="1;33"
export LESSHISTFILE=/dev/null

alias sudo='sudo '
alias ..='cd ..'
alias e="exit"
alias v="vim -O"
alias vs="vim -S ~/.vim/session.vim"
alias ls='ls --color=auto --group-directories-first'

alias grep='grep --color=auto'
alias mkdir='mkdir -p -v'
alias feh="feh --fullscreen"
alias todo="vim ~/words/todo"

alias reboot="sudo reboot"
alias shutdown="sudo shutdown -h now"
alias mount="sudo mount -o uid=rcr,gid=users,fmask=113,dmask=002"
alias umount="sudo umount"

pdf () { mupdf "$1" &> /dev/null & }
ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       7z x $1      ;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
