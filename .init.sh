#!/bin/sh

xmodmap .xmodmap
zenity --question --text="Kapcsolódjunk a T-Online-hoz?"
if [[ $? == 0 ]]; then
    xterm -e "sudo pppoe-start"
fi
zenity --question --text="Yaourt update (yaourt -Syu)?"
if [[ $? == 0 ]]; then
    xterm -e "yaourt -Syu"
fi
