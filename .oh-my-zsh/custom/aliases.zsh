alias ksb='knife spork bump'
alias ksu='knife spork upload'
alias kcu='knife cookbook upload'
kcuf() { knife cookbook upload $1 --force }
ksbu() { knife spork bump $1 && knife spork upload $1 }
alias kns='knife node show'
knsj() { knife node show jenkins$1.us.prezi.private }
alias ls='ls --color=tty'

alias gd='git diff'
alias gcaa='gca --amend'
alias gk='gitk'
alias grh='git reset --hard'
alias glg="git log --graph --pretty=format:'%Cred%H%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gri="git rebase --interactive"

alias sr='ssh -l root'
alias sp='ssh -l publisher'

alias st3='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

sm() {
  cmd=$1; shift
  for h in $*
  do
    echo $cmd on $h | tee $h.out
    sr $h "$cmd" | tee -a $h.out
  done
}

smp() {
  cmd=$1; shift
  for h in $*
  do
    echo $cmd on $h in background | tee $h.out
    (sr $h "$cmd" | tee -a $h.out) &
  done
}

# Shortcuts for activating and deactivating virtualenvs
v() {
	for candidate in virtualenv venv ../virtualenv ../../virtualenv ../ ../../; do
		if [ -f $candidate/bin/activate ]; then
			. $candidate/bin/activate
			return
		fi
	done
}
alias d='deactivate'
alias z=j

alias mt='./manage.py test'
alias mr='./manage.py runserver'
alias ms='./manage.py shell'
alias rmt='TEST_WITH_REMOTE=1 ./manage.py test'
