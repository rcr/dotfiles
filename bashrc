#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi
bind -m vi-insert '"jj": vi-movement-mode'
bind -m vi-insert '"\C-l": clear-screen'

PS1='> \W/ '

eval $(dircolors -b)

export GREP_COLOR="1;33"

alias sudo='sudo '
alias ..='cd ..'
alias e="exit"
alias v="vim -O"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias mkdir='mkdir -p -v'
alias alsa="alsamixer"
alias wicd="wicd-curses"
alias feh="feh --fullscreen"
alias todo="vim ~/docs/todo"
alias reboot="sudo shutdown -r now"
alias shutdown="sudo shutdown -h now"
alias irc="urxvt -e weechat-curses"
alias mount="sudo mount -o gid=users,fmask=113,dmask=002"
alias umount="sudo umount"
alias ff="firefox"

pdf () { zathura $1 &> /dev/null & }
ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       rar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       7z x $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
