function v
	for candidate in virtualenv venv ../virtualenv ../../virtualenv ../ ../../;
		if [ -f $candidate/bin/activate.fish ];
			source $candidate/bin/activate.fish
			return
		end
	end
end
alias d='deactivate'
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
