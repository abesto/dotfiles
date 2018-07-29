#!/bin/bash

set -euo pipefail

sudo mount "${bak_dev:-/dev/sdc2}" "${bak_mnt:-/mnt}"
