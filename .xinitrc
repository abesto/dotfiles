#!/bin/sh

    eval `gnome-keyring-daemon`
    export GNOME_KEYRING_PID 
    export GNOME_KEYRING_SOCKET 
    export SSH_AUTH_SOCK

    export WINDOW_MANAGER="/usr/bin/xmonad"
    export GNOME_DESKTOP_SESSION_ID=1
    export _JAVA_AWT_WM_NONREPARENTING=1
    #export JAVA_OPTIONS="-Djava.library.path=/opt/java/jre/lib/i386"

    BROWSER=opera
    export BROWSER

    xrdb -merge ~/.Xresources
    xmodmap ~/.xmodmap
    xset r rate 200 30

    xbindkeys &
    feh --bg-fill ~/sunflowers2.jpg &
    conky &
    conky -c /home/abesto/.conky-fortune-rc &
    emacs --daemon
    trayer --height 8 --SetDockType true &
    syndaemon -i .5 -d

	urxvtd &

    xsetroot -cursor_name left_ptr

DEFAULT_SESSION=xmonad

case $1 in
  awesome)

    dbus-launch awesome
    ;;
  xmonad)
    dbus-launch --exec-with-session xmonad
    #exec xmonad
    ;;
  gnome)
    exec gnome-session
    ;;
  *)
    dbus-launch --exit-with-session $DEFAULT_SESSION
    ;;
esac

kill $GNOME_KEYRING_PID
