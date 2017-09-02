#!/bin/bash

set -euo pipefail

borg create -p -v --stats --exclude '/home/*/.cache' "${bak_mnt:-/mnt}"/borgbackup::'{hostname}-{now:%Y-%m-%d}' "$HOME"
