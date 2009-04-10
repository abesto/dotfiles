#!/bin/sh
# Started by Awesome autorun
# Fire up the Emacs daemon and start a client with the org-mode agenda open
emacs --daemon --no-site
emacsclient -nc
emacsclient -e "(org-agenda-list)"
