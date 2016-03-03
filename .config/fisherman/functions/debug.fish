function debug -d "Conditional debug logger"
    set -l status_copy $status

    if test -z "$fish_debug"
        return $status_copy
    end

    set -l time 0
    set -l milliseconds -MTime::HiRes -e 'printf("%.0f\n", Time::HiRes::time() * 1000)'

    if test -z "$fish_debug_elapsed"
        set -g fish_debug_elapsed (perl $milliseconds)
    else
        set -l elapsed (perl $milliseconds)
        set time (math $elapsed - $fish_debug_elapsed)
        set -g fish_debug_elapsed $elapsed
    end

    set -l IFS ';'

    status -t | awk '
        NR <= 1 { next }

        /in function / {
            if (match($0, "in function .")) {
                func_name = substr($0, RSTART + RLENGTH)
                func_name = substr(func_name, 1, length(func_name) - 1)
                printf("%s\n", func_name)
                exit
            }
        }

        /called on line [0-9]+ of file [^-]+/ {
            match($0, ".*/")
            name = substr($0, RSTART + RLENGTH)

            match($0, "of file .+$")
            file = substr($0, RSTART + 8, RLENGTH)

            sub("\\\.fish$|\\\.load$", "", name)

            match($0, "[0-9]+")
            line = substr($0, RSTART, RLENGTH)

            printf("%s;%s;%s\n", name, file, line)

            exit
        }
    ' | read -l name file line

    if test -z "$name"
        set name "@"
    end

    if test -z "$file"
        set file "@"
    end

    if test -z "$line"
        set line "*"
    end

    if not contains -- "*" $fish_debug
        if not contains -- $name $fish_debug
            return $status_copy
        end

        if contains -- !$name $fish_debug
            return $status_copy
        end
    end

    set -l color_bold (set_color -o)
    set -l color_close (set_color normal)
    set -l color_list f05 f5f ff0 ff8 af5 5fa 0f0 0ff 87f
    set -l color_select (printf "%s\n" $fish_debug_names | sed -nE "s/^$name:(...)\$/\1/p")

    if test -z "$color_select"
        set color_select $color_list[(math (random) "%" (count $color_list) + 1)]
        set -g fish_debug_names $fish_debug_names $name:$color_select
    end

    set color_select (set_color $color_select)

    set -l header
    set -l body
    set -l footer
    set -l arguments

    set -l IFS \n\ \t

    getopts $argv | while read -l 1 2
        switch "$1"
            case _
                if test -z "$body"
                    set body $2
                else
                    set arguments $arguments $2
                end

            case no-color
                set -e color_bold
                set -e color_select
                set -e color_close

            case header
                set header "$2"

            case footer
                set footer "$2"

            case h help
                printf "Usage: debug [<format> [<arguments>]] [--header=<format>] [--footer=<format>]\n\n"

                printf "    --header=<format>  Set header format\n"
                printf "    --footer=<format>  Set footer format\n"
                printf "            -h --help  Show usage help\n"

                return

            case \*
                printf "debug: '%s' is not a valid option.\n" $1 > /dev/stderr
                debug -h > /dev/stderr
                return 1
        end
    end

    if test -z "$header"
        set header "%name"
    end

    if test -z "$footer"
        set footer "%time"
    end

    set header "$color_bold$color_select$header$color_close"
    set footer "$color_select$footer$color_close\n"

    # Make sure there are as many arguments as `%?` formatters to prevent
    # the script to exit prematurely in case printf fails.

    set arguments[(printf "%s\n" $body | awk '{ print gsub("%.", "") + 1 }')] ""

    echo | awk \
        -v name="$name" \
        -v file="$file" \
        -v line="$line" \
        -v time="$time" \
        -v header="$header" \
        -v body="$body" \
        -v footer="$footer" '

        function hmTime(time, stamp) {
            split("h:m:s:ms", units, ":")

            for (i = 2; i >= -1; i--) {
              if (t = int( i < 0 ? time % 1000 : time / (60 ^ i * 1000) % 60 )) {
                stamp = stamp t units[sqrt((i - 2) ^ 2) + 1] " "
              }
            }

            if (stamp ~ /^ *$/) {
                return "0ms"
            }

            return substr(stamp, 1, length(stamp) - 1)
        }

        function format(string) {
            gsub("%name", name, string)
            gsub("%file", file, string)
            gsub("%line", line, string)
            gsub("%time", hmTime(time), string)

            return string
        }

        {
            printf("%s", format(header))
            printf(format(body ? " "body" " : " ")'(printf ",\"%s\"" $arguments)')
            printf("%s", format(footer))
        }

    ' > /dev/stderr ^ /dev/null

    return $status_copy
end
