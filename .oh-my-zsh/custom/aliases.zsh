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
alias gup="git up"

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
f() {
    find . -iname "*$**"
}

alias mt='./manage.py test'
alias mr='./manage.py runserver'
alias ms='./manage.py shell'
alias rmt='TEST_WITH_REMOTE=1 ./manage.py test'

mtt() {
	mt $(echo $1 | totest)
}
alias rmtt='TEST_WITH_REMOTE=1 mtt'

alias irc-tunnel='ssh -f abesto@direct.abesto.net -L 6667:direct.abesto.net:6667 -N'

CHEF_HOME=${CHEF_HOME:-$HOME/.prezi/prezi-chef}
find_roles() {
    regex="$1"; shift
    ls $CHEF_HOME/roles | sed 's/\.json$//' | grep -E "$regex"
}
alias instances="ec2-describe-instances"
essh() {
    id=$(echo $1 | grep -o 'i-[0-9a-f]\{8\}')
    shift
    ec2_ssh $id "$@"
}
ec2_ssh() {
    id=$1; shift
    echo "Logging in to EC2 instance $id"
    ec2host=$(ec2-describe-instances --show-empty-fields $id | grep '^INSTANCE' | cut -f4)
    ssh $ec2host "$@"
}
chef_ssh() {
    role_regex=$1; shift
    role=$(find_roles "$role_regex")
    if [ $(echo "$role" | wc -w) = '0' ]; then
        echo "No matching Chef role found"
    elif [ $(echo "$role" | wc -w) != '1' ]; then
        echo "Found more than one matching Chef role:"
        echo "$role"
    else
        echo "Logging in to nodes with Chef role $role"
        cd $CHEF_HOME
        knife ssh roles:$role cssh -x root
    fi
}
s() {
    id=$(echo $1 | grep -o 'i-[0-9a-f]\{8\}')
    if [ $? -eq 0 ]; then
        shift
        echo "First argument looks like an EC2 instance id"
        ec2_ssh $id "$@"
    elif timeout 0.1 host "$1" > /dev/null; then
        echo "First argument doesn't look like an EC2 instance id, but I can resolve it as a hostname. Logging in directly."
        ssh "$@"
    else
        echo "First argument doesn't look like an EC2 instance id, I can't resolve it as a hostname, assuming it's a Chef role (maybe a regex)"
        chef_ssh "$@"
    fi
}
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
