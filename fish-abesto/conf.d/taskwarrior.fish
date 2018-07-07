alias t task
alias ta 'task add'
alias in 'task add +in'
alias someday 'task add +someday'
alias weekly 'task proj:gtd.weekly'

function tickle
    command task add +in +tickle wait:$argv[1] $argv[2..-1]
end

function rnr
    set -l url $argv[1]
    set --erase argv[1]

    set -l title (lynx -cfg=(printf '%s\n' 'PRINTER:P:printf "%0s" "$LYNX_PRINT_TITLE">&3:TRUE' | psub) lynx 3>&1 >/dev/null -nopause -noprint -accept_all_cookies -cmd_script (printf '%s\n' "key p" "key Select key" "key ^J" "exit" | psub) "$url")

    set -l descr
    set -l cmd task add +next +rnr $argv "\"Read and review: $title\""
    echo "+ $cmd"; eval $cmd

    set -l id (task +LATEST ids)
    set -l cmd task annotate $id $url
    echo "+ $cmd"; eval $cmd
end

alias tick=tickle
