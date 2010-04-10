#!/bin/sh

xrdb -merge ~/.Xresources
eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh)
xbindkeys &
syndaemon -i 0.2 -R -d

DEFAULT_SESSION=awesome

case $1 in
awesome)
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
