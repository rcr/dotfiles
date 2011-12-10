#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[1;33m\]user: \W/\[\033[0m\] '

eval $(dircolors -b)

export PATH=/opt/flex/bin:$PATH
export EDITOR=vim
export GREP_COLOR="1;33"

alias sudo='sudo '
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias mkdir='mkdir -p -v'
alias wicd="wicd-curses"
alias alsa="alsamixer"
alias shutdown="sudo shutdown -h now"
alias todo="vim /etc/conky/conky_todo"
alias v="vim -O" #-O switch so you can open multiple files in vertical split
alias ch="setsid chromium &> /dev/null"
alias irc="setsid terminator --geometry 683x748+0+0 -T Irssi -e irssi &> /dev/null"
alias mu="setsid terminator --geometry 683x748+0+0 -T Mutt -e mutt &> /dev/null"
alias e="exit"

#Functions for aliases with arguments
pdf () { setsid epdfview "$1" &> /dev/null;}
doc () { setsid libreoffice "$1" &> /dev/null;}
sanitize() {	#reset owner and permission to default values
  chmod -R u=rwX,go=rX "$@"
  chown -R ${USER}:users "$@"
}
f4 () { cp $1 /home/robbinsr/.config/openbox/scripts/f4.sh; echo "Script set";}
ex () {			#extract any filetype
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
