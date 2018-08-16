#!/bin/bash

set -x
set -euo pipefail

srcdir="${bak_mnt:-/run/media/$USER/borgbackup}"
borg with-lock "$srcdir/borgbackup-$(hostname)" rclone sync "$srcdir" ovh-backup:backup/ -vvv
