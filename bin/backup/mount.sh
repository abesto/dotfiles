#!/bin/bash

set -euo pipefail

sudo mount "${bak_dev:-/dev/sda2}" "${bak_mnt:-/mnt}"
