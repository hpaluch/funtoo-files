#!/bin/bash
set -euo pipefail

cd `dirname $0`
set -x
cp -L /etc/resolv.conf etc/
mount --types proc /proc proc
mount --rbind /sys sys
mount --rbind /dev dev
mount --bind  /run run
exit 0

