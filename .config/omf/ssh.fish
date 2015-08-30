set easyssh_executor '(if-command (ssh-exec-parallel) (if-one-target (ssh-login) (tmux-cssh)))'
set easyssh_discoverer '(first-matching (knife) (comma-separated))'
set easyssh_filter '(list (ec2-instance-id us-east-1) (ec2-instance-id us-west-1))'
alias s "easyssh -e='$easyssh_executor' -d='$easyssh_discoverer' -f='$easyssh_filter'"
alias sr 's -l root'
alias sp 's -l publisher'
