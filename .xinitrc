#!/bin/sh

eval `gnome-keyring-daemon`
export GNOME_KEYRING_PID 
export GNOME_KEYRING_SOCKET 
export SSH_AUTH_SOCK

xrdb -merge ~/.Xresources
xmodmap ~/.xmodmap
xset r rate 200 30

xbindkeys &
conky &
conkeror -daemon &
emacs --daemon
stjerm -k f1 -sh /bin/zsh -fn "Terminus" -b thin &
feh --bg-tile ~/archlinux-zenburn-wide.jpg &

xsetroot -cursor_name left_ptr


DEFAULT_SESSION=awesome

case $1 in
awesome)
	exec awesome
	;;
xmonad)
	dbus-launch --exit-with-session xmonad
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

kill $GNOME_KEYRING_PID
