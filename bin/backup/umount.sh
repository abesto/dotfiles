#!/bin/bash

set -euo pipefail

sudo umount "${bak_dev:-/dev/sda2}"
sudo udisksctl power-off -b "${bak_dev:-/dev/sda}"
