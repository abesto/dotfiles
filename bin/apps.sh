#!/bin/bash

set -euo pipefail

start_once() {
    command="$1"; shift
    if [ $# -gt 0 ]; then
        pattern="$1"; shift
    else
        pattern="$command"
    fi
    if ! pgrep "$pattern" > /dev/null; then
        $command &
    fi
}

start_once emacs
start_once spotify
start_once wmail
start_once google-chrome-stable chrome
start_once slack
start_once gitter
