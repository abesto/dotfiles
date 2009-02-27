#!/bin/bash

xmodmap .xmodmap
# xpmroot háttérkép &

emacs --daemon &
nm-applet &
~/mutt &
firefox &
stalonetray -w &
xmonad
