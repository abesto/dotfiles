set -l ignore init.fish osx.fish

for path in "$OMF_CONFIG"/*.fish
	contains -- (basename $path) $ignore; and continue
	#echo $path
	source $path
end
