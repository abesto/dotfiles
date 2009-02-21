#!/bin/sh

 xmodmap .xmodmap
# xpmroot háttérkép &

zenity --question --text="mutt?"
if [[ $? == 0 ]]; then
    xterm 'mutt' -T 'mutt' &
fi

emacs &
stalonetray &
nm-applet &
xmonad
