alias ksb='knife spork bump'
alias ksu='knife spork upload'
alias kcu='knife cookbook upload'
function kcuf 
    knife cookbook upload $argv[1] --force 
end
function ksbu
    knife spork bump $argv[1]; and knife spork upload $argv[1]
end
alias kns='knife node show'
function ksr
    knife search node roles:$argv[1]
end
function kr
	ls ~/.prezi/prezi-chef/roles | ag $argv[1]
end
