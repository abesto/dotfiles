xrdb -merge ~/.Xresources

DEFAULT_SESSION=awesome

case $1 in
awesomewm)
	exec awesome
	;;
gnome)
	exec gnome-session
	;;
kde)
	exec startkde
	;;
*)
	exec $DEFAULT_SESSION
	;;
esac
