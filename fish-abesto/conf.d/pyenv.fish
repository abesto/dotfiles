if [ -d "$HOME/.pyenv" ]
	set -x PYENV_ROOT "$HOME/.pyenv"
	set -x PATH "$PYENV_ROOT/bin" $PATH
end
