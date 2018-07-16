#!/bin/bash

set -euo pipefail

borg create -p -v --stats \
     --exclude-caches \
     --exclude "*/.Trash-*" \
     --exclude "*/.Trash/*" \
     --exclude "*/.[Cc]ache/*" \
     --exclude "*/.[Cc]aches/*" \
     --exclude "*/[Cc]ache/*" \
     --exclude "*/[Cc]aches/*" \
     --exclude "*/.IntelliJ*/index/*" \
     --exclude "*/node_modules/*" \
     --exclude "*/virtualenv/*" \
     --exclude "$HOME/.m2/*" \
     --exclude "$HOME/.rvm/*" \
     --exclude "$HOME/.gem/*" \
     --exclude "$HOME/.sbt/*" \
     --exclude "$HOME/.bundle/*" \
     --exclude "*/backend/workdir/*" \
     "${bak_mnt:-/mnt}"/'borgbackup-{hostname}::{now:%Y-%m-%d}' "$HOME"
