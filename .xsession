#!/bin/sh

xmodmap .xmodmap
# xpmroot háttérkép &

emacs --daemon&
stalonetray &
nm-applet &
~/mutt &
xmonad
