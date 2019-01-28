function auto_v --on-variable PWD
    set -l root "$PWD"
    while [ "$root" != '/' ]
        for candidate in virtualenv venv '';
            set -l venv "$root/$candidate"
            set -l activate "$venv/bin/activate.fish"
            if [ -f "$activate" ]
                if [ "$venv" != "$VIRTUAL_ENV" ]
                  if [ -n "$VIRTUAL_ENV" ]
                      deactivate
                  end
                  source "$activate"
                end
                return
            end
        end
        set root (dirname "$root")
    end
    if [ -n "$VIRTUAL_ENV" ]
        deactivate
    end
end
