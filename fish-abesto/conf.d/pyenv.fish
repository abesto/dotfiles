if [ -d "$HOME/.pyenv" ]; then
	set -x PYENV_ROOT "$HOME/.pyenv"
	set -x PATH "$PYENV_ROOT/bin" $PATH
end
