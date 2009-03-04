function notify(_text)
   return naughty.notify({text = _text})
end

local bashcomp_funcs = {}
local bashcomp_src = "@SYSCONFDIR@/bash_completion"

local function bash_escape(str)
    str = str:gsub(" ", "\\ ")
    str = str:gsub("%[", "\\[")
    str = str:gsub("%]", "\\]")
    str = str:gsub("%(", "\\(")
    str = str:gsub("%)", "\\)")
    return str
end
function bash_list(command, cur_pos, ncomp)
    local wstart = 1
    local wend = 1
    local words = {}
    local cword_index = 0
    local cword_start = 0
    local cword_end = 0
    local i = 1
    local comptype = "file"

    -- do nothing if we are on a letter, i.e. not at len + 1 or on a space
    if cur_pos ~= #command + 1 and command:sub(cur_pos, cur_pos) ~= " " then
        return command, cur_pos
    elseif #command == 0 then
        return command, cur_pos
    end

    while wend <= #command do
        wend = command:find(" ", wstart)
        if not wend then wend = #command + 1 end
        table.insert(words, command:sub(wstart, wend - 1))
        if cur_pos >= wstart and cur_pos <= wend + 1 then
            cword_start = wstart
            cword_end = wend
            cword_index = i
        end
        wstart = wend + 1
        i = i + 1
    end

    if cword_index == 1 then
        comptype = "command"
    end

    local bash_cmd
    if bashcomp_funcs[words[1]] then
        -- fairly complex command with inline bash script to get the possible completions
        bash_cmd = "/usr/bin/env bash -c 'source " .. bashcomp_src .. "; " ..
                   "__print_completions() { for ((i=0;i<${#COMPREPLY[*]};i++)); do echo ${COMPREPLY[i]}; done }; " ..
                   "COMP_WORDS=(" ..  command .."); COMP_LINE=\"" .. command .. "\"; " ..
                   "COMP_COUNT=" .. cur_pos ..  "; COMP_CWORD=" .. cword_index-1 .. "; " ..
                   bashcomp_funcs[words[1]] .. "; __print_completions | sort -u'"
    else
        bash_cmd = "/usr/bin/env bash -c 'compgen -A " .. comptype .. " " .. words[cword_index] .. "'"
    end
    local c, err = io.popen(bash_cmd)
    local output = {}
    i = 0
    if c then
        while true do
            local line = c:read("*line")
            if not line then break end
            if os.execute("test -d " .. line) == 0 then
                line = line .. "/"
            end
            table.insert(output, bash_escape(line))
        end

        c:close()
    else
        print(err)
    end

    return output
end

function n(command, cur_pos, ncomp)
   t = bash_list(command, cur_pos)
   str = ""
   for num,command in ipairs(t) do
      if num == ncomp then str = str .. '<span bgcolor="#444">' end
      str = str .. command
      if num == ncomp then str = str .. '</span>' end
      str = str .. "   "
   end
   a = notify(str)
   return a
end
