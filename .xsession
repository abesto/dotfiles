#!/bin/sh

 xmodmap .xmodmap
# xpmroot háttérkép &

zenity --question --text="Kapcsolódjunk a T-Online-hoz?"
if [[ $? == 0 ]]; then
    xterm -e "sudo pppoe-start" &
    zenity --question --text="Yaourt update (yaourt -Syu)?"
    if [[ $? == 0 ]]; then
	xterm -e "yaourt -Syu" &
    fi
    claws-mail &
    firefox &
else
    zenity --question --text="stalonetray + nm-applet?"
    if [[ $? == 0 ]]; then
        stalonetray &
        nm-applet &
    fi
fi

xmonad
