set -l ignore init.fish osx.fish

for path in /Users/abesto/playground/dotfiles/.config/fish/functions/fish-abesto/*.fish
	contains -- (basename $path) $ignore; and continue
	#echo $path
	source $path
end
