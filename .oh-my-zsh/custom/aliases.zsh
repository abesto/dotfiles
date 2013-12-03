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
alias irc-tunnel='ssh -f abesto@direct.abesto.net -L 6667:direct.abesto.net:6667 -N'

# from https://github.com/prezi/dotfiles/blob/zsol/ec2/aliases.zsh
alias instances="ec2-describe-instances"
essh() {
    id=$(echo $1 | grep -o 'i-[0-9a-f]\{8\}')
    shift
    ec2_ssh $id "$@"
}
ec2_ssh() {
    id=$1; shift
    ec2host=$(ec2-describe-instances --show-empty-fields $id | grep '^INSTANCE' | cut -f4)
    ssh $ec2host "$@"
}
chef_ssh() {
    role=$1; shift
    chefhost=$(knife search node role:$role -R 1 -Fj | jq -r '.rows[0].automatic.cloud.public_hostname')
    ssh $chefhost "$@"
}
s() {
    id=$(echo $1 | grep -o 'i-[0-9a-f]\{8\}')
    if [ $? -eq 0 ]; then
        shift
        ec2_ssh $id "$@"
    else
        chef_ssh "$@"
    fi
}
# eof stolen from zsol

sr() {
	s "$@" -l root
}
sp() {
	s "$@" -l publisher
}

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

