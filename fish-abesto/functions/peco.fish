function peco_select_history
    if set -q $argv
        history | peco | read line; commandline $line
    else
        history | peco --query $argv | read line; commandline $line
    end
end


function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end
