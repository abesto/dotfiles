#!/bin/bash

xmodmap .xmodmap &
feh --bg-scale ~/g24.jpg

emacs --daemon &
nm-applet &

~/mutt &
firefox &

xmonad
