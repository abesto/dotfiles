# Check for an interactive session
#[ -z "$PS1" ] && return 0

source /etc/profile  # for autojump
source ~/.bashprompt

alias ls='ls --color=auto --group-directories-first'
alias la='ls -a'
alias yup='yaourt -Syu'
alias y='yaourt -Sy'
alias ys='yaourt'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../../'
alias ec='emacsclient'

shopt -s cdspell
shopt -s progcomp

export OOO_FORCE_DESKTOP=gnome

eval `dircolors -b`

export GREP_COLRO="1;33"
alias grep='grep --color=auto'

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#export EDITOR='emacsclient -c'
#export VISUAL='emacsclient -c'

export EDITOR='vim'
export VISUAL='vim'

set show-all-if-ambiguous on

extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

clear

