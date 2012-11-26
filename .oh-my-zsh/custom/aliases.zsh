alias ksb='knife spork bump'
alias ksu='knife spork upload'
alias kcu='knife cookbook upload'
kcuf() { knife cookbook upload $1 --force }
ksbu() { knife spork bump $1 && knife spork upload $1 }

alias gd='git diff'
alias gcaa='gca --amend'
alias gk='gitk'

alias sr='ssh -l root'
alias sp='ssh -l publisher'
alias s='ssh'

sm() {
  cmd=$1; shift
  for h in $*
  do
    echo $cmd on $h
    sr $h "$cmd"
  done
}

smp() {
  cmd=$1; shift
  for h in $*
  do
    echo $cmd on $h in background
    sr $h "$cmd" &
  done
}
