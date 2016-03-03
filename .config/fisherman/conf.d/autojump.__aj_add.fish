# change pwd hook
function __aj_add --on-variable PWD
    status --is-command-substitution; and return
    autojump --add $PWD >/dev/null 2>>$AUTOJUMP_ERROR_PATH &
end
