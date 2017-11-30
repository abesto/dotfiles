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
	"${bak_mnt:-/mnt}"/borgbackup::'{hostname}-{now:%Y-%m-%d}' "$HOME"
