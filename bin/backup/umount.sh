#!/bin/bash

set -euo pipefail

sudo umount "${bak_dev:-/dev/sda}"
sudo udisksctl power-off -b "${bak_dev:-/dev/sda}"
